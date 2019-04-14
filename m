Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC338C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 07:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB52720850
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 07:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfDNHCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 03:02:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52494 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbfDNHCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 03:02:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2F6D1308212A;
        Sun, 14 Apr 2019 07:02:01 +0000 (UTC)
Received: from localhost (ovpn-12-23.pek2.redhat.com [10.72.12.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A3CE35C219;
        Sun, 14 Apr 2019 07:01:58 +0000 (UTC)
Date:   Sun, 14 Apr 2019 15:01:55 +0800
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@kernel.org, bp@alien8.de,
        hpa@zytor.com, kirill@shutemov.name, keescook@chromium.org,
        peterz@infradead.org, thgarnie@google.com,
        herbert@gondor.apana.org.au, mike.travis@hpe.com,
        frank.ramsay@hpe.com, yamada.masahiro@socionext.com
Subject: Re: [PATCH v2 1/2] x86/mm/KASLR: Fix the size of the direct mapping
 section
Message-ID: <20190414070155.GB7065@MiWiFi-R3L-srv>
References: <20190412065542.18431-1-bhe@redhat.com>
 <20190412065542.18431-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412065542.18431-2-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Sun, 14 Apr 2019 07:02:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/19 at 02:55pm, Baoquan He wrote:
> kernel_randomize_memory() uses __PHYSICAL_MASK_SHIFT to calculate
> the maximum amount of system RAM supported. The size of the direct
> mapping section is obtained from the smaller one of the below two
> values:
> 
>  (actual system RAM size + padding size) vs (max system RAM size supported)
> 
> This calculation is wrong since commit:
> b83ce5ee91471d ("x86/mm/64: Make __PHYSICAL_MASK_SHIFT always 52").
> 
> In commit b83ce5ee91471d, __PHYSICAL_MASK_SHIFT was changed to be 52,
> regardless of whether it's using 4-level or 5-level page tables.
> It will always use 4 PB as the maximum amount of system RAM, even
> in 4-level paging mode where it should be 64 TB.  Thus the size of
> the direct mapping section will always be the sum of the actual
> system RAM size plus the padding size.
> 
> Even when the amount of system RAM is 64 TB, the following layout will
> still be used. Obviously KALSR will be weakened significantly.
> 
>    |_______actual RAM_______|_padding_|______the rest_______ |
>    0            64TB          74TB                    ~120TB
                                ~~ I could use tab, will resend to
correct this.
> 
> What we want is the following:
> 
>    |_______actual RAM_______|_________the rest_______________|
>    0            64TB                                  ~120TB
> 
> So the code should use MAX_PHYSMEM_BITS instead. Fix it by replacing
> __PHYSICAL_MASK_SHIFT with MAX_PHYSMEM_BITS.
> 
> Fixes: b83ce5ee9147 ("x86/mm/64: Make __PHYSICAL_MASK_SHIFT always 52")
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Thomas Garnier <thgarnie@google.com>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/x86/mm/kaslr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> index 9a8756517504..387d4ed25d7c 100644
> --- a/arch/x86/mm/kaslr.c
> +++ b/arch/x86/mm/kaslr.c
> @@ -94,7 +94,7 @@ void __init kernel_randomize_memory(void)
>  	if (!kaslr_memory_enabled())
>  		return;
>  
> -	kaslr_regions[0].size_tb = 1 << (__PHYSICAL_MASK_SHIFT - TB_SHIFT);
> +	kaslr_regions[0].size_tb = 1 << (MAX_PHYSMEM_BITS - TB_SHIFT);
>  	kaslr_regions[1].size_tb = VMALLOC_SIZE_TB;
>  
>  	/*
> -- 
> 2.17.2
> 
