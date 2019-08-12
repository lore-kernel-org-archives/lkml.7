Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CFAC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 22:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388D02067D
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 22:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="geQsoQ49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfHLWga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 18:36:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36397 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbfHLWg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 18:36:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so50192327pgm.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 15:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G1GyJeHxK3pLSUGiO0YqwSLuWrA1RPqBG46rl6iGQ1s=;
        b=geQsoQ49HygUno2jknhm/5tkiWZxIR99UnMgMqLmz+2kVJ+u+dULTQe2yvZxTIU9XE
         mYN8oyWmjYVz5J+35rcExedP4HNSIYZORXL933ibyeyrh9j4x94vN7/CD7tKIgylySye
         GV9xj5Og/JcK1Ve+R7xdxdJnaJCamxQnIY10w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G1GyJeHxK3pLSUGiO0YqwSLuWrA1RPqBG46rl6iGQ1s=;
        b=E1SBWUWi0AaTv/wEAFczqRDsWUKSjEX1S3CkG+foqT7Z6USr++3GSKSOhefqmWyhXu
         znu1tL/axIUM58+N7WfGLuIoz1f2xDdjL10CD+1qfznpeb2flkqrEAmNQPP8L5FhC70N
         HXjkRBfnCTzgw9UZdaEvfq7SvuXM3lXsT4pF8SqlqSZtohnzAPOCIOj2TzvbN+e5YUzc
         AOig33nUkfRJjZZG/JjXnD0Jzo9/8WEmxEqiJxIqAsEUDLzwLFgrop7+pIZszwU0lwv4
         0qL9Zss3oc4Mua0onPbCCObJuw1od9p/EvnYum0awoZoanZoUOU+ozDBGdInDYJVcCTJ
         UT8g==
X-Gm-Message-State: APjAAAUv9FxB1UsCwMCLUU+7eX+JQD32UXr+ct5i4KHE75Ym8LcTbOyP
        DQP60Um9XMIFN0U/1D4FheJuRLCHor1A5A==
X-Google-Smtp-Source: APXvYqySaV6YpLXAdPxlUhjGdH9PpCPLsa2Hp/dqfsVZSEg/dLbajPrX4bseW4PkHigNheTRFb11Zg==
X-Received: by 2002:a17:90a:8c90:: with SMTP id b16mr1357627pjo.133.1565649386242;
        Mon, 12 Aug 2019 15:36:26 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b6sm93911594pgq.26.2019.08.12.15.36.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 15:36:25 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [PATCH v4 2/6] tpm: tpm_tis_spi: Introduce a flow control callback
Date:   Mon, 12 Aug 2019 15:36:18 -0700
Message-Id: <20190812223622.73297-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
In-Reply-To: <20190812223622.73297-1-swboyd@chromium.org>
References: <20190812223622.73297-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cr50 firmware has a different flow control protocol than the one used by
this TPM PTP SPI driver. Introduce a flow control callback so we can
override the standard sequence with the custom one that Cr50 uses.

Cc: Andrey Pronin <apronin@chromium.org>
Cc: Duncan Laurie <dlaurie@chromium.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/char/tpm/tpm_tis_spi.c | 55 +++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
index 19513e622053..819602e85b34 100644
--- a/drivers/char/tpm/tpm_tis_spi.c
+++ b/drivers/char/tpm/tpm_tis_spi.c
@@ -42,6 +42,8 @@
 struct tpm_tis_spi_phy {
 	struct tpm_tis_data priv;
 	struct spi_device *spi_device;
+	int (*flow_control)(struct tpm_tis_spi_phy *phy,
+			    struct spi_transfer *xfer);
 	u8 *iobuf;
 };
 
@@ -50,12 +52,39 @@ static inline struct tpm_tis_spi_phy *to_tpm_tis_spi_phy(struct tpm_tis_data *da
 	return container_of(data, struct tpm_tis_spi_phy, priv);
 }
 
+static int tpm_tis_spi_flow_control(struct tpm_tis_spi_phy *phy,
+				    struct spi_transfer *spi_xfer)
+{
+	struct spi_message m;
+	int ret, i;
+
+	if ((phy->iobuf[3] & 0x01) == 0) {
+		// handle SPI wait states
+		phy->iobuf[0] = 0;
+
+		for (i = 0; i < TPM_RETRY; i++) {
+			spi_xfer->len = 1;
+			spi_message_init(&m);
+			spi_message_add_tail(spi_xfer, &m);
+			ret = spi_sync_locked(phy->spi_device, &m);
+			if (ret < 0)
+				return ret;
+			if (phy->iobuf[0] & 0x01)
+				break;
+		}
+
+		if (i == TPM_RETRY)
+			return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
 static int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
 				u8 *in, const u8 *out)
 {
 	struct tpm_tis_spi_phy *phy = to_tpm_tis_spi_phy(data);
 	int ret = 0;
-	int i;
 	struct spi_message m;
 	struct spi_transfer spi_xfer;
 	u8 transfer_len;
@@ -82,26 +111,9 @@ static int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
 		if (ret < 0)
 			goto exit;
 
-		if ((phy->iobuf[3] & 0x01) == 0) {
-			// handle SPI wait states
-			phy->iobuf[0] = 0;
-
-			for (i = 0; i < TPM_RETRY; i++) {
-				spi_xfer.len = 1;
-				spi_message_init(&m);
-				spi_message_add_tail(&spi_xfer, &m);
-				ret = spi_sync_locked(phy->spi_device, &m);
-				if (ret < 0)
-					goto exit;
-				if (phy->iobuf[0] & 0x01)
-					break;
-			}
-
-			if (i == TPM_RETRY) {
-				ret = -ETIMEDOUT;
-				goto exit;
-			}
-		}
+		ret = phy->flow_control(phy, &spi_xfer);
+		if (ret < 0)
+			goto exit;
 
 		spi_xfer.cs_change = 0;
 		spi_xfer.len = transfer_len;
@@ -207,6 +219,7 @@ static int tpm_tis_spi_probe(struct spi_device *dev)
 	phy->iobuf = devm_kmalloc(&dev->dev, MAX_SPI_FRAMESIZE, GFP_KERNEL);
 	if (!phy->iobuf)
 		return -ENOMEM;
+	phy->flow_control = tpm_tis_spi_flow_control;
 
 	/* If the SPI device has an IRQ then use that */
 	if (dev->irq > 0)
-- 
Sent by a computer through tubes

