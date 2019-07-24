Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47117C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0DD229FA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7Gz6c35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbfGXMWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 08:22:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34573 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbfGXMWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 08:22:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so14935116pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 05:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=owiTM8Q6umaAS/3ug5KbVl7PG47t5xBZGA8pOFJhaV8=;
        b=W7Gz6c35Guc8aOL1iTlo1fcB4geIOT8cdwOS3IeIVUszly5B24LnjbaMVbEMD/Wjnl
         d3mAWEWmWoGPt5am6+eQ0PtGRMCwcDkKQnrrQeXIqvAKJREKLZIbRKQIjkeET10LxO57
         ++e6wpTj1c/CdcFhCoK1rTJTbQr827Zch+ivKGYPPM6Ue1296ECm8py5hDU+JZGcEILl
         //sl9HHAEGv+gir23ovAEre5YbCoQcUgcQhUrgQjH3nqYjhmQFEim4oa6Xrth1QaIIEo
         qxe5GIfxJ7G2fbUW2XT/Nrr/QBZn8TehPyaicnJjYRmiBowe1C6TJybSVNX/iDxjHEzO
         JDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=owiTM8Q6umaAS/3ug5KbVl7PG47t5xBZGA8pOFJhaV8=;
        b=qdtB4LQP3syUtJ7A90iCjJvZjuSajKGP2K96p7CwbQ2j+eaSM8Z6eNC28qeXp3PKcO
         f5uqGLb/Nog3EGqUFU56s8k8TrQhRdY3F5W1PKyDAd4MDF5hXTon9W9PzXZqDfT0JazE
         /WgfDKxgRQ49Z9AQXYYOH1ryAFXrH9Zy75w66Ps1CaKB+V5mWDzQrB+482NKcHEJzPJI
         bJvHMvhEQLnw4IWmqh7wZT2PXZEmMPuw6aFEHsVKtwHecAAnhA6cvNBarUoUR8nhr1Sf
         DdkFYaRENeONDuIFt1tR2ZsRAAqfrtuloGAslqcuSWEiwcBI+SavHQRGacXBbiXf1CN9
         XWWA==
X-Gm-Message-State: APjAAAWge3oW+dQ2Kbc40IrbJSjKSL/15ge/5aC9lrgtVLBsukIabPVI
        m6SbgDlMlZmFh8qMuwsKL+SoMk43BFA=
X-Google-Smtp-Source: APXvYqzOLsweWIyggknBzc6U+JNs+bguj8AFZcoaddkRkEfu2H355gu/llYNnKyTU1R7TyZ4zDOBkg==
X-Received: by 2002:a65:6406:: with SMTP id a6mr44499499pgv.393.1563970973792;
        Wed, 24 Jul 2019 05:22:53 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id b16sm74206976pfo.54.2019.07.24.05.22.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 05:22:53 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] parport: parport_serial: Use dev_get_drvdata
Date:   Wed, 24 Jul 2019 20:22:49 +0800
Message-Id: <20190724122249.21693-1-hslester96@gmail.com>
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
 drivers/parport/parport_serial.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index 461fd8a24278..b11f5d238eda 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -660,8 +660,7 @@ static void parport_serial_pci_remove(struct pci_dev *dev)
 
 static int __maybe_unused parport_serial_pci_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct parport_serial_private *priv = pci_get_drvdata(pdev);
+	struct parport_serial_private *priv = dev_get_drvdata(dev);
 
 	if (priv->serial)
 		pciserial_suspend_ports(priv->serial);
@@ -672,8 +671,7 @@ static int __maybe_unused parport_serial_pci_suspend(struct device *dev)
 
 static int __maybe_unused parport_serial_pci_resume(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct parport_serial_private *priv = pci_get_drvdata(pdev);
+	struct parport_serial_private *priv = dev_get_drvdata(dev);
 
 	if (priv->serial)
 		pciserial_resume_ports(priv->serial);
-- 
2.20.1

