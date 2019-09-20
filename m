Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAE2C4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 12:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FEB20665
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 12:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eYnxTpbb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438343AbfITMZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 08:25:53 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41874 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408959AbfITMZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 08:25:50 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8KCPlGI097187;
        Fri, 20 Sep 2019 07:25:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568982347;
        bh=pG4mgl4smi0vXrCKt7NfFjfjMeyzcmFhFDSwFOsD8gU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=eYnxTpbbs5nIFIpA5v696GFAFocbhSzYhq1L4HYQY4/Ga3KfMzOQlXhb4qrQ2TUqO
         dW0kixrF9LElV/yl/xE4w5KbqkIDRq3s1zx47HXQ9ti6vRXCYr9LPF+c0ncScZVRkW
         pjxMW4G+UXvc5fuM2ZQsBj6M7lfH+6aPeMCK+SD4=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8KCPl5F001216
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Sep 2019 07:25:47 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 20
 Sep 2019 07:25:46 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 20 Sep 2019 07:25:42 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8KCPjjb016315;
        Fri, 20 Sep 2019 07:25:46 -0500
From:   Jean-Jacques Hiblot <jjhiblot@ti.com>
To:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <daniel.thompson@linaro.org>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmurphy@ti.com>, <tomi.valkeinen@ti.com>,
        Jean-Jacques Hiblot <jjhiblot@ti.com>
Subject: [PATCH v4 1/3] led: make led_set_brightness_sync() use led_set_brightness_nosleep()
Date:   Fri, 20 Sep 2019 14:25:23 +0200
Message-ID: <20190920122525.15712-2-jjhiblot@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190920122525.15712-1-jjhiblot@ti.com>
References: <20190920122525.15712-1-jjhiblot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Making led_set_brightness_sync() use led_set_brightness_nosleep() has 2
advantages:
- works for LED controllers that do not provide brightness_set_blocking()
- When the blocking callback is used, it uses the workqueue to update the
  LED state, removing the need for mutual exclusion between
  led_set_brightness_sync() and set_brightness_delayed().

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
---
 drivers/leds/led-core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
index f1f718dbe0f8..50e28a8f9357 100644
--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -294,15 +294,17 @@ EXPORT_SYMBOL_GPL(led_set_brightness_nosleep);
 int led_set_brightness_sync(struct led_classdev *led_cdev,
 			    enum led_brightness value)
 {
+	int ret;
+
 	if (led_cdev->blink_delay_on || led_cdev->blink_delay_off)
 		return -EBUSY;
 
-	led_cdev->brightness = min(value, led_cdev->max_brightness);
-
-	if (led_cdev->flags & LED_SUSPENDED)
-		return 0;
+	ret = led_set_brightness_nosleep(led_cdev, value);
+	if (!ret)
+		return ret;
 
-	return __led_set_brightness_blocking(led_cdev, led_cdev->brightness);
+	flush_work(&led_cdev->set_brightness_work);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(led_set_brightness_sync);
 
-- 
2.17.1

