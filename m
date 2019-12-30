Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61094C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 14:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C36206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 14:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dlink.ru header.i=@dlink.ru header.b="fYhcqLol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfL3OeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 09:34:09 -0500
Received: from mail.dlink.ru ([178.170.168.18]:42950 "EHLO fd.dlink.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727538AbfL3OeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 09:34:09 -0500
Received: by fd.dlink.ru (Postfix, from userid 5000)
        id 87E981B2182A; Mon, 30 Dec 2019 17:34:05 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru 87E981B2182A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dlink.ru; s=mail;
        t=1577716445; bh=oIQhxpQSU+of0GS4enDiLZVDRRd/vUUBvg7EXVnvZnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fYhcqLolt1EhnpUopLGMSCLx9VpOQgXu/zRNEWuyCigv50pasfgr1/RzL2USUkerA
         uu1BpXhpwBwAaVqvkPvnai4JOWLNZ+UsA6tVrJN5ixnmZ7t+7mFvNS2DY+9BNMU+0u
         QfY1FbHU+6IyksnyTnh/Drtnk3DJOLt8ijzfnI4Y=
Received: from mail.rzn.dlink.ru (mail.rzn.dlink.ru [178.170.168.13])
        by fd.dlink.ru (Postfix) with ESMTP id AD2C11B20206;
        Mon, 30 Dec 2019 17:31:43 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru AD2C11B20206
Received: from mail.rzn.dlink.ru (localhost [127.0.0.1])
        by mail.rzn.dlink.ru (Postfix) with ESMTP id BE9641B229CB;
        Mon, 30 Dec 2019 17:31:41 +0300 (MSK)
Received: from localhost.localdomain (unknown [196.196.203.126])
        by mail.rzn.dlink.ru (Postfix) with ESMTPA;
        Mon, 30 Dec 2019 17:31:41 +0300 (MSK)
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
Subject: [PATCH RFC net-next 20/20] net: core: add (unlikely) DSA support in napi_gro_frags()
Date:   Mon, 30 Dec 2019 17:30:28 +0300
Message-Id: <20191230143028.27313-21-alobakin@dlink.ru>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191230143028.27313-1-alobakin@dlink.ru>
References: <20191230143028.27313-1-alobakin@dlink.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make napi_gro_frags() available for DSA-enabled device drivers by adding
the same condition for them as the one in eth_type_trans().

Signed-off-by: Alexander Lobakin <alobakin@dlink.ru>
---
 net/core/dev.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index f1b8afcfbc0f..923b930a4506 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -142,6 +142,7 @@
 #include <linux/net_namespace.h>
 #include <linux/indirect_call_wrapper.h>
 #include <net/devlink.h>
+#include <net/dsa.h>
 
 #include "net-sysfs.h"
 
@@ -5951,6 +5952,7 @@ static gro_result_t napi_frags_finish(struct napi_struct *napi,
  */
 static struct sk_buff *napi_frags_skb(struct napi_struct *napi)
 {
+	struct net_device *dev = napi->dev;
 	struct sk_buff *skb = napi->skb;
 	const struct ethhdr *eth;
 	unsigned int hlen = sizeof(*eth);
@@ -5964,7 +5966,7 @@ static struct sk_buff *napi_frags_skb(struct napi_struct *napi)
 		eth = skb_gro_header_slow(skb, hlen, 0);
 		if (unlikely(!eth)) {
 			net_warn_ratelimited("%s: dropping impossible skb from %s\n",
-					     __func__, napi->dev->name);
+					     __func__, dev->name);
 			napi_reuse_skb(napi, skb);
 			return NULL;
 		}
@@ -5978,10 +5980,13 @@ static struct sk_buff *napi_frags_skb(struct napi_struct *napi)
 
 	/*
 	 * This works because the only protocols we care about don't require
-	 * special handling.
+	 * special handling... except for DSA.
 	 * We'll fix it up properly in napi_frags_finish()
 	 */
-	skb->protocol = eth->h_proto;
+	if (unlikely(netdev_uses_dsa(dev)) && dsa_can_decode(skb, dev))
+		skb->protocol = htons(ETH_P_XDSA);
+	else
+		skb->protocol = eth->h_proto;
 
 	return skb;
 }
-- 
2.24.1

