Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6666BC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 05:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D36C21473
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 05:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfDIFsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 01:48:17 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:41586 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727222AbfDIFsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 01:48:14 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 0CB2B7FDEBDDE21AAFC2;
        Tue,  9 Apr 2019 13:48:12 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x395m6pE046078;
        Tue, 9 Apr 2019 13:48:06 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019040913482157-7975998 ;
          Tue, 9 Apr 2019 13:48:21 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Markus Elfring <Markus.Elfring@web.de>,
        Wingman Kwok <w-kwok2@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org (open list:TI NETCP ETHERNET DRIVER)
Subject: [PATCH 2/2] net: ethernet: ti: eliminated some duplicate code.
Date:   Tue, 9 Apr 2019 13:48:01 +0800
Message-Id: <1554788881-22647-2-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1554788881-22647-1-git-send-email-wen.yang99@zte.com.cn>
References: <1554788881-22647-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-04-09 13:48:21,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-04-09 13:48:04,
        Serialize complete at 2019-04-09 13:48:04
X-MAIL: mse01.zte.com.cn x395m6pE046078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put the code that obtains device_node and the code that
uses it tightly together to remove duplicate resource
cleanup statements between them.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Reported-by: Markus Elfring <Markus.Elfring@web.de>
Cc: Markus Elfring <Markus.Elfring@web.de>
Cc: Wingman Kwok <w-kwok2@ti.com> (maintainer:TI NETCP ETHERNET DRIVER)
Cc: Murali Karicheri <m-karicheri2@ti.com> (maintainer:TI NETCP ETHERNET DRIVER)
Cc: "David S. Miller" <davem@davemloft.net> (odd fixer:NETWORKING DRIVERS)
Cc: netdev@vger.kernel.org (open list:TI NETCP ETHERNET DRIVER)
Cc: linux-kernel@vger.kernel.org (open list)
---
 drivers/net/ethernet/ti/netcp_ethss.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
index 0a920c5..748116a 100644
--- a/drivers/net/ethernet/ti/netcp_ethss.c
+++ b/drivers/net/ethernet/ti/netcp_ethss.c
@@ -3651,22 +3651,18 @@ static int gbe_probe(struct netcp_device *netcp_device, struct device *dev,
 	if (ret)
 		return ret;
 
-	interfaces = of_get_child_by_name(node, "interfaces");
-	if (!interfaces)
-		dev_err(dev, "could not find interfaces\n");
-
 	ret = netcp_txpipe_init(&gbe_dev->tx_pipe, netcp_device,
 				gbe_dev->dma_chan_name, gbe_dev->tx_queue_id);
-	if (ret) {
-		of_node_put(interfaces);
+	if (ret)
 		return ret;
-	}
 
 	ret = netcp_txpipe_open(&gbe_dev->tx_pipe);
-	if (ret) {
-		of_node_put(interfaces);
+	if (ret)
 		return ret;
-	}
+
+	interfaces = of_get_child_by_name(node, "interfaces");
+	if (!interfaces)
+		dev_err(dev, "could not find interfaces\n");
 
 	/* Create network interfaces */
 	INIT_LIST_HEAD(&gbe_dev->gbe_intf_head);
-- 
2.9.5

