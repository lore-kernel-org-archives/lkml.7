Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBB4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0689218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbfC2QxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:53:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728936AbfC2QxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:53:00 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88EB5218D0;
        Fri, 29 Mar 2019 16:52:59 +0000 (UTC)
Date:   Fri, 29 Mar 2019 12:52:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jason Behmer <jbehmer@google.com>
Cc:     tom.zanussi@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: Nested events with zero deltas, can use absolute timestamps
 instead?
Message-ID: <20190329125258.2c6fe0cb@gandalf.local.home>
In-Reply-To: <CAMmhGqKc27W03roONYXhmwB0dtz5Z8nGoS2MLSsKJ3Zotv5-JA@mail.gmail.com>
References: <CAMmhGqKc27W03roONYXhmwB0dtz5Z8nGoS2MLSsKJ3Zotv5-JA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2019 09:30:36 -0700
Jason Behmer <jbehmer@google.com> wrote:

> Hi Steven and Tom,
> I recently ran into a problem with correlating timestamps across CPUs and
> finally was able to track it down to the fact that nested events are given
> zero deltas, and so are placed earlier in time than they actually occurred.
> 
> I'm on an older version and wanted to check if this problem still exists on
> head and it appears that it does, but I also ran into Tom's commits adding
> the ability to use absolute timestamps instead of deltas.  It seems like
> this option could fix the problem.
> 
> It seems like ideally nested events could just always use these absolute
> timestamps instead of zero deltas, as it appears the implementation of
> absolute timestamps is flexible enough to have a mix of deltas and
> absolutes in the stream of events.  A fix that would require less work
> would be for me to just turn on absolute timestamps for my entire trace,
> but I see that the file to do that isn't yet writable to support that.
> 
> Before trying to do either of these things I wanted to run it by both of
> you to see if there's something I'm missing here.  What do you think?
> 

Yes this is an issue I need to fix. I have some ideas on how to handle
this. I may need to go about looking into them again.

It may be possible to add an option to have all nested events use the
full timestamp as well.

I'll have to think about this a bit more.

-- Steve
