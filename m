Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B99BC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 19:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8A22171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 19:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfHPTSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 15:18:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbfHPTSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 15:18:50 -0400
Received: from oasis.local.home (rrcs-76-79-140-27.west.biz.rr.com [76.79.140.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 806BC2077C;
        Fri, 16 Aug 2019 19:18:49 +0000 (UTC)
Date:   Fri, 16 Aug 2019 15:18:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
Message-ID: <20190816151846.54692edc@oasis.local.home>
In-Reply-To: <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com>
References: <00000000000076ecf3059030d3f1@google.com>
        <20190816142643.13758-1-mathieu.desnoyers@efficios.com>
        <20190816122539.34fada7b@oasis.local.home>
        <28afb801-6b76-f86b-9e1b-09488fb7c8ce@arm.com>
        <20190816130440.07cc0a30@oasis.local.home>
        <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2019 13:41:59 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> ----- On Aug 16, 2019, at 1:04 PM, rostedt rostedt@goodmis.org wrote:
> 
> > On Fri, 16 Aug 2019 17:48:59 +0100
> > Valentin Schneider <valentin.schneider@arm.com> wrote:
> >   
> >> On 16/08/2019 17:25, Steven Rostedt wrote:  
> >> >> Also, write and read to/from those variables should be done with
> >> >> WRITE_ONCE() and READ_ONCE(), given that those are read within tracing
> >> >> probes without holding the sched_register_mutex.
> >> >>    
> >> > 
> >> > I understand the READ_ONCE() but is the WRITE_ONCE() truly necessary?
> >> > It's done while holding the mutex. It's not that critical of a path,
> >> > and makes the code look ugly.
> >> >     
> >> 
> >> I seem to recall something like locking primitives don't protect you from
> >> store tearing / invented stores, so if you can have concurrent readers
> >> using READ_ONCE(), there should be a WRITE_ONCE() on the writer side, even
> >> if it's done in a critical section.  
> > 
> > But for this, it really doesn't matter. The READ_ONCE() is for going
> > from 0->1 or 1->0 any other change is the same as 1.  
> 
> Let's consider this "invented store" scenario (even though as I noted in my
> earlier email, I suspect this particular instance of the code does not appear
> to fit the requirements to generate this in the wild with current compilers):
> 
> intial state:
> 
> sched_tgid_ref = 10;
> 
> Thread A                                Thread B
> 
> registration                            tracepoint probe
> sched_tgid_ref++
>   - compiler decides to invent a
>     store: sched_tgid_ref = 0

This looks to me that this would cause more issues in other parts of
the code if a compiler ever decided to do this.

But I still don't care for this case. It's a cache, nothing more. No
guarantee that anything will be recorded.


>                                         READ_ONCE(sched_tgid_ref) ->
> observes 0, but should really see either 10 or 11.
>   - compiler stores 11 into
>     sched_tgid_ref
> 
> This kind of scenario could cause spurious missing data in the middle
> of a trace caused by another user trying to increment the reference
> count, which is really unexpected.
> 
> A similar scenario can happen for "store tearing" if the compiler
> decides to break the store into many stores close to the 16-bit
> overflow value when updating a 32-bit reference count. Spurious 1 ->
> 0 -> 1 transitions could be observed by readers.
> 
> > When we enable trace events, we start recording the tasks comms such
> > that we can possibly map them to the pids. When we disable trace
> > events, we stop recording the comms so that we don't overwrite the
> > cache when not needed. Note, if more than the max cache of tasks are
> > recorded during a session, we are likely to miss comms anyway.
> > 
> > Thinking about this more, the READ_ONCE() and WRTIE_ONCE() are not
> > even needed, because this is just a best effort anyway.  
> 
> If you choose not to use READ_ONCE(), then the "load tearing" issue
> can cause similar spurious 1 -> 0 -> 1 transitions near 16-bit counter
> overflow as described above. The "Invented load" also becomes an
> issue, because the compiler could use the loaded value for a branch,
> and re-load that value between two branches which are expected to use
> the same value, effectively generating a corrupted state.
> 
> I think we need a statement about whether READ_ONCE/WRITE_ONCE should
> be used in this kind of situation, or if we are fine dealing with the
> awkward compiler side-effects when they will occur.
> 

Let me put it this way. My biggest issue with this, is that the
READ/WRITE_ONCE() has *nothing* to do with the bug you are trying to
fix.

That bug is that we did the decision of starting the probes outside the
mutex. That is fixed my moving the decision into the mutex. The
READ/WRITE_ONCE() is just added noise.

-- Steve
