Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99781C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B9420652
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6kl5u4g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfDLKyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:54:20 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33110 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfDLKyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:54:19 -0400
Received: by mail-ed1-f68.google.com with SMTP id d55so7144675ede.0;
        Fri, 12 Apr 2019 03:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xKIfWCxHbhwFJ1+b/MwpbnrM3F2wdwu1e4NkzCc5CUM=;
        b=b6kl5u4gCyhc3RlJhHnrlp0Ruz7qcDwYdEYS37U+BV0XzFWCCcXpovAw/CUAILObFk
         pTI2PARuYgVvelWMzAY4Ak9444kwJ5AkILEHBktWN+sEAETdd9eWnvcR/OVw1LjrZqYH
         hVxx/jupdVUuUHBvQdkCqMJIKd1Cx+qkUqg4T1S3DOBv9qclj7c13NWaKw5N2sh5RA+r
         ZyU4TYhxdjJJItlvDykMuluOhNFXRXssaVttuYTXQZeYlvKHaTXforCTvrW3EM6ISnvo
         83h5Rul633cpgi1EnXhLeI2Ne74Lb0g+BSO5lnYM/jAp/RiXnRN38yi3r8R7hYpOYEeB
         s+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=xKIfWCxHbhwFJ1+b/MwpbnrM3F2wdwu1e4NkzCc5CUM=;
        b=pUAm1unSy63dppNMKDf8xriRNom6a9ulNcL3LteiQTwF2xEuOwQGuGUXqDqWFfRDlh
         GXADTWu4QCx57pb9Yv7lNt1Xe6l2lF4PsxOLSkFidueR/bcpmnvtUYXsUWMMgfU2eHQ5
         OkFWHIcFpn5aQKAp/WkOI3T77EKsAXJmu/641WK0+JwYl2ITawuVOMjzXUFOb9ydMayP
         oLgNCbVDfXk064khCigJV085jFtxfzvyUtk5naGdUTfk2lzlrmAb0CO16jBZNoy7uYL5
         6aa3O7+4E7APQrNhbaD0z1v/0A412ZwHt/M5u4aAfHjLkjXhGj/U9/IdLaWojaxywjv2
         5TVw==
X-Gm-Message-State: APjAAAXbK8vnuYwzrsXr+Qic07zKL38x1cxR0mTk36yzh1dHP9zJQT+o
        FtDlIgOLdTkpS3DCAB9r+FSE0Kl0
X-Google-Smtp-Source: APXvYqxe6QhezhBCK+opbYcdALZLkgRza3g2v2TvYPzD8jEQ0r9PChlcheUh07eMQCr/Xr7fdkmk7g==
X-Received: by 2002:a17:906:2f13:: with SMTP id v19mr30567233eji.17.1555066457744;
        Fri, 12 Apr 2019 03:54:17 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4262:1ab:e::10])
        by smtp.gmail.com with ESMTPSA id y71sm2862750ede.21.2019.04.12.03.54.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 03:54:13 -0700 (PDT)
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     linux-spi@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Vicente Bergas <vicencb@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: [PATCH] spi: rockchip: turn down tx dma bursts
Date:   Fri, 12 Apr 2019 12:53:20 +0200
Message-Id: <20190412105320.2924-1-kernel@esmil.dk>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes tx and bi-directional dma transfers on rk3399-gru-kevin.

It seems the SPI fifo must have room for 2 bursts when the dma_tx_req
signal is generated or it might skip some words. This in turn makes
the rx dma channel never complete for bi-directional transfers.

Fix it by setting tx burst length to fifo_len / 4 and the dma
watermark to fifo_len / 2.

However the rk3399 TRM says (sic):
"DMAC support incrementing-address burst and fixed-address burst. But in
the case of access SPI and UART at byte or halfword size, DMAC only
support fixed-address burst and the address must be aligned to word."

So this relies on fifo_len being a multiple of 16 such that the
burst length (= fifo_len / 4) is a multiple of 4 and the addresses
will be word-aligned.

Fixes: dcfc861d24ec ("spi: rockchip: adjust dma watermark and burstlen")
Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 3912526ead66..19f6a76f1c07 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -425,7 +425,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
 			.direction = DMA_MEM_TO_DEV,
 			.dst_addr = rs->dma_addr_tx,
 			.dst_addr_width = rs->n_bytes,
-			.dst_maxburst = rs->fifo_len / 2,
+			.dst_maxburst = rs->fifo_len / 4,
 		};
 
 		dmaengine_slave_config(master->dma_tx, &txconf);
@@ -526,7 +526,7 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 	else
 		writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_RXFTLR);
 
-	writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_DMATDLR);
+	writel_relaxed(rs->fifo_len / 2, rs->regs + ROCKCHIP_SPI_DMATDLR);
 	writel_relaxed(0, rs->regs + ROCKCHIP_SPI_DMARDLR);
 	writel_relaxed(dmacr, rs->regs + ROCKCHIP_SPI_DMACR);
 
-- 
2.21.0

