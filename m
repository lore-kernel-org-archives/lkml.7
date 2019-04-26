Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807EDC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D1B20693
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ig45WgKK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfDZTZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:25:14 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42291 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfDZTZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 15:25:13 -0400
Received: by mail-pf1-f193.google.com with SMTP id w25so2172889pfi.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 12:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=an5rEpkFGQ3NHmznnBNRuXXxR3Z5SHbs8DWRZW5+fO8=;
        b=ig45WgKKQqZebDRRWwG1Lj4m5QQ9D9aAPNnhnX1eTLJiAqznX3JOJ2g5ahFB5uVQY5
         oyIERfk0X612tHthQqJypWNwnj9TehLdg1ikZ3jVD5cD+1COpgGuKm1HH6/7u5AGWf4M
         rX2BEXJnxNnSXjvlZ1XIUlHWb6nLcOIzj+qG8Mh9UmsxqIZspbBW7m4l6c7vcwJlZ5yL
         Bp98T7qET+H0q5pFEbVkUTJTxDBvu5e6CWEt5B1dmEwWQELjrLyZlwtsINfBnKF/hDZP
         nMJ7mYiVS1SKi5+SpVOfqLBaU6jo3WpxLSZGl0ZN5PNYGJ478PSfvCsjuYyGSSN2nT9m
         e6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=an5rEpkFGQ3NHmznnBNRuXXxR3Z5SHbs8DWRZW5+fO8=;
        b=q/c4Z0PlPMxkbagNynx7eQqM3C8V4RizUOK8Co1mI+0064sKEc7Stcs0v/xSLyM2Wr
         vNEzYyDZuMrixUyKKZAlJMvurSe0eYV6JmeS+sWpK6EQkTPZx3MVUXlN5pBiUjuxRU6N
         emaJ1bs+bg/7siPstpdFGphca7uqhyeh3+37PNUo5TKGGcey0pHBTrNu/OYMMJcWhuW3
         Nhpb5iyWULn4zHt7AQZ6FcNy3iyvQo56VMVmu+Sy2wgbLe2rWNqrKrlKZ5eTm3Lh/RNR
         Nsevu6QO9dQMBgp0DSw9UD/zVj/U21QVKk+IaM8lHfZFwlUIbLGMkXriWchFbN7F8/r8
         CCwA==
X-Gm-Message-State: APjAAAULZn9yTNUd9CZBjLRxgMwmy/f1lENKPc70arHdTZUwHKvcp8Mt
        MVa5C7aCk8eo/UObVqS3gJo=
X-Google-Smtp-Source: APXvYqzLiLvTpQeqBlBn2EZNk7kx1q3pLixQSE9zvkCA8sZ0NktBztwkexSNcxu8fIPn9TCgWhTcIA==
X-Received: by 2002:a63:1852:: with SMTP id 18mr9164960pgy.283.1556306713105;
        Fri, 26 Apr 2019 12:25:13 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id w38sm1129639pgk.90.2019.04.26.12.25.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 12:25:12 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH] mtd: rawnand: brcmnand: fix bch ecc layout for large page nand
Date:   Fri, 26 Apr 2019 15:22:26 -0400
Message-Id: <1556306615-37990-1-git-send-email-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The oobregion->offset for large page nand parts was wrong, change
fixes this error in calculation.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 482c6f0..3eefea7 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -939,7 +939,7 @@ static int brcmnand_bch_ooblayout_ecc(struct mtd_info *mtd, int section,
 	if (section >= sectors)
 		return -ERANGE;
 
-	oobregion->offset = (section * (sas + 1)) - chip->ecc.bytes;
+	oobregion->offset = ((section + 1) * sas) - chip->ecc.bytes;
 	oobregion->length = chip->ecc.bytes;
 
 	return 0;
-- 
1.9.0.138.g2de3478

