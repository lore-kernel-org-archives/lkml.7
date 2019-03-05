Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66167C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8732082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbfCEJwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 04:52:50 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4770 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726179AbfCEJwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 04:52:50 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1DB74868EC648C63CD9E;
        Tue,  5 Mar 2019 17:52:48 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Tue, 5 Mar 2019 17:52:38 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: fix to use kvfree instead of kzfree
Date:   Tue, 5 Mar 2019 17:52:33 +0800
Message-ID: <20190305095233.126601-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20190305095233.126601-1-yuchao0@huawei.com>
References: <20190305095233.126601-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Jiqun Li reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=202747

System can panic due to using wrong allocate/free function pair
in xattr interface:
- use kvmalloc to allocate memory
- use kzfree to free memory

Let's fix to use kvfree instead of kzfree, BTW, we are safe to
get rid of kzfree, since there is no such confidential data stored
as xattr, we don't need to zero it before free memory.

Fixes: 5222595d093e ("f2fs: use kvmalloc, if kmalloc is failed")
Reported-by: Jiqun Li <jiqun.li@unisoc.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/xattr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index fa620d31ea5f..ca47224d78ab 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -340,7 +340,7 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 	*base_addr = txattr_addr;
 	return 0;
 out:
-	kzfree(txattr_addr);
+	kvfree(txattr_addr);
 	return err;
 }
 
@@ -383,7 +383,7 @@ static int read_all_xattrs(struct inode *inode, struct page *ipage,
 	*base_addr = txattr_addr;
 	return 0;
 fail:
-	kzfree(txattr_addr);
+	kvfree(txattr_addr);
 	return err;
 }
 
@@ -510,7 +510,7 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
 	}
 	error = size;
 out:
-	kzfree(base_addr);
+	kvfree(base_addr);
 	return error;
 }
 
@@ -556,7 +556,7 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 	}
 	error = buffer_size - rest;
 cleanup:
-	kzfree(base_addr);
+	kvfree(base_addr);
 	return error;
 }
 
@@ -687,7 +687,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	if (!error && S_ISDIR(inode->i_mode))
 		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
 exit:
-	kzfree(base_addr);
+	kvfree(base_addr);
 	return error;
 }
 
-- 
2.18.0.rc1

