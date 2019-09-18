Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E477FC4CECE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 15:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D0120665
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 15:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PPpRS3UF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387465AbfIRP0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 11:26:17 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57186 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387432AbfIRP0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 11:26:14 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8IFQBYu121597;
        Wed, 18 Sep 2019 10:26:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568820371;
        bh=QM61BTqrkwGiL8NEpqP/iQB0DBs6+UUglmyZrxaauVU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=PPpRS3UFrrUnD5JidU4cRwGYGD2LQzpL2jzL9QuWzMSro+pdaLLDGJH3O1Mtd1upP
         l9jhsPN0H4+KPU56VFgT97gaKQVAH7pGmJg+JO7sFI7PmsghpbSFGxn6/zwS3lT/Hv
         iz6RrJanXpTa84nBO7Xxwu8FL0AinCVdpybDgLVY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8IFQB8b069052;
        Wed, 18 Sep 2019 10:26:11 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 18
 Sep 2019 10:26:11 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 18 Sep 2019 10:26:08 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8IFQA5h055847;
        Wed, 18 Sep 2019 10:26:11 -0500
From:   Jean-Jacques Hiblot <jjhiblot@ti.com>
To:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>, <dmurphy@ti.com>
CC:     <tomi.valkeinen@ti.com>, <linux-leds@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@ti.com>
Subject: [PATCH v3 2/2] leds: tlc591xx: use devm_led_classdev_register_ext()
Date:   Wed, 18 Sep 2019 17:25:56 +0200
Message-ID: <20190918152556.9925-3-jjhiblot@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190918152556.9925-1-jjhiblot@ti.com>
References: <20190918152556.9925-1-jjhiblot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_led_classdev_register_ext() to pass the fwnode to the LED core.
The fwnode can then be used by the firmware core to create meaningful
names.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
---
 drivers/leds/leds-tlc591xx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/leds-tlc591xx.c b/drivers/leds/leds-tlc591xx.c
index 3d5a4b92f016..bab792ed59c3 100644
--- a/drivers/leds/leds-tlc591xx.c
+++ b/drivers/leds/leds-tlc591xx.c
@@ -184,6 +184,9 @@ tlc591xx_probe(struct i2c_client *client,
 
 	for_each_child_of_node(np, child) {
 		struct tlc591xx_led *led;
+		struct led_init_data init_data = {};
+
+		init_data.fwnode = of_fwnode_handle(child);
 
 		err = of_property_read_u32(child, "reg", &reg);
 		if (err) {
@@ -198,8 +201,6 @@ tlc591xx_probe(struct i2c_client *client,
 		led = &priv->leds[reg];
 
 		led->active = true;
-		led->ldev.name =
-			of_get_property(child, "label", NULL) ? : child->name;
 		led->ldev.default_trigger =
 			of_get_property(child, "linux,default-trigger", NULL);
 
@@ -207,7 +208,8 @@ tlc591xx_probe(struct i2c_client *client,
 		led->led_no = reg;
 		led->ldev.brightness_set_blocking = tlc591xx_brightness_set;
 		led->ldev.max_brightness = LED_FULL;
-		err = devm_led_classdev_register(dev, &led->ldev);
+		err = devm_led_classdev_register_ext(dev, &led->ldev,
+						     &init_data);
 		if (err < 0) {
 			dev_err(dev, "couldn't register LED %s\n",
 				led->ldev.name);
-- 
2.17.1

