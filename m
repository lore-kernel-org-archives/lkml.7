Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE1AC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D668120665
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hk3w5a4R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbfFYI1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:27:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56097 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbfFYI1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:27:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8RAkW3530187
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:27:10 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8RAkW3530187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561451231;
        bh=+ZN9/QPz9wc5gfEP0xmU54nfW6Ec1tILXhks4RnBJWU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=hk3w5a4RffZveoUsQI4V/Ua1qKdziIL9Sx19v/5aYHkuR9CwaAEU4dx5M4xF6N9oy
         2oi0JbM5TMFCtnOxzwAEU85xR/Q9fvvTNqMsmyAgW5uTdAWZDx6pA59Y5OCJot1nVK
         SZZBxzOFtHn7uc7rhriKXqORe4Os/qWcn53XxntslPKszyZLA+c+WXmEMIzqMeNz4g
         pMoKQT1vxlOcn4QAdTta/sMkyG2tcIq77GHJdtyrbwnDKO52qn5dO4B0tmYmq2/qDU
         gkU6r/dT8AozYnfwi7eA6d0Wvkr84vpMmQFN3MHypAwoWDXIKcvIcIOQQY6qSmRSwJ
         fbYjxnKP81W3g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8RAYU3530184;
        Tue, 25 Jun 2019 01:27:10 -0700
Date:   Tue, 25 Jun 2019 01:27:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qais Yousef <tipbot@zytor.com>
Message-ID: <tip-8de6242cca17d9299e654e29c966d8612d397272@git.kernel.org>
Cc:     dietmar.eggemann@arm.com, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com, rostedt@goodmis.org,
        tglx@linutronix.de, mingo@kernel.org, quentin.perret@arm.com,
        u.kleine-koenig@pengutronix.de, qais.yousef@arm.com,
        torvalds@linux-foundation.org, peterz@infradead.org,
        pkondeti@codeaurora.org
Reply-To: linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
          dietmar.eggemann@arm.com, tglx@linutronix.de,
          rostedt@goodmis.org, hpa@zytor.com,
          torvalds@linux-foundation.org, qais.yousef@arm.com,
          u.kleine-koenig@pengutronix.de, quentin.perret@arm.com,
          mingo@kernel.org, pkondeti@codeaurora.org, peterz@infradead.org
In-Reply-To: <20190604111459.2862-5-qais.yousef@arm.com>
References: <20190604111459.2862-5-qais.yousef@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/debug: Add new tracepoint to track PELT at
 se level
Git-Commit-ID: 8de6242cca17d9299e654e29c966d8612d397272
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

Commit-ID:  8de6242cca17d9299e654e29c966d8612d397272
Gitweb:     https://git.kernel.org/tip/8de6242cca17d9299e654e29c966d8612d397272
Author:     Qais Yousef <qais.yousef@arm.com>
AuthorDate: Tue, 4 Jun 2019 12:14:57 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 24 Jun 2019 19:23:42 +0200

sched/debug: Add new tracepoint to track PELT at se level

The new tracepoint allows tracking PELT signals at sched_entity level.
Which is supported in CFS tasks and taskgroups only.

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
Link: https://lkml.kernel.org/r/20190604111459.2862-5-qais.yousef@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/trace/events/sched.h | 4 ++++
 kernel/sched/fair.c          | 1 +
 kernel/sched/pelt.c          | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 520b89d384ec..c7dd9bc7f001 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -617,6 +617,10 @@ DECLARE_TRACE(pelt_irq_tp,
 	TP_PROTO(struct rq *rq),
 	TP_ARGS(rq));
 
+DECLARE_TRACE(pelt_se_tp,
+	TP_PROTO(struct sched_entity *se),
+	TP_ARGS(se));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e883d7e17e36..75218ab1fa07 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3348,6 +3348,7 @@ static inline int propagate_entity_load_avg(struct sched_entity *se)
 	update_tg_cfs_runnable(cfs_rq, se, gcfs_rq);
 
 	trace_pelt_cfs_tp(cfs_rq);
+	trace_pelt_se_tp(se);
 
 	return 1;
 }
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 4e961b55b5ea..a96db50d40e0 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -267,6 +267,7 @@ int __update_load_avg_blocked_se(u64 now, struct sched_entity *se)
 {
 	if (___update_load_sum(now, &se->avg, 0, 0, 0)) {
 		___update_load_avg(&se->avg, se_weight(se), se_runnable(se));
+		trace_pelt_se_tp(se);
 		return 1;
 	}
 
@@ -280,6 +281,7 @@ int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se
 
 		___update_load_avg(&se->avg, se_weight(se), se_runnable(se));
 		cfs_se_util_change(&se->avg);
+		trace_pelt_se_tp(se);
 		return 1;
 	}
 
