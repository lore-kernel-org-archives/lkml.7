Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD28C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D58F2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfDDCkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 22:40:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45646 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726193AbfDDCkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 22:40:12 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [10.3.19.214])
        by Forcepoint Email with ESMTP id 5D7A15A57D407307C086;
        Thu,  4 Apr 2019 10:40:10 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Thu, 4 Apr 2019
 10:39:59 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <viro@zeniv.linux.org.uk>,
        <willemb@google.com>, <edumazet@google.com>, <fw@strlen.de>,
        <sagi@lightbitslabs.com>, <hch@lst.de>, <pabeni@redhat.com>,
        <pctammela@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2] iov_iter: Fix build error without CONFIG_CRYPTO
Date:   Thu, 4 Apr 2019 10:39:13 +0800
Message-ID: <20190404023913.20448-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190403095031.11720-1-yuehaibing@huawei.com>
References: <20190403095031.11720-1-yuehaibing@huawei.com>
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
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: rework the fix as Al Viro suggested
---
 lib/iov_iter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 50e77ec..f74fa83 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1531,6 +1531,7 @@ EXPORT_SYMBOL(csum_and_copy_to_iter);
 size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
 		struct iov_iter *i)
 {
+#ifdef CONFIG_CRYPTO
 	struct ahash_request *hash = hashp;
 	struct scatterlist sg;
 	size_t copied;
@@ -1540,6 +1541,9 @@ size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
 	ahash_request_set_crypt(hash, &sg, NULL, copied);
 	crypto_ahash_update(hash);
 	return copied;
+#else
+	return 0;
+#endif
 }
 EXPORT_SYMBOL(hash_and_copy_to_iter);
 
-- 
2.7.4


