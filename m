Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE83C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12CFC205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="XJh6WPpX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbfFYI3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:29:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55043 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfFYI3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:29:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8SZsb3530331
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:28:35 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8SZsb3530331
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561451316;
        bh=4jNSHdeSH0mDWUIrRgRqT3Kzj8jMa4BVBimvxxir21Q=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=XJh6WPpX1iiVzSpaR0M1MO6upgt4Na2Mu5scEidJNbagLyzFFwUe/G5X+raa3zpp8
         j97/CgyT19z50tkrmkby48RsGiYvjUYopocWH7SFMmM0vhF3kyhXHiYAzf5n/VeL7I
         gORfmhrx+AXxBq+1FEGDZfuHONLNkU6CQJr4UxsNTIAiUgLnoj6KFq/fdykyjKbJIp
         BlrfpO1coeMIcCTx7i/FP78QhzluLXVWvAw/tV6o99qV5KfBo6jAoVwKVanWcMDKat
         e4l3lytUGvxiXZ1MEXxZ3fBajx6fejPCc2Zt3GsI9kq9Rs2bggS1ZkjnTC7GWtutN9
         rNPRamB1bySfg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8SZ3Z3530328;
        Tue, 25 Jun 2019 01:28:35 -0700
Date:   Tue, 25 Jun 2019 01:28:35 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qais Yousef <tipbot@zytor.com>
Message-ID: <tip-a056a5bed7fa67706574b00cf1122c38596b2be1@git.kernel.org>
Cc:     u.kleine-koenig@pengutronix.de, bigeasy@linutronix.de,
        peterz@infradead.org, pkondeti@codeaurora.org,
        quentin.perret@arm.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, hpa@zytor.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mingo@kernel.org, qais.yousef@arm.com,
        linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, tglx@linutronix.de, qais.yousef@arm.com,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          mingo@kernel.org, rostedt@goodmis.org, pkondeti@codeaurora.org,
          quentin.perret@arm.com, u.kleine-koenig@pengutronix.de,
          bigeasy@linutronix.de, peterz@infradead.org,
          dietmar.eggemann@arm.com
In-Reply-To: <20190604111459.2862-7-qais.yousef@arm.com>
References: <20190604111459.2862-7-qais.yousef@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/debug: Export the newly added tracepoints
Git-Commit-ID: a056a5bed7fa67706574b00cf1122c38596b2be1
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

Commit-ID:  a056a5bed7fa67706574b00cf1122c38596b2be1
Gitweb:     https://git.kernel.org/tip/a056a5bed7fa67706574b00cf1122c38596b2be1
Author:     Qais Yousef <qais.yousef@arm.com>
AuthorDate: Tue, 4 Jun 2019 12:14:59 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 24 Jun 2019 19:23:43 +0200

sched/debug: Export the newly added tracepoints

So that external modules can hook into them and extract the info they
need. Since these new tracepoints have no events associated with them
exporting these tracepoints make them useful for external modules to
perform testing and debugging. There's no other way otherwise to access
them.

BPF doesn't have infrastructure to access these bare tracepoints either.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pavankumar Kondeti <pkondeti@codeaurora.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Perret <quentin.perret@arm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
Link: https://lkml.kernel.org/r/20190604111459.2862-7-qais.yousef@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 83bd6bb32a34..e5e02d23e693 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -23,6 +23,17 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/sched.h>
 
+/*
+ * Export tracepoints that act as a bare tracehook (ie: have no trace event
+ * associated with them) to allow external modules to probe them.
+ */
+EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_cfs_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_rt_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_dl_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_irq_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_se_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
+
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
 #if defined(CONFIG_SCHED_DEBUG) && defined(CONFIG_JUMP_LABEL)
