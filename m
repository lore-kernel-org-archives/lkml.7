Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEB5C7DBAB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187EC246EF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbfLMSNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 13:13:32 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:44233 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbfLMSNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 13:13:31 -0500
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id A9E9920003;
        Fri, 13 Dec 2019 18:13:27 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH] drm/panel: simple: Support reset GPIOs
Date:   Fri, 13 Dec 2019 19:13:25 +0100
Message-Id: <20191213181325.26228-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panel common bindings provide a gpios-reset property which is
active low by default. Let's support it in the simple driver.

De-asserting the reset pin implies a physical high, which in turns is
a logic low.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 5d487686d25c..15dd495c347d 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -110,6 +110,7 @@ struct panel_simple {
 	struct i2c_adapter *ddc;
 
 	struct gpio_desc *enable_gpio;
+	struct gpio_desc *reset_gpio;
 
 	struct drm_display_mode override_mode;
 };
@@ -433,12 +434,21 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
 	if (IS_ERR(panel->supply))
 		return PTR_ERR(panel->supply);
 
+	panel->reset_gpio = devm_gpiod_get_optional(dev, "reset",
+						    GPIOD_OUT_LOW);
+	if (IS_ERR(panel->reset_gpio)) {
+		err = PTR_ERR(panel->reset_gpio);
+		if (err != -EPROBE_DEFER)
+			dev_err(dev, "failed to request reset pin: %d\n", err);
+		return err;
+	}
+
 	panel->enable_gpio = devm_gpiod_get_optional(dev, "enable",
 						     GPIOD_OUT_LOW);
 	if (IS_ERR(panel->enable_gpio)) {
 		err = PTR_ERR(panel->enable_gpio);
 		if (err != -EPROBE_DEFER)
-			dev_err(dev, "failed to request GPIO: %d\n", err);
+			dev_err(dev, "failed to request enable pin: %d\n", err);
 		return err;
 	}
 
-- 
2.20.1

