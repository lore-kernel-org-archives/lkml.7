Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80ACFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5302D2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504323;
	bh=pIxf4BS8JJGwfL9mjosrFoChjL0yXeHt9nthO0IPsuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p2sepmS4kxTRG4mYlIqoOY0qZnDL+DhhbCLQiZsbPhdiy3j4p8na5VIfXwoBcg/Gt
	 J2cEKs8InSKBs4Uhendbu0gdujAniXegxgAMlNsoSbAiNQOj2SMKejFlOxhAcqUlOp
	 fRTsZ+lCvZKPUEA3i28Mhfw7tN+q5KSfaC1GubEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfCMTMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:12:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727611AbfCMTL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:11:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56EB12173C;
        Wed, 13 Mar 2019 19:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504316;
        bh=pIxf4BS8JJGwfL9mjosrFoChjL0yXeHt9nthO0IPsuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uS9OwW+9V9r9RZylHY7b3GZIv5pRM1IqevB1FhtZwS8dtsmE+51PUGPulDHZjdv8P
         3KtY7ofYSnJOs+RHSzVUzz/i+MXTnt+JE0bf/nhJHOBeo6jMheyeF+S6v6JIDMvi+W
         mtaXJuOuuxU4nnmjfY1SCiLIdnvKNcCOb9ou49gI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Magnus Karlsson <magnus.karlsson@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        xdp-newbies@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 42/60] ixgbe: fix potential RX buffer starvation for AF_XDP
Date:   Wed, 13 Mar 2019 15:10:03 -0400
Message-Id: <20190313191021.158171-42-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191021.158171-1-sashal@kernel.org>
References: <20190313191021.158171-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Magnus Karlsson <magnus.karlsson@intel.com>

[ Upstream commit 4a9b32f30f805ca596d76605903a48eab58e0b88 ]

When the RX rings are created they are also populated with buffers so
that packets can be received. Usually these are kernel buffers, but
for AF_XDP in zero-copy mode, these are user-space buffers and in this
case the application might not have sent down any buffers to the
driver at this point. And if no buffers are allocated at ring creation
time, no packets can be received and no interrupts will be generated so
the NAPI poll function that allocates buffers to the rings will never
get executed.

To rectify this, we kick the NAPI context of any queue with an
attached AF_XDP zero-copy socket in two places in the code. Once after
an XDP program has loaded and once after the umem is registered.  This
take care of both cases: XDP program gets loaded first then AF_XDP
socket is created, and the reverse, AF_XDP socket is created first,
then XDP program is loaded.

Fixes: d0bcacd0a130 ("ixgbe: add AF_XDP zero-copy Rx support")
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 12 +++++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  | 12 ++++++++++--
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index aed1890514d6..8c47451f17f1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -10207,6 +10207,7 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
 	int i, frame_size = dev->mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
 	struct ixgbe_adapter *adapter = netdev_priv(dev);
 	struct bpf_prog *old_prog;
+	bool need_reset;
 
 	if (adapter->flags & IXGBE_FLAG_SRIOV_ENABLED)
 		return -EINVAL;
@@ -10229,9 +10230,10 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
 		return -ENOMEM;
 
 	old_prog = xchg(&adapter->xdp_prog, prog);
+	need_reset = (!!prog != !!old_prog);
 
 	/* If transitioning XDP modes reconfigure rings */
-	if (!!prog != !!old_prog) {
+	if (need_reset) {
 		int err = ixgbe_setup_tc(dev, adapter->hw_tcs);
 
 		if (err) {
@@ -10247,6 +10249,14 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
 	if (old_prog)
 		bpf_prog_put(old_prog);
 
+	/* Kick start the NAPI context if there is an AF_XDP socket open
+	 * on that queue id. This so that receiving will start.
+	 */
+	if (need_reset && prog)
+		for (i = 0; i < adapter->num_rx_queues; i++)
+			if (adapter->xdp_ring[i]->xsk_umem)
+				(void)ixgbe_xsk_async_xmit(adapter->netdev, i);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 65c3e2c979d4..654ae92342ea 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -144,11 +144,19 @@ static int ixgbe_xsk_umem_enable(struct ixgbe_adapter *adapter,
 		ixgbe_txrx_ring_disable(adapter, qid);
 
 	err = ixgbe_add_xsk_umem(adapter, umem, qid);
+	if (err)
+		return err;
 
-	if (if_running)
+	if (if_running) {
 		ixgbe_txrx_ring_enable(adapter, qid);
 
-	return err;
+		/* Kick start the NAPI context so that receiving will start */
+		err = ixgbe_xsk_async_xmit(adapter->netdev, qid);
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
 
 static int ixgbe_xsk_umem_disable(struct ixgbe_adapter *adapter, u16 qid)
-- 
2.19.1

