Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A9BC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 09:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E2D205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 09:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="MWmSls6b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfHNJVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 05:21:47 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:36038 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725888AbfHNJVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 05:21:46 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7E9JrfQ026966;
        Wed, 14 Aug 2019 04:21:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=MBbLEmujsVlrP1G1w0n/5QjMnjeJe09isvCOhTmTH9c=;
 b=MWmSls6bydjXS7vHp+72MeCHiKtb4tDCXL8CONt6sxQwYm6YN1vkNs5HxOTSOz1V95hO
 EOXSbkFAndaydHQBFve5gKkA4lXDUgh1MjNZwjJYbNWITxuy/8LBCfrepyuTJMZrSRpy
 /5lwvBPO3RQRp3tyJ+1Kfl1hbZTvSPSS9jXFvHsVT828hkN97OaC3JtB8J7TMnhdifIP
 SHOHM0yFPseVQzszLx1AgDdlDqSD5BkdjsDqB+ZrL4ujLyeotx9Ha4RnOhOuQfiwmVYi
 sf5OOG0G88m30n7Ld8czlOXLI7weOBX39bE0lJwQPLtoLpMC/hJBpigh3bl+x8QBJ477 3w== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 2ubf9btdfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 14 Aug 2019 04:21:41 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Wed, 14 Aug
 2019 10:21:40 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Wed, 14 Aug 2019 10:21:40 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 32A222DD;
        Wed, 14 Aug 2019 10:21:40 +0100 (BST)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 2/2] mfd: madera: Add support for requesting the supply clocks
Date:   Wed, 14 Aug 2019 10:21:40 +0100
Message-ID: <20190814092140.30995-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190814092140.30995-1-ckeepax@opensource.cirrus.com>
References: <20190814092140.30995-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 adultscore=0 suspectscore=1 mlxscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 mlxlogscore=960
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908140094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ability to get the clock for each clock input pin of the chip
and enable MCLK2 since that is expected to be a permanently enabled
32kHz clock.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v1:
 - Fail probe if we encounter a clock error
 - Print a warning if MCLK2 is not specified

Thanks,
Charles

 drivers/mfd/madera-core.c       | 29 ++++++++++++++++++++++++++++-
 include/linux/mfd/madera/core.h | 11 +++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
index 29540cbf75934..9a0dee9400dd8 100644
--- a/drivers/mfd/madera-core.c
+++ b/drivers/mfd/madera-core.c
@@ -428,6 +428,7 @@ static void madera_set_micbias_info(struct madera *madera)
 
 int madera_dev_init(struct madera *madera)
 {
+	static const char * const mclk_name[] = { "mclk1", "mclk2", "mclk3" };
 	struct device *dev = madera->dev;
 	unsigned int hwid;
 	int (*patch_fn)(struct madera *) = NULL;
@@ -450,6 +451,22 @@ int madera_dev_init(struct madera *madera)
 		       sizeof(madera->pdata));
 	}
 
+	BUILD_BUG_ON(ARRAY_SIZE(madera->mclk) != ARRAY_SIZE(mclk_name));
+	for (i = 0; i < ARRAY_SIZE(madera->mclk); i++) {
+		madera->mclk[i] = devm_clk_get_optional(madera->dev,
+							mclk_name[i]);
+		if (IS_ERR(madera->mclk[i])) {
+			ret = PTR_ERR(madera->mclk[i]);
+			dev_err(madera->dev, "Failed to get %s: %d\n",
+				mclk_name[i], ret);
+			return ret;
+		}
+	}
+
+	/* Not using devm_clk_get to prevent breakage of existing DTs */
+	if (!madera->mclk[MADERA_MCLK2])
+		dev_warn(madera->dev, "Missing MCLK2, requires 32kHz clock\n");
+
 	ret = madera_get_reset_gpio(madera);
 	if (ret)
 		return ret;
@@ -660,13 +677,19 @@ int madera_dev_init(struct madera *madera)
 	}
 
 	/* Init 32k clock sourced from MCLK2 */
+	ret = clk_prepare_enable(madera->mclk[MADERA_MCLK2]);
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
@@ -687,6 +710,8 @@ int madera_dev_init(struct madera *madera)
 
 err_pm_runtime:
 	pm_runtime_disable(madera->dev);
+err_clock:
+	clk_disable_unprepare(madera->mclk[MADERA_MCLK2]);
 err_reset:
 	madera_enable_hard_reset(madera);
 	regulator_disable(madera->dcvdd);
@@ -713,6 +738,8 @@ int madera_dev_exit(struct madera *madera)
 	 */
 	pm_runtime_disable(madera->dev);
 
+	clk_disable_unprepare(madera->mclk[MADERA_MCLK2]);
+
 	regulator_disable(madera->dcvdd);
 	regulator_put(madera->dcvdd);
 
diff --git a/include/linux/mfd/madera/core.h b/include/linux/mfd/madera/core.h
index 7ffa696cce7ca..2b6c83fe221dc 100644
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
+ * @mclk:		pointers to clock supplies
  * @out_clamp:		indicates output clamp state for each analogue output
  * @out_shorted:	indicates short circuit state for each analogue output
  * @hp_ena:		bitflags of enable state for the headphone outputs
@@ -184,6 +193,8 @@ struct madera {
 	struct regmap_irq_chip_data *irq_data;
 	int irq;
 
+	struct clk *mclk[MADERA_NUM_MCLK];
+
 	unsigned int num_micbias;
 	unsigned int num_childbias[MADERA_MAX_MICBIAS];
 
-- 
2.11.0

