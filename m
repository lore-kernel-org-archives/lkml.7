Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21F6C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 02:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B7B0206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 02:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbfDBCVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 22:21:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfDBCVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 22:21:00 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 235FD206B6;
        Tue,  2 Apr 2019 02:20:59 +0000 (UTC)
Date:   Mon, 1 Apr 2019 22:20:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jason Behmer <jbehmer@google.com>
Cc:     tom.zanussi@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: Nested events with zero deltas, can use absolute timestamps
 instead?
Message-ID: <20190401222056.3da6e7a7@oasis.local.home>
In-Reply-To: <CAMmhGqKPw1sxB_Qc+Z-MXZue+wtAQsQDDgUvjs4JQTVY8bR65g@mail.gmail.com>
References: <CAMmhGqKc27W03roONYXhmwB0dtz5Z8nGoS2MLSsKJ3Zotv5-JA@mail.gmail.com>
        <20190329125258.2c6fe0cb@gandalf.local.home>
        <CAMmhGqKPw1sxB_Qc+Z-MXZue+wtAQsQDDgUvjs4JQTVY8bR65g@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Apr 2019 15:54:20 -0700
Jason Behmer <jbehmer@google.com> wrote:

> The concurrency model is still a little bit unclear to me as I'm new
> to this codebase.  So I'm having some trouble reasoning about what
> operations are safe at one point on the ring buffer.    It seems like
> we can't be preempted in general, just interrupts?  And the events for
> the events emitted by interrupts will be fully processed before
> getting back to the event pointed at by the commit pointer?  If this
> is true I think the approach below (and prototyped in the attached
> patch against head) might work and would love feedback.  If not, this
> problem is way harder.
> 
> We detect nested events by checking our event pointer against the
> commit pointer.  This is safe because we reserve our event space
> atomically in the buffer, leading to an ordering of events we can
> depend on.  But to add a TIME_STAMP event we need to reserve more
> space before we even have an event pointer, so we need to know
> something about the ordering of events before we've actually
> atomically reserved ours.  We could check if the write pointer is set
> to the commit pointer, and if it isn't we know we're a nested event.
> But, someone could update the write pointer and/or commit pointer
> between the time we check it and the time we atomically reserve our
> space in the buffer.  However, I think maybe this is ok.
> 
> If we see that the write pointer is not equal to the commit pointer,
> then we're in an interrupt, and the only thing that could update the
> commit pointer is the original event emitting code that was
> interrupted, which can't run again until we're finished.  And the only
> thing that can update the write pointer is further interrupts of us,
> which will advance the write pointer further away from commit, leaving
> our decision to allocate a TIME_STAMP event as valid.
> 
> If we see that the write pointer is equal to the commit pointer, then
> anything that interrupts us before we move the write pointer will see
> that same state and will need to, before returning to us, commit their
> event and set commit to their new write pointer, which will make our
> decision valid once again.
> 
> There's a lot of assumptions in there that I'd love to be checked on
> as I'm new to this code base.  For example I haven't read the read
> path at all and have no idea if it interacts with this at all.

I think you pretty much got the idea correct. The issue is what to put
into the extra timestamp value. As the time we record the timestamp
compared to the time we allocate the space for the timestamp is not
atomic. And we can't have time go backwards :-(

		|                                  |
commit 	--->	+----------------------------------+
		| TS offset from previous event    |  (A)
		+----------------------------------+
		| outer event data                 |
<interrupt>	+----------------------------------+
		| extended TS                      |  (B)
		+----------------------------------+
		| interrupt event data             |
		+----------------------------------+
 head	--->	|                                  |


	TS = rdstc();
	A = reserve_ring_buffer
	*A = TS

interrupt:
	TS = rdtsc();
	B = reserve_ring_buffer
	*B = TS


What's important is what we store in A and B

	TS = rdtsc();
		<interrupt> --->
					TS = rdstc()
					(this is first commit!)
					A = reserver_ring_buffer
					*A = TS
					(finish commit)
		<----
	A = reserver_ring_buffer
	*A = TS

You can see how the recording of the timestamp and writing it gets
complex. Also it gets more complex when we use deltas and not direct writes.

Now we may be able to handle this if we take the timestamp before doing
anything, and if it's nested, take it again (which should guarantee
that it's after the previous timestamp)

Now of course the question is, how do we update the write stamp that we
will use to compute new "deltas"? Or we just use absolute timestamps to
the end of the page, and start over again, when we start a new page
that isn't nested.

But see where the complexity comes from?

-- Steve
