Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8078C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944A420873
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F9HeoH2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfEOQm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 12:42:59 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33359 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfEOQm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:42:59 -0400
Received: by mail-pl1-f194.google.com with SMTP id y3so155562plp.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 09:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zme567uBX0e/zlR2pzmjT8qd1X0Emogu5v3ncY21WGY=;
        b=F9HeoH2vYHnM9Xvbn4sbLHFLRq3byqFoJipo7YeeVhD/lJc9AHIhAGShu/AEzk2ZoS
         SZ7e1NpoTXTZXQ89Bm1YHo1t5ZfpkxfMPPrAF5NjIrXWJR5G5jt4yX+lw0uR3w00RVw0
         v/lyu6z2HPFqOL3ze2sYhvuRMXlniSqJupEP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zme567uBX0e/zlR2pzmjT8qd1X0Emogu5v3ncY21WGY=;
        b=HTCdJs/luN4siDqkvoac6mcGjhUK3o0/wmU0l15tBnti9bQc2Qkv2owerh+xK7XIVb
         WZ3KcThxwNkClCAj2FVAmiyCry/xU8YJzh6BOg0bnLVg+3fgJEkyfHR6OWyhoMTuvfay
         nXZIgSaXH7Pd8viKK5z/WgBvjxASUtVONbwuxTFdMxlHUtnKk7nEyRXXnwre95Kxy6PK
         BGisrzN3TOHaUgencIafbrQ9EGga31r1HL6RlYUJ1Lofdu0H3rgxn26WOjygmh3VVCBn
         4xNjFMh9rxcdBrYXIQoOWXZGhx4zR4P+EKvNWbAfXMYIZafqqZ7h0D9rPDLa1AlJkm1s
         FgYg==
X-Gm-Message-State: APjAAAU+e0kkxh0zMmCYz8adrYewvXSOesDLO67sZuK6q23WClmlpOtH
        LIPh/pU7LNj3UBY1x4v6LRLhjd4KJ8Q=
X-Google-Smtp-Source: APXvYqzL6+5Z/ALSw51f8CRbGOtyKlKceN47EzvHzqX5lKGJIuFwZm8MvjMhzpWC2gYvqqplMZOadg==
X-Received: by 2002:a17:902:9048:: with SMTP id w8mr44173004plz.195.1557938578146;
        Wed, 15 May 2019 09:42:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w125sm3670490pfw.69.2019.05.15.09.42.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 09:42:57 -0700 (PDT)
Date:   Wed, 15 May 2019 09:42:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <nathanchance@gmail.com>,
        Jordan Rupprect <rupprecht@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lkdtm: support llvm-objcopy
Message-ID: <201905150935.3AFE8CC68B@keescook>
References: <20190513222109.110020-1-ndesaulniers@google.com>
 <20190513232910.GA30209@archlinux-i9>
 <CAKwvOd=W9nm04zvRQ3iu=AGHnitongZ7VQ9S32U9hBZKwNyeMw@mail.gmail.com>
 <201905141041.C38DA1B305@keescook>
 <CAKwvOdn2ESh+-T8=YFT=W=gjZHPpCY8QJVS7ytPHM04tN1v13g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdn2ESh+-T8=YFT=W=gjZHPpCY8QJVS7ytPHM04tN1v13g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 01:24:37PM -0700, Nick Desaulniers wrote:
> On Tue, May 14, 2019 at 11:11 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, May 13, 2019 at 04:50:05PM -0700, Nick Desaulniers wrote:
> > > On Mon, May 13, 2019 at 4:29 PM Nathan Chancellor
> > > <natechancellor@gmail.com> wrote:
> > > >
> > > > On Mon, May 13, 2019 at 03:21:09PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> > > > > With CONFIG_LKDTM=y and make OBJCOPY=llvm-objcopy, llvm-objcopy errors:
> > > > > llvm-objcopy: error: --set-section-flags=.text conflicts with
> > > > > --rename-section=.text=.rodata
> > > > >
> > > > > Rather than support setting flags then renaming sections vs renaming
> > > > > then setting flags, it's simpler to just change both at the same time
> > > > > via --rename-section.
> 
> I'm not sure I want to call it a bug in the initial implementation.  I've filed:
> https://sourceware.org/bugzilla/show_bug.cgi?id=24554 for
> clarification.  Jordan, I hope you can participate in any discussion
> there?

Based on the hint from Alan Modra, it seems PROGBITS/NOBITS can be
controlled with the presence/absence of the "load" section flag. This
appears to work for both BFD and LLVM:

$ objcopy --rename-section .text=.rodata,alloc,readonly,load rodata.o rodata_objcopy.o
$ readelf -WS rodata_objcopy.o | grep \.rodata
 [ 1] .rodata    PROGBITS     0000000000000000 000040 000002 00   A  0   0 16

$ llvm-objcopy --rename-section .text=.rodata,alloc,readonly,load rodata.o rodata_objcopy.o
$ readelf -WS rodata_objcopy.o | grep \.rodata
 [ 1] .rodata    PROGBITS     0000000000000000 000040 000002 00   A  0   0 16

So, that's an easy change that could be folded into the original version
of this patch (no need for my two-phase work-around).

-- 
Kees Cook
