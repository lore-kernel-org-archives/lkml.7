Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AD5C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B423D20843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="jXfBaweh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfEONaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 09:30:14 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40866 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfEONaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 09:30:14 -0400
Received: from zn.tnic (p200300EC2F0A7C00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:7c00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C0B741EC027A;
        Wed, 15 May 2019 15:30:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1557927012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=eJQC27+0zhQX1IOd45UbD4zUj0DPzTLcUpzDhuDznyY=;
        b=jXfBawehjYo9AaBwkNiuEIZe+S3HFuoi1U2VjsDcUW8RRcPsH3fEJZncf8CmibjqtTSI/9
        kJ3gpLFOhU01WXpUyQAVk/FWPs8HoSOhHlo7XubAACaboamrllSWwceEsh+trpNt7hDJ6B
        8Pw0ocMH/h0aepvlkG2KWDDIlEn7Mac=
Date:   Wed, 15 May 2019 15:30:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org,
        x86@kernel.org, hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com,
        Thomas.Lendacky@amd.com, brijesh.singh@amd.com
Subject: Re: [PATCH 2/3 v3] x86/kexec: Set the C-bit in the identity map page
 table when SEV is active
Message-ID: <20190515133006.GG24212@zn.tnic>
References: <20190430074421.7852-1-lijiang@redhat.com>
 <20190430074421.7852-3-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190430074421.7852-3-lijiang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 03:44:20PM +0800, Lianbo Jiang wrote:
> When SEV is active, the second kernel image is loaded into the
> encrypted memory. Lets make sure that when kexec builds the
> identity mapping page table it adds the memory encryption mask(C-bit).
> 
> Co-developed-by: Brijesh Singh <brijesh.singh@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  arch/x86/kernel/machine_kexec_64.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index f60611531d17..11fe352f7344 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -56,6 +56,7 @@ static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
>  	pte_t *pte;
>  	unsigned long vaddr, paddr;
>  	int result = -ENOMEM;
> +	pgprot_t prot = PAGE_KERNEL_EXEC_NOENC;
>  
>  	vaddr = (unsigned long)relocate_kernel;
>  	paddr = __pa(page_address(image->control_code_page)+PAGE_SIZE);
> @@ -92,7 +93,11 @@ static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
>  		set_pmd(pmd, __pmd(__pa(pte) | _KERNPG_TABLE));
>  	}
>  	pte = pte_offset_kernel(pmd, vaddr);
> -	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, PAGE_KERNEL_EXEC_NOENC));
> +
> +	if (sev_active())
> +		prot = PAGE_KERNEL_EXEC;
> +
> +	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, prot));
>  	return 0;
>  err:
>  	return result;
> @@ -129,6 +134,11 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
>  	level4p = (pgd_t *)__va(start_pgtable);
>  	clear_page(level4p);
>  
> +	if (sev_active()) {
> +		info.page_flag |= _PAGE_ENC;
> +		info.kernpg_flag = _KERNPG_TABLE;

kernpg_flag above is initialized to _KERNPG_TABLE_NOENC so you can do here

		info.kernpg_flag |= _PAGE_ENC;

too, to make it even more clear what this does, right?

IOW:

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 783ce5184405..16c37fe489bc 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -135,8 +135,8 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
        clear_page(level4p);
 
        if (sev_active()) {
-               info.page_flag |= _PAGE_ENC;
-               info.kernpg_flag = _KERNPG_TABLE;
+               info.page_flag   |= _PAGE_ENC;
+               info.kernpg_flag |= _PAGE_ENC;
        }
 
        if (direct_gbpages)


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
