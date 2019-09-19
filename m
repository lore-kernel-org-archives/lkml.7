Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C77C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B4121907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931049;
	bh=5NgFewY6WF0/ll0jM4pfbCuhJk4jlxUU9PS5C1LOheg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z4K8yxrI3mEyrSonmfTm8cy2KBb0Wr5jGf63kKC7aPvT/e1CZqmVx7QQXFN7q94Ip
	 EN8o9nBHLY8HEVh27E9Ehjs5x5BG2tTDyApM9Yh388L6/Qa+1cyxaqUpmT8HEGILIM
	 lRiTEBZpUbKEN8x1WTDGt503mpVz5IcRb992msYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405753AbfISWKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:10:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405738AbfISWKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:10:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69B4A21907;
        Thu, 19 Sep 2019 22:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931044;
        bh=5NgFewY6WF0/ll0jM4pfbCuhJk4jlxUU9PS5C1LOheg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gkUTsCjE7r5KiyUZBd5T5OtUi8Ys/fo5oCEWYKAzqJewIXtULWJPXXAsFtDrz6sM+
         044dTzie5OwiiLCsHXVfzNFd8dKUljMXwpI4VE6KwiCTjhH7SGGEX6qBNTEiB9bbT5
         OyGBZ6JLksrlZIYa/fMfv/L32hYMeJhN7gtJDfts=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 075/124] NFS: remove set but not used variable mapping
Date:   Fri, 20 Sep 2019 00:02:43 +0200
Message-Id: <20190919214821.731914191@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214819.198419517@linuxfoundation.org>
References: <20190919214819.198419517@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 99300a85260c2b7febd57082a617d1062532067e ]

Fixes gcc '-Wunused-but-set-variable' warning:

fs/nfs/write.c: In function nfs_page_async_flush:
fs/nfs/write.c:609:24: warning: variable mapping set but not used [-Wunused-but-set-variable]

It is not use since commit aefb623c422e ("NFS: Fix
writepage(s) error handling to not report errors twice")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/write.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 0d6d7beb85053..ee6932c9819e0 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -606,7 +606,6 @@ static void nfs_write_error(struct nfs_page *req, int error)
 static int nfs_page_async_flush(struct nfs_pageio_descriptor *pgio,
 				struct page *page)
 {
-	struct address_space *mapping;
 	struct nfs_page *req;
 	int ret = 0;
 
@@ -621,7 +620,6 @@ static int nfs_page_async_flush(struct nfs_pageio_descriptor *pgio,
 	WARN_ON_ONCE(test_bit(PG_CLEAN, &req->wb_flags));
 
 	/* If there is a fatal error that covers this write, just exit */
-	mapping = page_file_mapping(page);
 	ret = pgio->pg_error;
 	if (nfs_error_is_fatal_on_server(ret))
 		goto out_launder;
-- 
2.20.1



