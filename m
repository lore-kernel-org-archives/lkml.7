Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584A1C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A669206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S96Zv1qC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfDZKa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 06:30:26 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39215 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfDZKa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 06:30:26 -0400
Received: by mail-lj1-f196.google.com with SMTP id q10so2443678ljc.6;
        Fri, 26 Apr 2019 03:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8zqBMm2GfWpJOZGBcn2P97vjljYhCv1sr0X7foSj8jU=;
        b=S96Zv1qCBN53W1/5PAc3QwCClD2ceJ165SWyI+J2d/I6s+MJOvfliacB6ISHN/4+Mt
         cx1EEVjJv+yjwsynikRmwqPKx8WygNnPSqCkBvMTVdBSrIbHBkwPNYtruRbUpGSNEvV9
         AhprCHYiY6m5vVyAxKWC8XjxvRxkDMq2pfyrF8xuPDpVFvKY5dB+eKGMU/Fwfw7nsSMC
         G2NJEVraGlHYbGQiV1EiK0zHQsTzP8VIQomYbTubQBQbgvabWKYYySmvHb+DVVsdJT3Y
         lDVV86NUWnwrg2WZ5/J1rEE88fjUgZJXLFObwZDhS5cPLPtawOUizmn4qMbBDjw6xo0w
         Sjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8zqBMm2GfWpJOZGBcn2P97vjljYhCv1sr0X7foSj8jU=;
        b=iw8ue+YtNXmy/cLF5Fk1ZoruyhTBFZTpvtwyvlvGkzELAt2CyFsnGwjbY8SGuIL3AK
         ULVqBsrM6CWOBfxf0AaBXT00RDOEBtDsJaj5F4H6Umjj6adiirzT7FzFvzw9xbrZHRtS
         AdBN/oVwyuMAS7ZMw4MIvJx9fVSI5hPBucSjMaHQRDfndYScexE5CDxfmFKslX8zjrzg
         +F9l2z1CEXbrk60RmuQmtx9EhH96orkvYrvLVlZKOQUTSUgAasJa4t6o/m2T+A+BJe3N
         GK3Z7K/ol04H2D5oAR8CnDt3SOpGZlHAC7QpZaXxYVe+08XmCIe+TNKmYNPzlpDgezAj
         49Mg==
X-Gm-Message-State: APjAAAWK8C0zpco7Q8UExALo/Nu7agfJ7rRuAz3w4gKtnctEO9PDdbLT
        sFc56QkLi31SiE9YDxDLQQs=
X-Google-Smtp-Source: APXvYqzyVmCPjMsfn16taSQR340qE0hdIaRk6v+750SYDWOcitpTuLMHpZchtHXHtqAtawypq79EaQ==
X-Received: by 2002:a2e:9196:: with SMTP id f22mr24332953ljg.82.1556274623646;
        Fri, 26 Apr 2019 03:30:23 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id o3sm5509729lfn.41.2019.04.26.03.30.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 03:30:22 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: Clear SPI_CS_HIGH flag from bad_bits for GPIO chip-select
Date:   Fri, 26 Apr 2019 13:30:07 +0300
Message-Id: <20190426103007.29612-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When GPIO chip-select is used nothing prevents any available SPI
controllers to work with both CS-high and traditional CS-low modes.
In fact the SPI bus core code already does it, so we don't need to
introduce any modification there. But spi_setup() still fails to
switch the interface settings if CS-high flag is set for the case
of GPIO-driven slave chip-select when the SPI controller doesn't
support the hardwired CS-inversion. Lets fix it by clearing the
SPI_CS_HIGH flag out from bad_bits (unsupported by controller) when
client chip is selected by GPIO.

This feature is useful for slave devices, which in accordance with
communication protocol can work with both active-high and active-low
chip-selects. I am aware of one such device. It is MMC-SPI interface,
when at init sequence the driver needs to perform a read operation with
low and high chip-select sequentially (requirement of 74 clock cycles
with both chipselect, see the mmc_spi driver for details).

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/spi/spi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 93986f879b09..49808892ef35 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2943,6 +2943,11 @@ int spi_setup(struct spi_device *spi)
 	 * so it is ignored here.
 	 */
 	bad_bits = spi->mode & ~(spi->controller->mode_bits | SPI_CS_WORD);
+	/* nothing prevents from working with active-high CS in case if it
+	 * is driven by GPIO.
+	 */
+	if (gpio_is_valid(spi->cs_gpio))
+		bad_bits &= ~SPI_CS_HIGH;
 	ugly_bits = bad_bits &
 		    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL |
 		     SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL);
-- 
2.21.0

