Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A0EC04AB1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 02:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673562183F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 02:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfEJCaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 22:30:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbfEJCay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 22:30:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F40EB217F5;
        Fri, 10 May 2019 02:30:52 +0000 (UTC)
Date:   Thu, 9 May 2019 22:30:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC][PATCH] ftrace/x86: Remove mcount support
Message-ID: <20190509223051.710a8f4e@gandalf.local.home>
In-Reply-To: <20190509201430.2eabpqjv2kw7dwnv@treble>
References: <20190509154902.34ea14f8@gandalf.local.home>
        <20190509201430.2eabpqjv2kw7dwnv@treble>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 May 2019 15:14:30 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  arch/x86/include/asm/ftrace.h    |  8 +++----
> >  arch/x86/include/asm/livepatch.h |  3 ---
> >  arch/x86/kernel/ftrace_32.S      | 36 +++++---------------------------
> >  arch/x86/kernel/ftrace_64.S      | 28 +------------------------
> >  4 files changed, 9 insertions(+), 66 deletions(-)  
> 
> I was wondering why you didn't do s/mcount/fentry/ everywhere, but I
> guess it's because mcount is still used by other arches, so it still has
> a generic meaning tree-wide, right?

Yes, fentry works nicely when you have a single instruction that pushes
the return address on the stack and then jumps to another location.
It's much trickier to implement with link registers. There's a few
different implementations for other archs, but mcount happens to be the
one supported by most.

> 
> Anyway it's nice to finally see this cruft disappear.
> 
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

Thanks!

-- Steve
