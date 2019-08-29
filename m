Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8FBC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 04:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AFE12173E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 04:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E8Il4awv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfH2Ewt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 00:52:49 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38087 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfH2Ewr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 00:52:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id o70so1214488pfg.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 21:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GANqF4H1c9ctJZ93xy/AUHApZEM00s/jYLQw6n/4UXM=;
        b=E8Il4awvKrc4JNdKEdEKQ5KR7arPWnH6d5OGIRjXAoOZw2t1vKXjcuR64RT/n9LSis
         k7NHI1RR6uliGdlKYdourRu3GpPK1LOQhRTyYO8KvHPjx3CekCpevwFNyeEYFmq++6Hy
         pSy9iOm1V3Ui7LzZp5XwML27WdpcEL4nphvBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GANqF4H1c9ctJZ93xy/AUHApZEM00s/jYLQw6n/4UXM=;
        b=pyDhOYRcScIlZj3snHQGunYyt/cHhRSGeHCe1pvpUYk1ouKhzh775gl13L6tGy3yRP
         LTZyGA6VmPCO8W6tA2eTvg7X2xUarmZXLAq5beanSZfJeJK6LqMg3aaj7odd1FIP7d4d
         dnEfzB3/mP1y3gdqXfaxVBb+ve0oM82kk3gBuup8FAvB9QRSXWxtW0xaMo0WRi3D5hiI
         aD/7jLbEEcEelgruA10eQ58a3uVU7Vv6pxkBJwrtsnS6mnNUIP2ig02uf9a/xm5rAQI6
         6ft5NdFBdQZ9b5iOYmJbhLJlXGV8pMMzt+W0GUb6+TKgmLdyqXWSgl7SWABlzcgqetOJ
         bfvQ==
X-Gm-Message-State: APjAAAWCW+/RWUitkOrvXAfyXiS3bp5xjBGnPQiaV1GV4E6YTX8VAB5C
        P4DX3nU7Ux4dCnR/lGzX59+lMg==
X-Google-Smtp-Source: APXvYqyW8b/Ox0XdoME0liJ9cCnqa8HAZOZwlGMSTWggx7M6r7b503/4XWOBBnCwx8KFAvKsNhm5LQ==
X-Received: by 2002:aa7:8a04:: with SMTP id m4mr8851035pfa.65.1567054366484;
        Wed, 28 Aug 2019 21:52:46 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id j1sm1131440pfh.174.2019.08.28.21.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Aug 2019 21:52:45 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH 2/2] gpio: iproc-gpio: Handle interrupts for multiple instances
Date:   Thu, 29 Aug 2019 10:22:28 +0530
Message-Id: <1567054348-19685-3-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567054348-19685-1-git-send-email-srinath.mannam@broadcom.com>
References: <1567054348-19685-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

When multiple instance of iproc-gpio chips are present, a fix up
message[1] is printed during the probe of second and later instances.

This issue is because driver sharing same irq_chip data structure
among multiple instances of driver.

Fix this by allocating irq_chip data structure per instance of
iproc-gpio.

[1] fix up message addressed by this patch
[  7.862208] gpio gpiochip2: (689d0000.gpio): detected irqchip that
   is shared with multiple gpiochips: please fix the driver.

Fixes: 616043d58a89 ("pinctrl: Rename gpio driver from cygnus to iproc")
Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
index 20b9864..8729f47 100644
--- a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
+++ b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
@@ -114,6 +114,7 @@ struct iproc_gpio {
 
 	raw_spinlock_t lock;
 
+	struct irq_chip irqchip;
 	struct gpio_chip gc;
 	unsigned num_banks;
 
@@ -302,14 +303,6 @@ static int iproc_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	return 0;
 }
 
-static struct irq_chip iproc_gpio_irq_chip = {
-	.name = "bcm-iproc-gpio",
-	.irq_ack = iproc_gpio_irq_ack,
-	.irq_mask = iproc_gpio_irq_mask,
-	.irq_unmask = iproc_gpio_irq_unmask,
-	.irq_set_type = iproc_gpio_irq_set_type,
-};
-
 /*
  * Request the Iproc IOMUX pinmux controller to mux individual pins to GPIO
  */
@@ -875,14 +868,22 @@ static int iproc_gpio_probe(struct platform_device *pdev)
 	/* optional GPIO interrupt support */
 	irq = platform_get_irq(pdev, 0);
 	if (irq) {
-		ret = gpiochip_irqchip_add(gc, &iproc_gpio_irq_chip, 0,
+		chip->irqchip.name = "bcm-iproc-gpio";
+		chip->irqchip.irq_ack = iproc_gpio_irq_ack;
+		chip->irqchip.irq_mask = iproc_gpio_irq_mask;
+		chip->irqchip.irq_unmask = iproc_gpio_irq_unmask;
+		chip->irqchip.irq_set_type = iproc_gpio_irq_set_type;
+		chip->irqchip.irq_enable = iproc_gpio_irq_unmask;
+		chip->irqchip.irq_disable = iproc_gpio_irq_mask;
+
+		ret = gpiochip_irqchip_add(gc, &chip->irqchip, 0,
 					   handle_simple_irq, IRQ_TYPE_NONE);
 		if (ret) {
 			dev_err(dev, "no GPIO irqchip\n");
 			goto err_rm_gpiochip;
 		}
 
-		gpiochip_set_chained_irqchip(gc, &iproc_gpio_irq_chip, irq,
+		gpiochip_set_chained_irqchip(gc, &chip->irqchip, irq,
 					     iproc_gpio_irq_handler);
 	}
 
-- 
2.7.4

