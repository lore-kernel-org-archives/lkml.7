Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D323BCA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 12:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B070320867
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 12:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfJZMJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 08:09:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44554 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726162AbfJZMJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 08:09:28 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 96D153F420EC805E3DE0;
        Sat, 26 Oct 2019 20:09:25 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Sat, 26 Oct 2019
 20:09:16 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <tglx@linutronix.de>,
        <bp@alien8.de>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <wanghai38@huawei.com>
Subject: [PATCH] x86/perf/amd: remove set but not used variable 'active'
Date:   Sat, 26 Oct 2019 20:08:13 +0800
Message-ID: <20191026120813.5534-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following gcc warning:

arch/x86/events/amd/core.c: In function amd_pmu_handle_irq:
arch/x86/events/amd/core.c:656:6: warning: variable active set but not
used [-Wunused-but-set-variable]

Fixes: df4d29732fda ("perf/x86/amd: Change/fix NMI latency mitigation to use a timestamp")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 arch/x86/events/amd/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 64c3e70..b7f2bfb 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -653,14 +653,14 @@ static void amd_pmu_disable_event(struct perf_event *event)
 static int amd_pmu_handle_irq(struct pt_regs *regs)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	int active, handled;
+	int handled;
 
 	/*
 	 * Obtain the active count before calling x86_pmu_handle_irq() since
 	 * it is possible that x86_pmu_handle_irq() may make a counter
 	 * inactive (through x86_pmu_stop).
 	 */
-	active = __bitmap_weight(cpuc->active_mask, X86_PMC_IDX_MAX);
+	__bitmap_weight(cpuc->active_mask, X86_PMC_IDX_MAX);
 
 	/* Process any counter overflows */
 	handled = x86_pmu_handle_irq(regs);
-- 
1.8.3.1

