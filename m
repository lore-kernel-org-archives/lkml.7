Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0E8C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1322126446
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfEaGwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 02:52:07 -0400
Received: from alexa-out-tai-01.qualcomm.com ([103.229.16.226]:42773 "EHLO
        alexa-out-tai-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726002AbfEaGwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 02:52:07 -0400
Received: from ironmsg02-tai.qualcomm.com ([10.249.140.7])
  by alexa-out-tai-01.qualcomm.com with ESMTP; 31 May 2019 14:52:04 +0800
X-IronPort-AV: E=McAfee;i="5900,7806,9273"; a="30797288"
Received: from c-fan-gv.ap.qualcomm.com (HELO c-fan-gv) ([10.231.253.105])
  by ironmsg02-tai.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 May 2019 14:51:55 +0800
From:   Tengfei Fan <tengfeif@codeaurora.org>
To:     bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, linus.walleij@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tengfei Fan <tengfeif@codeaurora.org>
Subject: [PATCH] pinctrl: qcom: Clear status bit on irq_unmask
Date:   Fri, 31 May 2019 14:51:52 +0800
Message-Id: <1559285512-27784-1-git-send-email-tengfeif@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gpio interrupt status bit is getting set after the
irq is disabled and causing an immediate interrupt after
enablling the irq, so clear status bit on irq_unmask.

Signed-off-by: Tengfei Fan <tengfeif@codeaurora.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index ee81198..7283c50 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -740,6 +740,7 @@ static void msm_gpio_irq_mask(struct irq_data *d)
 static void msm_gpio_irq_unmask(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	uint32_t irqtype = irqd_get_trigger_type(d);
 	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
 	const struct msm_pingroup *g;
 	unsigned long flags;
@@ -749,6 +750,12 @@ static void msm_gpio_irq_unmask(struct irq_data *d)
 
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
+	if (irqtype & (IRQF_TRIGGER_HIGH | IRQF_TRIGGER_LOW)) {
+		val = readl_relaxed(pctrl->regs + g->intr_status_reg);
+		val &= ~BIT(g->intr_status_bit);
+		 writel_relaxed(val, pctrl->regs + g->intr_status_reg);
+	}
+
 	val = msm_readl_intr_cfg(pctrl, g);
 	val |= BIT(g->intr_raw_status_bit);
 	val |= BIT(g->intr_enable_bit);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

