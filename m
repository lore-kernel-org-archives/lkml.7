Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E1BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36BD12171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412504;
	bh=VPl6gZG/wfxTjwhfwztth/QLIaegHix6hLMXV9mC480=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=onoGQLvVNWMyEARINVdKFgJ/vMEu2uXe/xP6LmtuXsGyF+e0RMUtyPlRx7TxLojIX
	 F/FkxleSCKsGsQNPeQaIjsrz6lORS5gNamqgqpzmsggD7/5Z9nsSVy/vwlhDZ7m6qi
	 AK1xJvxEU3E9ChZy40QicF5gMRVCwfeOj6TJ9uEk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfCLRQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:16:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728621AbfCLRPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:07 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61A72206DF;
        Tue, 12 Mar 2019 17:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410906;
        bh=VPl6gZG/wfxTjwhfwztth/QLIaegHix6hLMXV9mC480=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HzOiTb3MdUe0IVYBU7zn+tmwDXcmUFNEKrUFTYniyrAloQyCJMTgd8G1E1g+89ZZd
         SpzNtWQYY0LLC49cV0qjEUyMgNWN0ilYDuvMG9TIVz0F/shayEpkp/lLTmVBRxXgsL
         6By//bGsI4s5ct9GjUIbeyDO8k2xYOaSZ5BxrfxQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sudarsana Reddy Kalluru <skalluru@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 120/149] qede: Fix system crash on configuring channels.
Date:   Tue, 12 Mar 2019 10:08:58 -0700
Message-Id: <20190312170359.509095211@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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
index 6a4d266fb8e2..d242a5724069 100644
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
index 1a78027de071..a96da16f3404 100644
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
index 46d0f2eaa0c0..f3d9c40c4115 100644
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



