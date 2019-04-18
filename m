Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F22C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2615A21872
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611187;
	bh=5baeiWPity8RZOHQWtYXZdv2SBsImonly71ywxIiovA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lr9RaDCTyXPsT6CJdvwEh8fae2BrHbDvW74EKVtVKt/1MA+0i6JxfX0Zd3IAwswyH
	 gjY0V8Siz2r6I690zfgqvhXcE7VX3Im53EQssyoncTSE27S/oedKpZTGnETXHi1CDy
	 2O7SB6Jl9JERgi5z4ZHq9fRak2tgHEaqBAQS8m5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391879AbfDRSNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:13:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390416AbfDRSNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:13:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D232F214DA;
        Thu, 18 Apr 2019 18:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611181;
        bh=5baeiWPity8RZOHQWtYXZdv2SBsImonly71ywxIiovA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b72Waq6Yw6+EZMrnKTEHNECggc80sjodRmMTFQrt8aVianamOoKF+hT8JD1HuUFUL
         ILe2a+FpGlNROv3/NG6zNZMHdOs5T04FaDiGeavkIdgIeZp+mAktSK4RaYowJ7b/ta
         RzL6dz9b/gGtqssegEjMUcXRgQOuY3omkQbKm/Gk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiqun Li <jiqun.li@unisoc.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 89/93] f2fs: fix to use kvfree instead of kzfree
Date:   Thu, 18 Apr 2019 19:58:07 +0200
Message-Id: <20190418160445.763852636@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 2a6a7e722e7a78d774ce02b847c5b183a3ff2672 ]

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
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/xattr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 73b92985198b..6b6fe6431a64 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -347,7 +347,7 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 	*base_addr = txattr_addr;
 	return 0;
 out:
-	kzfree(txattr_addr);
+	kvfree(txattr_addr);
 	return err;
 }
 
@@ -390,7 +390,7 @@ static int read_all_xattrs(struct inode *inode, struct page *ipage,
 	*base_addr = txattr_addr;
 	return 0;
 fail:
-	kzfree(txattr_addr);
+	kvfree(txattr_addr);
 	return err;
 }
 
@@ -517,7 +517,7 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
 	}
 	error = size;
 out:
-	kzfree(base_addr);
+	kvfree(base_addr);
 	return error;
 }
 
@@ -563,7 +563,7 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 	}
 	error = buffer_size - rest;
 cleanup:
-	kzfree(base_addr);
+	kvfree(base_addr);
 	return error;
 }
 
@@ -694,7 +694,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	if (!error && S_ISDIR(inode->i_mode))
 		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
 exit:
-	kzfree(base_addr);
+	kvfree(base_addr);
 	return error;
 }
 
-- 
2.19.1



