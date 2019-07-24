Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CB6C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090BF229FA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563996642;
	bh=eCYjIyDM/jcflqiRqencvb4jCEnsdmoqDhxKfRDM8Lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J3zdzkzUacKXWcudwk+ANRSXrPd11uR+BMNLq/7wWvmckT+EZ2kRW6GXi7fuo6UP/
	 Ku3cvxT9BzvllhM6u/OjvrWkdO/qfw05CdxbXUMNowSm3Dtp39J0wpP6eI+bjP2zxL
	 VGUHCqiZS9piuZJ2ji4ztKoa7kJ/qrJ7pTV10D1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387394AbfGXTak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:30:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388383AbfGXTah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:30:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44A45229F3;
        Wed, 24 Jul 2019 19:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996635;
        bh=eCYjIyDM/jcflqiRqencvb4jCEnsdmoqDhxKfRDM8Lo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aYo5m6hw93R4e2X8S3RH3YpjYnueSvxAXcQNMG8KYwzAmaOaI0wV36U/wk2gTNL8Y
         ag1xkb26mxUa1ebo2IFeP5CL1adzh3vwW0KAL1bILBg3Nw/ALn4hEJ17+6GU8SHlaS
         zYuL1WvzFy2FTIWnYo/jWV8J+hs0J3KY4tfdJkpg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 124/413] net: netsec: initialize tx ring on ndo_open
Date:   Wed, 24 Jul 2019 21:16:55 +0200
Message-Id: <20190724191744.034549270@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 39e3622edeffa63c2871153d8743c5825b139968 ]

Since we changed the Tx ring handling and now depends on bit31 to figure
out the owner of the descriptor, we should initialize this every time
the device goes down-up instead of doing it once on driver init. If the
value is not correctly initialized the device won't have any available
descriptors

Changes since v1:
- Typo fixes

Fixes: 35e07d234739 ("net: socionext: remove mmio reads on Tx")
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/socionext/netsec.c | 32 ++++++++++++++-----------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
index cba5881b2746..a10ef700f16d 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -1029,7 +1029,6 @@ static void netsec_free_dring(struct netsec_priv *priv, int id)
 static int netsec_alloc_dring(struct netsec_priv *priv, enum ring_id id)
 {
 	struct netsec_desc_ring *dring = &priv->desc_ring[id];
-	int i;
 
 	dring->vaddr = dma_alloc_coherent(priv->dev, DESC_SZ * DESC_NUM,
 					  &dring->desc_dma, GFP_KERNEL);
@@ -1040,19 +1039,6 @@ static int netsec_alloc_dring(struct netsec_priv *priv, enum ring_id id)
 	if (!dring->desc)
 		goto err;
 
-	if (id == NETSEC_RING_TX) {
-		for (i = 0; i < DESC_NUM; i++) {
-			struct netsec_de *de;
-
-			de = dring->vaddr + (DESC_SZ * i);
-			/* de->attr is not going to be accessed by the NIC
-			 * until netsec_set_tx_de() is called.
-			 * No need for a dma_wmb() here
-			 */
-			de->attr = 1U << NETSEC_TX_SHIFT_OWN_FIELD;
-		}
-	}
-
 	return 0;
 err:
 	netsec_free_dring(priv, id);
@@ -1060,6 +1046,23 @@ static int netsec_alloc_dring(struct netsec_priv *priv, enum ring_id id)
 	return -ENOMEM;
 }
 
+static void netsec_setup_tx_dring(struct netsec_priv *priv)
+{
+	struct netsec_desc_ring *dring = &priv->desc_ring[NETSEC_RING_TX];
+	int i;
+
+	for (i = 0; i < DESC_NUM; i++) {
+		struct netsec_de *de;
+
+		de = dring->vaddr + (DESC_SZ * i);
+		/* de->attr is not going to be accessed by the NIC
+		 * until netsec_set_tx_de() is called.
+		 * No need for a dma_wmb() here
+		 */
+		de->attr = 1U << NETSEC_TX_SHIFT_OWN_FIELD;
+	}
+}
+
 static int netsec_setup_rx_dring(struct netsec_priv *priv)
 {
 	struct netsec_desc_ring *dring = &priv->desc_ring[NETSEC_RING_RX];
@@ -1361,6 +1364,7 @@ static int netsec_netdev_open(struct net_device *ndev)
 
 	pm_runtime_get_sync(priv->dev);
 
+	netsec_setup_tx_dring(priv);
 	ret = netsec_setup_rx_dring(priv);
 	if (ret) {
 		netif_err(priv, probe, priv->ndev,
-- 
2.20.1



