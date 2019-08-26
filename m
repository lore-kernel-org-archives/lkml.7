Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C55DC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17B321848
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="To1PgnC5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733261AbfHZPjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:39:46 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:1659 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733200AbfHZPjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:39:35 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7QFPxf4018386;
        Mon, 26 Aug 2019 17:39:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=jU9f5j6ZxSufRp0l6yClPcW1jUXM3GEpOLQlLRS9pBU=;
 b=To1PgnC5V2IkRIl04X2kCQ4oVzbXRNf5P5lzE3ePlDgyC556SLdSpOi1X84Fd05OhJ1w
 6WFgqhhx5nX1gKmrSRgQmw8akYzlR4e6i+XSLcllZN/jD16WXKTLv3vAiS2ZJwmIhTCf
 nNjp4LSdVgz2RhkXzSkXRBQW2HSGRdG7rcyv4u5yEzBQBZ53PWw+6cFP49237RInq0KJ
 nHf/mgBEOfUFoy89GfXdGrpiuifa6b/AqQmdVru9pKYWYfcSGYtNXNvC93+aSawavht1
 Ws2+y6m06TOminI/hfJwLkBwpSZjkkvFMZU/eqy7s7OEZfxBYzhH27PO/wiuIAV9cze7 VA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2uju0vmgkf-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 26 Aug 2019 17:39:23 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 166B7238;
        Mon, 26 Aug 2019 15:39:07 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C05532BC1DD;
        Mon, 26 Aug 2019 17:38:53 +0200 (CEST)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 26 Aug
 2019 17:38:53 +0200
Received: from localhost (10.201.23.25) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 26 Aug 2019 17:38:53
 +0200
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH 2/2] remoteproc: stm32: wakeup the system by wdg irq
Date:   Mon, 26 Aug 2019 17:38:43 +0200
Message-ID: <1566833923-16718-3-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566833923-16718-1-git-send-email-fabien.dessenne@st.com>
References: <1566833923-16718-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-26_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the device node defines the 'wakeup-source' property, use the WDG
exti IRQ as a wakeup source of the system.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 drivers/remoteproc/stm32_rproc.c | 47 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 2cf4b29..7ed8895 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -15,6 +15,7 @@
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/of_reserved_mem.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/regmap.h>
 #include <linux/remoteproc.h>
 #include <linux/reset.h>
@@ -65,6 +66,7 @@ struct stm32_rproc {
 	struct reset_control *rst;
 	struct stm32_syscon hold_boot;
 	struct stm32_syscon pdds;
+	int wdg_irq;
 	u32 nb_rmems;
 	struct stm32_rproc_mem *rmems;
 	struct stm32_mbox mb[MBOX_NB_MBX];
@@ -528,6 +530,13 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev)
 			return err;
 		}
 
+		ddata->wdg_irq = irq;
+
+		if (of_property_read_bool(np, "wakeup-source")) {
+			device_init_wakeup(dev, true);
+			dev_pm_set_wake_irq(dev, irq);
+		}
+
 		dev_info(dev, "wdg irq registered\n");
 	}
 
@@ -607,6 +616,10 @@ static int stm32_rproc_probe(struct platform_device *pdev)
 free_mb:
 	stm32_rproc_free_mbox(rproc);
 free_rproc:
+	if (device_may_wakeup(dev)) {
+		dev_pm_clear_wake_irq(dev);
+		device_init_wakeup(dev, false);
+	}
 	rproc_free(rproc);
 	return ret;
 }
@@ -614,22 +627,56 @@ static int stm32_rproc_probe(struct platform_device *pdev)
 static int stm32_rproc_remove(struct platform_device *pdev)
 {
 	struct rproc *rproc = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
 
 	if (atomic_read(&rproc->power) > 0)
 		rproc_shutdown(rproc);
 
 	rproc_del(rproc);
 	stm32_rproc_free_mbox(rproc);
+
+	if (device_may_wakeup(dev)) {
+		dev_pm_clear_wake_irq(dev);
+		device_init_wakeup(dev, false);
+	}
 	rproc_free(rproc);
 
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int stm32_rproc_suspend(struct device *dev)
+{
+	struct rproc *rproc = dev_get_drvdata(dev);
+	struct stm32_rproc *ddata = rproc->priv;
+
+	if (device_may_wakeup(dev))
+		return enable_irq_wake(ddata->wdg_irq);
+
+	return 0;
+}
+
+static int stm32_rproc_resume(struct device *dev)
+{
+	struct rproc *rproc = dev_get_drvdata(dev);
+	struct stm32_rproc *ddata = rproc->priv;
+
+	if (device_may_wakeup(dev))
+		return disable_irq_wake(ddata->wdg_irq);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(stm32_rproc_pm_ops,
+			 stm32_rproc_suspend, stm32_rproc_resume);
+
 static struct platform_driver stm32_rproc_driver = {
 	.probe = stm32_rproc_probe,
 	.remove = stm32_rproc_remove,
 	.driver = {
 		.name = "stm32-rproc",
+		.pm = &stm32_rproc_pm_ops,
 		.of_match_table = of_match_ptr(stm32_rproc_match),
 	},
 };
-- 
2.7.4

