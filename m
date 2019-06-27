Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5A8C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B80D2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wgqyrt4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfF0HgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 03:36:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37090 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfF0HgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 03:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K9MKkuvvlkoqI3V4z9JRyu3OZSaCvrZVaduz8WwEhW8=; b=Wgqyrt4CxgPcSJ7TOkeI2Ff9e
        BBbI9B1+iwGcsdWa6cSJMnrdjE64fY7UczWXQlXatI6Rr8yIdu45/NIxJfRR/GWRlM9XqxkOo5gDT
        YrPozHJau5dM2mPqv9Z6ln/8b3BO/TqWoW/RfK+BpAg3LTfaUrt6ROBUddsF50a+KRrnMKORqUJK3
        aOPb7NzU0B3C6snfOPLxxUwcDQw0Nf3nttO+FO/VrStV6nntyCkjIBcdaU3XfDZ5Y+Xgv5kCiu3pY
        7CwagIHFP6thjgMZdM7g3o9VcHxZRtLL/fUfP5QKUxVGGMNBFpSJ3ROzf0pR0ruHSC39AUuTEVuCP
        VPeAnP6kg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgOwl-0003wR-0r; Thu, 27 Jun 2019 07:35:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 70478201D1C98; Thu, 27 Jun 2019 09:35:53 +0200 (CEST)
Date:   Thu, 27 Jun 2019 09:35:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Kees Cook <keescook@chromium.org>,
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
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
Message-ID: <20190627073553.GB3402@hirez.programming.kicks-ass.net>
References: <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com>
 <20190625071846.GN3436@hirez.programming.kicks-ass.net>
 <201906251009.BCB7438@keescook>
 <20190625180525.GA119831@archlinux-epyc>
 <alpine.DEB.2.21.1906252127290.32342@nanos.tec.linutronix.de>
 <20190625202746.GA83499@archlinux-epyc>
 <alpine.DEB.2.21.1906252255440.32342@nanos.tec.linutronix.de>
 <20190626092432.GJ3419@hirez.programming.kicks-ass.net>
 <20190626095522.GB3463@hirez.programming.kicks-ass.net>
 <CAKwvOdm=cOOW1MLz2re9MvW0K4g8cENdymOQoUL1k-+5v=bg=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdm=cOOW1MLz2re9MvW0K4g8cENdymOQoUL1k-+5v=bg=A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 03:23:24PM -0700, Nick Desaulniers wrote:
> On Wed, Jun 26, 2019 at 2:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Jun 26, 2019 at 11:24:32AM +0200, Peter Zijlstra wrote:
> > > That's pretty atrocious code-gen :/
> >
> > And I know nobody reads comments (I don't either), but I did write one
> > on this as it happens.
> 
> I've definitely read that block in include/linux/jump_label.h; can't
> say I fully understand it yet, but appreciate patience and
> explanations.

So the relevant bits are:

 * type\branch| likely (1)            | unlikely (0)
 * -----------+-----------------------+------------------
 *            |                       |
 *  true (1)  |    ...                |    ...
 *            |    NOP                |    JMP L
 *            |    <br-stmts>         | 1: ...
 *            | L: ...                |
 *            |                       |
 *            |                       | L: <br-stmts>
 *            |                       |    jmp 1b
 *            |                       |
 * -----------+-----------------------+------------------
 *            |                       |
 *  false (0) |    ...                |    ...
 *            |    JMP L              |    NOP
 *            |    <br-stmts>         | 1: ...
 *            | L: ...                |
 *            |                       |
 *            |                       | L: <br-stmts>
 *            |                       |    jmp 1b
 *            |                       |
 * -----------+-----------------------+------------------

So we have two types, static_key_true, which defaults to true and
static_key_false, which defaults (unsurprisingly) to false. At runtime
they can be switched at will, it is just the initial state which
determines what code we actually need to emit at compile time.

And we have two statements: static_branch_likely(), the branch is likely
-- or we want the block in-line, and static_branch_unlikely(), the
branch is unlikely -- or we want the block out-of-line.

This is coded like:

#define static_branch_likely(x)							\
({										\
	bool branch;								\
	if (__builtin_types_compatible_p(typeof(*x), struct static_key_true))	\
		branch = !arch_static_branch(&(x)->key, true);			\
	else if (__builtin_types_compatible_p(typeof(*x), struct static_key_false)) \
		branch = !arch_static_branch_jump(&(x)->key, true);		\
	else									\
		branch = ____wrong_branch_error();				\
	likely(branch);								\
})

#define static_branch_unlikely(x)						\
({										\
	bool branch;								\
	if (__builtin_types_compatible_p(typeof(*x), struct static_key_true))	\
		branch = arch_static_branch_jump(&(x)->key, false);		\
	else if (__builtin_types_compatible_p(typeof(*x), struct static_key_false)) \
		branch = arch_static_branch(&(x)->key, false);			\
	else									\
		branch = ____wrong_branch_error();				\
	unlikely(branch);							\
})

Let's walk through static_branch_unlikely() (the other is very similar,
just reversed).

We use __builtin_types_compatible_p() to compile-time detect which key
type is used, such that we can emit the right initial code:

  - static_key_true; we must emit a JMP to the block,
  - static_key_false; we must emit a NOP and not execute the block.
  - neither; we generate a link error.

Then we take the return value and use __builtin_expect(, 0) on it to
influence the block layout, specifically we want the block to be
out-of-line.

It appears the __builtin_expect() usage isn't working right with LLVM
resuling in that layout issue Thomas spotted. GCC8+ can even place them
in the .text.unlikely section as func.cold.N parts/symbols. But the main
point is to get the block away from the normal I$ content to minimize
impact.


