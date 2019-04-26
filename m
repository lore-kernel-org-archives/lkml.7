Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FEDC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3C720684
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="hdsOklcY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfDZHky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:40:54 -0400
Received: from first.geanix.com ([116.203.34.67]:59674 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfDZHkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 03:40:09 -0400
Received: from localhost (unknown [193.163.1.7])
        by first.geanix.com (Postfix) with ESMTPSA id DF28E308E6A;
        Fri, 26 Apr 2019 07:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1556263922; bh=jata0gS+b58PoHcR/CW2gpAhHvZ0Y9BcaAX0xDtVHQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hdsOklcYIGQGxetJ6/da4dG0+pgr/em8/ppV+9xGcv8amFpYoOkz5eLSEoggWN33x
         VFu0dL1CZyV88Dlvbj6ymQGwyMBp1uHXEF7fAeyP3RSjA/DpwBarhndI7gCW6S/oAl
         BFsSbO1MTp+jw4Z8dlaIaM/EWVeyIkgLxNimFZ2PnHkGYZS2H7Ppzyd1+eCt34urxj
         7MU8Sv3SDIVRhb9s7y7QQjZfg5WviuG7KzyHpe0hffdHcHdzXoBZ22AfSZ4UonEHqP
         EwlhldwkYLlK+TBLATPa77tqREtZPITGfuhUDPMud4c3ieimRfVrZy+tEPxx40H4g3
         /wJWbQ8iQUCcA==
From:   Esben Haabendal <esben@geanix.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Yang Wei <yang.wei9@zte.com.cn>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] net: ll_temac: Fix bug causing buffer descriptor overrun
Date:   Fri, 26 Apr 2019 09:32:28 +0200
Message-Id: <20190426073231.4008-10-esben@geanix.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190426073231.4008-1-esben@geanix.com>
References: <20190426073231.4008-1-esben@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we are actually using a BD for both the skb and each frag contained in
it, the oldest TX BD would be overwritten when there was exactly one BD
less than needed.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/net/ethernet/xilinx/ll_temac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index 56d8077..def3886 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -745,7 +745,7 @@ temac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	start_p = lp->tx_bd_p + sizeof(*lp->tx_bd_v) * lp->tx_bd_tail;
 	cur_p = &lp->tx_bd_v[lp->tx_bd_tail];
 
-	if (temac_check_tx_bd_space(lp, num_frag)) {
+	if (temac_check_tx_bd_space(lp, num_frag + 1)) {
 		if (!netif_queue_stopped(ndev))
 			netif_stop_queue(ndev);
 		return NETDEV_TX_BUSY;
-- 
2.4.11

