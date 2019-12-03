Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E583C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 02:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F35920674
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 02:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfLCCT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 21:19:59 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:60625 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726189AbfLCCT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 21:19:59 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TjlrUB7_1575339596;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TjlrUB7_1575339596)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 03 Dec 2019 10:19:56 +0800
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Mel Gorman <mgorman@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Subject: [PATCH RESEND] sched/numa: expose per-task pages-migration-failure
Message-ID: <7038afda-dd08-f01f-5da0-afadf76f5533@linux.alibaba.com>
Date:   Tue, 3 Dec 2019 10:18:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NUMA balancing will try to migrate pages between nodes, which
could caused by memory policy or numa group aggregation, while
the page migration could failed too for eg when the target node
run out of memory.

Since this is critical to the performance, admin should know
how serious the problem is, and take actions before it causing
too much performance damage, thus this patch expose the counter
as 'migfailed' in '/proc/PID/sched'.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michal Koutný <mkoutny@suse.com>
Acked-by: Mel Gorman <mgorman@suse.de>
Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
---
 kernel/sched/debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index f7e4579e746c..73c4809c8f37 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -848,6 +848,7 @@ static void sched_show_numa(struct task_struct *p, struct seq_file *m)
 	P(total_numa_faults);
 	SEQ_printf(m, "current_node=%d, numa_group_id=%d\n",
 			task_node(p), task_numa_group_id(p));
+	SEQ_printf(m, "migfailed=%lu\n", p->numa_faults_locality[2]);
 	show_numa_stats(p, m);
 	mpol_put(pol);
 #endif
-- 
2.14.4.44.g2045bb6

