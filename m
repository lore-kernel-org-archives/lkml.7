Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E639C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62532216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kUS/jiHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387867AbfG3SUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:20:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43489 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728544AbfG3SQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id i189so30264569pfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JNHF3NMJsmSwb/euYjm40Rqa04ACMFTRzvvInLLjC3g=;
        b=kUS/jiHMSjt9AG/oGT4ThWGiScXKduzhoF+7Oy+yhhxLRZkkDpXOW1k1SaJbXggUdj
         B56fXwLAQpaamyn5usHnpVTU/OPZ5FqVA3Gm5RihhbvTfeaoNeEAbyUkbynaQQoQR4Z2
         x8MJGSXwpzfjNYahGOSql+tTnE5tbcaTgcKTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JNHF3NMJsmSwb/euYjm40Rqa04ACMFTRzvvInLLjC3g=;
        b=iXcu04Ji17pgHNbhUj7vd/gP7lzaWUNeeCDBaTqjJQS4kPBox6PdccBFMVI903LkIa
         Ih79SuOeF62dG8Od2A8QF2A8T77S3bJYDONR5STCjaomkg0HBRNE2z+WsHf6Mfdq9Ae3
         8qP2xNriYNYemgniAt+6a02zyjHkMNlS1APLntF41FrcPVWQVyUv/3c2I455Lmiq5RO1
         9lo15IdwWoTUn/eUsX2aMqYt2yWJuFBN9Tf7PSvDCTxssugL6b2iRD7RlU4h2fpqFcq2
         LRiCushBjhSHHwDPBTSbD1K7s/87bcBI0ESX1elzVrZGeuUJYtu+T1ndEyOWL3oxwcP2
         T0yQ==
X-Gm-Message-State: APjAAAVzHKPb8ALyhkqMrgWPdyi+NpRfcPe5y8aCAvwPv1/4x77LA9Ie
        eRypFD0wnmlvreqFI0GNt1dIwuKH1Gg=
X-Google-Smtp-Source: APXvYqxoBb+shb8RH3rTuknOP3Xu9sizmf1NwP33yrUDvTwKTXC68040+BKhc5L489T/GJCTTT1Ucw==
X-Received: by 2002:a63:c03:: with SMTP id b3mr46549358pgl.23.1564510559896;
        Tue, 30 Jul 2019 11:15:59 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.15.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:15:59 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Subject: [PATCH v6 01/57] ata: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:01 -0700
Message-Id: <20190730181557.90391-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: <linux-ide@vger.kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/ata/libahci_platform.c | 7 ++-----
 drivers/ata/pata_rb532_cf.c    | 4 +---
 drivers/ata/sata_highbank.c    | 4 +---
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 72312ad2e142..433d54d269e1 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -583,11 +583,8 @@ int ahci_platform_init_host(struct platform_device *pdev,
 	int i, irq, n_ports, rc;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		if (irq != -EPROBE_DEFER)
-			dev_err(dev, "no irq\n");
-		return irq;
-	}
+	if (irq <= 0)
+		return irq ? : -ENXIO;
 
 	hpriv->irq = irq;
 
diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index 7c37f2ff09e4..4eea43a86e57 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -115,10 +115,8 @@ static int rb532_pata_driver_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(&pdev->dev, "no IRQ resource found\n");
+	if (irq <= 0)
 		return -ENOENT;
-	}
 
 	gpiod = devm_gpiod_get(&pdev->dev, NULL, GPIOD_IN);
 	if (IS_ERR(gpiod)) {
diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
index ad3893c62572..efd1925a97b9 100644
--- a/drivers/ata/sata_highbank.c
+++ b/drivers/ata/sata_highbank.c
@@ -469,10 +469,8 @@ static int ahci_highbank_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(dev, "no irq\n");
+	if (irq <= 0)
 		return -EINVAL;
-	}
 
 	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
 	if (!hpriv) {
-- 
Sent by a computer through tubes

