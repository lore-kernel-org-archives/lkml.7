Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9EFC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE06B20658
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574452337;
	bh=rt0gZO6uMKEjHQN3gy5iVI2W98TuSbkRFdUgSTYAts4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PQE5cxSl625SFpc/B47t52JDN/AzPeJxojsIHfmuZG7uqQKUJNnesrKmazqqcO0tA
	 MZMa1Wmb1waB24ixooqQbL4DUffN0njiJfJdBwcUHaLPnNMtWmEhbn7LZkv2IKWMST
	 /3vny18IEzOT7SD11XpsMm55EZddQWpX8BkDjfUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfKVTwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:52:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:50158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbfKVTty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 14:49:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7BB12073F;
        Fri, 22 Nov 2019 19:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574452193;
        bh=rt0gZO6uMKEjHQN3gy5iVI2W98TuSbkRFdUgSTYAts4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mJo7XAi30qxD0wR2Tm5smgjYp/TAUPWv1Wq/isaanrICW/1Bz3I/q3EvixIYQI7pg
         y6FsvoOzyCyKbW6/auAxWnUEG4qW+o7WkYIgKjyzzDutVaJ5ZXbW7sbHTp2hpqRo9L
         m/74MIFzp6RhGMAVYa2MacrZipsvqwAO67OfOIpQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 18/21] net: ep93xx_eth: fix mismatch of request_mem_region in remove
Date:   Fri, 22 Nov 2019 14:49:28 -0500
Message-Id: <20191122194931.24732-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122194931.24732-1-sashal@kernel.org>
References: <20191122194931.24732-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

