Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60F4C606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC5E216C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599144;
	bh=tnRMDA48rboUP2LOwgafjmYOMveaq5ZxCFEFDxyyE1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U/8h+f6xrf14ElJz/qoBg7Nf0hGxgJuULicdo4GBlawA5WgWikZ3hVww+6God9+pG
	 5T8cu2dhuFk7BndVM5pAMi80Xfsg75l3pzKIp8iu1l/UbjbYYRRKl9DEg14N7Nb9Ix
	 oVQDY4WDOJd883eJ2zDZwvsLGmwLWdAV9Sy9zggc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733172AbfGHPTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:19:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733147AbfGHPS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:18:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EEA321537;
        Mon,  8 Jul 2019 15:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599137;
        bh=tnRMDA48rboUP2LOwgafjmYOMveaq5ZxCFEFDxyyE1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gmAkAafjX08puTBH/mVkflV+PsXR5aYBOYEM2NvwrtgWNUPTutTpRS6dctGTQkLZ3
         LISGM6u4IsBkQL8hWoZ34hWHX2osfqZl9gc4Jb6x25Dwd2jDKQE/EmkAEmLbquuVub
         tP1hiXa28+agMCANKqtnG7AUEhEdEkI9wLKQCBUI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Lee <mark-mc.lee@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 018/102] net: ethernet: mediatek: Use hw_feature to judge if HWLRO is supported
Date:   Mon,  8 Jul 2019 17:12:11 +0200
Message-Id: <20190708150527.113999863@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150525.973820964@linuxfoundation.org>
References: <20190708150525.973820964@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 9e4f56f1a7f3287718d0083b5cb85298dc05a5fd ]

Should hw_feature as hardware capability flags to check if hardware LRO
got support.

Signed-off-by: Mark Lee <mark-mc.lee@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 20de37a414fe..03b599109619 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2175,13 +2175,13 @@ static int mtk_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 
 	switch (cmd->cmd) {
 	case ETHTOOL_GRXRINGS:
-		if (dev->features & NETIF_F_LRO) {
+		if (dev->hw_features & NETIF_F_LRO) {
 			cmd->data = MTK_MAX_RX_RING_NUM;
 			ret = 0;
 		}
 		break;
 	case ETHTOOL_GRXCLSRLCNT:
-		if (dev->features & NETIF_F_LRO) {
+		if (dev->hw_features & NETIF_F_LRO) {
 			struct mtk_mac *mac = netdev_priv(dev);
 
 			cmd->rule_cnt = mac->hwlro_ip_cnt;
@@ -2189,11 +2189,11 @@ static int mtk_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 		}
 		break;
 	case ETHTOOL_GRXCLSRULE:
-		if (dev->features & NETIF_F_LRO)
+		if (dev->hw_features & NETIF_F_LRO)
 			ret = mtk_hwlro_get_fdir_entry(dev, cmd);
 		break;
 	case ETHTOOL_GRXCLSRLALL:
-		if (dev->features & NETIF_F_LRO)
+		if (dev->hw_features & NETIF_F_LRO)
 			ret = mtk_hwlro_get_fdir_all(dev, cmd,
 						     rule_locs);
 		break;
@@ -2210,11 +2210,11 @@ static int mtk_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 
 	switch (cmd->cmd) {
 	case ETHTOOL_SRXCLSRLINS:
-		if (dev->features & NETIF_F_LRO)
+		if (dev->hw_features & NETIF_F_LRO)
 			ret = mtk_hwlro_add_ipaddr(dev, cmd);
 		break;
 	case ETHTOOL_SRXCLSRLDEL:
-		if (dev->features & NETIF_F_LRO)
+		if (dev->hw_features & NETIF_F_LRO)
 			ret = mtk_hwlro_del_ipaddr(dev, cmd);
 		break;
 	default:
-- 
2.20.1



