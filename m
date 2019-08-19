Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74699C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BDB2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfHSHMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 03:12:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5149 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726366AbfHSHMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 03:12:34 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 44AB9E5B4BA9EF0B5EE1;
        Mon, 19 Aug 2019 15:12:32 +0800 (CST)
Received: from [127.0.0.1] (10.133.211.147) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Mon, 19 Aug 2019
 15:12:25 +0800
From:   c00423981 <caomeng5@huawei.com>
Subject: [PATCH] cpustat: print watchdog time and statistics of soft and hard
 interrupts in soft lockup scenes
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Message-ID: <60319e82-3c2b-ff24-4ba7-4d58048130ff@huawei.com>
Date:   Mon, 19 Aug 2019 15:12:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.211.147]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we cannot determine quickly if a soft lockup occurrs, and
do not know what the cpu is doing in soft lockup scenes neither.

The new feature adds a new interface(/proc/cpuirqstat) to view
the statistics of interrupts in real time on a certain cpu, as well as
the time occupancy of user space, system space and so on. Also, we can
view the time after the last-time watchdog which is named cpu time.
If cpu time is longer than twice of watchdot_thresh, a soft lockup occurrs.

The feature enhances the ability of solving problems in soft lockup scenes.

For example, if we want to view the statistics of interrupts on cpu 1, we can
enter the following command to set the cpu index:
		echo 1 > /proc/cpuirqstat
And we can enter the following command to view the statistics:
		cat /proc/cpuirqstat
Then, the result is as follows:

cpu index: 1
cpu time: 2283720189 ns(HZ: 1000)
occupied: 1000000 us, 3000000 sy, 0 ni, 2269677000 id, 2709000 wa, 0 hi, 0 si, 2000000 st
softirq:
         TIMER: 73
        NET_TX: 10
        NET_RX: 26
         BLOCK: 1
         SCHED: 22
           RCU: 37
hardirq:
     irq(  72): delta     88, total:         0, timer4
     irq(  73): delta      2, total:         0, resched4

Also, we creat a watchdog thread for each cpu, and the watchdog
thread is used to check if soft lockup occurs. If so, the statistics
of interrupts will be printed automatically.


Signed-off-by: Meng Cao <caomeng5@huawei.com>
Signed-off-by: Chunmei Xu <xuchunmei@huawei.com>
Suggested-by: Feilong Lin <linfeilong@kernel.org>
Reviewed-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Reviewed-by: Jingxian He <hejingxian@huawei.com>

---
 kernel/cpustat.c | 214 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/cpustat.h |   7 ++
 2 files changed, 221 insertions(+)
 create mode 100644 kernel/cpustat.c
 create mode 100644 kernel/cpustat.h

diff --git a/kernel/cpustat.c b/kernel/cpustat.c
new file mode 100644
index 0000000..bb16160
--- /dev/null
+++ b/kernel/cpustat.c
@@ -0,0 +1,214 @@
+/*
+ * Copyright (C) 2016 Huawei Ltd
+ */
+#include <linux/kernel_stat.h>
+#include <linux/time.h>
+#include <linux/tick.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+
+struct cpustat_info {
+	struct kernel_stat kstat;
+	struct kernel_cpustat cpustat;
+	unsigned long timestamp;
+};
+
+static struct cpustat_info __percpu *cpustat_data;
+
+#define cpustat_last_softirqs(cpu, i)  \
+	(per_cpu_ptr(cpustat_data, (cpu))->kstat.softirqs[i])
+#define cpustat_last_cputime(cpu, i)   \
+	(per_cpu_ptr(cpustat_data, (cpu))->cpustat.cpustat[i])
+#define cpustat_timestamp(cpu)         \
+	(per_cpu_ptr(cpustat_data, (cpu))->timestamp)
+
+static unsigned int cpustat_cpu_num;
+#define cpustat_print(m, args...)	\
+do {					\
+	if (m)				\
+		seq_printf(m, args);	\
+	else				\
+		pr_warn(args);		\
+} while (0)
+
+static u64 cpustat_curr_cputime(int cpu, int index)
+{
+	u64 time;
+
+	if (index == CPUTIME_IDLE)
+		time = get_idle_time(cpu);
+	else if (index == CPUTIME_IOWAIT)
+		time = get_iowait_time(cpu);
+	else
+		time = kcpustat_cpu(cpu).cpustat[index];
+
+	return time;
+}
+
+static void cpustat_update_cputime(int cpu)
+{
+	int i;
+
+	for (i = 0; i < NR_STATS; i++)
+		cpustat_last_cputime(cpu, i) = cpustat_curr_cputime(cpu, i);
+
+	cpustat_timestamp(cpu) = ktime_to_ns(ktime_get());
+}
+
+static void cpustat_update_softirq(int cpu)
+{
+	int i;
+
+	for (i = 0; i < NR_SOFTIRQS; i++)
+		cpustat_last_softirqs(cpu, i) = kstat_softirqs_cpu(i, cpu);
+}
+
+static void cpustat_print_softirq(int cpu, struct seq_file *m)
+{
+	int i;
+	unsigned long count;
+
+	cpustat_print(m, "softirq:\n");
+	for (i = 0; i < NR_SOFTIRQS; i++) {
+		count = kstat_softirqs_cpu(i, cpu) -
+			cpustat_last_softirqs(cpu, i);
+		if (count)
+			cpustat_print(m, "%14s: %lu\n", softirq_to_name[i], count);
+	}
+}
+
+static void cpustat_print_hardirq(int cpu, struct seq_file *m)
+{
+	int irq;
+	unsigned long flag = 0;
+	unsigned int stat, diff;
+	struct irq_desc *desc;
+
+	cpustat_print(m, "hardirq:\n");
+	for_each_irq_desc(irq, desc) {
+		if (!desc)
+			continue;
+
+		stat = kstat_irqs_cpu(irq, cpu);
+		diff = kstat_irqs_diff_cpu(irq, cpu);
+		if (diff) {
+			cpustat_print(m, "     irq(%4d): delta %6u, total: %9u, %s\n",
+				irq, diff, stat,
+				desc->action ? desc->action->name : "none");
+			flag++;
+		}
+	}
+	if (flag == 0)
+		cpustat_print(m, "		no hard irqs found.\n");
+}
+
+void cpustat_update_cpu(void)
+{
+	int cpu;
+
+	if (!cpustat_data)
+		return;
+	cpu = smp_processor_id();
+	cpustat_update_cputime(cpu);
+	cpustat_update_softirq(cpu);
+	kstat_irq_update();
+}
+
+static void cpustat_print_cputime(int cpu, struct seq_file *m)
+{
+	int i;
+	unsigned long time;
+	u64 cputime[NR_STATS];
+
+	for (i = 0; i < NR_STATS; i++) {
+		cputime[i] = cpustat_curr_cputime(cpu, i);
+		cputime[i] -= cpustat_last_cputime(cpu, i);
+	}
+
+	time = ktime_to_ns(ktime_get()) - cpustat_timestamp(cpu);
+	cpustat_print(m, "cpu time: %lu ns(HZ: %d)\n", time, HZ);
+	cpustat_print(m, "occupied: %llu us, %llu sy, %llu ni,"
+		" %llu id, %llu wa, %llu hi, %llu si, %llu st\n",
+		cputime[CPUTIME_USER],
+		cputime[CPUTIME_SYSTEM],
+		cputime[CPUTIME_NICE],
+		cputime[CPUTIME_IDLE],
+		cputime[CPUTIME_IOWAIT],
+		cputime[CPUTIME_IRQ],
+		cputime[CPUTIME_SOFTIRQ],
+		cputime[CPUTIME_STEAL]);
+}
+
+void cpustat_print_cpu(void)
+{
+	int cpu;
+
+	if (!cpustat_data)
+		return;
+	cpu = smp_processor_id();
+	cpustat_print_cputime(cpu, NULL);
+	cpustat_print_softirq(cpu, NULL);
+	cpustat_print_hardirq(cpu, NULL);
+}
+
+static ssize_t proc_cpustat_write(struct file *file, const char __user *ubuf,
+		size_t cnt, loff_t *ppos)
+{
+	unsigned int val;
+	int ret;
+
+	ret = kstrtouint_from_user(ubuf, cnt, 0, &val);
+	if (ret) {
+		pr_err("[cpustat]: parse input parameter failed.\n");
+		return ret;
+	}
+
+	if (val >= num_online_cpus())
+		return -EINVAL;
+
+	cpustat_cpu_num = val;
+
+	return cnt;
+}
+
+static int cpustat_proc_show(struct seq_file *m, void *s)
+{
+	unsigned int cpu_num = cpustat_cpu_num;
+
+	if (cpu_num >= num_online_cpus())
+		return -EINVAL;
+
+	cpustat_print(m, "cpu index: %u\n", cpu_num);
+
+	cpustat_print_cputime(cpu_num, m);
+	cpustat_print_softirq(cpu_num, m);
+	cpustat_print_hardirq(cpu_num, m);
+	return 0;
+}
+
+static int proc_cpustat_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, cpustat_proc_show, PDE_DATA(inode));
+}
+
+static const struct file_operations proc_cpustat_file_operations = {
+	.owner		= THIS_MODULE,
+	.open		= proc_cpustat_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+	.write		= proc_cpustat_write,
+};
+
+void cpustat_init(void)
+{
+	cpustat_data = __alloc_percpu(sizeof(struct cpustat_info), 8);
+	if (!cpustat_data) {
+		pr_err("alloc percpu cpustat_info fail.\n");
+		return;
+	}
+
+	if (!proc_create("cpuirqstat", S_IRUSR|S_IWUSR, NULL, &proc_cpustat_file_operations)) {
+		pr_err("[cpuirqstat]: create /proc/cpuirqstat failed.\n");
+	}
+}
diff --git a/kernel/cpustat.h b/kernel/cpustat.h
new file mode 100644
index 0000000..7a79ee8
--- /dev/null
+++ b/kernel/cpustat.h
@@ -0,0 +1,7 @@
+#ifndef LINUX_CPUSTAT_H
+#define LINUX_CPUSTAT_H
+
+extern void cpustat_init(void);
+extern void cpustat_print_cpu(void);
+extern void cpustat_update_cpu(void);
+#endif
-- 
1.8.3.1


