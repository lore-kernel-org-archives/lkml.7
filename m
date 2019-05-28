Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319E2C04E84
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 23:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090AB206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 23:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfE1X6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 19:58:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53600 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfE1X6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 19:58:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id d17so294269wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 16:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xi6hRmlV/rkYRZXwRwO7EpD99nzQCtGBu1E4jVd0OG0=;
        b=Ab2zrIKXDuM3wH/3vleTi9v18qOFqdElCjs6oFhjb0djlC1D9ABTLkHJK3UUsZgwsn
         jkWx9AIzJuBInwij1Athq5uxujlQ8llomV1NukkmT+HEajHepYwsPCG7hOzYGSp4CVwB
         /xnLRtkwb+vs1A9OpiQgHt4Ic1Wb3TwQxOgrbXA/mdbVY6Bu/bilMA6EE62L9Sc2/ZIY
         8MoeGrKF2udYBK6Ddqb9dfCYOzSu7by1RizrxXIdaEnKCjJbcE4sL57OGwAToYqUrr2M
         rnlSp5Fvic8JvHEOwPAidOhkq7QukxXwY8lYCjk05Eh49qFcWUjiRyyMUk/DOm5wStfT
         s2tw==
X-Gm-Message-State: APjAAAXKSjAcuirMZ8qRiHnlGJrCjSi3h2U7AK7p6Ip+7eRei5ESowew
        nVEN7gPAmdz/aVWxK17qdOXXrofjOcQ=
X-Google-Smtp-Source: APXvYqxfl6xm2qcJA8awYqlEkYvzsKyFY1ok6e7KAzVB9YFi3gVE4bn35EcLiejKxDcMlJOYMcHy+Q==
X-Received: by 2002:a05:600c:1109:: with SMTP id b9mr4658543wma.107.1559087926470;
        Tue, 28 May 2019 16:58:46 -0700 (PDT)
Received: from raver.teknoraver.net (net-93-144-152-91.cust.vodafonedsl.it. [93.144.152.91])
        by smtp.gmail.com with ESMTPSA id a10sm17826941wrm.94.2019.05.28.16.58.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 28 May 2019 16:58:45 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: avoid indirect calls in L4 checksum calculation
Date:   Wed, 29 May 2019 01:58:44 +0200
Message-Id: <20190528235844.19360-1-mcroce@redhat.com>
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
 net/core/skbuff.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index e89be6282693..a24a7ef55ce9 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -69,6 +69,7 @@
 #include <net/sock.h>
 #include <net/checksum.h>
 #include <net/ip6_checksum.h>
+#include <net/sctp/checksum.h>
 #include <net/xfrm.h>
 
 #include <linux/uaccess.h>
@@ -76,9 +77,22 @@
 #include <linux/highmem.h>
 #include <linux/capability.h>
 #include <linux/user_namespace.h>
+#include <linux/indirect_call_wrapper.h>
 
 #include "datagram.h"
 
+#if IS_ENABLED(CONFIG_IP_SCTP)
+#define CSUM_UPDATE(f, ...) \
+	INDIRECT_CALL_2(f, csum_partial_ext, sctp_csum_update, __VA_ARGS__)
+#define CSUM_COMBINE(f, ...) \
+	INDIRECT_CALL_2(f, csum_block_add_ext, sctp_csum_combine, __VA_ARGS__)
+#else
+#define CSUM_UPDATE(f, ...) \
+	INDIRECT_CALL_1(f, csum_partial_ext, __VA_ARGS__)
+#define CSUM_COMBINE(f, ...) \
+	INDIRECT_CALL_1(f, csum_block_add_ext, __VA_ARGS__)
+#endif
+
 struct kmem_cache *skbuff_head_cache __ro_after_init;
 static struct kmem_cache *skbuff_fclone_cache __ro_after_init;
 #ifdef CONFIG_SKB_EXTENSIONS
@@ -2507,7 +2521,7 @@ __wsum __skb_checksum(const struct sk_buff *skb, int offset, int len,
 	if (copy > 0) {
 		if (copy > len)
 			copy = len;
-		csum = ops->update(skb->data + offset, copy, csum);
+		csum = CSUM_UPDATE(ops->update, skb->data + offset, copy, csum);
 		if ((len -= copy) == 0)
 			return csum;
 		offset += copy;
@@ -2534,9 +2548,9 @@ __wsum __skb_checksum(const struct sk_buff *skb, int offset, int len,
 					      frag->page_offset + offset - start,
 					      copy, p, p_off, p_len, copied) {
 				vaddr = kmap_atomic(p);
-				csum2 = ops->update(vaddr + p_off, p_len, 0);
+				csum2 = CSUM_UPDATE(ops->update, vaddr + p_off, p_len, 0);
 				kunmap_atomic(vaddr);
-				csum = ops->combine(csum, csum2, pos, p_len);
+				csum = CSUM_COMBINE(ops->combine, csum, csum2, pos, p_len);
 				pos += p_len;
 			}
 
@@ -2559,7 +2573,7 @@ __wsum __skb_checksum(const struct sk_buff *skb, int offset, int len,
 				copy = len;
 			csum2 = __skb_checksum(frag_iter, offset - start,
 					       copy, 0, ops);
-			csum = ops->combine(csum, csum2, pos, copy);
+			csum = CSUM_COMBINE(ops->combine, csum, csum2, pos, copy);
 			if ((len -= copy) == 0)
 				return csum;
 			offset += copy;
-- 
2.21.0

