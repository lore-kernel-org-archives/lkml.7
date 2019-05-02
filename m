Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9940C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE7020C01
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556811064;
	bh=H4BmzPu75TbcvgMnOx08EDQr38HeGXYDIua4wtQW1U4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xPduHMv/drlE5/UHG2Bz6L1QEmqmy5bm8yBw35poYW82eKup8rVr3MU63ApoupgRC
	 W3g1p595j4Ry0hMzRUuCfKWd09Exjce2M34i0k8O770cK2H8w27oqrLL18WfWIF7z7
	 AjTU+5Gb10M5LDGSw1dT+qqtrVpY8/cRzf4d2R5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbfEBPbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:31:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728901AbfEBPbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:31:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 743A820B7C;
        Thu,  2 May 2019 15:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556811061;
        bh=H4BmzPu75TbcvgMnOx08EDQr38HeGXYDIua4wtQW1U4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J0vfiolCHnpUrzSqPJaeblTuMHax0UQrUPTTgAlhSu4lX2W07y+/RjNbGcRpPh5YQ
         Sa0sbppFhIvbY/WDsKY7kpcoCyGzA98W7Ov4oTbSCTOyrehhmKVqFcaSI3Mfq6yuai
         YFPUN8bBUka/lLeZW5EU6Ibo6WIePYYV+d0ZC/kw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        Wingman Kwok <w-kwok2@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 5.0 058/101] net: ethernet: ti: fix possible object reference leak
Date:   Thu,  2 May 2019 17:21:00 +0200
Message-Id: <20190502143343.551515987@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143339.434882399@linuxfoundation.org>
References: <20190502143339.434882399@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



