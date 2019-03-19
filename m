Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F85EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 178CA2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfCSOza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:55:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbfCSOz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:55:27 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1A85217F9;
        Tue, 19 Mar 2019 14:55:26 +0000 (UTC)
Date:   Tue, 19 Mar 2019 10:55:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Brian Norris <briannorris@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] tracing: Add trace_total_entries() /
 trace_total_entries_cpu()
Message-ID: <20190319105525.7686763b@gandalf.local.home>
In-Reply-To: <CAD=FV=UJNED79Oc3ge3_JXZdJcADm_B9N-asymGrwZvKew2Wzw@mail.gmail.com>
References: <20190318204741.116550-1-dianders@chromium.org>
        <20190318204741.116550-2-dianders@chromium.org>
        <20190319112537.5yi7gelkk4ixswmu@holly.lan>
        <CAD=FV=UJNED79Oc3ge3_JXZdJcADm_B9N-asymGrwZvKew2Wzw@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2019 07:45:38 -0700
Doug Anderson <dianders@chromium.org> wrote:

> > > +unsigned long trace_total_entries_cpu(struct trace_array *tr, int cpu)
> > > +{
> > > +     unsigned long total, entries;
> > > +
> > > +     if (!tr)
> > > +             tr = &global_trace;  
> >
> > This function is only ever called with tr set to NULL which means tr is
> > an argument looking for a user.
> >
> > I wouldn't mind except if this was following copying prior art to keep
> > the API feel the same but I can't find any other trace function where
> > the trace_array can be substituted for NULL. AFAICT all the existing
> > sites where global_trace is used will use it unconditionally.  

I'm in the process of making everything work better with tracing
instances. Which means, making all the APIs use the tr pointer (which is
the descriptor for the instance).

All new APIs added to the tracing infrastructure should reference a "tr"
pointer, and not use the global_trace directly. We can default it if tr
is NULL.

There are currently lots of cases in the code that do so, but I'm
trying to get rid of them.

> 
> Happy to change this if you guys want.  At the moment the
> trace_total_entries() comes straight from Steven's suggestion at:
> 
> https://lkml.kernel.org/r/20190315144130.1aa36931@gandalf.local.home
> 
> Ugh, but while looking at this it looks like I totally forgot one
> piece of feedback from Steven: to move the disabling of the tracing
> out so it's not re-enabled after counting but before dumping.  Not
> sure how I missed that.  :(
> 
> I'll wait to spin until I hear from Steven if he wants me to remove
> the "struct trace_array *tr" argument, then I'll post out a v6 with
> the fix I forgot...

Please keep the tr argument.

Thanks!

-- Steve
