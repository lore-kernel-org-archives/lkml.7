Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BB3C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DCDB2063F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p9Pxp1s1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfFYUho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 16:37:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34007 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfFYUhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 16:37:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id p10so26441pgn.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 13:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iu3imckg8kYkPbb5Onx10ayhyMylqLFkWnoTnDGaH3U=;
        b=p9Pxp1s1oEWH6cPEGEdbiCSJ04C0CovZqwqvJ6A8xriWIaE9qqKZgruFvFHudSOQTg
         MGgHyZlGTRItVXoHcdDlhrAS3z+2eUUkoFX9ekgFTEQTVQ/VGawe21jRAqDrfDjIbfCN
         yi8ukYXqL1xj7TBQPE/3XZVbCxQIfuP1fq0P7WRwbW/A6pN3O/h7NHS9nZR2O0nAiiJ8
         qVn7Iik9ElwVRC8hR46oYC8wP+hoW+neCYc4OoYz0Aq4Pidy2Fridvwgj8tHDj87OC4W
         YKI3tMOamQ2ohsL5T3ajkX0AComBxGIS1I7n1cGzx3DMhfSWHZCU5HZOgtdSEKsPUbE8
         HLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iu3imckg8kYkPbb5Onx10ayhyMylqLFkWnoTnDGaH3U=;
        b=B6qPgu9Lg92dB+1xdR/7F+aqUoMPUH+cUyZtsAvxO6L+iK8QBCskna9qVFwv0o1qrM
         C/aJDisQ/HMB3vS61JJXDz1nxRss/mDc9AL2+VzfTTEkKk7QhW8LzYaGuVZlxChXaCsx
         UQQWWO8tfA6wJl1RKUnng+9RLvul5YDuIFhWcenpV7aW5NzQe+bkZfA3taP/WfrezpYS
         bbXgmUWtwbSyrd7nbFdZ0ieBpQf066UAyV3DoK45mQPQp8wOQVhFdwHQeSg+2sJ/vI4w
         8+PJS7pAAea0zfuv9Dr9/fGvj/w/EB0LzD/w77aIe4jyff16guTL/T4R+PcMuwym44G1
         pExw==
X-Gm-Message-State: APjAAAXhai7XmLgedy4XyM3q2WnAoH4g6CRhB9WQZCTKSGTG8dnbFxXg
        she4FYnFpTmUmQJympkXawqFw5eIv0hzkoSGo4FlFg==
X-Google-Smtp-Source: APXvYqxhRlAZ6GbcKjdAQCLvM436st6jv105wQOaLp/UVKlQ5iSic15Euot89ACHK5MhP4acxxpvk0lnUaPTBJ2UqUY=
X-Received: by 2002:a63:78ca:: with SMTP id t193mr9600212pgc.10.1561495062324;
 Tue, 25 Jun 2019 13:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190624161913.GA32270@embeddedor> <20190624193123.GI3436@hirez.programming.kicks-ass.net>
 <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com>
 <20190624203737.GL3436@hirez.programming.kicks-ass.net> <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
 <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com>
 <20190625071846.GN3436@hirez.programming.kicks-ass.net> <201906251009.BCB7438@keescook>
 <20190625180525.GA119831@archlinux-epyc> <alpine.DEB.2.21.1906252127290.32342@nanos.tec.linutronix.de>
 <20190625202746.GA83499@archlinux-epyc>
In-Reply-To: <20190625202746.GA83499@archlinux-epyc>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 25 Jun 2019 13:37:31 -0700
Message-ID: <CAKwvOd=iFDYuG=tpinN0NP23A6-AGza2Gepeui7eQUo6q5c_jA@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Joe Perches <joe@perches.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shawn Landden <shawn@git.icu>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 1:27 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
> On Tue, Jun 25, 2019 at 09:53:09PM +0200, Thomas Gleixner wrote:
> > On Tue, 25 Jun 2019, Nathan Chancellor wrote:
> > > On Tue, Jun 25, 2019 at 10:12:42AM -0700, Kees Cook wrote:
> > > > On Tue, Jun 25, 2019 at 09:18:46AM +0200, Peter Zijlstra wrote:
> > > > > Can it build a kernel without patches yet? That is, why should I care
> > > > > what LLVM does?
> > > >
> > > > Yes. LLVM trunk builds and boots x86 now. As for distro availability,
> > > > AIUI, the asm-goto feature missed the 9.0 LLVM branch point, so it'll
> > > > appear in the following release.

Kees meant asm goto missed 8.0 LLVM branch.  9.0 which is unreleased
will have it.

> > Kernel boots. As I'm currently benchmarking VDSO performance, this was
> > obviosly my first test. Compared to the same kernel built with gcc6.3 the
> > performance of the VDSO drops slightly.
> >
> > It's below 1%. Though I need to run the same tests on 4 other uarchs to get
> > the full picture. This stuff is randomly changing behaviour accross uarchs
> > depending on how the c source is arranged. So nothing to worry about (yet).

Thank you very much for testing and for these reports.  We've been
working through:
1. make it build
2. make it boot
3. make it run well
4. add features

With some amount of cycles in the above.  Now that most of the build
issues have been resolved, we're more able to focus our resources on 3
and 4.  Please report unexpected regressions to our mailing list
clang-built-linux@googlegroups.com and we'll track/follow up upstream
on the LLVM side.
-- 
Thanks,
~Nick Desaulniers
