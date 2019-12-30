Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E35C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 14:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4BF20730
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 14:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dlink.ru header.i=@dlink.ru header.b="HjAWVF7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfL3OcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 09:32:24 -0500
Received: from mail.dlink.ru ([178.170.168.18]:40796 "EHLO fd.dlink.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727661AbfL3OcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 09:32:20 -0500
Received: by fd.dlink.ru (Postfix, from userid 5000)
        id 78B151B21990; Mon, 30 Dec 2019 17:32:17 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru 78B151B21990
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dlink.ru; s=mail;
        t=1577716337; bh=SYnifMPQP4kzdSLpDkUORDps+aCxCuIpXYmwM1fEL9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=HjAWVF7fJOydlUu7w4y+Nj7t3lh9CsZSwnpvNJrr9JZgyGQ2iKuBzLZB12ahEdSI/
         kFoLJ6RIJtMyn8A9Yo6Q7CH8w24P1jKYfI711/d6vpyLzP6CkHYgKPE9nTxPytuePA
         c2xf96yt8jcMptCMC806qRahzuNRJpLHM9L+G27I=
Received: from mail.rzn.dlink.ru (mail.rzn.dlink.ru [178.170.168.13])
        by fd.dlink.ru (Postfix) with ESMTP id 3C8BB1B21825;
        Mon, 30 Dec 2019 17:31:29 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru 3C8BB1B21825
Received: from mail.rzn.dlink.ru (localhost [127.0.0.1])
        by mail.rzn.dlink.ru (Postfix) with ESMTP id 678DC1B229D0;
        Mon, 30 Dec 2019 17:31:27 +0300 (MSK)
Received: from localhost.localdomain (unknown [196.196.203.126])
        by mail.rzn.dlink.ru (Postfix) with ESMTPA;
        Mon, 30 Dec 2019 17:31:27 +0300 (MSK)
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
Subject: [PATCH RFC net-next 13/19] net: dsa: tag_lan9303: add GRO callbacks
Date:   Mon, 30 Dec 2019 17:30:21 +0300
Message-Id: <20191230143028.27313-14-alobakin@dlink.ru>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191230143028.27313-1-alobakin@dlink.ru>
References: <20191230143028.27313-1-alobakin@dlink.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GRO callbacks for LAN9303 tagger to make GRO available for frames
tagged with it.

Signed-off-by: Alexander Lobakin <alobakin@dlink.ru>
---
 net/dsa/tag_lan9303.c | 77 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/net/dsa/tag_lan9303.c b/net/dsa/tag_lan9303.c
index ba03502986a4..77aba4311f2d 100644
--- a/net/dsa/tag_lan9303.c
+++ b/net/dsa/tag_lan9303.c
@@ -151,12 +151,89 @@ static void lan9303_flow_dissect(const struct sk_buff *skb, __be16 *proto,
 	*proto = lan9303_encap_proto(skb->data);
 }
 
+static struct sk_buff *lan9303_gro_receive(struct list_head *head,
+					   struct sk_buff *skb)
+{
+	const struct packet_offload *ptype;
+	struct sk_buff *p, *pp = NULL;
+	const u8 *data, *data_p;
+	u32 data_off, data_end;
+	int flush = 1;
+
+	data_off = skb_gro_offset(skb);
+	data_end = data_off + LAN9303_TAG_LEN;
+
+	data = skb_gro_header_fast(skb, data_off);
+	if (skb_gro_header_hard(skb, data_end)) {
+		data = skb_gro_header_slow(skb, data_end, data_off);
+		if (unlikely(!data))
+			goto out;
+	}
+
+	/* Data that is to the left to the current position is already
+	 * pulled to the head
+	 */
+	if (!lan9303_sanity_check(skb->data + data_off))
+		goto out;
+
+	rcu_read_lock();
+
+	ptype = gro_find_receive_by_type(lan9303_encap_proto(data));
+	if (!ptype)
+		goto out_unlock;
+
+	flush = 0;
+
+	list_for_each_entry(p, head, list) {
+		if (!NAPI_GRO_CB(p)->same_flow)
+			continue;
+
+		data_p = p->data + data_off;
+		if (lan9303_source_port(data) ^ lan9303_source_port(data_p))
+			NAPI_GRO_CB(p)->same_flow = 0;
+	}
+
+	skb_gro_pull(skb, LAN9303_TAG_LEN);
+	skb_gro_postpull_rcsum(skb, data, LAN9303_TAG_LEN);
+
+	pp = call_gro_receive(ptype->callbacks.gro_receive, head, skb);
+
+out_unlock:
+	rcu_read_unlock();
+out:
+	skb_gro_flush_final(skb, pp, flush);
+
+	return pp;
+}
+
+static int lan9303_gro_complete(struct sk_buff *skb, int nhoff)
+{
+	const struct packet_offload *ptype;
+	int err = -ENOENT;
+	__be16 proto;
+
+	proto = lan9303_encap_proto(skb->data + nhoff);
+	nhoff += LAN9303_TAG_LEN;
+
+	rcu_read_lock();
+
+	ptype = gro_find_complete_by_type(proto);
+	if (ptype)
+		err = ptype->callbacks.gro_complete(skb, nhoff);
+
+	rcu_read_unlock();
+
+	return err;
+}
+
 static const struct dsa_device_ops lan9303_netdev_ops = {
 	.name		= "lan9303",
 	.proto		= DSA_TAG_PROTO_LAN9303,
 	.xmit		= lan9303_xmit,
 	.rcv		= lan9303_rcv,
 	.flow_dissect	= lan9303_flow_dissect,
+	.gro_receive	= lan9303_gro_receive,
+	.gro_complete	= lan9303_gro_complete,
 	.overhead	= LAN9303_TAG_LEN,
 };
 
-- 
2.24.1

