Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF88C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD002147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="fjBBCVWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfCMQz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:55:56 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:49288 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfCMQzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:55:54 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 6B53C110
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 16:55:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rd1_eAM9eqCc for <linux-kernel@vger.kernel.org>;
        Wed, 13 Mar 2019 11:55:52 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 3F93FC65
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 11:55:52 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id b199so2023091iof.14
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 09:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=upm2Q86VVPu6zcT5F0Y1ZkrMnCzf1/YcQCvwWffDqY4=;
        b=fjBBCVWJ6SGRmNGThnwgtYsvamFxWPfSKFKZMZpPjJEjOEuM+AWt/bQQRsruo1fNDl
         DPBLutlz3QhAbe1s1o9nlSgMnGkSTBglAukh5UpQKLsqE+OX+qBg6/u61lro89uEwx4T
         36+2ehxCQZUytmgYXWl/JybHf6TqOxaze2+Xi16BShlpb3BeSAXn3J/A0ydAa6alKXDV
         LtyQS2vG9cq9sm76u7EBYoX4n7mQgBkq6ZHJK6AqrEJwPPDl2g5CqObrMF/yWXhGBazp
         qwTHEkescDJkK8YXH5GluD+J4jkwv4pTGX9WHM6ZznMvFKw2A1BdagtDJFAXAEeH4iyq
         5xXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=upm2Q86VVPu6zcT5F0Y1ZkrMnCzf1/YcQCvwWffDqY4=;
        b=V5od1OVK8aBOTnk5meA6WkrQ4n1O48Z+JUD2fnIBZp1NjzAh00BZ7gxvHmO7OVEFap
         5D+4PoEgNtSSTZdMlsSBVeHFpQdpKeyQcptCgiyLwuzbAXZzaj760GUi4U97LxYJ/DHd
         62P1dWLiO2bCo91IBJmOMdSVbweidFOwNC452m/uIY4NIUlf3xoItB/f7DWdH+sWKQYQ
         YTXy5dF8JN1hMrjkFqxhcnBLaiMslLC7DUQVzy7/r4U7hq/Qqr8bUcS7O5bsA4bIgu5i
         LOqRsnnNEgoItRBAZuNnfDktCnO4ASp7xRxpbdJopDPkPXHv51fsD17R6VG2S5eUgE8W
         GyYg==
X-Gm-Message-State: APjAAAVVV1Q2Ww4nmzozJUpGV3iTuocx3sxlmDk4kGAjwdS8Y5RqrWYS
        0z2XI523nVBmzv9AqE5zujVFt4ur+eVAPRGMDPt2ySDasuwlV9GUe3gkpl7pLvElwWOXHWp5XX6
        1htwf7z2Sf0mAUy7ms58jnr42tjWA
X-Received: by 2002:a24:1605:: with SMTP id a5mr2378473ita.89.1552496151882;
        Wed, 13 Mar 2019 09:55:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwAyM691gipaluBGG4UigtYI9JEjuIMmsRRWSrod/ejHoO+1Ur/GV3ny4utDJumv/RbKILgAQ==
X-Received: by 2002:a24:1605:: with SMTP id a5mr2378461ita.89.1552496151627;
        Wed, 13 Mar 2019 09:55:51 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id q17sm5554692ior.71.2019.03.13.09.55.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 09:55:50 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi : spi-topcliff-pch: Fix to handle empty DMA buffers
Date:   Wed, 13 Mar 2019 11:55:41 -0500
Message-Id: <20190313165541.22548-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pch_alloc_dma_buf allocated tx, rx DMA buffers which can fail. Further,
these buffers are used without a check. The patch checks for these
failures and sends the error upstream.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/spi/spi-topcliff-pch.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index fba3f180f233..8a5966963834 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1299,18 +1299,27 @@ static void pch_free_dma_buf(struct pch_spi_board_data *board_dat,
 				  dma->rx_buf_virt, dma->rx_buf_dma);
 }
 
-static void pch_alloc_dma_buf(struct pch_spi_board_data *board_dat,
+static int pch_alloc_dma_buf(struct pch_spi_board_data *board_dat,
 			      struct pch_spi_data *data)
 {
 	struct pch_spi_dma_ctrl *dma;
+	int ret;
 
 	dma = &data->dma;
+	ret = 0;
 	/* Get Consistent memory for Tx DMA */
 	dma->tx_buf_virt = dma_alloc_coherent(&board_dat->pdev->dev,
 				PCH_BUF_SIZE, &dma->tx_buf_dma, GFP_KERNEL);
+	if (!dma->tx_buf_virt)
+		ret = -ENOMEM;
+
 	/* Get Consistent memory for Rx DMA */
 	dma->rx_buf_virt = dma_alloc_coherent(&board_dat->pdev->dev,
 				PCH_BUF_SIZE, &dma->rx_buf_dma, GFP_KERNEL);
+	if (!dma->rx_buf_virt)
+		ret = -ENOMEM;
+
+	return ret;
 }
 
 static int pch_spi_pd_probe(struct platform_device *plat_dev)
@@ -1387,7 +1396,9 @@ static int pch_spi_pd_probe(struct platform_device *plat_dev)
 
 	if (use_dma) {
 		dev_info(&plat_dev->dev, "Use DMA for data transfers\n");
-		pch_alloc_dma_buf(board_dat, data);
+		ret = pch_alloc_dma_buf(board_dat, data);
+		if (ret)
+			goto err_spi_register_master;
 	}
 
 	ret = spi_register_master(master);
-- 
2.17.1

