Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55AFC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3CA206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576780940;
	bh=bA+AWX+r9jIYVn9fb0mavTdRwonn+lP6pVz/FSvOLoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wk0DmAcyXdjJyc1LtjJ2E36VQCqg3nbzBM5AttGZpZvbQCA3f3nkFNh5SiJWde3gW
	 EbbZyDi4eH24bp0NHFjrECW78XPzN8vcQFLQ9P2ZyQC3dqV+P//fXtU3Y9rRkpyhpJ
	 Ioa54eNl+DQb3MsfVxHZelkN51cR/+74GFUEl/Y0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfLSSmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:42:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:33384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728663AbfLSSmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:42:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC564206D7;
        Thu, 19 Dec 2019 18:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780936;
        bh=bA+AWX+r9jIYVn9fb0mavTdRwonn+lP6pVz/FSvOLoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TTlPlZnKCh1kJzglryIOeGO/GV/jqxYDm6QP0MFJvrQSdQIUXpdyergEf/mTMMnLD
         gJY/Ri4FsJbbYqDGc1IY+bZMBXM7dk6uKRQn0BiKrn7fCdiQhQayktcU7RqgxzobAq
         swQqy8r9Y5BQRXFe5tiqgrT70P1jcCY9f/LQvdvU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 016/199] net: ep93xx_eth: fix mismatch of request_mem_region in remove
Date:   Thu, 19 Dec 2019 19:31:38 +0100
Message-Id: <20191219183215.670147273@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183214.629503389@linuxfoundation.org>
References: <20191219183214.629503389@linuxfoundation.org>
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
index 9a161e9815297..24f69034f52c4 100644
--- a/drivers/net/ethernet/cirrus/ep93xx_eth.c
+++ b/drivers/net/ethernet/cirrus/ep93xx_eth.c
@@ -780,6 +780,7 @@ static int ep93xx_eth_remove(struct platform_device *pdev)
 {
 	struct net_device *dev;
 	struct ep93xx_priv *ep;
+	struct resource *mem;
 
 	dev = platform_get_drvdata(pdev);
 	if (dev == NULL)
@@ -795,8 +796,8 @@ static int ep93xx_eth_remove(struct platform_device *pdev)
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



