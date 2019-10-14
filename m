Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EE0C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 00:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6311720815
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 00:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oaGiw5aR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbfJNA6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 20:58:31 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38170 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729180AbfJNA6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 20:58:30 -0400
Received: by mail-qk1-f193.google.com with SMTP id x4so10535100qkx.5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 17:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C71Hj3FAfJPFhO85jZclZxmP3ymeCuJHViUF1xnpygY=;
        b=oaGiw5aRw1A3F2kzXrr8txWWSNefUqvDNAIn8wXNSXOxnO1CCmOe/9tE3yoWerx37U
         dwdZmO0/ga+WVga9PPZdx/QioTC9cM05Q5BnrrFnnWPRVTcGk6VjvE1ZBX9DnHkDm403
         YlJDOo3VvV2PfRQ9IurFnFzIrks1x49Hv7/4HRJVRAYR3fZAJ+rXL1UDlBOZbb5tR62o
         V5YiNDviL1ZVzJvPxD0RInYdQKjTFQLxSiK3eljUc6HahTasuJ1AtA/GKA6TroSK2jQB
         zv8vkZ5iS/sDvqDE2CJVGn8ZPpX13vXuV8Nhz81aE8eJKEj6qbagG3xi+c7AOeQLe7C2
         fUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C71Hj3FAfJPFhO85jZclZxmP3ymeCuJHViUF1xnpygY=;
        b=jkkLfr4UFseN2S0fgwLuQ/FIfSeIB5KAd44hkYWa74qp8cVPwh6Luehzvf9JNyVfRE
         aoPqPFIRewymd8aWoKNWquy26pLJqNtlb4r8ghjwUOcMea0SbXMvYgDK9zfqmpyJ6YgB
         +PxIMDxb4oPa22hYyF97a3RTdi3ci2LrxEcyjIMlb37hzbgchLsR2oixDi1kAOeQqgeM
         TSqXmUAihs7nK1+rN5no+W0X8stQXJeqc/4ZoA59XrQL+jI08zlhaCPdHoNR+R7Y+Ybc
         Fe6B3W8NPsbn5ONO1S+SHvtO+9ee5v+y70O24Ztui7JFohAh3J6o0FOqoHnXV5aPXNrf
         YrLg==
X-Gm-Message-State: APjAAAWmQGKgFZW9l40tX2M/Hwq9b/LmUN+IJtF6zmOnkn/ajK5C1JIt
        IEB2AZbuhUnoaj7faM551aJWjA==
X-Google-Smtp-Source: APXvYqxacNxQw7eCDmvVQZa/5/5oibxwe1D6o6oFPnGTWKgnL08CIfYCF4wr4eNEviNWw+44kiNAbg==
X-Received: by 2002:a37:a8d5:: with SMTP id r204mr27828397qke.464.1571014708568;
        Sun, 13 Oct 2019 17:58:28 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id c185sm7663901qkf.122.2019.10.13.17.58.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Oct 2019 17:58:28 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: [Patch v3 1/7] sched/pelt.c: Add support to track thermal pressure
Date:   Sun, 13 Oct 2019 20:58:19 -0400
Message-Id: <1571014705-19646-2-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1571014705-19646-1-git-send-email-thara.gopinath@linaro.org>
References: <1571014705-19646-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extrapolating on the exisitng framework to track rt/dl utilization using
pelt signals, add a similar mechanism to track thermal pressue. The
difference here from rt/dl utilization tracking is that, instead of
tracking time spent by a cpu running a rt/dl task through util_avg,
the average thermal pressure is tracked through load_avg.
In order to track average thermal pressure, a new sched_avg variable
avg_thermal is introduced. Function update_thermal_avg can be called
to do the periodic bookeeping (accumulate, decay and average)
of the thermal pressure.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 kernel/sched/pelt.c  | 13 +++++++++++++
 kernel/sched/pelt.h  |  7 +++++++
 kernel/sched/sched.h |  1 +
 3 files changed, 21 insertions(+)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index a96db50..f06aae3 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -353,6 +353,19 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 	return 0;
 }
 
+int update_thermal_avg(u64 now, struct rq *rq, u64 capacity)
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
index afff644..01c5436 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -6,6 +6,7 @@ int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se
 int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq);
 int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
 int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
+int update_thermal_avg(u64 now, struct rq *rq, u64 capacity);
 
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 int update_irq_load_avg(struct rq *rq, u64 running);
@@ -175,6 +176,12 @@ update_rq_clock_pelt(struct rq *rq, s64 delta) { }
 static inline void
 update_idle_rq_clock_pelt(struct rq *rq) { }
 
+static inline int
+update_thermal_avg(u64 now, struct rq *rq, u64 capacity)
+{
+	return 0;
+}
+
 #endif
 
 
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

