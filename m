Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265BBC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 23:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03ADB20645
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 23:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfFYX0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 19:26:03 -0400
Received: from smtprelay0016.hostedemail.com ([216.40.44.16]:38045 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725782AbfFYX0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 19:26:03 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id E441A18225E09;
        Tue, 25 Jun 2019 23:25:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: paper48_16be84a42890e
X-Filterd-Recvd-Size: 4401
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Jun 2019 23:25:56 +0000 (UTC)
Message-ID: <c32b1f6381d0fcdc2a054c778e233b95dc728068.camel@perches.com>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
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
        Kees Cook <keescook@chromium.org>,
        Shawn Landden <shawn@git.icu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Chandler Carruth <chandlerc@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Date:   Tue, 25 Jun 2019 16:25:53 -0700
In-Reply-To: <CAKwvOdnzrMOCo4RRsfcR=K5ELWU8obgMqtOGZnx_avLrArjpRQ@mail.gmail.com>
References: <20190624161913.GA32270@embeddedor>
         <20190624193123.GI3436@hirez.programming.kicks-ass.net>
         <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com>
         <20190624203737.GL3436@hirez.programming.kicks-ass.net>
         <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
         <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com>
         <20190625071846.GN3436@hirez.programming.kicks-ass.net>
         <CANiq72=zzZ+Cx8uM+5UW7HeB9XtbXRhXmC2y2tz5EzPX77gHMw@mail.gmail.com>
         <CAKwvOdn5j8Hkc_jrLMbhg-4jbNya+agtMJi=c9o01RPCno1Q+w@mail.gmail.com>
         <1336988f46fb7ffda925ab86a6e4d5437cfdb275.camel@perches.com>
         <CAKwvOdnzrMOCo4RRsfcR=K5ELWU8obgMqtOGZnx_avLrArjpRQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-25 at 15:57 -0700, Nick Desaulniers wrote:
> consider most other GNU C extensions.  How do I
> test whether they exist in my compiler or not?  Is it everything or
> nothing (do they all have to exist?).

Until such time as the linux source code supports alternate
mechanisms for existing gcc extension uses, I think yes.

> In those cases you either end
> up shelling out to something like autoconf (which is what I consider
> the current infra around CONFIG_CC_HAS_ASM_GOTO), or code filled with
> tons of version checks for specific compilers which are brittle.

Or just one...

> Of the two cases, now consider what happens when my compiler that
> previously did not support a particular feature now does.  In the
> first case, the guards were compiler agnostic, and I *don't have to
> change the source* to make use of the feature in the new compiler.  In
> the second case, I *need to modify the source* to update the version
> checks to be correct.
[]
> Back to your point about adding a minimal version of Clang to the
> kernel; I don't really want to do this.  For non-x86 architectures,
> people are happily compiling their kernels with versions of clang as
> old as clang-4.

Perhaps:

#if defined(CONFIG_X86_32) || defined(CONFIG_X86_64)
#define CLANG_MINIMUM_VERSION 90000
#elif defined(CONFIG_ARM) || defined(CONFIG_ARM64)
#define CLANG_MINIMUM_VERSION 40000
#else
etc...
#endif

#if CLANG_VERSION < CLANG_MINIMUM_VERSION
etc...
#endif

> and if it continues to work for them; I'm happy.  And
> if it doesn't, and they raise an alarm, we're happy to take a look.
> Old LTS distros may have ancient builds of clang, so maybe some kind
> of hint would be nice, but I'd also like to support older versions
> where we can and I think choosing clang-9 for x86's sake is too
> x86-centric.  A version check on CONFIG_JUMP_LABEL is maybe more
> appropriate, so it cannot be selected if you're using clang && your
> version of clang is not clang-9 or greater?

The now non-portable nature of .config files might be
improved.


