Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A23BC10F14
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 02:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E6020833
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 02:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfDVCMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 22:12:24 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:49089 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726099AbfDVCMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 22:12:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TPtsv3i_1555899140;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TPtsv3i_1555899140)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 22 Apr 2019 10:12:21 +0800
Subject: [RFC PATCH 2/5] numa: append per-node execution info in
 memory.numa_stat
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
To:     Peter Zijlstra <peterz@infradead.org>, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
Message-ID: <7be82809-79d3-f6a1-dfe8-dd14d2b35219@linux.alibaba.com>
Date:   Mon, 22 Apr 2019 10:12:20 +0800
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

This patch introduced numa execution information, to imply the numa
efficiency.

By doing 'cat /sys/fs/cgroup/memory/CGROUP_PATH/memory.numa_stat', we
see new output line heading with 'exectime', like:

  exectime 24399843 27865444

which means the tasks of this cgroup executed 24399843 ticks on node 0,
and 27865444 ticks on node 1.

Combined with the memory node info, we can estimate the numa efficiency,
for example the memory.numa_stat show:

  total=4613257 N0=6849 N1=3928327
  ...
  exectime 24399843 27865444

there could be unmovable or cache pages on N1, then good locality could
mean nothing since we are not tracing these type of pages, thus bind the
workloads on the cpus of N1 worth a try, in order to achieve the maximum
performance bonus.

Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
---
 include/linux/memcontrol.h |  1 +
 mm/memcontrol.c            | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index bb62e6294484..e784d6252d5e 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -197,6 +197,7 @@ enum memcg_numa_locality_interval {

 struct memcg_stat_numa {
 	u64 locality[NR_NL_INTERVAL];
+	u64 exectime;
 };

 #endif
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b810d4e9c906..91bcd71fc38a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3409,6 +3409,18 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 		seq_printf(m, " %llu", sum);
 	}
 	seq_putc(m, '\n');
+
+	seq_puts(m, "exectime");
+	for_each_online_node(nr) {
+		int cpu;
+		u64 sum = 0;
+
+		for_each_cpu(cpu, cpumask_of_node(nr))
+			sum += per_cpu(memcg->stat_numa->exectime, cpu);
+
+		seq_printf(m, " %llu", sum);
+	}
+	seq_putc(m, '\n');
 #endif

 	return 0;
@@ -3437,6 +3449,7 @@ void memcg_stat_numa_update(struct task_struct *p)
 	memcg = mem_cgroup_from_task(p);
 	if (idx != -1)
 		this_cpu_inc(memcg->stat_numa->locality[idx]);
+	this_cpu_inc(memcg->stat_numa->exectime);
 	rcu_read_unlock();
 }
 #endif
-- 
2.14.4.44.g2045bb6

