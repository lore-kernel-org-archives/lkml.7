Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E52C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 14:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559BC206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 14:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dlink.ru header.i=@dlink.ru header.b="q7IfbC9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfL3OdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 09:33:08 -0500
Received: from mail.dlink.ru ([178.170.168.18]:41842 "EHLO fd.dlink.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727543AbfL3OdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 09:33:07 -0500
Received: by fd.dlink.ru (Postfix, from userid 5000)
        id 55A1E1B2176F; Mon, 30 Dec 2019 17:33:03 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru 55A1E1B2176F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dlink.ru; s=mail;
        t=1577716385; bh=NXl5VU/NmF4XHV2zVViXhu4aInL/BB6UJlu0+qQYx4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=q7IfbC9g1WsWcW3ct9wr1eTtowNwVWxCnUosrdhrbuK7bQeAYIVEJiScpiechbmcw
         UAJ2liXVJUMxB7sgm+B2GhN/wHMhI8RrIuveFE87p4Pj9siYz90QIC1thEsZeenG6u
         9zljbPGtqHgTtNeyFCrTOkqwT8QADsHn+fQCgr0E=
Received: from mail.rzn.dlink.ru (mail.rzn.dlink.ru [178.170.168.13])
        by fd.dlink.ru (Postfix) with ESMTP id 1C4DF1B217AA;
        Mon, 30 Dec 2019 17:31:19 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru 1C4DF1B217AA
Received: from mail.rzn.dlink.ru (localhost [127.0.0.1])
        by mail.rzn.dlink.ru (Postfix) with ESMTP id DF39D1B229D0;
        Mon, 30 Dec 2019 17:31:16 +0300 (MSK)
Received: from localhost.localdomain (unknown [196.196.203.126])
        by mail.rzn.dlink.ru (Postfix) with ESMTPA;
        Mon, 30 Dec 2019 17:31:16 +0300 (MSK)
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
Subject: [PATCH RFC net-next 08/19] net: dsa: tag_gswip: add .flow_dissect() callback
Date:   Mon, 30 Dec 2019 17:30:16 +0300
Message-Id: <20191230143028.27313-9-alobakin@dlink.ru>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191230143028.27313-1-alobakin@dlink.ru>
References: <20191230143028.27313-1-alobakin@dlink.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case user would like to configure RPS on such systems.
Misc: fix identation of gswip_netdev_ops structure.

Signed-off-by: Alexander Lobakin <alobakin@dlink.ru>
---
 net/dsa/tag_gswip.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/dsa/tag_gswip.c b/net/dsa/tag_gswip.c
index de920f6aac5b..d37289540ef3 100644
--- a/net/dsa/tag_gswip.c
+++ b/net/dsa/tag_gswip.c
@@ -97,12 +97,20 @@ static struct sk_buff *gswip_tag_rcv(struct sk_buff *skb,
 	return skb;
 }
 
+static void gswip_tag_flow_dissect(const struct sk_buff *skb, __be16 *proto,
+				   int *offset)
+{
+	*offset = GSWIP_RX_HEADER_LEN;
+	*proto = *(__be16 *)(skb->data + 6);
+}
+
 static const struct dsa_device_ops gswip_netdev_ops = {
-	.name = "gswip",
-	.proto	= DSA_TAG_PROTO_GSWIP,
-	.xmit = gswip_tag_xmit,
-	.rcv = gswip_tag_rcv,
-	.overhead = GSWIP_RX_HEADER_LEN,
+	.name		= "gswip",
+	.proto		= DSA_TAG_PROTO_GSWIP,
+	.xmit		= gswip_tag_xmit,
+	.rcv		= gswip_tag_rcv,
+	.flow_dissect	= gswip_tag_flow_dissect,
+	.overhead	= GSWIP_RX_HEADER_LEN,
 };
 
 MODULE_LICENSE("GPL");
-- 
2.24.1

