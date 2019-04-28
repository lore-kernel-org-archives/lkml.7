Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB866C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 07:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80D22075D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 07:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uh5u1pAL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfD1HcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 03:32:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39353 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfD1HcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 03:32:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id l18so3645508pgj.6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 00:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qtqBXmm6KCwHcgr0Sj8jxHmzOMgpySRRx6FbMdFEjR8=;
        b=uh5u1pALOO3wYr2vZNf5QPYWrBs2eD6MPs+GbcWEY1X+/F0pd+sIFRyI5tnhN4HORI
         z0mSUfYBTTcFCiq/jb8XcENzlIvRRR8FhVtoJazqkVc1u2zQJ+6j9EYrE1yVxrk0obCT
         l2/UCgG82+5BBswIth87lP/ITfJHXWo2ASrM9fNl5va3XXUtpkjhHFHU76QNTEbKWvPJ
         a9mqEifHXaZaUIGh1uaTFLxUdr8hvWXJ7WMz44DUXiCFfBKDrNoW6PZfn1BJjwSADxCa
         cgF2diAfTdDQLzGMtEgtuvTLku1JumEGQN0Q9W9NKlaPfFIhrYWOpDPY1v+Z/kTBkxn5
         NsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qtqBXmm6KCwHcgr0Sj8jxHmzOMgpySRRx6FbMdFEjR8=;
        b=i6jXfWIQw0NJEO4clQvJ1CjKl7+TI6a+3dvCxxAsaRtzY0RqrYum9e1QqEO4wz16T0
         VhHaE4INAFHGr7CgIWWGlJLX578Y7GGULNxu8NRQkP5RHL9EcWUHrdHA+D/N5uvTaiu1
         mU2z99f+98V8DAoELB2O8QOnkccI5I08/yIGj5JlCE6WW3ToNiiK2CC7CZdTNKBe9v6N
         oaZeYMKaZboK+T6MyIDsMN/BT/ImC13R6yiwu5j8yHeYwFXvq7gVWPwlJWbWGwbVH4S5
         el8/gIklZuMEpySqDaySjoJHURQTMGdum4rjhhEEJTudqoj5UaeGFGXuGIxyYJo9Ttnf
         Q2ZQ==
X-Gm-Message-State: APjAAAUXkkvHyxX0YMvdnuvxnPf6HMJwsTW/xUT/SSyqUZs2HejuLEu8
        LchTiLUUaNs/3uAi8vQhLSs=
X-Google-Smtp-Source: APXvYqyQ1Z/S4HVCwzGBU2cCWVby/KMJKWmSX0t4dlEKknd6vEknQMNwT57ga/oNqpJSh1gsAyGHIw==
X-Received: by 2002:aa7:8e0d:: with SMTP id c13mr57684468pfr.193.1556436732427;
        Sun, 28 Apr 2019 00:32:12 -0700 (PDT)
Received: from my.k-onishi.net ([163.43.121.36])
        by smtp.gmail.com with ESMTPSA id q78sm26952045pfi.76.2019.04.28.00.32.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 00:32:11 -0700 (PDT)
From:   k-onishi <princeontrojanhorse@gmail.com>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        princeontrojanhorse@gmail.com
Subject: [PATCH] feat(CFS Bandwidth): add an interface for CFS Bandwidth
Date:   Sun, 28 Apr 2019 16:32:06 +0900
Message-Id: <20190428073207.6733-1-princeontrojanhorse@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I added an interface which is more intuitive
and takes less write/read systemcalls.

I think that most people don't really care period
and quota of CFS Bandwidth,

They just use it like
"I will allow this process to use 50% of single core" in most cases.

But I know that we still need to care period and quota in some cases.

Please consider for merging this if you like, thanks.

Signed-off-by: k-onishi <princeontrojanhorse@gmail.com>
---
 kernel/sched/core.c | 46 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4778c48a7fda..27338c727d7c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6700,6 +6700,35 @@ long tg_get_cfs_period(struct task_group *tg)
 	return cfs_period_us;
 }
 
+int tg_set_cfs_percent(struct task_group *tg, long cfs_percent)
+{
+	u64 quota, period;
+
+	if (cfs_percent < 0)
+		return -EINVAL;
+
+	period = 1 * NSEC_PER_SEC;
+	quota = cfs_percent * 10 * USEC_PER_SECUL;
+	return tg_set_cfs_bandwidth(tg, period, quota);
+}
+
+long tg_get_cfs_percent(struct task_group *tg)
+{
+	u64 quota, period;
+
+	if (tg->cfs_bandwidth.quota == RUNTIME_INF)
+		return -1;
+
+	quota = tg->cfs_bandwidth.quota;
+	period = tg->cfs_bandwidth.period;
+
+	do_div(quota, 10);
+	do_div(period, NSEC_PER_USEC);
+	do_div(quota, period);
+
+	return quota;
+}
+
 static s64 cpu_cfs_quota_read_s64(struct cgroup_subsys_state *css,
 				  struct cftype *cft)
 {
@@ -6724,6 +6753,18 @@ static int cpu_cfs_period_write_u64(struct cgroup_subsys_state *css,
 	return tg_set_cfs_period(css_tg(css), cfs_period_us);
 }
 
+static s64 cpu_cfs_percent_read_u64(struct cgroup_subsys_state *css,
+				   struct cftype *cft)
+{
+	return tg_get_cfs_percent(css_tg(css));
+}
+
+static int cpu_cfs_percent_write_u64(struct cgroup_subsys_state *css,
+				   struct cftype *cftype, u64 cfs_percent)
+{
+	return tg_set_cfs_percent(css_tg(css), cfs_percent);
+}
+
 struct cfs_schedulable_data {
 	struct task_group *tg;
 	u64 period, quota;
@@ -6876,6 +6917,11 @@ static struct cftype cpu_legacy_files[] = {
 		.read_u64 = cpu_cfs_period_read_u64,
 		.write_u64 = cpu_cfs_period_write_u64,
 	},
+	{
+		.name = "cfs_percent",
+		.read_s64 = cpu_cfs_percent_read_u64,
+		.write_u64 = cpu_cfs_percent_write_u64,
+	},
 	{
 		.name = "stat",
 		.seq_show = cpu_cfs_stat_show,
-- 
2.17.1

