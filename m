Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B30C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 14:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45ECE2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 14:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dlink.ru header.i=@dlink.ru header.b="HHvUKrU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfL3OdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 09:33:11 -0500
Received: from mail.dlink.ru ([178.170.168.18]:41872 "EHLO fd.dlink.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbfL3OdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 09:33:10 -0500
Received: by fd.dlink.ru (Postfix, from userid 5000)
        id 36C071B2196B; Mon, 30 Dec 2019 17:33:04 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru 36C071B2196B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dlink.ru; s=mail;
        t=1577716387; bh=oevogiD6ZZjPjhds8OttybiSWL3W+YH+lNJv5xktFv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=HHvUKrU9njVz7eRTFBtWVcJqgiN98W16NbF+L4eCilFnxxjJS9ZFwyEldY9xsL7kO
         /rVUwlNrY7C6XSNZtZvUNFGbDDzyy144NEFHCQInQhc6scjh5kIrxhEIlHAoknozuU
         07FCzo+AMG+P8XnzVcaQbIhY3ToLZdSJT4uVPsus=
Received: from mail.rzn.dlink.ru (mail.rzn.dlink.ru [178.170.168.13])
        by fd.dlink.ru (Postfix) with ESMTP id 0E58B1B2176F;
        Mon, 30 Dec 2019 17:31:17 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru 0E58B1B2176F
Received: from mail.rzn.dlink.ru (localhost [127.0.0.1])
        by mail.rzn.dlink.ru (Postfix) with ESMTP id D02B21B229CB;
        Mon, 30 Dec 2019 17:31:14 +0300 (MSK)
Received: from localhost.localdomain (unknown [196.196.203.126])
        by mail.rzn.dlink.ru (Postfix) with ESMTPA;
        Mon, 30 Dec 2019 17:31:14 +0300 (MSK)
From:   Alexander Lobakin <alobakin@dlink.ru>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Edward Cree <ecree@solarflare.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Alexander Lobakin <alobakin@dlink.ru>,
        Taehee Yoo <ap420073@gmail.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Matteo Croce <mcroce@redhat.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Paul Blakey <paulb@mellanox.com>,
        Yoshiki Komachi <komachi.yoshiki@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH RFC net-next 07/19] net: dsa: tag_gswip: switch to bitfield helpers
Date:   Mon, 30 Dec 2019 17:30:15 +0300
Message-Id: <20191230143028.27313-8-alobakin@dlink.ru>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191230143028.27313-1-alobakin@dlink.ru>
References: <20191230143028.27313-1-alobakin@dlink.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make code look cleaner and more readable by using bitfield macros instead
of open-coding masks and shifts.
Misc: remove redundant variable in gswip_tag_xmit(), make dsa_port const.

Signed-off-by: Alexander Lobakin <alobakin@dlink.ru>
---
 net/dsa/tag_gswip.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/net/dsa/tag_gswip.c b/net/dsa/tag_gswip.c
index 408d4af390a0..de920f6aac5b 100644
--- a/net/dsa/tag_gswip.c
+++ b/net/dsa/tag_gswip.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2017 - 2018 Hauke Mehrtens <hauke@hauke-m.de>
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
@@ -45,26 +46,22 @@
 #define GSWIP_TX_CLASS_MASK		GENMASK(3, 0)
 
 /* Byte 3 */
+#define GSWIP_TX_PORT_MAP(port)		FIELD_PREP(GENMASK(6, 1), BIT(port))
 #define GSWIP_TX_DPID_EN		BIT(0)
-#define GSWIP_TX_PORT_MAP_SHIFT		1
-#define GSWIP_TX_PORT_MAP_MASK		GENMASK(6, 1)
 
-#define GSWIP_RX_HEADER_LEN	8
+#define GSWIP_RX_HEADER_LEN		8
 
 /* special tag in RX path header */
 /* Byte 7 */
-#define GSWIP_RX_SPPID_SHIFT		4
-#define GSWIP_RX_SPPID_MASK		GENMASK(6, 4)
+#define GSWIP_RX_SPPID(byte_7)		FIELD_GET(GENMASK(6, 4), byte_7)
 
 static struct sk_buff *gswip_tag_xmit(struct sk_buff *skb,
 				      struct net_device *dev)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
-	int err;
+	const struct dsa_port *dp = dsa_slave_to_port(dev);
 	u8 *gswip_tag;
 
-	err = skb_cow_head(skb, GSWIP_TX_HEADER_LEN);
-	if (err)
+	if (skb_cow_head(skb, GSWIP_TX_HEADER_LEN))
 		return NULL;
 
 	skb_push(skb, GSWIP_TX_HEADER_LEN);
@@ -73,8 +70,7 @@ static struct sk_buff *gswip_tag_xmit(struct sk_buff *skb,
 	gswip_tag[0] = GSWIP_TX_SLPID_CPU;
 	gswip_tag[1] = GSWIP_TX_DPID_ELAN;
 	gswip_tag[2] = GSWIP_TX_PORT_MAP_EN | GSWIP_TX_PORT_MAP_SEL;
-	gswip_tag[3] = BIT(dp->index + GSWIP_TX_PORT_MAP_SHIFT) & GSWIP_TX_PORT_MAP_MASK;
-	gswip_tag[3] |= GSWIP_TX_DPID_EN;
+	gswip_tag[3] = GSWIP_TX_PORT_MAP(dp->index) | GSWIP_TX_DPID_EN;
 
 	return skb;
 }
@@ -84,15 +80,13 @@ static struct sk_buff *gswip_tag_rcv(struct sk_buff *skb,
 				     struct packet_type *pt)
 {
 	int port;
-	u8 *gswip_tag;
 
 	if (unlikely(!pskb_may_pull(skb, GSWIP_RX_HEADER_LEN)))
 		return NULL;
 
-	gswip_tag = skb->data - ETH_HLEN;
-
 	/* Get source port information */
-	port = (gswip_tag[7] & GSWIP_RX_SPPID_MASK) >> GSWIP_RX_SPPID_SHIFT;
+	port = GSWIP_RX_SPPID(*(skb->data - ETH_HLEN + 7));
+
 	skb->dev = dsa_master_find_slave(dev, 0, port);
 	if (!skb->dev)
 		return NULL;
-- 
2.24.1

