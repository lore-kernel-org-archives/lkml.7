Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD10CC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DBE421721
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfHPRFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 13:05:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbfHPRFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:05:06 -0400
Received: from oasis.local.home (rrcs-76-79-140-27.west.biz.rr.com [76.79.140.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E1E42077C;
        Fri, 16 Aug 2019 17:05:05 +0000 (UTC)
Date:   Fri, 16 Aug 2019 13:04:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
Message-ID: <20190816130440.07cc0a30@oasis.local.home>
In-Reply-To: <28afb801-6b76-f86b-9e1b-09488fb7c8ce@arm.com>
References: <00000000000076ecf3059030d3f1@google.com>
        <20190816142643.13758-1-mathieu.desnoyers@efficios.com>
        <20190816122539.34fada7b@oasis.local.home>
        <28afb801-6b76-f86b-9e1b-09488fb7c8ce@arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2019 17:48:59 +0100
Valentin Schneider <valentin.schneider@arm.com> wrote:

> On 16/08/2019 17:25, Steven Rostedt wrote:
> >> Also, write and read to/from those variables should be done with
> >> WRITE_ONCE() and READ_ONCE(), given that those are read within tracing
> >> probes without holding the sched_register_mutex.
> >>  
> > 
> > I understand the READ_ONCE() but is the WRITE_ONCE() truly necessary?
> > It's done while holding the mutex. It's not that critical of a path,
> > and makes the code look ugly.
> >   
> 
> I seem to recall something like locking primitives don't protect you from
> store tearing / invented stores, so if you can have concurrent readers
> using READ_ONCE(), there should be a WRITE_ONCE() on the writer side, even
> if it's done in a critical section.

But for this, it really doesn't matter. The READ_ONCE() is for going
from 0->1 or 1->0 any other change is the same as 1.

When we enable trace events, we start recording the tasks comms such
that we can possibly map them to the pids. When we disable trace
events, we stop recording the comms so that we don't overwrite the
cache when not needed. Note, if more than the max cache of tasks are
recorded during a session, we are likely to miss comms anyway.

Thinking about this more, the READ_ONCE() and WRTIE_ONCE() are not even
needed, because this is just a best effort anyway.

The only real fix was to move the check into the mutex protect area,
because that can cause a real bug if there was a race.

 {
-	bool sched_register = (!sched_cmdline_ref && !sched_tgid_ref);
+	bool sched_register;
+
 	mutex_lock(&sched_register_mutex);
+	sched_register = (!sched_cmdline_ref && !sched_tgid_ref);

Thus, I'd like to see a v2 of this patch without the READ_ONCE() or
WRITE_ONCE() added.

-- Steve
