Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC902C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C6E2184E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504491;
	bh=vi/vH8pyOAlrCZUrjN+SwGrbS8OfUm+zrqmnWIEMZxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ed6n5Fhhol0RSdoK6VEHwzEdrtfIze8iutiKFh//ew47pM354Dfuyz/7ZjC3ATt5t
	 sJFZzFJLscg8bnAwgnjhOSaXkqRai33DqftFlQDWaz55VsxciikEO/MCjFeKMljX7h
	 rM+7eHmioEjv1qGFlVrEmkygZlxj880e6xHiVLcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbfCMTOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:14:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbfCMTOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:14:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3081D2075C;
        Wed, 13 Mar 2019 19:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504486;
        bh=vi/vH8pyOAlrCZUrjN+SwGrbS8OfUm+zrqmnWIEMZxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jJEinZCKQIgTkduU+FnZ9mJiTLW/HAmC+Zdo3zBtaa/td4EbZMpluaapC1nYnT+8T
         g3r4QgwRngrRp0dFxiMSuSDGeavQXWBJ3nsLvQcXpq8KNG5ZIDwtoNaC+peBVbwaqZ
         54hZkFsPwWzJ3Lz0v0n2Uk8ZYTW63jR2b+CDQUlc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vadim Lomovtsev <vlomovtsev@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 41/48] net: thunderx: add nicvf_send_msg_to_pf result check for set_rx_mode_task
Date:   Wed, 13 Mar 2019 15:12:43 -0400
Message-Id: <20190313191250.158955-41-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191250.158955-1-sashal@kernel.org>
References: <20190313191250.158955-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Lomovtsev <vlomovtsev@marvell.com>

[ Upstream commit 7db730d9d2f7b6af6aeac621b1890ea477a0cb8d ]

The rx_set_mode invokes number of messages to be send to PF for receive
mode configuration. In case if there any issues we need to stop sending
messages and release allocated memory.

This commit is to implement check of nicvf_msg_send_to_pf() result.

Signed-off-by: Vadim Lomovtsev <vlomovtsev@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index 4eb24e10ba4d..9800738448ec 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -1950,7 +1950,8 @@ static void __nicvf_set_rx_mode_task(u8 mode, struct xcast_addr_list *mc_addrs,
 
 	/* flush DMAC filters and reset RX mode */
 	mbx.xcast.msg = NIC_MBOX_MSG_RESET_XCAST;
-	nicvf_send_msg_to_pf(nic, &mbx);
+	if (nicvf_send_msg_to_pf(nic, &mbx) < 0)
+		goto free_mc;
 
 	if (mode & BGX_XCAST_MCAST_FILTER) {
 		/* once enabling filtering, we need to signal to PF to add
@@ -1958,7 +1959,8 @@ static void __nicvf_set_rx_mode_task(u8 mode, struct xcast_addr_list *mc_addrs,
 		 */
 		mbx.xcast.msg = NIC_MBOX_MSG_ADD_MCAST;
 		mbx.xcast.data.mac = 0;
-		nicvf_send_msg_to_pf(nic, &mbx);
+		if (nicvf_send_msg_to_pf(nic, &mbx) < 0)
+			goto free_mc;
 	}
 
 	/* check if we have any specific MACs to be added to PF DMAC filter */
@@ -1967,9 +1969,9 @@ static void __nicvf_set_rx_mode_task(u8 mode, struct xcast_addr_list *mc_addrs,
 		for (idx = 0; idx < mc_addrs->count; idx++) {
 			mbx.xcast.msg = NIC_MBOX_MSG_ADD_MCAST;
 			mbx.xcast.data.mac = mc_addrs->mc[idx];
-			nicvf_send_msg_to_pf(nic, &mbx);
+			if (nicvf_send_msg_to_pf(nic, &mbx) < 0)
+				goto free_mc;
 		}
-		kfree(mc_addrs);
 	}
 
 	/* and finally set rx mode for PF accordingly */
@@ -1977,6 +1979,8 @@ static void __nicvf_set_rx_mode_task(u8 mode, struct xcast_addr_list *mc_addrs,
 	mbx.xcast.data.mode = mode;
 
 	nicvf_send_msg_to_pf(nic, &mbx);
+free_mc:
+	kfree(mc_addrs);
 }
 
 static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
-- 
2.19.1

