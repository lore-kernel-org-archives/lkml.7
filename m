Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F100C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7AF32190B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962575;
	bh=4LMSCIR1Th0mz8SSjIH8jn9qHmI65qaQLfDcxCqkh5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hi0tstbO57wv4kk8tPpOD1FZed0XB/HOtB9ESD4Lx84+xUsbp3q7XyH3v/9doils2
	 tdCC4MX7qU3hz8Daggwjo+wECPAKEesDLITWhl0JEUKqVl407mZ1SB2FkhMl2I7w2V
	 rAt0ogT9ctFKdrMz/bjuFJdbfcguTjQugyFhlhJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbfDVTtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:49:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730852AbfDVTt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:49:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 946302075A;
        Mon, 22 Apr 2019 19:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962568;
        bh=4LMSCIR1Th0mz8SSjIH8jn9qHmI65qaQLfDcxCqkh5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k6R9LypMqZPLLo/gKrvPfGslvdMGWQwN6lmmHIxZHHfYTmmiQhhwn2zck1aB2kYEO
         /r5BfA/BTaW7cCAgC5C20yM9DYiE4CdEtkeMHLXCuBasDKqCixTnmsymkUj4860YZE
         JzKX5g3fjR3pJx8ib94u5//tDmPbWji4MRtuVOn4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wen Yang <wen.yang99@zte.com.cn>, Wingman Kwok <w-kwok2@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 20/29] net: ethernet: ti: fix possible object reference leak
Date:   Mon, 22 Apr 2019 15:48:39 -0400
Message-Id: <20190422194848.13049-20-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194848.13049-1-sashal@kernel.org>
References: <20190422194848.13049-1-sashal@kernel.org>
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
index d543298d6750..ff24524e7f46 100644
--- a/drivers/net/ethernet/ti/netcp_ethss.c
+++ b/drivers/net/ethernet/ti/netcp_ethss.c
@@ -3122,12 +3122,16 @@ static int gbe_probe(struct netcp_device *netcp_device, struct device *dev,
 
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

