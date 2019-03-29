Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C1CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C6F218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LRagdDwq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbfC2PrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:47:22 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49772 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729269AbfC2PrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:47:21 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2TFlGIC000368;
        Fri, 29 Mar 2019 10:47:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553874436;
        bh=AmbVrhxS9g/ZR6yBKcKLqSqDLiYJR2GhKSi862P1jss=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=LRagdDwqJAoRKgvHtDRiaDVSkA4zcImvgSZrqyNCC7XsLaQkMrewEq2EjMxc8kPuI
         9PdcCqGlPrcY6Jp374YEQwUB/xiU5LPgHUxrfH2vBL773tE09A1JZc7ZxhM5fhvx2r
         A1K1VYMregcObjf5P7U814u/H+3SPXYqpBm/T4iA=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2TFlGoh040859
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Mar 2019 10:47:16 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 29
 Mar 2019 10:47:15 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 29 Mar 2019 10:47:15 -0500
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2TFlF28074385;
        Fri, 29 Mar 2019 10:47:15 -0500
Received: from localhost ([10.250.67.168])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x2TFlFU27657;
        Fri, 29 Mar 2019 10:47:15 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH v3 2/2] ASoC: tlv320aic31xx: Add button press detection
Date:   Fri, 29 Mar 2019 10:47:04 -0500
Message-ID: <20190329154704.4922-2-afd@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190329154704.4922-1-afd@ti.com>
References: <20190329154704.4922-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device can optionally detect headset or microphone button presses.
Add support for this by passing this event to the jack layer.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---

Changes from v1:
 - Rebase

Changes from v2:
 - Rebase

 sound/soc/codecs/tlv320aic31xx.c | 17 +++++++++++++++--
 sound/soc/codecs/tlv320aic31xx.h |  3 ++-
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 3e11b3d41f3d..f59632ed2230 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1380,10 +1380,21 @@ static irqreturn_t aic31xx_irq(int irq, void *data)
 		dev_err(dev, "Short circuit on Left output is detected\n");
 	if (value & AIC31XX_HPRSCDETECT)
 		dev_err(dev, "Short circuit on Right output is detected\n");
-	if (value & AIC31XX_HSPLUG) {
+	if (value & (AIC31XX_HSPLUG | AIC31XX_BUTTONPRESS)) {
 		unsigned int val;
 		int status = 0;
 
+		ret = regmap_read(aic31xx->regmap, AIC31XX_INTRDACFLAG2,
+				  &val);
+		if (ret) {
+			dev_err(dev, "Failed to read interrupt mask: %d\n",
+				ret);
+			goto exit;
+		}
+
+		if (val & AIC31XX_BUTTONPRESS)
+			status |= SND_JACK_BTN_0;
+
 		ret = regmap_read(aic31xx->regmap, AIC31XX_HSDETECT, &val);
 		if (ret) {
 			dev_err(dev, "Failed to read headset type: %d\n", ret);
@@ -1408,7 +1419,8 @@ static irqreturn_t aic31xx_irq(int irq, void *data)
 	}
 	if (value & ~(AIC31XX_HPLSCDETECT |
 		      AIC31XX_HPRSCDETECT |
-		      AIC31XX_HSPLUG))
+		      AIC31XX_HSPLUG |
+		      AIC31XX_BUTTONPRESS))
 		dev_err(dev, "Unknown DAC interrupt flags: 0x%08x\n", value);
 
 read_overflow:
@@ -1522,6 +1534,7 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 
 		regmap_write(aic31xx->regmap, AIC31XX_INT1CTRL,
 			     AIC31XX_HSPLUGDET |
+			     AIC31XX_BUTTONPRESSDET |
 			     AIC31XX_SC |
 			     AIC31XX_ENGINE);
 
diff --git a/sound/soc/codecs/tlv320aic31xx.h b/sound/soc/codecs/tlv320aic31xx.h
index 9985ceed97ae..cb024955c978 100644
--- a/sound/soc/codecs/tlv320aic31xx.h
+++ b/sound/soc/codecs/tlv320aic31xx.h
@@ -21,7 +21,8 @@
 #define DAC31XX_BIT			BIT(3)
 
 #define AIC31XX_JACK_MASK (SND_JACK_HEADPHONE | \
-			   SND_JACK_HEADSET)
+			   SND_JACK_HEADSET | \
+			   SND_JACK_BTN_0)
 
 enum aic31xx_type {
 	AIC3100	= 0,
-- 
2.21.0

