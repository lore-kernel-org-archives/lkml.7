Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9503BC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC2A21855
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569948105;
	bh=RZ+WOcSOBvQdQXPYEN1ohKIQpxofeW8IA32kr+1bOQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YI8TlFwiva3uP4uNyqjnSIOIvBEsqQxGwx2GKGXu5ksEbDdTbHon2knLav14CaCow
	 58H2lqjm/lj1eg1Bx32LSW8Gmze0n7j0vfHq1GjvtnV01DKH5svwF4cKQ/lR364L45
	 zpzMnwsbq1tpOmnLVjgud4Dm7DovC1vW++yEIoVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731289AbfJAQlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:41:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731168AbfJAQlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:41:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1188E2190F;
        Tue,  1 Oct 2019 16:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569948098;
        bh=RZ+WOcSOBvQdQXPYEN1ohKIQpxofeW8IA32kr+1bOQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1TgcFVG5MLZnMMVQpLNF+ZKATvqkfm10J7MG6fJ8HIgL04UT0jK20zjh2UMNYGn+3
         R9tVQ++8hgCY5bhCkNtbFHzjywmZHzfQLhfqj1ke/juJyBCV4z+3otpxvbz/GhFNZn
         kfsjftS+2N2gJga0LkpYkeRf1mYnaq/Mq+0QvEF8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 10/63] fuse: fix request limit
Date:   Tue,  1 Oct 2019 12:40:32 -0400
Message-Id: <20191001164125.15398-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001164125.15398-1-sashal@kernel.org>
References: <20191001164125.15398-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miklos Szeredi <mszeredi@redhat.com>

[ Upstream commit f22f812d5ce75a18b56073a7a63862e6ea764070 ]

The size of struct fuse_req was reduced from 392B to 144B on a non-debug
config, thus the sanitize_global_limit() helper was setting a larger
default limit.  This doesn't really reflect reduction in the memory used by
requests, since the fields removed from fuse_req were added to fuse_args
derived structs; e.g. sizeof(struct fuse_writepages_args) is 248B, thus
resulting in slightly more memory being used for writepage requests
overalll (due to using 256B slabs).

Make the calculatation ignore the size of fuse_req and use the old 392B
value.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 4bb885b0f0322..04b10b3b8741b 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -822,9 +822,12 @@ static const struct super_operations fuse_super_operations = {
 
 static void sanitize_global_limit(unsigned *limit)
 {
+	/*
+	 * The default maximum number of async requests is calculated to consume
+	 * 1/2^13 of the total memory, assuming 392 bytes per request.
+	 */
 	if (*limit == 0)
-		*limit = ((totalram_pages() << PAGE_SHIFT) >> 13) /
-			 sizeof(struct fuse_req);
+		*limit = ((totalram_pages() << PAGE_SHIFT) >> 13) / 392;
 
 	if (*limit >= 1 << 16)
 		*limit = (1 << 16) - 1;
-- 
2.20.1

