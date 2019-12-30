Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE976C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 14:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D712071E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 14:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dlink.ru header.i=@dlink.ru header.b="iQLU0DZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfL3Obz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 09:31:55 -0500
Received: from mail.dlink.ru ([178.170.168.18]:40070 "EHLO fd.dlink.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727397AbfL3Obz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 09:31:55 -0500
Received: by fd.dlink.ru (Postfix, from userid 5000)
        id EC3991B205DF; Mon, 30 Dec 2019 17:31:52 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru EC3991B205DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dlink.ru; s=mail;
        t=1577716313; bh=18voDyGBMtcwId3z4bi4wS1wyOebnKJGhqqk04an6a0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iQLU0DZfS2ARZJQSoCBYhABscHZQr0JgJNiEKhpGUuZBFdlf2/mzRHdDXeUsh8qbk
         Jy7Q+RLhH+MN/jiJ2fTC4aoUW8UfsFiIe5JB75aFQZ3efdWXA1fwcSZbKJWxDvBCMi
         blmJygWcLItkSbGCtLgIBcHq5eg1+Qf15PfC9Lh0=
Received: from mail.rzn.dlink.ru (mail.rzn.dlink.ru [178.170.168.13])
        by fd.dlink.ru (Postfix) with ESMTP id D7C7E1B205DF;
        Mon, 30 Dec 2019 17:31:08 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru D7C7E1B205DF
Received: from mail.rzn.dlink.ru (localhost [127.0.0.1])
        by mail.rzn.dlink.ru (Postfix) with ESMTP id 1E48A1B229D1;
        Mon, 30 Dec 2019 17:31:07 +0300 (MSK)
Received: from localhost.localdomain (unknown [196.196.203.126])
        by mail.rzn.dlink.ru (Postfix) with ESMTPA;
        Mon, 30 Dec 2019 17:31:07 +0300 (MSK)
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
Subject: [PATCH RFC net-next 03/19] net: dsa: tag_ar9331: add .flow_dissect() callback
Date:   Mon, 30 Dec 2019 17:30:11 +0300
Message-Id: <20191230143028.27313-4-alobakin@dlink.ru>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191230143028.27313-1-alobakin@dlink.ru>
References: <20191230143028.27313-1-alobakin@dlink.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...to make RPS work correctly if user would like to configure it.
Misc: fix identation of ar9331_netdev_ops structure.

Signed-off-by: Alexander Lobakin <alobakin@dlink.ru>
---
 net/dsa/tag_ar9331.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/dsa/tag_ar9331.c b/net/dsa/tag_ar9331.c
index 466ffa92a474..399ca21ec03b 100644
--- a/net/dsa/tag_ar9331.c
+++ b/net/dsa/tag_ar9331.c
@@ -83,12 +83,20 @@ static struct sk_buff *ar9331_tag_rcv(struct sk_buff *skb,
 	return skb;
 }
 
+static void ar9331_tag_flow_dissect(const struct sk_buff *skb, __be16 *proto,
+				    int *offset)
+{
+	*offset = AR9331_HDR_LEN;
+	*proto = *(__be16 *)skb->data;
+}
+
 static const struct dsa_device_ops ar9331_netdev_ops = {
-	.name	= "ar9331",
-	.proto	= DSA_TAG_PROTO_AR9331,
-	.xmit	= ar9331_tag_xmit,
-	.rcv	= ar9331_tag_rcv,
-	.overhead = AR9331_HDR_LEN,
+	.name		= "ar9331",
+	.proto		= DSA_TAG_PROTO_AR9331,
+	.xmit		= ar9331_tag_xmit,
+	.rcv		= ar9331_tag_rcv,
+	.flow_dissect	= ar9331_tag_flow_dissect,
+	.overhead	= AR9331_HDR_LEN,
 };
 
 MODULE_LICENSE("GPL v2");
-- 
2.24.1

