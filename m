Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA4EC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F9D229F3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gf2BrVqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbfGYQIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:08:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39527 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfGYQIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:08:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PG7rgO1073608
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 09:07:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PG7rgO1073608
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564070874;
        bh=yk5+Q4B6YbH8hj+rw74twQlCrgmpreye3zuxjVwLICE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=gf2BrVqAE/JA8ChWK4hhoyTJ+QUHCGiswHV6/hV4XaWGWVmKD7A0QchRO3PUKN9Mv
         0pbc37i+jEuJzkeo7TtQPAK4u7PspHxxH9DCFNhAJebbcp/74QIo6emsTnJExX0vl5
         BB3LqbMYo1LiBq6gizsteeC/QvnT2zKyWAhwGA104/bTQISHWmtXd8vVFaajQ77DLv
         eHTtagPcYNMni1NU45Yin3/wWRQafpUfgXFktPhc34RzE4yO48IxpO4X7hfxyWnG4O
         Iosbq//5vipFkTHZiv1lqKrPxEkCKxhHQkYb++gYXv+iELXDGS7M8BeXnjAaAEf696
         NInDIk/W+w8Gg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PG7qec1073605;
        Thu, 25 Jul 2019 09:07:52 -0700
Date:   Thu, 25 Jul 2019 09:07:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Leonard Crestez <tipbot@zytor.com>
Message-ID: <tip-4ce54af8b33d3e21ca935fc1b89b58cbba956051@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, jolsa@redhat.com,
        mingo@kernel.org, acme@kernel.org, linux-kernel@vger.kernel.org,
        Frank.li@nxp.com, namhyung@kernel.org, peterz@infradead.org,
        leonard.crestez@nxp.com, alexander.shishkin@linux.intel.com,
        mark.rutland@arm.com, torvalds@linux-foundation.org,
        will@kernel.org
Reply-To: tglx@linutronix.de, jolsa@redhat.com, hpa@zytor.com,
          mingo@kernel.org, acme@kernel.org, peterz@infradead.org,
          leonard.crestez@nxp.com, linux-kernel@vger.kernel.org,
          Frank.li@nxp.com, namhyung@kernel.org, will@kernel.org,
          alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
          torvalds@linux-foundation.org
In-Reply-To: <c4ebe0503623066896d7046def4d6b1e06e0eb2e.1563972056.git.leonard.crestez@nxp.com>
References: <c4ebe0503623066896d7046def4d6b1e06e0eb2e.1563972056.git.leonard.crestez@nxp.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/core: Fix creating kernel counters for PMUs
 that override event->cpu
Git-Commit-ID: 4ce54af8b33d3e21ca935fc1b89b58cbba956051
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

Commit-ID:  4ce54af8b33d3e21ca935fc1b89b58cbba956051
Gitweb:     https://git.kernel.org/tip/4ce54af8b33d3e21ca935fc1b89b58cbba956051
Author:     Leonard Crestez <leonard.crestez@nxp.com>
AuthorDate: Wed, 24 Jul 2019 15:53:24 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:41:31 +0200

perf/core: Fix creating kernel counters for PMUs that override event->cpu

Some hardware PMU drivers will override perf_event.cpu inside their
event_init callback. This causes a lockdep splat when initialized through
the kernel API:

 WARNING: CPU: 0 PID: 250 at kernel/events/core.c:2917 ctx_sched_out+0x78/0x208
 pc : ctx_sched_out+0x78/0x208
 Call trace:
  ctx_sched_out+0x78/0x208
  __perf_install_in_context+0x160/0x248
  remote_function+0x58/0x68
  generic_exec_single+0x100/0x180
  smp_call_function_single+0x174/0x1b8
  perf_install_in_context+0x178/0x188
  perf_event_create_kernel_counter+0x118/0x160

Fix this by calling perf_install_in_context with event->cpu, just like
perf_event_open

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/r/c4ebe0503623066896d7046def4d6b1e06e0eb2e.1563972056.git.leonard.crestez@nxp.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 026a14541a38..0463c1151bae 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11274,7 +11274,7 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
 		goto err_unlock;
 	}
 
-	perf_install_in_context(ctx, event, cpu);
+	perf_install_in_context(ctx, event, event->cpu);
 	perf_unpin_context(ctx);
 	mutex_unlock(&ctx->mutex);
 
