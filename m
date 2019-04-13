Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F907C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25B7620850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5J/TuVw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfDMB2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 21:28:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39556 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbfDMB2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 21:28:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id n25so12998286wmk.4;
        Fri, 12 Apr 2019 18:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9cWj4xQqA+GWCHrHu4/kVBdzTRwBkOxunvX43iPa314=;
        b=b5J/TuVwEodJuAjtGoToluhBcqW0/7F6U5VfXYd2ia2UlOLMKgycEjwB3ERs8KyiMx
         vaeZwb+pAP9yZiYeQjtEGfKu+1osCYPd38Bubu5LOklA87aS8k8bz3ocp20HdYEpeFvS
         2vwxAvsW554yd4tRK3ptH0JRAJfKiUZimKhwvHm7hGD2zaQlhurHtVnCw0EocIDqiRBe
         DD9gN2c6KJnE1qaPQl8MZbOocG3WPihOFf8TjoEe8LdJjeRStOY0XujSHruF8cXGxmCQ
         FACxz1N5+Tc81va9AM+15hpeTWOspQdXc895crP4vrOTqDQAIs3jpfpdyv6E9dWOu2hO
         VBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9cWj4xQqA+GWCHrHu4/kVBdzTRwBkOxunvX43iPa314=;
        b=e/RXCIOQHjXjXUOoeqxVz4VpBAEm7lDamB+1Avq6zO1PGy6vBn8mx1jghkXalfEpNH
         /Pzxjea6kfmZe7J6zAmAqV8ppQtH5P4vbOAuvIza+vOGBxasGTzvAzHPtl0mbf8ngciW
         8aFO7xADcZ+5b9kOrrXli0LkoelJAdAtDCQghOhAcJ+RZXKsAp9MM0Dp6qfh6/qhXP3z
         qS7a4Ril8cV80eX3mhYPsy0++GF4TUp7m75CLZSBaRjVQrCn6/Pg3F4XwKQeCg1kKiBf
         PlfS4WkKPVlpw2qrP+JYsIQ0Sy2LphR4anw6u0b41e4N0gTB11b2dcu65DSwKWzkJzWK
         3WzQ==
X-Gm-Message-State: APjAAAW1bVYfPNybqd+JeCXCyucEb2QbsFum7JSpBvuSnBU1hH8bOQqO
        FxAQXgdQeZxQbzK30teGnonwqHCF4v4=
X-Google-Smtp-Source: APXvYqzRdigkm6D7IEqg4UVxo/JC13bzF1IDJZguiePFqnaZZ6JSGhLH3nctMKMLtbnXxrLLaAR+fw==
X-Received: by 2002:a7b:c054:: with SMTP id u20mr13302990wmc.100.1555118925317;
        Fri, 12 Apr 2019 18:28:45 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id r9sm8053141wmh.38.2019.04.12.18.28.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 18:28:44 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v3 net-next 13/24] net: dsa: Allow drivers to filter packets they can decode source port from
Date:   Sat, 13 Apr 2019 04:28:11 +0300
Message-Id: <20190413012822.30931-14-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190413012822.30931-1-olteanv@gmail.com>
References: <20190413012822.30931-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frames get processed by DSA and redirected to switch port net devices
based on the ETH_P_XDSA multiplexed packet_type handler found by the
network stack when calling eth_type_trans().

The running assumption is that once the DSA .rcv function is called, DSA
is always able to decode the switch tag in order to change the skb->dev
from its master.

However there are tagging protocols (such as the new DSA_TAG_PROTO_SJA1105,
user of DSA_TAG_PROTO_8021Q) where this assumption is not completely
true, since switch tagging piggybacks on the absence of a vlan_filtering
bridge. Moreover, management traffic (BPDU, PTP) for this switch doesn't
rely on switch tagging, but on a different mechanism. So it would make
sense to at least be able to terminate that.

Having DSA receive traffic it can't decode would put it in an impossible
situation: the eth_type_trans() function would invoke the DSA .rcv(),
which could not change skb->dev, then eth_type_trans() would be invoked
again, which again would call the DSA .rcv, and the packet would never
be able to exit the DSA filter and would spiral in a loop until the
whole system dies.

This happens because eth_type_trans() doesn't actually look at the skb
(so as to identify a potential tag) when it deems it as being
ETH_P_XDSA. It just checks whether skb->dev has a DSA private pointer
installed (therefore it's a DSA master) and that there exists a .rcv
callback (everybody except DSA_TAG_PROTO_NONE has that). This is
understandable as there are many switch tags out there, and exhaustively
checking for all of them is far from ideal.

The solution lies in introducing a filtering function for each tagging
protocol. In the absence of a filtering function, all traffic is passed
to the .rcv DSA callback. The tagging protocol should see the filtering
function as a pre-validation that it can decode the incoming skb. The
traffic that doesn't match the filter will bypass the DSA .rcv callback
and be left on the master netdevice, which wasn't previously possible.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
Changes in v3:
Reworked from a simple boolean (uses_tag_protocol) into a function where
the driver has full insight into both the skb as well as the state of
the master netdevice (and implicitly the cpu_dp and the entire DSA
switch tree).

Changes in v2:
Patch is new.

 include/net/dsa.h  | 15 +++++++++++++++
 net/dsa/dsa2.c     |  1 +
 net/dsa/legacy.c   |  1 +
 net/ethernet/eth.c |  6 +++++-
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 94a9f096568d..e46c107507d8 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -55,6 +55,11 @@ struct dsa_device_ops {
 			       struct packet_type *pt);
 	int (*flow_dissect)(const struct sk_buff *skb, __be16 *proto,
 			    int *offset);
+	/* Used to determine which traffic should match the DSA filter in
+	 * eth_type_trans, and which, if any, should bypass it and be processed
+	 * as regular on the master net device.
+	 */
+	bool (*filter)(const struct sk_buff *skb, struct net_device *dev);
 	unsigned int overhead;
 };
 
@@ -128,6 +133,7 @@ struct dsa_port {
 	struct dsa_switch_tree *dst;
 	struct sk_buff *(*rcv)(struct sk_buff *skb, struct net_device *dev,
 			       struct packet_type *pt);
+	bool (*filter)(const struct sk_buff *skb, struct net_device *dev);
 
 	enum {
 		DSA_PORT_TYPE_UNUSED = 0,
@@ -508,6 +514,15 @@ static inline bool netdev_uses_dsa(struct net_device *dev)
 	return false;
 }
 
+static inline bool dsa_can_decode(const struct sk_buff *skb,
+				  struct net_device *dev)
+{
+#if IS_ENABLED(CONFIG_NET_DSA)
+	return !dev->dsa_ptr->filter || dev->dsa_ptr->filter(skb, dev);
+#endif
+	return false;
+}
+
 struct dsa_switch *dsa_switch_alloc(struct device *dev, size_t n);
 void dsa_unregister_switch(struct dsa_switch *ds);
 int dsa_register_switch(struct dsa_switch *ds);
diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
index 17817c1a7fbd..e28cc98cf358 100644
--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -584,6 +584,7 @@ static int dsa_port_parse_cpu(struct dsa_port *dp, struct net_device *master)
 	}
 
 	dp->type = DSA_PORT_TYPE_CPU;
+	dp->filter = tag_ops->filter;
 	dp->rcv = tag_ops->rcv;
 	dp->tag_ops = tag_ops;
 	dp->master = master;
diff --git a/net/dsa/legacy.c b/net/dsa/legacy.c
index cb42939db776..33cb4e7cf74b 100644
--- a/net/dsa/legacy.c
+++ b/net/dsa/legacy.c
@@ -159,6 +159,7 @@ static int dsa_switch_setup_one(struct dsa_switch *ds,
 		dst->cpu_dp->tag_ops = tag_ops;
 
 		/* Few copies for faster access in master receive hot path */
+		dst->cpu_dp->filter = dst->cpu_dp->tag_ops->filter;
 		dst->cpu_dp->rcv = dst->cpu_dp->tag_ops->rcv;
 		dst->cpu_dp->dst = dst;
 	}
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index f7a3d7a171c7..0c984bb01c0a 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -183,8 +183,12 @@ __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev)
 	 * at all, so we check here whether one of those tagging
 	 * variants has been configured on the receiving interface,
 	 * and if so, set skb->protocol without looking at the packet.
+	 * The DSA tagging protocol may be able to decode some but not all
+	 * traffic (for example only for management). In that case give it the
+	 * option to filter the packets from which it can decode source port
+	 * information.
 	 */
-	if (unlikely(netdev_uses_dsa(dev)))
+	if (unlikely(netdev_uses_dsa(dev)) && dsa_can_decode(skb, dev))
 		return htons(ETH_P_XDSA);
 
 	if (likely(eth_proto_is_802_3(eth->h_proto)))
-- 
2.17.1

