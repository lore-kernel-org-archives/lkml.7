Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A04C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14FF2133F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfCHPye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 10:54:34 -0500
Received: from foss.arm.com ([217.140.101.70]:60664 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbfCHPye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 10:54:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04EE3A78;
        Fri,  8 Mar 2019 07:54:34 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37A3E3F703;
        Fri,  8 Mar 2019 07:54:32 -0800 (PST)
Date:   Fri, 8 Mar 2019 15:54:29 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, dvyukov@google.com, namhyung@kernel.org,
        xiexiuqi@huawei.com,
        syzbot+a24c397a29ad22d86c98@syzkaller.appspotmail.com
Subject: Re: [RFC PATCH] perf: Paper over the hw.target problems
Message-ID: <20190308155429.GB10860@lakrids.cambridge.arm.com>
References: <278ac311-d8f3-2832-5fa1-522471c8c31c@huawei.com>
 <20190228140109.64238-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228140109.64238-1-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Thu, Feb 28, 2019 at 04:01:09PM +0200, Alexander Shishkin wrote:
> First, we have a race between perf_event_release_kernel() and
> perf_free_event(), which happens when parent's event is released while the
> child's fork fails (because of a fatal signal, for example), that looks
> like this:
> 
> cpu X                            cpu Y
> -----                            -----
>                                  copy_process() error path
> perf_release(parent)             +->perf_event_free_task()
> +-> lock(child_ctx->mutex)       |  |
> +-> remove_from_context(child)   |  |
> +-> unlock(child_ctx->mutex)     |  |
> |                                |  +-> lock(child_ctx->mutex)
> |                                |  +-> unlock(child_ctx->mutex)
> |                                +-> free_task(child_task)
> +-> put_task_struct(child_task)
> 
> Technically, we're still holding a reference to the task via
> parent->hw.target, that's not stopping free_task(), so we end up poking at
> free'd memory, as is pointed out by KASAN in the syzkaller report (see Link
> below). The straightforward fix is to drop the hw.target reference while
> the task is still around.

I've recently started hitting this on arm64, and had come to the same
conclusion.

> Therein lies the second problem: the users of hw.target (uprobe) assume
> that it's around at ->destroy() callback time, where they use it for
> context. So, in order to not break the uprobe teardown and avoid leaking
> stuff, we need to call ->destroy() at the same time.

I had not spotted that case. That's rather horrid. :/

> This patch fixes the race and the subsequent fallout by doing both these
> things at remove_from_context time.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Link: https://syzkaller.appspot.com/bug?extid=a24c397a29ad22d86c98
> Reported-by: syzbot+a24c397a29ad22d86c98@syzkaller.appspotmail.com
> ---
>  kernel/events/core.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 36b8320590e8..640695d114f8 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2105,6 +2105,27 @@ static void perf_remove_from_context(struct perf_event *event, unsigned long fla
>  
>  	event_function_call(event, __perf_remove_from_context, (void *)flags);
>  
> +	/*
> +	 * This is as passable as any hw.target handling out there;
> +	 * hw.target implies task context, therefore, no migration.
> +	 * Which means that we can only get here at the teardown.
> +	 */
> +	if (event->hw.target) {
> +		/*
> +		 * Now, the problem with, say uprobes, is that they
> +		 * use hw.target for context in their ->destroy()
> +		 * callbacks. Supposedly, they may need to poke at
> +		 * its contents, so better call it while we still
> +		 * have the task.
> +		 */
> +		if (event->destroy) {
> +			event->destroy(event);
> +			event->destroy = NULL;
> +		}
> +		put_task_struct(event->hw.target);
> +		event->hw.target = NULL;
> +	}

We also use perf_remove_from_context() in perf_event_open() when we move
events from a SW context to a HW context, so we can't destroy the event
here.

I think we need something more like the below (untested), but I fear
that it's not safe to call perf_event::destroy() in this context.

Thanks,
Mark.

---->8----
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 26d6edab051a..b32f2cac5563 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4532,6 +4532,24 @@ static void put_event(struct perf_event *event)
        _free_event(event);
 }
 
+void perf_event_detach_target(struct perf_event *event)
+{
+       if (!event->hw.target)
+               return;
+
+       /*
+        * The uprobes perf_event::destroy() callback needs the target, so call
+        * that while the target is still valid.
+        */
+       if (event->destroy) {
+               event->destroy(event);
+               event->destroy = NULL;
+       }
+
+       put_task_struct(event->hw.target);
+       event->hw.target = NULL;
+}
+
 /*
  * Kill an event dead; while event:refcount will preserve the event
  * object, it will not preserve its functionality. Once the last 'user'
@@ -4559,6 +4577,7 @@ int perf_event_release_kernel(struct perf_event *event)
        ctx = perf_event_ctx_lock(event);
        WARN_ON_ONCE(ctx->parent_ctx);
        perf_remove_from_context(event, DETACH_GROUP);
+       perf_event_detach_target(event);
 
        raw_spin_lock_irq(&ctx->lock);
        /*
@@ -4614,6 +4633,7 @@ int perf_event_release_kernel(struct perf_event *event)
                                               struct perf_event, child_list);
                if (tmp == child) {
                        perf_remove_from_context(child, DETACH_GROUP);
+                       perf_event_detach_target(child);
                        list_move(&child->child_list, &free_list);
                        /*
                         * This matches the refcount bump in inherit_event();
 
