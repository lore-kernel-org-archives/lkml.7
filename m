Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606D6C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 14:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2010520673
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 14:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qXp2W7KY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404090AbfEXOR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 10:17:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34453 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403895AbfEXOR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 10:17:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id h2so2095367pgg.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 07:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nKudlJj/w8w8O8/nnYWhoDEELtp6+YxytSFdce5FuwQ=;
        b=qXp2W7KYLzfPRkn4lW6HybWe5fJOUKlJBOjqbh8nw6RYEePPHQq0yCtWKcKH8IrW3N
         eorqIQKqt7LSttdvJdN6wthW7Ras8GKMqg+R62NGP4FHW5QyIyJgycEfryTYJFr4Ora3
         yCKVAmed09SRB0itVJhCOLp5D6nJWboN/VVYfYMBjMpjioiNJj/7MVSYi6GTDtVNOFsF
         v391lEILHvxbJ4JofS+Pfazahdd+Oh1kbPDwfMWV3xb7cyzCqZf0Vwn4ajfoITTb/GMo
         U6H27EL2DFPw/3QWqS155bup2lZ+jmLjj01o8KnBUnnnRcW1EqT4gnBAmwPfW/ORTqb2
         HS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nKudlJj/w8w8O8/nnYWhoDEELtp6+YxytSFdce5FuwQ=;
        b=WQoISlMFuRrFMSeGW1NNE05vu/R//nR5g/3DwFhBavKTT0lBcl9PqynxrxW5KquFCl
         DyWDDhqBu8VMg4CLnqS1dVPMqBMfv6EpAjx9xhraAxvjRpZKD0mt1lcAcw0qC51oJQKg
         Lifyy+SY/yZO4+l58oQ9YnNMZSgOtkR9Zmt484taWpv10FvYoPRM1IyoK7kK5WzDBhbj
         mytOvAszbeQsYNyxVQryr8aFcP9VKB0lislaUvKOP/aGDyIDoLCiq23XLpbLvmCiAH62
         B0sfYzYUAWSEQBKWkDDlUwOHowyx/8+YrADsvNEr0yqh2d55GP1rsqGDN4IuFIf+c/DB
         IJIg==
X-Gm-Message-State: APjAAAW0EMvJ9PT3CwS8dNNh92TzsKRoU3zuNktDLaIzZdgFs7SWbzcQ
        Y+G2gPTXJtnizt20u1f+4R4YBT+1lc8HzqNy//WHvC71Z+MnWQ==
X-Google-Smtp-Source: APXvYqxzJlRFsoRsutKj/X8gJ2yqMvFk36dvVCpHR+Y9L1tN8QR0lbEFrAkXAxkKc73NJ53R6ip00845jmj5aZZHuGQ=
X-Received: by 2002:a63:d70b:: with SMTP id d11mr103366510pgg.178.1558707446255;
 Fri, 24 May 2019 07:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAMmhGqKc27W03roONYXhmwB0dtz5Z8nGoS2MLSsKJ3Zotv5-JA@mail.gmail.com>
 <20190329125258.2c6fe0cb@gandalf.local.home> <CAMmhGqKPw1sxB_Qc+Z-MXZue+wtAQsQDDgUvjs4JQTVY8bR65g@mail.gmail.com>
 <20190401222056.3da6e7a7@oasis.local.home> <CAMmhGqL0tvxW_ucJUFKYqRrMRTTfUfRGpm1BnXiEvqFntSXSjQ@mail.gmail.com>
In-Reply-To: <CAMmhGqL0tvxW_ucJUFKYqRrMRTTfUfRGpm1BnXiEvqFntSXSjQ@mail.gmail.com>
From:   Jason Behmer <jbehmer@google.com>
Date:   Fri, 24 May 2019 07:17:15 -0700
Message-ID: <CAMmhGq+8XKBB9GA3J0pwZ6X6Qb1syxKVqNU6i6digtyjMrGyWw@mail.gmail.com>
Subject: Re: Nested events with zero deltas, can use absolute timestamps instead?
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     tom.zanussi@linux.intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 9:42 PM Jason Behmer <jbehmer@google.com> wrote:
>
> On Mon, Apr 1, 2019 at 7:21 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Mon, 1 Apr 2019 15:54:20 -0700
> > Jason Behmer <jbehmer@google.com> wrote:
> >
> > > The concurrency model is still a little bit unclear to me as I'm new
> > > to this codebase.  So I'm having some trouble reasoning about what
> > > operations are safe at one point on the ring buffer.    It seems like
> > > we can't be preempted in general, just interrupts?  And the events for
> > > the events emitted by interrupts will be fully processed before
> > > getting back to the event pointed at by the commit pointer?  If this
> > > is true I think the approach below (and prototyped in the attached
> > > patch against head) might work and would love feedback.  If not, this
> > > problem is way harder.
> > >
> > > We detect nested events by checking our event pointer against the
> > > commit pointer.  This is safe because we reserve our event space
> > > atomically in the buffer, leading to an ordering of events we can
> > > depend on.  But to add a TIME_STAMP event we need to reserve more
> > > space before we even have an event pointer, so we need to know
> > > something about the ordering of events before we've actually
> > > atomically reserved ours.  We could check if the write pointer is set
> > > to the commit pointer, and if it isn't we know we're a nested event.
> > > But, someone could update the write pointer and/or commit pointer
> > > between the time we check it and the time we atomically reserve our
> > > space in the buffer.  However, I think maybe this is ok.
> > >
> > > If we see that the write pointer is not equal to the commit pointer,
> > > then we're in an interrupt, and the only thing that could update the
> > > commit pointer is the original event emitting code that was
> > > interrupted, which can't run again until we're finished.  And the only
> > > thing that can update the write pointer is further interrupts of us,
> > > which will advance the write pointer further away from commit, leaving
> > > our decision to allocate a TIME_STAMP event as valid.
> > >
> > > If we see that the write pointer is equal to the commit pointer, then
> > > anything that interrupts us before we move the write pointer will see
> > > that same state and will need to, before returning to us, commit their
> > > event and set commit to their new write pointer, which will make our
> > > decision valid once again.
> > >
> > > There's a lot of assumptions in there that I'd love to be checked on
> > > as I'm new to this code base.  For example I haven't read the read
> > > path at all and have no idea if it interacts with this at all.
> >
> > I think you pretty much got the idea correct. The issue is what to put
> > into the extra timestamp value. As the time we record the timestamp
> > compared to the time we allocate the space for the timestamp is not
> > atomic. And we can't have time go backwards :-(
> >
> >                 |                                  |
> > commit  --->    +----------------------------------+
> >                 | TS offset from previous event    |  (A)
> >                 +----------------------------------+
> >                 | outer event data                 |
> > <interrupt>     +----------------------------------+
> >                 | extended TS                      |  (B)
> >                 +----------------------------------+
> >                 | interrupt event data             |
> >                 +----------------------------------+
> >  head   --->    |                                  |
> >
> >
> >         TS = rdstc();
> >         A = reserve_ring_buffer
> >         *A = TS
> >
> > interrupt:
> >         TS = rdtsc();
> >         B = reserve_ring_buffer
> >         *B = TS
> >
> >
> > What's important is what we store in A and B
> >
> >         TS = rdtsc();
> >                 <interrupt> --->
> >                                         TS = rdstc()
> >                                         (this is first commit!)
> >                                         A = reserver_ring_buffer
> >                                         *A = TS
> >                                         (finish commit)
> >                 <----
> >         A = reserver_ring_buffer
> >         *A = TS
> >
> > You can see how the recording of the timestamp and writing it gets
> > complex. Also it gets more complex when we use deltas and not direct writes.
> >
> > Now we may be able to handle this if we take the timestamp before doing
> > anything, and if it's nested, take it again (which should guarantee
> > that it's after the previous timestamp)
> >
> > Now of course the question is, how do we update the write stamp that we
> > will use to compute new "deltas"? Or we just use absolute timestamps to
> > the end of the page, and start over again, when we start a new page
> > that isn't nested.
> >
> > But see where the complexity comes from?
> >
> > -- Steve
>
> Ah, yes, I was too focused on the first problem of if we could even
> reserve the space due to concurrency restrictions.
>
> First, I had assumed there weren't restrictions on timestamps needing
> to not go backwards between consecutive events in the buffers, as it
> seems the current implementation of absolute timestamps should have
> this issue.  It also seems incredibly difficult to solve.  Even with
> your suggestion of taking the timestamp a second time if you're nested
> - can't you end up with multiple layers of nesting?  So how do you
> make sure that the third level nested event has a timestamp after the
> second level nested event?  It seems like maybe there's some very
> complicated way you can make this work given that it seems like your
> stack depth here is limited here to One of each of normal, nmi,
> softirq, and hardirq at a time (is that right?).
>
> And second, I forgot entirely about updating the write stamp.  It
> looks like my prototype patch as written will still just update the
> write stamp to the outer event's timestamp, whereas really logically
> we'd like to set it to the last thing in the buffer when we commit.
> It looks like rb_set_commit_to_write already leapfrogs write_stamp to
> the next page timestamp every time it commits a full page.  Ideally
> we'd be able to also do this when we get to the tail page and update
> commit to its write index.  Because, I think, nothing will be diffing
> off of write_stamp until we set commit to be back to write.  But of
> course within a page we have no clue what the timestamp of the event
> previous to the write pointer is.
>
> And with ordering problems, you can't even just try the brute force
> approach of having all of the nested events update write_stamp on
> commit if their ts is larger than the current write_stamp (although
> even if you did want to do that it seems like you'd have to do some
> more complicate atomic access to write stamp as you would no longer
> have the nice property of it only being updated by one piece of code
> at a time).
>
> As for using absolute timestamps for the rest of the page, it seems
> like in many use cases that would end up being functionally very
> similar (with a far more complex implementation) to just turning on
> absolute timestamps for everything.  This of course depends entirely
> on the trace points you're gathering, but some common ones, like
> sched_* seem to get called fairly often from an interrupt context even
> on an idle system.
>
>
> Also, I was actually going to send out a patch to try to make the
> timestamp_mode file writable, as an easy short-term fix for getting
> absolute time stamps.  However, it looks like the current hook to turn
> it on is doing some ref counting on enabling/disabling some histogram
> listeners.  Combining that with a user-writable config file seems a
> little tricky in terms of semantics, which do we want to take
> priority?  It seems like a user changing a config an accidentally
> clobbering the histogram listeners isn't great, but neither is giving
> back a user cryptic errors when they try to write the file and
> histogram listeners are configured.  Any thoughts on what to do there
> and how to implement it?
>
> Thanks,
> Jason

Hi Steven,
Your other email reminded me of this thread.  The easy "fix" we
decided to pursue was to simply turn on absolute timestamps for all
events and use up the extra space, which in our particular application
isn't a huge deal.  We haven't yet gotten around to trying to send a
patch for plumbing user-configurable absolute timestamps, but as noted
immediately above, the configuration for timestamp_mode is actually a
bit tricky to implement with the existing histogram ref counting.  The
way I was thinking about dealing with that was to have a separate bool
to indicate the state the user has indicated they want, and then you
have to work through all the possible combinations of behavior:

If user absolute timestamps is false, all behavior is exactly as today.
If user absolute timestamps is true, histogram refs transitioning 0->1
is a no-op, as is histogram refs transitioning 1->0.
If histogram refs are 0 and user absolute timestamps transition
false->true or true->false, they get what they want.
If histogram refs are >0 and user absolute timestamps transition
false->true, it's a no-op.

And the confusing one:
If histogram refs are >0 and user absolute timestamps transitions
true->false we can't turn off absolute timestamps and screw up the
histograms, so we return an error.  But user absolute timestamps is
now false, which means when histogram refs transitions back to 0, it
will turn off absolute timestamps.

What do you think of that?
