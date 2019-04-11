Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB41C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C74F2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VExnVpkW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfDKTjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 15:39:11 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50452 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfDKTjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 15:39:10 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3BJcpPs097034;
        Thu, 11 Apr 2019 14:38:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555011531;
        bh=baqNVO7clRuyE5fP6zoOVX4pSxUZ/nsAbVFV7wkYINw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VExnVpkW31gv5R/TPVQKllr6TeY+e/4B98I503LB8AJySE3+65ySZwL8NvZcP633g
         ZyP7iO5pySLtC/lrWaHY28P25f6+pvKJA5W0c5fQIcjHkk+9n3W+6NDEeDXvwTwvCr
         vyUcd0idH4aawprBpoNyUMfAIwJAz4tW0Gd+PN0E=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3BJcp6Z120624
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Apr 2019 14:38:51 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 11
 Apr 2019 14:38:51 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 11 Apr 2019 14:38:51 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3BJcoZW073810;
        Thu, 11 Apr 2019 14:38:50 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <marek.behun@nic.cz>, <rdunlap@infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v2 4/7] dt-bindings: leds: Add multicolor ID to the color ID list
Date:   Thu, 11 Apr 2019 14:38:45 -0500
Message-ID: <20190411193848.23140-5-dmurphy@ti.com>
X-Mailer: git-send-email 2.21.0.5.gaeb582a983
In-Reply-To: <20190411193848.23140-1-dmurphy@ti.com>
References: <20190411193848.23140-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new color ID that is declared as MULTICOLOR as with the
multicolor framework declaring a definitive color is not accurate
as the node can contain multiple colors.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/leds/led-class.c          | 1 +
 include/dt-bindings/leds/common.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index bfd46a9bba63..11dd78b63403 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -35,6 +35,7 @@ const char *led_colors[LED_COLOR_ID_COUNT] = {
 	[LED_COLOR_ID_VIOLET] = "violet",
 	[LED_COLOR_ID_YELLOW] = "yellow",
 	[LED_COLOR_ID_IR] = "ir",
+	[LED_COLOR_ID_MULTI] = "multicolor",
 };
 EXPORT_SYMBOL_GPL(led_colors);
 
diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
index c95f39b3a254..f6df2c63398e 100644
--- a/include/dt-bindings/leds/common.h
+++ b/include/dt-bindings/leds/common.h
@@ -64,6 +64,7 @@
 #define LED_COLOR_ID_VIOLET	5
 #define LED_COLOR_ID_YELLOW	6
 #define LED_COLOR_ID_IR		7
-#define LED_COLOR_ID_COUNT	8
+#define LED_COLOR_ID_MULTI	8
+#define LED_COLOR_ID_COUNT	9
 
 #endif /* __DT_BINDINGS_LEDS_H */
-- 
2.21.0.5.gaeb582a983

