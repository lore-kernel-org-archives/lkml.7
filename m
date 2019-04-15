Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B42C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BEC320854
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="OOqT3Caf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbfDOTuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:50:11 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55668 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728605AbfDOTuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:50:10 -0400
Received: from zn.tnic (p4FED3D80.dip0.t-ipconnect.de [79.237.61.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 448EE1EC02AE;
        Mon, 15 Apr 2019 21:50:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555357808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Ief1bSeBDooFjV+/QSkceSHzeIIB5ciAHxhEmjiNw7s=;
        b=OOqT3CafFcizE4FwSgROrgjYicpEKSTeoPegIba43hVDBRuZ+yVcdkLAM3u1F65ZY7LGCo
        1D1kEN8ACAcX9nDk6TbwHoBm05SmhITXQy8F0HtvGmfzCn2X16b+Oo/3WeXL0Bv2k4ozYh
        NCf8bD3F+G7DhDsDgN3tM+UI4muJoNc=
Date:   Mon, 15 Apr 2019 21:47:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Baoquan He <bhe@redhat.com>, kirill@shutemov.name
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@kernel.org, hpa@zytor.com, keescook@chromium.org,
        peterz@infradead.org, thgarnie@google.com,
        herbert@gondor.apana.org.au, mike.travis@hpe.com,
        frank.ramsay@hpe.com, yamada.masahiro@socionext.com
Subject: Re: [PATCH v2 RESEND 2/2] x86/mm/KASLR: Fix the size of vmemmap
 section
Message-ID: <20190415194755.GJ29317@zn.tnic>
References: <20190414072804.12560-1-bhe@redhat.com>
 <20190414072804.12560-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190414072804.12560-3-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 03:28:04PM +0800, Baoquan He wrote:
> kernel_randomize_memory() hardcodes the size of vmemmap section as 1 TB,
> to support the maximum amount of system RAM in 4-level paging mode, 64 TB.
> 
> However, 1 TB is not enough for vmemmap in 5-level paging mode. Assuming
> the size of struct page is 64 Bytes, to support 4 PB system RAM in 5-level,
> 64 TB of vmemmap area is needed. The wrong hardcoding may cause vmemmap
> stamping into the following cpu_entry_area section, if KASLR puts vmemmap
> very close to cpu_entry_area, and the actual area of vmemmap is much bigger
> than 1 TB.
> 
> So here calculate the actual size of vmemmap region, then align up to 1 TB
> boundary. In 4-level it's always 1 TB. In 5-level it's adjusted on demand.
> The current code reserves 0.5 PB for vmemmap in 5-level. In this new methor,
								       ^^^^^^^

Please introduce a spellchecker into your patch creation workflow.

> the left space can be saved to join randomization to increase the entropy.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/x86/mm/kaslr.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> index 387d4ed25d7c..4679a0075048 100644
> --- a/arch/x86/mm/kaslr.c
> +++ b/arch/x86/mm/kaslr.c
> @@ -52,7 +52,7 @@ static __initdata struct kaslr_memory_region {
>  } kaslr_regions[] = {
>  	{ &page_offset_base, 0 },
>  	{ &vmalloc_base, 0 },
> -	{ &vmemmap_base, 1 },
> +	{ &vmemmap_base, 0 },
>  };
>  
>  /* Get size in bytes used by the memory region */
> @@ -78,6 +78,7 @@ void __init kernel_randomize_memory(void)
>  	unsigned long rand, memory_tb;
>  	struct rnd_state rand_state;
>  	unsigned long remain_entropy;
> +	unsigned long vmemmap_size;
>  
>  	vaddr_start = pgtable_l5_enabled() ? __PAGE_OFFSET_BASE_L5 : __PAGE_OFFSET_BASE_L4;
>  	vaddr = vaddr_start;
> @@ -109,6 +110,14 @@ void __init kernel_randomize_memory(void)
>  	if (memory_tb < kaslr_regions[0].size_tb)
>  		kaslr_regions[0].size_tb = memory_tb;
>  
> +	/**
> +	 * Calculate how many TB vmemmap region needs, and aligned to
> +	 * 1TB boundary.
> +	 */
> +	vmemmap_size = (kaslr_regions[0].size_tb << (TB_SHIFT - PAGE_SHIFT)) *
> +		sizeof(struct page);
> +	kaslr_regions[2].size_tb = DIV_ROUND_UP(vmemmap_size, 1UL << TB_SHIFT);
> +
>  	/* Calculate entropy available between regions */
>  	remain_entropy = vaddr_end - vaddr_start;
>  	for (i = 0; i < ARRAY_SIZE(kaslr_regions); i++)
> -- 

Kirill, ack?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
