Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9426EC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 06:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65522205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 06:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbfI2Gyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 02:54:35 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:50376 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725906AbfI2Gyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 02:54:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01451;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Tdgp2DH_1569740065;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0Tdgp2DH_1569740065)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 29 Sep 2019 14:54:32 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        davem@davemloft.net
Cc:     xlpang@linux.alibaba.com, zhiche.yy@alibaba-inc.com,
        Wen Yang <wenyang@linux.alibaba.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: mscc: ocelot: add missing of_node_put after calling of_get_child_by_name
Date:   Sun, 29 Sep 2019 14:54:24 +0800
Message-Id: <20190929065424.2437-1-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_node_put needs to be called when the device node which is got
from of_get_child_by_name finished using.
In both cases of success and failure, we need to release 'ports',
so clean up the code using goto.

fixes: a556c76adc05 ("net: mscc: Add initial Ocelot switch support")
Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/ethernet/mscc/ocelot_board.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_board.c b/drivers/net/ethernet/mscc/ocelot_board.c
index b063eb7..aac1151 100644
--- a/drivers/net/ethernet/mscc/ocelot_board.c
+++ b/drivers/net/ethernet/mscc/ocelot_board.c
@@ -388,13 +388,14 @@ static int mscc_ocelot_probe(struct platform_device *pdev)
 			continue;
 
 		phy = of_phy_find_device(phy_node);
+		of_node_put(phy_node);
 		if (!phy)
 			continue;
 
 		err = ocelot_probe_port(ocelot, port, regs, phy);
 		if (err) {
 			of_node_put(portnp);
-			return err;
+			goto out_put_ports;
 		}
 
 		phy_mode = of_get_phy_mode(portnp);
@@ -422,7 +423,8 @@ static int mscc_ocelot_probe(struct platform_device *pdev)
 				"invalid phy mode for port%d, (Q)SGMII only\n",
 				port);
 			of_node_put(portnp);
-			return -EINVAL;
+			err = -EINVAL;
+			goto out_put_ports;
 		}
 
 		serdes = devm_of_phy_get(ocelot->dev, portnp, NULL);
@@ -435,7 +437,8 @@ static int mscc_ocelot_probe(struct platform_device *pdev)
 					"missing SerDes phys for port%d\n",
 					port);
 
-			goto err_probe_ports;
+			of_node_put(portnp);
+			goto out_put_ports;
 		}
 
 		ocelot->ports[port]->serdes = serdes;
@@ -447,9 +450,8 @@ static int mscc_ocelot_probe(struct platform_device *pdev)
 
 	dev_info(&pdev->dev, "Ocelot switch probed\n");
 
-	return 0;
-
-err_probe_ports:
+out_put_ports:
+	of_node_put(ports);
 	return err;
 }
 
-- 
1.8.3.1

