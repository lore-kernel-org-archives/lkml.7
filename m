Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E20C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4439120640
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="peIsFVor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfLDHOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 02:14:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39442 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfLDHOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 02:14:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id y11so7153596wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 23:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=faPNT/f5uZo8iaeYVLQEwdlcOY2/BBdz04dTFvoUITs=;
        b=peIsFVorQnWepGPOfBNBZe45ZXcl5mpOqPoMHX8IOEUf1fn4okHL/y7Pa74ipFV7GD
         cTmSQwqp9fRwL/vTYVqMUTw5C1MQHDslN+//Vi8OSIBreTBfwJ8ljsM4prVjG2rFNCah
         LeicfS6tlqh06809CAta+BGy33TV1JGJ5O1eB0wBhQI8tn1Bj57BoUE9DS3ZBSVKlvgZ
         6xh+rDqxqtkL8Tb3RDA+XPbA9GoG3Z3Hon6p1BuYcl7QHh0RaRk9nH2IqDfTqhbozBdK
         mB9gmxOd4/3OZMQKb2RiP6BxRSdRFIMRBhZI5yosPQeZbErEhSUr9w7t/Sj/QrUIIvy1
         tpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=faPNT/f5uZo8iaeYVLQEwdlcOY2/BBdz04dTFvoUITs=;
        b=Q230KsiTegPsJqUEQmTwRhVgOYT1HnaWGpvKvNIDZ3mKt88oMtze4qWHfBHJj/ftdg
         sHM6TJqB2U0KQnn5KKvAvVtyu2h+OvmV8GmbEoNZFyv40YNOIp6rqDgSKY3GAYmZRYWZ
         dNoPpP9ugVsNFcMcGKN+zArXHLzKy1286Lt/33kBDDZWl9/W1s7FUdkgPko+rXmHxO1k
         T2fsm4FVWo3+iPzZvEyiyOUSLSW3ZYvBPS3cPZmKhxRueO0H7JY6zcbIISREfzQDF62W
         hZIu8NZWdPeVijnRboBW2uq+KZ+fDHW7483eybo3Mq9VglCZNnpo0cnuBngIFOObuw0W
         rPTw==
X-Gm-Message-State: APjAAAVIZ1WHQYgbws7HcxeiZxwZ/W+ICPf7WVxGdCccFb/jzi04vEJK
        8jLmBjtYdFeOocVGAvNtgZ5Axg==
X-Google-Smtp-Source: APXvYqzD+bj2dB60P1mwGmgJ0xT8Xw/FI3kBxaFo3ktA55T4hDKZCn/mogaPOBLxwLnhnhi+FcGYpw==
X-Received: by 2002:a5d:5403:: with SMTP id g3mr2210292wrv.302.1575443652648;
        Tue, 03 Dec 2019 23:14:12 -0800 (PST)
Received: from glaroque-ThinkPad-T480.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v15sm5417592wmh.24.2019.12.03.23.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 23:14:12 -0800 (PST)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     marcel@holtmann.org, ohan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, khilman@baylibre.com
Subject: [PATCH] bluetooth: hci_bcm: enable IRQ capability from node
Date:   Wed,  4 Dec 2019 08:14:11 +0100
Message-Id: <20191204071411.13624-1-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually IRQ can be found from GPIO but all platorms don't support
gpiod_to_irq, it's the case on amlogic chip.
so to have possibility to use interrupt mode we need to add interrupts
field in node and support it in driver.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 drivers/bluetooth/hci_bcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 7646636f2d18..9b024e1e36e2 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1372,6 +1372,7 @@ static struct platform_driver bcm_driver = {
 static int bcm_serdev_probe(struct serdev_device *serdev)
 {
 	struct bcm_device *bcmdev;
+	struct platform_device *pdev;
 	int err;
 
 	bcmdev = devm_kzalloc(&serdev->dev, sizeof(*bcmdev), GFP_KERNEL);
@@ -1384,6 +1385,8 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
 #endif
 	bcmdev->serdev_hu.serdev = serdev;
 	serdev_device_set_drvdata(serdev, bcmdev);
+	pdev = to_platform_device(bcmdev->dev);
+	bcmdev->irq = platform_get_irq(pdev, 0);
 
 	if (has_acpi_companion(&serdev->dev))
 		err = bcm_acpi_probe(bcmdev);
-- 
2.17.1

