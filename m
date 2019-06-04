Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F62C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18F424B70
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfFDLP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 07:15:28 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40604 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727612AbfFDLPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 07:15:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84C291715;
        Tue,  4 Jun 2019 04:15:20 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6BC03F690;
        Tue,  4 Jun 2019 04:15:18 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH v3 6/6] sched: export the newly added tracepoints
Date:   Tue,  4 Jun 2019 12:14:59 +0100
Message-Id: <20190604111459.2862-7-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604111459.2862-1-qais.yousef@arm.com>
References: <20190604111459.2862-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So that external modules can hook into them and extract the info they
need. Since these new tracepoints have no events associated with them
exporting these tracepoints make them useful for external modules to
perform testing and debugging. There's no other way otherwise to access
them.

BPF doesn't have infrastructure to access these bare tracepoints either.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 kernel/sched/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 874c427742a9..bc831d913088 100644
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
-- 
2.17.1

