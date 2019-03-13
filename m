Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B50C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862942184D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504397;
	bh=FzHvRoG17K54IWiQfe8Szt+YKIB6vt1cflLjm0hIFzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GEDL94b4BXGinZA1Ckwjg7uhvLmnuQ88rABsvRkNs5OETVJyWGfbaKF5yv+vA4y++
	 DJQ8lhuQsWx86bVtssKe/tdcwz9flY3ahYpgyRte/yXzUhCGQN5rqf4WUx1ntXoFox
	 KwiVnXDtXLG68JBanGXtdszITVisRyjsjXkLCYvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfCMTNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:13:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727921AbfCMTNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:13:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 472712075C;
        Wed, 13 Mar 2019 19:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504392;
        bh=FzHvRoG17K54IWiQfe8Szt+YKIB6vt1cflLjm0hIFzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cW8wqD31hSMsfudA2yYZjbkf8/CZy/ms/SQKe0D6K+wrqxGUOz3WYkYIqze0Tn26O
         39Jn6XPokMiNDbwDzx7QzO1qAw7UXwwkqsK3EPhZKp1RS+2f8ZXRQmR32fgiZ03MlX
         GTxHbPxXR83/PL2oihf5WjKrCJnxD3yP4QtuEQDY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Willem de Bruijn <willemb@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 06/48] bpf: only adjust gso_size on bytestream protocols
Date:   Wed, 13 Mar 2019 15:12:08 -0400
Message-Id: <20190313191250.158955-6-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191250.158955-1-sashal@kernel.org>
References: <20190313191250.158955-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

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
index fb0080e84bd4..cb792b344b5e 100644
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

