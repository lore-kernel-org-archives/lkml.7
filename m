Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1D5C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7ED2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6Enh0j7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbfGWIHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 04:07:23 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45019 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbfGWIHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 04:07:23 -0400
Received: by mail-pl1-f193.google.com with SMTP id t14so20272902plr.11;
        Tue, 23 Jul 2019 01:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SmcqePyLoJfafXJo9wRS1ucEWseSMTg+J4NGkrBeJ2Q=;
        b=D6Enh0j7M4s2hLVUEvLzBLpx/VNPQG8njwiAL9gv0mP/6QIdVjkkOLVkYs/4u2GHDA
         Wst6nQeGEUZv1KorUW/tlAYTmEmd742o44p8TqsbH5g81NfeF3viBZqhkJfGRchxDtcI
         oqWT2iJZlCXzfwlZprDJIxW6QAwsv5xAtfCVFnC1RV5fDCVSknHKTzFA0gqEI9bsP9ko
         Z5oH5bpYZVTEGMVzYW5lLZam0i7EVNSf2cTV3fYGb3zNIpkldP/CAvLaCsWOINEn8Gwx
         SBA7cwOCTxc/83F+ym4tfbQmC6lKDxqUXGTasVrldu+HzrHwt4SDWTkTz5rGFriep2ok
         /jgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SmcqePyLoJfafXJo9wRS1ucEWseSMTg+J4NGkrBeJ2Q=;
        b=OOdpGnZoXDEI3ZVIsPRyWVznu82whpJfBbmh2DE6gxZh0WkNTtQ79IIplNqQIpwa2l
         +SSLoknT22ZjdhTJ4jaAWufhLE86mrUy7JWxHz1Cw8f8xEUvMTsucCRpEmLKFQj4Wufh
         cZuhWi/XRdasuSK4LVRVFFu4b8z3o5zoFwJLZMzm4zk7ppDBFq1Gx+nnL0K7A7R4cFew
         f0WlV0JD1XrLCxtaGLICntd8sIEwYbFVy+A2ka/PuhtC/xxZDugXaaeRjKIYg2XuE59T
         O5xznw1IuEIx8fNhTBao12P/aVN6ooCeropNKi9zGrehfiOeWIz4iz9gRNIKX3Hqh/3H
         60Uw==
X-Gm-Message-State: APjAAAVKORc6bzIDVRrqb5XD4VcYY9EWJ/4PHYZKL9l37xbGz8TE24Jd
        Yzl9Wt7UygvM8iuv0JiR9oQ=
X-Google-Smtp-Source: APXvYqwfKMeKOiyYZCg3FMaWQWMfftf6NffcTc0jG5L82eCYYT4wrDNxfsY6ien9qxQ2e2FaVrgXwQ==
X-Received: by 2002:a17:902:4283:: with SMTP id h3mr77244197pld.15.1563869242286;
        Tue, 23 Jul 2019 01:07:22 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id z24sm71542800pfr.51.2019.07.23.01.07.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 01:07:21 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] drivers: ata: Use dev_get_drvdata where possible
Date:   Tue, 23 Jul 2019 16:06:40 +0800
Message-Id: <20190723080639.18266-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/ata/ahci.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index f7652baa6337..58a981cdc83f 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -836,8 +836,7 @@ static void ahci_pci_disable_interrupts(struct ata_host *host)
 
 static int ahci_pci_device_runtime_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct ata_host *host = pci_get_drvdata(pdev);
+	struct ata_host *host = dev_get_drvdata(dev);
 
 	ahci_pci_disable_interrupts(host);
 	return 0;
@@ -845,8 +844,7 @@ static int ahci_pci_device_runtime_suspend(struct device *dev)
 
 static int ahci_pci_device_runtime_resume(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct ata_host *host = pci_get_drvdata(pdev);
+	struct ata_host *host = dev_get_drvdata(dev);
 	int rc;
 
 	rc = ahci_pci_reset_controller(host);
@@ -859,12 +857,11 @@ static int ahci_pci_device_runtime_resume(struct device *dev)
 #ifdef CONFIG_PM_SLEEP
 static int ahci_pci_device_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct ata_host *host = pci_get_drvdata(pdev);
+	struct ata_host *host = dev_get_drvdata(dev);
 	struct ahci_host_priv *hpriv = host->private_data;
 
 	if (hpriv->flags & AHCI_HFLAG_NO_SUSPEND) {
-		dev_err(&pdev->dev,
+		dev_err(dev,
 			"BIOS update required for suspend/resume\n");
 		return -EIO;
 	}
-- 
2.20.1

