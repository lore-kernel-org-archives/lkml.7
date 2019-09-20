Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76D1C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 18:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976382080F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 18:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J2EFF13K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406632AbfITSct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 14:32:49 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42040 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406592AbfITScp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 14:32:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id q12so5052760pff.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 11:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rBbuZ1/hGmJSVpkE9Mk+PjVfNnVUpgjwmAPJurf50Uw=;
        b=J2EFF13K/jXVBj5kVcGXkf4RTeD2hgA/FBTQUufm3ZAyBcJfDNoM8BEXyhVSeaM97J
         3NRdzMCsebNhpUDgWPIQNpcHCSuN31/lsVomrYDqdzdwIbdbvK4+amEAIc6puo1dzF2E
         SkZZGJgtjwUySa44m9f4HcJZ5Kv+RLrasmrrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rBbuZ1/hGmJSVpkE9Mk+PjVfNnVUpgjwmAPJurf50Uw=;
        b=eJNIj2VMstdO1PhROwj6vTLiUsEwo0LhHj6H/s7JOhV2VCOrAwfNyvRq3VEEDRIyBP
         UFUzI3jgVDjEGfmiSwx4oS4x+syX7idwQ+RDV32Otc9ORWdhJ/wl6qeD93ukA+ja2zRS
         Ls50WCvgogVZSDzVMUI7+Qx7Ugmhkn43ckausKjC1iVIdZLD8yfwZpgQM9dS6cZV4q0L
         6nW5dejHAcUFxnzXUB/yBd9lgTe5fSwu5nWJv4SdHT/INfbPWQLKgI3DFgzjIXSD4Suk
         thq/wMNKmLSdsd+/bW+U2xIV1VdzDgE21fKHyJoH5ea6cCsziQkePFkX4HH83VFGir9d
         Qjfg==
X-Gm-Message-State: APjAAAWN00q5oFHQ2Ib8+fgIXAewH5F0NJ7GPiyoUxqkNfs/ogJpJ14M
        ucqXKJjNrQ4oPPhS2/PpMEawww==
X-Google-Smtp-Source: APXvYqynrv4peJetxnAo9QWlTFtoQAG24ppGCJoY2oeM0C/YlX0ZUTXBo5O8AkbLJU88NgBvfrKtBA==
X-Received: by 2002:a17:90a:24a8:: with SMTP id i37mr6241044pje.123.1569004365164;
        Fri, 20 Sep 2019 11:32:45 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b69sm4436072pfb.132.2019.09.20.11.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 11:32:44 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v7 3/6] tpm: tpm_tis_spi: Introduce a flow control callback
Date:   Fri, 20 Sep 2019 11:32:37 -0700
Message-Id: <20190920183240.181420-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
In-Reply-To: <20190920183240.181420-1-swboyd@chromium.org>
References: <20190920183240.181420-1-swboyd@chromium.org>
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
Cc: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/char/tpm/tpm_tis_spi.c | 62 ++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 21 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
index 19513e622053..b3ed85671dd8 100644
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
 
@@ -50,12 +52,46 @@ static inline struct tpm_tis_spi_phy *to_tpm_tis_spi_phy(struct tpm_tis_data *da
 	return container_of(data, struct tpm_tis_spi_phy, priv);
 }
 
+/*
+ * TCG SPI flow control is documented in section 6.4 of the spec[1]. In short,
+ * keep trying to read from the device until MISO goes high indicating the
+ * wait state has ended.
+ *
+ * [1] https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profile-ptp-specification/
+ */
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
@@ -82,26 +118,9 @@ static int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
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
@@ -207,6 +226,7 @@ static int tpm_tis_spi_probe(struct spi_device *dev)
 	phy->iobuf = devm_kmalloc(&dev->dev, MAX_SPI_FRAMESIZE, GFP_KERNEL);
 	if (!phy->iobuf)
 		return -ENOMEM;
+	phy->flow_control = tpm_tis_spi_flow_control;
 
 	/* If the SPI device has an IRQ then use that */
 	if (dev->irq > 0)
-- 
Sent by a computer through tubes

