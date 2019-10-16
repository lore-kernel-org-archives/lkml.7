Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DA4C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C764B2082C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixvpOstz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391341AbfJPHtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:49:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40701 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391302AbfJPHtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:49:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id e13so5575626pga.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j+5wZZ+PjzxLbMdDOyLUeg2K+18/C67QOv7Ke0t4fjo=;
        b=ixvpOstzzh3n7mUe8J+gXJcDAZhkvWoSGd1eB3X7cV83Sq/sGKwD0BvSmgzCO4pEH1
         8xHcTnl2orrYAh9GoXEg8kXwC0swCt3zu44EVqw7VYIPzTkp1PL7whWl0RsFJ5nkNmoE
         8RjCjeBqOOd+/WoEGZqwzfZwkeI1arrPWG9Br/zmKwkk/Di/y/nOX+IQlnkcqRkOLnnz
         1faPGUdICdBjTBUi1/pgI68Mr7a7wPi3ZqzL9RLNXKi75JAPEpF3MmJ3929fFCoU9TQG
         j/EN6MeO7S19BncTqnru8P0J+ByqNpeQGowtyu0RYq/zAv72VsNiybnamdSXTgmZOEY0
         wzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j+5wZZ+PjzxLbMdDOyLUeg2K+18/C67QOv7Ke0t4fjo=;
        b=p0Vo9ifZQu434kvdzIE8e6L4tEhqX37n2IDPS6DsG53rEjpC+6dvNylPa3iTKsAqwX
         YeSGQQ8VvmAqDZEsZuECMymrgJ2XjROoM2VPXUsCBImCDvEEJEb97qnsz1IjoCxjL/AF
         N3glLM0mXthuxJbWrnPR4d0FCGk+Ki+F0AejkNH4XzaE70OuC8prNWp/w1lS1g3gE1aG
         qkM9tLOMFewFUwqJOtq1A4EBqjtdj+DqF0k6+OARyLU0N7AUcatmdtzSbR8IgUNESfaa
         MwwEzTs0sp9cKY60Etoj7RwC608f7c04rWI/mZ1FkmVFn4beuKs5RLG7F2kmuG1HSnTK
         lDPQ==
X-Gm-Message-State: APjAAAXyd7srCsnTw9wAxFl19kYD8IDW0Ff3ZcUzuc2w6OlF71HVxfo/
        y36V5ImXLI251K0omZbU60Y=
X-Google-Smtp-Source: APXvYqxeiL7hsuQgKd5RdWHbcJnrSFSos2Vz9sXRLn+I2/lmCgWGAzK2cnT9hVWh1kAMGR8JeKFcrg==
X-Received: by 2002:a63:78f:: with SMTP id 137mr24973067pgh.110.1571212190178;
        Wed, 16 Oct 2019 00:49:50 -0700 (PDT)
Received: from localhost.localdomain ([45.52.215.209])
        by smtp.gmail.com with ESMTPSA id d1sm25185522pfc.98.2019.10.16.00.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 00:49:49 -0700 (PDT)
From:   Chandra Annamaneni <chandra627@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     gneukum1@gmail.com, dan.carpenter@oracle.com,
        michael.scheiderer@fau.de, fabian.krueger@fau.de,
        chandra627@gmail.com, simon@nikanor.nu, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] staging: KPC2000: kpc2000_spi.c: Fix style issues (alignment)
Date:   Wed, 16 Oct 2019 00:49:26 -0700
Message-Id: <20191016074927.20056-3-chandra627@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191016074927.20056-1-chandra627@gmail.com>
References: <20191016074927.20056-1-chandra627@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolved: "CHECK: Alignment should match open parenthesis" from checkpatch

Signed-off-by: Chandra Annamaneni <chandra627@gmail.com>
---
Previous versions of these patches were not split into different 
patches, did not have different patch numbers and did not have the
keyword staging.
 drivers/staging/kpc2000/kpc2000_spi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 929136cdc3e1..24de8d63f504 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -313,19 +313,19 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
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
2.20.1

