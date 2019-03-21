Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C0EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 02:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A3F218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 02:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfCUCf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 22:35:58 -0400
Received: from smtpbg65.qq.com ([103.7.28.233]:22649 "EHLO smtpbg65.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727507AbfCUCf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 22:35:58 -0400
X-QQ-mid: bizesmtp13t1553135732t8j2wzla
Received: from ubuntu.gz.cvte.cn (unknown [183.63.127.82])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 21 Mar 2019 10:35:26 +0800 (CST)
X-QQ-SSF: 01400000002000N0YM40000A0000000
X-QQ-FEAT: QX/rXDl9P1s+MhQv4S+EFjcI0R4m0l7vL1bvE1UQlbFvEs6gJeJGuXtcYEd6I
        pUjiWRTr20+M/QMM6lmcDX+TFF7AT3YBvvYdCl72tS9JnsCbAaz/kGEwtvXZ3sO3dxi2uSU
        8f/1EHnTF8YIJLI1VpWW1Clw7AUvA+UxG+qxzQzHRuprEhn6bCsKDgBoudry+ycNMBb7jwo
        0nB3X5BNWGsW3EILh03VDLKlDKQBr6Lf73Dkg007Nsed8lgJThOhLRkFKWqh8jYKU3maznb
        eG8LEoxGhjdpj7XnCCdCnxA6s=
X-QQ-GoodBg: 2
From:   zhuchangchun <zhuchangchun@cvte.com>
To:     mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, hendychu@aliyun.com,
        zhuchangchun <zhuchangchun@cvte.com>
Subject: [PATCH] pinctrl: intel: Implements gpio free function
Date:   Thu, 21 Mar 2019 10:35:24 +0800
Message-Id: <1553135724-38331-1-git-send-email-zhuchangchun@cvte.com>
X-Mailer: git-send-email 2.7.4
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cvte.com:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we use the gpio to control some peripheral devices,and try to
export the gpio first,then unexport the gpio, we test the signal with
oscilloscope,and find the signal can't meet the requirements,because
after we unexported the gpio,the gpio's register(tx and rx)value can't
be recovered,and this will infruence the device work flow.

We check the gpio's unexport code work flow, then find the gpio's free
hook function has not been implemented, After we add pinmux_ops' free
function to set exported gpio to recover its original value,the problem
is fixed.

Signed-off-by: zhuchangchun <zhuchangchun@cvte.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 3b18181..002b9d3 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -480,6 +480,33 @@ static int intel_gpio_set_direction(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
+static int intel_gpio_free(struct pinctrl_dev *pctldev, unsigned int pin)
+{
+	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
+	void __iomem *padcfg0;
+	unsigned long flags;
+	u32 value;
+
+	spin_lock_irqsave(&pctrl->lock, flags);
+
+	if (!intel_pad_usable(pctrl, pin)) {
+		spin_unlock_irqrestore(&pctrl->lock, flags);
+		return -EBUSY;
+	}
+	padcfg0 = intel_get_padcfg(pctrl, pin, PADCFG0);
+
+	/* Put the pad into GPIO mode */
+	value = readl(padcfg0) & ~PADCFG0_PMODE_MASK;
+	/* enable TX buffer and disable RX (this will be input) */
+	value |= PADCFG0_GPIORXDIS;
+	value &= ~PADCFG0_GPIOTXDIS;
+	writel(value, padcfg0);
+
+	spin_unlock_irqrestore(&pctrl->lock, flags);
+
+	return 0;
+}
+
 static const struct pinmux_ops intel_pinmux_ops = {
 	.get_functions_count = intel_get_functions_count,
 	.get_function_name = intel_get_function_name,
@@ -487,6 +514,7 @@ static const struct pinmux_ops intel_pinmux_ops = {
 	.set_mux = intel_pinmux_set_mux,
 	.gpio_request_enable = intel_gpio_request_enable,
 	.gpio_set_direction = intel_gpio_set_direction,
+	.free = intel_gpio_free,
 };
 
 static int intel_config_get(struct pinctrl_dev *pctldev, unsigned int pin,
-- 
2.7.4



