Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09284C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96B2206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbfH0NAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 09:00:37 -0400
Received: from mail.thorsis.com ([92.198.35.195]:43523 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfH0NAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:00:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id 558434ECF;
        Tue, 27 Aug 2019 15:01:41 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CrP9xAz6rOr8; Tue, 27 Aug 2019 15:01:41 +0200 (CEST)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id B2509F0F; Tue, 27 Aug 2019 15:01:38 +0200 (CEST)
Received: from adahl by ada.ifak-system.com with local (Exim 4.89)
        (envelope-from <ada@thorsis.com>)
        id 1i2b5H-0007YO-6f; Tue, 27 Aug 2019 15:00:27 +0200
From:   Alexander Dahl <ada@thorsis.com>
To:     linux-leds@vger.kernel.org
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] leds: syscon: Use resource managed variant of device register
Date:   Tue, 27 Aug 2019 15:00:27 +0200
Message-Id: <20190827130027.28998-1-ada@thorsis.com>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a MFD driver compiled as module instantiating this driver. When
unloading that module, those LED devices are not removed, which produces
conflicts, when that module is inserted again.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/leds/leds-syscon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-syscon.c b/drivers/leds/leds-syscon.c
index e35dff0050f0..b58f3cafe16f 100644
--- a/drivers/leds/leds-syscon.c
+++ b/drivers/leds/leds-syscon.c
@@ -115,7 +115,7 @@ static int syscon_led_probe(struct platform_device *pdev)
 	}
 	sled->cdev.brightness_set = syscon_led_set;
 
-	ret = led_classdev_register(dev, &sled->cdev);
+	ret = devm_led_classdev_register(dev, &sled->cdev);
 	if (ret < 0)
 		return ret;
 
-- 
2.20.1

