Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0428CC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6302084F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="IFnokjdB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbfDHVqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:46:24 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59404 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726635AbfDHVqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:46:22 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x38LjWlf017034
        for <linux-kernel@vger.kernel.org>; Mon, 8 Apr 2019 14:46:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=71jwMW3DLj1Y0qARI7vL6lQXr6moJopGA2vrTbvAKZY=;
 b=IFnokjdBqKBbNDyHAhzFonMssV3LqPdtM0epDC+Rm1ZlQCjqnHfITvIA9dfznHG/Qq8X
 tvgR3bD4vzKzSyCORx7WxtaQ+vRYuoJrkmtqhVRMNf5FpQCjKV1kT4/R5XfJDOknNd+Y
 vTkYz5QQoGDP9GKKp7GsXm+XyXqJSHQxlSQ= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rre1hr3e7-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 14:46:21 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 8 Apr 2019 14:46:06 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 2840B62E1F66; Mon,  8 Apr 2019 14:46:06 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <vincent.guittot@linaro.org>, <tglx@linutronix.de>,
        <morten.rasmussen@arm.com>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH 5/7] sched/fair: global idleness counter for cpu.headroom
Date:   Mon, 8 Apr 2019 14:45:37 -0700
Message-ID: <20190408214539.2705660-6-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190408214539.2705660-1-songliubraving@fb.com>
References: <20190408214539.2705660-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-08_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a global idleness counter in fair.c for the
cpu.headroom knob. This counter is based on per cpu get_idle_time().

The counter is used via function call:

  unsigned long cfs_global_idleness_update(u64 now, u64 period);

The function returns global idleness in fixed-point percentage since
previous call of the function. If the time between previous call of the
function is called and @now is shorter than @period, the function will
return idleness calculated in previous call.

cfs_global_idleness_update() will be called from a non-preemptible
context, struct cfs_global_idleness uses raw_spin_lock instead of
spin_lock.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 fs/proc/stat.c              |  4 +--
 include/linux/kernel_stat.h |  2 ++
 kernel/sched/fair.c         | 64 +++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 80c305f206bb..b327ffdb169f 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -23,7 +23,7 @@
 
 #ifdef arch_idle_time
 
-static u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
+u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
 {
 	u64 idle;
 
@@ -45,7 +45,7 @@ static u64 get_iowait_time(struct kernel_cpustat *kcs, int cpu)
 
 #else
 
-static u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
+u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
 {
 	u64 idle, idle_usecs = -1ULL;
 
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 7ee2bb43b251..337135272391 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -97,4 +97,6 @@ extern void account_process_tick(struct task_struct *, int user);
 
 extern void account_idle_ticks(unsigned long ticks);
 
+u64 get_idle_time(struct kernel_cpustat *kcs, int cpu);
+
 #endif /* _LINUX_KERNEL_STAT_H */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 65aa9d3b665f..49c68daffe7e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -116,6 +116,62 @@ static unsigned int capacity_margin			= 1280;
  * (default: 5 msec, units: microseconds)
  */
 unsigned int sysctl_sched_cfs_bandwidth_slice		= 5000UL;
+
+/* tracking global idlenesss for cpu.headroom */
+struct cfs_global_idleness {
+	u64		prev_total_idle_time;
+	u64		prev_timestamp;
+	unsigned long	idle_percent; /* fixed-point */
+	raw_spinlock_t	lock;
+};
+
+static struct cfs_global_idleness global_idleness;
+
+/*
+ * Calculate global idleness in fixed-point percentage since previous call
+ * of the function. If the time between previous call of the function is
+ * called and @now is shorter than @period, return idleness calculated in
+ * previous call.
+ */
+static unsigned long cfs_global_idleness_update(u64 now, u64 period)
+{
+	u64 prev_timestamp, total_idle_time, delta_idle_time;
+	unsigned long idle_percent;
+	int cpu;
+
+	/*
+	 * Fastpath: if idleness has been updated within the last period
+	 * of time, just return previous idleness.
+	 */
+	prev_timestamp = READ_ONCE(global_idleness.prev_timestamp);
+	if (prev_timestamp + period >= now)
+		return READ_ONCE(global_idleness.idle_percent);
+
+	raw_spin_lock_irq(&global_idleness.lock);
+	if (global_idleness.prev_timestamp + period >= now) {
+		idle_percent = global_idleness.idle_percent;
+		goto out;
+	}
+
+	/* Slowpath: calculate the average idleness since prev_timestamp */
+	total_idle_time = 0;
+	for_each_online_cpu(cpu)
+		total_idle_time += get_idle_time(&kcpustat_cpu(cpu), cpu);
+
+	delta_idle_time = total_idle_time -
+		global_idleness.prev_total_idle_time;
+
+	idle_percent = div64_u64((delta_idle_time << FSHIFT) * 100,
+				 num_online_cpus() *
+				 (now - global_idleness.prev_timestamp));
+
+	WRITE_ONCE(global_idleness.prev_total_idle_time, total_idle_time);
+	WRITE_ONCE(global_idleness.prev_timestamp, now);
+	WRITE_ONCE(global_idleness.idle_percent, idle_percent);
+out:
+	raw_spin_unlock_irq(&global_idleness.lock);
+	return idle_percent;
+}
 #endif
 
 static inline void update_load_add(struct load_weight *lw, unsigned long inc)
@@ -4293,6 +4349,11 @@ void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
 	cfs_b->runtime = cfs_b->quota;
 	cfs_b->runtime_expires = now + ktime_to_ns(cfs_b->period);
 	cfs_b->expires_seq++;
+
+	if (cfs_b->target_idle == 0)
+		return;
+
+	cfs_global_idleness_update(now, cfs_b->period);
 }
 
 static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
@@ -10676,4 +10737,7 @@ __init void init_sched_fair_class(void)
 #endif
 #endif /* SMP */
 
+#ifdef CONFIG_CFS_BANDWIDTH
+	raw_spin_lock_init(&global_idleness.lock);
+#endif
 }
-- 
2.17.1

