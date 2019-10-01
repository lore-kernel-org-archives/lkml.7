Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D07CECE58A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35AF521A4A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569948354;
	bh=5WsXYxQaIBpr8vWoz7PKJg3VhlPuGky2A2LPmzJ/Rwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nkzu6hKDJhwSPP72ikxAn0pnqbzd/01OTVhyFirf+y12JiLj7ikUj7YMqm7PSG+V/
	 R/io0JO3AvzNHy80+HAvSE1YoxdbAK1yj2Seh/0CozdbzLdC+s4PkiTkVTAyi8v7zl
	 p/6PSHyjfTT/YWkqmAqZwsl4tjiqMT/2wdMGC2/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390424AbfJAQpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:45:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390388AbfJAQpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:45:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3035A222BE;
        Tue,  1 Oct 2019 16:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569948348;
        bh=5WsXYxQaIBpr8vWoz7PKJg3VhlPuGky2A2LPmzJ/Rwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BQna7woYLYR7kJTQHytMW+PyBZUNltn2hWtheutu0/ElSi9LMz8J3dxD0cHH7jWYz
         kf/NHvOLRpTCVLWPUfQX6TR/ydXzMlaxCHhvBhfexfhzl9ISCBIMLSdSysV39GXiTT
         WcG+rPr6UGOcjEqQdKv3fIjxeOpY1rq9n9bRX0yw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 12/15] arcnet: provide a buffer big enough to actually receive packets
Date:   Tue,  1 Oct 2019 12:45:30 -0400
Message-Id: <20191001164533.16915-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001164533.16915-1-sashal@kernel.org>
References: <20191001164533.16915-1-sashal@kernel.org>
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
index 6ea963e3b89a1..85ffd0561827e 100644
--- a/drivers/net/arcnet/arcnet.c
+++ b/drivers/net/arcnet/arcnet.c
@@ -1009,31 +1009,34 @@ EXPORT_SYMBOL(arcnet_interrupt);
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
@@ -1042,13 +1045,13 @@ static void arcnet_rx(struct net_device *dev, int bufnum)
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
@@ -1057,10 +1060,10 @@ static void arcnet_rx(struct net_device *dev, int bufnum)
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

