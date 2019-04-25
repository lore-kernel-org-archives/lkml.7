Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AB4C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE6C21907
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfDYKMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:12:49 -0400
Received: from regular1.263xmail.com ([211.150.70.196]:49898 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfDYKMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:12:43 -0400
Received: from zhangqing?rock-chips.com (unknown [192.168.167.13])
        by regular1.263xmail.com (Postfix) with ESMTP id 8544E7FE;
        Thu, 25 Apr 2019 18:12:39 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P797T140025968707328S1556187150403323_;
        Thu, 25 Apr 2019 18:12:39 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <ab597d942803cc042213c6826a0f61c1>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     heiko@sntech.de
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com,
        Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v2 3/3] thermal: rockchip: Support the PX30 SoC in thermal driver
Date:   Thu, 25 Apr 2019 18:12:29 +0800
Message-Id: <1556187154-22632-4-git-send-email-zhangqing@rock-chips.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556187154-22632-1-git-send-email-zhangqing@rock-chips.com>
References: <1556187154-22632-1-git-send-email-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PX30 SOC has two Temperature Sensors for CPU and GPU.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/thermal/rockchip_thermal.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 03ff494f2864..246d9513a465 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -225,11 +225,15 @@ struct rockchip_thermal_data {
 #define GRF_TSADC_TESTBIT_L			0x0e648
 #define GRF_TSADC_TESTBIT_H			0x0e64c
 
+#define PX30_GRF_SOC_CON2			0x0408
+
 #define GRF_SARADC_TESTBIT_ON			(0x10001 << 2)
 #define GRF_TSADC_TESTBIT_H_ON			(0x10001 << 2)
 #define GRF_TSADC_VCM_EN_L			(0x10001 << 7)
 #define GRF_TSADC_VCM_EN_H			(0x10001 << 7)
 
+#define GRF_CON_TSADC_CH_INV			(0x10001 << 1)
+
 /**
  * struct tsadc_table - code to temperature conversion table
  * @code: the value of adc channel
@@ -692,6 +696,13 @@ static void rk_tsadcv3_initialize(struct regmap *grf, void __iomem *regs,
 			       regs + TSADCV2_AUTO_CON);
 }
 
+static void rk_tsadcv4_initialize(struct regmap *grf, void __iomem *regs,
+				  enum tshut_polarity tshut_polarity)
+{
+	rk_tsadcv2_initialize(grf, regs, tshut_polarity);
+	regmap_write(grf, PX30_GRF_SOC_CON2, GRF_CON_TSADC_CH_INV);
+}
+
 static void rk_tsadcv2_irq_ack(void __iomem *regs)
 {
 	u32 val;
@@ -821,6 +832,30 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
 	writel_relaxed(val, regs + TSADCV2_INT_EN);
 }
 
+static const struct rockchip_tsadc_chip px30_tsadc_data = {
+	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
+	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
+	.chn_num = 2, /* 2 channels for tsadc */
+
+	.tshut_mode = TSHUT_MODE_CRU, /* default TSHUT via CRU */
+	.tshut_temp = 95000,
+
+	.initialize = rk_tsadcv4_initialize,
+	.irq_ack = rk_tsadcv3_irq_ack,
+	.control = rk_tsadcv3_control,
+	.get_temp = rk_tsadcv2_get_temp,
+	.set_alarm_temp = rk_tsadcv2_alarm_temp,
+	.set_tshut_temp = rk_tsadcv2_tshut_temp,
+	.set_tshut_mode = rk_tsadcv2_tshut_mode,
+
+	.table = {
+		.id = rk3328_code_table,
+		.length = ARRAY_SIZE(rk3328_code_table),
+		.data_mask = TSADCV2_DATA_MASK,
+		.mode = ADC_INCREMENT,
+	},
+};
+
 static const struct rockchip_tsadc_chip rv1108_tsadc_data = {
 	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
 	.chn_num = 1, /* one channel for tsadc */
@@ -993,6 +1028,9 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
 };
 
 static const struct of_device_id of_rockchip_thermal_match[] = {
+	{	.compatible = "rockchip,px30-tsadc",
+		.data = (void *)&px30_tsadc_data,
+	},
 	{
 		.compatible = "rockchip,rv1108-tsadc",
 		.data = (void *)&rv1108_tsadc_data,
-- 
1.9.1



