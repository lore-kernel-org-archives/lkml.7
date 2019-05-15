Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09086C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C6A2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HoTCTtfo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfEORhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 13:37:45 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42557 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfEORhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 13:37:45 -0400
Received: by mail-pl1-f195.google.com with SMTP id x15so202254pln.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 10:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6MPB6abkHkJ0qbicT9wcmWrQ37/LHEgzn/YrZbRl8XQ=;
        b=HoTCTtforuL3wGQfErSjO1VKyUwbCZGxLa9EOSZVgemOObkuInPAHO8GmGZuXzlYDZ
         w7v/VQsM6dXv1zCy6Dc9qkv59qQc9CjNrGtMrHxcv1H+jW0700gP+qQPZ0Ep0blVPy0P
         OxOH0OzNtVo6l/g+dXJXpxXKvwc+9I8FhEK2L03R48/lbHLegUZAWGTwnQkHhwoF4Kzf
         n6j06NHwghm96dIcPgV3xuM2hw5KWSxlovdMA33Ch5uh7UOmTaMrEJSJB9vqkmkLNZgV
         X3zZ0Y2XxyoIEklWJzzMC+t3rcv/ygRXp+7E3aiqGBoXXpSJij/qGTjk/J/tKvXoG0eb
         VrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6MPB6abkHkJ0qbicT9wcmWrQ37/LHEgzn/YrZbRl8XQ=;
        b=Lx/eXTtGYDJ/GT5OcdvjYj0Pngrsi01P7U74rTzD9G4RezcXcvflvBUhORRq9TR6k0
         fmi6CtS3HNH7ZmcmdbsR3zlB1r4lnseqOQJKKlD3ZH5IVGAsIpuY3eYm1xtCBLkPx+ZD
         +O0nC3XRSj1GUdo0eptaEWVCTQ2Y9tT4LRh8hrHsjAYb3de8qnkYx9WSciXgeu7ItVFA
         o79Os5UyxqIEK8dOCLGToKDajBI6UzkjRahr9ll7VGTPIqKx+oUqrkfuyd5hGAV9NQfT
         92QjKI4xnGeesicMAAhwe9tU7z0p9Nr79n76FXWJ6+rpVC9u2i1vbK4BLWUwiglCfiX8
         x7hw==
X-Gm-Message-State: APjAAAUTc/RkcXM+wItVu6vD7iweYjMkaiO4vg2CPy1RBChZDPt0b324
        4WB4DMJu5dhHUs2uywdnXXMvc/Iz3rNTiIJrzm4uJA==
X-Google-Smtp-Source: APXvYqxiNynwv+C+4bYX03W2HuvbOdJC2rqQW/r3u5j9Ys7lSGVzYYIJx/dUWNXg+rGmmOCTRmnALz6ockaHwhtll/Y=
X-Received: by 2002:a17:902:2aab:: with SMTP id j40mr21495934plb.238.1557941863681;
 Wed, 15 May 2019 10:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190513222109.110020-1-ndesaulniers@google.com>
 <20190513232910.GA30209@archlinux-i9> <CAKwvOd=W9nm04zvRQ3iu=AGHnitongZ7VQ9S32U9hBZKwNyeMw@mail.gmail.com>
 <201905141041.C38DA1B305@keescook> <CAKwvOdn2ESh+-T8=YFT=W=gjZHPpCY8QJVS7ytPHM04tN1v13g@mail.gmail.com>
 <201905150935.3AFE8CC68B@keescook>
In-Reply-To: <201905150935.3AFE8CC68B@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 15 May 2019 10:37:31 -0700
Message-ID: <CAKwvOdk_KmyT4yZOz8iczxeP7mYq-h5LmjzkE5yhsodupRLxEQ@mail.gmail.com>
Subject: Re: [PATCH] lkdtm: support llvm-objcopy
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <nathanchance@gmail.com>,
        Jordan Rupprect <rupprecht@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 9:43 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, May 14, 2019 at 01:24:37PM -0700, Nick Desaulniers wrote:
> > On Tue, May 14, 2019 at 11:11 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Mon, May 13, 2019 at 04:50:05PM -0700, Nick Desaulniers wrote:
> > > > On Mon, May 13, 2019 at 4:29 PM Nathan Chancellor
> > > > <natechancellor@gmail.com> wrote:
> > > > >
> > > > > On Mon, May 13, 2019 at 03:21:09PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> > > > > > With CONFIG_LKDTM=y and make OBJCOPY=llvm-objcopy, llvm-objcopy errors:
> > > > > > llvm-objcopy: error: --set-section-flags=.text conflicts with
> > > > > > --rename-section=.text=.rodata
> > > > > >
> > > > > > Rather than support setting flags then renaming sections vs renaming
> > > > > > then setting flags, it's simpler to just change both at the same time
> > > > > > via --rename-section.
> >
> > I'm not sure I want to call it a bug in the initial implementation.  I've filed:
> > https://sourceware.org/bugzilla/show_bug.cgi?id=24554 for
> > clarification.  Jordan, I hope you can participate in any discussion
> > there?
>
> Based on the hint from Alan Modra, it seems PROGBITS/NOBITS can be
> controlled with the presence/absence of the "load" section flag. This
> appears to work for both BFD and LLVM:
>
> $ objcopy --rename-section .text=.rodata,alloc,readonly,load rodata.o rodata_objcopy.o
> $ readelf -WS rodata_objcopy.o | grep \.rodata
>  [ 1] .rodata    PROGBITS     0000000000000000 000040 000002 00   A  0   0 16
>
> $ llvm-objcopy --rename-section .text=.rodata,alloc,readonly,load rodata.o rodata_objcopy.o
> $ readelf -WS rodata_objcopy.o | grep \.rodata
>  [ 1] .rodata    PROGBITS     0000000000000000 000040 000002 00   A  0   0 16
>
> So, that's an easy change that could be folded into the original version
> of this patch (no need for my two-phase work-around).

Ah, yes that's better.  I'll fold that into a v2 and resend shortly.
I'm going to carry your Ack from earlier, please let me know offlist
if that's not appropriate.
-- 
Thanks,
~Nick Desaulniers
