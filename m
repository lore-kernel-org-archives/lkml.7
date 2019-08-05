Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30ECCC19759
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 02:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11AE920B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 02:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfHECBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 22:01:13 -0400
Received: from smtprelay0147.hostedemail.com ([216.40.44.147]:45321 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726561AbfHECBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 22:01:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 660668368EF8;
        Mon,  5 Aug 2019 02:01:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: leaf55_441906b845118
X-Filterd-Recvd-Size: 3022
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Mon,  5 Aug 2019 02:01:07 +0000 (UTC)
Message-ID: <281d938d3d50efd75d5ec927c393c936c78f9d75.camel@perches.com>
Subject: Re: [RFC PATCH] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use
From:   Joe Perches <joe@perches.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>,
        David Miller <davem@davemloft.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Date:   Sun, 04 Aug 2019 19:01:06 -0700
In-Reply-To: <20190805011815.GA110280@archlinux-threadripper>
References: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com>
         <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com>
         <c0669a7130645a20e99915385b7e712360c31ed9.camel@perches.com>
         <CAHk-=wg1PAJR6ChVXE7O_H2wEG=1mWxi2uc0fH5bthOC_81uTA@mail.gmail.com>
         <49b659d8f88f67c736881224203418f59a5d29ac.camel@perches.com>
         <20190805011815.GA110280@archlinux-threadripper>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-08-04 at 18:18 -0700, Nathan Chancellor wrote:
> On Sun, Aug 04, 2019 at 05:39:28PM -0700, Joe Perches wrote:
> Hi Joe,

Hi Nathan.

> This patch resolves that while adding support for the attribute.
> https://reviews.llvm.org/D64838
[]
> > The __has_attribute use is at least clang compatible.
> > https://releases.llvm.org/3.7.0/tools/clang/docs/LanguageExtensions.html
> > even if it doesn't (seem to?) work.
> 
> I was trying to follow along with this thread through the web interface
> and kind of got lost, how does it not work?

It does not work in llvm/clang mainline through
commit 305b961f64b75e73110e309341535f6d5a48ed72.

> If I apply your compiler attributes patch with D64838,
> I see fallthrough get expanded to
> __attribute__((__fallthrough__)) by the preprocessor.

Well, great.
I hope D64838 or something like it gets applied soon.
But all I could and did test was the current version.

cheers, Joe

