Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4271C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF632086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfDAKoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:44:38 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60480 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbfDAKoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:44:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAB81A78;
        Mon,  1 Apr 2019 03:44:37 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D3713F557;
        Mon,  1 Apr 2019 03:44:35 -0700 (PDT)
Date:   Mon, 1 Apr 2019 11:44:32 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Muchun Song <smuchun@gmail.com>
Cc:     will.deacon@arm.com, akpm@linux-foundation.org,
        rppt@linux.vnet.ibm.com, ard.biesheuvel@linaro.org,
        f.fainelli@gmail.com, logang@deltatee.com, robin.murphy@arm.com,
        ghackmann@android.com, hannes@cmpxchg.org, stefan@agner.ch,
        david@redhat.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: fix max_mapnr is assigned the wrong value
Message-ID: <20190401104432.GB14874@arrakis.emea.arm.com>
References: <20190330131346.40289-1-smuchun@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190330131346.40289-1-smuchun@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 09:13:46PM +0800, Muchun Song wrote:
> When we not use flat memory, the mem_map will be NULL and
> pfn_to_page(max_pfn) is a pointer which is located in kernel space. So
> max_mapnr is assigned a very large number(e.g., 0xffffxxxx_xxxxxxxx) - fix
> it.
> 
> Signed-off-by: Muchun Song <smuchun@gmail.com>
> ---
>  arch/arm64/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index bc02818fa48b..e86c21a44c88 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -535,7 +535,7 @@ void __init mem_init(void)
>  	else
>  		swiotlb_force = SWIOTLB_NO_FORCE;
>  
> -	set_max_mapnr(pfn_to_page(max_pfn) - mem_map);
> +	set_max_mapnr(max_pfn - PHYS_PFN_OFFSET);
>  
>  #ifndef CONFIG_SPARSEMEM_VMEMMAP
>  	free_unused_memmap();

The patch looks fine but did you actually hit any problem? max_mapnr
seems to only be used in the generic pfn_valid() which we do not use on
arm64 (just wondering if it needs a cc stable; it doesn't look like as
it's not a regression).

-- 
Catalin
