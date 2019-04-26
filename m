Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9292BC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBF3212F5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="j1NIMlE/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfDZRNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:13:08 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47752 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfDZRNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:13:04 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3QHD0hW072452;
        Fri, 26 Apr 2019 12:13:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556298780;
        bh=95yxaG9sedTBg4t8LtXgLgWbi9p7IkLXNVqsPK50T4g=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=j1NIMlE/pqwp5gjMO4pQ6bIiw6qZIBLjr+QP9Aghqw3hNFUXZsDmUQIjPuM80Zooq
         8JE+Bu+dV2LxEg+iguDub/TrZfV9bLZ+ADhgvdho7e9j/zTUqGktxyx87dQt//piDI
         gzdtJgMitBnfeMrxkxqiBIAb4v2B9pKQYviafpF8=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3QHD0QQ129818
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Apr 2019 12:13:00 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 26
 Apr 2019 12:13:00 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 26 Apr 2019 12:13:00 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3QHCxm3113328;
        Fri, 26 Apr 2019 12:13:00 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     <netdev@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next v2 08/20] net: ethernet: ti: cpsw: drop cpsw_tx_packet_submit()
Date:   Fri, 26 Apr 2019 20:12:30 +0300
Message-ID: <1556298762-8632-9-git-send-email-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
References: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop unnecessary wrapper function cpsw_tx_packet_submit() which is used
only in one place.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index ddc259c45481..4a26c72be0cc 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1500,17 +1500,6 @@ static void cpsw_get_ethtool_stats(struct net_device *ndev,
 	}
 }
 
-static inline int cpsw_tx_packet_submit(struct cpsw_priv *priv,
-					struct sk_buff *skb,
-					struct cpdma_chan *txch)
-{
-	struct cpsw_common *cpsw = priv->cpsw;
-
-	skb_tx_timestamp(skb);
-	return cpdma_chan_submit(txch, skb, skb->data, skb->len,
-				 priv->emac_port + cpsw->data.dual_emac);
-}
-
 static inline void cpsw_add_dual_emac_def_ale_entries(
 		struct cpsw_priv *priv, struct cpsw_slave *slave,
 		u32 slave_port)
@@ -2138,7 +2127,9 @@ static netdev_tx_t cpsw_ndo_start_xmit(struct sk_buff *skb,
 
 	txch = cpsw->txv[q_idx].ch;
 	txq = netdev_get_tx_queue(ndev, q_idx);
-	ret = cpsw_tx_packet_submit(priv, skb, txch);
+	skb_tx_timestamp(skb);
+	ret = cpdma_chan_submit(txch, skb, skb->data, skb->len,
+				priv->emac_port + cpsw->data.dual_emac);
 	if (unlikely(ret != 0)) {
 		cpsw_err(priv, tx_err, "desc submit failed\n");
 		goto fail;
-- 
2.17.1

