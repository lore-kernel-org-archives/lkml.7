Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC9FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666DB204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256008;
	bh=r3OmJKEruieEwLDcDICfTpRqmYrWcDvTiJ2e25LRW4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kFbRFYqppY6OmXpNQy+TfZh8YCiPi+svdN91RRPt4rTO9EeSy1z+wkrLcV4Fml3dr
	 eA/+y9yQ5gRbgs8WWVAr26jTbG9Uh2dtuotD035ej7gsIEc1roBVO9CuQh3JmRWH6N
	 11wEjzBaZSTKFclYQsr+GyS7mGjxWZkvopJcfynY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388052AbfCVMAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388034AbfCVMAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:00:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3CA02192D;
        Fri, 22 Mar 2019 12:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256005;
        bh=r3OmJKEruieEwLDcDICfTpRqmYrWcDvTiJ2e25LRW4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fcUKobNT0zwyO1VYVbmbVHDKejo229h/E6eV5cTIzeBT97y4ugArj7oAWKZEKCYxj
         iKo+Ega/1wb9GYn2HUF86hcHFgvukiARO/S1P2TAPx/HyYt3AzueJAQGr1stPzQzXA
         aivniQe3ZU/lp6dFKQR5IKtyvdlYz6uetbHsLElM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huang Zijiang <huang.zijiang@zte.com.cn>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 062/280] net: hns: Fix object reference leaks in hns_dsaf_roce_reset()
Date:   Fri, 22 Mar 2019 12:13:35 +0100
Message-Id: <20190322111309.758574321@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c969c6e7ab8cb42b5c787c567615474fdbad9d6a ]

The of_find_device_by_node() takes a reference to the underlying device
structure, we should release that reference.

Signed-off-by: Huang Zijiang <huang.zijiang@zte.com.cn>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
index 3b9e74be5fbd..b8155f5e71b4 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
@@ -3081,6 +3081,7 @@ int hns_dsaf_roce_reset(struct fwnode_handle *dsaf_fwnode, bool dereset)
 	dsaf_dev = dev_get_drvdata(&pdev->dev);
 	if (!dsaf_dev) {
 		dev_err(&pdev->dev, "dsaf_dev is NULL\n");
+		put_device(&pdev->dev);
 		return -ENODEV;
 	}
 
@@ -3088,6 +3089,7 @@ int hns_dsaf_roce_reset(struct fwnode_handle *dsaf_fwnode, bool dereset)
 	if (AE_IS_VER1(dsaf_dev->dsaf_ver)) {
 		dev_err(dsaf_dev->dev, "%s v1 chip doesn't support RoCE!\n",
 			dsaf_dev->ae_dev.name);
+		put_device(&pdev->dev);
 		return -ENODEV;
 	}
 
-- 
2.19.1



