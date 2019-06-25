Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E17C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC528215EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Um+6gMeJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbfFYI0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:26:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43675 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfFYI0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:26:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8PiU43529798
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:25:44 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8PiU43529798
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561451145;
        bh=SUSJy0tko47mlnnmG4TYXShvjd83OfDFpqhxx3SURZU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Um+6gMeJyZSEoJ/FoxdhZzvRuPTwlFYXuAfy12z6t8bLeXg56cDNXDtUzWlr8MALS
         kQSsHQmyTStfWhoTyB9l1+VL3wKEWoXeHx4gLGKjqDDn9xAFAJqSBm+t0AfuaGjBJW
         Ql1FRZJrCI+XsEPRSRVzrUfJNdcTUQD7jKHLkpqM7VnyjYGRg2rBiWEtWpuyHIKOlO
         nR1ytDMNF4WFrWYVwzdftEEiXg0XQ1jP9TcN+Qu5+noiuh3WURHZmthEairpCft/sw
         lEq+34JWkHhH9UAFf6Grms3zXt8481/uU+NjMuWsTEDK6f9arrVceD/q4LJnDlDdZZ
         MWkFRhmUTFgGw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8PijK3529795;
        Tue, 25 Jun 2019 01:25:44 -0700
Date:   Tue, 25 Jun 2019 01:25:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qais Yousef <tipbot@zytor.com>
Message-ID: <tip-3c93a0c04dfdcba199982b53b97488b1b1d90eff@git.kernel.org>
Cc:     mingo@kernel.org, pkondeti@codeaurora.org, hpa@zytor.com,
        quentin.perret@arm.com, torvalds@linux-foundation.org,
        qais.yousef@arm.com, tglx@linutronix.de, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, u.kleine-koenig@pengutronix.de,
        bigeasy@linutronix.de
Reply-To: hpa@zytor.com, quentin.perret@arm.com, mingo@kernel.org,
          pkondeti@codeaurora.org, qais.yousef@arm.com,
          torvalds@linux-foundation.org, rostedt@goodmis.org,
          tglx@linutronix.de, dietmar.eggemann@arm.com,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          u.kleine-koenig@pengutronix.de, bigeasy@linutronix.de
In-Reply-To: <20190604111459.2862-3-qais.yousef@arm.com>
References: <20190604111459.2862-3-qais.yousef@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/debug: Add a new sched_trace_*() helper
 functions
Git-Commit-ID: 3c93a0c04dfdcba199982b53b97488b1b1d90eff
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

Commit-ID:  3c93a0c04dfdcba199982b53b97488b1b1d90eff
Gitweb:     https://git.kernel.org/tip/3c93a0c04dfdcba199982b53b97488b1b1d90eff
Author:     Qais Yousef <qais.yousef@arm.com>
AuthorDate: Tue, 4 Jun 2019 12:14:55 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 24 Jun 2019 19:23:41 +0200

sched/debug: Add a new sched_trace_*() helper functions

The new functions allow modules to access internal data structures of
unexported struct cfs_rq and struct rq to extract important information
from the tracepoints to be introduced in later patches.

While at it fix alphabetical order of struct declarations in sched.h

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
Link: https://lkml.kernel.org/r/20190604111459.2862-3-qais.yousef@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched.h | 16 ++++++++-
 kernel/sched/fair.c   | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1b2590a8d038..044c023875e8 100644
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
@@ -1920,4 +1922,16 @@ static inline void rseq_syscall(struct pt_regs *regs)
 
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
index 4f8754157763..461c3e9a67b2 100644
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
@@ -10408,3 +10427,83 @@ __init void init_sched_fair_class(void)
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
