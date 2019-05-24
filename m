Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96C7C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB7B2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404216AbfEXPAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 11:00:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404095AbfEXPAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 11:00:50 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA4DF2133D;
        Fri, 24 May 2019 15:00:49 +0000 (UTC)
Date:   Fri, 24 May 2019 11:00:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jason Behmer <jbehmer@google.com>
Cc:     tom.zanussi@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: Nested events with zero deltas, can use absolute timestamps
 instead?
Message-ID: <20190524110048.142efd44@gandalf.local.home>
In-Reply-To: <CAMmhGq+8XKBB9GA3J0pwZ6X6Qb1syxKVqNU6i6digtyjMrGyWw@mail.gmail.com>
References: <CAMmhGqKc27W03roONYXhmwB0dtz5Z8nGoS2MLSsKJ3Zotv5-JA@mail.gmail.com>
        <20190329125258.2c6fe0cb@gandalf.local.home>
        <CAMmhGqKPw1sxB_Qc+Z-MXZue+wtAQsQDDgUvjs4JQTVY8bR65g@mail.gmail.com>
        <20190401222056.3da6e7a7@oasis.local.home>
        <CAMmhGqL0tvxW_ucJUFKYqRrMRTTfUfRGpm1BnXiEvqFntSXSjQ@mail.gmail.com>
        <CAMmhGq+8XKBB9GA3J0pwZ6X6Qb1syxKVqNU6i6digtyjMrGyWw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2019 07:17:15 -0700
Jason Behmer <jbehmer@google.com> wrote:


> Hi Steven,
> Your other email reminded me of this thread.  The easy "fix" we
> decided to pursue was to simply turn on absolute timestamps for all
> events and use up the extra space, which in our particular application
> isn't a huge deal.  We haven't yet gotten around to trying to send a
> patch for plumbing user-configurable absolute timestamps, but as noted
> immediately above, the configuration for timestamp_mode is actually a
> bit tricky to implement with the existing histogram ref counting.  The
> way I was thinking about dealing with that was to have a separate bool
> to indicate the state the user has indicated they want, and then you
> have to work through all the possible combinations of behavior:
> 
> If user absolute timestamps is false, all behavior is exactly as today.
> If user absolute timestamps is true, histogram refs transitioning 0->1
> is a no-op, as is histogram refs transitioning 1->0.
> If histogram refs are 0 and user absolute timestamps transition
> false->true or true->false, they get what they want.
> If histogram refs are >0 and user absolute timestamps transition
> false->true, it's a no-op.
> 
> And the confusing one:
> If histogram refs are >0 and user absolute timestamps transitions
> true->false we can't turn off absolute timestamps and screw up the
> histograms, so we return an error.  But user absolute timestamps is
> now false, which means when histogram refs transitions back to 0, it
> will turn off absolute timestamps.
> 
> What do you think of that?

I don't think that's confusing if its well documented. Have the user
flag called "force_absolute_timestamps", that way it's not something
that the user will think that we wont have absolute timestamps if it is
zero. Have the documentation say:

 Various utilities within the tracing system require that the ring
 buffer uses absolute timestamps. But you may force the ring buffer to
 always use it, which will give you unique timings with nested tracing
 at the cost of more usage in the ring buffer.

-- Steve
