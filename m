Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71784CA9EB3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A7721D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wWvUFiMD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503839AbfJRA3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:29:22 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:39698 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406927AbfJRA2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:28:41 -0400
Received: by mail-pg1-f202.google.com with SMTP id m20so3021626pgv.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=j+5h8tQfMwxRzPWa0YsZn6CHewLhXavyhIU1GNL2cCg=;
        b=wWvUFiMDL+FpAEBvOeSh92Ok6NrnP0bMly0DvcbnIEwAXgGMsFpdxjlNZIkHJTYYBa
         RRx649P7sqiPze6DlRwJOUwwuFezLRxr6AueTJGVgGsRuHZqUR62pVBaDH5dw3oVDwJF
         cqz06TfsdUQqKYWYzqCu1qGrSGJTcxPYv4FciDQIqqO3PIW4m2UzT+g4IwApY3LkDK0H
         UzSRCzIapr1rLvg4twVJwpwLGQFu0MzEemzo/jZzvekhF3dWx3g2K2T5lXemO6XXF183
         DSve4IVI9m4PDbMg8OfAlO424FgA0MXzf8aoQb3/3dDlHQPqUPbovQfJUZyE+fNef8pE
         aqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=j+5h8tQfMwxRzPWa0YsZn6CHewLhXavyhIU1GNL2cCg=;
        b=S3e+uEg95ajtwW76FKX+2LqAPGDrEBxh3YkwKr2gpOirVzvD0FZa7LECl1i/XEnR+3
         GirzjtfiWjEoW9yUu8fVFZT3u4XYXfnikrmveSdATOtpJam83LqzFCetEVyA9+TcoLqU
         8RvKQKBf8OeIgcoQHr3MHucLadm2DTdpy50+1MldQ3FIPvBpB+PsbYEFjFrQvKjaSs8f
         26RMtYtxSs99WlPL5EhkIELW2Eyb9YtHJMbrXCMKKH/ASSRgbPLVZg8oNeIY+3cBvqa5
         YzyqWalEu6vjH7u6iw3C8Gu+Fayqyt1WQyNXxhBnvc3WrJasc87b4kp1miACKuu4SZyn
         O5BA==
X-Gm-Message-State: APjAAAWBPWiSmSUI4T+Mx3GBR/w8a+XAO72kObBHHdo0NXD5Gy0IH8y+
        1mg9UmYn+IGVIvA8RIDGPQ7eBevZW/FOUPhC8lysEJt2e3l88330Z5YvF7BaKJ0rqXheLfwnWgL
        EfJZsPg2eIFhK3eMWGQeuUa+ujAx9+t+UPHAlu4toXjfWi49EmG9lE/bULVGyZtZiXQqh5Ika
X-Google-Smtp-Source: APXvYqwu1mc92nD1BJySLwigscmIoAcEQnImRqxXgGASAaAf5eB9ASrZf51xyyOQBtOzwJXz7u15Vnj3MRI+
X-Received: by 2002:a63:131b:: with SMTP id i27mr6927200pgl.209.1571358518957;
 Thu, 17 Oct 2019 17:28:38 -0700 (PDT)
Date:   Thu, 17 Oct 2019 17:27:46 -0700
Message-Id: <20191018002746.149200-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH] perf/core: fix multiplexing event scheduling issue
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@elte.hu, acme@redhat.com,
        jolsa@redhat.com, kan.liang@intel.com, songliubraving@fb.com,
        irogers@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch complements the following commit:
7fa343b7fdc4 ("perf/core: Fix corner case in perf_rotate_context()")

The fix from Song addresses the consequences of the problem but
not the cause. This patch fixes the causes and can sit on top of
Song's patch.

This patch fixes a scheduling problem in the core functions of
perf_events. Under certain conditions, some events would not be
scheduled even though many counters would be available. This
is related to multiplexing and is architecture agnostic and
PMU agnostic (i.e., core or uncore).

This problem can easily be reproduced when you have two perf
stat sessions. The first session does not cause multiplexing,
let's say it is measuring 1 event, E1. While it is measuring,
a second session starts and causes multiplexing. Let's say it
adds 6 events, B1-B6. Now, 7 events compete and are multiplexed.
When the second session terminates, all 6 (B1-B6) events are
removed. Normally, you'd expect the E1 event to continue to run
with no multiplexing. However, the problem is that depending on
the state Of E1 when B1-B6 are removed, it may never be scheduled
again. If E1 was inactive at the time of removal, despite the
multiplexing hrtimer still firing, it will not find any active
events and will not try to reschedule. This is what Song's patch
fixes. It forces the multiplexing code to consider non-active events.
However, the cause is not addressed. The kernel should not rely on
the multiplexing hrtimer to unblock inactive events. That timer
can have abitrary duration in the milliseconds. Until the timer
fires, counters are available, but no measurable events are using
them. We do not want to introduce blind spots of arbitrary durations.

This patch addresses the cause of the problem, by checking that,
when an event is disabled or removed and the context was multiplexing
events, inactive events gets immediately a chance to be scheduled by
calling ctx_resched(). The rescheduling is done on  event of equal
or lower priority types.  With that in place, as soon as a counter
is freed, schedulable inactive events may run, thereby eliminating
a blind spot.

This can be illustrated as follows using Skylake uncore CHA here:

$ perf stat --no-merge -a -I 1000 -C 28 -e uncore_cha_0/event=0x0/
    42.007856531      2,000,291,322      uncore_cha_0/event=0x0/
    43.008062166      2,000,399,526      uncore_cha_0/event=0x0/
    44.008293244      2,000,473,720      uncore_cha_0/event=0x0/
    45.008501847      2,000,423,420      uncore_cha_0/event=0x0/
    46.008706558      2,000,411,132      uncore_cha_0/event=0x0/
    47.008928543      2,000,441,660      uncore_cha_0/event=0x0/

Adding second sessiont with 4 events for 4s

$ perf stat -a -I 1000 -C 28 --no-merge -e uncore_cha_0/event=0x0/,uncore_cha_0/event=0x0/,uncore_cha_0/event=0x0/,uncore_cha_0/event=0x0/ sleep 4
    48.009114643      1,983,129,830      uncore_cha_0/event=0x0/                                       (99.71%)
    49.009279616      1,976,067,751      uncore_cha_0/event=0x0/                                       (99.30%)
    50.009428660      1,974,448,006      uncore_cha_0/event=0x0/                                       (98.92%)
    51.009524309      1,973,083,237      uncore_cha_0/event=0x0/                                       (98.55%)
    52.009673467      1,972,097,678      uncore_cha_0/event=0x0/                                       (97.11%)

End of 4s, second session is removed. But the first event does not schedule and never will
unless new events force multiplexing again.

    53.009815999      <not counted>      uncore_cha_0/event=0x0/                                       (95.28%)
    54.009961809      <not counted>      uncore_cha_0/event=0x0/                                       (93.52%)
    55.010110972      <not counted>      uncore_cha_0/event=0x0/                                       (91.82%)
    56.010217579      <not counted>      uncore_cha_0/event=0x0/                                       (90.18%)

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 kernel/events/core.c | 67 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9ec0b0bfddbd..578587246ffb 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2140,6 +2140,10 @@ group_sched_out(struct perf_event *group_event,
 
 #define DETACH_GROUP	0x01UL
 
+static void ctx_resched(struct perf_cpu_context *cpuctx,
+			struct perf_event_context *task_ctx,
+			enum event_type_t event_type);
+
 /*
  * Cross CPU call to remove a performance event
  *
@@ -2153,6 +2157,7 @@ __perf_remove_from_context(struct perf_event *event,
 			   void *info)
 {
 	unsigned long flags = (unsigned long)info;
+	int was_necessary = ctx->rotate_necessary;
 
 	if (ctx->is_active & EVENT_TIME) {
 		update_context_time(ctx);
@@ -2171,6 +2176,37 @@ __perf_remove_from_context(struct perf_event *event,
 			cpuctx->task_ctx = NULL;
 		}
 	}
+
+	/*
+	 * sanity check that event_sched_out() does not and will not
+	 * change the state of ctx->rotate_necessary
+	 */
+	WARN_ON(was_necessary != event->ctx->rotate_necessary);
+	/*
+	 * if we remove an event AND we were multiplexing then, that means
+	 * we had more events than we have counters for, and thus, at least,
+	 * one event was in INACTIVE state. Now, that we removed an event,
+	 * we need to resched to give a chance to all events to get scheduled,
+	 * otherwise some may get stuck.
+	 *
+	 * By the time this function is called the event is usually in the OFF
+	 * state.
+	 * Note that this is not a duplicate of the same code in _perf_event_disable()
+	 * because the call path are different. Some events may be simply disabled
+	 * others removed. There is a way to get removed and not be disabled first.
+	 */
+	if (ctx->rotate_necessary && ctx->nr_events) {
+		int type = get_event_type(event);
+		/*
+		 * In case we removed a pinned event, then we need to
+		 * resched for both pinned and flexible events. The
+		 * opposite is not true. A pinned event can never be
+		 * inactive due to multiplexing.
+		 */
+		if (type & EVENT_PINNED)
+			type |= EVENT_FLEXIBLE;
+		ctx_resched(cpuctx, cpuctx->task_ctx, type);
+	}
 }
 
 /*
@@ -2218,6 +2254,8 @@ static void __perf_event_disable(struct perf_event *event,
 				 struct perf_event_context *ctx,
 				 void *info)
 {
+	int was_necessary = ctx->rotate_necessary;
+
 	if (event->state < PERF_EVENT_STATE_INACTIVE)
 		return;
 
@@ -2232,6 +2270,35 @@ static void __perf_event_disable(struct perf_event *event,
 		event_sched_out(event, cpuctx, ctx);
 
 	perf_event_set_state(event, PERF_EVENT_STATE_OFF);
+	/*
+	 * sanity check that event_sched_out() does not and will not
+	 * change the state of ctx->rotate_necessary
+	 */
+	WARN_ON_ONCE(was_necessary != event->ctx->rotate_necessary);
+
+	/*
+	 * if we disable an event AND we were multiplexing then, that means
+	 * we had more events than we have counters for, and thus, at least,
+	 * one event was in INACTIVE state. Now, that we disabled an event,
+	 * we need to resched to give a chance to all events to be scheduled,
+	 * otherwise some may get stuck.
+	 *
+	 * Note that this is not a duplicate of the same code in
+	 * __perf_remove_from_context()
+	 * because events can be disabled without being removed.
+	 */
+	if (ctx->rotate_necessary && ctx->nr_events) {
+		int type = get_event_type(event);
+		/*
+		 * In case we removed a pinned event, then we need to
+		 * resched for both pinned and flexible events. The
+		 * opposite is not true. A pinned event can never be
+		 * inactive due to multiplexing.
+		 */
+		if (type & EVENT_PINNED)
+			type |= EVENT_FLEXIBLE;
+		ctx_resched(cpuctx, cpuctx->task_ctx, type);
+	}
 }
 
 /*
-- 
2.23.0.866.gb869b98d4c-goog

