Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD82C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D580424D7C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559188256;
	bh=5zpwOjDO1fpQzwqoXZLpNd3AB+Dz2aPEnFSCm18DBbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aa7o7i1pfwFtq49N2N38TaVddDmU0D0wwcL5vRvxop7FysBHqXl+WRw4iiuWKG3Bf
	 RBKtXwsQ8FTagQCJrCjpUmkraqMqdjQR+w3c1unf8Z94dPBPP3IK2UYj29V2/amst4
	 BtlLlNKGzp6S0DZ4SAJkH8ZUf78dn7XN3NYRxzvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfE3DTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:19:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730446AbfE3DPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:15:42 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F2F524585;
        Thu, 30 May 2019 03:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186141;
        bh=5zpwOjDO1fpQzwqoXZLpNd3AB+Dz2aPEnFSCm18DBbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nweUEK2UNPm0hgH4Ul449Lk2fmxrP86pUg9JO6v8vwXR8WHKYbjhZ+nWlZJseUYNH
         QfhRHBxZS8bQd5IpqPNPQJ1pG8BmjDap/WxNxqmExO/ek9aK8I78KG6iZM3v9MCNJu
         H5tZq7DdBSkQMwx+nnOFlJeV/DO3GbzKZrs3Z0X8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 317/346] spi : spi-topcliff-pch: Fix to handle empty DMA buffers
Date:   Wed, 29 May 2019 20:06:30 -0700
Message-Id: <20190530030556.868566279@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f37d8e67f39e6d3eaf4cc5471e8a3d21209843c6 ]

pch_alloc_dma_buf allocated tx, rx DMA buffers which can fail. Further,
these buffers are used without a check. The patch checks for these
failures and sends the error upstream.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-topcliff-pch.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 97d137591b18d..4389ab80c23e6 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1294,18 +1294,27 @@ static void pch_free_dma_buf(struct pch_spi_board_data *board_dat,
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
@@ -1382,7 +1391,9 @@ static int pch_spi_pd_probe(struct platform_device *plat_dev)
 
 	if (use_dma) {
 		dev_info(&plat_dev->dev, "Use DMA for data transfers\n");
-		pch_alloc_dma_buf(board_dat, data);
+		ret = pch_alloc_dma_buf(board_dat, data);
+		if (ret)
+			goto err_spi_register_master;
 	}
 
 	ret = spi_register_master(master);
-- 
2.20.1



