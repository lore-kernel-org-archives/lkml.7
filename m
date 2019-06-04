Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15666C04AB5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 02:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E60255E2
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 02:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfFDCZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 22:25:11 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:39319 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726369AbfFDCZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 22:25:09 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0745275|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.709893-0.0127304-0.277376;FP=307772312550016443|2|2|3|0|-1|-1|-1;HT=e01l01425;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.Eh71qzG_1559615106;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.Eh71qzG_1559615106)
          by smtp.aliyun-inc.com(10.147.42.198);
          Tue, 04 Jun 2019 10:25:06 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mao Han <han_mao@c-sky.com>, linux-csky@vger.kernel.org,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH V4 1/6] csky: Init pmu as a device
Date:   Tue,  4 Jun 2019 10:23:55 +0800
Message-Id: <40e0b27c342458360f9f30ef16026cb63e792850.1559614824.git.han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1559614824.git.han_mao@c-sky.com>
References: <cover.1559614824.git.han_mao@c-sky.com>
In-Reply-To: <cover.1559614824.git.han_mao@c-sky.com>
References: <cover.1559614824.git.han_mao@c-sky.com>
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
 arch/csky/kernel/perf_event.c | 58 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/arch/csky/kernel/perf_event.c b/arch/csky/kernel/perf_event.c
index 376c972..c022acc 100644
--- a/arch/csky/kernel/perf_event.c
+++ b/arch/csky/kernel/perf_event.c
@@ -21,6 +21,8 @@ struct csky_pmu_t {
 	uint32_t	hpcr;
 } csky_pmu;
 
+typedef int (*csky_pmu_init)(struct csky_pmu_t *);
+
 #define cprgr(reg)				\
 ({						\
 	unsigned int tmp;			\
@@ -1028,4 +1030,58 @@ int __init init_hw_perf_events(void)
 
 	return perf_pmu_register(&csky_pmu.pmu, "cpu", PERF_TYPE_RAW);
 }
-arch_initcall(init_hw_perf_events);
+
+int csky_pmu_device_probe(struct platform_device *pdev,
+			  const struct of_device_id *of_table)
+{
+	const struct of_device_id *of_id;
+	csky_pmu_init init_fn;
+	struct device_node *node = pdev->dev.of_node;
+	int ret = -ENODEV;
+
+	of_id = of_match_node(of_table, pdev->dev.of_node);
+	if (node && of_id) {
+		init_fn = of_id->data;
+		ret = init_fn(&csky_pmu);
+	}
+
+	if (ret) {
+		pr_notice("[perf] failed to probe PMU!\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+const static struct of_device_id csky_pmu_of_device_ids[] = {
+	{.compatible = "csky,csky-pmu", .data = init_hw_perf_events},
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

