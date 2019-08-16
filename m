Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA57C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 16:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB452171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 16:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfHPQZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 12:25:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfHPQZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 12:25:46 -0400
Received: from oasis.local.home (rrcs-76-79-140-27.west.biz.rr.com [76.79.140.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04F3320665;
        Fri, 16 Aug 2019 16:25:44 +0000 (UTC)
Date:   Fri, 16 Aug 2019 12:25:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
Message-ID: <20190816122539.34fada7b@oasis.local.home>
In-Reply-To: <20190816142643.13758-1-mathieu.desnoyers@efficios.com>
References: <00000000000076ecf3059030d3f1@google.com>
        <20190816142643.13758-1-mathieu.desnoyers@efficios.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2019 10:26:43 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Reading the sched_cmdline_ref and sched_tgid_ref initial state within
> tracing_start_sched_switch without holding the sched_register_mutex is
> racy against concurrent updates, which can lead to tracepoint probes
> being registered more than once (and thus trigger warnings within
> tracepoint.c).
> 
> Also, write and read to/from those variables should be done with
> WRITE_ONCE() and READ_ONCE(), given that those are read within tracing
> probes without holding the sched_register_mutex.
> 

I understand the READ_ONCE() but is the WRITE_ONCE() truly necessary?
It's done while holding the mutex. It's not that critical of a path,
and makes the code look ugly.

-- Steve



> [ Compile-tested only. I suspect it might fix the following syzbot
>   report:
> 
>   syzbot+774fddf07b7ab29a1e55@syzkaller.appspotmail.com ]
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> CC: Joel Fernandes (Google) <joel@joelfernandes.org>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Steven Rostedt (VMware) <rostedt@goodmis.org>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Paul E. McKenney <paulmck@linux.ibm.com>
> ---
>  kernel/trace/trace_sched_switch.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
> index e288168661e1..902e8bf59aeb 100644
> --- a/kernel/trace/trace_sched_switch.c
> +++ b/kernel/trace/trace_sched_switch.c
> @@ -26,8 +26,8 @@ probe_sched_switch(void *ignore, bool preempt,
>  {
>  	int flags;
>  
> -	flags = (RECORD_TGID * !!sched_tgid_ref) +
> -		(RECORD_CMDLINE * !!sched_cmdline_ref);
> +	flags = (RECORD_TGID * !!READ_ONCE(sched_tgid_ref)) +
> +		(RECORD_CMDLINE * !!READ_ONCE(sched_cmdline_ref));
>  
>  	if (!flags)
>  		return;
> @@ -39,8 +39,8 @@ probe_sched_wakeup(void *ignore, struct task_struct *wakee)
>  {
>  	int flags;
>  
> -	flags = (RECORD_TGID * !!sched_tgid_ref) +
> -		(RECORD_CMDLINE * !!sched_cmdline_ref);
> +	flags = (RECORD_TGID * !!READ_ONCE(sched_tgid_ref)) +
> +		(RECORD_CMDLINE * !!READ_ONCE(sched_cmdline_ref));
>  
>  	if (!flags)
>  		return;
> @@ -89,21 +89,28 @@ static void tracing_sched_unregister(void)
>  
>  static void tracing_start_sched_switch(int ops)
>  {
> -	bool sched_register = (!sched_cmdline_ref && !sched_tgid_ref);
> +	bool sched_register;
> +
>  	mutex_lock(&sched_register_mutex);
> +	sched_register = (!sched_cmdline_ref && !sched_tgid_ref);
>  
>  	switch (ops) {
>  	case RECORD_CMDLINE:
> -		sched_cmdline_ref++;
> +		WRITE_ONCE(sched_cmdline_ref, sched_cmdline_ref + 1);
>  		break;
>  
>  	case RECORD_TGID:
> -		sched_tgid_ref++;
> +		WRITE_ONCE(sched_tgid_ref, sched_tgid_ref + 1);
>  		break;
> +
> +	default:
> +		WARN_ONCE(1, "Unsupported tracing op: %d", ops);
> +		goto end;
>  	}
>  
> -	if (sched_register && (sched_cmdline_ref || sched_tgid_ref))
> +	if (sched_register)
>  		tracing_sched_register();
> +end:
>  	mutex_unlock(&sched_register_mutex);
>  }
>  
> @@ -113,16 +120,21 @@ static void tracing_stop_sched_switch(int ops)
>  
>  	switch (ops) {
>  	case RECORD_CMDLINE:
> -		sched_cmdline_ref--;
> +		WRITE_ONCE(sched_cmdline_ref, sched_cmdline_ref - 1);
>  		break;
>  
>  	case RECORD_TGID:
> -		sched_tgid_ref--;
> +		WRITE_ONCE(sched_tgid_ref, sched_tgid_ref - 1);
>  		break;
> +
> +	default:
> +		WARN_ONCE(1, "Unsupported tracing op: %d", ops);
> +		goto end;
>  	}
>  
>  	if (!sched_cmdline_ref && !sched_tgid_ref)
>  		tracing_sched_unregister();
> +end:
>  	mutex_unlock(&sched_register_mutex);
>  }
>  

