Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245D7C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76EE21874
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565127604;
	bh=xExYZlj16QTL8K2BGncB++iPUVhpTo03XydSzUlUYrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xDwANhIto7ty8kkHX/92tz/P/sXxYrWWA3Y91Xz3npZrh+OJ5tCAYYuHxUwgCVJSs
	 gJxmZ58ap/NxizuPuG8wJwXd+7ivfgb9S03PyBdzVK9Lrd64X+qzn2LYNtRxULk2p4
	 j/YaUtFNRsCZcd2eBmyF0cafAvxI9H3AdtPCjT04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbfHFVkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:40:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728242AbfHFVhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:37:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E00C2186A;
        Tue,  6 Aug 2019 21:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565127430;
        bh=xExYZlj16QTL8K2BGncB++iPUVhpTo03XydSzUlUYrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XAwaarHpV717TG1nAICwOukhfIqjeeYR0tSgg6T0nQr9k77qyAu+clRmplXqF0ywb
         EO90tN1z9HmtovbWNvfYYPA5ik85fODDyTBtytLaMPiFfA1mBm/KsEKe0VmeDR7EW5
         ypkS7zG9Ii5xTZDCD8uXjKJvf0a51gun02xFN7jA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Changwei Ge <gechangwei@live.cn>, Gang He <ghe@suse.com>,
        Jun Piao <piaojun@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 23/25] ocfs2: remove set but not used variable 'last_hash'
Date:   Tue,  6 Aug 2019 17:36:20 -0400
Message-Id: <20190806213624.20194-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806213624.20194-1-sashal@kernel.org>
References: <20190806213624.20194-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

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
index fb0a4eec310ce..77740ef5a8e85 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -3832,7 +3832,6 @@ static int ocfs2_xattr_bucket_find(struct inode *inode,
 	u16 blk_per_bucket = ocfs2_blocks_per_xattr_bucket(inode->i_sb);
 	int low_bucket = 0, bucket, high_bucket;
 	struct ocfs2_xattr_bucket *search;
-	u32 last_hash;
 	u64 blkno, lower_blkno = 0;
 
 	search = ocfs2_xattr_bucket_new(inode);
@@ -3876,8 +3875,6 @@ static int ocfs2_xattr_bucket_find(struct inode *inode,
 		if (xh->xh_count)
 			xe = &xh->xh_entries[le16_to_cpu(xh->xh_count) - 1];
 
-		last_hash = le32_to_cpu(xe->xe_name_hash);
-
 		/* record lower_blkno which may be the insert place. */
 		lower_blkno = blkno;
 
-- 
2.20.1

