Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F338C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E52E21721
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404591AbfFKPOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 11:14:19 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18128 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404557AbfFKPOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:14:18 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5B7A1785BD8CB804D325;
        Tue, 11 Jun 2019 23:14:11 +0800 (CST)
Received: from euler.huawei.com (10.175.104.193) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Tue, 11 Jun 2019 23:14:04 +0800
From:   Wei Li <liwei391@huawei.com>
To:     <mark.rutland@arm.com>, <marc.zyngier@arm.com>,
        <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <huawei.libin@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] clocksource/arm_arch_timer: mark arch_timer_read_counter() as notrace to avoid deadloop
Date:   Tue, 11 Jun 2019 23:21:35 +0800
Message-ID: <20190611152135.44589-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.193]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to arch_counter_register(), mark arch_counter_get_*() what
arch_timer_read_counter() can be as notrace to avoid deadloop when using
function_graph tracer.

 0xffff80028af23250 0xffff000010195e00 sched_clock+64
 0xffff80028af23290 0xffff0000101e83ec trace_clock_local+12
 0xffff80028af232a0 0xffff00001020e52c function_graph_enter+116
 0xffff80028af23300 0xffff00001009af9c prepare_ftrace_return+44
 0xffff80028af23320 0xffff00001009b0a8 ftrace_graph_caller+28
 0xffff80028af23330 0xffff000010b01918 arch_counter_get_cntvct+16
 0xffff80028af23340 0xffff000010195e00 sched_clock+64
 0xffff80028af23380 0xffff0000101e83ec trace_clock_local+12
 0xffff80028af23390 0xffff00001020e52c function_graph_enter+116
 0xffff80028af233f0 0xffff00001009af9c prepare_ftrace_return+44
 0xffff80028af23410 0xffff00001009b0a8 ftrace_graph_caller+28
 0xffff80028af23420 0xffff000010b01918 arch_counter_get_cntvct+16
 ...

Fixes: 0ea415390cd3 ("clocksource/arm_arch_timer: Use arch_timer_read_counter to access stable counters")
Signed-off-by: Wei Li <liwei391@huawei.com>
---
 drivers/clocksource/arm_arch_timer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index b2a951a798e2..f4d5bd8fe906 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -149,22 +149,22 @@ u32 arch_timer_reg_read(int access, enum arch_timer_reg reg,
 	return val;
 }
 
-static u64 arch_counter_get_cntpct_stable(void)
+static u64 notrace arch_counter_get_cntpct_stable(void)
 {
 	return __arch_counter_get_cntpct_stable();
 }
 
-static u64 arch_counter_get_cntpct(void)
+static u64 notrace arch_counter_get_cntpct(void)
 {
 	return __arch_counter_get_cntpct();
 }
 
-static u64 arch_counter_get_cntvct_stable(void)
+static u64 notrace arch_counter_get_cntvct_stable(void)
 {
 	return __arch_counter_get_cntvct_stable();
 }
 
-static u64 arch_counter_get_cntvct(void)
+static u64 notrace arch_counter_get_cntvct(void)
 {
 	return __arch_counter_get_cntvct();
 }
@@ -947,7 +947,7 @@ bool arch_timer_evtstrm_available(void)
 	return cpumask_test_cpu(raw_smp_processor_id(), &evtstrm_available);
 }
 
-static u64 arch_counter_get_cntvct_mem(void)
+static u64 notrace arch_counter_get_cntvct_mem(void)
 {
 	u32 vct_lo, vct_hi, tmp_hi;
 
-- 
2.17.1

