Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B343BC04AB5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 02:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941F3255DE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 02:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfFDCZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 22:25:16 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:50973 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726369AbfFDCZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 22:25:12 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09231208|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.412593-0.0549792-0.532428;FP=4993171859445338579|2|2|3|0|-1|-1|-1;HT=e02c03275;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.Eh6wegv_1559615110;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.Eh6wegv_1559615110)
          by smtp.aliyun-inc.com(10.147.41.120);
          Tue, 04 Jun 2019 10:25:10 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mao Han <han_mao@c-sky.com>, linux-csky@vger.kernel.org,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH V4 6/6] csky: Fix perf record in kernel/user space
Date:   Tue,  4 Jun 2019 10:24:00 +0800
Message-Id: <3a6a5379b4f692773d82ff5ad18a7b22ceaf5a80.1559614824.git.han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1559614824.git.han_mao@c-sky.com>
References: <cover.1559614824.git.han_mao@c-sky.com>
In-Reply-To: <cover.1559614824.git.han_mao@c-sky.com>
References: <cover.1559614824.git.han_mao@c-sky.com>
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
 arch/csky/kernel/perf_event.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/csky/kernel/perf_event.c b/arch/csky/kernel/perf_event.c
index dc84dc7..e3308ab 100644
--- a/arch/csky/kernel/perf_event.c
+++ b/arch/csky/kernel/perf_event.c
@@ -983,6 +983,12 @@ static int csky_pmu_event_init(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	int ret;
 
+	if (event->attr.type != PERF_TYPE_HARDWARE &&
+	    event->attr.type != PERF_TYPE_HW_CACHE &&
+	    event->attr.type != PERF_TYPE_RAW) {
+		return -ENOENT;
+	}
+
 	if (event->attr.exclude_user)
 		csky_pmu.hpcr = BIT(2);
 	else if (event->attr.exclude_kernel)
-- 
2.7.4

