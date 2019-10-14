Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A30C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 00:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A702067B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 00:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JEUmMaVv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbfJNA6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 20:58:39 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36721 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729755AbfJNA6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 20:58:37 -0400
Received: by mail-qt1-f196.google.com with SMTP id o12so23149369qtf.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 17:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aPyEagV1DxsvKL/RZo3njz7RJXo5X1hyEh5ILDelpv8=;
        b=JEUmMaVvI1LTbq3LGF/EHz2CBzkv+GbwvnLMnASrc+hIV9wAca7MyTEh6eTobXhfHE
         Q+Ca96u2yVxistrNN4nSIttKWMZAiGhjYxHE77kJtMg0Fq3B7kgItwp0zzgctcRMzCIQ
         pTxOgNH2GVIWWo/X+ghPkmT6MPxxVvXV+Pa7tFIpr6H+oVMT4+oKmwkodX63ZPfQ9naB
         bWXkxqp6QL3TBDPXGj5sXeGa0xGNkuN4ZaIQqDLYHK1vx2zyXzfRCheESeEG2c9ANJW3
         rDLndBM3+sVJpeXsvRP4XoSU/uhEUqmQ09mzeqwPJZhfuuWnKWQ2vg/YvS2eXhUM/KG1
         +IJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aPyEagV1DxsvKL/RZo3njz7RJXo5X1hyEh5ILDelpv8=;
        b=rw/mEP63PmdmRUJCUzs/hp3EwV5HfGaE93SwMxKNlwM7UukCiu/Q5KODFzw4o1ZfdJ
         dYrMsjhV2AU/CI6USuO3gVgQGS78xSw93SDDAbf7YOT80d1b+Y5mAuay9r2Jklf5Oarx
         AOC7QsZXgmmWibB4nRwNrZU7ptJXUzncEnbfzoRGIQOYnrt124GDOgVPsLbETQ79TV+0
         qL3ytuC9yzRxdzmIlIIt+5Jrks1dsL3aOq+glInTTpoJtid1pnZqZk0rxWI3LO15dUr1
         cXjmxcPCmRvXt2TUzU/SKIgfP6E1VBC3UXZIIhcjjP7U9Kqx6Lz0w/0FconJMdtE1LyG
         m4Pg==
X-Gm-Message-State: APjAAAWumtn+klowBlkM61lkZSNZPHVMBqiDzSQtl+rSFZT4YSjUTZnD
        LpDw/OrHEnX38ng3bzt9YIsSkg==
X-Google-Smtp-Source: APXvYqzkg42eNImOPKjj+twry1oYkan3yacXziqUZevwWM3AKG6aCw79uYsL1yZlNwbv3Kephhv5cg==
X-Received: by 2002:ac8:363c:: with SMTP id m57mr30156349qtb.290.1571014716532;
        Sun, 13 Oct 2019 17:58:36 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id c185sm7663901qkf.122.2019.10.13.17.58.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Oct 2019 17:58:35 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: [Patch v3 7/7] sched: thermal: Enable tuning of decay period
Date:   Sun, 13 Oct 2019 20:58:25 -0400
Message-Id: <1571014705-19646-8-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1571014705-19646-1-git-send-email-thara.gopinath@linaro.org>
References: <1571014705-19646-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thermal pressure follows pelt signas which means the
decay period for thermal pressure is the default pelt
decay period. Depending on soc charecteristics and thermal
activity, it might be beneficial to decay thermal pressure
slower, but still in-tune with the pelt signals.
One way to achieve this slow decay is to right shift the now
run time.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 include/linux/sched/sysctl.h |  1 +
 kernel/sched/thermal.c       | 16 +++++++++++++++-
 kernel/sysctl.c              |  7 +++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index d4f6215..f4c4afd 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -41,6 +41,7 @@ extern unsigned int sysctl_numa_balancing_scan_size;
 #ifdef CONFIG_SCHED_DEBUG
 extern __read_mostly unsigned int sysctl_sched_migration_cost;
 extern __read_mostly unsigned int sysctl_sched_nr_migrate;
+extern __read_mostly unsigned int sysctl_sched_thermal_decay_coeff;
 
 int sched_proc_update_handler(struct ctl_table *table, int write,
 		void __user *buffer, size_t *length,
diff --git a/kernel/sched/thermal.c b/kernel/sched/thermal.c
index 5f0b2d4..2a00488 100644
--- a/kernel/sched/thermal.c
+++ b/kernel/sched/thermal.c
@@ -10,6 +10,19 @@
 #include "pelt.h"
 #include "thermal.h"
 
+/**
+ * By default the decay is the default pelt decay period.
+ * The decay coefficient can change is decay period in
+ * multiples of 32.
+ *   Decay coefficient    Decay period(ms)
+ *	0			32
+ *	1			64
+ *	2			128
+ *	3			256
+ *	4			512
+ */
+unsigned int sysctl_sched_thermal_decay_coeff __read_mostly;
+
 struct max_capacity_info {
 	unsigned long max_capacity;
 	unsigned long cap_capacity;
@@ -62,5 +75,6 @@ void update_periodic_maxcap(struct rq *rq)
 		return;
 
 	delta = __max_cap->max_capacity - __max_cap->cap_capacity;
-	update_thermal_avg(rq_clock_task(rq), rq, delta);
+	update_thermal_avg((rq_clock_task(rq) >>
+			   sysctl_sched_thermal_decay_coeff), rq, delta);
 }
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 00fcea2..5056c08 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -376,6 +376,13 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
+	{
+		.procname	= "sched_thermal_decay_coeff",
+		.data		= &sysctl_sched_thermal_decay_coeff,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
 #ifdef CONFIG_SCHEDSTATS
 	{
 		.procname	= "sched_schedstats",
-- 
2.1.4

