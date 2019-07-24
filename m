Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CA9C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886A32054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564000508;
	bh=D1ImSPYYb7rvJrA9L8FdYS8eG3GasbQG6P3ud3fBYWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vk9G9omKsBlCfsTa4AsGzyWqzGorRdS6bHMx+iG1Pm72PHBt7W7ISL9/CvARcO9nH
	 Xvjfr1FVw/2+ow2uFfIgiSHp9OaNl1ar6QotCw8NGBjNvv8wluX0QKfnSKcYeifsiO
	 hv7k3iuhQpzk4UZfIx0PYmrJFMFYof/5gdDsl6qk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390298AbfGXUfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387576AbfGXT0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:26:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 860FF2238C;
        Wed, 24 Jul 2019 19:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996373;
        bh=D1ImSPYYb7rvJrA9L8FdYS8eG3GasbQG6P3ud3fBYWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HOzNjfAZzvfKJ18YBj5EAcyOXXxCWPLsMw7TueBRXCV9GMzOczSS5WCWZOK3Yfz32
         0HR9kb/lqUH9tzH7GI0WyPuOuUap5faBl6/6tcFnpLQFXHH73s0AJRDMLGRRKPPZOn
         ru3sKXoo9BnuUGzR6Yd5proRK+9eK0DFO6pHp9Gw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 072/413] net: fec: Do not use netdev messages too early
Date:   Wed, 24 Jul 2019 21:16:03 +0200
Message-Id: <20190724191740.257055985@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



