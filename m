Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DA9C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B562084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfDCJu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:50:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5660 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726097AbfDCJu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:50:59 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [10.3.19.208])
        by Forcepoint Email with ESMTP id B476C2BA2CE7B8344C7F;
        Wed,  3 Apr 2019 17:50:56 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Wed, 3 Apr 2019
 17:50:49 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <viro@zeniv.linux.org.uk>,
        <willemb@google.com>, <edumazet@google.com>, <fw@strlen.de>,
        <sagi@lightbitslabs.com>, <hch@lst.de>, <pabeni@redhat.com>,
        <pctammela@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] iov_iter: Fix build error without CONFIG_CRYPTO
Date:   Wed, 3 Apr 2019 17:50:31 +0800
Message-ID: <20190403095031.11720-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

If CONFIG_CRYPTO is not set or set to m,
gcc building warn this:

lib/iov_iter.o: In function `hash_and_copy_to_iter':
iov_iter.c:(.text+0x9129): undefined reference to `crypto_stats_get'
iov_iter.c:(.text+0x9152): undefined reference to `crypto_stats_ahash_update'

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: d05f443554b3 ("iov_iter: introduce hash_and_copy_to_iter helper")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/skbuff.h | 2 ++
 lib/iov_iter.c         | 2 ++
 net/core/datagram.c    | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 9027a8c..3999112 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3396,9 +3396,11 @@ static inline int skb_copy_datagram_msg(const struct sk_buff *from, int offset,
 }
 int skb_copy_and_csum_datagram_msg(struct sk_buff *skb, int hlen,
 				   struct msghdr *msg);
+#ifdef CONFIG_CRYPTO
 int skb_copy_and_hash_datagram_iter(const struct sk_buff *skb, int offset,
 			   struct iov_iter *to, int len,
 			   struct ahash_request *hash);
+#endif
 int skb_copy_datagram_from_iter(struct sk_buff *skb, int offset,
 				 struct iov_iter *from, int len);
 int zerocopy_sg_from_iter(struct sk_buff *skb, struct iov_iter *frm);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 50e77ec..ed02f74 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1528,6 +1528,7 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *csump,
 }
 EXPORT_SYMBOL(csum_and_copy_to_iter);
 
+#ifdef CONFIG_CRYPTO
 size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
 		struct iov_iter *i)
 {
@@ -1542,6 +1543,7 @@ size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
 	return copied;
 }
 EXPORT_SYMBOL(hash_and_copy_to_iter);
+#endif
 
 int iov_iter_npages(const struct iov_iter *i, int maxpages)
 {
diff --git a/net/core/datagram.c b/net/core/datagram.c
index 91bb5a0..8815ec2 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -494,6 +494,7 @@ static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
 	return 0;
 }
 
+#ifdef CONFIG_CRYPTO
 /**
  *	skb_copy_and_hash_datagram_iter - Copy datagram to an iovec iterator
  *          and update a hash.
@@ -511,6 +512,7 @@ int skb_copy_and_hash_datagram_iter(const struct sk_buff *skb, int offset,
 			hash_and_copy_to_iter, hash);
 }
 EXPORT_SYMBOL(skb_copy_and_hash_datagram_iter);
+#endif
 
 static size_t simple_copy_to_iter(const void *addr, size_t bytes,
 		void *data __always_unused, struct iov_iter *i)
-- 
2.7.4


