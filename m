Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDB4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34F1218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfCOVIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 17:08:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbfCOVIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 17:08:25 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72E8521871;
        Fri, 15 Mar 2019 21:08:23 +0000 (UTC)
Date:   Fri, 15 Mar 2019 17:08:22 -0400
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
Message-ID: <20190315170822.6316f3cb@gandalf.local.home>
In-Reply-To: <CAD=FV=VcpVYjwYq3zo6ODKzRBtDkjgEM2sXC-KMUa0ObskfTnw@mail.gmail.com>
References: <20190315174528.16531-1-dianders@chromium.org>
        <20190315144130.1aa36931@gandalf.local.home>
        <CAD=FV=WUnmMxKZrH-Jfz-VocieOu-Cfsi1aLpB8G5FnLM+_W_w@mail.gmail.com>
        <20190315161203.25dc2a0c@gandalf.local.home>
        <CAD=FV=VcpVYjwYq3zo6ODKzRBtDkjgEM2sXC-KMUa0ObskfTnw@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019 13:54:11 -0700
Doug Anderson <dianders@chromium.org> wrote:

> > Hmm, actually your method still wont work, because you are only
> > counting entries not lines. The stack dumps are considered a single
> > line but will print multiple lines.  
> 
> LOL.  Back to v1 then?  v1 of the patch [1] was definitely consistent
> even if it was very slow.  Specifically whatever was being counted by
> ftrace_dump_buf() (entries or lines or something in between) was
> definitely used to figure out how many to skip.

You'll need to read the line itself. I don't see v1 giving a different
count than the get_total_entries() does.

> 
> 
> > Not only that, perhaps you should break apart ftrace_dump_buf(),
> > because calling it twice (or doing what I suggested), wont stop tracing
> > in between, and the size of the buffer might change between the two
> > calls.
> >
> > You need to move out:
> >
> >         for_each_tracing_cpu(cpu) {
> >                 atomic_inc(&per_cpu_ptr(iter.trace_buffer->data, cpu)->disabled);
> >         }
> >
> >
> > and
> >
> >         for_each_tracing_cpu(cpu) {
> >                 atomic_dec(&per_cpu_ptr(iter.trace_buffer->data, cpu)->disabled);
> >         }
> >
> > to disable tracing while you do this.  
> 
> Happy to do this in a v4.  I think it's very unlikely to matter
> because we're in kdb and thus all the other CPUs are stopped and
> interrupts are disabled.  ...so unless an NMI adds something to the
> trace buffer in between the two calls the counts will be the same.
> ...but it certainly is cleaner.

NMI's can indeed add to the trace.

> 
> 
> > The get_total_entries() is the faster approach to get the count, but in
> > either case, the count should end up the same.  
> 
> If you're OK with going back to the super slow mechanism in v1 I can
> do that and we can be guaranteed we're consistent.  Presumably it
> can't be _that_ slow because we're going to use the same mechanism to
> skip the lines later.
> 
> So, if you agree, I'll send out a v4 that looks like v1 except that it
> disables / enables tracing directly in kdb_ftdump() so it stays
> disabled for both calls.
> 
> 
> [1] https://lkml.kernel.org/r/20190305233150.159633-1-dianders@chromium.org
> 

But this part of the patch:

> -static void ftrace_dump_buf(int skip_lines, long cpu_file)
> +static int ftrace_dump_buf(int skip_lines, long cpu_file, bool quiet)
>  {
>  	/* use static because iter can be a bit big for the stack */
>  	static struct trace_iterator iter;
> @@ -39,7 +39,9 @@ static void ftrace_dump_buf(int skip_lines, long cpu_file)
>  	/* don't look at user memory in panic mode */
>  	tr->trace_flags &= ~TRACE_ITER_SYM_USEROBJ;
>  
> -	kdb_printf("Dumping ftrace buffer:\n");
> +	if (!quiet)
> +		kdb_printf("Dumping ftrace buffer (skipping %d lines):\n",
> +			   skip_lines);
>  
>  	/* reset all but tr, trace, and overruns */
>  	memset(&iter.seq, 0,
> @@ -66,25 +68,29 @@ static void ftrace_dump_buf(int skip_lines, long cpu_file)
>  	}
>  
>  	while (trace_find_next_entry_inc(&iter)) {
> -		if (!cnt)
> -			kdb_printf("---------------------------------\n");
> -		cnt++;
> -
> -		if (!skip_lines) {
> -			print_trace_line(&iter);
> -			trace_printk_seq(&iter.seq);
> -		} else {
> -			skip_lines--;
> +		if (!quiet) {
> +			if (!cnt)
> +				kdb_printf("---------------------------------\n");
> +
> +			if (!skip_lines) {
> +				print_trace_line(&iter);
> +				trace_printk_seq(&iter.seq);
> +			} else {
> +				skip_lines--;

How do you know that trace_printk_seq() didn't produce more than one line?

If the event is a stack dump, you need to read the seq, and count the
number of '\n' that are added.

The cnt in this code is no different than the get_total_entries() that
I suggested.

Now the really ugly solution is to have:

	print_trace_line(&iter);

	if (quiet || skip_lines) {
		lines = count_all_newlines(&iter.seq);
		if (skip_lines) {
			skip_lines -= lines;
			if (skip_lines < 0)
				skip_lines = 0;
		}
		cnt += lines
	} else (!quiet) {
		trace_printk_seq(&iter.seq);
	}

Where the count_all_newlines() needs to be created to read the seq
buffer and return the number of '\n' that are found.

-- Steve



> +			}
>  		}
> +		cnt++;
>  
>  		if (KDB_FLAG(CMD_INTERRUPT))
>  			goto out;
>  	}
>  
> -	if (!cnt)
> -		kdb_printf("   (ftrace buffer empty)\n");
> -	else
> -		kdb_printf("---------------------------------\n");
> +	if (!quiet) {
> +		if (!cnt)
> +			kdb_printf("   (ftrace buffer empty)\n");
> +		else
> +			kdb_printf("---------------------------------\n");
> +	}
