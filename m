Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF17C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E581020693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552505656;
	bh=ehcFTpKlVQO+i83WcJUFAB9EgudEjTrngKna63Oxums=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r3evX39YunGeNNWIaaOO8dCaGBqC4BW5Wl158fnbDUrcXLe5wZaJ8g2Oe77jXtpbg
	 UpInfui6xz+LHcb99g0thfAaorCpAck08VdBbYUjxhsUxOwXEi894oGHjl2kOEeEx2
	 dsD+KvZmwjUxye6z4q0d9XNdKg4h/FWXIO2fjGTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfCMTeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:34:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbfCMTKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:10:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE08E2173C;
        Wed, 13 Mar 2019 19:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504236;
        bh=ehcFTpKlVQO+i83WcJUFAB9EgudEjTrngKna63Oxums=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j+JcJ2jouQi8BHMQwpFivrsRk+qaKhB8Sk7W6bcr/sHyEgS+WtIPCz3WsXMHlgDht
         8khvSjU57HNCF4pygii6BC8dkVK4daf1MWnMaEfgrmDwLIv/khsFIWPN+yEZhqM1Q7
         60jip/fN3ZjyMQ/mfSVXQQyHzNlzUSShnoS+AGVg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Willem de Bruijn <willemb@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 07/60] bpf: only adjust gso_size on bytestream protocols
Date:   Wed, 13 Mar 2019 15:09:28 -0400
Message-Id: <20190313191021.158171-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191021.158171-1-sashal@kernel.org>
References: <20190313191021.158171-1-sashal@kernel.org>
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
index 8e63c166765e..875f56cbb756 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4118,6 +4118,12 @@ static inline bool skb_is_gso_sctp(const struct sk_buff *skb)
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
index 16350f8c8815..6e37c639519e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2624,8 +2624,7 @@ static int bpf_skb_proto_4_to_6(struct sk_buff *skb)
 	u32 off = skb_mac_header_len(skb);
 	int ret;
 
-	/* SCTP uses GSO_BY_FRAGS, thus cannot adjust it. */
-	if (skb_is_gso(skb) && unlikely(skb_is_gso_sctp(skb)))
+	if (!skb_is_gso_tcp(skb))
 		return -ENOTSUPP;
 
 	ret = skb_cow(skb, len_diff);
@@ -2666,8 +2665,7 @@ static int bpf_skb_proto_6_to_4(struct sk_buff *skb)
 	u32 off = skb_mac_header_len(skb);
 	int ret;
 
-	/* SCTP uses GSO_BY_FRAGS, thus cannot adjust it. */
-	if (skb_is_gso(skb) && unlikely(skb_is_gso_sctp(skb)))
+	if (!skb_is_gso_tcp(skb))
 		return -ENOTSUPP;
 
 	ret = skb_unclone(skb, GFP_ATOMIC);
@@ -2792,8 +2790,7 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 len_diff)
 	u32 off = skb_mac_header_len(skb) + bpf_skb_net_base_len(skb);
 	int ret;
 
-	/* SCTP uses GSO_BY_FRAGS, thus cannot adjust it. */
-	if (skb_is_gso(skb) && unlikely(skb_is_gso_sctp(skb)))
+	if (!skb_is_gso_tcp(skb))
 		return -ENOTSUPP;
 
 	ret = skb_cow(skb, len_diff);
@@ -2822,8 +2819,7 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 len_diff)
 	u32 off = skb_mac_header_len(skb) + bpf_skb_net_base_len(skb);
 	int ret;
 
-	/* SCTP uses GSO_BY_FRAGS, thus cannot adjust it. */
-	if (skb_is_gso(skb) && unlikely(skb_is_gso_sctp(skb)))
+	if (!skb_is_gso_tcp(skb))
 		return -ENOTSUPP;
 
 	ret = skb_unclone(skb, GFP_ATOMIC);
-- 
2.19.1

