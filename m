Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF8BC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C5524A1D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfFDK4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 06:56:24 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:52391 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726877AbfFDK4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 06:56:12 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07489662|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.122591-0.00828454-0.869125;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03299;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.EhJB.ip_1559645769;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.EhJB.ip_1559645769)
          by smtp.aliyun-inc.com(10.147.40.2);
          Tue, 04 Jun 2019 18:56:09 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mao Han <han_mao@c-sky.com>, linux-csky@vger.kernel.org,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH V5 6/6] csky: Fix perf record in kernel/user space
Date:   Tue,  4 Jun 2019 18:54:49 +0800
Message-Id: <210ca538c85e6f1b9f1539fd9f69cc59d046dc11.1559644961.git.han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1559644961.git.han_mao@c-sky.com>
References: <cover.1559644961.git.han_mao@c-sky.com>
In-Reply-To: <cover.1559644961.git.han_mao@c-sky.com>
References: <cover.1559644961.git.han_mao@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

csky_pmu_event_init is called several times during the perf record
initialzation. After configure the event counter in either kernel
space or user space, csky_pmu_event_init is called twice with no
attr specified. Configuration will be overwritten with sampling in
both kernel space and user space. --all-kernel/--all-user is
useless without this patch applied.

Signed-off-by: Mao Han <han_mao@c-sky.com>
Cc: Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org
---
 arch/csky/kernel/perf_event.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/csky/kernel/perf_event.c b/arch/csky/kernel/perf_event.c
index 499427e..13a254e 100644
--- a/arch/csky/kernel/perf_event.c
+++ b/arch/csky/kernel/perf_event.c
@@ -976,15 +976,6 @@ static int csky_pmu_event_init(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	int ret;
 
-	if (event->attr.exclude_user)
-		csky_pmu.hpcr = BIT(2);
-	else if (event->attr.exclude_kernel)
-		csky_pmu.hpcr = BIT(3);
-	else
-		csky_pmu.hpcr = BIT(2) | BIT(3);
-
-	csky_pmu.hpcr |= BIT(1) | BIT(0);
-
 	switch (event->attr.type) {
 	case PERF_TYPE_HARDWARE:
 		if (event->attr.config >= PERF_COUNT_HW_MAX)
@@ -993,21 +984,32 @@ static int csky_pmu_event_init(struct perf_event *event)
 		if (ret == HW_OP_UNSUPPORTED)
 			return -ENOENT;
 		hwc->idx = ret;
-		return 0;
+		break;
 	case PERF_TYPE_HW_CACHE:
 		ret = csky_pmu_cache_event(event->attr.config);
 		if (ret == CACHE_OP_UNSUPPORTED)
 			return -ENOENT;
 		hwc->idx = ret;
-		return 0;
+		break;
 	case PERF_TYPE_RAW:
 		if (hw_raw_read_mapping[event->attr.config] == NULL)
 			return -ENOENT;
 		hwc->idx = event->attr.config;
-		return 0;
+		break;
 	default:
 		return -ENOENT;
 	}
+
+	if (event->attr.exclude_user)
+		csky_pmu.hpcr = BIT(2);
+	else if (event->attr.exclude_kernel)
+		csky_pmu.hpcr = BIT(3);
+	else
+		csky_pmu.hpcr = BIT(2) | BIT(3);
+
+	csky_pmu.hpcr |= BIT(1) | BIT(0);
+
+	return 0;
 }
 
 /* starts all counters */
-- 
2.7.4

