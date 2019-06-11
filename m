Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB2DC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D124A20652
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t2tAqctA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404716AbfFKIPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 04:15:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41408 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403996AbfFKIO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 04:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rAIZ7FJf0J2lqQzq5dJJHqYXe4kkarjlGPQQ0o7ePeQ=; b=t2tAqctAJIpeoLWXUomazXH2P
        9oYCDj5ayBOxpU249Bagdzi7c5IGCC4782ld3dmUdxA6wjVQZ+Iaz7AJIueRckUKA3RI6d/Zxv1qW
        VMJZB47jSS+Jpb2T/kWsFctcB+Yw1cfcImoy4pP169oWjm/NUWNjrDe9BbqIb76diVXv7D65Fkt+4
        tjOYp/QIX5jwimyYuyadGUWMprQNfYmK+9FaALXLDKpHnuF03oIhlcibX78Lffr/W2zvdQU3V8X0F
        U0Rp0EddPotow9payHRcDuO3ZfJ0+NYwf2HCtj+cxa2QOZP7odKYrb5HT/vYtYLtCLf413YelH+7F
        6fud750IA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1habvP-0004Ce-E4; Tue, 11 Jun 2019 08:14:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E1F4C20227121; Tue, 11 Jun 2019 10:14:33 +0200 (CEST)
Date:   Tue, 11 Jun 2019 10:14:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 05/15] x86_32: Provide consistent pt_regs
Message-ID: <20190611081433.GP3436@hirez.programming.kicks-ass.net>
References: <20190605130753.327195108@infradead.org>
 <20190605131944.829537410@infradead.org>
 <20190607193215.qw5xo2cdajhihk2x@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607193215.qw5xo2cdajhihk2x@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 03:32:15PM -0400, Josh Poimboeuf wrote:
> On Wed, Jun 05, 2019 at 03:07:58PM +0200, Peter Zijlstra wrote:
> > Currently pt_regs on x86_32 has an oddity in that kernel regs
> > (!user_mode(regs)) are short two entries (esp/ss). This means that any
> > code trying to use them (typically: regs->sp) needs to jump through
> > some unfortunate hoops.
> > 
> > Change the entry code to fix this up and create a full pt_regs frame.
> > 
> > This then simplifies various trampolines in ftrace and kprobes, the
> > stack unwinder, ptrace, kdump and kgdb.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >
> > ---
> >  arch/x86/entry/entry_32.S         |  105 ++++++++++++++++++++++++++++++++++----
> >  arch/x86/include/asm/kexec.h      |   17 ------
> >  arch/x86/include/asm/ptrace.h     |   17 ------
> >  arch/x86/include/asm/stacktrace.h |    2 
> >  arch/x86/kernel/crash.c           |    8 --
> >  arch/x86/kernel/ftrace_32.S       |   77 +++++++++++++++------------
> >  arch/x86/kernel/kgdb.c            |    8 --
> >  arch/x86/kernel/kprobes/common.h  |    4 -
> >  arch/x86/kernel/kprobes/core.c    |   29 ++++------
> >  arch/x86/kernel/kprobes/opt.c     |   20 ++++---
> >  arch/x86/kernel/process_32.c      |   16 +----
> >  arch/x86/kernel/ptrace.c          |   29 ----------
> >  arch/x86/kernel/time.c            |    3 -
> >  arch/x86/kernel/unwind_frame.c    |   32 +----------
> >  arch/x86/kernel/unwind_orc.c      |    2 
> >  15 files changed, 178 insertions(+), 191 deletions(-)
> 
> I recall writing some of this code (some of the kernel_stack_pointer
> removal stuff) so please give me a shout-out ;-)

Absolutely, sorry for not doing that. I've added:

 "Much thanks to Josh for help with the cleanups!"
