Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DDDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3DB218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfCOUMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 16:12:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfCOUMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 16:12:06 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA10B218A1;
        Fri, 15 Mar 2019 20:12:04 +0000 (UTC)
Date:   Fri, 15 Mar 2019 16:12:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Brian Norris <briannorris@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] tracing: kdb: Allow ftdump to skip all but the last
 few lines
Message-ID: <20190315161203.25dc2a0c@gandalf.local.home>
In-Reply-To: <CAD=FV=WUnmMxKZrH-Jfz-VocieOu-Cfsi1aLpB8G5FnLM+_W_w@mail.gmail.com>
References: <20190315174528.16531-1-dianders@chromium.org>
        <20190315144130.1aa36931@gandalf.local.home>
        <CAD=FV=WUnmMxKZrH-Jfz-VocieOu-Cfsi1aLpB8G5FnLM+_W_w@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019 12:55:31 -0700
Doug Anderson <dianders@chromium.org> wrote:

> >
> > Actually, you can add a function in trace.c that exposes
> > get_total_entries:
> >
> > unsigned long trace_total_entries(struct trace_array *tr)
> > {
> >         unsigned long total, entries;
> >
> >         if (!tr)
> >                 tr = &global_trace;
> >
> >         get_total_entries(tr->trace_buffer, &total, &entries);
> >
> >         return entries;
> > }
> >
> > and then do:
> >                 cnt = trace_total_entries(NULL);  
> 
> OK.  I guess I'll need to figure out how to add an argument to limit
> it to just one CPU too since the kdb command allows you to specify a
> single CPU or all CPUs.  I think the best way would mean adding an
> argument to get_total_entries().  ...or I can just change the kdb
> command to not allow specifying a CPU?  Which do you prefer?  I
> personally haven't ever used the feature to just print the ftrace
> buffer for a certain CPU so I'd be OK removing it.

I would make a get_total_entries_cpu() that contains the guts of
get_total_entries() which then calls get_total_entries_cpu()

static void
get_total_entries(struct trace_buffer *buf,
		  unsigned long *total, unsigned long *entries)
{
	unsigned long t, e;
	int cpu;

	*total = 0;
	*entries = 0;

	for_each_tracing_cpu(cpu)
		get_total_entries_cpu(buf, &t, &e, cpu);
		*total += t;
		*entries += e;
	}
}
	
> 
> 
> > Don't modify ftrace_dump_buf()  
> 
> I still kinda prefer modifying ftrace_dump_buf() just because it's
> pretty important that the "count" we come up with match pretty exactly
> the count that ftrace_dump_buf() will come up with.  My worry probably
> comes from my lack of experience with the internals of ftrace but, for
> instance, I see things like "tr->trace_flags &=
> ~TRACE_ITER_SYM_USEROBJ" in ftrace_dump_buf() and I worry that it will
> affect the count.  ...but if you tell me that I need not worry about
> things like that then I won't.  :-)

Hmm, actually your method still wont work, because you are only
counting entries not lines. The stack dumps are considered a single
line but will print multiple lines.

Not only that, perhaps you should break apart ftrace_dump_buf(),
because calling it twice (or doing what I suggested), wont stop tracing
in between, and the size of the buffer might change between the two
calls.

You need to move out:

	for_each_tracing_cpu(cpu) {
		atomic_inc(&per_cpu_ptr(iter.trace_buffer->data, cpu)->disabled);
	}


and

	for_each_tracing_cpu(cpu) {
		atomic_dec(&per_cpu_ptr(iter.trace_buffer->data, cpu)->disabled);
	}

to disable tracing while you do this.

The get_total_entries() is the faster approach to get the count, but in
either case, the count should end up the same.

-- Steve
