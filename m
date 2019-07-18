Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E16AC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 22:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6032D21019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 22:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pWK3hlhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391523AbfGRW0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 18:26:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35823 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfGRW0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 18:26:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id u14so13260350pfn.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 15:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HMjENTT88YFzIjLrd/J4kKvhXkDZWLblcqa2AQPC8TY=;
        b=pWK3hlhXRtv0mo8nqgZ6lytPhrOHYexo2EBBi1gmBvadJwnJ9p0lNZH/xA5dEuYCyo
         fLLmFI92XQW6ZlkZYgpfGui84FYTSGPfcqwcnOId4DRDholhG8uggKc5zu55gMR8vhoi
         Dkpd1UY2eZ2HxeXVq8xrfmnRup4VD7hTqCwIgh+/2bQqSlVA6T6khx3POndCeyL4gL/8
         PjcoW6e+BhoWIzfBVDMmqbcJYh6iNNz5ce7pPS8/YGvgveZKPX21C9FgFllrm4EYxQAn
         L/9SEkH2zDOCqgkJe/Bh1iII/yfZ5xL5aBxXXFPzd6KYbAe/oIn3n3wzIrL/1OJJF9dg
         jwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HMjENTT88YFzIjLrd/J4kKvhXkDZWLblcqa2AQPC8TY=;
        b=F8PSO7Y1pHXrIsnsMPofQIC3Acu2sCo9hqaeZNdQ0VHPtUdPOH/YnLeQlbhq6GthPf
         JFVxESbTACzAQrP7//OpHliUckr7XGM074k6bzhfGTOXjWWjlYWIKvylGKJMjyJBo8KS
         aeO44AdaDdF87hWOwFpH/LkfAen54XewVlrZM1/xlP7McGOsq8vk5atigoHUwwzyiMrH
         JnLDyMUvAm426yioX3vfwMledOMK++pByAhnMZxebWC9Bpp+4WJaL+VBX5pDKz9IKOBk
         m8o4rQOSF5ZnNk81Tc02O2d43Ck3nGgpy+/0CtzBPEQ9Ez1UKjKzsVPMHTp4gMGxPP1A
         0I8Q==
X-Gm-Message-State: APjAAAU/T5DFFBsGvecgsSbOnZ+3OGxu3/SgJGdIwD9eyyS9w8PUgyDX
        LLjCR5eHwQMuyh+HeI4wgkz0dbCweQuwRxQ0K0ARGw==
X-Google-Smtp-Source: APXvYqy25+0MYvF04Ir0OHL5Txgsnp7ZxD6pE/9GMRWJ0QwWvWulc567ZDU5MyEjxq3SOxNceXKGXGfdoUCZ91C3yt4=
X-Received: by 2002:a17:90a:bf02:: with SMTP id c2mr54078589pjs.73.1563488801525;
 Thu, 18 Jul 2019 15:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563150885.git.jpoimboe@redhat.com> <20190715193834.5tvzukcwq735ufgb@treble>
 <CAKwvOdnXt=_NVjK7+RjuxeyESytO6ra769i4qjSwt1Gd1G22dA@mail.gmail.com> <20190716231718.flutou25wemgsfju@treble>
In-Reply-To: <20190716231718.flutou25wemgsfju@treble>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 18 Jul 2019 15:26:30 -0700
Message-ID: <CAKwvOdn8_NENF8_cxizrD-PYN_t11px+51WKtkAUa2Q-vH68yw@mail.gmail.com>
Subject: Re: [PATCH 00/22] x86, objtool: several fixes/improvements
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 4:17 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Mon, Jul 15, 2019 at 02:45:39PM -0700, Nick Desaulniers wrote:
> > For a defconfig, that's the only issue I see.
> > (Note that I just landed https://reviews.llvm.org/rL366130 for fixing
> > up bugs from loop unrolling loops containing asm goto with Clang, so
> > anyone else testing w/ clang will see fewer objtool warnings with that
> > patch applied.  A follow up is being worked on in
> > https://reviews.llvm.org/D64101).
> >
> > For allmodconfig:
> > arch/x86/ia32/ia32_signal.o: warning: objtool:
> > ia32_setup_rt_frame()+0x247: call to memset() with UACCESS enabled
> > mm/kasan/common.o: warning: objtool: kasan_report()+0x52: call to
> > __stack_chk_fail() with UACCESS enabled
> > arch/x86/kernel/signal.o: warning: objtool:
> > x32_setup_rt_frame()+0x255: call to memset() with UACCESS enabled
> > arch/x86/kernel/signal.o: warning: objtool: __setup_rt_frame()+0x254:
> > call to memset() with UACCESS enabled
> > drivers/ata/sata_dwc_460ex.o: warning: objtool:
> > sata_dwc_bmdma_start_by_tag()+0x3a0: can't find switch jump table
> > lib/ubsan.o: warning: objtool: __ubsan_handle_type_mismatch()+0x88:
> > call to memset() with UACCESS enabled
> > lib/ubsan.o: warning: objtool: ubsan_type_mismatch_common()+0x610:
> > call to __stack_chk_fail() with UACCESS enabled
> > lib/ubsan.o: warning: objtool: __ubsan_handle_type_mismatch_v1()+0x88:
> > call to memset() with UACCESS enabled
> > drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:
> > .altinstr_replacement+0x56: redundant UACCESS disable
> >
> > Without your series, I see them anyways, so I don't consider them
> > regressions added by this series.  Let's follow up on these maybe in a
> > new thread?  (Shall I send you these object files?)
>
> Yes, maybe open a new thread and be sure to copy PeterZ.  He loves those
> warnings ;-)  Object files are definitely needed.
>
> > So for the series:
> > Tested-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Thanks!
>
> >
> > > >
> > > >    I haven't dug into it yet.
> > > >
> > > > 2) There's also an issue in clang where a large switch table had a bunch
> > > >    of unused (bad) entries.  It's not a code correctness issue, but
> > > >    hopefully it can get fixed in clang anyway.  See patch 20/22 for more
> > > >    details.
> >
> > Thanks for the report, let's follow up on steps for me to reproduce.
>
> Just to clarify, there are two clang issues.  Both of them were reported
> originally by Arnd, IIRC.
>
> 1) The one described above and in patch 20, where the switch table is
>    mostly unused entries.  Not a real bug, but it's a bit sloppy and
>    wasteful, and objtool doesn't know how to interpret it.

Thanks for the concise reports.  Will follow up on these in:
https://github.com/ClangBuiltLinux/linux/issues/611

>
> 2) The bug with the noreturn call site having a different stack size
>    depending on which code path was taken.

and:
https://github.com/ClangBuiltLinux/linux/issues/612
-- 
Thanks,
~Nick Desaulniers
