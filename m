Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6161C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D64206F0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intenta.de header.i=@intenta.de header.b="izslhIGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgAGMME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:12:04 -0500
Received: from mail.intenta.de ([178.249.25.132]:31287 "EHLO mail.intenta.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbgAGMME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 07:12:04 -0500
X-Greylist: delayed 355 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Jan 2020 07:12:03 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=intenta.de; s=dkim1;
        h=Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date; bh=IyyrdIDQlwVJClfzGwNhR8Zly4pMsd9+TJ5wRCXLDtM=;
        b=izslhIGqY/ast6R96SpD0DtDi5NakZBPyOMQtkFRXaL8JaF7UgbEZy7oKKbW/EQ7ANu+IwvaLUpj/6TrSd9wFzro5hOZZ+snHV4dUAuTfkXuPxcz4IybuRoM9JNwl2DmIefAHQrBLVSxQ5rBCzz56QFqeghi8vXvEoQ3dGdaM3RgSvhnNuTo97YymO8zRoC3NltdFmkbIngEyCt60ShTuofJcT1zb7swvgAirCFzA0Lkn/ev74jVvkx9j4mCW5p8gA6B+KEsI8S42tKWTKh58R77B6NLmF+JUc7Aibzr+7oBDB6qX9jsZ929cs+pG70QQdLRSojTe4vN55C6JDeT/g==;
Date:   Tue, 7 Jan 2020 13:06:03 +0100
From:   Helmut Grohne <helmut.grohne@intenta.de>
To:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] mfd: da9062: enable being a system-power-controller
Message-ID: <20200107120559.GA700@laureti-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ICSMA002.intenta.de (10.10.16.48) To ICSMA002.intenta.de
 (10.10.16.48)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DA9062 can be the device used to power the CPU. In that case, it can
be used to power off the system. In the CONTROL_A register, the M_*_EN
bits must be zero for the corresponding *_EN bits to have an effect. We
zero them all to turn off the system.

Signed-off-by: Helmut Grohne <helmut.grohne@intenta.de>
---
 drivers/mfd/da9062-core.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

This patch includes the functionality into the da9062-core driver. If
that is not the preferred way to integrate it, it can be added as a
mfd_cell instead. In that case, I can move the functionality to a new
drivers/power/reset/da9062-poweroff.c. As far as I can see, doing so
implies that we can no longer use the standard system-power-controller
property though and must use a new compatible property
dlg,da9062-poweroff. Please let me know your preference.

diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index e69626867c26..a2b5dfee677f 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -572,6 +572,23 @@ static const struct of_device_id da9062_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, da9062_dt_ids);
 
+/* Hold client since pm_power_off is global. */
+static struct i2c_client *da9062_i2c_client;
+
+static void da9062_power_off(void)
+{
+	struct da9062 *chip = i2c_get_clientdata(da9062_i2c_client);
+	const unsigned int mask = DA9062AA_SYSTEM_EN_MASK |
+		DA9062AA_POWER_EN_MASK | DA9062AA_POWER1_EN_MASK |
+		DA9062AA_M_SYSTEM_EN_MASK | DA9062AA_M_POWER_EN_MASK |
+		DA9062AA_M_POWER1_EN_MASK;
+	int ret = regmap_update_bits(chip->regmap, DA9062AA_CONTROL_A, mask, 0);
+
+	if (ret < 0)
+		dev_err(&da9062_i2c_client->dev,
+			"DA9062AA_CONTROL_A update failed, %d\n", ret);
+}
+
 static int da9062_i2c_probe(struct i2c_client *i2c,
 	const struct i2c_device_id *id)
 {
@@ -661,6 +678,15 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	if (of_device_is_system_power_controller(i2c->dev.of_node)) {
+		if (!pm_power_off) {
+			da9062_i2c_client = i2c;
+			pm_power_off = da9062_power_off;
+		} else {
+			dev_warn(&i2c->dev, "Poweroff callback already assigned\n");
+		}
+	}
+
 	return ret;
 }
 
@@ -668,6 +694,11 @@ static int da9062_i2c_remove(struct i2c_client *i2c)
 {
 	struct da9062 *chip = i2c_get_clientdata(i2c);
 
+	if (pm_power_off == da9062_power_off)
+		pm_power_off = NULL;
+	if (da9062_i2c_client)
+		da9062_i2c_client = NULL;
+
 	mfd_remove_devices(chip->dev);
 	regmap_del_irq_chip(i2c->irq, chip->regmap_irq);
 
-- 
2.20.1

