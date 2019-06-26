Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA29FC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 15:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2C52086D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 15:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfFZPS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 11:18:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49220 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFZPS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 11:18:59 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hg9h0-0005Q2-FX; Wed, 26 Jun 2019 17:18:38 +0200
Date:   Wed, 26 Jun 2019 17:18:37 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Nathan Chancellor <natechancellor@gmail.com>
cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
        clang-built-linux@googlegroups.com,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
In-Reply-To: <20190626051035.GA114229@archlinux-epyc>
Message-ID: <alpine.DEB.2.21.1906261711540.32342@nanos.tec.linutronix.de>
References: <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com> <20190624203737.GL3436@hirez.programming.kicks-ass.net> <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com> <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com>
 <20190625071846.GN3436@hirez.programming.kicks-ass.net> <201906251009.BCB7438@keescook> <20190625180525.GA119831@archlinux-epyc> <alpine.DEB.2.21.1906252127290.32342@nanos.tec.linutronix.de> <20190625202746.GA83499@archlinux-epyc>
 <alpine.DEB.2.21.1906252255440.32342@nanos.tec.linutronix.de> <20190626051035.GA114229@archlinux-epyc>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jun 2019, Nathan Chancellor wrote:
> On Tue, Jun 25, 2019 at 11:47:06PM +0200, Thomas Gleixner wrote:
> > On Tue, 25 Jun 2019, Nathan Chancellor wrote:
> > > On Tue, Jun 25, 2019 at 09:53:09PM +0200, Thomas Gleixner wrote:
> > > > 
> > > > But can the script please check for a minimal clang version required to
> > > > build that thing.
> > > > 
> > > > The default clang-3.8 which is installed on Debian stretch explodes. The
> > > > 6.0 variant from backports works as advertised.
> > > > 
> > > 
> > > Hmmm interesting, I test a lot of different distros using Docker
> > > containers to make sure the script works universally and that includes
> > > Debian stretch, which is the stress tester because all of the packages
> > > are older. I install the following packages then run the following
> > > command and it works fine for me (just tested):
> > > 
> > > $ apt update && apt install -y --no-install-recommends ca-certificates \
> > > ccache clang cmake curl file gcc g++ git make ninja-build python3 \
> > > texinfo zlib1g-dev
> > > $ ./build-llvm.py
> > > 
> > > If you could give me a build log, I'd be happy to look into it and see
> > > what I can do.
> > 
> > I can produce one tomorrow.

tarball with log and the preprocessed source and run scripts:

    https://tglx.de/~tglx/tc-crash.tar.bz2

The machine runs up to date debian stretch which has backports enabled and
I just used the install command from the github project page you linked
to. Getting started section.

Thanks,

	tglx
