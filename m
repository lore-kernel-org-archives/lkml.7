Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EEBCA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 608CA21848
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aH+I9Mrz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389376AbfJVUea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 16:34:30 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34339 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389153AbfJVUea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 16:34:30 -0400
Received: by mail-qt1-f194.google.com with SMTP id e14so9093382qto.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 13:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3iXJDm64yU5kPpIovC1LUxJgR4cu+K7/3XhEF8ojNLc=;
        b=aH+I9MrzgLa6oPfEAQB10D3S98FO/VBm9pwwROVFp920m35baZz1f5Hf+WH2033EnT
         3rgTmpl/aeitOy6UGm1KCCbhrkpZkzMWjFr9utusfa7rWS26TZUhJwrfezuAkR/ekk5V
         yD7nKdwuFmgM8c7eJTLtfUMT8/qwInrjuxstvExOqFCNQuJY6CoEe1ElI1aOQ2nta9zz
         1yZ7W68BgH+Eh9aTFsQV0AEknM3ufkenjZ0ac0dY6INUrjNqalZVnX3BHyX92XA3362N
         uWJzfJa1OmAD638xyJ+v/dxURzQjMBcFez8gyCTRINAAaGm9eFRW11h0HrqrEuwJOtdf
         HYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3iXJDm64yU5kPpIovC1LUxJgR4cu+K7/3XhEF8ojNLc=;
        b=Z8/F0DUPXOuTjlQcBqd+Z8OFP2IWplu/A4nJ3dtaX8i1AOwQIG8WDH5SDkPh1QfNnx
         PRjRlaVKk3/3awF9swWWNOiCYcvqO5ZVkZdbHPoY/CF0T1Dh23ZJF3jhg50i+VExJ0oG
         2fS0Zp6e+8v0skiY9IYxMvOxOgZoaAHLBPoMkeaOhMHivukhi/peCNBZB94/y6VpZSej
         R6W102gmssl3QdxtOQ987+zDTVTB/ZLNk7d+KQJP1s+6D2BBhSG2d90M3FHWAq1lxJTo
         6Ckp0GSLGK3xaf97ubPi9gBiHHk5JUQVcTPExS0k+udJzCMcFmhlVkaRaT1j6CL0aIq2
         cceQ==
X-Gm-Message-State: APjAAAVw7PWxarp9GKCw26o/hCugty5XWybgcO9oNq1FTr039nrZsmvZ
        qjdHOeJkmuwE/2offrHaaNqOsMh+uh4=
X-Google-Smtp-Source: APXvYqy/Kn8iq0ZEHqm4JRT27uLFILbLKTFoCONCaC/TrbIzwdgy7/krGsWvkvrvtvjTLPxh3C3kiw==
X-Received: by 2002:ac8:3849:: with SMTP id r9mr5365347qtb.370.1571776469099;
        Tue, 22 Oct 2019 13:34:29 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id r126sm8895038qke.98.2019.10.22.13.34.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Oct 2019 13:34:28 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, qperret@google.com
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: [Patch v4 1/6] sched/pelt.c: Add support to track thermal pressure
Date:   Tue, 22 Oct 2019 16:34:20 -0400
Message-Id: <1571776465-29763-2-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extrapolating on the exisiting framework to track rt/dl utilization using
pelt signals, add a similar mechanism to track thermal pressure. The
difference here from rt/dl utilization tracking is that, instead of
tracking time spent by a cpu running a rt/dl task through util_avg,
the average thermal pressure is tracked through load_avg. This is
because thermal pressure signal is weighted "delta" capacity
and is not binary(util_avg is binary). "delta capacity" here
means delta between the actual capacity of a cpu and the decreased
capacity a cpu due to a thermal event.
In order to track average thermal pressure, a new sched_avg variable
avg_thermal is introduced. Function update_thermal_avg can be called
to do the periodic bookeeping (accumulate, decay and average)
of the thermal pressure.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
v3->v4:
	- Renamed update_thermal_avg to update_thermal_load_avg.
	- Fixed typos as per review comments on mailing list
	- Reordered the code as per review comments

 kernel/sched/pelt.c  | 13 +++++++++++++
 kernel/sched/pelt.h  |  7 +++++++
 kernel/sched/sched.h |  1 +
 3 files changed, 21 insertions(+)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index a96db50..3821069 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -353,6 +353,19 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 	return 0;
 }
 
+int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
+{
+	if (___update_load_sum(now, &rq->avg_thermal,
+			       capacity,
+			       capacity,
+			       capacity)) {
+		___update_load_avg(&rq->avg_thermal, 1, 1);
+		return 1;
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 /*
  * irq:
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index afff644..c74226d 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -6,6 +6,7 @@ int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se
 int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq);
 int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
 int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
+int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity);
 
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 int update_irq_load_avg(struct rq *rq, u64 running);
@@ -159,6 +160,12 @@ update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 }
 
 static inline int
+update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
+{
+	return 0;
+}
+
+static inline int
 update_irq_load_avg(struct rq *rq, u64 running)
 {
 	return 0;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0db2c1b..d5d82c8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -944,6 +944,7 @@ struct rq {
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 	struct sched_avg	avg_irq;
 #endif
+	struct sched_avg	avg_thermal;
 	u64			idle_stamp;
 	u64			avg_idle;
 
-- 
2.1.4

