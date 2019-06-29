Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D6CC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 07:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F36214DA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 07:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HELsi/hw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfF2HKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 03:10:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42784 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfF2HKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 03:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6VdWHYYjQYQdf+o3RkiSdlEDelgrMiUAhFpXTYAbsrY=; b=HELsi/hwqhMZniUHgB1d4/yv2
        0GCOfEF/cXKHXolWSljA/QDMne3s9BQFBeLhw6xjKdjZCcp1DpKyNlCvp5JkexOgEvoEm3kjZJKT0
        P4F47b28Comw+VOMQCB+cSomd61J9BgkyqVnu3EnU9wlux/DtlB604JXf17x2D4fkwLKUdro4ylIg
        SwEJG1+XsRV/irbQN1XgT2jqtPdQ9E3eJ2nFpUvbapZKxg6eRj6e2M07sFOI6pWoHFEFbZkxjSjRX
        AgWMeUT7EmLp8JnEh2CvNJeMrLSZuWi1/KdScBU0Y7LPp6FM1lTyJBO9X/rZrjCZZqvGAhakr+2DU
        3LxoXpRKw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hh7Uz-0006FB-LN; Sat, 29 Jun 2019 07:10:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 310232010DE4B; Sat, 29 Jun 2019 09:10:11 +0200 (CEST)
Date:   Sat, 29 Jun 2019 09:10:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Joe Perches <joe@perches.com>,
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
        Jann Horn <jannh@google.com>, Bill Wendling <morbo@google.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
Message-ID: <20190629071011.GI3402@hirez.programming.kicks-ass.net>
References: <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
 <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com>
 <20190625071846.GN3436@hirez.programming.kicks-ass.net>
 <CANiq72=zzZ+Cx8uM+5UW7HeB9XtbXRhXmC2y2tz5EzPX77gHMw@mail.gmail.com>
 <CAKwvOdn5j8Hkc_jrLMbhg-4jbNya+agtMJi=c9o01RPCno1Q+w@mail.gmail.com>
 <20190626084927.GI3419@hirez.programming.kicks-ass.net>
 <CAKwvOdkp7qnwLGY2=TOx=FQa1k2hEkdi1PO+9GfZkTQEUh49Rg@mail.gmail.com>
 <20190627071250.GZ3402@hirez.programming.kicks-ass.net>
 <20190628133105.GD3463@hirez.programming.kicks-ass.net>
 <CAKwvOdkx+=Z5-Ov4CY6y+XhMCNWa35BBFUdQWgP49PBTLr-Erg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkx+=Z5-Ov4CY6y+XhMCNWa35BBFUdQWgP49PBTLr-Erg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 11:44:16AM -0700, Nick Desaulniers wrote:
> On Fri, Jun 28, 2019 at 6:31 AM Peter Zijlstra <peterz@infradead.org> wrote:

> > For those with interest; full patches at:
> >
> >   https://lkml.kernel.org/r/20190628102113.360432762@infradead.org
> 
> Do you have a branch pushed that I can pull this from to quickly test w/ Clang?

I've not yet pushied it out, will do on Monday or so.

> The .skip trick is wild; I don't quite understand the negation in the
> above or patch 8/8 for is_byte/is_long.

Yes, that's a bit magic. What happens is that GAS has:

 false := 0
 true := ~false

(it lacks a boolean not and uses a bitwise negate instead). Therefore,
the result of an (true) compare is all-1-s (or -1), and since we want a
single .skip we have to negate.

The actual condition for the result is more complicated than it should
be, but that only came to me after sendind out these patches, basically
it should be:

  (val >> 31) == (val >> 7)

to test if a s32 van be represented in a s8.

> For the wrong __jump_table entry; I consider that a critical issue we
> need to fix before the clang-9 release.  I'm unloading my current
> responsibilities at work to be able to sit and focus on bug.  I'll
> probably start a new thread with you, tglx, Josh, and our mailing list
> next week (sorry for co-opting this thread).  I have been using
> creduce quite successfully for finding and fixing our previous codegen
> bugs (https://nickdesaulniers.github.io/blog/2019/01/18/finding-compiler-bugs-with-c-reduce/),
> but I need to sit and understand the precise failure more in order to
> reduce the input.  We can see pretty well where in the compilation
> pipeline things go wrong; I just find it hard to page through large
> inputs such as whole translation units.

Sure; add me to the thread and I'll be glad to answer anything I can.
