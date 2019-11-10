Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74182C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 05:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F0221655
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 05:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRJv1meB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfKJFck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 00:32:40 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33919 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfKJFcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 00:32:39 -0500
Received: by mail-pl1-f196.google.com with SMTP id h13so755872plr.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2019 21:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dW9rEHfAMAiZ8BDOMvHKousAF8Cv21mLTzBUYKxpOAI=;
        b=eRJv1meBHaBsNs/LWfHXDNl3o4RXJ1hz/3kt5fdFOk79SGhh33/iUy1l0wzRyoZWCk
         x8b44T2LDZgKpCuw/tSGwVeaLlR2Q/ItR5Sn7MbIVaXY05a8jzUbAbCgQSZ4UE7hd04/
         64lPaX1SAl2J3fgqt1fBR+dWP3OV0zBSULRZ24l1vHNnxBMB+RK3oxgnGwNJQjUsLA6R
         vpTckT7770qWDDzfgiNhsY+rbI+pZ1Q82kbmEMdxQXzmp34k3zcC4a346/C37jYyl5XK
         V3AECsCFqp53kTxhYnBUhBxT8PhTMyLGA2teM05+B7Wt3Nb3fj7HuZWa1w4OJixlRo1S
         ++Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dW9rEHfAMAiZ8BDOMvHKousAF8Cv21mLTzBUYKxpOAI=;
        b=Y/aQ4TlY8637DxDByyN4baRG+4ysJQTOn1X+biNfSchGDQ8Eazw7ZH6/cEZVBnIqku
         Y0ng/xF19CTQgzIVI5hgsuYegYhQjSCu35OmjkOiTyjrqY0/AdJRC2wYp9rNPx/cdz4j
         boT09UGt339hcfzbEKMGY0zO8euruT6UiL3HC9eajQ0p5kUtFm4J3vDOTzsu/zrmxScH
         /3bLpLEXePTAza7yGWncI/A+dAxFstH3wXG47FltFy9bG50s5GWWYpOQr0Y5VTt8yjRe
         //GcxEu1zWo30gWkvliBYWLShyMvF4S3tUzSCG/WBsNqR2D3BNVHvbGCSeGI9KlFAl7f
         CLQQ==
X-Gm-Message-State: APjAAAU7zGbXXgXYrytTA5ah5TBzbS+vozjY/23DfgVtEz5iyUEK+LZw
        HHW36e5vpYQPCzI9qc+vnp0=
X-Google-Smtp-Source: APXvYqxmqFZlDdyU04Yl8n0zJ1+fXDN6Te6YzmWq7V5r4yf2f++VR8Wzpvp+/frSUOXQAo9ZLnCZkw==
X-Received: by 2002:a17:902:142:: with SMTP id 60mr19903253plb.38.1573363958952;
        Sat, 09 Nov 2019 21:32:38 -0800 (PST)
Received: from localhost.localdomain ([2001:19f0:7001:2668:5400:1ff:fe62:2bbd])
        by smtp.gmail.com with ESMTPSA id v19sm9759298pjr.14.2019.11.09.21.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2019 21:32:38 -0800 (PST)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: spi-nor: add dual and quad read support for w25q128
Date:   Sun, 10 Nov 2019 13:32:21 +0800
Message-Id: <20191110053222.22945-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only w25q128 variant I could find with 0xef4018 as ID is
w25q128fv, which supports both dual and quad read mode.
Add these two flags in chip info.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index f89620005198..6adf16259841 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2479,7 +2479,10 @@ static const struct flash_info spi_nor_ids[] = {
 	},
 	{ "w25q80", INFO(0xef5014, 0, 64 * 1024,  16, SECT_4K) },
 	{ "w25q80bl", INFO(0xef4014, 0, 64 * 1024,  16, SECT_4K) },
-	{ "w25q128", INFO(0xef4018, 0, 64 * 1024, 256, SECT_4K) },
+	{
+		"w25q128", INFO(0xef4018, 0, 64 * 1024, 256,
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
+	},
 	{ "w25q256", INFO(0xef4019, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "w25q256jvm", INFO(0xef7019, 0, 64 * 1024, 512,
 			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-- 
2.21.0

