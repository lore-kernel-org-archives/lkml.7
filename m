Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F40EC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5DEF2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TMAR2YSd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbfH2TSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:18:42 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56344 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbfH2TSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:18:42 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7TJIb8F000568;
        Thu, 29 Aug 2019 14:18:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1567106317;
        bh=YPMK3qy+FwQWJdK8CXDbDuVTKiryLM2FqawPb2zrJX4=;
        h=From:To:CC:Subject:Date;
        b=TMAR2YSdE+rVZ2I95l+fsw4cG8mFSmSWsRLMWVNMvh2r6s/a/Dn0Z4cM6wMOaoz/X
         iYkVVoKLlXCU1fx2xoYSryn9tdQIV2EjCv8o6B9H7YrgWfbteekz2Vf/A/b1hed26B
         GZm9gZyR0HcQ76xV4H672Sg0Vm9A0W9xkKex5iyI=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7TJIb7g098727
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Aug 2019 14:18:37 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 29
 Aug 2019 14:18:37 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 29 Aug 2019 14:18:37 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7TJIaOS113670;
        Thu, 29 Aug 2019 14:18:37 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH] leds: lm3532: Fix optional led-max-microamp prop error handling
Date:   Thu, 29 Aug 2019 14:18:36 -0500
Message-ID: <20190829191836.9648-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.22.0.214.g8dca754b1e
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the error handling for the led-max-microamp property.
Need to check if the property is present and then if it is
retrieve the setting and its max boundary

Reported-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/leds/leds-lm3532.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/leds/leds-lm3532.c b/drivers/leds/leds-lm3532.c
index c5cfd8e3f15f..13b4265fb85a 100644
--- a/drivers/leds/leds-lm3532.c
+++ b/drivers/leds/leds-lm3532.c
@@ -601,11 +601,15 @@ static int lm3532_parse_node(struct lm3532_data *priv)
 			goto child_out;
 		}
 
-		ret = fwnode_property_read_u32(child, "led-max-microamp",
-					       &led->full_scale_current);
-
-		if (led->full_scale_current > LM3532_FS_CURR_MAX)
-			led->full_scale_current = LM3532_FS_CURR_MAX;
+		if (fwnode_property_present(child, "led-max-microamp")) {
+			if (fwnode_property_read_u32(child, "led-max-microamp",
+						     &led->full_scale_current))
+				dev_err(&priv->client->dev,
+					"Failed getting led-max-microamp\n");
+
+			if (led->full_scale_current > LM3532_FS_CURR_MAX)
+				led->full_scale_current = LM3532_FS_CURR_MAX;
+		}
 
 		if (led->mode == LM3532_BL_MODE_ALS) {
 			led->mode = LM3532_ALS_CTRL;
-- 
2.22.0.214.g8dca754b1e

