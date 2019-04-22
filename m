Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=FROM_EXCESS_BASE64,
	FUZZY_AMBIEN,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E68C10F14
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 02:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839ED20833
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 02:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfDVCVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 22:21:23 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:46636 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726292AbfDVCVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 22:21:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TPtsYiU_1555899677;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TPtsYiU_1555899677)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 22 Apr 2019 10:21:17 +0800
Subject: [RFC PATCH 5/5] numa: numa balancer
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
To:     Peter Zijlstra <peterz@infradead.org>, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
Message-ID: <85bcd381-ef27-ddda-6069-1f1d80cf296a@linux.alibaba.com>
Date:   Mon, 22 Apr 2019 10:21:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

numa balancer is a module which will try to automatically adjust numa
balancing stuff to gain numa bonus as much as possible.

For each memory cgroup, we process the work in two steps:

On stage 1 we check cgroup's exectime and memory topology to see
if there could be a candidate for settled down, if we got one then
move onto stage 2.

On stage 2 we try to settle down as much as possible by prefer the
candidate node, if the node no longer suitable or locality keep
downturn, we reset things and new round begin.

Decision made with find_candidate_nid(), should_prefer() and keep_prefer(),
which try to pick a candidate node, see if allowed to prefer it and if
keep doing the prefer.

Tested on the box with 96 cpus with sysbench-mysql-oltp_read_write
testing, 4 mysqld instances created and attached to 4 cgroups, 4
sysbench instances then created and attached to corresponding cgroup
to test the mysql with oltp_read_write script, average eps show:

				origin		balancer
4 instances each 12 threads	5241.08		5375.59		+2.50%
4 instances each 24 threads	7497.29		7820.73		+4.13%
4 instances each 36 threads	8985.44		9317.04		+3.55%
4 instances each 48 threads	9716.50		9982.60		+2.66%

Other benchmark liks dbench, pgbench, perf bench numa also tested, and
with different parameters and number of instances/threads, most of
the cases show bonus, some show acceptable regression, and some got no
changes.

TODO:
  * improve the logical to address the regression cases
  * Find a way, maybe, to handle the page cache left on remote
  * find more scenery which could gain benefit

Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
---
 drivers/Makefile             |   1 +
 drivers/numa/Makefile        |   1 +
 drivers/numa/numa_balancer.c | 715 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 717 insertions(+)
 create mode 100644 drivers/numa/Makefile
 create mode 100644 drivers/numa/numa_balancer.c

diff --git a/drivers/Makefile b/drivers/Makefile
index c61cde554340..f07936b03870 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -187,3 +187,4 @@ obj-$(CONFIG_UNISYS_VISORBUS)	+= visorbus/
 obj-$(CONFIG_SIOX)		+= siox/
 obj-$(CONFIG_GNSS)		+= gnss/
 obj-$(CONFIG_INTERCONNECT)	+= interconnect/
+obj-$(CONFIG_NUMA_BALANCING)	+= numa/
diff --git a/drivers/numa/Makefile b/drivers/numa/Makefile
new file mode 100644
index 000000000000..acf8a4083333
--- /dev/null
+++ b/drivers/numa/Makefile
@@ -0,0 +1 @@
+obj-m	+= numa_balancer.o
diff --git a/drivers/numa/numa_balancer.c b/drivers/numa/numa_balancer.c
new file mode 100644
index 000000000000..25bbe08c82a2
--- /dev/null
+++ b/drivers/numa/numa_balancer.c
@@ -0,0 +1,715 @@
+/*
+ * NUMA Balancer
+ *
+ *  Copyright (C) 2019 Alibaba Group Holding Limited.
+ *  Author: Michael Wang <yun.wang@linux.alibaba.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/module.h>
+#include <linux/memcontrol.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/kthread.h>
+#include <linux/kernel_stat.h>
+#include <linux/vmstat.h>
+
+static unsigned int debug_level;
+module_param(debug_level, uint, 0644);
+MODULE_PARM_DESC(debug_level, "1 to print decisions, 2 to print both decisions and node info");
+
+static int prefer_level = 10;
+module_param(prefer_level, int, 0644);
+MODULE_PARM_DESC(prefer_level, "stop numa prefer when reach this much continuous downturn, 0 means no prefer");
+
+static unsigned int locality_level = PERCENT_70_79;
+module_param(locality_level, uint, 0644);
+MODULE_PARM_DESC(locality_level, "consider locality as good when above this sector");
+
+static unsigned long period_max = (600 * HZ);
+module_param(period_max, ulong, 0644);
+MODULE_PARM_DESC(period_max, "maximum period between each stage");
+
+static unsigned long period_min = (5 * HZ);
+module_param(period_min, ulong, 0644);
+MODULE_PARM_DESC(period_min, "minimum period between each stage");
+
+static unsigned int cpu_high_wmark = 100;
+module_param(cpu_high_wmark, uint, 0644);
+MODULE_PARM_DESC(cpu_high_wmark, "respect the execution percent rather than memory percent when above this cpu usage");
+
+static unsigned int cpu_low_wmark = 10;
+module_param(cpu_low_wmark, uint, 0644);
+MODULE_PARM_DESC(cpu_low_wmark, "consider cgroup as active when above this cpu usage");
+
+static unsigned int free_low_wmark = 10;
+module_param(free_low_wmark, uint, 0644);
+MODULE_PARM_DESC(free_low_wmark, "consider node as consumed out when below this free percent");
+
+static unsigned int candidate_wmark = 60;
+module_param(candidate_wmark, uint, 0644);
+MODULE_PARM_DESC(candidate_wmark, "consider node as candidate when above this execution time or memory percent");
+
+static unsigned int settled_wmark = 90;
+module_param(settled_wmark, uint, 0644);
+MODULE_PARM_DESC(settled_wmark, "consider cgroup settle down on node when above this execution time and memory percent, or locality");
+
+/*
+ * STAGE_1 -- no preferred node
+ *
+ * STAGE_2 -- preferred node setted
+ *
+ * Check handlers for details.
+ */
+enum {
+	STAGE_1,
+	STAGE_2,
+	NR_STAGES,
+};
+
+struct node_info {
+	u64 anon;
+	u64 pages;
+	u64 exectime;
+	u64 exectime_history;
+
+	u64 ticks;
+	u64 ticks_history;
+	u64 idle;
+	u64 idle_history;
+
+	u64 total_pages;
+	u64 free_pages;
+
+	unsigned int exectime_percent;
+	unsigned int last_exectime_percent;
+	unsigned int anon_percent;
+	unsigned int pages_percent;
+	unsigned int free_percent;
+	unsigned int idle_percent;
+	unsigned int cpu_usage;
+};
+
+struct numa_balancer {
+	struct delayed_work dwork;
+	struct mem_cgroup *memcg;
+	struct node_info *ni;
+
+	unsigned long period;
+	unsigned long jstamp;
+
+	u64 locality_good;
+	u64 locality_sum;
+	u64 anon_sum;
+	u64 pages_sum;
+	u64 exectime_sum;
+	u64 free_pages_sum;
+
+	unsigned int stage;
+	unsigned int cpu_usage_sum;
+	unsigned int locality_score;
+	unsigned int downturn;
+
+	int anon_max_nid;
+	int pages_max_nid;
+	int exectime_max_nid;
+	int candidate_nid;
+};
+
+static struct workqueue_struct *numa_balancer_wq;
+
+/*
+ * Kernel increase the locality counter when hit memcg's task running
+ * on each tick, classified according to the percentage of local page
+ * access.
+ *
+ * This can representing the NUMA benefit, higher the locality lower
+ * the memory access latency, thus we calculate a score here to tell
+ * how well the memcg is playing with NUMA.
+ *
+ * The score is simplly the percentage of ticks above locality_level,
+ * which usually from 0 to 100, -1 means no ticks.
+ *
+ * For example, score 90 with locality_level 7 means there are 90
+ * percentage of the ticks hit memcg's tasks running above 79% local
+ * page access on numa page fault.
+ */
+static inline void update_locality_score(struct numa_balancer *nb)
+{
+	int i, cpu;
+	u64 good, sum, tmp;
+	unsigned int last_locality_score = nb->locality_score;
+	struct memcg_stat_numa *stat = nb->memcg->stat_numa;
+
+	nb->locality_score = -1;
+
+	for (good = sum = i = 0; i < NR_NL_INTERVAL; i++) {
+		for_each_possible_cpu(cpu) {
+			u64 val = per_cpu(stat->locality[i], cpu);
+
+			good += i > locality_level ? val : 0;
+			sum += val;
+		}
+	}
+
+	tmp = nb->locality_good;
+	nb->locality_good = good;
+	good -= tmp;
+
+	tmp = nb->locality_sum;
+	nb->locality_sum = sum;
+	sum -= tmp;
+
+	if (sum)
+		nb->locality_score = (good * 100) / sum;
+
+	if (nb->locality_score == -1 ||
+	    nb->locality_score > settled_wmark ||
+	    nb->locality_score > last_locality_score)
+		nb->downturn = 0;
+	else
+		nb->downturn++;
+}
+
+static inline void update_numa_info(struct numa_balancer *nb)
+{
+	int nid;
+	unsigned long period_in_jiffies = jiffies - nb->jstamp;
+	struct memcg_stat_numa *stat = nb->memcg->stat_numa;
+
+	if (period_in_jiffies <= 0)
+		return;
+
+	nb->anon_sum = nb->pages_sum = nb->exectime_sum = 0;
+	nb->anon_max_nid = nb->pages_max_nid = nb->exectime_max_nid = 0;
+
+	nb->free_pages_sum = 0;
+
+	for_each_online_node(nid) {
+		int cpu, zid;
+		u64 idle_curr, ticks_curr, exectime_curr;
+		struct node_info *nip = &nb->ni[nid];
+
+		nip->total_pages = nip->free_pages = 0;
+		for (zid = 0; zid <= ZONE_MOVABLE; zid++) {
+			pg_data_t *pgdat = NODE_DATA(nid);
+			struct zone *z = &pgdat->node_zones[zid];
+
+			nip->total_pages += zone_managed_pages(z);
+			nip->free_pages  += zone_page_state(z, NR_FREE_PAGES);
+		}
+
+		idle_curr = ticks_curr = exectime_curr = 0;
+		for_each_cpu(cpu, cpumask_of_node(nid)) {
+			u64 *cstat = kcpustat_cpu(cpu).cpustat;
+
+			/* not accurate but fine */
+			idle_curr += cstat[CPUTIME_IDLE];
+			ticks_curr +=
+				cstat[CPUTIME_USER] + cstat[CPUTIME_NICE] +
+				cstat[CPUTIME_SYSTEM] + cstat[CPUTIME_IDLE] +
+				cstat[CPUTIME_IOWAIT] + cstat[CPUTIME_IRQ] +
+				cstat[CPUTIME_SOFTIRQ] + cstat[CPUTIME_STEAL];
+
+			exectime_curr += per_cpu(stat->exectime, cpu);
+		}
+
+		nip->ticks = ticks_curr - nip->ticks_history;
+		nip->ticks_history = ticks_curr;
+
+		nip->idle = idle_curr - nip->idle_history;
+		nip->idle_history = idle_curr;
+
+		nip->idle_percent = nip->idle * 100 / nip->ticks;
+
+		nip->exectime = exectime_curr - nip->exectime_history;
+		nip->exectime_history = exectime_curr;
+
+		nip->anon = memcg_numa_pages(nb->memcg, nid, LRU_ALL_ANON);
+		nip->pages = memcg_numa_pages(nb->memcg, nid, LRU_ALL);
+
+		if (nip->anon > nb->ni[nb->anon_max_nid].anon)
+			nb->anon_max_nid = nid;
+
+		if (nip->pages > nb->ni[nb->pages_max_nid].pages)
+			nb->pages_max_nid = nid;
+
+		if (nip->exectime > nb->ni[nb->exectime_max_nid].exectime)
+			nb->exectime_max_nid = nid;
+
+		nb->anon_sum += nip->anon;
+		nb->pages_sum += nip->pages;
+		nb->exectime_sum += nip->exectime;
+		nb->free_pages_sum += nip->free_pages;
+	}
+
+	for_each_online_node(nid) {
+		struct node_info *nip = &nb->ni[nid];
+
+		nip->last_exectime_percent = nip->exectime_percent;
+		nip->exectime_percent = nb->exectime_sum ?
+			nip->exectime * 100 / nb->exectime_sum : 0;
+
+		nip->anon_percent = nb->anon_sum ?
+			nip->anon * 100 / nb->anon_sum : 0;
+
+		nip->pages_percent = nb->pages_sum ?
+			nip->pages * 100 / nb->pages_sum : 0;
+
+		nip->free_percent = nip->total_pages ?
+			nip->free_pages * 100 / nip->total_pages : 0;
+
+		nip->cpu_usage = nip->exectime * 100 / period_in_jiffies;
+	}
+
+	nb->cpu_usage_sum = nb->exectime_sum * 100 / period_in_jiffies;
+	nb->jstamp = jiffies;
+}
+
+/*
+ * We consider a node as candidate when settle down is more easier,
+ * which means page and task migration should as less as possible.
+ *
+ * However, usually it's impossible to find an ideal candidate since
+ * kernel have no idea about the cgroup numa affinity, thus we need
+ * to pick out the most likely winner and play gambling.
+ */
+static inline int find_candidate_nid(struct numa_balancer *nb)
+{
+	int cnid = -1;
+	int enid = nb->exectime_max_nid;
+	int pnid = nb->pages_max_nid;
+	int anid = nb->anon_max_nid;
+	struct node_info *nip;
+
+	/*
+	 * settled execution percent could imply the only available
+	 * node for running, respect this firstly.
+	 */
+	nip = &nb->ni[enid];
+	if (nb->cpu_usage_sum > cpu_high_wmark &&
+	    nip->exectime_percent > settled_wmark) {
+		cnid = enid;
+		goto out;
+	}
+
+	/*
+	 * Migrate page cost a lot, if the node is available for
+	 * running and most of the pages reside there, just pick it.
+	 */
+	nip = &nb->ni[pnid];
+	if (nip->exectime_percent &&
+	    nip->pages_percent > candidate_wmark) {
+		cnid = pnid;
+		goto out;
+	}
+
+	/*
+	 * Now pick the node when most of the execution time and
+	 * anonymous pages already there.
+	 */
+	nip = &nb->ni[anid];
+	if (nip->exectime_percent > candidate_wmark &&
+	    nip->anon_percent > candidate_wmark) {
+		cnid = anid;
+		goto out;
+	}
+
+	/*
+	 * No strong hint so we reach here, respect the load balancing
+	 * and play gambling.
+	 */
+	nip = &nb->ni[enid];
+	if (nb->cpu_usage_sum > cpu_high_wmark &&
+	    nip->exectime_percent > candidate_wmark) {
+		cnid = enid;
+		goto out;
+	}
+
+out:
+	nb->candidate_nid = cnid;
+	return cnid;
+}
+
+static inline unsigned long clip_period(unsigned long period)
+{
+	if (period < period_min)
+		return period_min;
+	if (period > period_max)
+		return period_max;
+	return period;
+}
+
+static inline void increase_period(struct numa_balancer *nb)
+{
+	nb->period = clip_period(nb->period * 2);
+}
+
+static inline void decrease_period(struct numa_balancer *nb)
+{
+	nb->period = clip_period(nb->period / 2);
+}
+
+static inline bool is_zombie(struct numa_balancer *nb)
+{
+	return (nb->cpu_usage_sum < cpu_low_wmark);
+}
+
+static inline bool is_settled(struct numa_balancer *nb, int nid)
+{
+	return (nb->ni[nid].exectime_percent > settled_wmark &&
+		nb->ni[nid].pages_percent > settled_wmark);
+}
+
+static inline void
+__memcg_printk(struct mem_cgroup *memcg, const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+	const char *name = memcg->css.cgroup->kn->name;
+
+	if (!debug_level)
+		return;
+
+	if (*name == '\0')
+		name = "root";
+
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+	pr_notice("%s: [%s] %pV",
+		KBUILD_MODNAME, name, &vaf);
+	va_end(args);
+}
+
+static inline void
+__nb_printk(struct numa_balancer *nb, const char *fmt, ...)
+{
+	int nid;
+	struct va_format vaf;
+	va_list args;
+	const char *name = nb->memcg->css.cgroup->kn->name;
+
+	if (!debug_level)
+		return;
+
+	if (*name == '\0')
+		name = "root";
+
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+	pr_notice("%s: [%s][stage %d] cpu %d%% %pV",
+		KBUILD_MODNAME, name, nb->stage, nb->cpu_usage_sum, &vaf);
+	va_end(args);
+
+	if (debug_level < 2)
+		return;
+
+	for_each_online_node(nid) {
+		struct node_info *nip = &nb->ni[nid];
+
+		pr_notice("%s: [%s][stage %d]\tnid %d exectime %llu[%d%%] anon %llu[%d%%] pages %llu[%d%%] idle [%d%%] free [%d%%]\n",
+			KBUILD_MODNAME, name, nb->stage,
+			nid, nip->exectime, nip->exectime_percent,
+			nip->anon, nip->anon_percent,
+			nip->pages, nip->pages_percent, nip->idle_percent,
+			nip->free_percent);
+	}
+}
+
+#define nb_printk(fmt...)	__nb_printk(nb, fmt)
+#define memcg_printk(fmt...)	__memcg_printk(memcg, fmt)
+
+static inline void reset_stage(struct numa_balancer *nb)
+{
+	nb->stage		= STAGE_1;
+	nb->period		= period_min;
+	nb->candidate_nid	= NUMA_NO_NODE;
+	nb->locality_score	= -1;
+	nb->downturn		= 0;
+
+	config_numa_preferred(nb->memcg, -1);
+}
+
+/*
+ * In most of the cases, we need to give kernel the hint of memcg
+ * preference in order to settle down on a particular node, the benefit
+ * is obviously while the risk too.
+ *
+ * Prefer behaviour could cause global influence and become a trigger
+ * for other memcg to make their own decision, ideally different memcg
+ * workloads will change their resources then settle down on different
+ * nodes, make resource balanced again and gain maximum numa benefit.
+ */
+static inline bool should_prefer(struct numa_balancer *nb, int cnid)
+{
+	struct node_info *cnip = &nb->ni[cnid];
+	u64 cpu_left, cpu_to_move, mem_left, mem_to_move;
+
+	if (nb->downturn >= prefer_level ||
+	    cnip->free_percent < free_low_wmark ||
+	    cnip->idle_percent < free_low_wmark)
+		return false;
+
+	/*
+	 * We don't want to cause starving on a particular node,
+	 * while there are race conditions and it's impossible to
+	 * predict the resource requirement in future, so risk can't
+	 * be avoided.
+	 *
+	 * Fortunately kernel won't respect numa prefer anymore if
+	 * things going to get worse :-P
+	 */
+	cpu_left = cpumask_weight(cpumask_of_node(cnid)) * 100 *
+			(cnip->idle_percent - free_low_wmark);
+	cpu_to_move = nb->cpu_usage_sum - cnip->cpu_usage;
+	if (cpu_left < cpu_to_move)
+		return false;
+
+	mem_left = cnip->total_pages *
+			(cnip->free_percent - free_low_wmark);
+	mem_to_move = nb->pages_sum - cnip->pages;
+	if (mem_left < mem_to_move)
+		return false;
+
+	return true;
+}
+
+static void STAGE_1_handler(struct numa_balancer *nb)
+{
+	int cnid;
+	struct node_info *cnip;
+
+	if (is_zombie(nb)) {
+		reset_stage(nb);
+		increase_period(nb);
+		nb_printk("zombie, silent for %lu seconds\n", nb->period / HZ);
+		return;
+	}
+
+	update_locality_score(nb);
+
+	cnid = find_candidate_nid(nb);
+	if (cnid == NUMA_NO_NODE) {
+		increase_period(nb);
+		nb_printk("no candidate locality %d%%, silent for %lu seconds\n",
+				nb->locality_score, nb->period / HZ);
+		return;
+	}
+
+	cnip = &nb->ni[cnid];
+	if (is_settled(nb, cnid)) {
+		increase_period(nb);
+		nb_printk("settle down node %d exectime %d%% pages %d%% locality %d%%, silent for %lu seconds\n",
+				cnid, cnip->exectime_percent,
+				cnip->pages_percent, nb->locality_score,
+				nb->period / HZ);
+		return;
+	}
+
+	if (!should_prefer(nb, cnid)) {
+		increase_period(nb);
+		nb_printk("discard node %d exectime %d%% pages %d%% locality %d%% free %d%%, silent for %lu seconds\n",
+				cnid, cnip->exectime_percent,
+				cnip->pages_percent, nb->locality_score,
+				cnip->free_percent, nb->period / HZ);
+		return;
+	}
+
+	nb_printk("prefer node %d exectime %d%% pages %d%% locality %d%% free %d%%, goto next stage\n",
+			cnid, cnip->exectime_percent, cnip->pages_percent,
+			nb->locality_score, cnip->free_percent);
+
+	config_numa_preferred(nb->memcg, cnid);
+
+	nb->stage++;
+	nb->period = period_min;
+}
+
+/*
+ * A tough decision here, as soon as we giveup prefer the node,
+ * kernel will lost the hint on memcg CPU preference, in good case
+ * tasks will still running on the right node since numa balancing
+ * preferred, but no more guarantees.
+ */
+static inline bool keep_prefer(struct numa_balancer *nb, int cnid)
+{
+	struct node_info *cnip = &nb->ni[cnid];
+
+	if (nb->downturn >= prefer_level)
+		return false;
+
+	/* stop prefer a harsh node */
+	if (cnip->free_percent < free_low_wmark ||
+	    cnip->idle_percent < free_low_wmark)
+		return false;
+
+	if (nb->locality_score > settled_wmark ||
+	    cnip->exectime_percent > settled_wmark)
+		return true;
+
+	if (cnip->exectime_percent > cnip->last_exectime_percent)
+		return true;
+
+	/*
+	 * kernel will make sure the balancing won't be broken, which
+	 * means some task won't stay on the preferred node when
+	 * balancing failed too much, imply that we should stop the
+	 * prefer behaviour to avoid the possible cpu starving on
+	 * the preferred node.
+	 *
+	 * Or maybe the current preferred node just haven't got enough
+	 * available cpus for memcg anymore.
+	 */
+	if (cnip->exectime_percent < candidate_wmark ||
+	    nb->exectime_max_nid != cnid)
+		return false;
+
+	return true;
+}
+
+static void STAGE_2_handler(struct numa_balancer *nb)
+{
+	int cnid;
+	struct node_info *cnip;
+
+	if (is_zombie(nb)) {
+		nb_printk("zombie, reset stage\n");
+		reset_stage(nb);
+		return;
+	}
+
+	cnid = nb->candidate_nid;
+	cnip = &nb->ni[cnid];
+
+	update_locality_score(nb);
+
+	if (keep_prefer(nb, cnid)) {
+		if (is_settled(nb, cnid))
+			increase_period(nb);
+		else
+			decrease_period(nb);
+
+		nb_printk("tangled node %d exectime %d%% pages %d%% locality %d%% free %d%%, silent for %lu seconds\n",
+				cnid, cnip->exectime_percent,
+				cnip->pages_percent, nb->locality_score,
+				cnip->free_percent, nb->period / HZ);
+		return;
+	}
+
+	nb_printk("giveup node %d exectime %d%% pages %d%% locality %d%% downturn %d free %d%%, reset stage\n",
+			cnid, cnip->exectime_percent, cnip->pages_percent,
+			nb->locality_score, nb->downturn, cnip->free_percent);
+
+	reset_stage(nb);
+}
+
+static void (*stage_handler[NR_STAGES])(struct numa_balancer *nb) = {
+	&STAGE_1_handler,
+	&STAGE_2_handler,
+};
+
+static void numa_balancer_workfn(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct numa_balancer *nb =
+			container_of(dwork, struct numa_balancer, dwork);
+
+	update_numa_info(nb);
+	(stage_handler[nb->stage])(nb);
+	cond_resched();
+
+	queue_delayed_work(numa_balancer_wq, &nb->dwork, nb->period);
+}
+
+static void memcg_init_handler(struct mem_cgroup *memcg)
+{
+	struct numa_balancer *nb = memcg->numa_private;
+
+	if (!nb) {
+		nb = kzalloc(sizeof(struct numa_balancer), GFP_KERNEL);
+		if (!nb) {
+			pr_err("allocate balancer private failed\n");
+			return;
+		}
+
+		nb->ni = kcalloc(nr_online_nodes, sizeof(*nb->ni), GFP_KERNEL);
+		if (!nb->ni) {
+			pr_err("allocate balancer node info failed\n");
+			kfree(nb);
+			return;
+		}
+
+		nb->memcg = memcg;
+		memcg->numa_private = nb;
+
+		INIT_DELAYED_WORK(&nb->dwork, numa_balancer_workfn);
+	}
+
+	reset_stage(nb);
+	update_numa_info(nb);
+	update_locality_score(nb);
+
+	queue_delayed_work(numa_balancer_wq, &nb->dwork, nb->period);
+	memcg_printk("NUMA Balancer On\n");
+}
+
+static void memcg_exit_handler(struct mem_cgroup *memcg)
+{
+	struct numa_balancer *nb = memcg->numa_private;
+
+	if (nb) {
+		cancel_delayed_work_sync(&nb->dwork);
+
+		kfree(nb->ni);
+		kfree(nb);
+		memcg->numa_private = NULL;
+	}
+
+	config_numa_preferred(memcg, -1);
+	memcg_printk("NUMA Balancer Off\n");
+}
+
+struct memcg_callback cb = {
+	.init = memcg_init_handler,
+	.exit = memcg_exit_handler,
+};
+
+static int __init numa_balancer_init(void)
+{
+	if (nr_online_nodes < 2) {
+		pr_err("Single node arch don't need numa balancer\n");
+		return -EINVAL;
+	}
+
+	numa_balancer_wq = create_workqueue("numa_balancer");
+	if (!numa_balancer_wq) {
+		pr_err("Create workqueue failed\n");
+		return -ENOMEM;
+	}
+
+	if (register_memcg_callback(&cb) != 0) {
+		pr_err("Register memcg callback failed\n");
+		return -EINVAL;
+	}
+
+	pr_notice(KBUILD_MODNAME ": Initialization Done\n");
+	return 0;
+}
+
+static void __exit numa_balancer_exit(void)
+{
+	unregister_memcg_callback(&cb);
+	destroy_workqueue(numa_balancer_wq);
+
+	pr_notice(KBUILD_MODNAME ": Exit\n");
+}
+
+module_init(numa_balancer_init);
+module_exit(numa_balancer_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Michael Wang <yun.wang@linux.alibaba.com>");
-- 
2.14.4.44.g2045bb6

