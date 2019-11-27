Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0A4C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C046206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfK0InN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 03:43:13 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:52832 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfK0InL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 03:43:11 -0500
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id Wwiu2100W5USYZQ01wiua3; Wed, 27 Nov 2019 09:43:09 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iZsuU-0000xj-Mm; Wed, 27 Nov 2019 09:42:54 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iZsuU-0004Ol-KQ; Wed, 27 Nov 2019 09:42:54 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Harish Jenny K N <harish_kandiga@mentor.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Alexander Graf <graf@amazon.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Phil Reid <preid@electromag.com.au>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 3/7] gpiolib: Add support for GPIO line table lookup
Date:   Wed, 27 Nov 2019 09:42:49 +0100
Message-Id: <20191127084253.16356-4-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191127084253.16356-1-geert+renesas@glider.be>
References: <20191127084253.16356-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently GPIOs can only be referred to by GPIO controller and offset in
GPIO lookup tables.

Add support for looking them up by line name.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
If this is rejected, the GPIO Aggregator documentation and code must be
updated.

v3:
  - New.
---
 drivers/gpio/gpiolib.c       | 12 ++++++++++++
 include/linux/gpio/machine.h |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index d24a3d79dcfe69ad..cb608512ad6bbded 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4475,6 +4475,18 @@ static struct gpio_desc *gpiod_find(struct device *dev, const char *con_id,
 		if (p->con_id && (!con_id || strcmp(p->con_id, con_id)))
 			continue;
 
+		if (p->chip_hwnum == (u16)-1) {
+			desc = gpio_name_to_desc(p->chip_label);
+			if (desc) {
+				*flags = p->flags;
+				return desc;
+			}
+
+			dev_warn(dev, "cannot find GPIO line %s, deferring\n",
+				 p->chip_label);
+			return ERR_PTR(-EPROBE_DEFER);
+		}
+
 		chip = find_chip_by_name(p->chip_label);
 
 		if (!chip) {
diff --git a/include/linux/gpio/machine.h b/include/linux/gpio/machine.h
index 1ebe5be05d5f81fa..84c1c097e55eefaf 100644
--- a/include/linux/gpio/machine.h
+++ b/include/linux/gpio/machine.h
@@ -31,7 +31,7 @@ enum gpio_lookup_flags {
  */
 struct gpiod_lookup {
 	const char *chip_label;
-	u16 chip_hwnum;
+	u16 chip_hwnum;			/* if -1, chip_label is named line */
 	const char *con_id;
 	unsigned int idx;
 	unsigned long flags;
-- 
2.17.1

