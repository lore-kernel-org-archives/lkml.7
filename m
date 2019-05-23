Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DABC282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8BE218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639223;
	bh=7rPitIyyJ88Ajz/ZM+BgOKkmfkRETC+ZL64Szngkiwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S8ubU6MKoDPrm3p0vRiV0SV1cSqEW7yJot4+BnpIEpMP3sN/ZWBgo7T6tAq/mz/yz
	 Pzzd1aYEDZ8Dzg6bH7BwzymI+5bZMW+1jtZ5IBBx6UazcWvd0xCbGi9GBwReKhZ07T
	 x4nl0n1Rfq061HHKqGhV+aktmOQb2Qxfl1Uc+Xqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390030AbfEWTUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:20:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:56994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390000AbfEWTUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:20:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D006721851;
        Thu, 23 May 2019 19:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639218;
        bh=7rPitIyyJ88Ajz/ZM+BgOKkmfkRETC+ZL64Szngkiwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c1HFzZ7uZgmnF12NBrM4r0bwUW0lEIcGUTfhDdhrD+V2HaVp+QRtVrV6ioZQcEKtw
         KtdNEC2+64tGBHnsgIZpPFi91RD6BiNLXJ/lx7OmfhjOcZlOJ6NLymeT2tmf3a+AAU
         q2c7pOD0qymE/XVMf9pouRzG2J1NgLKycOHRAwtM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmytro Linkin <dmitrolin@mellanox.com>,
        Gavi Teitz <gavi@mellanox.com>, Roi Dayan <roid@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.0 015/139] net/mlx5e: Add missing ethtool driver info for representors
Date:   Thu, 23 May 2019 21:05:03 +0200
Message-Id: <20190523181722.461799422@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181720.120897565@linuxfoundation.org>
References: <20190523181720.120897565@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmytro Linkin <dmitrolin@mellanox.com>

[ Upstream commit cf83c8fdcd4756644595521f48748ec22f7efede ]

For all representors added firmware version info to show in
ethtool driver info.
For uplink representor, because only it is tied to the pci device
sysfs, added pci bus info.

Fixes: ff9b85de5d5d ("net/mlx5e: Add some ethtool port control entries to the uplink rep netdev")
Signed-off-by: Dmytro Linkin <dmitrolin@mellanox.com>
Reviewed-by: Gavi Teitz <gavi@mellanox.com>
Reviewed-by: Roi Dayan <roid@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -64,9 +64,26 @@ static void mlx5e_rep_indr_unregister_bl
 static void mlx5e_rep_get_drvinfo(struct net_device *dev,
 				  struct ethtool_drvinfo *drvinfo)
 {
+	struct mlx5e_priv *priv = netdev_priv(dev);
+	struct mlx5_core_dev *mdev = priv->mdev;
+
 	strlcpy(drvinfo->driver, mlx5e_rep_driver_name,
 		sizeof(drvinfo->driver));
 	strlcpy(drvinfo->version, UTS_RELEASE, sizeof(drvinfo->version));
+	snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
+		 "%d.%d.%04d (%.16s)",
+		 fw_rev_maj(mdev), fw_rev_min(mdev),
+		 fw_rev_sub(mdev), mdev->board_id);
+}
+
+static void mlx5e_uplink_rep_get_drvinfo(struct net_device *dev,
+					 struct ethtool_drvinfo *drvinfo)
+{
+	struct mlx5e_priv *priv = netdev_priv(dev);
+
+	mlx5e_rep_get_drvinfo(dev, drvinfo);
+	strlcpy(drvinfo->bus_info, pci_name(priv->mdev->pdev),
+		sizeof(drvinfo->bus_info));
 }
 
 static const struct counter_desc sw_rep_stats_desc[] = {
@@ -374,7 +391,7 @@ static const struct ethtool_ops mlx5e_vf
 };
 
 static const struct ethtool_ops mlx5e_uplink_rep_ethtool_ops = {
-	.get_drvinfo	   = mlx5e_rep_get_drvinfo,
+	.get_drvinfo	   = mlx5e_uplink_rep_get_drvinfo,
 	.get_link	   = ethtool_op_get_link,
 	.get_strings       = mlx5e_rep_get_strings,
 	.get_sset_count    = mlx5e_rep_get_sset_count,


