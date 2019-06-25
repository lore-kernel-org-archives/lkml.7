Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259A1C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E902B2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="np9051N/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfFYUJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 16:09:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40261 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfFYUJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 16:09:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so9473698pgj.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 13:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9HIbjW/UTQH9RcDsaHdx3MzCgSHJWkM4/9sLFdKj7fY=;
        b=np9051N/pT9hzPSxZ5Rb2qNrgtPujyiRa3l3w69lKbPm7p/eAyYcVhrIzKGkV0WecY
         LKYPS9C8lN2ZNZcgzJApatdXP02Bid9YIf2KsDQqEB9/YEMq/GRJPFAOLYEo1zq/o/ZS
         UX7+WnoqcMCR9HwaIM1Zl76EkgZ4H4sn0vlYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9HIbjW/UTQH9RcDsaHdx3MzCgSHJWkM4/9sLFdKj7fY=;
        b=FUzph70AC8/npa6qy1goTBKwHfK0pe2moX1OVxFuuhM703lgeKuHTwdblpQdlVYJ6O
         vNp8/ZUS0gnkz8ATtTlqTXlFpqgmtA1xx9ziyqb9ZQm9tUXayP3dt3QBJgsnV1GuQpVZ
         Jox9qj551vW+7mdOf/egRFXK4kZdxOO8GfcWNPUyE6YrIXp4plO8d+ux4J25S++CmQ4E
         Zgh5jYyj+1DjoS+SQucCrSfG5OxnEAj94prZqGCM/pLzYJZDCxLNFR/7x/LIg8uKPgOE
         8ey1jWVnJFJmrwAx1aifwQrO1MQIeS06x0Mmv0esat2GXKpi99fxmzmh+Wxu4foLu0ko
         KBBw==
X-Gm-Message-State: APjAAAXfUbhRnCGvU2ZHIuMrnT3c2hxSrfxHrvpKmC1wHfuu6JZ3hu3S
        2CGl2m3Mfl+cvVNUzy2auxP0RQ==
X-Google-Smtp-Source: APXvYqz8ZG275gJ15NJOL5CcY2r65le+WZDZlhfBDgfAwtPWcjmOGT4M6p1P11L4X8B/TCWCNsM66g==
X-Received: by 2002:a63:9e53:: with SMTP id r19mr32674817pgo.442.1561493379704;
        Tue, 25 Jun 2019 13:09:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a18sm88751pjq.0.2019.06.25.13.09.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Jun 2019 13:09:38 -0700 (PDT)
Date:   Tue, 25 Jun 2019 13:09:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Joe Perches <joe@perches.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shawn Landden <shawn@git.icu>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
Message-ID: <201906251309.BBB7D17@keescook>
References: <20190624161913.GA32270@embeddedor>
 <20190624193123.GI3436@hirez.programming.kicks-ass.net>
 <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com>
 <20190624203737.GL3436@hirez.programming.kicks-ass.net>
 <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
 <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com>
 <20190625071846.GN3436@hirez.programming.kicks-ass.net>
 <201906251009.BCB7438@keescook>
 <20190625180525.GA119831@archlinux-epyc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625180525.GA119831@archlinux-epyc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 11:05:25AM -0700, Nathan Chancellor wrote:
> On Tue, Jun 25, 2019 at 10:12:42AM -0700, Kees Cook wrote:
> > On Tue, Jun 25, 2019 at 09:18:46AM +0200, Peter Zijlstra wrote:
> > > Can it build a kernel without patches yet? That is, why should I care
> > > what LLVM does?
> > 
> > Yes. LLVM trunk builds and boots x86 now. As for distro availability,
> > AIUI, the asm-goto feature missed the 9.0 LLVM branch point, so it'll
> > appear in the following release.
> > 
> > -- 
> > Kees Cook
> 
> I don't think that's right. LLVM 9 hasn't been branched yet so it should
> make it in.
> 
> http://lists.llvm.org/pipermail/llvm-dev/2019-June/133155.html
> 
> If anyone wants to play around with it before then, we wrote a
> self-contained script that will build an LLVM toolchain suitable for
> kernel development:
> 
> https://github.com/ClangBuiltLinux/tc-build

Ah! That's good news. :) I thought the branch happened just before
asm-goto landed. Wheee!

-- 
Kees Cook
