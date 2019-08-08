Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D0BC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9298214C6
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565291596;
	bh=Qcy+4RkCqsyk7y3ye2bsGhK/Mc7XEY6y2lFVcBCGoZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c+EKy1bMlGZB3uXB6FVtaF9+nrZM4es3YEshkz/ImpLJdMyUijqVQUaf+CEHjO35g
	 +ldeeS2TPPwzSQesFF3IfCFr31DXrNWnzjs3aw86OMhQ942nMOQvwY31g+YhKpetEZ
	 1nNALwwdPdEJF5zPNnkFx2XnxP9cBZc9kc7ka8tI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405243AbfHHTKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:10:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404830AbfHHTKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:10:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD25E21743;
        Thu,  8 Aug 2019 19:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565291406;
        bh=Qcy+4RkCqsyk7y3ye2bsGhK/Mc7XEY6y2lFVcBCGoZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X93JVPUdWm3iqzrSg+w8lt4LMDLnfl4B0xvCFVp616uWBkOheTnJ/3G9oQBksVIjs
         QWo5V0PLhzsXF0AJB25P+YEV1a/oigxObGQRWDZW112unKERqSjX4c3Z1bYxVT4Pxz
         Dqoly5EVRe6+NVErQGh/yxQfc7TLX8FtOAUalOPA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matteo Croce <mcroce@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 20/45] mvpp2: refactor MTU change code
Date:   Thu,  8 Aug 2019 21:05:06 +0200
Message-Id: <20190808190454.862440748@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808190453.827571908@linuxfoundation.org>
References: <20190808190453.827571908@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@redhat.com>

[ Upstream commit 230bd958c2c846ee292aa38bc6b006296c24ca01 ]

The MTU change code can call napi_disable() with the device already down,
leading to a deadlock. Also, lot of code is duplicated unnecessarily.

Rework mvpp2_change_mtu() to avoid the deadlock and remove duplicated code.

Fixes: 3f518509dedc ("ethernet: Add new driver for Marvell Armada 375 network unit")
Signed-off-by: Matteo Croce <mcroce@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c |   41 +++++++-----------------
 1 file changed, 13 insertions(+), 28 deletions(-)

--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3501,6 +3501,7 @@ static int mvpp2_set_mac_address(struct
 static int mvpp2_change_mtu(struct net_device *dev, int mtu)
 {
 	struct mvpp2_port *port = netdev_priv(dev);
+	bool running = netif_running(dev);
 	int err;
 
 	if (!IS_ALIGNED(MVPP2_RX_PKT_SIZE(mtu), 8)) {
@@ -3509,40 +3510,24 @@ static int mvpp2_change_mtu(struct net_d
 		mtu = ALIGN(MVPP2_RX_PKT_SIZE(mtu), 8);
 	}
 
-	if (!netif_running(dev)) {
-		err = mvpp2_bm_update_mtu(dev, mtu);
-		if (!err) {
-			port->pkt_size =  MVPP2_RX_PKT_SIZE(mtu);
-			return 0;
-		}
+	if (running)
+		mvpp2_stop_dev(port);
 
+	err = mvpp2_bm_update_mtu(dev, mtu);
+	if (err) {
+		netdev_err(dev, "failed to change MTU\n");
 		/* Reconfigure BM to the original MTU */
-		err = mvpp2_bm_update_mtu(dev, dev->mtu);
-		if (err)
-			goto log_error;
+		mvpp2_bm_update_mtu(dev, dev->mtu);
+	} else {
+		port->pkt_size =  MVPP2_RX_PKT_SIZE(mtu);
 	}
 
-	mvpp2_stop_dev(port);
-
-	err = mvpp2_bm_update_mtu(dev, mtu);
-	if (!err) {
-		port->pkt_size =  MVPP2_RX_PKT_SIZE(mtu);
-		goto out_start;
+	if (running) {
+		mvpp2_start_dev(port);
+		mvpp2_egress_enable(port);
+		mvpp2_ingress_enable(port);
 	}
 
-	/* Reconfigure BM to the original MTU */
-	err = mvpp2_bm_update_mtu(dev, dev->mtu);
-	if (err)
-		goto log_error;
-
-out_start:
-	mvpp2_start_dev(port);
-	mvpp2_egress_enable(port);
-	mvpp2_ingress_enable(port);
-
-	return 0;
-log_error:
-	netdev_err(dev, "failed to change MTU\n");
 	return err;
 }
 


