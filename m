Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7EAC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F8E261AB
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="g/AtBERZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbfFCNYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:24:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38925 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbfFCNYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:24:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DN8FF607237
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:23:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DN8FF607237
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559568189;
        bh=nSuYddbevhmED+nMbEBKkc/LPaP5S4tg5oR9ZJ5p/og=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=g/AtBERZjvmZhpLO+ZDvyDMcL1P79P7V6lp4LWeV7+yLtBwvukZrsHqnbaJolZQyk
         88RYUUB5N1rHhxqSiHzCwORoCr8s1/oFQgPd4K07cq94K8vySagH91ww7uuz4IjfOz
         H4Ce7M9jL7fatDkF2rWwoUYxPxOsvVBF7OiFn3fLudp/c90HUSOaXovl4Txb2Q0eR1
         nGG2IzXpRpoww+sSENsnOSA0va0kZbRv47vVDgveFHWS89xoDSqVy3UBcp8l1V4h9n
         atP4ga0qzR2Iu5T5aOlJDkFH9bhEK5+9QR66LMF2ZJ7OKix5OghqLeDnLXywU22T7J
         cutJwT+M2VMzA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DN8mS607234;
        Mon, 3 Jun 2019 06:23:08 -0700
Date:   Mon, 3 Jun 2019 06:23:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-9fd2e48b9ae17978b2c2a98c055c774d5d90bce8@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        acme@kernel.org, songliubraving@fb.com, jolsa@redhat.com,
        kernel-team@fb.com, hpa@zytor.com, peterz@infradead.org
Reply-To: torvalds@linux-foundation.org, mingo@kernel.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          acme@kernel.org, songliubraving@fb.com, hpa@zytor.com,
          kernel-team@fb.com, jolsa@redhat.com, peterz@infradead.org
In-Reply-To: <20190507161545.788381-1-songliubraving@fb.com>
References: <20190507161545.788381-1-songliubraving@fb.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/core: Allow non-privileged uprobe for user
 processes
Git-Commit-ID: 9fd2e48b9ae17978b2c2a98c055c774d5d90bce8
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  9fd2e48b9ae17978b2c2a98c055c774d5d90bce8
Gitweb:     https://git.kernel.org/tip/9fd2e48b9ae17978b2c2a98c055c774d5d90bce8
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Tue, 7 May 2019 09:15:45 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:58:18 +0200

perf/core: Allow non-privileged uprobe for user processes

Currently, non-privileged user could only use uprobe with

    kernel.perf_event_paranoid = -1

However, setting perf_event_paranoid to -1 leaks other users' processes to
non-privileged uprobes.

To introduce proper permission control of uprobes, we are building the
following system:

  A daemon with CAP_SYS_ADMIN is in charge to create uprobes via tracefs;
  Users asks the daemon to create uprobes;
  Then user can attach uprobe only to processes owned by the user.

This patch allows non-privileged user to attach uprobe to processes owned
by the user.

The following example shows how to use uprobe with non-privileged user.
This is based on Brendan's blog post [1]

1. Create uprobe with root:

  sudo perf probe -x 'readline%return +0($retval):string'

2. Then non-root user can use the uprobe as:

  perf record -vvv -e probe_bash:readline__return -p <pid> sleep 20
  perf script

[1] http://www.brendangregg.com/blog/2015-06-28/linux-ftrace-uprobe.html

Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <kernel-team@fb.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190507161545.788381-1-songliubraving@fb.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/core.c        | 4 ++--
 kernel/trace/trace_uprobe.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index abbd4b3b96c2..3005c80f621d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8532,9 +8532,9 @@ static int perf_tp_event_match(struct perf_event *event,
 	if (event->hw.state & PERF_HES_STOPPED)
 		return 0;
 	/*
-	 * All tracepoints are from kernel-space.
+	 * If exclude_kernel, only trace user-space tracepoints (uprobes)
 	 */
-	if (event->attr.exclude_kernel)
+	if (event->attr.exclude_kernel && !user_mode(regs))
 		return 0;
 
 	if (!perf_tp_filter_match(event, data))
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index eb7e06b54741..0d60d6856de5 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1331,7 +1331,7 @@ static inline void init_trace_event_call(struct trace_uprobe *tu,
 	call->event.funcs = &uprobe_funcs;
 	call->class->define_fields = uprobe_event_define_fields;
 
-	call->flags = TRACE_EVENT_FL_UPROBE;
+	call->flags = TRACE_EVENT_FL_UPROBE | TRACE_EVENT_FL_CAP_ANY;
 	call->class->reg = trace_uprobe_register;
 	call->data = tu;
 }
