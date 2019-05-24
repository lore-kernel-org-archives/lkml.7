Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF07CC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A142081C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391387AbfEXMMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 08:12:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391253AbfEXMMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 08:12:23 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD98421773;
        Fri, 24 May 2019 12:12:21 +0000 (UTC)
Date:   Fri, 24 May 2019 08:12:19 -0400
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
Subject: Re: [RFC][PATCH 03/14 v2] function_graph: Allow multiple users to
 attach to function graph
Message-ID: <20190524081219.25de03f6@gandalf.local.home>
In-Reply-To: <20190524112608.GJ2589@hirez.programming.kicks-ass.net>
References: <20190520142001.270067280@goodmis.org>
        <20190520142156.992391836@goodmis.org>
        <20190524112608.GJ2589@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2019 13:26:08 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> But but but but.. why not add all the required bits to the shadow stack
> in the first place and do away with the array entirely?

What required bits would that be? The pointer to the fgraph_ops,
because we need that to pass to the calling function.

> 
> So on ret, just keep POP'ing until either the stack is empty or the
> entry is for another function.

When we hit a fgraph_ops, how do we know if it was freed or not? We
can't just blindly reference it.

The idea of the array, is that we can maintain state in a single
location of when the fgraph_ops is freed. If we return from a function,
we have an index and a counter, and if the counter doesn't match with
what's in the array, then we know that the fgraph_ops is no longer
around and we just drop it.

The reason for the array, is to keep track of if the fgraph_ops has
been freed or not. Otherwise, when we unregister the fgraph_ops, we
would need to search all shadow stacks, looking for it to unreference
it.

Believe me, I rather not have that array, but I couldn't come up with a
better solution to handle freeing of fgraph_ops.

-- Steve
