Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC88C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 23:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E59D20675
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 23:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfEEXBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 19:01:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:40072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727615AbfEEXBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 19:01:37 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5880E20675;
        Sun,  5 May 2019 23:01:36 +0000 (UTC)
Date:   Sun, 5 May 2019 19:01:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Viktor Rosendahl <viktor.rosendahl@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] ftrace: Implement fs notification for
 preempt/irqsoff tracers
Message-ID: <20190505190133.49b5ea46@oasis.local.home>
In-Reply-To: <20190505223915.4569-1-viktor.rosendahl@gmail.com>
References: <20190504164710.GA55790@google.com>
        <20190505223915.4569-1-viktor.rosendahl@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 May 2019 00:39:15 +0200
Viktor Rosendahl <viktor.rosendahl@gmail.com> wrote:

> Can you explain more precisely what you agree with?
> 
> The general idea of being able to trace bursts of latencies?

One thing I have an issue with the current approach is the use of the
trace file for this.

> 
> Or the slightly more specific idea of notifying user space when
> /sys/kernel/debug/tracing/trace has new data, and let user space do the rest?
> 
> > We do have a notification mechanism already in the form of trace_pipe. Can we
> > not improve that in some way to be notified of a new trace data? In theory,
> > the trace_pipe does fit into the description in the documentation: "Reads
> > from this file will block until new data is retrieved"
> >  
> 
> I am not quite sure what kind of solution you are after here. Could you be more
> specific?
> 
> I think that it would be weird if we used trace_pipe to send a message with
> the meaning "new data is available in the trace file". To me this would seem
> like (re)inventing a special purpose alternative to inotify.
> 
> Another option would be to allow the user to consume the the latency traces
> directly from trace_pipe, without using the trace file. This would make sense
> to me and would indeed be a much better solution. If somebody is able to make
> such an implementation I am all for it.
> 
> However, I do not know how to do this. I believe that it would lead towards a
> significant rewrite of the latency tracers, probably also how the ftrace
> buffering works.
> 

Hmm, what about adding a notifier to tracing_max_latency instead? And
do it not as a config option, but have it always enabled. It would send a
notification when it changes, and that only happens when there's a new
max latency. Would that work for you?

-- Steve

