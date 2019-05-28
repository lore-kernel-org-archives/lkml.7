Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F41C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE563208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfE1M6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 08:58:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727360AbfE1M63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:58:29 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB5292081C;
        Tue, 28 May 2019 12:58:27 +0000 (UTC)
Date:   Tue, 28 May 2019 08:58:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: [PATCH 01/16 v3] function_graph: Convert ret_stack to a series
 of longs
Message-ID: <20190528085826.796157de@gandalf.local.home>
In-Reply-To: <20190528095043.GA252809@google.com>
References: <20190525031633.811342628@goodmis.org>
        <20190525031745.235716308@goodmis.org>
        <20190528095043.GA252809@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 May 2019 05:50:43 -0400
Joel Fernandes <joel@joelfernandes.org> wrote:

> On Fri, May 24, 2019 at 11:16:34PM -0400, Steven Rostedt wrote:
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > In order to make it possible to have multiple callbacks registered with the
> > function_graph tracer, the retstack needs to be converted from an array of
> > ftrace_ret_stack structures to an array of longs. This will allow to store
> > the list of callbacks on the stack for the return side of the functions.
> > 
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  include/linux/sched.h |   2 +-
> >  kernel/trace/fgraph.c | 124 ++++++++++++++++++++++++------------------
> >  2 files changed, 71 insertions(+), 55 deletions(-)
> > 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 11837410690f..1850d8a3c3f0 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1113,7 +1113,7 @@ struct task_struct {
> >  	int				curr_ret_depth;
> >  
> >  	/* Stack of return addresses for return function tracing: */
> > -	struct ftrace_ret_stack		*ret_stack;
> > +	unsigned long			*ret_stack;  
> 
> Can it be converted to an array of unsigned int so the shadown stack space
> can be better used? This way stack overflow chance is lesser if there are too
> many registered fgraph users and the function call depth is too deep.
> AFAICS from patch 5/13, you need only 32-bits for the ftrace_ret_stack
> offset, type and array index, so the upper 32-bit would not be used.
> 

We can look to improve that later on. This is complex enough and I kept
some features (like 4 byte minimum) out of this series to keep the
complexity down. I believe there are some archs that require 64bit
aligned access for 64 bit words and pointers. And the retstack
structure still has longs on it. If we need to adapt to making sure we
are aligned, I rather keep that complexity out for now.

That said, I just did a git grep HAVE_64BIT_ALIGNED_ACCESS and only
found the kconfig where it is defined and the ring buffer code that
deals with it. We recently removed a bunch of archs, and it could very
well be that this requirement no longer exists.

Regardless, I've been testing this code quite heavily, and changing the
stack from moving up to moving down already put me behind. I'd like to
pull this code into linux-next soon. Converting to ints can be done for
the release after we get this in.

Thanks for reviewing!

-- Steve
