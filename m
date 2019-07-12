Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8CAC742D7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 20:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4CA62146E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 20:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfGLUac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 16:30:32 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45111 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfGLUac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 16:30:32 -0400
Received: by mail-qt1-f195.google.com with SMTP id x22so4584723qtp.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 13:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Jxwo9pjmGUKQ0uHToCiY3Wz26c1dotpxquQLKWEEI4=;
        b=BvZiWMTiR0TUe5H+y9PN2BBFwc+ViqWtJG/er4hjj/6fFEt08xDXbp99+F4Uux4BaD
         YOlc8gzmj/4XrhovI/6dS1S02EB6izfuRThgFw+2I3BDy2xuMGs+mDf9/KEcDBdx4ELc
         Z2PVJ22PkBCOywck75c+049c/vh+WrGowA97hHbNtQ0q/WQobIrjFV+tLPbKPd+9nOOv
         QVeNTQwf3Mnv0xQ6BZPh2m+gnoG+Qd5lZ0WeI1jxkh2yIPrLrc3ATpjurnDQl3fj2rJD
         rBRGw03JLm6oumSl9RoMVypSrtRSqyUZnPl8Dl/4ySXmPJyVlK/4evaLhvpkwcfra3ds
         KOkQ==
X-Gm-Message-State: APjAAAUA4ASGJFDxfLpWI03fwlYeTOpms0GbU1ICO0FbBaOymla7Ewcp
        /hgqktwsrAvWY4SzViTrwvVDmynrgeEWsWBHXR0=
X-Google-Smtp-Source: APXvYqw/HRQPv+zrvR1ZBQyClQoN6ydkstV5/Wy0XOB5yS7boQcdKYnFigC2K+BswfrrWijZn61LUT0XF3ZF2POzlZo=
X-Received: by 2002:a0c:b758:: with SMTP id q24mr7462464qve.45.1562963431425;
 Fri, 12 Jul 2019 13:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190712093720.1461418-1-arnd@arndb.de> <CAKwvOd=Xdp_=G3UU9ubayeTvkKCJ9hak0a-7yK90-RPUBQKrpw@mail.gmail.com>
In-Reply-To: <CAKwvOd=Xdp_=G3UU9ubayeTvkKCJ9hak0a-7yK90-RPUBQKrpw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 12 Jul 2019 22:30:14 +0200
Message-ID: <CAK8P3a0vTwtDtxDhfmhzOViUp+DPzuJ_qsQsnVFw4B7oBaudTQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Support clang option for stack alignment
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Duke Du <Duke.Du@amd.com>, Charlene Liu <charlene.liu@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Matthias Kaehlcke <mka@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 8:49 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> On Fri, Jul 12, 2019 at 2:37 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > As previously fixed for dml in commit 4769278e5c7f ("amdgpu/dc/dml:
> > Support clang option for stack alignment") and calcs in commit
> > cc32ad8f559c ("amdgpu/dc/calcs: Support clang option for stack
> > alignment"), dcn20 uses an option that is not available with clang:
> >
> > clang: error: unknown argument: '-mpreferred-stack-boundary=4'
> > scripts/Makefile.build:281: recipe for target 'drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.o' failed
> >
> > Use the same trick that we have in the other two files.
>
> Maybe time for a macro in Kbuild.include or some such, if we see this
> pattern being repeated?

I'm not actually convinced that the argument does anything useful
at all, if the kernel stack is normally not 16-byte aligned
when we enter the driver, and it clearly is not needed if the stack
is already aligned.

Unless any code calling into the portions that want the alignment
manually aligns the kernel stack pointer, we could just as well
leave it out. The git history does not explain why it was added in the
first place though, so I really have no idea.

I see in the architecture makefiles that i386 kernels are built with
the same flag globally, but other architectures (including x86_64)
use the default stack alignment, which may be different.

      Arnd
