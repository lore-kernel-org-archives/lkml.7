Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC52FC4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 01:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE66F2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 01:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392630AbfIJBvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 21:51:54 -0400
Received: from mx.socionext.com ([202.248.49.38]:11572 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbfIJBvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 21:51:53 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 10 Sep 2019 10:51:51 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id DDFBC605F8;
        Tue, 10 Sep 2019 10:51:51 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 10 Sep 2019 10:51:51 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 5EFEF1A04FB;
        Tue, 10 Sep 2019 10:51:51 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] regulator: uniphier: Add Pro5 USB3 VBUS support
Date:   Tue, 10 Sep 2019 10:51:44 +0900
Message-Id: <1568080304-1572-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pro5 SoC has same scheme of USB3 VBUS as Pro4, so the data for Pro5 is
equivalent to Pro4.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 Documentation/devicetree/bindings/regulator/uniphier-regulator.txt | 5 +++--
 drivers/regulator/uniphier-regulator.c                             | 4 ++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/uniphier-regulator.txt b/Documentation/devicetree/bindings/regulator/uniphier-regulator.txt
index c9919f4..94fd38b 100644
--- a/Documentation/devicetree/bindings/regulator/uniphier-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/uniphier-regulator.txt
@@ -13,6 +13,7 @@ this layer. These clocks and resets should be described in each property.
 Required properties:
 - compatible: Should be
     "socionext,uniphier-pro4-usb3-regulator" - for Pro4 SoC
+    "socionext,uniphier-pro5-usb3-regulator" - for Pro5 SoC
     "socionext,uniphier-pxs2-usb3-regulator" - for PXs2 SoC
     "socionext,uniphier-ld20-usb3-regulator" - for LD20 SoC
     "socionext,uniphier-pxs3-usb3-regulator" - for PXs3 SoC
@@ -20,12 +21,12 @@ Required properties:
 - clocks: A list of phandles to the clock gate for USB3 glue layer.
 	According to the clock-names, appropriate clocks are required.
 - clock-names: Should contain
-    "gio", "link" - for Pro4 SoC
+    "gio", "link" - for Pro4 and Pro5 SoCs
     "link"        - for others
 - resets: A list of phandles to the reset control for USB3 glue layer.
 	According to the reset-names, appropriate resets are required.
 - reset-names: Should contain
-    "gio", "link" - for Pro4 SoC
+    "gio", "link" - for Pro4 and Pro5 SoCs
     "link"        - for others
 
 See Documentation/devicetree/bindings/regulator/regulator.txt
diff --git a/drivers/regulator/uniphier-regulator.c b/drivers/regulator/uniphier-regulator.c
index 9026d5a..2311924 100644
--- a/drivers/regulator/uniphier-regulator.c
+++ b/drivers/regulator/uniphier-regulator.c
@@ -186,6 +186,10 @@ static const struct of_device_id uniphier_regulator_match[] = {
 		.data = &uniphier_pro4_usb3_data,
 	},
 	{
+		.compatible = "socionext,uniphier-pro5-usb3-regulator",
+		.data = &uniphier_pro4_usb3_data,
+	},
+	{
 		.compatible = "socionext,uniphier-pxs2-usb3-regulator",
 		.data = &uniphier_pxs2_usb3_data,
 	},
-- 
2.7.4

