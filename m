Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCAEC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FE12089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561371532;
	bh=wmC6sIKsGuYIVEGrslgGVmYB1d51672VeR1UWq/sook=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vFajCLwk6TXYmxBnmwMYPdP/kw2ZoAGEmuOugBQIfJxToLlcM7ZFzj4NtxHpCzZMs
	 7EWXKw/0Vx16oDt3attC/OvPKEr3mvZOjfokR2qrdAK5cSkmuT06BsrX+vIdtiFuyn
	 bW5b9++NokVUhNQ8kG8hcUeEq+pEDfelMjMY+pyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbfFXKSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:18:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730084AbfFXKPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:15:45 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17D58205ED;
        Mon, 24 Jun 2019 10:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561371344;
        bh=wmC6sIKsGuYIVEGrslgGVmYB1d51672VeR1UWq/sook=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pzoQ+WATQamKZISpr7+KQZYWrsonvJ/IBKI0Ed5WRQ//4KPYa7mhLr+VmGw80YGEh
         6j1u9KJ5Pg7JoZpZd3jmqyT+rBYCGGMMGXSXCRiUKTsrDiwk/yEg2KYAHsr6B8oRPU
         B6Qty0UefSKSddlu0dpI9+lrczGdVpUNbPVYC6dg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Lee <mark-mc.lee@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 067/121] net: ethernet: mediatek: Use hw_feature to judge if HWLRO is supported
Date:   Mon, 24 Jun 2019 17:56:39 +0800
Message-Id: <20190624092324.278858135@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092320.652599624@linuxfoundation.org>
References: <20190624092320.652599624@linuxfoundation.org>
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
index 549d36497b8c..59601cb5aeee 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2297,13 +2297,13 @@ static int mtk_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 
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
@@ -2311,11 +2311,11 @@ static int mtk_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
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
@@ -2332,11 +2332,11 @@ static int mtk_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 
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



