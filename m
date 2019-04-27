Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE031C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A4520679
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556330100;
	bh=i6YHSI44jIHFPVkUNp9oqgvJmO+gQWosKUklt8yg0wY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AnXifzm50OLDR7OROWQmlcpWcXY4edp2KuawciL8EYhboubYSc66ua0YZGr1fpSLh
	 VC2dQETQq2/bdeDF6toYgJU9U37vuAM0g36OrBCTG2WmWkh3kGb33XfsratfUlIQQg
	 TUXWGhvww5mtc91pYMBnf8PI9qo2iRgNDH5KRaV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfD0By7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:54:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbfD0Bjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:39:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51BF5214C6;
        Sat, 27 Apr 2019 01:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329172;
        bh=i6YHSI44jIHFPVkUNp9oqgvJmO+gQWosKUklt8yg0wY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rJETz3EMQqyTW/lyQAuG+wD91Pla/r7N0HnfzdB3GK+77AHT0CV6EaTrsYXp7TT+w
         pdZtq8qbbqBLCmoHPp6Dx5NusIWc0W5ZWoGY4zna7Q9nxiyyfPWC+yfxywuohLsWhI
         yikt5JwLXyC+QL0SkKukb2EtJ9rbrGuAaGY2Gwwo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 35/79] iov_iter: Fix build error without CONFIG_CRYPTO
Date:   Fri, 26 Apr 2019 21:37:54 -0400
Message-Id: <20190427013838.6596-35-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 27fad74a5a77fe2e1f876db7bf27efcf2ec304b2 ]

If CONFIG_CRYPTO is not set or set to m,
gcc building warn this:

lib/iov_iter.o: In function `hash_and_copy_to_iter':
iov_iter.c:(.text+0x9129): undefined reference to `crypto_stats_get'
iov_iter.c:(.text+0x9152): undefined reference to `crypto_stats_ahash_update'

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: d05f443554b3 ("iov_iter: introduce hash_and_copy_to_iter helper")
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/iov_iter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index be4bd627caf0..a0d1cd88f903 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1515,6 +1515,7 @@ EXPORT_SYMBOL(csum_and_copy_to_iter);
 size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
 		struct iov_iter *i)
 {
+#ifdef CONFIG_CRYPTO
 	struct ahash_request *hash = hashp;
 	struct scatterlist sg;
 	size_t copied;
@@ -1524,6 +1525,9 @@ size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
 	ahash_request_set_crypt(hash, &sg, NULL, copied);
 	crypto_ahash_update(hash);
 	return copied;
+#else
+	return 0;
+#endif
 }
 EXPORT_SYMBOL(hash_and_copy_to_iter);
 
-- 
2.19.1

