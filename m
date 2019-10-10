Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F6CC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 03:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467CB20650
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 03:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKK7M6r9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732637AbfJJDLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 23:11:55 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41906 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfJJDLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 23:11:54 -0400
Received: by mail-pl1-f194.google.com with SMTP id t10so2050588plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 20:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=D/KNHz5BwPe8IYjqa/nxA57E4GIlBboQkvtK/MCahh0=;
        b=fKK7M6r9XMD030uB0tGC5Zm7u+1xds6ICaE53rNv9XP+LRFFf/mM1qekxlWcYwAFBC
         7/o6L3mHz+Q5AW21AL7tdt96KczaCJjPls/tB/twdyFiBeeJgyfjKMBMHE4I+XH3DVw7
         S35xJL7EuNrf9zYy1kJYghMW8R2COu2qQYq1EeI2DisV2nuiWTnxg7HpsZeJ/e89+5Cr
         TA+0/yPWcZ/ui57oygr00sIxDRFqZJs3xxKITsj+WqR424AQgTa6dbKCi6u4BNTWULgQ
         LMvLKVNRv7LuhCOEdTiB8iUgtGKVbDBE2/v+Hpw5Bj47UKc6fqGqmVhoJ4J7j0z2xfic
         vYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D/KNHz5BwPe8IYjqa/nxA57E4GIlBboQkvtK/MCahh0=;
        b=jIoLVmihM8BN1nnKYK4HztgMgIRxgsfUzKLRZxNqlpKtyWLCg9I+ANVR/nAUmkv9IK
         EMy19cSEGvww2namVg5tKTh/QXH3m75oT3oAisQaAvf7oHhhUOIz27vSds3Jol5PpQ9f
         7V+niAzVhgSkqWsvt3uzXejo5bTx/VjizILrRfeAgFKG/N941Rk0kOX2F0bQNrW/7ZCZ
         O57WExC5XLIWljRlVwonzbtc31z8iiNPUY4kKJBKGrNXszO0VUn9memKCCTTN+uwEOx3
         0o+7FMSz8X0nfkEuFAkdJiTH6+nq872VHipqb7YbjytShllh8wmQE+NEUr8E1SNRgIFO
         sudw==
X-Gm-Message-State: APjAAAXWTi/j08FaOZcMa+3rGKgv5upCSEyu+z0LYzo1e6rr/EMqx3EG
        4pHdHQwj8hTTBw7N6/8jUNk=
X-Google-Smtp-Source: APXvYqzCw7q+QR6Sb72KBCYSpYvYD5cC8rr/pEpNA+HHhXTr9aH++Si0CSkNaSI6dP4NRceJ+X6fNQ==
X-Received: by 2002:a17:902:848e:: with SMTP id c14mr6732262plo.217.1570677114247;
        Wed, 09 Oct 2019 20:11:54 -0700 (PDT)
Received: from panther.hsd1.or.comcast.net ([45.52.215.209])
        by smtp.gmail.com with ESMTPSA id b4sm2810934pju.16.2019.10.09.20.11.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Oct 2019 20:11:53 -0700 (PDT)
From:   Chandra Annamaneni <chandra627@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     gneukum1@gmail.com, chandra627@gmail.com, dan.carpenter@oracle.com,
        fabian.krueger@fau.de, simon@nikanor.nu,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KPC2000: kpc2000_spi.c: Fix style issues (alignment)
Date:   Wed,  9 Oct 2019 20:11:45 -0700
Message-Id: <1570677105-4151-1-git-send-email-chandra627@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolved: "CHECK: Alignment should match open parenthesis" from checkpatch.pl

Signed-off-by: Chandra Annamaneni <chandra627@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 0d510f0..ccf88b8 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -316,19 +316,19 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
 		if (transfer->speed_hz > KP_SPI_CLK ||
 		    (len && !(rx_buf || tx_buf))) {
 			dev_dbg(kpspi->dev, "  transfer: %d Hz, %d %s%s, %d bpw\n",
-					transfer->speed_hz,
-					len,
-					tx_buf ? "tx" : "",
-					rx_buf ? "rx" : "",
-					transfer->bits_per_word);
+				transfer->speed_hz,
+				len,
+				tx_buf ? "tx" : "",
+				rx_buf ? "rx" : "",
+				transfer->bits_per_word);
 			dev_dbg(kpspi->dev, "  transfer -EINVAL\n");
 			return -EINVAL;
 		}
 		if (transfer->speed_hz &&
 		    transfer->speed_hz < (KP_SPI_CLK >> 15)) {
 			dev_dbg(kpspi->dev, "speed_hz %d below minimum %d Hz\n",
-					transfer->speed_hz,
-					KP_SPI_CLK >> 15);
+				transfer->speed_hz,
+				KP_SPI_CLK >> 15);
 			dev_dbg(kpspi->dev, "  speed_hz -EINVAL\n");
 			return -EINVAL;
 		}
-- 
2.7.4

