Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA0EECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DA02190F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="EDxAHxLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388703AbfJANqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:46:25 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:45374 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388170AbfJANqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:46:25 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x91DinhQ023930;
        Tue, 1 Oct 2019 08:46:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=FCRXcxlBOfNZdlMdGggkY99dkVqafYnC8FQDk3CxLno=;
 b=EDxAHxLCLqE2Tkzyeq7wt0uJepiflurWnxOfZXxypwCYfuQ7rdLDWjJFFznr/WdMpMXx
 8ckRU2qNEnMAreSFlu1fsUa1feLIMNU/GRg6VM1E07tJ5GNr42vYxbmLj65Fvp6rSDPm
 9olehpNz0fVTRknzYMBKhqwJZ99jYEn+y0nms3KqFCCcqKnKUwVBZqbq+N6uDmZ3CWhr
 RnIrZU0lkLrkhs9V96rEHNPu8nTKbkvmU3Suqcp3pn8F8BuUOafw1sFSbUSMTWhzZVK1
 RaMaTEjCsjpeCHEjs7ZjWAhpyEJbuhXl0Uahu/7dG2N6EHvTNZZYCJTWqGC1cHeCLBgL Sg== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 2va4x4ncr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 01 Oct 2019 08:46:20 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 1 Oct
 2019 14:46:18 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Tue, 1 Oct 2019 14:46:18 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E88282B3;
        Tue,  1 Oct 2019 13:46:17 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v3 3/3] mfd: madera: Add support for requesting the supply clocks
Date:   Tue, 1 Oct 2019 14:46:17 +0100
Message-ID: <20191001134617.12093-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191001134617.12093-1-ckeepax@opensource.cirrus.com>
References: <20191001134617.12093-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=939
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 suspectscore=1 bulkscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910010125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ability to get the clock for each clock input pin of the chip
and enable MCLK2 since that is expected to be a permanently enabled
32kHz clock.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v2:
 - Use new devm_clk_bulk_get_optional API

Thanks,
Charles

 drivers/mfd/madera-core.c       | 27 ++++++++++++++++++++++++++-
 include/linux/mfd/madera/core.h | 11 +++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
index 29540cbf75934..88d904eb016ea 100644
--- a/drivers/mfd/madera-core.c
+++ b/drivers/mfd/madera-core.c
@@ -450,6 +450,21 @@ int madera_dev_init(struct madera *madera)
 		       sizeof(madera->pdata));
 	}
 
+	madera->mclk[MADERA_MCLK1].id = "mclk1";
+	madera->mclk[MADERA_MCLK2].id = "mclk2";
+	madera->mclk[MADERA_MCLK3].id = "mclk3";
+
+	ret = devm_clk_bulk_get_optional(madera->dev, ARRAY_SIZE(madera->mclk),
+					 madera->mclk);
+	if (ret) {
+		dev_err(madera->dev, "Failed to get clocks: %d\n", ret);
+		return ret;
+	}
+
+	/* Not using devm_clk_get to prevent breakage of existing DTs */
+	if (!madera->mclk[MADERA_MCLK2].clk)
+		dev_warn(madera->dev, "Missing MCLK2, requires 32kHz clock\n");
+
 	ret = madera_get_reset_gpio(madera);
 	if (ret)
 		return ret;
@@ -660,13 +675,19 @@ int madera_dev_init(struct madera *madera)
 	}
 
 	/* Init 32k clock sourced from MCLK2 */
+	ret = clk_prepare_enable(madera->mclk[MADERA_MCLK2].clk);
+	if (ret != 0) {
+		dev_err(madera->dev, "Failed to enable 32k clock: %d\n", ret);
+		goto err_reset;
+	}
+
 	ret = regmap_update_bits(madera->regmap,
 			MADERA_CLOCK_32K_1,
 			MADERA_CLK_32K_ENA_MASK | MADERA_CLK_32K_SRC_MASK,
 			MADERA_CLK_32K_ENA | MADERA_32KZ_MCLK2);
 	if (ret) {
 		dev_err(madera->dev, "Failed to init 32k clock: %d\n", ret);
-		goto err_reset;
+		goto err_clock;
 	}
 
 	pm_runtime_set_active(madera->dev);
@@ -687,6 +708,8 @@ int madera_dev_init(struct madera *madera)
 
 err_pm_runtime:
 	pm_runtime_disable(madera->dev);
+err_clock:
+	clk_disable_unprepare(madera->mclk[MADERA_MCLK2].clk);
 err_reset:
 	madera_enable_hard_reset(madera);
 	regulator_disable(madera->dcvdd);
@@ -713,6 +736,8 @@ int madera_dev_exit(struct madera *madera)
 	 */
 	pm_runtime_disable(madera->dev);
 
+	clk_disable_unprepare(madera->mclk[MADERA_MCLK2].clk);
+
 	regulator_disable(madera->dcvdd);
 	regulator_put(madera->dcvdd);
 
diff --git a/include/linux/mfd/madera/core.h b/include/linux/mfd/madera/core.h
index 7ffa696cce7ca..ad2c138105d4b 100644
--- a/include/linux/mfd/madera/core.h
+++ b/include/linux/mfd/madera/core.h
@@ -8,6 +8,7 @@
 #ifndef MADERA_CORE_H
 #define MADERA_CORE_H
 
+#include <linux/clk.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/mfd/madera/pdata.h>
@@ -29,6 +30,13 @@ enum madera_type {
 	CS42L92 = 9,
 };
 
+enum {
+	MADERA_MCLK1,
+	MADERA_MCLK2,
+	MADERA_MCLK3,
+	MADERA_NUM_MCLK
+};
+
 #define MADERA_MAX_CORE_SUPPLIES	2
 #define MADERA_MAX_GPIOS		40
 
@@ -155,6 +163,7 @@ struct snd_soc_dapm_context;
  * @irq_dev:		the irqchip child driver device
  * @irq_data:		pointer to irqchip data for the child irqchip driver
  * @irq:		host irq number from SPI or I2C configuration
+ * @mclk:		Structure holding clock supplies
  * @out_clamp:		indicates output clamp state for each analogue output
  * @out_shorted:	indicates short circuit state for each analogue output
  * @hp_ena:		bitflags of enable state for the headphone outputs
@@ -184,6 +193,8 @@ struct madera {
 	struct regmap_irq_chip_data *irq_data;
 	int irq;
 
+	struct clk_bulk_data mclk[MADERA_NUM_MCLK];
+
 	unsigned int num_micbias;
 	unsigned int num_childbias[MADERA_MAX_MICBIAS];
 
-- 
2.11.0

