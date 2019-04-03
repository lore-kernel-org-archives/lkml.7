Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8024C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2F120882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptrpgFFF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbfDCECJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:02:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44632 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbfDCECF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:02:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id i2so7597782pgj.11;
        Tue, 02 Apr 2019 21:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lQ5TRqsl7OK4dEO30Fxm7obK/gnvpQsYkNAdZjHgD1Y=;
        b=ptrpgFFFBW0XMvWarVP6hSin6Cp1WxSuNsLKB7TAFV5pdPCxGk5HFmcE5f3/WTZ8FD
         syQqXCDq1sKD6aYHBAhmgJ4ftW4OilbWAKA2lhusyQ2lKsYFKiQmZjnMsFMhlydEOptC
         5f4ozgwH/vCLKc3xj/0aPzTxfFPH6iAyK6G11ilREhLnNUEVDbIeCD8tImioTuG/5hZX
         yAdk1/8vTvTNLDjIf5zd+8F43IXnX/QkxNKW3Bax0zuLcHI5IQhktinJLNTJab58NIeG
         VmrY1zGFU4EM/uxXzypQGcJffxFsd2f+IQ1cWOrEAtKdN3ZdbcY+IV3KlD31i9UGaAWC
         DQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lQ5TRqsl7OK4dEO30Fxm7obK/gnvpQsYkNAdZjHgD1Y=;
        b=JuF7aPcJbpZ2HvWhu0Z8AzeE8Ff4+LP40q2IyTZ4zzoUG8ksnkcqi20NDQR/5uoZwN
         R5Ac/BhnJ94hS+INanDs70QmIgUwNTe/IHGZDehxiSgkeScpzp9QbittLbRVc6a3wz+J
         YYDPJv8mWsRpXVpHEoXGvLjnAhYsINGGLM0uYtGSyJ2ISFoS9hfTn4FseXusL8RFSOdR
         H5ljpymCU5I41jmM3VfAFdin+SDh3v1YRNymTwREoMxCqiKNTXmjRHep6Oy9QbnR1ne6
         CJp4tTmPFLilsRzPc5Jip2ExHC47Zu2/w6UelBY/NjYB5aF4qQ/3faQDpZSRw7y5fTrB
         ohkA==
X-Gm-Message-State: APjAAAV1htW+dKE+9RSBo4sxanHwtFVOJgv7zJzULvBC916PgB5JxMa5
        BjQq7iennGgEGu7mX2a8++es0ZHB
X-Google-Smtp-Source: APXvYqxFnxsBSlLgCTkoKsjb5WiZfgpz43mL3z0eSIukGuN54vp1cQf2g/tu8wffxkwZbNq8luvsMw==
X-Received: by 2002:a63:554b:: with SMTP id f11mr11742738pgm.77.1554264124585;
        Tue, 02 Apr 2019 21:02:04 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id k14sm16278064pfb.125.2019.04.02.21.02.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 21:02:03 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] spi: bitbang: Introduce spi_bitbang_init()
Date:   Tue,  2 Apr 2019 21:01:32 -0700
Message-Id: <20190403040133.1459-12-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403040133.1459-1-andrew.smirnov@gmail.com>
References: <20190403040133.1459-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move all of the code doing struct spi_bitbang initialization, so that
it can be paired with devm_spi_register_master() in order to avoid
having to call spi_bitbang_stop() explicitly.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/spi/spi-bitbang.c       | 66 +++++++++++++++++++--------------
 include/linux/spi/spi_bitbang.h |  1 +
 2 files changed, 40 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index dd9a8c54a693..4243e53f9f7b 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -335,6 +335,42 @@ static void spi_bitbang_set_cs(struct spi_device *spi, bool enable)
 
 /*----------------------------------------------------------------------*/
 
+int spi_bitbang_init(struct spi_bitbang *bitbang)
+{
+	struct spi_master *master = bitbang->master;
+
+	if (!master || !bitbang->chipselect)
+		return -EINVAL;
+
+	mutex_init(&bitbang->lock);
+
+	if (!master->mode_bits)
+		master->mode_bits = SPI_CPOL | SPI_CPHA | bitbang->flags;
+
+	if (master->transfer || master->transfer_one_message)
+		return -EINVAL;
+
+	master->prepare_transfer_hardware = spi_bitbang_prepare_hardware;
+	master->unprepare_transfer_hardware = spi_bitbang_unprepare_hardware;
+	master->transfer_one = spi_bitbang_transfer_one;
+	master->set_cs = spi_bitbang_set_cs;
+
+	if (!bitbang->txrx_bufs) {
+		bitbang->use_dma = 0;
+		bitbang->txrx_bufs = spi_bitbang_bufs;
+		if (!master->setup) {
+			if (!bitbang->setup_transfer)
+				bitbang->setup_transfer =
+					 spi_bitbang_setup_transfer;
+			master->setup = spi_bitbang_setup;
+			master->cleanup = spi_bitbang_cleanup;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spi_bitbang_init);
+
 /**
  * spi_bitbang_start - start up a polled/bitbanging SPI master driver
  * @bitbang: driver handle
@@ -368,33 +404,9 @@ int spi_bitbang_start(struct spi_bitbang *bitbang)
 	struct spi_master *master = bitbang->master;
 	int ret;
 
-	if (!master || !bitbang->chipselect)
-		return -EINVAL;
-
-	mutex_init(&bitbang->lock);
-
-	if (!master->mode_bits)
-		master->mode_bits = SPI_CPOL | SPI_CPHA | bitbang->flags;
-
-	if (master->transfer || master->transfer_one_message)
-		return -EINVAL;
-
-	master->prepare_transfer_hardware = spi_bitbang_prepare_hardware;
-	master->unprepare_transfer_hardware = spi_bitbang_unprepare_hardware;
-	master->transfer_one = spi_bitbang_transfer_one;
-	master->set_cs = spi_bitbang_set_cs;
-
-	if (!bitbang->txrx_bufs) {
-		bitbang->use_dma = 0;
-		bitbang->txrx_bufs = spi_bitbang_bufs;
-		if (!master->setup) {
-			if (!bitbang->setup_transfer)
-				bitbang->setup_transfer =
-					 spi_bitbang_setup_transfer;
-			master->setup = spi_bitbang_setup;
-			master->cleanup = spi_bitbang_cleanup;
-		}
-	}
+	ret = spi_bitbang_init(bitbang);
+	if (ret)
+		return ret;
 
 	/* driver may get busy before register() returns, especially
 	 * if someone registered boardinfo for devices
diff --git a/include/linux/spi/spi_bitbang.h b/include/linux/spi/spi_bitbang.h
index b7e021b274dc..4444c2a992cb 100644
--- a/include/linux/spi/spi_bitbang.h
+++ b/include/linux/spi/spi_bitbang.h
@@ -44,6 +44,7 @@ extern int spi_bitbang_setup_transfer(struct spi_device *spi,
 
 /* start or stop queue processing */
 extern int spi_bitbang_start(struct spi_bitbang *spi);
+extern int spi_bitbang_init(struct spi_bitbang *spi);
 extern void spi_bitbang_stop(struct spi_bitbang *spi);
 
 #endif	/* __SPI_BITBANG_H */
-- 
2.20.1

