Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F03C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14D220663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbfCFQtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:49:36 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:32637 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727964AbfCFQtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 11:49:36 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x26GhPTu013356;
        Wed, 6 Mar 2019 17:48:34 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qyhgb14hy-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 06 Mar 2019 17:48:34 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 164CE3A;
        Wed,  6 Mar 2019 16:48:32 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C21AC5079;
        Wed,  6 Mar 2019 16:48:32 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.44) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 6 Mar 2019
 17:48:32 +0100
Received: from localhost (10.201.23.16) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 6 Mar 2019 17:48:32
 +0100
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@st.com>
Subject: [PATCH] ASoC: stm32: spdifrx: add power management
Date:   Wed, 6 Mar 2019 17:48:08 +0100
Message-ID: <1551890888-24622-1-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-06_11:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suspend and resume sleep callbacks to STM32 SPDIFRX driver,
to support system low power modes.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_spdifrx.c | 42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index 373df4f24be1..b4c3d983e195 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -21,6 +21,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
@@ -471,6 +472,8 @@ static int stm32_spdifrx_get_ctrl_data(struct stm32_spdifrx_data *spdifrx)
 	memset(spdifrx->cs, 0, SPDIFRX_CS_BYTES_NB);
 	memset(spdifrx->ub, 0, SPDIFRX_UB_BYTES_NB);
 
+	pinctrl_pm_select_default_state(&spdifrx->pdev->dev);
+
 	ret = stm32_spdifrx_dma_ctrl_start(spdifrx);
 	if (ret < 0)
 		return ret;
@@ -502,6 +505,7 @@ static int stm32_spdifrx_get_ctrl_data(struct stm32_spdifrx_data *spdifrx)
 
 end:
 	clk_disable_unprepare(spdifrx->kclk);
+	pinctrl_pm_select_sleep_state(&spdifrx->pdev->dev);
 
 	return ret;
 }
@@ -611,10 +615,15 @@ static bool stm32_spdifrx_readable_reg(struct device *dev, unsigned int reg)
 
 static bool stm32_spdifrx_volatile_reg(struct device *dev, unsigned int reg)
 {
-	if (reg == STM32_SPDIFRX_DR)
+	switch (reg) {
+	case STM32_SPDIFRX_DR:
+	case STM32_SPDIFRX_CSR:
+	case STM32_SPDIFRX_SR:
+	case STM32_SPDIFRX_DIR:
 		return true;
-
-	return false;
+	default:
+		return false;
+	}
 }
 
 static bool stm32_spdifrx_writeable_reg(struct device *dev, unsigned int reg)
@@ -638,6 +647,7 @@ static const struct regmap_config stm32_h7_spdifrx_regmap_conf = {
 	.volatile_reg = stm32_spdifrx_volatile_reg,
 	.writeable_reg = stm32_spdifrx_writeable_reg,
 	.fast_io = true,
+	.cache_type = REGCACHE_FLAT,
 };
 
 static irqreturn_t stm32_spdifrx_isr(int irq, void *devid)
@@ -983,10 +993,36 @@ static int stm32_spdifrx_remove(struct platform_device *pdev)
 
 MODULE_DEVICE_TABLE(of, stm32_spdifrx_ids);
 
+#ifdef CONFIG_PM_SLEEP
+static int stm32_spdifrx_suspend(struct device *dev)
+{
+	struct stm32_spdifrx_data *spdifrx = dev_get_drvdata(dev);
+
+	regcache_cache_only(spdifrx->regmap, true);
+	regcache_mark_dirty(spdifrx->regmap);
+
+	return 0;
+}
+
+static int stm32_spdifrx_resume(struct device *dev)
+{
+	struct stm32_spdifrx_data *spdifrx = dev_get_drvdata(dev);
+
+	regcache_cache_only(spdifrx->regmap, false);
+
+	return regcache_sync(spdifrx->regmap);
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops stm32_spdifrx_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(stm32_spdifrx_suspend, stm32_spdifrx_resume)
+};
+
 static struct platform_driver stm32_spdifrx_driver = {
 	.driver = {
 		.name = "st,stm32-spdifrx",
 		.of_match_table = stm32_spdifrx_ids,
+		.pm = &stm32_spdifrx_pm_ops,
 	},
 	.probe = stm32_spdifrx_probe,
 	.remove = stm32_spdifrx_remove,
-- 
2.7.4

