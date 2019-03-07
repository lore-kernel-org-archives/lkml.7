Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27384C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5DFA20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Zv2rm0rM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfCGWKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 17:10:19 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40262 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfCGWKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 17:10:17 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x27MABl9123635;
        Thu, 7 Mar 2019 16:10:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551996611;
        bh=Yq1H9tpdUQlSl9Z4bOZkbnhMuJzjoJZUy3JCfrjZEZ8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Zv2rm0rMwDFFNR6q0OpGkesWzoI8JJqkQmngMV/8f0BbjAlNsXGzOAXOdPHxss49s
         hVtCA9Ojy0JY5XmDu5Un2CbI4b7S25cqqCd9/fTOwz0dBV5F3cGNFtrteBLOTr9INz
         gHeoO6tYwjYXx0Np/w5rKrCNvTGzSzJfEaKea1lg=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x27MABKU007886
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Mar 2019 16:10:11 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 7
 Mar 2019 16:10:11 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 7 Mar 2019 16:10:11 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x27MABep003182;
        Thu, 7 Mar 2019 16:10:11 -0600
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.83.167])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x27MAAU21687;
        Thu, 7 Mar 2019 16:10:10 -0600 (CST)
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <tony@atomide.com>, <lee.jones@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 3/4] mfd: ti-lmu: Remove LM3532 backlight driver references
Date:   Thu, 7 Mar 2019 16:09:46 -0600
Message-ID: <20190307220947.20057-3-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20190307220947.20057-1-dmurphy@ti.com>
References: <20190307220947.20057-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the LM3532 backlight driver references from the ti-lmu
code as dedicated driver support is available.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/mfd/ti-lmu.c       | 11 -----------
 include/linux/mfd/ti-lmu.h |  1 -
 2 files changed, 12 deletions(-)

diff --git a/drivers/mfd/ti-lmu.c b/drivers/mfd/ti-lmu.c
index 37d0bdb291c3..b06cb908d1aa 100644
--- a/drivers/mfd/ti-lmu.c
+++ b/drivers/mfd/ti-lmu.c
@@ -54,14 +54,6 @@ static void ti_lmu_disable_hw(void *data)
 		gpiod_set_value(lmu->en_gpio, 0);
 }
 
-static const struct mfd_cell lm3532_devices[] = {
-	{
-		.name          = "ti-lmu-backlight",
-		.id            = LM3532,
-		.of_compatible = "ti,lm3532-backlight",
-	},
-};
-
 #define LM363X_REGULATOR(_id)			\
 {						\
 	.name          = "lm363x-regulator",	\
@@ -141,7 +133,6 @@ static const struct ti_lmu_data chip##_data =	\
 	.max_register = max_reg,		\
 }						\
 
-TI_LMU_DATA(lm3532, LM3532_MAX_REG);
 TI_LMU_DATA(lm3631, LM3631_MAX_REG);
 TI_LMU_DATA(lm3632, LM3632_MAX_REG);
 TI_LMU_DATA(lm3633, LM3633_MAX_REG);
@@ -211,7 +202,6 @@ static int ti_lmu_probe(struct i2c_client *cl, const struct i2c_device_id *id)
 }
 
 static const struct of_device_id ti_lmu_of_match[] = {
-	{ .compatible = "ti,lm3532", .data = &lm3532_data },
 	{ .compatible = "ti,lm3631", .data = &lm3631_data },
 	{ .compatible = "ti,lm3632", .data = &lm3632_data },
 	{ .compatible = "ti,lm3633", .data = &lm3633_data },
@@ -222,7 +212,6 @@ static const struct of_device_id ti_lmu_of_match[] = {
 MODULE_DEVICE_TABLE(of, ti_lmu_of_match);
 
 static const struct i2c_device_id ti_lmu_ids[] = {
-	{ "lm3532", LM3532 },
 	{ "lm3631", LM3631 },
 	{ "lm3632", LM3632 },
 	{ "lm3633", LM3633 },
diff --git a/include/linux/mfd/ti-lmu.h b/include/linux/mfd/ti-lmu.h
index 1ef51ed36be5..7762c1bce55d 100644
--- a/include/linux/mfd/ti-lmu.h
+++ b/include/linux/mfd/ti-lmu.h
@@ -22,7 +22,6 @@
 #define LMU_EVENT_MONITOR_DONE		0x01
 
 enum ti_lmu_id {
-	LM3532,
 	LM3631,
 	LM3632,
 	LM3633,
-- 
2.20.1.390.gb5101f9297

