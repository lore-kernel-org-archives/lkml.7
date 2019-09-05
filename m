Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE16EC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C431222C0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389723AbfIENFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 09:05:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:50764 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726097AbfIENFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 09:05:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6BD8DAD4B;
        Thu,  5 Sep 2019 13:05:14 +0000 (UTC)
Date:   Thu, 5 Sep 2019 15:05:13 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 0/9] printk: new ringbuffer implementation
Message-ID: <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190904123531.GA2369@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904123531.GA2369@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-09-04 14:35:31, Peter Zijlstra wrote:
> On Thu, Aug 08, 2019 at 12:32:25AM +0206, John Ogness wrote:
> > Hello,
> > 
> > This is a follow-up RFC on the work to re-implement much of
> > the core of printk. The threads for the previous RFC versions
> > are here: v1[0], v2[1], v3[2].
> > 
> > This series only builds upon v3 (i.e. the first part of this
> > series is exactly v3). The main purpose of this series is to
> > replace the current printk ringbuffer with the new
> > ringbuffer. As was discussed[3], this is a conservative
> > first step to rework printk. For example, all logbuf_lock
> > usage is kept even though the new ringbuffer does not
> > require it. This avoids any side-effect bugs in case the
> > logbuf_lock is (unintentionally) synchronizing more than
> > just the ringbuffer. However, this also means that the
> > series does not bring any improvements, just swapping out
> > implementations. A future patch will remove the logbuf_lock.
> 
> So after reading most of the first patch (and it look _much_ better than
> previous times), I'm left wondering *why* ?!
> 
> That is, why do we need this complexity, as compared to that
> CPU serialized approach?

The serialized approach used a lock. It was re-entrant and thus less
error-prone but still a lock.

The lock was planed to be used not only to access the buffer but also
for eventual locking inside lockless consoles. It might allow to
have some synchronization even in lockless consoles. But it
would be big-kernel-lock-like style. It might create yet
another maze of problems.

If we remove per-CPU buffers in NMI. We would need to synchronize
again printing backtraces from all CPUs. Otherwise they would get
mixed and hard to read. It might be solved by some prefix and
sorting in userspace but...

This why I asked to see a fully lockless code to see how
more complicated it was. John told me that he had an early
version of it around.


I agree that this lockless variant is really complicated. I am not
able to prove that it is race free as it is now. I understand
the algorithm. But there are too many synchronization points.

Peter, have you seen my alternative approach, please. See
https://lore.kernel.org/lkml/20190704103321.10022-1-pmladek@suse.com/

It uses two tricks:

   1. Two bits in the sequence number are used to track the state
      of the related data. It allows to implement the entire
      life cycle of each entry using atomic operation on a single
      variable.

   2. There is a helper function to read valid data for each entry,
      see prb_read_desc(). It checks the state before and after
      reading the data to make sure that they are valid. And
      it includes the needed read barriers. As a result there
      are only three explicit barriers in the code. All other
      are implicitly done by cmpxchg() atomic operations.

The alternative lockless approach is still more complicated than
the serialized one. But I think that it is manageable thanks to
the simplified state tracking. And I might safe use some pain
in the long term.


> In my book simpler is better here. printk() is an absolute utter slow
> path anyway, nobody cares about the performance much, and I'm thinking
> that it should be plenty fast enough as long as you don't run a
> synchronous serial output (which is exactly what I do do/require
> anyway).

I fully agree.

Best Regards,
Petr
