Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D5EECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 23:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D10421479
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 23:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570491268;
	bh=fN7qSYliVkwX4jJrS1kU+LcEhjuHRlhE+ua1+TXs/Ig=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=FAzS/53L70/1fPjqPGZ7O4ObcWUBQwpabnmVOYyJYxHLn9TMoc4spZpQp1jBQixu2
	 S75MCowMA9ayknbZ0S6EUEGnlxk27Wasg057V4UntzFhckFOKrNxwU2fFSeYCeGKNe
	 8x7HBH2XEQZKK/Z6JnAqq5zYeKCVRfctozMgwlNs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbfJGXe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 19:34:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729252AbfJGXe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 19:34:26 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEC2C20867;
        Mon,  7 Oct 2019 23:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570491265;
        bh=fN7qSYliVkwX4jJrS1kU+LcEhjuHRlhE+ua1+TXs/Ig=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OaiL2kd77aI/CXJyFEilk3+k8IKyFNY8Gqes8VJbqvvZlbVb14y81pjVkYHiFw4Td
         2zllzJ5wpE0ZXrstMsexJJsxg3lurTL2pkxEZU7ABQINDrT45LFeqrPsGJ86v0R7Jl
         Gok0KDsse7ghyLOz9rwMiaWeyPksrYUcRRMLiQvM=
Date:   Tue, 8 Oct 2019 08:34:20 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>, <dxu@fb.com>,
        <hall@fb.com>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] perf/kprobe: maxactive for fd-based kprobe (pmu
 perf_kprobe)
Message-Id: <20191008083420.cecebd6afdf5c34074565195@kernel.org>
In-Reply-To: <20191007223111.1142454-1-songliubraving@fb.com>
References: <20191007223111.1142454-1-songliubraving@fb.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 7 Oct 2019 15:31:11 -0700
Song Liu <songliubraving@fb.com> wrote:

> Enable specifying maxactive for fd based kretprobe. This will be useful
> for tracing tools like bcc and bpftrace. [1] discussed the need of this
> in bpftrace. Use highest highest 12 bit (bit 52-63) to allow maximal
> maxactive of 4095.
> 
> [1] https://github.com/iovisor/bpftrace/issues/835

From the view point of trace_kprobe, this looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/trace_events.h    |  3 ++-
>  kernel/events/core.c            | 20 ++++++++++++++++----
>  kernel/trace/trace_event_perf.c |  5 +++--
>  kernel/trace/trace_kprobe.c     |  4 ++--
>  kernel/trace/trace_probe.h      |  2 +-
>  5 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 30a8cdcfd4a4..706d515d2b5e 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -581,7 +581,8 @@ extern void perf_trace_destroy(struct perf_event *event);
>  extern int  perf_trace_add(struct perf_event *event, int flags);
>  extern void perf_trace_del(struct perf_event *event, int flags);
>  #ifdef CONFIG_KPROBE_EVENTS
> -extern int  perf_kprobe_init(struct perf_event *event, bool is_retprobe);
> +extern int  perf_kprobe_init(struct perf_event *event, bool is_retprobe,
> +			     int max_active);
>  extern void perf_kprobe_destroy(struct perf_event *event);
>  extern int bpf_get_kprobe_info(const struct perf_event *event,
>  			       u32 *fd_type, const char **symbol,
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 3f0cb82e4fbc..f1b16cda5a9b 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8772,24 +8772,34 @@ static struct pmu perf_tracepoint = {
>   * PERF_PROBE_CONFIG_IS_RETPROBE if set, create kretprobe/uretprobe
>   *                               if not set, create kprobe/uprobe
>   *
> - * The following values specify a reference counter (or semaphore in the
> - * terminology of tools like dtrace, systemtap, etc.) Userspace Statically
> - * Defined Tracepoints (USDT). Currently, we use 40 bit for the offset.
> + * PERF_UPROBE_REF_CTR_OFFSET_* specify a reference counter (or semaphore
> + * in the terminology of tools like dtrace, systemtap, etc.) Userspace
> + * Statically Defined Tracepoints (USDT). Currently, we use 40 bit for the
> + * offset.
>   *
>   * PERF_UPROBE_REF_CTR_OFFSET_BITS	# of bits in config as th offset
>   * PERF_UPROBE_REF_CTR_OFFSET_SHIFT	# of bits to shift left
> + *
> + * PERF_KPROBE_MAX_ACTIVE_* defines max_active for kretprobe.
> + * KRETPROBE_MAXACTIVE_MAX is 4096. We allow 4095 here to save a bit.
>   */
>  enum perf_probe_config {
>  	PERF_PROBE_CONFIG_IS_RETPROBE = 1U << 0,  /* [k,u]retprobe */
>  	PERF_UPROBE_REF_CTR_OFFSET_BITS = 32,
>  	PERF_UPROBE_REF_CTR_OFFSET_SHIFT = 64 - PERF_UPROBE_REF_CTR_OFFSET_BITS,
> +	PERF_KPROBE_MAX_ACTIVE_BITS = 12,
> +	PERF_KPROBE_MAX_ACTIVE_SHIFT = 64 - PERF_KPROBE_MAX_ACTIVE_BITS,
>  };
>  
>  PMU_FORMAT_ATTR(retprobe, "config:0");
>  #endif
>  
>  #ifdef CONFIG_KPROBE_EVENTS
> +/* KRETPROBE_MAXACTIVE_MAX is 4096, only allow 4095 here to save a bit */
> +PMU_FORMAT_ATTR(max_active, "config:52-63");
> +
>  static struct attribute *kprobe_attrs[] = {
> +	&format_attr_max_active.attr,
>  	&format_attr_retprobe.attr,
>  	NULL,
>  };
> @@ -8820,6 +8830,7 @@ static int perf_kprobe_event_init(struct perf_event *event)
>  {
>  	int err;
>  	bool is_retprobe;
> +	int max_active;
>  
>  	if (event->attr.type != perf_kprobe.type)
>  		return -ENOENT;
> @@ -8834,7 +8845,8 @@ static int perf_kprobe_event_init(struct perf_event *event)
>  		return -EOPNOTSUPP;
>  
>  	is_retprobe = event->attr.config & PERF_PROBE_CONFIG_IS_RETPROBE;
> -	err = perf_kprobe_init(event, is_retprobe);
> +	max_active = event->attr.config >> PERF_KPROBE_MAX_ACTIVE_SHIFT;
> +	err = perf_kprobe_init(event, is_retprobe, max_active);
>  	if (err)
>  		return err;
>  
> diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
> index 0892e38ed6fb..da6744ac7bc9 100644
> --- a/kernel/trace/trace_event_perf.c
> +++ b/kernel/trace/trace_event_perf.c
> @@ -240,7 +240,8 @@ void perf_trace_destroy(struct perf_event *p_event)
>  }
>  
>  #ifdef CONFIG_KPROBE_EVENTS
> -int perf_kprobe_init(struct perf_event *p_event, bool is_retprobe)
> +int perf_kprobe_init(struct perf_event *p_event, bool is_retprobe,
> +		     int max_active)
>  {
>  	int ret;
>  	char *func = NULL;
> @@ -266,7 +267,7 @@ int perf_kprobe_init(struct perf_event *p_event, bool is_retprobe)
>  
>  	tp_event = create_local_trace_kprobe(
>  		func, (void *)(unsigned long)(p_event->attr.kprobe_addr),
> -		p_event->attr.probe_offset, is_retprobe);
> +		p_event->attr.probe_offset, is_retprobe, max_active);
>  	if (IS_ERR(tp_event)) {
>  		ret = PTR_ERR(tp_event);
>  		goto out;
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 324ffbea3556..12088a76e7da 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -1556,7 +1556,7 @@ static int unregister_kprobe_event(struct trace_kprobe *tk)
>  /* create a trace_kprobe, but don't add it to global lists */
>  struct trace_event_call *
>  create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
> -			  bool is_return)
> +			  bool is_return, int max_active)
>  {
>  	struct trace_kprobe *tk;
>  	int ret;
> @@ -1570,7 +1570,7 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
>  	event = func ? func : "DUMMY_EVENT";
>  
>  	tk = alloc_trace_kprobe(KPROBE_EVENT_SYSTEM, event, (void *)addr, func,
> -				offs, 0 /* maxactive */, 0 /* nargs */,
> +				offs, max_active, 0 /* nargs */,
>  				is_return);
>  
>  	if (IS_ERR(tk)) {
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 4ee703728aec..b4368c652749 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -373,7 +373,7 @@ extern int traceprobe_set_print_fmt(struct trace_probe *tp, bool is_return);
>  #ifdef CONFIG_PERF_EVENTS
>  extern struct trace_event_call *
>  create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
> -			  bool is_return);
> +			  bool is_return, int max_active);
>  extern void destroy_local_trace_kprobe(struct trace_event_call *event_call);
>  
>  extern struct trace_event_call *
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
