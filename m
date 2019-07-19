Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044DCC76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27B421851
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfGSHAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 03:00:39 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40524 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfGSHAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 03:00:39 -0400
Received: by mail-qk1-f196.google.com with SMTP id s145so22537028qke.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 00:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VlN+fpVehtgU0BVWJLT3nUlfPtMws+h2ksG4OpU0Bug=;
        b=JgNWK/ATKOHHcU2xegUVKXdegtsJe9R/ACZYpaJqQJaepMk4b4V1YPkP9xIj5THs9Q
         TJOF2CWnWZQh+lJr4ANcGjtOSLIHVfZ7UxHboetZzThnK4L2yCdksjcNmMgp94CKLtv9
         EFI/dp2zJyVBN82N0IK5CLKFxGwL9EpTaGRls0YwySlfe9YpUsZ7hLghNy7YXWEwb+YJ
         X2ltyd0Q1VClQk74u923H25aLtCSvromwNMx8ZEcptyXdO7Lq8rbXfAYxdwF9RE++PnY
         CsjmH83KNWzaTUCEK4yKhGk6+C5iEc3t6JaMBlp/nI6JFnqck7UxQrswkA1ckhM201A5
         4ijg==
X-Gm-Message-State: APjAAAWoWE8u0YFtINCFzjZEgPdNld9wwFzrRST95gaiuXnnTGPi7H0/
        08dTNpIduvDlwddPNmKl5OETqn6EFIyXl5DeFaI=
X-Google-Smtp-Source: APXvYqw9BPrE7HWDtjoNSCSvckjT6LcvuI1IHZgSsQ6KCfSkfXyksKAKvpihyTK39skHsTR+cnxu1LCzvZ3OUsQbep4=
X-Received: by 2002:a37:5f45:: with SMTP id t66mr34294524qkb.286.1563519637939;
 Fri, 19 Jul 2019 00:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1907182223560.1785@nanos.tec.linutronix.de>
 <20190718205839.GA40219@archlinux-threadripper> <alpine.DEB.2.21.1907190837350.1785@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907190837350.1785@nanos.tec.linutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 19 Jul 2019 09:00:21 +0200
Message-ID: <CAK8P3a3ghOxkY8SQs9Wz-3ikoM=QL8m+F3JYdAMPT+RDvLAhbQ@mail.gmail.com>
Subject: Re: x86 - clang / objtool status
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 8:39 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Thu, 18 Jul 2019, Nathan Chancellor wrote:
>
> > Hi Thomas,
> >
> > I can't comment on the objtool stuff as it is a bit outside of my area
> > of expertise (probably going to be my next major learning project) but I
> > can comment on the other errors.
> >
> > On Thu, Jul 18, 2019 at 10:40:09PM +0200, Thomas Gleixner wrote:
> > >  Build fails with:
> > >
> > >   clang-10: error: unknown argument: '-mpreferred-stack-boundary=4'
> > >   make[5]: *** [linux/scripts/Makefile.build:279: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.o] Error 1
> >
> > Arnd sent a patch for this which has been picked up:
> > https://lore.kernel.org/lkml/CADnq5_Mm=Fj4AkFtuo+W_295q8r6DY3Sumo7gTG-McUYY=CeVg@mail.gmail.com/
>
> Which I applied and now I get:
>
> ERROR: "__fixdfsi" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: "__eqdf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: "__truncdfsf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: "__nedf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!

I saw that earlier and use this local workaround that I still need to
submit, see
the bottom of this mail.

The amdgpu driver has a rather liberal use of floating point math in the kernel
that has caused other problems in the past as it is not portable to non-x86
architectures and breaks at least KCOV. Ideally we would try to get the
driver owners to rewrite that code to avoid floating point math, but that
does not seem likely.

It is also possible that we just need to pass the correct flags to clang to
make it actually use hardfloat mode.

      Arnd

commit 3c12c0c7fceaf492d41e6bfc46f0000198f496df
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Thu Jul 11 16:09:18 2019 +0200

    drm/amd/display: disable DRM_AMD_DC_DCN1_0 with clang

    The DRM_AMD_DC_DCN1_0 code and several other parts of the display
    code use x86 floating point math. When compiling with clang instead
    of gcc, this causes link errors:

    ERROR: "__subdf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
    ERROR: "__gedf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
    ERROR: "__truncdfsf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
    ERROR: "__muldf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
    ERROR: "__divdf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
    ERROR: "__ledf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
    ERROR: "__fixdfsi" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
    ERROR: "__floatunsidf" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
    ERROR: "__adddf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
    ERROR: "__extendsfdf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
    ERROR: "__fixunsdfsi" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
    ERROR: "__ltdf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
    ERROR: "__floatsidf" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
    ERROR: "__gtdf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!

    I don't really see a way to fix this, so disable the DCN when
    building with clang instead until someone finds a way to fix it.

    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/gpu/drm/amd/display/Kconfig
b/drivers/gpu/drm/amd/display/Kconfig
index f954bf61af28..2cfbbf3b85dd 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -6,7 +6,7 @@ config DRM_AMD_DC
  bool "AMD DC - Enable new display engine"
  default y
  select SND_HDA_COMPONENT if SND_HDA_CORE
- select DRM_AMD_DC_DCN1_0 if X86 && !(KCOV_INSTRUMENT_ALL &&
KCOV_ENABLE_COMPARISONS)
+ select DRM_AMD_DC_DCN1_0 if X86 && !(KCOV_INSTRUMENT_ALL &&
KCOV_ENABLE_COMPARISONS) && !CC_IS_CLANG
  help
    Choose this option if you want to use the new display engine
    support for AMDGPU. This adds required support for Vega and
