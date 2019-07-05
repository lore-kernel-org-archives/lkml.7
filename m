Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992B5C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 14:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7612A20828
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 14:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfGEONR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 10:13:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59526 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbfGEONQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 10:13:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9DF9B3082135;
        Fri,  5 Jul 2019 14:13:11 +0000 (UTC)
Received: from krava (unknown [10.43.17.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id B97B782297;
        Fri,  5 Jul 2019 14:13:06 +0000 (UTC)
Date:   Fri, 5 Jul 2019 16:13:06 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/7] perf: propagate perf_install_in_context errors up
Message-ID: <20190705141306.GB10777@krava>
References: <20190702065955.165738-1-irogers@google.com>
 <20190702065955.165738-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702065955.165738-2-irogers@google.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 05 Jul 2019 14:13:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 11:59:49PM -0700, Ian Rogers wrote:
> The current __perf_install_in_context can fail and the error is ignored.
> Changing __perf_install_in_context can add new failure modes that need
> errors propagating up. This change prepares for this.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  kernel/events/core.c | 38 +++++++++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 785d708f8553..4faa90f5a934 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2558,11 +2558,12 @@ static int  __perf_install_in_context(void *info)
>   *
>   * Very similar to event_function_call, see comment there.
>   */
> -static void
> +static int
>  perf_install_in_context(struct perf_event_context *ctx,
>  			struct perf_event *event,
>  			int cpu)
>  {
> +	int err;
>  	struct task_struct *task = READ_ONCE(ctx->task);
>  
>  	lockdep_assert_held(&ctx->mutex);
> @@ -2577,15 +2578,15 @@ perf_install_in_context(struct perf_event_context *ctx,
>  	smp_store_release(&event->ctx, ctx);
>  
>  	if (!task) {
> -		cpu_function_call(cpu, __perf_install_in_context, event);
> -		return;
> +		err = cpu_function_call(cpu, __perf_install_in_context, event);
> +		return err;
>  	}
>  
>  	/*
>  	 * Should not happen, we validate the ctx is still alive before calling.
>  	 */
>  	if (WARN_ON_ONCE(task == TASK_TOMBSTONE))
> -		return;
> +		return 0;
>  
>  	/*
>  	 * Installing events is tricky because we cannot rely on ctx->is_active
> @@ -2619,8 +2620,9 @@ perf_install_in_context(struct perf_event_context *ctx,
>  	 */
>  	smp_mb();
>  again:
> -	if (!task_function_call(task, __perf_install_in_context, event))
> -		return;
> +	err = task_function_call(task, __perf_install_in_context, event);
> +	if (err)
> +		return err;

you need to return in here if task_function_call succeeds and
continue in case of error, not the other way round, otherwise
bad things will happen ;-)

jirka

>  
>  	raw_spin_lock_irq(&ctx->lock);
>  	task = ctx->task;
> @@ -2631,7 +2633,7 @@ perf_install_in_context(struct perf_event_context *ctx,
>  		 * against perf_event_exit_task_context().
>  		 */
>  		raw_spin_unlock_irq(&ctx->lock);
> -		return;
> +		return 0;
>  	}
>  	/*
>  	 * If the task is not running, ctx->lock will avoid it becoming so,
> @@ -2643,6 +2645,7 @@ perf_install_in_context(struct perf_event_context *ctx,
>  	}
>  	add_event_to_ctx(event, ctx);
>  	raw_spin_unlock_irq(&ctx->lock);
> +	return 0;
>  }
>  
>  /*

SNIP
