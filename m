Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EBEC2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 18:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34ADE2053B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 18:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TjTY3FAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfL3SeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 13:34:11 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34636 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfL3SeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 13:34:10 -0500
Received: by mail-ot1-f67.google.com with SMTP id a15so47234792otf.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 10:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qJxG5rXeQ+ZGJOaYW4EXkwuwUFBqKojJcyGWuzZri/k=;
        b=TjTY3FAwY5LS77J2nD1DGrKzPF9YGkdN6ifPOrdb45SvYIh5qCd84cYm1LdF+hVVGC
         XV3U4NJuvtV55tXe8xuP2fhgaHpori4DgyCVgvTasyVyFLgoaMuRfGxZ9n7NxydMJ3iq
         lfGl9YM5+cEcPnqn5pPXqXPpApfTmCyA8sYNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qJxG5rXeQ+ZGJOaYW4EXkwuwUFBqKojJcyGWuzZri/k=;
        b=IsJJl8R0qtUzkKUtUiugaQ8bsqRRwcRbYP4/2HrLLkKBoIyNAA/jFpzSvpnbw+RYxI
         mnmJXq7uZ9k5Fw+1vqxoF8X8PzTIfFExdxLoXM8lXBJNUcTmaaYCm2aSJHa1UrYegIjT
         w2YmxAhsRnoP+P6zg79tzQOp/iUytkGXr427xGwEgqgItcEUnQC1gvrnKzngToKFNamf
         1NRJX7d71k60S2b7B79N9t7upaqrUt6cz6M+3bpQPmUCwjCbvp8ksrGk/c1tnycAc3QE
         l8QjqQHpx9nGLNqyQifkPJBh4T5eYjPdtXfeqmxWNUsy0gFhUNEBWiRXROkHwqPq0tOz
         RWHw==
X-Gm-Message-State: APjAAAVJG8ptUM+8uuAQjENfI73A9uXR7Tc4JS18M1RoH/pVYP825ujb
        QCFpM7HTT//hHNp7+19zRPE09w==
X-Google-Smtp-Source: APXvYqxiIpRQoEw6avj320pC7DPFPnEoxp205ZIz1CCuAlAt/mRonbGz50/VOB7qiwbiTz+hP8QHZg==
X-Received: by 2002:a05:6830:1141:: with SMTP id x1mr1566945otq.120.1577730849877;
        Mon, 30 Dec 2019 10:34:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p65sm12426488oif.47.2019.12.30.10.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 10:34:08 -0800 (PST)
Date:   Mon, 30 Dec 2019 10:34:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Khem Raj <raj.khem@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>
Subject: Re: [PATCH] x86/boot/compressed/64: Define __force_order only when
 CONFIG_RANDOMIZE_BASE is unset
Message-ID: <201912301033.84517BA05@keescook>
References: <20191221151813.1573450-1-raj.khem@gmail.com>
 <20191223171043.g54secptjtqkhuve@box>
 <CAMKF1sqvEH94Abv2Ptz3XTCg6hGk9tQ1Dr86RwYn+bpSLQVyxg@mail.gmail.com>
 <20191223230857.eafab52y5erfmgab@box>
 <CAK8P3a0rwQ6jyibZJ85N32UrrhBhyhesO24_6-66F07JMFYz+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0rwQ6jyibZJ85N32UrrhBhyhesO24_6-66F07JMFYz+A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 01:12:31PM +0100, Arnd Bergmann wrote:
> On Tue, Dec 24, 2019 at 12:08 AM Kirill A. Shutemov
> <kirill@shutemov.name> wrote:
> > On Mon, Dec 23, 2019 at 02:25:02PM -0800, Khem Raj wrote:
> > > On Mon, Dec 23, 2019 at 9:10 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > > >
> > > > On Sat, Dec 21, 2019 at 07:18:13AM -0800, Khem Raj wrote:
> > > > > Since arch/x86/boot/compressed/Makefile overrides global CFLAGS it loses
> > > > > -fno-common option which would have caught this
> > > >
> > > > If this doesn't cause any visible problems, why bother?
> > > >
> > >
> > > it does break builds with gcc trunk as of now e.g.
> > >
> > > > Hopefully, we will be able to drop it altogether once we ditch GCC 4.X
> > > > support.
> > > >
> > >
> > > gcc10 is switching defaults to -fno-common so we need to solve this one way or
> > > other, I am not sure if gcc 4.x will be dropped before gcc10 release
> > > which would be
> > > in mid of 2020
> >
> > Okay, it makes sense then. Please include this info into the commit
> > message.
> >
> > Also, I wounder if it would be cleaner to define both of them as __weak?
> 
> Or maybe make the #ifdef check for gcc < 5 instead of checking for
> CONFIG_RANDOMIZE_BASE? That way it will be found by whoever
> cleans up the code when we increase the minimum compiler
> version to one that doesn't require the hack.

I agree: that seems a better way to do this.

-- 
Kees Cook
