Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5FAC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F3F21874
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565291183;
	bh=J+cRS0pPH6TjuP/mNcXIclG01o0N65mVi/1OxkSjt+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WVs8VkTKpGUIiXTc9jFbNfoLjv9Bpdy1ukfOPYMkf6V6U2xlN0c4kw/K3T144XE8P
	 fs5YoRGoHLtpF4akUux3aqAkx2x1nNOQyyvcnabKLtRvAHsIIIBRBQNPmgXbnQxFAU
	 RylkpZrL96/bnDDkTxJudNJdlp0qn7e8KBAu95fM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404397AbfHHTGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:06:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404374AbfHHTGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:06:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1326F21880;
        Thu,  8 Aug 2019 19:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565291179;
        bh=J+cRS0pPH6TjuP/mNcXIclG01o0N65mVi/1OxkSjt+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zFrO4Br12yXdeHsnIxagp1I3UggLnByxWyBWsx8rR4FdSkVHy5uNNVPUle7hTjke1
         TLwzbLAdz/xKW3rFawpwWEXVERXGuFHMTD39bzeeNzwOkNO8mNzvkC+MeZ2UvuJebv
         v7H+hL7GIBkLTwGBRDWINW+IsJ7f38CwFOJkUhn0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matteo Croce <mcroce@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 17/56] mvpp2: refactor MTU change code
Date:   Thu,  8 Aug 2019 21:04:43 +0200
Message-Id: <20190808190453.539040073@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808190452.867062037@linuxfoundation.org>
References: <20190808190452.867062037@linuxfoundation.org>
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
@@ -3609,6 +3609,7 @@ static int mvpp2_set_mac_address(struct
 static int mvpp2_change_mtu(struct net_device *dev, int mtu)
 {
 	struct mvpp2_port *port = netdev_priv(dev);
+	bool running = netif_running(dev);
 	int err;
 
 	if (!IS_ALIGNED(MVPP2_RX_PKT_SIZE(mtu), 8)) {
@@ -3617,40 +3618,24 @@ static int mvpp2_change_mtu(struct net_d
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
 


