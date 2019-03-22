Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3338FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085C821A4A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256149;
	bh=3s68TZcsaLBH8LVQi6/u1BUkGhrEfracpBX7xhurTko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XgnH40noG9V9/9YRu40Ve4ihlkXlYqECMUiIrzYTUaYHV5tbW7/hE8ESbQhGAkjHb
	 QySxEejkvp18ejBWrKZ1sk2mSLsYGuNcMAeNoaKoe7NvN6xcfTZXwCwmQqeL4Z9pPk
	 r0rT/JG9dIBE9pjbxNUmCDFXSO8ZoKqs3OyJ3y/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388371AbfCVMC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:02:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388356AbfCVMCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:02:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA45B2192D;
        Fri, 22 Mar 2019 12:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256142;
        bh=3s68TZcsaLBH8LVQi6/u1BUkGhrEfracpBX7xhurTko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V21JifWs4JpQ/TszWf1FkX40QNUgMV/4tl1QNaZ3zE0GdNXEnWHK3GdKmYXBpubFu
         LdA20Lv8v8/6AHx8+cxfEntFjwhoohLrjCsOBfeZwhAs0TsVRELrfrbH+CcZtBBAHj
         Kdk3/e13S+rZAbK4TQodm5qTHIF1yes6XdA7gOTE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vadim Lomovtsev <vlomovtsev@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 103/280] net: thunderx: make CFG_DONE message to run through generic send-ack sequence
Date:   Fri, 22 Mar 2019 12:14:16 +0100
Message-Id: <20190322111312.460289996@linuxfoundation.org>
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
index 6c8dcb65ff03..90497a27df18 100644
--- a/drivers/net/ethernet/cavium/thunder/nic_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nic_main.c
@@ -1039,7 +1039,7 @@ static void nic_handle_mbx_intr(struct nicpf *nic, int vf)
 	case NIC_MBOX_MSG_CFG_DONE:
 		/* Last message of VF config msg sequence */
 		nic_enable_vf(nic, vf, true);
-		goto unlock;
+		break;
 	case NIC_MBOX_MSG_SHUTDOWN:
 		/* First msg in VF teardown sequence */
 		if (vf >= nic->num_vf_en)
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index 88f8a8fa93cd..4eb24e10ba4d 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -172,6 +172,17 @@ static int nicvf_check_pf_ready(struct nicvf *nic)
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
@@ -1416,7 +1427,6 @@ int nicvf_open(struct net_device *netdev)
 	struct nicvf *nic = netdev_priv(netdev);
 	struct queue_set *qs = nic->qs;
 	struct nicvf_cq_poll *cq_poll = NULL;
-	union nic_mbx mbx = {};
 
 	netif_carrier_off(netdev);
 
@@ -1512,8 +1522,7 @@ int nicvf_open(struct net_device *netdev)
 		nicvf_enable_intr(nic, NICVF_INTR_RBDR, qidx);
 
 	/* Send VF config done msg to PF */
-	mbx.msg.msg = NIC_MBOX_MSG_CFG_DONE;
-	nicvf_write_to_mbx(nic, &mbx);
+	nicvf_send_cfg_done(nic);
 
 	return 0;
 cleanup:
-- 
2.19.1



