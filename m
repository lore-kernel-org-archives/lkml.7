Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1D9C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 03:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25AB920675
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 03:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNCs3bNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfDLDdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 23:33:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32825 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfDLDdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 23:33:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id k19so4508803pgh.0;
        Thu, 11 Apr 2019 20:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3C1fGOgvnRDgr2+61i3UruLYNDemZ25874nEdVYBcWA=;
        b=QNCs3bNdGU0tzYReElByvLX7oAa0r8acXj7J4fXU9V/vNfvPt1TQsdFMDorUnHk3hT
         ipecVBiSF6JpvMYCk8v0qwL+dbiSLA4nKha50c9uit35EDQEHR/JbxbS6qTt+/B57u0E
         NI3YS0M7KFl0EWZdOU4rf/o6Y+8pe84AdViYrC0hnGlXAI7Q3plDLAY/BMn/zjk9QDxY
         kMT4dtwnArAWIBPM6qyKPDao9PkfCXm2nH6MfJyWLCMK7+a1/IGOKaX3KynlaAmN+18a
         Y9fSfFR9ZrxdXbnSRCeS1tFt50R+DUKmjFJKAmEg+/j+z3gowyzbty2ooycJgc7kbMj2
         Um/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3C1fGOgvnRDgr2+61i3UruLYNDemZ25874nEdVYBcWA=;
        b=GsCGCRdZfXs1zS54BnAicyrwpYSvWbxXYma8thH35+S7WR0yqJL0FDSONjor5mNfIp
         lGASwXFCbgCLa+QX8+PxP7fAsJLNO2qQtLm5eNKJBcdjXW6qcv+uyU0qHf8Eg7ttQPf8
         kqluxdHtJdxA+XcIa4hHbPOA/Gv9pKBjIsXAWjKzEFx04+2GU2yRwSw0NYdP/6J9+uJY
         DR46Nvqp1/33zN/yTs1S5nghDuC9CpUNJKU1/WiMtfopiN8LqtFTSvbLGHyM3vjVYZIQ
         KhnALe92YUd9HLTOsAZDWhVDTYMPUSLtITjRwkrBcXkQjmVdEK9lYvh4jneeKELFEJ1y
         2ocQ==
X-Gm-Message-State: APjAAAVjAfqSKtxzbNQGM7Yu1xd9WeYAkcGKklmiwcZUzyQ51Yg5y1EO
        em9DhgBllZWphXXEcrIyDNAuD8GteSIROw==
X-Google-Smtp-Source: APXvYqxXA51zkEYpKKdImox7l1Zgb3hfIvJOZhcMGCAT1g5DovuBJTZhOXmWQkHsWJ8fGEKjj3I6+Q==
X-Received: by 2002:a63:6e0e:: with SMTP id j14mr50228731pgc.203.1555039987990;
        Thu, 11 Apr 2019 20:33:07 -0700 (PDT)
Received: from xy-data.openstacklocal (ecs-159-138-22-150.compute.hwclouds-dns.com. [159.138.22.150])
        by smtp.gmail.com with ESMTPSA id c25sm57750648pfo.69.2019.04.11.20.33.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Apr 2019 20:33:07 -0700 (PDT)
From:   Young Xiao <92siuyang@gmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Young Xiao <YangX92@hotmail.com>
Subject: [PATCH] ipv6: Prevent overrun when parsing v6 header options
Date:   Fri, 12 Apr 2019 11:34:08 +0800
Message-Id: <1555040048-31294-1-git-send-email-92siuyang@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Young Xiao <YangX92@hotmail.com>

The fragmentation code tries to parse the header options in order
to figure out where to insert the fragment option.  Since nexthdr points
to an invalid option, the calculation of the size of the network header
can made to be much larger than the linear section of the skb and data
is read outside of it.

This vulnerability is similar to CVE-2017-9074.

Signed-off-by: Young Xiao <YangX92@hotmail.com>
---
 net/ipv6/mip6.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/net/ipv6/mip6.c b/net/ipv6/mip6.c
index 64f0f7b..1b3a6e4 100644
--- a/net/ipv6/mip6.c
+++ b/net/ipv6/mip6.c
@@ -263,8 +263,6 @@ static int mip6_destopt_offset(struct xfrm_state *x, struct sk_buff *skb,
 			       u8 **nexthdr)
 {
 	u16 offset = sizeof(struct ipv6hdr);
-	struct ipv6_opt_hdr *exthdr =
-				   (struct ipv6_opt_hdr *)(ipv6_hdr(skb) + 1);
 	const unsigned char *nh = skb_network_header(skb);
 	unsigned int packet_len = skb_tail_pointer(skb) -
 		skb_network_header(skb);
@@ -272,7 +270,8 @@ static int mip6_destopt_offset(struct xfrm_state *x, struct sk_buff *skb,
 
 	*nexthdr = &ipv6_hdr(skb)->nexthdr;
 
-	while (offset + 1 <= packet_len) {
+	while (offset <= packet_len) {
+		struct ipv6_opt_hdr *exthdr;
 
 		switch (**nexthdr) {
 		case NEXTHDR_HOP:
@@ -299,12 +298,16 @@ static int mip6_destopt_offset(struct xfrm_state *x, struct sk_buff *skb,
 			return offset;
 		}
 
+		if (offset + sizeof(struct ipv6_opt_hdr) > packet_len)
+			return -EINVAL;
+
+		exthdr = (struct ipv6_opt_hdr *)(nh + offset);
 		offset += ipv6_optlen(exthdr);
 		*nexthdr = &exthdr->nexthdr;
-		exthdr = (struct ipv6_opt_hdr *)(nh + offset);
+
 	}
 
-	return offset;
+	return -EINVAL;
 }
 
 static int mip6_destopt_init_state(struct xfrm_state *x)
@@ -399,8 +402,6 @@ static int mip6_rthdr_offset(struct xfrm_state *x, struct sk_buff *skb,
 			     u8 **nexthdr)
 {
 	u16 offset = sizeof(struct ipv6hdr);
-	struct ipv6_opt_hdr *exthdr =
-				   (struct ipv6_opt_hdr *)(ipv6_hdr(skb) + 1);
 	const unsigned char *nh = skb_network_header(skb);
 	unsigned int packet_len = skb_tail_pointer(skb) -
 		skb_network_header(skb);
@@ -408,7 +409,8 @@ static int mip6_rthdr_offset(struct xfrm_state *x, struct sk_buff *skb,
 
 	*nexthdr = &ipv6_hdr(skb)->nexthdr;
 
-	while (offset + 1 <= packet_len) {
+	while (offset <= packet_len) {
+		struct ipv6_opt_hdr *exthdr;
 
 		switch (**nexthdr) {
 		case NEXTHDR_HOP:
@@ -434,12 +436,16 @@ static int mip6_rthdr_offset(struct xfrm_state *x, struct sk_buff *skb,
 			return offset;
 		}
 
+		if (offset + sizeof(struct ipv6_opt_hdr) > packet_len)
+			return -EINVAL;
+
+		exthdr = (struct ipv6_opt_hdr *)(nh + offset);
+
 		offset += ipv6_optlen(exthdr);
 		*nexthdr = &exthdr->nexthdr;
-		exthdr = (struct ipv6_opt_hdr *)(nh + offset);
 	}
 
-	return offset;
+	return -EINVAL;
 }
 
 static int mip6_rthdr_init_state(struct xfrm_state *x)
-- 
1.9.1

