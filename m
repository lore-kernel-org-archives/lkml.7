Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AD8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CE321B18
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256153;
	bh=nHfYX/0EUAGT1HJ5q88LC7QJ8xQZSLKbhMMneAY/Ai4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VzrIsaQ2MAQBtiuEoKd1Y5q96XhFPGuJEC3jWP/6xF7WB/0OMwoJKDl7YdSruHokO
	 MUhB9vvZVX/y6L6wXv8Xn7LUxKkJdAqUxbBP+JTHjjwySpMP67d6ht0LgnvD07gd9f
	 j9iqfMc4CD0OukpE2cBJwooc+RKYTpx6Clj5suNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388378AbfCVMCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:02:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388363AbfCVMCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:02:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C10D21934;
        Fri, 22 Mar 2019 12:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256144;
        bh=nHfYX/0EUAGT1HJ5q88LC7QJ8xQZSLKbhMMneAY/Ai4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=porhAgYf/pMMTMncx1CLXWbrc6yi4KiYSMVV0mYKjVtR9mVEaS+vZBRTZP7MTYlBk
         G2DN56UCM8qHHsmZ8KQMTk0+p4HuBALuEOihuBcJADKxJO8jZ4OGV+iwQKQV7xDmOC
         Af9pQrtMY5+smf6Sycm227VTQ7BzNMiKfbzghwhE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vadim Lomovtsev <vlomovtsev@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 104/280] net: thunderx: add nicvf_send_msg_to_pf result check for set_rx_mode_task
Date:   Fri, 22 Mar 2019 12:14:17 +0100
Message-Id: <20190322111312.574579576@linuxfoundation.org>
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



