Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6527DC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AADF204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="EfGYhmMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfKZNxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:53:44 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39724 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727374AbfKZNxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:53:43 -0500
Received: from zn.tnic (p200300EC2F0EC2004C218550ABF865B7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:c200:4c21:8550:abf8:65b7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 838561EC0CC9;
        Tue, 26 Nov 2019 14:53:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574776422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yYVg4n91flpvNftEr6bER0DSitlLkMNVnW8X+eq28JQ=;
        b=EfGYhmMKkzziEqxtddBTe2Cod4+mjp2qSbJiB1PQPuw+OLcqULqMAUxe7VwYqLkit5Ovea
        JBctUxU0kulh0A/Gx7pjq9KSDTYC//uUd4Wo5eKmy10OVePGWw9Cpwnyhk6+HS/HXh8Nal
        5VFrs1V8Pb0AkHD5m6NmXjfE6Tv8keE=
Date:   Tue, 26 Nov 2019 14:53:30 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        hpa@zytor.com, mingo@redhat.com
Subject: Re: [PATCH] cpu: microcode: replace 0 with NULL
Message-ID: <20191126135330.GE31379@zn.tnic>
References: <20191126002734.121905-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191126002734.121905-1-jbi.octave@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 12:27:34AM +0000, Jules Irenge wrote:
> Replace 0 with NULL to fix sparse tool  warning
>  warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  arch/x86/kernel/cpu/microcode/amd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
> index a0e52bd00ecc..4934aa7c94e7 100644
> --- a/arch/x86/kernel/cpu/microcode/amd.c
> +++ b/arch/x86/kernel/cpu/microcode/amd.c
> @@ -418,7 +418,7 @@ static int __apply_microcode_amd(struct microcode_amd *mc)
>  static bool
>  apply_microcode_early_amd(u32 cpuid_1_eax, void *ucode, size_t size, bool save_patch)
>  {
> -	struct cont_desc desc = { 0 };
> +	struct cont_desc desc = { NULL };

So my gcc guy says that 0 and NULL are equivalent as designated
initializers in this case. And if you look at the resulting asm, it
doesn't change:

# arch/x86/kernel/cpu/microcode/amd.c:421: 	struct cont_desc desc = { 0 };
	movq	$0, 8(%rsp)	#, desc
	movq	$0, (%rsp)	#, desc
	movq	$0, 16(%rsp)	#, desc
	movq	$0, 24(%rsp)	#, desc

But what I'd prefer actually is, if you do them like this:

			... = { 0,  };

because:

1. It is clear that the memory for the struct is being cleared
2. The following ones - the ones after "," are missing too, on purpose,
   because they're being cleared too.

Also pls add that explanation to the commit message.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
