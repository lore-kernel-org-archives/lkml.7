Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058ABC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58B622527
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077626;
	bh=QRIx0vxWTbHAWziDstpDUXNhVnzbNZ00Ted2OA/utF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DUH2E63ehmg75atflQRdn2U4kqmT3WgLy6dSO46KUb1q/Lqd7EA1+M9pGvUfBNCrR
	 eCm6FaL9THXs40SBhw7KYPoe6ubeyTZ3UVXZE8+t2l7PRAKWgRdIFI5YWuaW0Tij9x
	 vGQlfjlNvwg71W3j/qEidA5r3xKNBQyzMgQzRFl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732336AbfLKPUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:20:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:49634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732325AbfLKPUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:20:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 032592073D;
        Wed, 11 Dec 2019 15:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077622;
        bh=QRIx0vxWTbHAWziDstpDUXNhVnzbNZ00Ted2OA/utF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UfGrXmoawe6/shTbTMNN1brOtERzQIZVbTbZCuLE5B2f1KFqzC/lFOk9I5pnxaeMm
         iOQ9OMFJc1ESfy+CJvbeHw/X61+3/cNnaPMw0mnJvX6UtqzJoP4U1YKhbYBWWCv1wL
         bGJWUOFJMTU8U5k+bG/SUhpn/fkhz+anCYPp/cx4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xue Chaojing <xuechaojing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 071/243] net-next/hinic:fix a bug in set mac address
Date:   Wed, 11 Dec 2019 16:03:53 +0100
Message-Id: <20191211150343.895499811@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xue Chaojing <xuechaojing@huawei.com>

[ Upstream commit 9ea72dc9430306b77c73a8a21beb51437cde1d6d ]

In add_mac_addr(), if the MAC address is a muliticast address,
it will not be set, which causes the network card fail to receive
the multicast packet. This patch fixes this bug.

Signed-off-by: Xue Chaojing <xuechaojing@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/huawei/hinic/hinic_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_main.c b/drivers/net/ethernet/huawei/hinic/hinic_main.c
index 4a8f82938ed5b..2352046971a4e 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_main.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_main.c
@@ -600,9 +600,6 @@ static int add_mac_addr(struct net_device *netdev, const u8 *addr)
 	u16 vid = 0;
 	int err;
 
-	if (!is_valid_ether_addr(addr))
-		return -EADDRNOTAVAIL;
-
 	netif_info(nic_dev, drv, netdev, "set mac addr = %02x %02x %02x %02x %02x %02x\n",
 		   addr[0], addr[1], addr[2], addr[3], addr[4], addr[5]);
 
@@ -726,6 +723,7 @@ static void set_rx_mode(struct work_struct *work)
 {
 	struct hinic_rx_mode_work *rx_mode_work = work_to_rx_mode_work(work);
 	struct hinic_dev *nic_dev = rx_mode_work_to_nic_dev(rx_mode_work);
+	struct netdev_hw_addr *ha;
 
 	netif_info(nic_dev, drv, nic_dev->netdev, "set rx mode work\n");
 
@@ -733,6 +731,9 @@ static void set_rx_mode(struct work_struct *work)
 
 	__dev_uc_sync(nic_dev->netdev, add_mac_addr, remove_mac_addr);
 	__dev_mc_sync(nic_dev->netdev, add_mac_addr, remove_mac_addr);
+
+	netdev_for_each_mc_addr(ha, nic_dev->netdev)
+		add_mac_addr(nic_dev->netdev, ha->addr);
 }
 
 static void hinic_set_rx_mode(struct net_device *netdev)
-- 
2.20.1



