Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8722C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 01:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B787D2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 01:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfFRB4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 21:56:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbfFRB4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 21:56:47 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A8462080C;
        Tue, 18 Jun 2019 01:56:45 +0000 (UTC)
Date:   Mon, 17 Jun 2019 21:56:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 10/21] tracing/probe: Split trace_event related data
 from trace_probe
Message-ID: <20190617215643.05a33541@oasis.local.home>
In-Reply-To: <155931589667.28323.6107724588059072406.stgit@devnote2>
References: <155931578555.28323.16360245959211149678.stgit@devnote2>
        <155931589667.28323.6107724588059072406.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  1 Jun 2019 00:18:16 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Split the trace_event related data from trace_probe data structure
> and introduce trace_probe_event data structure for its folder.
> This trace_probe_event data structure can have multiple trace_probe.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_kprobe.c |   99 ++++++++++++++++++++++-------------
>  kernel/trace/trace_probe.c  |   53 +++++++++++++------
>  kernel/trace/trace_probe.h  |   48 +++++++++++++----
>  kernel/trace/trace_uprobe.c |  123 +++++++++++++++++++++++++++++--------------
>  4 files changed, 221 insertions(+), 102 deletions(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 9d483ad9bb6c..633edb88cd0e 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -180,9 +180,17 @@ unsigned long trace_kprobe_address(struct trace_kprobe *tk)
>  	return addr;
>  }
>  
> +static nokprobe_inline struct trace_kprobe *
> +trace_kprobe_primary_from_call(struct trace_event_call *call)
> +{
> +	struct trace_probe *tp = trace_probe_primary_from_call(call);
> +
> +	return container_of(tp, struct trace_kprobe, tp);


Hmm, is there a possibility that trace_probe_primary_from_call() may
not have a primary?


> +}
> +
>  bool trace_kprobe_on_func_entry(struct trace_event_call *call)
>  {
> -	struct trace_kprobe *tk = (struct trace_kprobe *)call->data;
> +	struct trace_kprobe *tk = trace_kprobe_primary_from_call(call);
>  
>  	return kprobe_on_func_entry(tk->rp.kp.addr,
>  			tk->rp.kp.addr ? NULL : tk->rp.kp.symbol_name,
> @@ -191,7 +199,7 @@ bool trace_kprobe_on_func_entry(struct trace_event_call *call)
>  
>  bool trace_kprobe_error_injectable(struct trace_event_call *call)
>  {
> -	struct trace_kprobe *tk = (struct trace_kprobe *)call->data;
> +	struct trace_kprobe *tk = trace_kprobe_primary_from_call(call);
>  
>  	return within_error_injection_list(trace_kprobe_address(tk));
>  }
> @@ -295,28 +303,40 @@ static inline int __enable_trace_kprobe(struct trace_kprobe *tk)
>   * Enable trace_probe
>   * if the file is NULL, enable "perf" handler, or enable "trace" handler.
>   */
> -static int
> -enable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
> +static int enable_trace_kprobe(struct trace_event_call *call,
> +				struct trace_event_file *file)
>  {
> -	bool enabled = trace_probe_is_enabled(&tk->tp);
> -	int ret = 0;
> +	struct trace_probe *pos, *tp = trace_probe_primary_from_call(call);
> +	struct trace_kprobe *tk;
> +	bool enabled = trace_probe_is_enabled(tp);
> +	int ret = 0, ecode;
>  
>  	if (file) {
> -		ret = trace_probe_add_file(&tk->tp, file);
> +		ret = trace_probe_add_file(tp, file);
>  		if (ret)
>  			return ret;
>  	} else
> -		trace_probe_set_flag(&tk->tp, TP_FLAG_PROFILE);
> +		trace_probe_set_flag(tp, TP_FLAG_PROFILE);
>  
>  	if (enabled)
>  		return 0;
>  
> -	ret = __enable_trace_kprobe(tk);
> -	if (ret) {
> +	enabled = false;
> +	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
> +		tk = container_of(pos, struct trace_kprobe, tp);
> +		ecode = __enable_trace_kprobe(tk);
> +		if (ecode)
> +			ret = ecode;	/* Save the last error code */
> +		else
> +			enabled = true;

So, if we have some enabled but return an error code, what should a
caller think of that? Wouldn't it be an inconsistent state?

-- Steve


> +	}
> +
> +	if (!enabled) {
> +		/* No probe is enabled. Roll back */
>  		if (file)
> -			trace_probe_remove_file(&tk->tp, file);
> +			trace_probe_remove_file(tp, file);
>  		else
> -			trace_probe_clear_flag(&tk->tp, TP_FLAG_PROFILE);
> +			trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
>  	}
>  
>


> +static inline struct trace_probe_event *
> +trace_probe_event_from_call(struct trace_event_call *event_call)
> +{
> +	return container_of(event_call, struct trace_probe_event, call);
> +}
> +
> +static inline struct trace_probe *
> +trace_probe_primary_from_call(struct trace_event_call *call)
> +{
> +	struct trace_probe_event *tpe = trace_probe_event_from_call(call);
> +
> +	return list_first_entry(&tpe->probes, struct trace_probe, list);
> +}
> +
> +static inline struct list_head *trace_probe_probe_list(struct trace_probe *tp)
> +{
> +	return &tp->event->probes;
>  }
>  
