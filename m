Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A329C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567FA21738
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963712;
	bh=yK4vAa+m2IRRV23BfQirRkIQ8E74H/kqOpyG8IAntcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z5d2xuLK5XsFc3HdFzAlu2kSRSVewU1SeJnHJYk29RZn+cklyBdw1okvidV2iKP0d
	 UybiwyyH4BfH6AiVQMPBARg7h2urO35ihyErBIsD6l46Q56WjPj83khuZEYENmJPCx
	 Kwp8cjf8xVgZ1zfqxezsvqfZKLXlWQOX731X8bzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732457AbfDVUIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:08:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729289AbfDVTnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:43:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 339F4218B0;
        Mon, 22 Apr 2019 19:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962233;
        bh=yK4vAa+m2IRRV23BfQirRkIQ8E74H/kqOpyG8IAntcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GxI6D+DclZEbGod9P0urm4PEoMN4JrTJy6NWUzOlStDEPE/PkRbduEQ/Q0iGp2t1A
         Bdz65ePVJaUo35IOfglwmCqqVyNKgGbl4fhYNsL89FXs1WFgDaBc9AoJmCJNh12Gx5
         PXeMfM/JFmGUNijGK5paITCevGi9a7I05FIIrepw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wen Yang <wen.yang99@zte.com.cn>, Wingman Kwok <w-kwok2@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 53/98] net: ethernet: ti: fix possible object reference leak
Date:   Mon, 22 Apr 2019 15:41:20 -0400
Message-Id: <20190422194205.10404-53-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wen.yang99@zte.com.cn>

[ Upstream commit 75eac7b5f68b0a0671e795ac636457ee27cc11d8 ]

The call to of_get_child_by_name returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./drivers/net/ethernet/ti/netcp_ethss.c:3661:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 3654, but without a corresponding object release within this function.
./drivers/net/ethernet/ti/netcp_ethss.c:3665:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 3654, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Wingman Kwok <w-kwok2@ti.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/net/ethernet/ti/netcp_ethss.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
index 5174d318901e..0a920c5936b2 100644
--- a/drivers/net/ethernet/ti/netcp_ethss.c
+++ b/drivers/net/ethernet/ti/netcp_ethss.c
@@ -3657,12 +3657,16 @@ static int gbe_probe(struct netcp_device *netcp_device, struct device *dev,
 
 	ret = netcp_txpipe_init(&gbe_dev->tx_pipe, netcp_device,
 				gbe_dev->dma_chan_name, gbe_dev->tx_queue_id);
-	if (ret)
+	if (ret) {
+		of_node_put(interfaces);
 		return ret;
+	}
 
 	ret = netcp_txpipe_open(&gbe_dev->tx_pipe);
-	if (ret)
+	if (ret) {
+		of_node_put(interfaces);
 		return ret;
+	}
 
 	/* Create network interfaces */
 	INIT_LIST_HEAD(&gbe_dev->gbe_intf_head);
-- 
2.19.1

