Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CE4C04AB2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC3F217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfEJLc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 07:32:56 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44584 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727573AbfEJLcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 07:32:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4D5D1A25;
        Fri, 10 May 2019 04:32:47 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D75113F6C4;
        Fri, 10 May 2019 04:32:45 -0700 (PDT)
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
Subject: [PATCH v2 7/7] sched: export the newly added tracepoints
Date:   Fri, 10 May 2019 12:30:13 +0100
Message-Id: <20190510113013.1193-8-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510113013.1193-1-qais.yousef@arm.com>
References: <20190510113013.1193-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So that external modules can hook into them and extract the info they
need. Since these new tracepoints have no events associated with them
exporting these tracepoints make them useful for external modules to
perform testing and debugging. There's no other way otherwise to access
them.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 kernel/sched/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4778c48a7fda..0f16e445cca1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -22,6 +22,14 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/sched.h>
 
+/*
+ * Export tracepoints that act as a bare tracehook (ie: have no trace event
+ * associated with them) to allow external modules to probe them.
+ */
+EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_rq);
+EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_se);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized);
+
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
 #if defined(CONFIG_SCHED_DEBUG) && defined(CONFIG_JUMP_LABEL)
-- 
2.17.1

