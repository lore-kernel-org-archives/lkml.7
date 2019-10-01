Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE104ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929BD206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569948957;
	bh=Yxl65tRtauaDS2ACA8wLQ/MJvNUzQFwwxmwfmyU6yTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rbJDY7NRWe0SLT5k2Jv2SsFN/WcIp5zQCHdev2I836tFIDK9tN/YuTz7Mz+MhUyUN
	 lItK+90MlXMpRhmPWXCp0SPPamx2HOPR35jKbZNtxD0zwW8tfmw5xAeTO0pyVgP9O3
	 ByI1O/+nM4x2ZINDx1FEaFfxUZNrWiEH7QM3Jy8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731890AbfJAQz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:55:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731852AbfJAQmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:42:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26B0921906;
        Tue,  1 Oct 2019 16:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569948138;
        bh=Yxl65tRtauaDS2ACA8wLQ/MJvNUzQFwwxmwfmyU6yTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WZl92/ShZydHDmGUDtCoPyhpb+kxEbJacA0nUsBGk5KSEIAgld4AyMbxtSzbis3zw
         JFhzF9/cbcfx2tbWphuNzkbU8xhVZCMXjOd2QnPMLHjaEVT8ZbrRohfJ+cP0gXIlUP
         jWIGafLM4cXqf2R2n9F1VB3r8oUrXtsPS3+zU0f0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 38/63] arcnet: provide a buffer big enough to actually receive packets
Date:   Tue,  1 Oct 2019 12:41:00 -0400
Message-Id: <20191001164125.15398-38-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001164125.15398-1-sashal@kernel.org>
References: <20191001164125.15398-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 02a07046834e64970f3bcd87a422ac2b0adb80de ]

struct archdr is only big enough to hold the header of various types of
arcnet packets. So to provide enough space to hold the data read from
hardware provide a buffer large enough to hold a packet with maximal
size.

The problem was noticed by the stack protector which makes the kernel
oops.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/arcnet/arcnet.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/net/arcnet/arcnet.c b/drivers/net/arcnet/arcnet.c
index 8459115d9d4e5..553776cc1d29d 100644
--- a/drivers/net/arcnet/arcnet.c
+++ b/drivers/net/arcnet/arcnet.c
@@ -1063,31 +1063,34 @@ EXPORT_SYMBOL(arcnet_interrupt);
 static void arcnet_rx(struct net_device *dev, int bufnum)
 {
 	struct arcnet_local *lp = netdev_priv(dev);
-	struct archdr pkt;
+	union {
+		struct archdr pkt;
+		char buf[512];
+	} rxdata;
 	struct arc_rfc1201 *soft;
 	int length, ofs;
 
-	soft = &pkt.soft.rfc1201;
+	soft = &rxdata.pkt.soft.rfc1201;
 
-	lp->hw.copy_from_card(dev, bufnum, 0, &pkt, ARC_HDR_SIZE);
-	if (pkt.hard.offset[0]) {
-		ofs = pkt.hard.offset[0];
+	lp->hw.copy_from_card(dev, bufnum, 0, &rxdata.pkt, ARC_HDR_SIZE);
+	if (rxdata.pkt.hard.offset[0]) {
+		ofs = rxdata.pkt.hard.offset[0];
 		length = 256 - ofs;
 	} else {
-		ofs = pkt.hard.offset[1];
+		ofs = rxdata.pkt.hard.offset[1];
 		length = 512 - ofs;
 	}
 
 	/* get the full header, if possible */
-	if (sizeof(pkt.soft) <= length) {
-		lp->hw.copy_from_card(dev, bufnum, ofs, soft, sizeof(pkt.soft));
+	if (sizeof(rxdata.pkt.soft) <= length) {
+		lp->hw.copy_from_card(dev, bufnum, ofs, soft, sizeof(rxdata.pkt.soft));
 	} else {
-		memset(&pkt.soft, 0, sizeof(pkt.soft));
+		memset(&rxdata.pkt.soft, 0, sizeof(rxdata.pkt.soft));
 		lp->hw.copy_from_card(dev, bufnum, ofs, soft, length);
 	}
 
 	arc_printk(D_DURING, dev, "Buffer #%d: received packet from %02Xh to %02Xh (%d+4 bytes)\n",
-		   bufnum, pkt.hard.source, pkt.hard.dest, length);
+		   bufnum, rxdata.pkt.hard.source, rxdata.pkt.hard.dest, length);
 
 	dev->stats.rx_packets++;
 	dev->stats.rx_bytes += length + ARC_HDR_SIZE;
@@ -1096,13 +1099,13 @@ static void arcnet_rx(struct net_device *dev, int bufnum)
 	if (arc_proto_map[soft->proto]->is_ip) {
 		if (BUGLVL(D_PROTO)) {
 			struct ArcProto
-			*oldp = arc_proto_map[lp->default_proto[pkt.hard.source]],
+			*oldp = arc_proto_map[lp->default_proto[rxdata.pkt.hard.source]],
 			*newp = arc_proto_map[soft->proto];
 
 			if (oldp != newp) {
 				arc_printk(D_PROTO, dev,
 					   "got protocol %02Xh; encap for host %02Xh is now '%c' (was '%c')\n",
-					   soft->proto, pkt.hard.source,
+					   soft->proto, rxdata.pkt.hard.source,
 					   newp->suffix, oldp->suffix);
 			}
 		}
@@ -1111,10 +1114,10 @@ static void arcnet_rx(struct net_device *dev, int bufnum)
 		lp->default_proto[0] = soft->proto;
 
 		/* in striking contrast, the following isn't a hack. */
-		lp->default_proto[pkt.hard.source] = soft->proto;
+		lp->default_proto[rxdata.pkt.hard.source] = soft->proto;
 	}
 	/* call the protocol-specific receiver. */
-	arc_proto_map[soft->proto]->rx(dev, bufnum, &pkt, length);
+	arc_proto_map[soft->proto]->rx(dev, bufnum, &rxdata.pkt, length);
 }
 
 static void null_rx(struct net_device *dev, int bufnum,
-- 
2.20.1

