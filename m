Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC01AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8778D20645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfDWHlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:41:19 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7226 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726698AbfDWHkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 03:40:24 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 48A5FDEEC6CD3E90994B;
        Tue, 23 Apr 2019 15:40:22 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Tue, 23 Apr 2019 15:40:15 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Eduardo Valentin" <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH next 23/25] thermal: Use dev_get_drvdata()
Date:   Tue, 23 Apr 2019 15:50:18 +0800
Message-ID: <20190423075020.173734-24-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423075020.173734-1-wangkefeng.wang@huawei.com>
References: <20190423075020.173734-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using dev_get_drvdata directly.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 .../intel/int340x_thermal/processor_thermal_device.c      | 8 +-------
 drivers/thermal/st/stm_thermal.c                          | 6 ++----
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index 8e1cf4d789be..4ad54b8d4778 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -81,8 +81,6 @@ static ssize_t power_limit_##index##_##suffix##_show(struct device *dev, \
 					struct device_attribute *attr, \
 					char *buf) \
 { \
-	struct pci_dev *pci_dev; \
-	struct platform_device *pdev; \
 	struct proc_thermal_device *proc_dev; \
 	\
 	if (proc_thermal_emum_mode == PROC_THERMAL_NONE) { \
@@ -91,11 +89,7 @@ static ssize_t power_limit_##index##_##suffix##_show(struct device *dev, \
 	} \
 	\
 	if (proc_thermal_emum_mode == PROC_THERMAL_PLATFORM_DEV) { \
-		pdev = to_platform_device(dev); \
-		proc_dev = platform_get_drvdata(pdev); \
-	} else { \
-		pci_dev = to_pci_dev(dev); \
-		proc_dev = pci_get_drvdata(pci_dev); \
+		proc_dev = dev_get_drvdata(dev); \
 	} \
 	return sprintf(buf, "%lu\n",\
 	(unsigned long)proc_dev->power_limits[index].suffix * 1000); \
diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index bbd73c5a4a4e..cf9ddc52f30e 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -570,8 +570,7 @@ static int stm_thermal_prepare(struct stm_thermal_sensor *sensor)
 static int stm_thermal_suspend(struct device *dev)
 {
 	int ret;
-	struct platform_device *pdev = to_platform_device(dev);
-	struct stm_thermal_sensor *sensor = platform_get_drvdata(pdev);
+	struct stm_thermal_sensor *sensor = dev_get_drvdata(dev);
 
 	ret = stm_thermal_sensor_off(sensor);
 	if (ret)
@@ -585,8 +584,7 @@ static int stm_thermal_suspend(struct device *dev)
 static int stm_thermal_resume(struct device *dev)
 {
 	int ret;
-	struct platform_device *pdev = to_platform_device(dev);
-	struct stm_thermal_sensor *sensor = platform_get_drvdata(pdev);
+	struct stm_thermal_sensor *sensor = dev_get_drvdata(dev);
 
 	ret = stm_thermal_prepare(sensor);
 	if (ret)
-- 
2.20.1

