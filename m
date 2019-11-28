Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C84C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 02:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D92215A4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 02:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F7pTQilg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfK1Cyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 21:54:51 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44215 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfK1Cyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 21:54:51 -0500
Received: by mail-pg1-f195.google.com with SMTP id e6so12109094pgi.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 18:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=InKhsbIaHjq4gFdOUDlKjqE9Q00XjHb4Vn+0PbEJFRs=;
        b=F7pTQilgEs48MIpVo0p7X2jCwHTYYnyiR4APuDJngRJhkrgRNxoNY8XuCqMcc1Edfo
         OaKNuJfPBBq+EUDv15Ywjv9iNEoWiTl9UCRu3z63T53Ziiold2pliNBTh5e6pq4N7YYn
         hBWSgomiw+Z0b0d8Jg+VkmpR0uQJHaSw8M8aE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=InKhsbIaHjq4gFdOUDlKjqE9Q00XjHb4Vn+0PbEJFRs=;
        b=LC+vGGi0+LhMyAxFeK2P6BDqfTQhcjSUlm9hvn8Iar/WeCdAW4/4DMaNxyHqEOS7sb
         dE1KWgnY5H+vnylIkRbeTB/ZnTmEpRd89PmHi9VQqD8pTGDzN6OezCUNCUH1Cdo1zPiH
         WBZQDaNFiAzsN49y618pkmNmAJjjDH2DTbRRT9ysSlpZB6A8KcREZDKlswl/2sQBKN49
         pAwIWNkW/QBWityVREkOuFUglig2WpON2eSJAq2vNuTGTwLzDb+hT/hjfXJ1nEIzyanZ
         9tfzJ4LL45mMOOV/GGYAfmNYFquOglDn7VAqsmDVm+sc5cZ3EbVKZaf0hcMt6R+Pg0wF
         uzGA==
X-Gm-Message-State: APjAAAXxN23JT8078UWXcQQ4h7KfYcYt8l+EVkCApgU9c31JCQx3Gy1r
        kq/ei2FgXX0drLmES242Kgm8Ow==
X-Google-Smtp-Source: APXvYqw2tbfS77QohNjoXgVmMFVco9eO58SzL9dYggFhVVyedVA/u4/TedPGOs86o3gQ/HzqJyZf7A==
X-Received: by 2002:a63:d613:: with SMTP id q19mr8810073pgg.350.1574909690334;
        Wed, 27 Nov 2019 18:54:50 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a66sm18031276pfb.166.2019.11.27.18.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 18:54:49 -0800 (PST)
Date:   Wed, 27 Nov 2019 18:54:48 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        x86 <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lkdtm/bugs: Avoid ifdefs for DOUBLE_FAULT
Message-ID: <201911271852.4AA977DFD@keescook>
References: <201911271748.A7C361E28@keescook>
 <C0659748-A5B3-45D3-B752-88A643C66E46@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C0659748-A5B3-45D3-B752-88A643C66E46@amacapital.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 06:15:17PM -0800, Andy Lutomirski wrote:
> 
> > On Nov 27, 2019, at 5:50 PM, Kees Cook <keescook@chromium.org> wrote:
> > 
> > ﻿On Wed, Nov 27, 2019 at 01:01:40PM -0800, Andy Lutomirski wrote:
> >> 
> >> 
> >>>> On Nov 27, 2019, at 11:19 AM, Kees Cook <keescook@chromium.org> wrote:
> >>> 
> >>> ﻿LKDTM test visibility shouldn't change, so remove the ifdefs on
> >>> DOUBLE_FAULT and make sure test failure doesn't crash the system.
> >>> 
> >>> Link: https://lore.kernel.org/lkml/20191127184837.GA35982@gmail.com
> >>> Fixes: b09511c253e5 ("lkdtm: Add a DOUBLE_FAULT crash type on x86")
> >>> Signed-off-by: Kees Cook <keescook@chromium.org>
> >>> ---
> >>> applies on top of tip/x86/urgent
> >>> ---
> >>> drivers/misc/lkdtm/bugs.c  | 8 +++++---
> >>> drivers/misc/lkdtm/core.c  | 4 +---
> >>> drivers/misc/lkdtm/lkdtm.h | 2 --
> >>> 3 files changed, 6 insertions(+), 8 deletions(-)
> >>> 
> >>> diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
> >>> index a4fdad04809a..22f5293414cc 100644
> >>> --- a/drivers/misc/lkdtm/bugs.c
> >>> +++ b/drivers/misc/lkdtm/bugs.c
> >>> @@ -342,9 +342,9 @@ void lkdtm_UNSET_SMEP(void)
> >>> #endif
> >>> }
> >>> 
> >>> -#ifdef CONFIG_X86_32
> >>> void lkdtm_DOUBLE_FAULT(void)
> >>> {
> >>> +#ifdef CONFIG_X86_32
> >>>   /*
> >>>    * Trigger #DF by setting the stack limit to zero.  This clobbers
> >>>    * a GDT TLS slot, which is okay because the current task will die
> >>> @@ -373,6 +373,8 @@ void lkdtm_DOUBLE_FAULT(void)
> >>>   asm volatile ("movw %0, %%ss; addl $0, (%%esp)" ::
> >>>             "r" ((unsigned short)(GDT_ENTRY_TLS_MIN << 3)));
> >>> 
> >>> -    panic("tried to double fault but didn't die\n");
> >>> -}
> >>> +    pr_err("FAIL: tried to double fault but didn't die!\n");
> >>> +#else
> >>> +    pr_err("FAIL: this test is only available on 32-bit x86.\n");
> >>> #endif
> >>> +}
> >> 
> >> I’m not familiar with the userspace tooling, but this seems unfortunate. The first FAIL is “the test case screwed up, and it’s a bug.”  The second FAIL is “not applicable to this system.”
> >> 
> >> 
> >> ISTM simply not exposing the test on systems that don’t support makes sense. Can you clarify?
> > 
> > I don't like the tests liked in the DIRECT file to change from build to
> > build (it should be stable per kernel version). Userspace needs to know
> > how to evaluate the results of running each test, so in both cases, I
> > consider it a failure: double fault didn't work or you tried to test
> > double fault on an unsupported architecture. (The SMEP test works
> > similarly.)
> > 
> 
> 
> So how is the test harness supposed
> to distinguish success from failure?  If it printed UNSUPPORTED instead of FAIL, it would make more sense to me, but I’m not sure why that’s better than just not exposing it at all.

If kernelci or similar ever mentions this as a problem for them, I'm
happy to change it. I think it's an error to request this test in the
wrong environment (because that implies userspace doesn't know how to
evaluate the results). As I like it _available_ because having it
missing makes the code ugly (lots of ifdefs) and provides to signal to
userspace about it (EINVAL on the write to DIRECT) doesn't tell me if I
have the wrong kernel version or the wrong architecture, etc. Since the
tester needs to be parsing dmesg and system state (did it panic, etc), I
much prefer keeping the signals there.

-- 
Kees Cook
