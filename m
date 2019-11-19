Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A947C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8CA20872
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574143406;
	bh=5ZDLL2jzO0bYUJZZV6wHwNTMpEYiGBSQOV5StXzn/1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rBx8uiK69prLg4sKffOyBiU4fXAcA55aeRaTvjwuhdoPtkVUG7xpe7y8Fp672VCkN
	 YkE06f9gVY8xJe33gqmTR5Z5XuI5yeeZMaTfdyp6hM4KmyOC0i4eCyOMqdPuVSOPFx
	 T6kBJRZH4k3lxDKqcojJe2MVExzjau8vBzXOm/oc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbfKSFkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:40:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:34288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729283AbfKSFkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:40:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3728D218BA;
        Tue, 19 Nov 2019 05:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142008;
        bh=5ZDLL2jzO0bYUJZZV6wHwNTMpEYiGBSQOV5StXzn/1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PYc3dQOhRqRT+X42sRY+YQRxg4GeC3lrg3lPPT9HhnZ7Ja5WxGyVl4JVtWZtZ7q9X
         zfvsCowdOb3KKf+W5Pq6sBFgl1HEU+86XwTvpd/xfu6JBhTFa7ClMnN3YpAno5kKAu
         K0fFzrNMPi8a6niDnjDgOkJGpob3ws+FFo96FE/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 316/422] samples/bpf: fix compilation failure
Date:   Tue, 19 Nov 2019 06:18:33 +0100
Message-Id: <20191119051419.471438761@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>

[ Upstream commit 32c009798385ce21080beaa87a9b95faad3acd1e ]

following commit:
commit d58e468b1112 ("flow_dissector: implements flow dissector BPF hook")
added struct bpf_flow_keys which conflicts with the struct with
same name in sockex2_kern.c and sockex3_kern.c

similar to commit:
commit 534e0e52bc23 ("samples/bpf: fix a compilation failure")
we tried the rename it "flow_keys" but it also conflicted with struct
having same name in include/net/flow_dissector.h. Hence renaming the
struct to "flow_key_record". Also, this commit doesn't fix the
compilation error completely because the similar struct is present in
sockex3_kern.c. Hence renaming it in both files sockex3_user.c and
sockex3_kern.c

Signed-off-by: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/bpf/sockex2_kern.c | 11 ++++++-----
 samples/bpf/sockex3_kern.c |  8 ++++----
 samples/bpf/sockex3_user.c |  4 ++--
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/samples/bpf/sockex2_kern.c b/samples/bpf/sockex2_kern.c
index f58acfc925561..f2f9dbc021b0d 100644
--- a/samples/bpf/sockex2_kern.c
+++ b/samples/bpf/sockex2_kern.c
@@ -14,7 +14,7 @@ struct vlan_hdr {
 	__be16 h_vlan_encapsulated_proto;
 };
 
-struct bpf_flow_keys {
+struct flow_key_record {
 	__be32 src;
 	__be32 dst;
 	union {
@@ -59,7 +59,7 @@ static inline __u32 ipv6_addr_hash(struct __sk_buff *ctx, __u64 off)
 }
 
 static inline __u64 parse_ip(struct __sk_buff *skb, __u64 nhoff, __u64 *ip_proto,
-			     struct bpf_flow_keys *flow)
+			     struct flow_key_record *flow)
 {
 	__u64 verlen;
 
@@ -83,7 +83,7 @@ static inline __u64 parse_ip(struct __sk_buff *skb, __u64 nhoff, __u64 *ip_proto
 }
 
 static inline __u64 parse_ipv6(struct __sk_buff *skb, __u64 nhoff, __u64 *ip_proto,
-			       struct bpf_flow_keys *flow)
+			       struct flow_key_record *flow)
 {
 	*ip_proto = load_byte(skb,
 			      nhoff + offsetof(struct ipv6hdr, nexthdr));
@@ -96,7 +96,8 @@ static inline __u64 parse_ipv6(struct __sk_buff *skb, __u64 nhoff, __u64 *ip_pro
 	return nhoff;
 }
 
-static inline bool flow_dissector(struct __sk_buff *skb, struct bpf_flow_keys *flow)
+static inline bool flow_dissector(struct __sk_buff *skb,
+				  struct flow_key_record *flow)
 {
 	__u64 nhoff = ETH_HLEN;
 	__u64 ip_proto;
@@ -198,7 +199,7 @@ struct bpf_map_def SEC("maps") hash_map = {
 SEC("socket2")
 int bpf_prog2(struct __sk_buff *skb)
 {
-	struct bpf_flow_keys flow = {};
+	struct flow_key_record flow = {};
 	struct pair *value;
 	u32 key;
 
diff --git a/samples/bpf/sockex3_kern.c b/samples/bpf/sockex3_kern.c
index 95907f8d2b17d..c527b57d3ec8a 100644
--- a/samples/bpf/sockex3_kern.c
+++ b/samples/bpf/sockex3_kern.c
@@ -61,7 +61,7 @@ struct vlan_hdr {
 	__be16 h_vlan_encapsulated_proto;
 };
 
-struct bpf_flow_keys {
+struct flow_key_record {
 	__be32 src;
 	__be32 dst;
 	union {
@@ -88,7 +88,7 @@ static inline __u32 ipv6_addr_hash(struct __sk_buff *ctx, __u64 off)
 }
 
 struct globals {
-	struct bpf_flow_keys flow;
+	struct flow_key_record flow;
 };
 
 struct bpf_map_def SEC("maps") percpu_map = {
@@ -114,14 +114,14 @@ struct pair {
 
 struct bpf_map_def SEC("maps") hash_map = {
 	.type = BPF_MAP_TYPE_HASH,
-	.key_size = sizeof(struct bpf_flow_keys),
+	.key_size = sizeof(struct flow_key_record),
 	.value_size = sizeof(struct pair),
 	.max_entries = 1024,
 };
 
 static void update_stats(struct __sk_buff *skb, struct globals *g)
 {
-	struct bpf_flow_keys key = g->flow;
+	struct flow_key_record key = g->flow;
 	struct pair *value;
 
 	value = bpf_map_lookup_elem(&hash_map, &key);
diff --git a/samples/bpf/sockex3_user.c b/samples/bpf/sockex3_user.c
index 22f74d0e14934..9d02e0404719a 100644
--- a/samples/bpf/sockex3_user.c
+++ b/samples/bpf/sockex3_user.c
@@ -13,7 +13,7 @@
 #define PARSE_IP_PROG_FD (prog_fd[0])
 #define PROG_ARRAY_FD (map_fd[0])
 
-struct flow_keys {
+struct flow_key_record {
 	__be32 src;
 	__be32 dst;
 	union {
@@ -64,7 +64,7 @@ int main(int argc, char **argv)
 	(void) f;
 
 	for (i = 0; i < 5; i++) {
-		struct flow_keys key = {}, next_key;
+		struct flow_key_record key = {}, next_key;
 		struct pair value;
 
 		sleep(1);
-- 
2.20.1



