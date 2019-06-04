Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441C4C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C30C24B6F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfFDLPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 07:15:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40522 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbfFDLPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 07:15:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40A2C15A2;
        Tue,  4 Jun 2019 04:15:10 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71E353F690;
        Tue,  4 Jun 2019 04:15:08 -0700 (PDT)
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
Subject: [PATCH v3 1/6] sched: autogroup: Make autogroup_path() always available
Date:   Tue,  4 Jun 2019 12:14:54 +0100
Message-Id: <20190604111459.2862-2-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604111459.2862-1-qais.yousef@arm.com>
References: <20190604111459.2862-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By removing the #ifdef CONFIG_SCHED_DEBUG

Some of the tracepoints to be introduced in later patches need to access
this function. Hence make it always available since the tracepoints are
not protected by CONFIG_SCHED_DEBUG.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 kernel/sched/autogroup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
index 2d4ff5353ded..2067080bb235 100644
--- a/kernel/sched/autogroup.c
+++ b/kernel/sched/autogroup.c
@@ -259,7 +259,6 @@ void proc_sched_autogroup_show_task(struct task_struct *p, struct seq_file *m)
 }
 #endif /* CONFIG_PROC_FS */
 
-#ifdef CONFIG_SCHED_DEBUG
 int autogroup_path(struct task_group *tg, char *buf, int buflen)
 {
 	if (!task_group_is_autogroup(tg))
@@ -267,4 +266,3 @@ int autogroup_path(struct task_group *tg, char *buf, int buflen)
 
 	return snprintf(buf, buflen, "%s-%ld", "/autogroup", tg->autogroup->id);
 }
-#endif
-- 
2.17.1

