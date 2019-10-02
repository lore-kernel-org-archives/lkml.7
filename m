Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2801ECE58B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 11:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D487321920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 11:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfJBL0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 07:26:49 -0400
Received: from hermes.aosc.io ([199.195.250.187]:42439 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbfJBL0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 07:26:48 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id DE8DE82D37;
        Wed,  2 Oct 2019 11:26:45 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 1/2] power: supply: axp20x_usb_power: enable USB BC detection on AXP813
Date:   Wed,  2 Oct 2019 19:25:44 +0800
Message-Id: <20191002112545.58481-2-icenowy@aosc.io>
In-Reply-To: <20191002112545.58481-1-icenowy@aosc.io>
References: <20191002112545.58481-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP813 PMIC has support for detection of USB Battery Charging
specification, and it will limit the current to 500mA by default when
the detection is not enabled or the detection result is SDP.

Enable the BC detection to allow correctly selection of the current.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/power/supply/axp20x_usb_power.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index dc4c316eff81..5f0a5722b19e 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -48,6 +48,8 @@
 
 #define AXP20X_VBUS_MON_VBUS_VALID	BIT(3)
 
+#define AXP813_BC_EN		BIT(0)
+
 /*
  * Note do not raise the debounce time, we must report Vusb high within
  * 100ms otherwise we get Vbus errors in musb.
@@ -495,6 +497,12 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	if (power->axp20x_id == AXP813_ID) {
+		/* Enable USB Battery Charging specification detection */
+		regmap_update_bits(axp20x->regmap, AXP288_BC_GLOBAL,
+				   AXP813_BC_EN, AXP813_BC_EN);
+	}
+
 	psy_cfg.of_node = pdev->dev.of_node;
 	psy_cfg.drv_data = power;
 
-- 
2.21.0

