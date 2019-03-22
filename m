Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D59DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8A52070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258341;
	bh=yAfiYDjR2ddQY8tQpHwSJHtznzRFCjryNCHfQF0rifc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yLsXP6Cmhw/z+5PILIVlEti3/kEPMqz/6xyFJRnZYj6cM0QXGZfljrAVdPnQJDAQd
	 8tIYrI9s7BcjVkat5t09z1MEJ0G4ckMkObGxn6N61BJwjGoFg+ZuyscYAN1l7rH1lZ
	 zquu4Ru9p6LKAhlttqFsBBdu8nlMs27p3/qiHwF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732980AbfCVMi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:38:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388090AbfCVMIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:08:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB15E2082C;
        Fri, 22 Mar 2019 12:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256498;
        bh=yAfiYDjR2ddQY8tQpHwSJHtznzRFCjryNCHfQF0rifc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d87cfwGBbD/9pNLeT8A/bGNikQw/zfrPoa+HbSnboikLZ0HlzwPlXJB53sUrTbpck
         K7SSMtxtDIyU7V5KM23v4AWfhBsX2mv99WOsgp8JittqJui7QEQaqAuD8Rvx3YN8iI
         yuaitmRxrdvtTXI2CM+0LUJna5nHWCeZ8Mr2bvhA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 212/280] bpf: only test gso type on gso packets
Date:   Fri, 22 Mar 2019 12:16:05 +0100
Message-Id: <20190322111333.030538897@linuxfoundation.org>
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

[ Upstream commit 4c3024debf62de4c6ac6d3cb4c0063be21d4f652 ]

BPF can adjust gso only for tcp bytestreams. Fail on other gso types.

But only on gso packets. It does not touch this field if !gso_size.

Fixes: b90efd225874 ("bpf: only adjust gso_size on bytestream protocols")
Signed-off-by: Willem de Bruijn <willemb@google.com>
Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/skbuff.h | 4 ++--
 net/core/filter.c      | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 3b0a25bb7c6f..820903ceac4f 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4086,10 +4086,10 @@ static inline bool skb_is_gso_sctp(const struct sk_buff *skb)
 	return skb_shinfo(skb)->gso_type & SKB_GSO_SCTP;
 }
 
+/* Note: Should be called only if skb_is_gso(skb) is true */
 static inline bool skb_is_gso_tcp(const struct sk_buff *skb)
 {
-	return skb_is_gso(skb) &&
-	       skb_shinfo(skb)->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6);
+	return skb_shinfo(skb)->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6);
 }
 
 static inline void skb_gso_reset(struct sk_buff *skb)
diff --git a/net/core/filter.c b/net/core/filter.c
index b1369edce113..eb81e9db4093 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2614,7 +2614,7 @@ static int bpf_skb_proto_4_to_6(struct sk_buff *skb)
 	u32 off = skb_mac_header_len(skb);
 	int ret;
 
-	if (!skb_is_gso_tcp(skb))
+	if (skb_is_gso(skb) && !skb_is_gso_tcp(skb))
 		return -ENOTSUPP;
 
 	ret = skb_cow(skb, len_diff);
@@ -2655,7 +2655,7 @@ static int bpf_skb_proto_6_to_4(struct sk_buff *skb)
 	u32 off = skb_mac_header_len(skb);
 	int ret;
 
-	if (!skb_is_gso_tcp(skb))
+	if (skb_is_gso(skb) && !skb_is_gso_tcp(skb))
 		return -ENOTSUPP;
 
 	ret = skb_unclone(skb, GFP_ATOMIC);
@@ -2780,7 +2780,7 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 len_diff)
 	u32 off = skb_mac_header_len(skb) + bpf_skb_net_base_len(skb);
 	int ret;
 
-	if (!skb_is_gso_tcp(skb))
+	if (skb_is_gso(skb) && !skb_is_gso_tcp(skb))
 		return -ENOTSUPP;
 
 	ret = skb_cow(skb, len_diff);
@@ -2809,7 +2809,7 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 len_diff)
 	u32 off = skb_mac_header_len(skb) + bpf_skb_net_base_len(skb);
 	int ret;
 
-	if (!skb_is_gso_tcp(skb))
+	if (skb_is_gso(skb) && !skb_is_gso_tcp(skb))
 		return -ENOTSUPP;
 
 	ret = skb_unclone(skb, GFP_ATOMIC);
-- 
2.19.1



