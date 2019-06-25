Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48ADC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D500215EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="WcVfJ0X0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730844AbfFYIlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:41:40 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35148 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730817AbfFYIli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:41:38 -0400
Received: by mail-lj1-f194.google.com with SMTP id x25so15405936ljh.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 01:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rd250VDhsjPLUwA1a42kw4RNZnyxND2ZxMWmtg0lvNo=;
        b=WcVfJ0X0LUHLM0e/G6nd/vLI+BGUCKQWYKotmqkmKz+bpFDdiBnvJ8jEt09JC6Jw8Q
         1FWXOrrHi9NET4XQMT/spR6M1nzKZcrV8L2Vcxn38bAoHJNXtKWj85EJ7PZoB16UqAjM
         PRmqvrLoSKWAUIEdxfcr06a6iAPOykZhM3eggXl7TD3T5uiifP5VNTZkhApb8jNfAriw
         Kt2K3b1M/7RG7jw7qTSF8bzq62CpWR6slmgyqXI/rYvl30WhT3sSgsERYvFoeO90Fyrn
         wF67T/7T1kYcM2slwppbIWXSJCGEqHPJhDYuWPZFU33Eka4iEw4wME5xliWeCgGR774B
         MqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rd250VDhsjPLUwA1a42kw4RNZnyxND2ZxMWmtg0lvNo=;
        b=JOB7ETktISdiSg7Dbvr1faBNBxYXA13/oRWpg60j5YQflRRE6tTu13xlJKEjtlCc39
         wnnHX/754NVfmd/o1hks6yMNnYVY2GIeePbCbnd/mCv8tCq87a41EyKvutcZugzWIrAP
         rq7Kcr1WzpfcGpAYpjP6HBz+Pp4flFNWGDzzUS4VLo0jdKGzdCHxjGSvogPQAI33AEbo
         /2Sufd31IJL6k9F7dnQqGvNWkaCN+6KbuKYsv0QpFFXo3IujQMA9Ls/ZwtVPAB8Y2l9J
         4m4ghMiKWU7pMb27uuinX+Q7+GwXLxwZuMnDZAZvSVFXZFHp5m+Tyn7iJUTLD9gLFClt
         Ml/g==
X-Gm-Message-State: APjAAAUepQx41nOqT9ZrczaLIhmKgtLpWH43hzpfuXN+g+escNTUXLsv
        2s0Lz3OkuaEAzQznhB9Tb4Buyg==
X-Google-Smtp-Source: APXvYqxlEa2qcgRTrBKbmMGD0WUI4gNzVSn1EmnChp9trqvT5sEKRzwQR4wR12wpCpwZY/aiwZNdWg==
X-Received: by 2002:a2e:3a05:: with SMTP id h5mr73942952lja.114.1561452096735;
        Tue, 25 Jun 2019 01:41:36 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id h78sm341564ljf.88.2019.06.25.01.41.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 01:41:35 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     gneukum1@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
Subject: [PATCH 2/4] staging: kpc2000: add missing spaces in kpc2000_spi.c
Date:   Tue, 25 Jun 2019 10:41:28 +0200
Message-Id: <20190625084130.1107-3-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625084130.1107-1-simon@nikanor.nu>
References: <20190625084130.1107-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch errors:
- spaces required around that '=' (ctx:VxV)
- space required before the open parenthesis '('
- spaces preferred around that '-' (ctx:VxV)
- space required before the open brace '{'

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index c3e5c1848f53..98484fbb9d2e 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -164,7 +164,7 @@ kp_spi_read_reg(struct kp_spi_controller_state *cs, int idx)
 	u64 val;
 
 	addr += idx;
-	if ((idx == KP_SPI_REG_CONFIG) && (cs->conf_cache >= 0)){
+	if ((idx == KP_SPI_REG_CONFIG) && (cs->conf_cache >= 0)) {
 		return cs->conf_cache;
 	}
 	val = readq(addr);
@@ -223,9 +223,9 @@ kp_spi_txrx_pio(struct spi_device *spidev, struct spi_transfer *transfer)
 			processed++;
 		}
 	}
-	else if(rx) {
+	else if (rx) {
 		for (i = 0 ; i < c ; i++) {
-			char test=0;
+			char test = 0;
 
 			kp_spi_write_reg(cs, KP_SPI_REG_TXDATA, 0x00);
 
@@ -261,7 +261,7 @@ kp_spi_setup(struct spi_device *spidev)
 	cs = spidev->controller_state;
 	if (!cs) {
 		cs = kzalloc(sizeof(*cs), GFP_KERNEL);
-		if(!cs) {
+		if (!cs) {
 			return -ENOMEM;
 		}
 		cs->base = kpspi->base;
@@ -364,7 +364,7 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
 			if (transfer->bits_per_word) {
 				word_len = transfer->bits_per_word;
 			}
-			sc.bitfield.wl = word_len-1;
+			sc.bitfield.wl = word_len - 1;
 
 			/* ...chip select */
 			sc.bitfield.cs = spidev->chip_select;
@@ -425,7 +425,7 @@ kp_spi_probe(struct platform_device *pldev)
 	int i;
 
 	drvdata = pldev->dev.platform_data;
-	if (!drvdata){
+	if (!drvdata) {
 		dev_err(&pldev->dev, "kp_spi_probe: platform_data is NULL!\n");
 		return -ENODEV;
 	}
@@ -476,7 +476,7 @@ kp_spi_probe(struct platform_device *pldev)
 		spi_new_device(master, &(table[i])); \
 	}
 
-	switch ((drvdata->card_id & 0xFFFF0000) >> 16){
+	switch ((drvdata->card_id & 0xFFFF0000) >> 16) {
 	case PCI_DEVICE_ID_DAKTRONICS_KADOKA_P2KR0:
 		NEW_SPI_DEVICE_FROM_BOARD_INFO_TABLE(p2kr0_board_info);
 		break;
-- 
2.20.1

