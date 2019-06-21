Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAB3C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFA02075E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbfFUPaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 11:30:05 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:48095 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfFUPaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:30:05 -0400
X-Originating-IP: 90.88.16.156
Received: from localhost (aaubervilliers-681-1-41-156.w90-88.abo.wanadoo.fr [90.88.16.156])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id D4C076000D;
        Fri, 21 Jun 2019 15:30:01 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, nicolas.ferre@microchip.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ludovic.desroches@microchip.com, alexandre.belloni@bootlin.com
Subject: [PATCH net] net: macb: do not copy the mac address if NULL
Date:   Fri, 21 Jun 2019 17:26:35 +0200
Message-Id: <20190621152635.29689-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the MAC address setup in the probe. The MAC address
retrieved using of_get_mac_address was checked for not containing an
error, but it may also be NULL which wasn't tested. Fix it by replacing
IS_ERR with IS_ERR_OR_NULL.

Fixes: 541ddc66d665 ("net: macb: support of_get_mac_address new ERR_PTR error")
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 1241a2a73438..1cd1f2c36d6f 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4304,7 +4304,7 @@ static int macb_probe(struct platform_device *pdev)
 	if (PTR_ERR(mac) == -EPROBE_DEFER) {
 		err = -EPROBE_DEFER;
 		goto err_out_free_netdev;
-	} else if (!IS_ERR(mac)) {
+	} else if (!IS_ERR_OR_NULL(mac)) {
 		ether_addr_copy(bp->dev->dev_addr, mac);
 	} else {
 		macb_get_hwaddr(bp);
-- 
2.21.0

