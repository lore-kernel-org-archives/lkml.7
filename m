Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DB1C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A158A23BD4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfE2PNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:13:52 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34109 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfE2PNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:13:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id e19so4493414wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 08:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W2buZooF/pmx7z95pzXizhl/Lg5Xb9tNt67UtliOTiY=;
        b=hYoBDqgCA9JdKalL6UyEyryzQ1UdtbzRaa7BET53Hn2oeGSLyZBiQoD21RxcdVJqBk
         SSSyq02j6LRt8PFwgTC9paSKqk9s4CuHvhOkek7Bib43cxMxSHIUnQWe/Bvrrzv5vKYI
         FUfwX7/j41O5Wb8g6C4olOvCREDAIK8Ipzgn+wtjxXan6dtdOolqT9UfcMKadbjsi9u1
         Qpa5fZUj3xwCXWE6ObMM+qPmsmb9VgFIKKNn32yGL0grhZW2t3TIBxXDS8TiDtyiMWey
         whKOxEBVQsUND9jMwtHkCm41YOYK6DPl3rqGTAZp+3jG6FitBtl/7ag29cHF0upQKXNv
         +2kA==
X-Gm-Message-State: APjAAAW3rDqLYrb1+u7sX042fDKzfayJllf4iEPFzUghKi8rXGgJCe7a
        U2Tw7uK7fyT0Y9iHi5I+zrwtR60E3YA=
X-Google-Smtp-Source: APXvYqw6TGNqjwQ/cGPnADmOEDWtEPldcH4/ylP16XoGpsMS5pki4FsKsIdNSaS7vfzqm2UD4Lr31w==
X-Received: by 2002:a1c:4d07:: with SMTP id o7mr7154944wmh.156.1559142830240;
        Wed, 29 May 2019 08:13:50 -0700 (PDT)
Received: from raver.teknoraver.net (net-93-144-152-91.cust.dsl.teletu.it. [93.144.152.91])
        by smtp.gmail.com with ESMTPSA id c131sm7284963wma.31.2019.05.29.08.13.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 29 May 2019 08:13:49 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: avoid indirect calls in L4 checksum calculation
Date:   Wed, 29 May 2019 17:13:48 +0200
Message-Id: <20190529151348.31311-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 283c16a2dfd3 ("indirect call wrappers: helpers to speed-up
indirect calls of builtin") introduces some macros to avoid doing
indirect calls.

Use these helpers to remove two indirect calls in the L4 checksum
calculation for devices which don't have hardware support for it.

As a test I generate packets with pktgen out to a dummy interface
with HW checksumming disabled, to have the checksum calculated in
every sent packet.
The packet rate measured with an i7-6700K CPU and a single pktgen
thread raised from 6143 to 6608 Kpps, an increase by 7.5%

Suggested-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 net/core/skbuff.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index e89be6282693..0c2e7d4946ef 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -76,6 +76,7 @@
 #include <linux/highmem.h>
 #include <linux/capability.h>
 #include <linux/user_namespace.h>
+#include <linux/indirect_call_wrapper.h>
 
 #include "datagram.h"
 
@@ -2507,7 +2508,8 @@ __wsum __skb_checksum(const struct sk_buff *skb, int offset, int len,
 	if (copy > 0) {
 		if (copy > len)
 			copy = len;
-		csum = ops->update(skb->data + offset, copy, csum);
+		csum = INDIRECT_CALL_1(ops->update, csum_partial_ext,
+				       skb->data + offset, copy, csum);
 		if ((len -= copy) == 0)
 			return csum;
 		offset += copy;
@@ -2534,9 +2536,13 @@ __wsum __skb_checksum(const struct sk_buff *skb, int offset, int len,
 					      frag->page_offset + offset - start,
 					      copy, p, p_off, p_len, copied) {
 				vaddr = kmap_atomic(p);
-				csum2 = ops->update(vaddr + p_off, p_len, 0);
+				csum2 = INDIRECT_CALL_1(ops->update,
+							csum_partial_ext,
+							vaddr + p_off, p_len, 0);
 				kunmap_atomic(vaddr);
-				csum = ops->combine(csum, csum2, pos, p_len);
+				csum = INDIRECT_CALL_1(ops->combine,
+						       csum_block_add_ext, csum,
+						       csum2, pos, p_len);
 				pos += p_len;
 			}
 
@@ -2559,7 +2565,8 @@ __wsum __skb_checksum(const struct sk_buff *skb, int offset, int len,
 				copy = len;
 			csum2 = __skb_checksum(frag_iter, offset - start,
 					       copy, 0, ops);
-			csum = ops->combine(csum, csum2, pos, copy);
+			csum = INDIRECT_CALL_1(ops->combine, csum_block_add_ext,
+					       csum, csum2, pos, copy);
 			if ((len -= copy) == 0)
 				return csum;
 			offset += copy;
-- 
2.21.0

