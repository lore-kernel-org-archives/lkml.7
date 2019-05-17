Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB61C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 15:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA562083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 15:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbfEQPGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 11:06:04 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:39315 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728935AbfEQPGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 11:06:04 -0400
X-Originating-IP: 90.88.22.185
Received: from localhost.localdomain (aaubervilliers-681-1-80-185.w90-88.abo.wanadoo.fr [90.88.22.185])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 17FCF24000F;
        Fri, 17 May 2019 15:05:57 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH] backlight: gpio-backlight: Set power state instead of brightness at probe
Date:   Fri, 17 May 2019 17:05:46 +0200
Message-Id: <20190517150546.4508-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a trivial gpio-backlight setup with a panel using the backlight but
no boot software to enable it beforehand, we fall in a case where the
backlight is disabled (not just blanked) and thus remains disabled when
the panel gets enabled.

Setting gbl->def_value via the device-tree prop allows enabling the
backlight in this situation, but it will be unblanked straight away,
in compliance with the binding. This does not work well when there was no
boot software to display something before, since we really need to unblank
by the time the panel is enabled, not before.

Resolve the situation by setting the brightness to 1 at probe and
managing the power state accordingly, a bit like it's done in
pwm-backlight.

Fixes: 8b770e3c9824 ("backlight: Add GPIO-based backlight driver")
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/video/backlight/gpio_backlight.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index e470da95d806..c9cb97fa13d0 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -57,6 +57,21 @@ static const struct backlight_ops gpio_backlight_ops = {
 	.check_fb	= gpio_backlight_check_fb,
 };
 
+static int gpio_backlight_initial_power_state(struct gpio_backlight *gbl)
+{
+	struct device_node *node = gbl->dev->of_node;
+
+	/* If we absolutely want the backlight enabled at boot. */
+	if (gbl->def_value)
+		return FB_BLANK_UNBLANK;
+
+	/* If there's no panel to unblank the backlight later. */
+	if (!node || !node->phandle)
+		return FB_BLANK_UNBLANK;
+
+	return FB_BLANK_POWERDOWN;
+}
+
 static int gpio_backlight_probe_dt(struct platform_device *pdev,
 				   struct gpio_backlight *gbl)
 {
@@ -142,7 +157,9 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 		return PTR_ERR(bl);
 	}
 
-	bl->props.brightness = gbl->def_value;
+	bl->props.brightness = 1;
+	bl->props.power = gpio_backlight_initial_power_state(gbl);
+
 	backlight_update_status(bl);
 
 	platform_set_drvdata(pdev, bl);
-- 
2.21.0

