Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E9FC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7450221773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391328AbfEXMF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 08:05:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:47342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391216AbfEXMF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 08:05:57 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3653120851;
        Fri, 24 May 2019 12:05:55 +0000 (UTC)
Date:   Fri, 24 May 2019 08:05:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: [RFC][PATCH 01/14 v2] function_graph: Convert ret_stack to a
 series of longs
Message-ID: <20190524080553.354f1cae@gandalf.local.home>
In-Reply-To: <20190524111144.GI2589@hirez.programming.kicks-ass.net>
References: <20190520142001.270067280@goodmis.org>
        <20190520142156.704372433@goodmis.org>
        <20190524111144.GI2589@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2019 13:11:44 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, May 20, 2019 at 10:20:02AM -0400, Steven Rostedt wrote:
> 
> > +#define FGRAPH_RET_SIZE (sizeof(struct ftrace_ret_stack))
> > +#define FGRAPH_RET_INDEX (ALIGN(FGRAPH_RET_SIZE, sizeof(long)) / sizeof(long))  
> 
> I think you want to write that like:
> 
> 	BUILD_BUG_ON(sizeof(ftrace_ret_stack) % sizeof(long));

Sure.

> 
> It'd be very weird for that sizeof not to be right.

Agreed, but I was paranoid. The BUILD_BUG_ON() would also work.

> 
> > +#define SHADOW_STACK_SIZE (PAGE_SIZE)  
> 
> Do we really need that big a shadow stack?

Well, this is a sticky point. I allow up to 16 users at a time
(although I can't imagine more than 5, but you never know), and each
user adds a long and up to 4 more words (which is probably unlikely
anyway). And then we can have deep call stacks (we are getting deeper
each release it seems).

I figured, I start with a page size, and then in the future we can make
it dynamic, or shrink it if it proves to be too much.

> 
> > +#define SHADOW_STACK_INDEX			\
> > +	(ALIGN(SHADOW_STACK_SIZE, sizeof(long)) / sizeof(long))
> > +/* Leave on a buffer at the end */
> > +#define SHADOW_STACK_MAX_INDEX (SHADOW_STACK_INDEX - FGRAPH_RET_INDEX)
> > +
> > +#define RET_STACK(t, index) ((struct ftrace_ret_stack *)(&(t)->ret_stack[index]))
> > +#define RET_STACK_INC(c) ({ c += FGRAPH_RET_INDEX; })
> > +#define RET_STACK_DEC(c) ({ c -= FGRAPH_RET_INDEX; })  
> 
> I'm thinking something like:
> 
> #define RET_PUSH(s, val)				\
> do {							\
> 	(s) -= sizeof(val);				\
> 	(typeof(val) *)(s) = val;			\
> } while (0)
> 
> #define RET_POP(s, type)				\
> ({							\
> 	type *__ptr = (void *)(s);			\
> 	(s) += sizeof(type);				\
> 	*__ptr;						\
> })
> 
> Would me clearer?

Due to races with interrupts, and this not being an atomic operation, I
had to play tricks with moving the stack pointer and adding data to it.
So I wanted to keep the changing of the stack pointer and adding and
retrieving of the stack data separate.

Later patches remove the RET_STACK_INC/DEC() anyway.

Thanks for taking the time to look at these patches!

-- Steve

