Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F182C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2245F21775
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576518721;
	bh=rt0gZO6uMKEjHQN3gy5iVI2W98TuSbkRFdUgSTYAts4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vG6PZ6eGZZPt/MFbTvIx3qQ4q+hoQJEDxZo0nx0l2u6Bsc3UNRGbFSy04z2OzYVDS
	 MnK2jUwc4JQjELW/WoYy0A2DjmsmdqW3DH/CIVgpkzHkIZR+RD+Eh2cIsUno/TgMde
	 2T8/taXIGmCPNauDrgdy4coeTINOahwy21lr9gNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfLPRwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:52:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:42828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbfLPRv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:51:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5823021775;
        Mon, 16 Dec 2019 17:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518716;
        bh=rt0gZO6uMKEjHQN3gy5iVI2W98TuSbkRFdUgSTYAts4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r837HXnW1ZuU9KKf1oAvvs2pcSFsfSFztmhRTRvfy716ii68Twf5fvyMl/ojY9ag9
         JX/ij2GNLRfzrjlPRGfRBHUMomUiMHFsY049THyPQh8+6jIP8QHtusxOs2sWOGolm0
         OgVfBqNuyav4JTVLeLkhB5BuKgbzr8AEHauElcEc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 020/267] net: ep93xx_eth: fix mismatch of request_mem_region in remove
Date:   Mon, 16 Dec 2019 18:45:46 +0100
Message-Id: <20191216174851.211492139@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

[ Upstream commit 3df70afe8d33f4977d0e0891bdcfb639320b5257 ]

The driver calls release_resource in remove to match request_mem_region
in probe, which is incorrect.
Fix it by using the right one, release_mem_region.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cirrus/ep93xx_eth.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cirrus/ep93xx_eth.c b/drivers/net/ethernet/cirrus/ep93xx_eth.c
index e2a702996db41..82bd918bf967f 100644
--- a/drivers/net/ethernet/cirrus/ep93xx_eth.c
+++ b/drivers/net/ethernet/cirrus/ep93xx_eth.c
@@ -767,6 +767,7 @@ static int ep93xx_eth_remove(struct platform_device *pdev)
 {
 	struct net_device *dev;
 	struct ep93xx_priv *ep;
+	struct resource *mem;
 
 	dev = platform_get_drvdata(pdev);
 	if (dev == NULL)
@@ -782,8 +783,8 @@ static int ep93xx_eth_remove(struct platform_device *pdev)
 		iounmap(ep->base_addr);
 
 	if (ep->res != NULL) {
-		release_resource(ep->res);
-		kfree(ep->res);
+		mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		release_mem_region(mem->start, resource_size(mem));
 	}
 
 	free_netdev(dev);
-- 
2.20.1



