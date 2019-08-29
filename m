Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E7AC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACF82166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567102714;
	bh=D22k3r46Zb5QFczzA77YHEXHotFNIJZqhiXYajFYR64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WZPSLy2LMUfxqpLdVWmyRAKjMRZ27loBq14P+ErNYfVGN3ofVvHp7JWmnT6hH3Cd4
	 1I7ZrJ+leGT49f2zUDpSZ65wytH3Hn7fhECyQ7N0LYvc9v0Yo8ZKoQKI0mqkyCUCLF
	 JFOxn198xwTNB+p7RUojObly8ZpvEzNNoYKCF1FU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbfH2SSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:18:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730389AbfH2SSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:18:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13FCD2339E;
        Thu, 29 Aug 2019 18:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102696;
        bh=D22k3r46Zb5QFczzA77YHEXHotFNIJZqhiXYajFYR64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QkfoT6ZYcCgLJ7GTbcs+EVasaEUYLhQlToffyJA9Pi3OEY6kiu5MkrvHbZuFQW68K
         V7GgSf3ncX+hgq94wQ/BDwOUj/xL4od5PFcPDZ8OcdAdTaAjnzS2p/4oWNLgpnIxuo
         Xxy2vQVkxGJJUdUJ/uuyHfm0DFviKmryocDjZEes=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tho Vu <tho.vu.wh@rvc.renesas.com>,
        Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-sh@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 11/15] ravb: Fix use-after-free ravb_tstamp_skb
Date:   Thu, 29 Aug 2019 14:17:58 -0400
Message-Id: <20190829181802.9619-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181802.9619-1-sashal@kernel.org>
References: <20190829181802.9619-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tho Vu <tho.vu.wh@rvc.renesas.com>

[ Upstream commit cfef46d692efd852a0da6803f920cc756eea2855 ]

When a Tx timestamp is requested, a pointer to the skb is stored in the
ravb_tstamp_skb struct. This was done without an skb_get. There exists
the possibility that the skb could be freed by ravb_tx_free (when
ravb_tx_free is called from ravb_start_xmit) before the timestamp was
processed, leading to a use-after-free bug.

Use skb_get when filling a ravb_tstamp_skb struct, and add appropriate
frees/consumes when a ravb_tstamp_skb struct is freed.

Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
Signed-off-by: Tho Vu <tho.vu.wh@rvc.renesas.com>
Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/renesas/ravb_main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 29d31eb995d7f..fedfd94699cb8 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1,6 +1,6 @@
 /* Renesas Ethernet AVB device driver
  *
- * Copyright (C) 2014-2015 Renesas Electronics Corporation
+ * Copyright (C) 2014-2019 Renesas Electronics Corporation
  * Copyright (C) 2015 Renesas Solutions Corp.
  * Copyright (C) 2015 Cogent Embedded, Inc. <source@cogentembedded.com>
  *
@@ -501,7 +501,10 @@ static void ravb_get_tx_tstamp(struct net_device *ndev)
 			kfree(ts_skb);
 			if (tag == tfa_tag) {
 				skb_tstamp_tx(skb, &shhwtstamps);
+				dev_consume_skb_any(skb);
 				break;
+			} else {
+				dev_kfree_skb_any(skb);
 			}
 		}
 		ravb_write(ndev, ravb_read(ndev, TCCR) | TCCR_TFR, TCCR);
@@ -1382,7 +1385,7 @@ static netdev_tx_t ravb_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 					 DMA_TO_DEVICE);
 			goto unmap;
 		}
-		ts_skb->skb = skb;
+		ts_skb->skb = skb_get(skb);
 		ts_skb->tag = priv->ts_skb_tag++;
 		priv->ts_skb_tag &= 0x3ff;
 		list_add_tail(&ts_skb->list, &priv->ts_skb_list);
@@ -1514,6 +1517,7 @@ static int ravb_close(struct net_device *ndev)
 	/* Clear the timestamp list */
 	list_for_each_entry_safe(ts_skb, ts_skb2, &priv->ts_skb_list, list) {
 		list_del(&ts_skb->list);
+		kfree_skb(ts_skb->skb);
 		kfree(ts_skb);
 	}
 
-- 
2.20.1

