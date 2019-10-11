Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D0BECE596
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 18:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88EA5222D3
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 18:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570819718;
	bh=OTgrNLS53g8Rccfn5K0Ut7tIZlmbMatndfizupjVyyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Iq2J5h5MJiXTF+U/zYLwQrbI0LriuKcn+BZmsqsHjAyduT3nXplNU0uF0DMkaQy73
	 14EDz5cZ7l8RSIa83QfxhNS25p+gkRvXFrPsRgDFPe3y/E55zVRcRs8Jnm5JCPIt/I
	 N0WfznVyqu/new2rGnvH6ryOWbGZ46WBDfDcQC0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbfJKSsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 14:48:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728878AbfJKSsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 14:48:35 -0400
Received: from ziggy.de (unknown [37.223.145.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0677D21D7D;
        Fri, 11 Oct 2019 18:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570819715;
        bh=OTgrNLS53g8Rccfn5K0Ut7tIZlmbMatndfizupjVyyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g05iTO8bqc9Hw/bPhfJPhqHd2S/Wm/rU7uVAmBZFK7XabPCoP46nZvxGqaQ78Pc+y
         5WEMsFah3lJ+B40CYJYv56CgIRYNrrV/6OgUyGj2854IFl/WPJo9l4AfdwbaqluUH6
         6cdx7SJ3NZcTCZpowHc531St/uRnbnjTZeogUH5M=
From:   matthias.bgg@kernel.org
To:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Matthias Brugger <matthias.bgg@kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <wahrenst@gmx.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Doug Berger <opendmb@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v1 2/3] net: bcmgenet: use optional max DMA burst size property
Date:   Fri, 11 Oct 2019 20:48:20 +0200
Message-Id: <20191011184822.866-3-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011184822.866-1-matthias.bgg@kernel.org>
References: <20191011184822.866-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

Depending on the HW, the maximal usable DMA burst size can vary.
If not set accordingly a timeout in the transmit queue happens and no
package can be sent. Read to optional max-burst-sz property, if not
present, fallback to the standard value.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---

 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 13 +++++++++++--
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |  1 +
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 12cb77ef1081..a7bb822a6d83 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2576,7 +2576,8 @@ static int bcmgenet_init_dma(struct bcmgenet_priv *priv)
 	}
 
 	/* Init rDma */
-	bcmgenet_rdma_writel(priv, DMA_MAX_BURST_LENGTH, DMA_SCB_BURST_SIZE);
+	bcmgenet_rdma_writel(priv, priv->dma_max_burst_length,
+			     DMA_SCB_BURST_SIZE);
 
 	/* Initialize Rx queues */
 	ret = bcmgenet_init_rx_queues(priv->dev);
@@ -2589,7 +2590,8 @@ static int bcmgenet_init_dma(struct bcmgenet_priv *priv)
 	}
 
 	/* Init tDma */
-	bcmgenet_tdma_writel(priv, DMA_MAX_BURST_LENGTH, DMA_SCB_BURST_SIZE);
+	bcmgenet_tdma_writel(priv, priv->dma_max_burst_length,
+			     DMA_SCB_BURST_SIZE);
 
 	/* Initialize Tx queues */
 	bcmgenet_init_tx_queues(priv->dev);
@@ -3522,6 +3524,13 @@ static int bcmgenet_probe(struct platform_device *pdev)
 
 	clk_prepare_enable(priv->clk);
 
+	if (dn) {
+		of_property_read_u32(dn, "dma-burst-sz",
+				     &priv->dma_max_burst_length);
+	} else {
+		priv->dma_max_burst_length = DMA_MAX_BURST_LENGTH;
+	}
+
 	bcmgenet_set_hw_params(priv);
 
 	/* Mii wait queue */
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 4a8fc03d82fd..897f356eb376 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -663,6 +663,7 @@ struct bcmgenet_priv {
 	bool crc_fwd_en;
 
 	unsigned int dma_rx_chk_bit;
+	unsigned int dma_max_burst_length;
 
 	u32 msg_enable;
 
-- 
2.23.0

