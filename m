Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8192C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40A9218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfCOSle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 14:41:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfCOSld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 14:41:33 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E44D218A1;
        Fri, 15 Mar 2019 18:41:32 +0000 (UTC)
Date:   Fri, 15 Mar 2019 14:41:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Brian Norris <briannorris@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tracing: kdb: Allow ftdump to skip all but the last
 few lines
Message-ID: <20190315144130.1aa36931@gandalf.local.home>
In-Reply-To: <20190315174528.16531-1-dianders@chromium.org>
References: <20190315174528.16531-1-dianders@chromium.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019 10:45:28 -0700
Douglas Anderson <dianders@chromium.org> wrote:


> Changes in v3:
> - Optimize counting as per Steven Rostedt.
> - Down to 1 patch since patch #1 from v2 landed.
> 
>  kernel/trace/trace_kdb.c | 38 +++++++++++++++++++++++++++++---------
>  1 file changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
> index 810d78a8d14c..cc6ca6c0d6de 100644
> --- a/kernel/trace/trace_kdb.c
> +++ b/kernel/trace/trace_kdb.c
> @@ -17,7 +17,7 @@
>  #include "trace.h"
>  #include "trace_output.h"
>  
> -static void ftrace_dump_buf(int skip_lines, long cpu_file)
> +static int ftrace_dump_buf(int skip_lines, long cpu_file, bool quiet)

Not quite what I wanted you to do.


>  {
>  	/* use static because iter can be a bit big for the stack */
>  	static struct trace_iterator iter;
> @@ -39,8 +39,6 @@ static void ftrace_dump_buf(int skip_lines, long cpu_file)
>  	/* don't look at user memory in panic mode */
>  	tr->trace_flags &= ~TRACE_ITER_SYM_USEROBJ;
>  
> -	kdb_printf("Dumping ftrace buffer:\n");
> -
>  	/* reset all but tr, trace, and overruns */
>  	memset(&iter.seq, 0,
>  		   sizeof(struct trace_iterator) -
> @@ -55,6 +53,9 @@ static void ftrace_dump_buf(int skip_lines, long cpu_file)
>  						 cpu, GFP_ATOMIC);
>  			ring_buffer_read_start(iter.buffer_iter[cpu]);
>  			tracing_iter_reset(&iter, cpu);
> +
> +			cnt +=
> +			ring_buffer_entries_cpu(iter.trace_buffer->buffer, cpu);

BTW, 80 char limit is a guideline not a rule. Don't break a line to
make it look worse. But that doesn't matter because this isn't the
change I meant.

>  		}
>  	} else {
>  		iter.cpu_file = cpu_file;
> @@ -63,13 +64,21 @@ static void ftrace_dump_buf(int skip_lines, long cpu_file)
>  						 cpu_file, GFP_ATOMIC);
>  		ring_buffer_read_start(iter.buffer_iter[cpu_file]);
>  		tracing_iter_reset(&iter, cpu_file);
> +
> +		cnt += ring_buffer_entries_cpu(iter.trace_buffer->buffer,
> +					       cpu_file);
>  	}
>  
> -	while (trace_find_next_entry_inc(&iter)) {
> -		if (!cnt)
> -			kdb_printf("---------------------------------\n");
> -		cnt++;
> +	if (quiet)
> +		goto out;
> +
> +	kdb_printf("Dumping ftrace buffer (skipping %d lines):\n",
> +		   skip_lines);
> +
> +	if (cnt)
> +		kdb_printf("---------------------------------\n");
>  
> +	while (trace_find_next_entry_inc(&iter)) {
>  		if (!skip_lines) {
>  			print_trace_line(&iter);
>  			trace_printk_seq(&iter.seq);
> @@ -99,6 +108,8 @@ static void ftrace_dump_buf(int skip_lines, long cpu_file)
>  			iter.buffer_iter[cpu] = NULL;
>  		}
>  	}
> +
> +	return cnt;
>  }
>  
>  /*
> @@ -109,6 +120,7 @@ static int kdb_ftdump(int argc, const char **argv)
>  	int skip_lines = 0;
>  	long cpu_file;
>  	char *cp;
> +	int cnt;
>  
>  	if (argc > 2)
>  		return KDB_ARGCOUNT;
> @@ -129,7 +141,14 @@ static int kdb_ftdump(int argc, const char **argv)
>  	}
>  
>  	kdb_trap_printk++;
> -	ftrace_dump_buf(skip_lines, cpu_file);
> +
> +	/* A negative skip_lines means skip all but the last lines */
> +	if (skip_lines < 0) {
> +		cnt = ftrace_dump_buf(0, cpu_file, true);

Actually, you can add a function in trace.c that exposes
get_total_entries:

unsigned long trace_total_entries(struct trace_array *tr)
{
	unsigned long total, entries;

	if (!tr)
		tr = &global_trace;

	get_total_entries(tr->trace_buffer, &total, &entries);

	return entries;
}

and then do:
		cnt = trace_total_entries(NULL);

Don't modify ftrace_dump_buf()

-- Steve

> +		skip_lines = max(cnt + skip_lines, 0);
> +	}
> +
> +	ftrace_dump_buf(skip_lines, cpu_file, false);
>  	kdb_trap_printk--;
>  
>  	return 0;
> @@ -138,7 +157,8 @@ static int kdb_ftdump(int argc, const char **argv)
>  static __init int kdb_ftrace_register(void)
>  {
>  	kdb_register_flags("ftdump", kdb_ftdump, "[skip_#lines] [cpu]",
> -			    "Dump ftrace log", 0, KDB_ENABLE_ALWAYS_SAFE);
> +			    "Dump ftrace log; -skip dumps last #lines", 0,
> +			    KDB_ENABLE_ALWAYS_SAFE);
>  	return 0;
>  }
>  

