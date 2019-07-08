Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668F7C5B57D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 360312064B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JR3BZbIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbfGHIsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 04:48:43 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:43784 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfGHIsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 04:48:43 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x688mfSc105328;
        Mon, 8 Jul 2019 03:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1562575721;
        bh=0vvrbq4sO8mI+45KfLyz6qhcBRue/QwX9tsHP/CDc7o=;
        h=From:To:CC:Subject:Date;
        b=JR3BZbImwQ5P/aIZK4o7eVKa/2secReGTOj/RZR4AakVNcnXSY4oP4wU6Vdngd8UT
         EuGy7rzzQ2AOPj+dcYb/Ars00Ch4SQXRST3xGJr9uZDJguJIVzo6dGECi3VRfvpv8L
         nfgYZUu+skpWWWhEjDkM9+gIwq0nb9zUyctiw35Y=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x688medG122916
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Jul 2019 03:48:40 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 8 Jul
 2019 03:48:40 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 8 Jul 2019 03:48:40 -0500
Received: from a0393675ula.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x688mc7P061716;
        Mon, 8 Jul 2019 03:48:39 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <t-kristo@ti.com>, <j-keerthy@ti.com>
Subject: [PATCH] gpio: davinci: silence error prints in case of EPROBE_DEFER
Date:   Mon, 8 Jul 2019 14:19:04 +0530
Message-ID: <20190708084904.18607-1-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Silence error prints in case of EPROBE_DEFER. This avoids
multiple/duplicate defer prints during boot.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/gpio/gpio-davinci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index fc494a84a29d..e0b025689625 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -238,8 +238,9 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 	for (i = 0; i < nirq; i++) {
 		chips->irqs[i] = platform_get_irq(pdev, i);
 		if (chips->irqs[i] < 0) {
-			dev_info(dev, "IRQ not populated, err = %d\n",
-				 chips->irqs[i]);
+			if (chips->irqs[i] != -EPROBE_DEFER)
+				dev_info(dev, "IRQ not populated, err = %d\n",
+					 chips->irqs[i]);
 			return chips->irqs[i];
 		}
 	}
-- 
2.17.1

