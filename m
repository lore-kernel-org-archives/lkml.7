Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3BEC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA50E20665
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gtnNfdFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbfFYI21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:28:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50247 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfFYI20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:28:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8Rr6d3530276
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:27:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8Rr6d3530276
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561451273;
        bh=FVZduO8uCpQbUH+ZvmuOf8fI4oijO9iRMSWmE53gYx8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=gtnNfdFSm5vJF3fbxvlEj97X8ZwvRpl5eTcFRFPOiIl8fF4CGzZv6kWTOweSngP61
         9wpskkKvyuphsHtfuB33gdjv5G9tEXRcVkV1p72lR1WUhh+Yl1i+s+S6NkLVB4W5S3
         wIfF/yy7TOvEuR2f4qq8G8wlquyrpi0VWh6ziDEW0CUxwujvwPGT0s3xD2p6Qijlan
         zGHHBQEHbFrkbNYGxUPhzvYT5fJ23O0Lp5LmQj/fB6NnrcWm799nLs/EnDgX+P01Zb
         UKNaUtwKWMoAVN0AqdOHExhYHx4h7KPpNCethRfAHkVQTW2qOLSOjHN8v5Y7uhd+99
         /s1lY3eTXKa/A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8Rrij3530273;
        Tue, 25 Jun 2019 01:27:53 -0700
Date:   Tue, 25 Jun 2019 01:27:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qais Yousef <tipbot@zytor.com>
Message-ID: <tip-f9f240f96efc5bcec62379eac701523e11fbb45b@git.kernel.org>
Cc:     quentin.perret@arm.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bigeasy@linutronix.de, mingo@kernel.org,
        u.kleine-koenig@pengutronix.de, peterz@infradead.org,
        dietmar.eggemann@arm.com, hpa@zytor.com, rostedt@goodmis.org,
        torvalds@linux-foundation.org, qais.yousef@arm.com,
        pkondeti@codeaurora.org
Reply-To: torvalds@linux-foundation.org, hpa@zytor.com,
          rostedt@goodmis.org, qais.yousef@arm.com,
          pkondeti@codeaurora.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, quentin.perret@arm.com,
          bigeasy@linutronix.de, u.kleine-koenig@pengutronix.de,
          mingo@kernel.org, peterz@infradead.org, dietmar.eggemann@arm.com
In-Reply-To: <20190604111459.2862-6-qais.yousef@arm.com>
References: <20190604111459.2862-6-qais.yousef@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/debug: Add sched_overutilized tracepoint
Git-Commit-ID: f9f240f96efc5bcec62379eac701523e11fbb45b
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

Commit-ID:  f9f240f96efc5bcec62379eac701523e11fbb45b
Gitweb:     https://git.kernel.org/tip/f9f240f96efc5bcec62379eac701523e11fbb45b
Author:     Qais Yousef <qais.yousef@arm.com>
AuthorDate: Tue, 4 Jun 2019 12:14:58 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 24 Jun 2019 19:23:42 +0200

sched/debug: Add sched_overutilized tracepoint

The new tracepoint allows us to track the changes in overutilized
status.

Overutilized status is associated with EAS. It indicates that the system
is in high performance state. EAS is disabled when the system is in this
state since there's not much energy savings while high performance tasks
are pushing the system to the limit and it's better to default to the
spreading behavior of the scheduler.

This tracepoint helps understanding and debugging the conditions under
which this happens.

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
Link: https://lkml.kernel.org/r/20190604111459.2862-6-qais.yousef@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/trace/events/sched.h |  4 ++++
 kernel/sched/fair.c          | 10 ++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index c7dd9bc7f001..420e80e56e55 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -621,6 +621,10 @@ DECLARE_TRACE(pelt_se_tp,
 	TP_PROTO(struct sched_entity *se),
 	TP_ARGS(se));
 
+DECLARE_TRACE(sched_overutilized_tp,
+	TP_PROTO(struct root_domain *rd, bool overutilized),
+	TP_ARGS(rd, overutilized));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 75218ab1fa07..11ec52709323 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5181,8 +5181,10 @@ static inline bool cpu_overutilized(int cpu)
 
 static inline void update_overutilized_status(struct rq *rq)
 {
-	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu))
+	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu)) {
 		WRITE_ONCE(rq->rd->overutilized, SG_OVERUTILIZED);
+		trace_sched_overutilized_tp(rq->rd, SG_OVERUTILIZED);
+	}
 }
 #else
 static inline void update_overutilized_status(struct rq *rq) { }
@@ -8214,8 +8216,12 @@ next_group:
 
 		/* Update over-utilization (tipping point, U >= 0) indicator */
 		WRITE_ONCE(rd->overutilized, sg_status & SG_OVERUTILIZED);
+		trace_sched_overutilized_tp(rd, sg_status & SG_OVERUTILIZED);
 	} else if (sg_status & SG_OVERUTILIZED) {
-		WRITE_ONCE(env->dst_rq->rd->overutilized, SG_OVERUTILIZED);
+		struct root_domain *rd = env->dst_rq->rd;
+
+		WRITE_ONCE(rd->overutilized, SG_OVERUTILIZED);
+		trace_sched_overutilized_tp(rd, SG_OVERUTILIZED);
 	}
 }
 
