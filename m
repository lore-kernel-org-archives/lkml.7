Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453D1C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 11:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191B620665
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 11:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="fEz4+Vgw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfK0L01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 06:26:27 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54506 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbfK0L01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 06:26:27 -0500
Received: from zn.tnic (p200300EC2F0F37003034EE13CF148829.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:3700:3034:ee13:cf14:8829])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 83C531EC0CEB;
        Wed, 27 Nov 2019 12:26:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574853981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zkgYU9yQbCe3KqRjeSOv/Vsy6xOWdNuit7arXyBXsR8=;
        b=fEz4+VgwlWzJgyGzRPmC9fQQXD8YKWUB2F6jMEnUiBY4w1cNtHIPxShAsjuFAu3zm7RRMI
        CCHzwdQUrz96dXJFE+NTvM7Z7/wTnWU3kzkH3NwHk73GOs19sAgWhIH35AyQBJoKHx8qoR
        qoNHcq4B8l062u8GGC6FstPOhFA7pqw=
Date:   Wed, 27 Nov 2019 12:26:13 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jules Irenge <jbi.octave@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        mingo@redhat.com
Subject: Re: [PATCH] cpu: microcode: Add comma to 0
Message-ID: <20191127112613.GA3812@zn.tnic>
References: <20191126221519.167145-1-jbi.octave@gmail.com>
 <20191127065436.GC52731@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191127065436.GC52731@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 07:54:36AM +0100, Ingo Molnar wrote:
> 
> * Jules Irenge <jbi.octave@gmail.com> wrote:
> 
> > Add ","  after 0
> > Because memory for the struct is being cleared
> > and elements after "," are missing on purpose
> >  as they are being cleared to
> > 
> > Recommended by Boris Petkov
> > 
> > Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> > ---
> >  arch/x86/kernel/cpu/microcode/amd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
> > index a0e52bd00ecc..04ee649f4acb 100644
> > --- a/arch/x86/kernel/cpu/microcode/amd.c
> > +++ b/arch/x86/kernel/cpu/microcode/amd.c
> > @@ -418,7 +418,7 @@ static int __apply_microcode_amd(struct microcode_amd *mc)
> >  static bool
> >  apply_microcode_early_amd(u32 cpuid_1_eax, void *ucode, size_t size, bool save_patch)
> >  {
> > -	struct cont_desc desc = { 0 };
> > +	struct cont_desc desc = { 0, };
> 
> This is 100% unnecessary - " = { }" is enough of a structure initializer.

That was my initial thought but empty initializers are not ISO C
compliant, I've been told.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
