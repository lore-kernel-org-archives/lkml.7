Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A392C010A3
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 11:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D644217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 11:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ZTynsEqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbfKELkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 06:40:46 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:18028 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730627AbfKELkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 06:40:45 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA5BZw7C005593;
        Tue, 5 Nov 2019 05:40:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=oYxUDSSjGk5c8krXph9FBh3Hos7bGE51sHLO4pVm3Y8=;
 b=ZTynsEqHG0D+XKs5vnIpNJZ4R3UYJ8brD950oCHEUkRQidXR+INvTapyJQtRvXWAyfV+
 EHkiHc16kl5GncTSg+GLpjSGWoCxIqPdIB1ZzPv1Rs/WzmDTMzMJ0ObpM8NzDhKZw8t3
 Cj3jnxHCEg0BHaXxSH9A2I4yHD0Ez+/oF7QsJLgRNCcXFFtnhtPj8z6d38Jp4tz73j4n
 GKCMt8slOg7Rw2+MFkfxTQpqsy//XG9gWUSrGHQRALMFLqijnNqek8fWxPZeX9uDk+Er
 1FagBjhGqrnt8k8ZVnZ2aS0G3UpeNoBaOm8j0cABuzKDQRsGWtIOs/RKRv5Ym8/YPMvK 6w== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 2w167skttp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 05 Nov 2019 05:40:41 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 5 Nov
 2019 11:40:40 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Tue, 5 Nov 2019 11:40:40 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4428B2C3;
        Tue,  5 Nov 2019 11:40:40 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH] mfd: madera: Improve handling of regulator unbinding
Date:   Tue, 5 Nov 2019 11:40:40 +0000
Message-ID: <20191105114040.22010-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=603 clxscore=1015 mlxscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1911050097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current unbinding process for Madera has some issues. The trouble
is runtime PM is disabled as the first step of the process, but
some of the drivers release IRQs causing regmap IRQ to issue a
runtime get which fails. To allow runtime PM to remain enabled during
mfd_remove_devices, the DCVDD regulator must remain available. In
the case of external DCVDD's this is simple, the regulator can simply
be disabled/put after the call to mfd_remove_devices. However, in
the case of an internally supplied DCVDD the regulator needs to be
released after all the MFD children, except for the regulator child
itself, have been removed. This is achieved by having the regulator
driver itself do the disable/put, as it is the last driver removed from
the MFD.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/madera-core.c        | 20 ++++++++++++--------
 drivers/regulator/arizona-ldo1.c | 14 +++++++++++++-
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
index a8cfadc1fc01e..5170b55836fc1 100644
--- a/drivers/mfd/madera-core.c
+++ b/drivers/mfd/madera-core.c
@@ -730,18 +730,22 @@ int madera_dev_exit(struct madera *madera)
 	/* Prevent any IRQs being serviced while we clean up */
 	disable_irq(madera->irq);
 
-	/*
-	 * DCVDD could be supplied by a child node, we must disable it before
-	 * removing the children, and prevent PM runtime from turning it back on
-	 */
+	pm_runtime_get_sync(madera->dev);
+
+	mfd_remove_devices(madera->dev);
+
 	pm_runtime_disable(madera->dev);
 
-	clk_disable_unprepare(madera->mclk[MADERA_MCLK2].clk);
+	if (!madera->internal_dcvdd) {
+		regulator_disable(madera->dcvdd);
+		regulator_put(madera->dcvdd);
+	}
 
-	regulator_disable(madera->dcvdd);
-	regulator_put(madera->dcvdd);
+	pm_runtime_set_suspended(madera->dev);
+	pm_runtime_put_noidle(madera->dev);
+
+	clk_disable_unprepare(madera->mclk[MADERA_MCLK2].clk);
 
-	mfd_remove_devices(madera->dev);
 	madera_enable_hard_reset(madera);
 
 	regulator_bulk_disable(madera->num_core_supplies,
diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index 1a3d7b720f5e0..83dd37dbfe07b 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -375,6 +375,18 @@ static int madera_ldo1_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int madera_ldo1_remove(struct platform_device *pdev)
+{
+	struct madera *madera = dev_get_drvdata(pdev->dev.parent);
+
+	if (madera->internal_dcvdd) {
+		regulator_disable(madera->dcvdd);
+		regulator_put(madera->dcvdd);
+	}
+
+	return arizona_ldo1_remove(pdev);
+}
+
 static struct platform_driver arizona_ldo1_driver = {
 	.probe = arizona_ldo1_probe,
 	.remove = arizona_ldo1_remove,
@@ -385,7 +397,7 @@ static struct platform_driver arizona_ldo1_driver = {
 
 static struct platform_driver madera_ldo1_driver = {
 	.probe = madera_ldo1_probe,
-	.remove = arizona_ldo1_remove,
+	.remove = madera_ldo1_remove,
 	.driver		= {
 		.name	= "madera-ldo1",
 	},
-- 
2.11.0

