Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA60C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9CA24B6F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfFDLPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 07:15:14 -0400
Received: from foss.arm.com ([217.140.101.70]:40540 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727513AbfFDLPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 07:15:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CB1D15AB;
        Tue,  4 Jun 2019 04:15:12 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EEB13F690;
        Tue,  4 Jun 2019 04:15:10 -0700 (PDT)
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
Subject: [PATCH v3 2/6] sched: add a new sched_trace_*() helper functions
Date:   Tue,  4 Jun 2019 12:14:55 +0100
Message-Id: <20190604111459.2862-3-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604111459.2862-1-qais.yousef@arm.com>
References: <20190604111459.2862-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new functions allow modules to access internal data structures of
unexported struct cfs_rq and struct rq to extract important information
from the tracepoints to be introduced in later patches.

While at it fix alphabetical order of struct declarations in sched.h

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 include/linux/sched.h | 16 ++++++-
 kernel/sched/fair.c   | 99 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 11837410690f..5079ab584066 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -35,6 +35,7 @@ struct audit_context;
 struct backing_dev_info;
 struct bio_list;
 struct blk_plug;
+struct capture_control;
 struct cfs_rq;
 struct fs_struct;
 struct futex_pi_state;
@@ -47,8 +48,9 @@ struct pid_namespace;
 struct pipe_inode_info;
 struct rcu_node;
 struct reclaim_state;
-struct capture_control;
 struct robust_list_head;
+struct root_domain;
+struct rq;
 struct sched_attr;
 struct sched_param;
 struct seq_file;
@@ -1919,4 +1921,16 @@ static inline void rseq_syscall(struct pt_regs *regs)
 
 #endif
 
+const struct sched_avg *sched_trace_cfs_rq_avg(struct cfs_rq *cfs_rq);
+char *sched_trace_cfs_rq_path(struct cfs_rq *cfs_rq, char *str, int len);
+int sched_trace_cfs_rq_cpu(struct cfs_rq *cfs_rq);
+
+const struct sched_avg *sched_trace_rq_avg_rt(struct rq *rq);
+const struct sched_avg *sched_trace_rq_avg_dl(struct rq *rq);
+const struct sched_avg *sched_trace_rq_avg_irq(struct rq *rq);
+
+int sched_trace_rq_cpu(struct rq *rq);
+
+const struct cpumask *sched_trace_rd_span(struct root_domain *rd);
+
 #endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f35930f5e528..18c89ebadfc7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -275,6 +275,19 @@ static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
 	return grp->my_q;
 }
 
+static inline void cfs_rq_tg_path(struct cfs_rq *cfs_rq, char *path, int len)
+{
+	if (!path)
+		return;
+
+	if (cfs_rq && task_group_is_autogroup(cfs_rq->tg))
+		autogroup_path(cfs_rq->tg, path, len);
+	else if (cfs_rq && cfs_rq->tg->css.cgroup)
+		cgroup_path(cfs_rq->tg->css.cgroup, path, len);
+	else
+		strlcpy(path, "(null)", len);
+}
+
 static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq = rq_of(cfs_rq);
@@ -449,6 +462,12 @@ static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
 	return NULL;
 }
 
+static inline void cfs_rq_tg_path(struct cfs_rq *cfs_rq, char *path, int len)
+{
+	if (path)
+		strlcpy(path, "(null)", len);
+}
+
 static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	return true;
@@ -10737,3 +10756,83 @@ __init void init_sched_fair_class(void)
 #endif /* SMP */
 
 }
+
+/*
+ * Helper functions to facilitate extracting info from tracepoints.
+ */
+
+const struct sched_avg *sched_trace_cfs_rq_avg(struct cfs_rq *cfs_rq)
+{
+#ifdef CONFIG_SMP
+	return cfs_rq ? &cfs_rq->avg : NULL;
+#else
+	return NULL;
+#endif
+}
+EXPORT_SYMBOL_GPL(sched_trace_cfs_rq_avg);
+
+char *sched_trace_cfs_rq_path(struct cfs_rq *cfs_rq, char *str, int len)
+{
+	if (!cfs_rq) {
+		if (str)
+			strlcpy(str, "(null)", len);
+		else
+			return NULL;
+	}
+
+	cfs_rq_tg_path(cfs_rq, str, len);
+	return str;
+}
+EXPORT_SYMBOL_GPL(sched_trace_cfs_rq_path);
+
+int sched_trace_cfs_rq_cpu(struct cfs_rq *cfs_rq)
+{
+	return cfs_rq ? cpu_of(rq_of(cfs_rq)) : -1;
+}
+EXPORT_SYMBOL_GPL(sched_trace_cfs_rq_cpu);
+
+const struct sched_avg *sched_trace_rq_avg_rt(struct rq *rq)
+{
+#ifdef CONFIG_SMP
+	return rq ? &rq->avg_rt : NULL;
+#else
+	return NULL;
+#endif
+}
+EXPORT_SYMBOL_GPL(sched_trace_rq_avg_rt);
+
+const struct sched_avg *sched_trace_rq_avg_dl(struct rq *rq)
+{
+#ifdef CONFIG_SMP
+	return rq ? &rq->avg_dl : NULL;
+#else
+	return NULL;
+#endif
+}
+EXPORT_SYMBOL_GPL(sched_trace_rq_avg_dl);
+
+const struct sched_avg *sched_trace_rq_avg_irq(struct rq *rq)
+{
+#if defined(CONFIG_SMP) && defined(CONFIG_HAVE_SCHED_AVG_IRQ)
+	return rq ? &rq->avg_irq : NULL;
+#else
+	return NULL;
+#endif
+}
+EXPORT_SYMBOL_GPL(sched_trace_rq_avg_irq);
+
+int sched_trace_rq_cpu(struct rq *rq)
+{
+	return rq ? cpu_of(rq) : -1;
+}
+EXPORT_SYMBOL_GPL(sched_trace_rq_cpu);
+
+const struct cpumask *sched_trace_rd_span(struct root_domain *rd)
+{
+#ifdef CONFIG_SMP
+	return rd ? rd->span : NULL;
+#else
+	return NULL;
+#endif
+}
+EXPORT_SYMBOL_GPL(sched_trace_rd_span);
-- 
2.17.1

