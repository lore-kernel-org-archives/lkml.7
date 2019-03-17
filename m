Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F79AC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 08:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0069E21019
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 08:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCmUpGPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfCQIpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 04:45:24 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45186 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfCQIpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 04:45:24 -0400
Received: by mail-ed1-f68.google.com with SMTP id m16so4418432edd.12
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 01:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RtHiWH4K4SJja5CH/zDeqFlMiK5IlNzj5APbdLQeZRw=;
        b=DCmUpGPqk/ha9uQ+xUDlCMagJAIVzby5g1u6GVt8wSAK/wTSaTO3Ujmn/WlMwe1X6P
         32diwz5kFCt4cqQ74ulbXfBlMgE0fItlQTWeMu+VTLpTtM/roPrENNvAaKB5d4WlziMz
         NnLsLQaOyvPC9y4h3AqTejhOlse3nMjnANqoTONm1T91WAlB2CMEcuUkx8L6JpvZ3MrS
         aZEaPlMWu3Jtv9mGDwzbb3qgU4AXwgV5p55Y4yA8vFXr9GtLQOEwGN5dNgrs255r3cTU
         QqvtYGAfxlpXne+OhPQNac30oVQYtA1w2zwjBH6tUrQZ7Kr3WbfBH1FbMSfdOKsQHAkm
         0c7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RtHiWH4K4SJja5CH/zDeqFlMiK5IlNzj5APbdLQeZRw=;
        b=bxFK8jyICIf//IZfmStMhyxr++9q04R0+oOOP4/LJz5AGg2zDCluaiW0mh+ujhd4tM
         OiAGB5YoSx1iIfFDvYyNH1GCbDpwdVnAJxrRated5uVLfO3jDGS3swF/2tXL0gWnh0Tl
         mA61fAjVdI7RCLoQEMCnYAkMdC+TskADbFZYpL7VjQBHzT498PCXrGxCzssFb0Z4LbAP
         a8n/t0llV4tF5RfaRv2iivm0bx/yuhibpEobZyqDbOIF1Okt1r8CDA+nm4lzd8VqbztY
         aU/0OwquSaSWjfyVTFeiVq07+9aS0pOw6xMe47mDbqOG8B6iFvdq49Hf8T25kteHOgck
         oGLA==
X-Gm-Message-State: APjAAAVDLujdBmIvgDBCoTllQ5ZQjJcrnRRJlJVzz0ryEW1/xgei/C4F
        JbXt53JBKKadGEVrReUUnmo=
X-Google-Smtp-Source: APXvYqxs8U8C4rz1U0om36B0l6u9CkssvSdjjiYTmgsEgSTvgbKo5FLgJMIWd5WeFEE0oXXK2D/DGA==
X-Received: by 2002:a50:b497:: with SMTP id w23mr8983849edd.84.1552812322436;
        Sun, 17 Mar 2019 01:45:22 -0700 (PDT)
Received: from lamport.roam.corp.google.com ([89.248.140.15])
        by smtp.gmail.com with ESMTPSA id b3sm91998edj.56.2019.03.17.01.45.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 01:45:21 -0700 (PDT)
From:   Armando Miraglia <arma2ff0@gmail.com>
X-Google-Original-From: Armando Miraglia <armax@google.com>
To:     matthias.bgg@gmail.com, neil@brown.name
Cc:     gregkh@linuxfoundation.org, christian@lkamp.de,
        bhanusreemahesh@gmail.com, jbi.octave@gmail.com,
        sergio.paracuellos@gmail.com, gustavo@embeddedor.com,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Armando Miraglia <armax@google.com>
Subject: [PATCH] dma: mediatek: addres minor style issues flagged by clang-format.
Date:   Sun, 17 Mar 2019 09:44:45 +0100
Message-Id: <20190317084443.158913-1-armax@google.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running clang-format on mtk-hsdma.c I noticed that few lines would not
need to be wrapped, since they fit 80 columns. This change changes such
lines to better fit the style-guide.

Signed-off-by: Armando Miraglia <armax@google.com>
---
 drivers/staging/mt7621-dma/mtk-hsdma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/mt7621-dma/mtk-hsdma.c b/drivers/staging/mt7621-dma/mtk-hsdma.c
index 97571f1d697b..74c374f7bef4 100644
--- a/drivers/staging/mt7621-dma/mtk-hsdma.c
+++ b/drivers/staging/mt7621-dma/mtk-hsdma.c
@@ -264,8 +264,7 @@ static void mtk_hsdma_reset(struct mtk_hsdam_engine *hsdma,
 	/* init desc value */
 	for (i = 0; i < HSDMA_DESCS_NUM; i++) {
 		chan->tx_ring[i].addr0 = 0;
-		chan->tx_ring[i].flags = HSDMA_DESC_LS0 |
-			HSDMA_DESC_DONE;
+		chan->tx_ring[i].flags = HSDMA_DESC_LS0 | HSDMA_DESC_DONE;
 	}
 	for (i = 0; i < HSDMA_DESCS_NUM; i++) {
 		chan->rx_ring[i].addr0 = 0;
@@ -435,8 +434,7 @@ static irqreturn_t mtk_hsdma_irq(int irq, void *devid)
 	if (likely(status & HSDMA_INT_RX_Q0))
 		tasklet_schedule(&hsdma->task);
 	else
-		dev_dbg(hsdma->ddev.dev, "unhandle irq status %08x\n",
-			status);
+		dev_dbg(hsdma->ddev.dev, "unhandle irq status %08x\n", status);
 	/* clean intr bits */
 	mtk_hsdma_write(hsdma, HSDMA_REG_INT_STATUS, status);
 
-- 
2.21.0.360.g471c308f928-goog

