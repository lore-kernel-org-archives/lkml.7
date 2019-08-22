Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC75C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5305923400
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495100;
	bh=eVVfnND6+8w4CpkKtZC2eBq5M8dM5nUmyL4NnSPSKpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b0zlJdm+IZrhIzqFGVZqZUErUveg9wrBCpt/VzMwJBBIQa2+nwKx2wfpE0m3GH25F
	 +lzGzYRnDwDCXRcFN4yvfQVOEgN6MyOSeaEDRkC3wiJuFmBBPNCvOqlyhn0/CENWoF
	 U4Bf+FvOsYOB+VrA9ZeT7az8RtjBngkMGajrLRuM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392253AbfHVRbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:31:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404511AbfHVRZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:25:53 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCBFB23405;
        Thu, 22 Aug 2019 17:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494753;
        bh=eVVfnND6+8w4CpkKtZC2eBq5M8dM5nUmyL4NnSPSKpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f4jZBrcB+pzlsu7Yrdc5jDwDgpOFuXjsC8iunTem9JHv907uVuFBsWs/gMLRUxtjS
         3d4s3K7osI5b7zq0KCMmbeUYZRouodumvp91jtkx5NwOerBAOnGBeKDbxIwBOqOZhS
         FaE1Fwe9ZmXp6n0M1dhqYg9Kh2UQy890sST9wYpw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Changwei Ge <gechangwei@live.cn>, Gang He <ghe@suse.com>,
        Jun Piao <piaojun@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 52/85] ocfs2: remove set but not used variable last_hash
Date:   Thu, 22 Aug 2019 10:19:25 -0700
Message-Id: <20190822171733.513920094@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171731.012687054@linuxfoundation.org>
References: <20190822171731.012687054@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 7bc36e3ce91471b6377c8eadc0a2f220a2280083 ]

Fixes gcc '-Wunused-but-set-variable' warning:

  fs/ocfs2/xattr.c: In function ocfs2_xattr_bucket_find:
  fs/ocfs2/xattr.c:3828:6: warning: variable last_hash set but not used [-Wunused-but-set-variable]

It's never used and can be removed.

Link: http://lkml.kernel.org/r/20190716132110.34836-1-yuehaibing@huawei.com
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Gang He <ghe@suse.com>
Cc: Jun Piao <piaojun@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/xattr.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 3a24ce3deb013..c146e12a8601f 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -3833,7 +3833,6 @@ static int ocfs2_xattr_bucket_find(struct inode *inode,
 	u16 blk_per_bucket = ocfs2_blocks_per_xattr_bucket(inode->i_sb);
 	int low_bucket = 0, bucket, high_bucket;
 	struct ocfs2_xattr_bucket *search;
-	u32 last_hash;
 	u64 blkno, lower_blkno = 0;
 
 	search = ocfs2_xattr_bucket_new(inode);
@@ -3877,8 +3876,6 @@ static int ocfs2_xattr_bucket_find(struct inode *inode,
 		if (xh->xh_count)
 			xe = &xh->xh_entries[le16_to_cpu(xh->xh_count) - 1];
 
-		last_hash = le32_to_cpu(xe->xe_name_hash);
-
 		/* record lower_blkno which may be the insert place. */
 		lower_blkno = blkno;
 
-- 
2.20.1



