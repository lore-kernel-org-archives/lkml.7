Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D38C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E59821841
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ckdL9xNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfGXQ6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:58:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45050 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfGXQ6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:58:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so21224481pfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 09:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s7ukXGKCr3sO7fhC6+VXw/YOnCbyLTCvDGXac4+FsVg=;
        b=ckdL9xNk9dJcvMeNWxqzjoOC3mYV4foWL4DJyqLQFw8MgKbF3FOWuDILcLC05yUvk4
         02DHiGg33KMa8ao90K2/rfwmP5rnwKrGXT+L8ws73WurUzIUwMaTB6tGyzB8oxG5QyFB
         Wb49QeLbf/kwxddrww8ssgK9nKGUg+GZV6LSrWxTazlPk885ZXzWQyOw3YCy+4AfDkLZ
         6bvzJyxt2Bw3/enR0AFOv18JhVtEhvs097B7ELSjcac14aUb3wpLq6Jj24qKj+TvAKIf
         v+BDPd3si5IlcPCRhh6bf+cypufItFfayAUBMe65pY0ctkzSRHLWlycLt/U1OfCrx7OZ
         X2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s7ukXGKCr3sO7fhC6+VXw/YOnCbyLTCvDGXac4+FsVg=;
        b=Jovs02iMocTdvFOfu70p7LkGE0ZMEPqs0spBzrnVLeQOg3/Df28vDhVn3Oh2c3u1k9
         s4ghc+6DvoeDwPBPJOn9Z3Zu5hLqGPqrEHeY/2H0SSg48fvxnl6wzbmWyCuXJ2STax59
         nz8wIJhqvOdRpB99irT7BqOL4/SoV68RkQT4mYxtrgNLr4Xjho+kAWqjO2NmqhSjWjoS
         OcAkrCW7TRoWAM2/LfrUMcT4NGd2es9oGlK4rIPO0mwhucUey5YGNf5nHlzKL5n6T+uC
         sEySlLmYpuIuVEokpvsByvPySHrr7qn+f1aeghf6UIS4Qjgrx6FyjEDGMmrRNzqyEOsl
         8zLA==
X-Gm-Message-State: APjAAAXIU8/B1wGN5DHbnyr0yIiDBagMQt7oBAXq4IIJr1rQ2ytGqntl
        wKyTmVNt1suV4p/+IeVtMa6zOm4bDyx4RohtHI8ogw==
X-Google-Smtp-Source: APXvYqwtd/MIlPgj4XQPELXcGFeWZeldRKC4fdCUY5wDDmotUp04bXXgIc6pZ9ZPYLTGlO0mzTbUPH1YGKnGgNfs9y0=
X-Received: by 2002:a63:2cd1:: with SMTP id s200mr78200867pgs.10.1563987486194;
 Wed, 24 Jul 2019 09:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1907182223560.1785@nanos.tec.linutronix.de>
 <20190718205839.GA40219@archlinux-threadripper> <alpine.DEB.2.21.1907190837350.1785@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907190837350.1785@nanos.tec.linutronix.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 24 Jul 2019 09:57:55 -0700
Message-ID: <CAKwvOdkkaypJPxfaxa_-Q0jtzX4AreNQx8rM7tw9Z78wPfV7fA@mail.gmail.com>
Subject: Re: x86 - clang / objtool status
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 11:39 PM Thomas Gleixner <tglx@linutronix.de> wrote:
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
> ERROR: "__floatsidf" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: "__divdf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: "__adddf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: "__ledf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: "__subdf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: "__muldf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: "__fixunsdfsi" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: "__floatunsidf" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: "__extendsfdf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: "__gedf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: "__ltdf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: "__gtdf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: "__floatdidf" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> make[2]: *** [/home/tglx/work/kernel/linus/linux/scripts/Makefile.modpost:91: __modpost] Error 1
>

Thanks for reminding me to send a v2: https://lkml.org/lkml/2019/7/22/1196
Sounds like it was picked up yesterday (but I'm not sure the
maintainer pushed it publicly anywhere yet).
-- 
Thanks,
~Nick Desaulniers
