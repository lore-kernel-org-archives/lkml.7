Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA52C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9483C2253D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbfLLOnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:43:55 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7679 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729266AbfLLOnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:43:55 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B6E1D8ADCCDE0913A27E;
        Thu, 12 Dec 2019 22:43:52 +0800 (CST)
Received: from huawei.com (10.175.113.25) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Thu, 12 Dec 2019
 22:43:42 +0800
From:   Cheng Jian <cj.chengjian@huawei.com>
To:     <mingo@kernel.org>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <cj.chengjian@huawei.com>, <chenwandun@huawei.com>,
        <xiexiuqi@huawei.com>, <liwei391@huawei.com>,
        <huawei.libin@huawei.com>, <bobo.shaobowang@huawei.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: Optimize select_idle_cpu
Date:   Thu, 12 Dec 2019 22:41:02 +0800
Message-ID: <20191212144102.181510-1-cj.chengjian@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

select_idle_cpu will scan the LLC domain for idle CPUs,
it's always expensive. so commit
    1ad3aaf3fcd2 ("sched/core: Implement new approach to scale select_idle_cpu()")
introduces a way to limit how many CPUs we scan.

But this also lead to the following issue:

Our threads are all bind to the front CPUs of the LLC domain,
and now all the threads runs on the last CPU of them. nr is
always less than the cpumask_weight, for_each_cpu_wrap can't
find the CPU which our threads can run on, so the threads stay
at the last CPU all the time.

Fixes: 1ad3aaf3fcd2 ("sched/core: Implement new approach to scale select_idle_cpu()")
Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
---
 kernel/sched/fair.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 08a233e97a01..16a29b570803 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5834,6 +5834,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	s64 delta;
 	int this = smp_processor_id();
 	int cpu, nr = INT_MAX, si_cpu = -1;
+	struct cpumask cpus;
 
 	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
 	if (!this_sd)
@@ -5859,11 +5860,11 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 
 	time = cpu_clock(this);
 
-	for_each_cpu_wrap(cpu, sched_domain_span(sd), target) {
+	cpumask_and(&cpus, sched_domain_span(sd), p->cpus_ptr);
+
+	for_each_cpu_wrap(cpu, &cpus, target) {
 		if (!--nr)
 			return si_cpu;
-		if (!cpumask_test_cpu(cpu, p->cpus_ptr))
-			continue;
 		if (available_idle_cpu(cpu))
 			break;
 		if (si_cpu == -1 && sched_idle_cpu(cpu))
-- 
2.20.1

