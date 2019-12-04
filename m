Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7D6C2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABD32081B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vVJG7FXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfLDQMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:12:49 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37582 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728618AbfLDQMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 11:12:42 -0500
Received: by mail-wm1-f66.google.com with SMTP id f129so342325wmf.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 08:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=uNltmXqrTHCnNf+qBYAGd5VIRrUeGqmibGRaqa9yu1Q=;
        b=vVJG7FXFHlTEExX4Hsqsesxz4BcR7uE4KGZOnfgsx+3n4+/1kENEs5eO1w8pO8spjs
         lj6/5OWVTWddVehZBTAVSONnQb1q3ia2F95diaguJ4YDwXL/zF5VGSYttpVWIqLAX9J2
         CqGz/ziX+vHOc4IGwAH5yR0QoZZbOUML64Z/VbmvKmIqzLZsWuslfm8LhvKrVfwoFx21
         Vgqb1DffRv/n/1QEX+SdwLAAPrh40LjSXj3GlgunQemerCnGJsgMhacS1cSMaY9H4iMR
         jK84L0Y3WjgRJcVF6c6YEciDjOL5hl80MnV0nM9KPDjqfCjeUjLWK7lZVRNngpU8LpGU
         yB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uNltmXqrTHCnNf+qBYAGd5VIRrUeGqmibGRaqa9yu1Q=;
        b=t24Qh6gOa8YgbkyfM3cqiwdw4Wm9XoS5vktncL0BspKam8TuGj55BYpFty7XipMVW9
         ZT7orBE8YqiURWEg6BKnho0ExoN8klLp2Ljinpa8Ljv9/MlJhYtvHkDXp/4kM+ojZGKB
         yoyq0hPI3J8zc0ByXxfLwhBXSJFFpAu2K3YuT+00tSnzbGxiYrvxmAu2xPmOQZy5+row
         WQvpTh+UE21Uk4SwYxmvEvFyGuQyqlf67HBe0ZiIdQ5sf9bEnnzGqQ4MMviGQB72UfpI
         GSb22rww2TXUIxoZD/uwHfPggaUY05DiHzuUTN7aEblfZKPX94a9bLY42rnloFbqPCGN
         9TIw==
X-Gm-Message-State: APjAAAViGTZ+eDQbYkJx+vFoccqIjh+L7VGB/wqO51p8y2fIeuh6pl9E
        prpZ3f6rBm2hW2CO23Nqh7KUAg==
X-Google-Smtp-Source: APXvYqxrriJxLsMfieNeOg4mz1DuduSGtrjOq7RZ4bPDbDfGq+BAPK1gy4x1qgM2SsGWth1VIbi0gg==
X-Received: by 2002:a1c:7203:: with SMTP id n3mr229261wmc.119.1575475960961;
        Wed, 04 Dec 2019 08:12:40 -0800 (PST)
Received: from glaroque-ThinkPad-T480.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l3sm8747238wrt.29.2019.12.04.08.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 08:12:40 -0800 (PST)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, khilman@baylibre.com
Subject: [PATCH v2] bluetooth: hci_bcm: enable IRQ capability from node
Date:   Wed,  4 Dec 2019 17:12:39 +0100
Message-Id: <20191204161239.16653-1-glaroque@baylibre.com>
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
sorry for noise,

v2 is for rebasing on master branch

guillaume

 drivers/bluetooth/hci_bcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index f8f5c593a05c..9f52d57c56de 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1409,6 +1409,7 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
 {
 	struct bcm_device *bcmdev;
 	const struct bcm_device_data *data;
+	struct platform_device *pdev;
 	int err;
 
 	bcmdev = devm_kzalloc(&serdev->dev, sizeof(*bcmdev), GFP_KERNEL);
@@ -1421,6 +1422,8 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
 #endif
 	bcmdev->serdev_hu.serdev = serdev;
 	serdev_device_set_drvdata(serdev, bcmdev);
+	pdev = to_platform_device(bcmdev->dev);
+	bcmdev->irq = platform_get_irq(pdev, 0);
 
 	/* Initialize routing field to an unused value */
 	bcmdev->pcm_int_params[0] = 0xff;
-- 
2.17.1

