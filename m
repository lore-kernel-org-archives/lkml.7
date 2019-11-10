Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D967AC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9079214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573354811;
	bh=tqhzOFt/TJw6rlPqBauXF0MLO3aJItvG9ekXWJ+WCXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hv6wUP3NmlCoh1Tzh1vNxHF839K7mLE9sDWtlhjb55qWY6lN6GhoWAb6ZLFPlWHRa
	 ENBDlEoZYr1XhpuG9qFzOX0lWjL2o3sO8O0v5wwaxIFnZIEw00TufIv7EifC0GpnF5
	 tdYzDZk3cYfIy9JLR+AZ/+H9Ar0ljU7UN29OKk1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbfKJDAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 22:00:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:47260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729274AbfKJC4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:56:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7736C22487;
        Sun, 10 Nov 2019 02:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573354076;
        bh=tqhzOFt/TJw6rlPqBauXF0MLO3aJItvG9ekXWJ+WCXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NbMLpP0JZvfAMhMr6/4cceU4rr80G8Ol0DJE32/cy+cA1XF7/ABisB9ecxxPCDK5f
         ZBbz4WlGWo+NZoPRRZ51oU0wr/oGIey8+NOpQycfworpBa80+wU/WSe3lNk0LPqusC
         jcbAtltyb/SFZV7CeN3LXI5Ds0pTvygNQje+3Df8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 076/109] net: smsc: fix return type of ndo_start_xmit function
Date:   Sat,  9 Nov 2019 21:45:08 -0500
Message-Id: <20191110024541.31567-76-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024541.31567-1-sashal@kernel.org>
References: <20191110024541.31567-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 6323d57f335ce1490d025cacc83fc10b07792130 ]

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, so make sure the implementation in
this driver has returns 'netdev_tx_t' value, and change the function
return type to netdev_tx_t.

Found by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/smsc/smc911x.c  | 3 ++-
 drivers/net/ethernet/smsc/smc91x.c   | 3 ++-
 drivers/net/ethernet/smsc/smsc911x.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smc911x.c b/drivers/net/ethernet/smsc/smc911x.c
index 05157442a9807..42d35a87bcc9f 100644
--- a/drivers/net/ethernet/smsc/smc911x.c
+++ b/drivers/net/ethernet/smsc/smc911x.c
@@ -514,7 +514,8 @@ static void smc911x_hardware_send_pkt(struct net_device *dev)
  * now, or set the card to generates an interrupt when ready
  * for the packet.
  */
-static int smc911x_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+smc911x_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct smc911x_local *lp = netdev_priv(dev);
 	unsigned int free;
diff --git a/drivers/net/ethernet/smsc/smc91x.c b/drivers/net/ethernet/smsc/smc91x.c
index 0804287628584..96ac0d3af6f5b 100644
--- a/drivers/net/ethernet/smsc/smc91x.c
+++ b/drivers/net/ethernet/smsc/smc91x.c
@@ -638,7 +638,8 @@ done:	if (!THROTTLE_TX_PKTS)
  * now, or set the card to generates an interrupt when ready
  * for the packet.
  */
-static int smc_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+smc_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct smc_local *lp = netdev_priv(dev);
 	void __iomem *ioaddr = lp->base;
diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index f0afb88d7bc2b..ce4bfecc26c7a 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -1786,7 +1786,8 @@ static int smsc911x_stop(struct net_device *dev)
 }
 
 /* Entry point for transmitting a packet */
-static int smsc911x_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+smsc911x_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct smsc911x_data *pdata = netdev_priv(dev);
 	unsigned int freespace;
-- 
2.20.1

