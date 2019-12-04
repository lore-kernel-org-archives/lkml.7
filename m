Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10693C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34BD2068E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cveiedzL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfLDHQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 02:16:55 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55133 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfLDHQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 02:16:54 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so5799592wmj.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 23:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=faPNT/f5uZo8iaeYVLQEwdlcOY2/BBdz04dTFvoUITs=;
        b=cveiedzLTF5mS2Zqe/QUDDb+gQEYISQzEcCxIXxHIgCwuxsCD7IguOlhvwF1mEGg2o
         yQZ+GKi3S7RZugEX2dkJs+rijyMXZKk0ktN2VTREOuTi+3slnANkRK+oG28LjgVp8dOU
         aRRNb6+jvjPH6c/s0rsEwy/2dNj0u5hr4PfC8SmRhLoDd+K3kv+3NDa+pL8ohSdCBFqT
         JOtBJGFlRL9fL3dQwWe/MH2MdP2fds1j9Ia8voFpqlD9rm8OZeuWIUGC74Ifxn1ihlYy
         ZnrUOB2wEuQgmQSX1hrYqSg4+FQ0wmsYZrefxHyXN5AgX1K1dJlmi0+qwBXLw01dMoo8
         n5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=faPNT/f5uZo8iaeYVLQEwdlcOY2/BBdz04dTFvoUITs=;
        b=B2uMuteRUQPLnzxaAlXi11951CCuNQa5Ts5Swh03glum+cp3AHBxo1BEZEkydEhZcC
         ph+wW4pteW9WmIihxoaCy78mCtgZARctdj7gyxbp3p8z3vZgDGaGWCPemqYtfkIv7LW7
         CJujtPqr+6dQ3Pl1AqIrJrlmDe703wPQSpF0J4t+H05tWPnz1ndUh/JKX2VQmEEeks56
         TnVQO2eiq5/0W3Yf5jZ6wO73LtKjiB5TfGeJ7KilAg1z5zUwgVk6RF9YVM1apd4n8uYZ
         fM5okNCotUf7PDAGwg67cBa1VC4n+w717PXLmxOGpORrvl1ZExXH8nlrcyHZiD91z/+j
         RcGA==
X-Gm-Message-State: APjAAAX1+EWZtm4MWmk9ofqiz8lRGKwTij1XtD1QfMGHv6kL/+cWVClY
        7qKjPvupK/e4I+5RsMJ0qcWNcg==
X-Google-Smtp-Source: APXvYqw1e9Sba16z73Xn9TIg9bIDlbIodXDWx2BbrTyW3EZXd6bcOtv3skaMKAl+1FJ8nPB6WxGrFw==
X-Received: by 2002:a1c:a70e:: with SMTP id q14mr13797771wme.142.1575443812562;
        Tue, 03 Dec 2019 23:16:52 -0800 (PST)
Received: from glaroque-ThinkPad-T480.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m7sm2319337wrr.40.2019.12.03.23.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 23:16:52 -0800 (PST)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, khilman@baylibre.com
Subject: [PATCH] bluetooth: hci_bcm: enable IRQ capability from node
Date:   Wed,  4 Dec 2019 08:16:51 +0100
Message-Id: <20191204071651.14977-1-glaroque@baylibre.com>
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

