Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E7FC28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1190024A1D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfFDK4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 06:56:12 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:41233 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727038AbfFDK4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 06:56:08 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07446621|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.72441-0.0119977-0.263592;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16378;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.EhJUzkJ_1559645765;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.EhJUzkJ_1559645765)
          by smtp.aliyun-inc.com(10.147.41.120);
          Tue, 04 Jun 2019 18:56:05 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mao Han <han_mao@c-sky.com>, linux-csky@vger.kernel.org,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH V5 1/6] csky: Init pmu as a device
Date:   Tue,  4 Jun 2019 18:54:44 +0800
Message-Id: <06bdeb08d3d1240900c37a83c2c5dfa131f61554.1559644961.git.han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1559644961.git.han_mao@c-sky.com>
References: <cover.1559644961.git.han_mao@c-sky.com>
In-Reply-To: <cover.1559644961.git.han_mao@c-sky.com>
References: <cover.1559644961.git.han_mao@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch change the csky pmu initialization from arch init to
device init. The pmu can be configued with information from
device tree(pmu device name, irq number and etc.).

Signed-off-by: Mao Han <han_mao@c-sky.com>
Cc: Guo Ren <guoren@kernel.org>
---
 arch/csky/kernel/perf_event.c | 50 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/arch/csky/kernel/perf_event.c b/arch/csky/kernel/perf_event.c
index 376c972..2282554 100644
--- a/arch/csky/kernel/perf_event.c
+++ b/arch/csky/kernel/perf_event.c
@@ -949,7 +949,7 @@ static int csky_pmu_add(struct perf_event *event, int flags)
 	return 0;
 }
 
-int __init init_hw_perf_events(void)
+int init_hw_perf_events(void)
 {
 	csky_pmu.pmu = (struct pmu) {
 		.pmu_enable	= csky_pmu_enable,
@@ -1028,4 +1028,50 @@ int __init init_hw_perf_events(void)
 
 	return perf_pmu_register(&csky_pmu.pmu, "cpu", PERF_TYPE_RAW);
 }
-arch_initcall(init_hw_perf_events);
+
+int csky_pmu_device_probe(struct platform_device *pdev,
+			  const struct of_device_id *of_table)
+{
+	int ret;
+
+	ret = init_hw_perf_events();
+	if (ret) {
+		pr_notice("[perf] failed to probe PMU!\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+const static struct of_device_id csky_pmu_of_device_ids[] = {
+	{.compatible = "csky,csky-pmu"},
+	{},
+};
+
+static int csky_pmu_dev_probe(struct platform_device *pdev)
+{
+	return csky_pmu_device_probe(pdev, csky_pmu_of_device_ids);
+}
+
+static struct platform_driver csky_pmu_driver = {
+	.driver = {
+		   .name = "csky-pmu",
+		   .of_match_table = csky_pmu_of_device_ids,
+		   },
+	.probe = csky_pmu_dev_probe,
+};
+
+static int __init csky_pmu_probe(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&csky_pmu_driver);
+	if (ret)
+		pr_notice("[perf] PMU initialization failed\n");
+	else
+		pr_notice("[perf] PMU initialization done\n");
+
+	return ret;
+}
+
+device_initcall(csky_pmu_probe);
-- 
2.7.4

