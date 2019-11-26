Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38665C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF37C2073F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4l9HfAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbfKZQD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 11:03:58 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41792 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbfKZQD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 11:03:58 -0500
Received: by mail-wr1-f65.google.com with SMTP id b18so23100295wrj.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 08:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=thkMkZZ0rwSYenWctM1Kcw4AEXUt8IPH6bLPfuHvNuQ=;
        b=k4l9HfAvi5BCg2d4qiYeEOQT9fZpqfpX+g8twmbdYl2v56FLVyS++MZBnWqBfXe172
         8K8aCdtpwsnNeq8WPrhyqHlj2clMrgRBuW4WUckumjLmrfH93sOI85fqWxAX2t9Z1R7w
         MKyhcUg0iPiU+4m0oIKvmfbgLsycyQk9RLxtqf1cA1el29ZXMf8Q/9cG4iBrjXJyWVrD
         bIPyRTD8tzqDX2qqYwWjxOOkPSU2qgWdQtYFugX9mWf7gZFvZUWxl4j85hn7pDBbsC2B
         8O1rOIrVFQGGTrLU/Cmj3K6GJjMw2KnPMJzZZoR3H0sHUACIrN0BQxMMn0O823xcvAWQ
         Ji4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=thkMkZZ0rwSYenWctM1Kcw4AEXUt8IPH6bLPfuHvNuQ=;
        b=S6KmO9fzbQaSwiWxSykEgeCB6LiHth65mBFrfmEr6n9IF6S+8Uy6uxAMsL6fzYljzJ
         oDXPmU3hg8VHaEULCC5dT2ReFFcjcsrSxDFZ5HsJwraOcz6f/Jps7uPyK4E2UKVWzkfs
         EK1V2Ys0kDZGusqgTi5DYFsUJ0vP2cK/xpcclS4/gZN+klJpzmzZTWSL7wKEybdMdcxJ
         6MRbcRbr7cARXz4k2fuxC4VLjRbZGKSPY2A9Il0OKCzBcdH4hJrJQ5W9dMxmphvPC9oB
         i/ivgcSWeYGJCqIsyIEcRTfx6fR4IBsomUnEJzGLDyHX+rGhz3m2dnLCae07AwQt2XpX
         leVw==
X-Gm-Message-State: APjAAAWkpzwIOltOMoL4NXEsDPn34L2W3p9SnFJbg30ZEC3Xw70NXvwg
        fy0sOS66WYrnf8YzrkOeEw==
X-Google-Smtp-Source: APXvYqy9MV2xNAbKaC2myDa+DvGQhUkjama4Keo6dotM5b9Ss8umhr5feHB6rZIK8uIK59aG94Z8CA==
X-Received: by 2002:adf:ea92:: with SMTP id s18mr36418424wrm.327.1574784235750;
        Tue, 26 Nov 2019 08:03:55 -0800 (PST)
Received: from ninjahub.org (cornerstone451.plus.com. [212.159.66.145])
        by smtp.gmail.com with ESMTPSA id o1sm380229wrn.84.2019.11.26.08.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 08:03:55 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
X-Google-Original-From: Jules Irenge <maxx@ninjahub.org>
Date:   Tue, 26 Nov 2019 16:03:40 +0000 (GMT)
To:     Borislav Petkov <bp@alien8.de>
cc:     Jules Irenge <jbi.octave@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        mingo@redhat.com
Subject: Re: [PATCH] cpu: microcode: replace 0 with NULL
In-Reply-To: <20191126135330.GE31379@zn.tnic>
Message-ID: <alpine.LFD.2.21.1911261554100.156067@ninjahub.org>
References: <20191126002734.121905-1-jbi.octave@gmail.com> <20191126135330.GE31379@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 26 Nov 2019, Borislav Petkov wrote:

> On Tue, Nov 26, 2019 at 12:27:34AM +0000, Jules Irenge wrote:
> > Replace 0 with NULL to fix sparse tool  warning
> >  warning: Using plain integer as NULL pointer
> > 
> > Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> > ---
> >  arch/x86/kernel/cpu/microcode/amd.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
> > index a0e52bd00ecc..4934aa7c94e7 100644
> > --- a/arch/x86/kernel/cpu/microcode/amd.c
> > +++ b/arch/x86/kernel/cpu/microcode/amd.c
> > @@ -418,7 +418,7 @@ static int __apply_microcode_amd(struct microcode_amd *mc)
> >  static bool
> >  apply_microcode_early_amd(u32 cpuid_1_eax, void *ucode, size_t size, bool save_patch)
> >  {
> > -	struct cont_desc desc = { 0 };
> > +	struct cont_desc desc = { NULL };
> 
> So my gcc guy says that 0 and NULL are equivalent as designated
> initializers in this case. And if you look at the resulting asm, it
> doesn't change:
> 
> # arch/x86/kernel/cpu/microcode/amd.c:421: 	struct cont_desc desc = { 0 };
> 	movq	$0, 8(%rsp)	#, desc
> 	movq	$0, (%rsp)	#, desc
> 	movq	$0, 16(%rsp)	#, desc
> 	movq	$0, 24(%rsp)	#, desc
> 
> But what I'd prefer actually is, if you do them like this:
> 
> 			... = { 0,  };
> 
> because:
> 
> 1. It is clear that the memory for the struct is being cleared
> 2. The following ones - the ones after "," are missing too, on purpose,
>    because they're being cleared too.
> 
> Also pls add that explanation to the commit message.
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 
Hi Boris,

Thanks for your reply and suggestion. 

I am learning patching with sparse trying to solve some problems that the 
tool complains about.

Sometime the tool is not always right. If I take your suggestion that I 
am about to do, sparse will however still complain.

so I will suggest my change to be discarded.

I will take another challenge.

Kind regards,
Jules
