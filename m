Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC51C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BBD2073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555396833;
	bh=leU528GPgbbl6FZ0hvYD1ThhlYXuBMbC39ljevMevzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WTeVaxVnMcGk7b7H/xlCeZx2q6ZtHMMl/QgQFZFO624oQBmorLNvSy2d+0PG8JQAR
	 gAIwGYPMfL4oSgK/t1xqfwHZ6wSC4Yi8EHh8K7SEZYfzPq7DGXxV/1nNhYZ1iRyJCp
	 Ak+u644kJHxI0gISPRzn7kXlHW3Or0W/+gz4gnJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbfDPGkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 02:40:33 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:33982 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbfDPGk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 02:40:29 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id 8C7A95FD9F; Tue, 16 Apr 2019 14:40:25 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v4 2/7] power: supply: axp20x_usb_power: Fix typo in VBUS current limit macros
Date:   Tue, 16 Apr 2019 14:40:19 +0800
Message-Id: <20190416064024.20414-3-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416064024.20414-1-wens@kernel.org>
References: <20190416064024.20414-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The VBUS current limit value macros have VBUS typed as VBUC, while
the bitmask macro is named correctly. Fix it.

Fixes: 69fb4dcada77 ("power: Add an axp20x-usb-power driver")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/power/supply/axp20x_usb_power.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index f52fe77edb6f..cd9b90d79839 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -36,10 +36,10 @@
 #define AXP20X_VBUS_VHOLD_MASK		GENMASK(5, 3)
 #define AXP20X_VBUS_VHOLD_OFFSET	3
 #define AXP20X_VBUS_CLIMIT_MASK		3
-#define AXP20X_VBUC_CLIMIT_900mA	0
-#define AXP20X_VBUC_CLIMIT_500mA	1
-#define AXP20X_VBUC_CLIMIT_100mA	2
-#define AXP20X_VBUC_CLIMIT_NONE		3
+#define AXP20X_VBUS_CLIMIT_900mA	0
+#define AXP20X_VBUS_CLIMIT_500mA	1
+#define AXP20X_VBUS_CLIMIT_100mA	2
+#define AXP20X_VBUS_CLIMIT_NONE		3
 
 #define AXP20X_ADC_EN1_VBUS_CURR	BIT(2)
 #define AXP20X_ADC_EN1_VBUS_VOLT	BIT(3)
@@ -107,19 +107,19 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 			return ret;
 
 		switch (v & AXP20X_VBUS_CLIMIT_MASK) {
-		case AXP20X_VBUC_CLIMIT_100mA:
+		case AXP20X_VBUS_CLIMIT_100mA:
 			if (power->axp20x_id == AXP221_ID)
 				val->intval = -1; /* No 100mA limit */
 			else
 				val->intval = 100000;
 			break;
-		case AXP20X_VBUC_CLIMIT_500mA:
+		case AXP20X_VBUS_CLIMIT_500mA:
 			val->intval = 500000;
 			break;
-		case AXP20X_VBUC_CLIMIT_900mA:
+		case AXP20X_VBUS_CLIMIT_900mA:
 			val->intval = 900000;
 			break;
-		case AXP20X_VBUC_CLIMIT_NONE:
+		case AXP20X_VBUS_CLIMIT_NONE:
 			val->intval = -1;
 			break;
 		}
-- 
2.20.1

