Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224A5C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18572070B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfHSPuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:50:19 -0400
Received: from foss.arm.com ([217.140.110.172]:56654 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbfHSPuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:50:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C28B3344;
        Mon, 19 Aug 2019 08:50:18 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF6643F718;
        Mon, 19 Aug 2019 08:50:16 -0700 (PDT)
Date:   Mon, 19 Aug 2019 16:50:14 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org
Subject: Re: [PATCH v2 02/14] arm64, hibernate: create_safe_exec_page cleanup
Message-ID: <20190819155014.GD9927@lakrids.cambridge.arm.com>
References: <20190817024629.26611-1-pasha.tatashin@soleen.com>
 <20190817024629.26611-3-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190817024629.26611-3-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 10:46:17PM -0400, Pavel Tatashin wrote:
> create_safe_exec_page() is going to be split into two parts in preparation
> of moving page table handling code out of hibernate.c
> 
> Remove allocator parameter, and rename dst to page. Also, remove the
> goto's, as we can return directly without cleanups.

It would be nice if you could do the goto/allocator/rename changes as
separate patches, since it's vastly easier to verify each change in
isolation that way.

What's the point of the rename? It's inconsistent with the phys_dst_addr
that you leave as-is, so I'm not sure that's worthwhile.

> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  arch/arm64/kernel/hibernate.c | 60 +++++++++++++++--------------------
>  1 file changed, 26 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> index 9341fcc6e809..96b6f8da7e49 100644
> --- a/arch/arm64/kernel/hibernate.c
> +++ b/arch/arm64/kernel/hibernate.c
> @@ -196,57 +196,51 @@ EXPORT_SYMBOL(arch_hibernation_header_restore);
>   */
>  static int create_safe_exec_page(void *src_start, size_t length,
>  				 unsigned long dst_addr,
> -				 phys_addr_t *phys_dst_addr,
> -				 void *(*allocator)(gfp_t mask),
> -				 gfp_t mask)
> +				 phys_addr_t *phys_dst_addr)
>  {
> -	int rc = 0;
> +	void *page = (void *)get_safe_page(GFP_ATOMIC);
> +	pgd_t *trans_table;

The addition of this trans_table variable wasn't mentioned in the commit
message...

> +	trans_table = (void *)get_safe_page(GFP_ATOMIC);
> +	if (!trans_table)
> +		return -ENOMEM;
>  
> -	pgdp = pgd_offset_raw(allocator(mask), dst_addr);
> +	pgdp = pgd_offset_raw(trans_table, dst_addr);

> -	write_sysreg(phys_to_ttbr(virt_to_phys(pgdp)), ttbr0_el1);
> +	write_sysreg(phys_to_ttbr(virt_to_phys(trans_table)), ttbr0_el1);


... and I guess you're trying to ensure that we program the TTBR with
the correct base address, without the offset of whatever pgd entry we
happen to have plumbed in?

I think that's a fix, and should come before any other cleanup or
rework.

If you can respin that specific change with s/trans_table/pgdir/, that
would make sense to me.

Thanks,
Mark.
