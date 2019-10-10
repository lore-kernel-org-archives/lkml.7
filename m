Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B163C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E223C206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H3tKHjAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfJJUjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 16:39:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44353 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfJJUjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:39:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id e10so403926pgd.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 13:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S6k3ViNzJ7YzSO4Rk6x02I91FS8Fe+dk8MkxjwLqK8Q=;
        b=H3tKHjAt+i0+CQTvoADnXR7F0rxl5YFxMCX0FbptG8IPZY7dVhLhq+z4nTwr3xlJsm
         NZCxMoKJQ66Pdcz8X9EMKBKlUFSL7NpNQB19aZgVH1zs9Tid11Hci9H3uXP9wcfKvMVB
         l1buCrnseYmvSt9KY1GGS9m7ffX+mHlOyjQV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S6k3ViNzJ7YzSO4Rk6x02I91FS8Fe+dk8MkxjwLqK8Q=;
        b=fBguylBGtlVLj5pw+KK4iDYHWA670LHxHYtZoUuJyp5u98x7eDUDmDZDQ3Fqzvfk5H
         ATq6QANZMCR4oCMzK+uPsP0BGGq6kF8k8K3NG36byYqJh5NIzMLwrxKXrzu80jJKG0Pi
         2YsW9tA85LFqjuQX9DMwbqt6BLZHBBRAsRIxPJD+4DHA6X+tgUmnl/s1KTDtA/SKENJg
         0HBpfpHu6tjofikl+OR3XKZQfFX4yc45zWXo4PpdUvWTpfdl7+02hmCwF4WbqLljpuWx
         oYm9p/gYHzux1SlKktVwlTGBdFm/FrN20F5fgXw3IqrOE3mr+fPnyaXBAYtu33/CEEJ5
         FT4w==
X-Gm-Message-State: APjAAAW9BWmrMSOyy3cBlWEO42zySP//Ez1JfPFJO2P28dAjnakANkC4
        NxIGy5WO9+JEQ5ncom87tBgD+A==
X-Google-Smtp-Source: APXvYqy5p9hU263vrnIMDOktaRZ6ou916sxO2v+ayu3IHxX6tjjtY4ecaAh+JfCCcvfW9uZFmT1dnA==
X-Received: by 2002:a63:5516:: with SMTP id j22mr12913251pgb.201.1570739948545;
        Thu, 10 Oct 2019 13:39:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f65sm6116366pgc.90.2019.10.10.13.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 13:39:07 -0700 (PDT)
Date:   Thu, 10 Oct 2019 13:39:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Machek <pavel@ucw.cz>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH 4/4] scripts/cvt_style.pl: Tool to reformat sources in
 various ways
Message-ID: <201910101338.59F36A33@keescook>
References: <cover.1570292505.git.joe@perches.com>
 <4a904777303fbaea75fe0875b7984c33824f4b68.1570292505.git.joe@perches.com>
 <CANiq72nwDgMgXNczW=JRANzH72=f0ukwVoPaud1d7J4YQLQX=w@mail.gmail.com>
 <52794b248ba13e88ab4c30c9b6ea55a7be30df5d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52794b248ba13e88ab4c30c9b6ea55a7be30df5d.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2019 at 11:35:42PM -0700, Joe Perches wrote:
> On Sat, 2019-10-05 at 19:31 +0200, Miguel Ojeda wrote:
> > Hi Joe,
> 
> Hello.
> 
> > On Sat, Oct 5, 2019 at 6:47 PM Joe Perches <joe@perches.com> wrote:
> []
> > > As for the commit itself: while I am sure this tool is very useful
> > (and certainly you put a *lot* of effort into this tool), I don't see
> > how it is related to the fallthrough remapping (at least the
> > non-fallthrough parts).
> 
> It's not particularly related.
> 
> It's a 10 year old script that I just extended because it's
> convenient for me.
> 
> I think I first posted it in 2011, but I started it as a
> complement to checkpatch in 2010.
> 
> https://lwn.net/Articles/380161/
> 
> Doing the regexes for the fallthrough conversions took me
> a couple hours.
> 
> > Also, we should consider whether we want more tools like this now or
> > simply put the efforts into moving to clang-format.
> 
> I think clang-format could not do this sort of conversion.
> Nor could coccinelle or checkpatch.
> 
> Anyway, it's not really necessary for this particular patch
> to be applied, but it's a convenient way to show the script
> has the capability to do fallthrough comment conversions.
> 
> I think it does conversions fairly reasonably but likely
> some files could not compile without adding an #include
> like:
> 
> #include <linux/compiler.h>

I think this is a nice tool to add -- at the very least it serves as
infrastructure for future similar conversions. And small cleanups can be
generated from it for people looking to clean up subsystems, etc.

-- 
Kees Cook
