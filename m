Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599C0C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFA8212F5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563198666;
	bh=V7/RbqCX1YhchHKhMe9qWX6100K5iWkhdr8+rSnHO7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mJSSEWNOxIM5qtYJHso/D1HqFYIvsl6M3Y460fsQ8mLBB+wcnmYXByJiDN2gQeLZm
	 7tAgoqpXLBmawCnt6037SPVB45Rz6NL2edHhn59DE6IkPHEAwyzlc5pvC0P1PXmWmN
	 aiyOc0i3eAPOzxtvZJLALs3YJqfDeSjQMl3vDnY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731818AbfGONvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:51:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731621AbfGONvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:51:00 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D1E62081C;
        Mon, 15 Jul 2019 13:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563198659;
        bh=V7/RbqCX1YhchHKhMe9qWX6100K5iWkhdr8+rSnHO7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CzHdxMofD2WvIswbRrmKTdVv3RLl0rHMNUAnQuRjdjnWjQGAXnOKEMRrbSqdbZslL
         j8r7npN6MUG4guyucaSE+5PmekTiDWOtjX08KsTMDQssXbs5Zj9A6pZlUrpQIYsgdv
         gpiXQqBRtWqzAFAjK8HXSVKfqJvAk7l6Y8fXzydk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 075/249] net: fec: Do not use netdev messages too early
Date:   Mon, 15 Jul 2019 09:44:00 -0400
Message-Id: <20190715134655.4076-75-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134655.4076-1-sashal@kernel.org>
References: <20190715134655.4076-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

[ Upstream commit a19a0582363b9a5f8ba812f34f1b8df394898780 ]

When a valid MAC address is not found the current messages
are shown:

fec 2188000.ethernet (unnamed net_device) (uninitialized): Invalid MAC address: 00:00:00:00:00:00
fec 2188000.ethernet (unnamed net_device) (uninitialized): Using random MAC address: aa:9f:25:eb:7e:aa

Since the network device has not been registered at this point, it is better
to use dev_err()/dev_info() instead, which will provide cleaner log
messages like these:

fec 2188000.ethernet: Invalid MAC address: 00:00:00:00:00:00
fec 2188000.ethernet: Using random MAC address: aa:9f:25:eb:7e:aa

Tested on a imx6dl-pico-pi board.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fec_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 38f10f7dcbc3..831bb709e783 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1689,10 +1689,10 @@ static void fec_get_mac(struct net_device *ndev)
 	 */
 	if (!is_valid_ether_addr(iap)) {
 		/* Report it and use a random ethernet address instead */
-		netdev_err(ndev, "Invalid MAC address: %pM\n", iap);
+		dev_err(&fep->pdev->dev, "Invalid MAC address: %pM\n", iap);
 		eth_hw_addr_random(ndev);
-		netdev_info(ndev, "Using random MAC address: %pM\n",
-			    ndev->dev_addr);
+		dev_info(&fep->pdev->dev, "Using random MAC address: %pM\n",
+			 ndev->dev_addr);
 		return;
 	}
 
-- 
2.20.1

