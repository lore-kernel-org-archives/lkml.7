Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E059CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0662192D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255985;
	bh=TVWPEdDW+Li3XctenXGC8MA/0vXpJ8FXqxHLbG/jMLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wv58Z4bcjd2qV2Jn8afAwND2uM0OAwfcni+Qsie33niDQX9RiWUR4QdL6BCCsrBTN
	 K+4Tyjs6/i4blgiADvXV4dOYz2Ehb4aS0nPIYZljpMfb2JN0fundlwLq4Z41nbfJPx
	 uQIbE9rJEzyS0t5J2RNr8UDnll1SxuEPGAPezeEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388011AbfCVL7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:59:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387984AbfCVL7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:59:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D44E020830;
        Fri, 22 Mar 2019 11:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255978;
        bh=TVWPEdDW+Li3XctenXGC8MA/0vXpJ8FXqxHLbG/jMLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r3JE1upVpnC26ftr7nXOSfYG9tWvh3qaPkpBbt+3qvpRK19tkRuVEmcAs9Sa0EQoX
         yiDQVZY8+Rxf6Mny0ZRHaIsGaXUX+rk23VHU+QGoKfXv7LeefNKUnB6DoPJARgbRYJ
         krYaCQs5YO1U8q37L7K389tZA4tr/uqPgFsrr/Io=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 072/280] bpf: only adjust gso_size on bytestream protocols
Date:   Fri, 22 Mar 2019 12:13:45 +0100
Message-Id: <20190322111310.364484563@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit b90efd2258749e04e1b3f71ef0d716f2ac2337e0 ]

bpf_skb_change_proto and bpf_skb_adjust_room change skb header length.
For GSO packets they adjust gso_size to maintain the same MTU.

The gso size can only be safely adjusted on bytestream protocols.
Commit d02f51cbcf12 ("bpf: fix bpf_skb_adjust_net/bpf_skb_proto_xlat
to deal with gso sctp skbs") excluded SKB_GSO_SCTP.

Since then type SKB_GSO_UDP_L4 has been added, whose contents are one
gso_size unit per datagram. Also exclude these.

Move from a blacklist to a whitelist check to future proof against
additional such new GSO types, e.g., for fraglist based GRO.

Fixes: bec1f6f69736 ("udp: generate gso with UDP_SEGMENT")
Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/skbuff.h |  6 ++++++
 net/core/filter.c      | 12 ++++--------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index a404d475acee..3b0a25bb7c6f 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4086,6 +4086,12 @@ static inline bool skb_is_gso_sctp(const struct sk_buff *skb)
 	return skb_shinfo(skb)->gso_type & SKB_GSO_SCTP;
 }
 
+static inline bool skb_is_gso_tcp(const struct sk_buff *skb)
+{
+	return skb_is_gso(skb) &&
+	       skb_shinfo(skb)->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6);
+}
+
 static inline void skb_gso_reset(struct sk_buff *skb)
 {
 	skb_shinfo(skb)->gso_size = 0;
diff --git a/net/core/filter.c b/net/core/filter.c
index bed9061102f4..b1369edce113 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2614,8 +2614,7 @@ static int bpf_skb_proto_4_to_6(struct sk_buff *skb)
 	u32 off = skb_mac_header_len(skb);
 	int ret;
 
-	/* SCTP uses GSO_BY_FRAGS, thus cannot adjust it. */
-	if (skb_is_gso(skb) && unlikely(skb_is_gso_sctp(skb)))
+	if (!skb_is_gso_tcp(skb))
 		return -ENOTSUPP;
 
 	ret = skb_cow(skb, len_diff);
@@ -2656,8 +2655,7 @@ static int bpf_skb_proto_6_to_4(struct sk_buff *skb)
 	u32 off = skb_mac_header_len(skb);
 	int ret;
 
-	/* SCTP uses GSO_BY_FRAGS, thus cannot adjust it. */
-	if (skb_is_gso(skb) && unlikely(skb_is_gso_sctp(skb)))
+	if (!skb_is_gso_tcp(skb))
 		return -ENOTSUPP;
 
 	ret = skb_unclone(skb, GFP_ATOMIC);
@@ -2782,8 +2780,7 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 len_diff)
 	u32 off = skb_mac_header_len(skb) + bpf_skb_net_base_len(skb);
 	int ret;
 
-	/* SCTP uses GSO_BY_FRAGS, thus cannot adjust it. */
-	if (skb_is_gso(skb) && unlikely(skb_is_gso_sctp(skb)))
+	if (!skb_is_gso_tcp(skb))
 		return -ENOTSUPP;
 
 	ret = skb_cow(skb, len_diff);
@@ -2812,8 +2809,7 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 len_diff)
 	u32 off = skb_mac_header_len(skb) + bpf_skb_net_base_len(skb);
 	int ret;
 
-	/* SCTP uses GSO_BY_FRAGS, thus cannot adjust it. */
-	if (skb_is_gso(skb) && unlikely(skb_is_gso_sctp(skb)))
+	if (!skb_is_gso_tcp(skb))
 		return -ENOTSUPP;
 
 	ret = skb_unclone(skb, GFP_ATOMIC);
-- 
2.19.1



