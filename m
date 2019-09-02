Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31466C3A5A7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002852168B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="miDU0KYr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbfIBNAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 09:00:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36139 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729672AbfIBNAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:00:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id y19so13950323wrd.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 06:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=AwtIASwzD2wQBnlL9oHyI7SdRwOZSjZruhQTBPnShKk=;
        b=miDU0KYrIicIRBE0zL4/Itl/AJs4+B1X28hNpOLsd4u82nYRjtqm5YsetSNVou587O
         l5czxqg5TxbhTwY/rJGt/3KjpM1CL8XRNByXdDn2EFouyUgw1gmHjO1Iimtg8ScndpvG
         S30aTizsZUf9047APAU/CoXzU2jSs2VINLCFj94sFgTAfYopHzz4ET6kO6nemshLc7Kh
         JGzuJFWbU9rZVojwTvg9ycy4e8W0BzPL/HHPQTw6g5beWRVk6hixc0NjM5d84FVwMheD
         PxeLQndvg7+r2ZV+QYIQ0K/rzf3LdGRg0RAxlDkXB9/JITJab4lXygSZg0vdA/JRC4al
         V8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=AwtIASwzD2wQBnlL9oHyI7SdRwOZSjZruhQTBPnShKk=;
        b=i2kKOlwq0CUf2Jr7Nl2Pjn9Bm38cJWQKMmojj8q5g9CaT8wsiZtxr+pLKM5IFIwpU6
         FTKqcNNEDovMWvcE24WSOiYLvcJ18sc9TGYxTX63Y1PJggmBvXkfb5aF2gq2WmaTA53T
         lCFgEwGj13al7dg3CwaFVwCMCLPpaV2HifYs6wUWrvP3zHrdwuiQCB43Fri6lDHE5LC1
         4V+I+mkOSAFd3q/E4pLG5JgybQWuQpdsLlqwsOTfYlDaCu2ucQfuLO54rMW5Spw+QIEJ
         78u9Hk6PRO0rhiP/uSwXTQWpgN1wKwJ9EaXtkjtxcnnfub2FabW4wTM3PV+NoRo0BzZ6
         YR8w==
X-Gm-Message-State: APjAAAUN8BmdLoN4ypQ/c9vf0qemCzwOyHTOAzNcU6sXl2Lfp6fuiu7P
        kCgB2BFAXI4qFX6KhfkdiXplEcetWPrAuA==
X-Google-Smtp-Source: APXvYqyYBW8VX3THfeDjkn30HbB7ZOHfQ8B3R0dRRt05rjR3UpR45PXXZOUTymd4u25da9bAS1a1pQ==
X-Received: by 2002:adf:ecc7:: with SMTP id s7mr37562687wro.215.1567429245648;
        Mon, 02 Sep 2019 06:00:45 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id m3sm12163829wmc.44.2019.09.02.06.00.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 06:00:45 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH] power: reset: gpio-restart: Fix typo when gpio reset is not found
Date:   Mon,  2 Sep 2019 15:00:40 +0200
Message-Id: <94b3d1f3ebeb6000c32a7bed6f8b9411bae9cf19.1567429238.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial patch which just corrects error message.

Fixes: 371bb20d6927 ("power: Add simple gpio-restart driver")
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/power/reset/gpio-restart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/gpio-restart.c b/drivers/power/reset/gpio-restart.c
index 2880cd5ae0d2..308ca9d9d276 100644
--- a/drivers/power/reset/gpio-restart.c
+++ b/drivers/power/reset/gpio-restart.c
@@ -65,7 +65,7 @@ static int gpio_restart_probe(struct platform_device *pdev)
 	gpio_restart->reset_gpio = devm_gpiod_get(&pdev->dev, NULL,
 			open_source ? GPIOD_IN : GPIOD_OUT_LOW);
 	if (IS_ERR(gpio_restart->reset_gpio)) {
-		dev_err(&pdev->dev, "Could net get reset GPIO\n");
+		dev_err(&pdev->dev, "Could not get reset GPIO\n");
 		return PTR_ERR(gpio_restart->reset_gpio);
 	}
 
-- 
2.17.1

