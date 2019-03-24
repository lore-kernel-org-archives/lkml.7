Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF273C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 15:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83954222EC
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 15:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="FjA6xSzO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfCXPAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 11:00:34 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55700 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbfCXPAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 11:00:33 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2B6A11EC00FF;
        Sun, 24 Mar 2019 16:00:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553439632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kp54LshAJMBMHu2DJKFtv+hvASa6jYCug3O09jofmXA=;
        b=FjA6xSzO2M3J1dFCKUCbl369NK8ehaM4xft2jix8/NilIE+k2T+iHiU3b7oDOcSLijoTgp
        /WeQ6VQ6F61YoqRELH2u96lpgRCWgWe62u7viosG+roq4qmxyekT5WE0rrTZk3mQ0dzof8
        vbf5anyCkdkhNXo6jKK5pGuKuT/1J+0=
Date:   Sun, 24 Mar 2019 16:00:34 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        hpa@zytor.com, akpm@linux-foundation.org, dyoung@redhat.com,
        brijesh.singh@amd.com, thomas.lendacky@amd.com, bhe@redhat.com
Subject: Re: [PATCH 1/3] kexec: Do not map the kexec area as decrypted when
 SEV is active
Message-ID: <20190324150034.GH23289@zn.tnic>
References: <20190315103203.13128-1-lijiang@redhat.com>
 <20190315103203.13128-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190315103203.13128-2-lijiang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 1/3] kexec: Do not map the kexec area as decrypted when SEV is active

The tip tree preferred format for patch subject prefixes is
'subsys/component:', e.g. 'x86/apic:', 'x86/mm/fault:', 'sched/fair:',
'genirq/core:'. Please do not use file names or complete file paths as
prefix. 'git log path/to/file' should give you a reasonable hint in most
cases.

On Fri, Mar 15, 2019 at 06:32:01PM +0800, Lianbo Jiang wrote:
> Currently, the arch_kexec_post_{alloc,free}_pages unconditionally

Please end function names with parentheses.

> maps the kexec area as decrypted. This works fine when SME is active.
> Because in SME, the first kernel is loaded in decrypted area by the
> BIOS, so the second kernel must be also loaded into the decrypted
> memory.
> 
> When SEV is active, the first kernel is loaded into the encrypted
> area, so the second kernel must be also loaded into the encrypted
> memory. Lets make sure that arch_kexec_post_{alloc,free}_pages does
> not clear the memory encryption mask from the kexec area when SEV
> is active.

Hold on, wait a minute!

Why do we even need this? As usual, you guys never explain what the big
picture is. So you mention SEV, which sounds to me like you want to be
able to kexec the SEV *guest*. Yes?

First of all, why?

Then, if so...

> Co-developed-by: Brijesh Singh <brijesh.singh@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  arch/x86/kernel/machine_kexec_64.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index ceba408ea982..bcebf4993da4 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -566,7 +566,10 @@ int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, gfp_t gfp)
>  	 * not encrypted because when we boot to the new kernel the
>  	 * pages won't be accessed encrypted (initially).
>  	 */
> -	return set_memory_decrypted((unsigned long)vaddr, pages);
> +	if (sme_active())
> +		return set_memory_decrypted((unsigned long)vaddr, pages);

... then this looks yucky. Because, you're adding an sme_active() check here
but then __set_memory_enc_dec() checks

	if (!mem_encrypt_active())

and heads will spin from all the checking of memory encryption aspects.

So this would need a rework so that there are no multiple confusing
checks.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
