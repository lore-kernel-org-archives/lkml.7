Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7B3C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17794217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563202032;
	bh=qR146ivIQwhvLYQVXcYFs2DrnYiY9L6a2Ox+hVENN9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LT6z/HUhyTzsJSpy3vScVVZmQ8PhZ7d4xfUhGXQwdwZou1OpKllj4GthJTO99h5Mg
	 LlQsDetLIJF7FGQtFAsqPNNh5E098zaWdukEm9K18wwLH1kZxURTz3oFXE/NR6vwgD
	 FMuNu/uW4SbySID5KSxXXVLbi5Z2GrB3Q3k9wlyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404168AbfGOOrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:47:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:39912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405130AbfGOOq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:46:57 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88B2120651;
        Mon, 15 Jul 2019 14:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563202016;
        bh=qR146ivIQwhvLYQVXcYFs2DrnYiY9L6a2Ox+hVENN9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1KWw6/dfQQPtGL5p7tYcN+T/++7zJ2MOpKgVdlvyyYN00AyIKmXBp2tEWr6hm7yHi
         r773PMAqo6mFXjoyn36yOMYv3s3RdxK5hxdkVYN5IDjleCgyEZlmNANMSK7oySGa6S
         TkzWsaDm0EOU8y12uDq7cgUcJ03pV4Z6WB7gIvB0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 22/53] net: fec: Do not use netdev messages too early
Date:   Mon, 15 Jul 2019 10:45:04 -0400
Message-Id: <20190715144535.11636-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715144535.11636-1-sashal@kernel.org>
References: <20190715144535.11636-1-sashal@kernel.org>
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
index ae8e4fc22e7b..0ee164d09f39 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1699,10 +1699,10 @@ static void fec_get_mac(struct net_device *ndev)
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

