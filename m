Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A36C43215
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9BC20803
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573919000;
	bh=9jTiWjD3dsUPaP+cMWDmZ87NWsOHV8AQalAaCPDJXAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VYqFbhrelCyzhJVkV9WWWHmPEO9oIJXJpMlUD3Pzra/A/wrZCT1hxIBc8cUMS2u/D
	 7ttjHiiBp11eFJi4EKsGwj42RkvlsZ8PSdiSqHxVB65Ii2CJkFvK9lDinZuelWNMuM
	 +tv/Y5ak0imoT37o1wNK8UVEWP8vxsQKtDcJoa4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbfKPPnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:43:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:47174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728638AbfKPPnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:43:17 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 639132077B;
        Sat, 16 Nov 2019 15:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573918995;
        bh=9jTiWjD3dsUPaP+cMWDmZ87NWsOHV8AQalAaCPDJXAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LE+sXpZulMrM2cQl27gjXx5tYvbmg3PgxIT5E85ic7A8Ii99W5ymWx3TD20wafATX
         dT4g4vLbGdg3mo4MADI0IlpHqS08bwEVnloX3PRs6erZdz/BoUG7IRfFVWouz6c+U1
         0ruBHIHx0nfTkDeTcyJlCZkVqCynKzrrPHYlMyMM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Luis Henriques <lhenriques@suse.com>,
        "Yan, Zheng" <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 099/237] ceph: only allow punch hole mode in fallocate
Date:   Sat, 16 Nov 2019 10:38:54 -0500
Message-Id: <20191116154113.7417-99-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luis Henriques <lhenriques@suse.com>

[ Upstream commit bddff633ab7bc60a18a86ac8b322695b6f8594d0 ]

Current implementation of cephfs fallocate isn't correct as it doesn't
really reserve the space in the cluster, which means that a subsequent
call to a write may actually fail due to lack of space.  In fact, it is
currently possible to fallocate an amount space that is larger than the
free space in the cluster.  It has behaved this way since the initial
commit ad7a60de882a ("ceph: punch hole support").

Since there's no easy solution to fix this at the moment, this patch
simply removes support for all fallocate operations but
FALLOC_FL_PUNCH_HOLE (which implies FALLOC_FL_KEEP_SIZE).

Link: https://tracker.ceph.com/issues/36317
Signed-off-by: Luis Henriques <lhenriques@suse.com>
Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/file.c | 45 +++++++++------------------------------------
 1 file changed, 9 insertions(+), 36 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 92ab204336829..91a7ad259bcf2 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1735,7 +1735,6 @@ static long ceph_fallocate(struct file *file, int mode,
 	struct ceph_file_info *fi = file->private_data;
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
 	struct ceph_cap_flush *prealloc_cf;
 	int want, got = 0;
 	int dirty;
@@ -1743,10 +1742,7 @@ static long ceph_fallocate(struct file *file, int mode,
 	loff_t endoff = 0;
 	loff_t size;
 
-	if ((offset + length) > max(i_size_read(inode), fsc->max_file_size))
-		return -EFBIG;
-
-	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
+	if (mode != (FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
 		return -EOPNOTSUPP;
 
 	if (!S_ISREG(inode->i_mode))
@@ -1763,18 +1759,6 @@ static long ceph_fallocate(struct file *file, int mode,
 		goto unlock;
 	}
 
-	if (!(mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)) &&
-	    ceph_quota_is_max_bytes_exceeded(inode, offset + length)) {
-		ret = -EDQUOT;
-		goto unlock;
-	}
-
-	if (ceph_osdmap_flag(&fsc->client->osdc, CEPH_OSDMAP_FULL) &&
-	    !(mode & FALLOC_FL_PUNCH_HOLE)) {
-		ret = -ENOSPC;
-		goto unlock;
-	}
-
 	if (ci->i_inline_version != CEPH_INLINE_NONE) {
 		ret = ceph_uninline_data(file, NULL);
 		if (ret < 0)
@@ -1782,12 +1766,12 @@ static long ceph_fallocate(struct file *file, int mode,
 	}
 
 	size = i_size_read(inode);
-	if (!(mode & FALLOC_FL_KEEP_SIZE)) {
-		endoff = offset + length;
-		ret = inode_newsize_ok(inode, endoff);
-		if (ret)
-			goto unlock;
-	}
+
+	/* Are we punching a hole beyond EOF? */
+	if (offset >= size)
+		goto unlock;
+	if ((offset + length) > size)
+		length = size - offset;
 
 	if (fi->fmode & CEPH_FILE_MODE_LAZY)
 		want = CEPH_CAP_FILE_BUFFER | CEPH_CAP_FILE_LAZYIO;
@@ -1798,16 +1782,8 @@ static long ceph_fallocate(struct file *file, int mode,
 	if (ret < 0)
 		goto unlock;
 
-	if (mode & FALLOC_FL_PUNCH_HOLE) {
-		if (offset < size)
-			ceph_zero_pagecache_range(inode, offset, length);
-		ret = ceph_zero_objects(inode, offset, length);
-	} else if (endoff > size) {
-		truncate_pagecache_range(inode, size, -1);
-		if (ceph_inode_set_size(inode, endoff))
-			ceph_check_caps(ceph_inode(inode),
-				CHECK_CAPS_AUTHONLY, NULL);
-	}
+	ceph_zero_pagecache_range(inode, offset, length);
+	ret = ceph_zero_objects(inode, offset, length);
 
 	if (!ret) {
 		spin_lock(&ci->i_ceph_lock);
@@ -1817,9 +1793,6 @@ static long ceph_fallocate(struct file *file, int mode,
 		spin_unlock(&ci->i_ceph_lock);
 		if (dirty)
 			__mark_inode_dirty(inode, dirty);
-		if ((endoff > size) &&
-		    ceph_quota_is_max_bytes_approaching(inode, endoff))
-			ceph_check_caps(ci, CHECK_CAPS_NODELAY, NULL);
 	}
 
 	ceph_put_cap_refs(ci, got);
-- 
2.20.1

