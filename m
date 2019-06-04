Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBC8C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C91124A37
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfFDJEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 05:04:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbfFDJEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 05:04:16 -0400
Received: from oasis.local.home (unknown [146.247.46.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB95E24A33;
        Tue,  4 Jun 2019 09:04:12 +0000 (UTC)
Date:   Tue, 4 Jun 2019 05:04:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: [RFC][PATCH 01/14 v2] function_graph: Convert ret_stack to a
 series of longs
Message-ID: <20190604050407.736b2a32@oasis.local.home>
In-Reply-To: <20190603203049.bf07719eb3c0af4218812b3f@kernel.org>
References: <20190520142001.270067280@goodmis.org>
        <20190520142156.704372433@goodmis.org>
        <20190524111144.GI2589@hirez.programming.kicks-ass.net>
        <20190524080553.354f1cae@gandalf.local.home>
        <20190603203049.bf07719eb3c0af4218812b3f@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2019 20:30:49 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > >   
> > > > +#define SHADOW_STACK_SIZE (PAGE_SIZE)    
> > > 
> > > Do we really need that big a shadow stack?  
> > 
> > Well, this is a sticky point. I allow up to 16 users at a time
> > (although I can't imagine more than 5, but you never know), and each
> > user adds a long and up to 4 more words (which is probably unlikely
> > anyway). And then we can have deep call stacks (we are getting deeper
> > each release it seems).
> > 
> > I figured, I start with a page size, and then in the future we can make
> > it dynamic, or shrink it if it proves to be too much.  
> 
> I'd prefer dynamic allocation, based on the number of users or actual
> stack starvation.

As stated, it's something we can improve on in the future. I'll
probably be pushing out this series for linux-next, and then we can
incrementally improve it.

First on my list is to add a REGS version of function_graph such that
kretprobes can use it ;-)

-- Steve
