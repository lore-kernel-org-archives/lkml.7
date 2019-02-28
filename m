Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1B0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A4C22133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367687;
	bh=AdvyOXBZdGiKLKKBjc2UHhK/WFigOjBwFWsoUAE78Nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uInWHDxnO9FMrd2GIUCbxBytlqlwMkWNiJBm6PkZCgz2+MglioXMNdkH0T0sHg2H5
	 B9ptB+bynIWrFz1Be+XK9xufLY2JmmyRaT7o1L2xn9hkRqutsyJI9G7iImyScJh8xX
	 pd9iRhYobopMUkpXVmtZjrxDQtCPVi/MDM9HLlYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388696AbfB1P2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:28:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:43986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387823AbfB1PLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:11:03 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1874218C3;
        Thu, 28 Feb 2019 15:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366662;
        bh=AdvyOXBZdGiKLKKBjc2UHhK/WFigOjBwFWsoUAE78Nk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zJlljTr52HrShqttTSlyLABcLZXZeDhm2MMEM91/h92FmEvfOKGmkKjhMAPrPSqMy
         xOwNTJy8IFtAGukXOvAgB5NuQVi34OknXnv0BHk5Ose9IAtdXtJniH/9MRw5BaE0rw
         tjwz/DQcF4vgqMmrhKJ6uAHML2mTmzttLXf/7vJ4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sudarsana Reddy Kalluru <skalluru@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 80/81] qede: Fix system crash on configuring channels.
Date:   Thu, 28 Feb 2019 10:08:12 -0500
Message-Id: <20190228150813.10256-80-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudarsana Reddy Kalluru <skalluru@marvell.com>

[ Upstream commit 0aa4febb420d91df5b56b1864a2465765da85f4b ]

Under heavy traffic load, when changing number of channels via
ethtool (ethtool -L) which will cause interface to be reloaded,
it was observed that some packets gets transmitted on old TX
channel/queue id which doesn't really exist after the channel
configuration leads to system crash.

Add a safeguard in the driver by validating queue id through
ndo_select_queue() which is called before the ndo_start_xmit().

Signed-off-by: Sudarsana Reddy Kalluru <skalluru@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qede/qede.h      |  3 +++
 drivers/net/ethernet/qlogic/qede/qede_fp.c   | 13 +++++++++++++
 drivers/net/ethernet/qlogic/qede/qede_main.c |  3 +++
 3 files changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qede/qede.h b/drivers/net/ethernet/qlogic/qede/qede.h
index de98a974673b3..4b875f652ecd1 100644
--- a/drivers/net/ethernet/qlogic/qede/qede.h
+++ b/drivers/net/ethernet/qlogic/qede/qede.h
@@ -489,6 +489,9 @@ struct qede_reload_args {
 
 /* Datapath functions definition */
 netdev_tx_t qede_start_xmit(struct sk_buff *skb, struct net_device *ndev);
+u16 qede_select_queue(struct net_device *dev, struct sk_buff *skb,
+		      struct net_device *sb_dev,
+		      select_queue_fallback_t fallback);
 netdev_features_t qede_features_check(struct sk_buff *skb,
 				      struct net_device *dev,
 				      netdev_features_t features);
diff --git a/drivers/net/ethernet/qlogic/qede/qede_fp.c b/drivers/net/ethernet/qlogic/qede/qede_fp.c
index 1a78027de071f..a96da16f34049 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_fp.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_fp.c
@@ -1695,6 +1695,19 @@ netdev_tx_t qede_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	return NETDEV_TX_OK;
 }
 
+u16 qede_select_queue(struct net_device *dev, struct sk_buff *skb,
+		      struct net_device *sb_dev,
+		      select_queue_fallback_t fallback)
+{
+	struct qede_dev *edev = netdev_priv(dev);
+	int total_txq;
+
+	total_txq = QEDE_TSS_COUNT(edev) * edev->dev_info.num_tc;
+
+	return QEDE_TSS_COUNT(edev) ?
+		fallback(dev, skb, NULL) % total_txq :  0;
+}
+
 /* 8B udp header + 8B base tunnel header + 32B option length */
 #define QEDE_MAX_TUN_HDR_LEN 48
 
diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index 46d0f2eaa0c09..f3d9c40c41159 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -631,6 +631,7 @@ static const struct net_device_ops qede_netdev_ops = {
 	.ndo_open = qede_open,
 	.ndo_stop = qede_close,
 	.ndo_start_xmit = qede_start_xmit,
+	.ndo_select_queue = qede_select_queue,
 	.ndo_set_rx_mode = qede_set_rx_mode,
 	.ndo_set_mac_address = qede_set_mac_addr,
 	.ndo_validate_addr = eth_validate_addr,
@@ -666,6 +667,7 @@ static const struct net_device_ops qede_netdev_vf_ops = {
 	.ndo_open = qede_open,
 	.ndo_stop = qede_close,
 	.ndo_start_xmit = qede_start_xmit,
+	.ndo_select_queue = qede_select_queue,
 	.ndo_set_rx_mode = qede_set_rx_mode,
 	.ndo_set_mac_address = qede_set_mac_addr,
 	.ndo_validate_addr = eth_validate_addr,
@@ -684,6 +686,7 @@ static const struct net_device_ops qede_netdev_vf_xdp_ops = {
 	.ndo_open = qede_open,
 	.ndo_stop = qede_close,
 	.ndo_start_xmit = qede_start_xmit,
+	.ndo_select_queue = qede_select_queue,
 	.ndo_set_rx_mode = qede_set_rx_mode,
 	.ndo_set_mac_address = qede_set_mac_addr,
 	.ndo_validate_addr = eth_validate_addr,
-- 
2.19.1

