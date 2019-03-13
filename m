Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E068C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7D3217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504673;
	bh=utozTv3XkrTpdfNgZ2ryzQ+c3ZHZ2Fsop0JXppyDpqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pvfmD0J6bXQCzuGhgbuM7cfh9mTtvukPmpR7VOtkfBCf1fZOIrt0mH4BAh1z6G3sc
	 0JiDWfbixRVl+8MwE7EfmsMbZ62EbU0UwwDV0w2qPqjkbl3DBSlb9N/SWef6JHMgu6
	 Iv58vL+KiSkBDyELpVmnEWFuKVtd7mcAZAjLQe+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbfCMTRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:17:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728953AbfCMTRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:17:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07F70217F5;
        Wed, 13 Mar 2019 19:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504667;
        bh=utozTv3XkrTpdfNgZ2ryzQ+c3ZHZ2Fsop0JXppyDpqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ku43kAR2srG8EAOiAgIT9+xdL2QF/tgUfaYHJyviCjzXn+OOH+3J5xRyse4a0S5Ds
         5YnTXPCcsFJAESMD4A8FU9doFlLCeBZOAi4MmUS5UPh8mmpeTspYO2n2ijmBF+0I/z
         P2OSswbw4qI/vfdRddyp7QGIRfvzyq97w7oSMeKc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vadim Lomovtsev <vlomovtsev@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 20/24] net: thunderx: make CFG_DONE message to run through generic send-ack sequence
Date:   Wed, 13 Mar 2019 15:16:43 -0400
Message-Id: <20190313191647.160171-20-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191647.160171-1-sashal@kernel.org>
References: <20190313191647.160171-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Lomovtsev <vlomovtsev@marvell.com>

[ Upstream commit 0dd563b9a62c4cbabf5d4fd6596440c2491e72b1 ]

At the end of NIC VF initialization VF sends CFG_DONE message to PF without
using nicvf_msg_send_to_pf routine. This potentially could re-write data in
mailbox. This commit is to implement common way of sending CFG_DONE message
by the same way with other configuration messages by using
nicvf_send_msg_to_pf() routine.

Signed-off-by: Vadim Lomovtsev <vlomovtsev@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cavium/thunder/nic_main.c   |  2 +-
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 15 ++++++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nic_main.c b/drivers/net/ethernet/cavium/thunder/nic_main.c
index da142f6bd0c3..18ddd243dfa1 100644
--- a/drivers/net/ethernet/cavium/thunder/nic_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nic_main.c
@@ -999,7 +999,7 @@ static void nic_handle_mbx_intr(struct nicpf *nic, int vf)
 	case NIC_MBOX_MSG_CFG_DONE:
 		/* Last message of VF config msg sequence */
 		nic_enable_vf(nic, vf, true);
-		goto unlock;
+		break;
 	case NIC_MBOX_MSG_SHUTDOWN:
 		/* First msg in VF teardown sequence */
 		if (vf >= nic->num_vf_en)
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index c75d4ea9342b..71f228cece03 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -162,6 +162,17 @@ static int nicvf_check_pf_ready(struct nicvf *nic)
 	return 1;
 }
 
+static void nicvf_send_cfg_done(struct nicvf *nic)
+{
+	union nic_mbx mbx = {};
+
+	mbx.msg.msg = NIC_MBOX_MSG_CFG_DONE;
+	if (nicvf_send_msg_to_pf(nic, &mbx)) {
+		netdev_err(nic->netdev,
+			   "PF didn't respond to CFG DONE msg\n");
+	}
+}
+
 static void nicvf_read_bgx_stats(struct nicvf *nic, struct bgx_stats_msg *bgx)
 {
 	if (bgx->rx)
@@ -1178,7 +1189,6 @@ int nicvf_open(struct net_device *netdev)
 	struct nicvf *nic = netdev_priv(netdev);
 	struct queue_set *qs = nic->qs;
 	struct nicvf_cq_poll *cq_poll = NULL;
-	union nic_mbx mbx = {};
 
 	netif_carrier_off(netdev);
 
@@ -1267,8 +1277,7 @@ int nicvf_open(struct net_device *netdev)
 		nicvf_enable_intr(nic, NICVF_INTR_RBDR, qidx);
 
 	/* Send VF config done msg to PF */
-	mbx.msg.msg = NIC_MBOX_MSG_CFG_DONE;
-	nicvf_write_to_mbx(nic, &mbx);
+	nicvf_send_cfg_done(nic);
 
 	return 0;
 cleanup:
-- 
2.19.1

