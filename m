Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F27C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C902720675
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611259;
	bh=su+vPTFnWpZh3p/InwWOGEwKQc4cfRYNn+dKZ4k6rGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g6FMNJnC7JkzxTz3CVaRMNZqKhZKtfhCQN3CE5Ifb0M91JpnMj9wQ+bFKlEeO3wRU
	 ktBFWWNkAJQtXm6Umfj/m2R+rfXGNEDVe+alUS/XPGGIwYHdThdXeQd9ATfvsSsXLc
	 ZiYoSksYA70jgzbG/Up8zGeW6xju15Y9+aw6WdZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391650AbfDRSOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:14:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404183AbfDRSM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:12:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3110F206B6;
        Thu, 18 Apr 2019 18:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611178;
        bh=su+vPTFnWpZh3p/InwWOGEwKQc4cfRYNn+dKZ4k6rGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jl/xuqAXw6/mKbhOdgecakqZ+uMRYjSsvTCWfU9LAeoc658Ud1r31ykaQIGQqCZV5
         XDtdIOuZJdECWQC0RdNPHjDW6T8d/nzvuB32OZjbE7+f6pR4aLXVkojGZppQ/ENeDL
         6NO/fNCaW/avd7235MaGbeyvNa341meESJ6aigHc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Seulbae Kim <seulbae@gatech.edu>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 88/93] f2fs: fix to dirty inode for i_mode recovery
Date:   Thu, 18 Apr 2019 19:58:06 +0200
Message-Id: <20190418160445.689370123@linuxfoundation.org>
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

[ Upstream commit ca597bddedd94906cd761d8be6a3ad21292725de ]

As Seulbae Kim reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=202637

We didn't recover permission field correctly after sudden power-cut,
the reason is in setattr we didn't add inode into global dirty list
once i_mode is changed, so latter checkpoint triggered by fsync will
not flush last i_mode into disk, result in this problem, fix it.

Reported-by: Seulbae Kim <seulbae@gatech.edu>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ae2b45e75847..30ed43bce110 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -768,7 +768,6 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	int err;
-	bool size_changed = false;
 
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
 		return -EIO;
@@ -843,8 +842,6 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 		down_write(&F2FS_I(inode)->i_sem);
 		F2FS_I(inode)->last_disk_size = i_size_read(inode);
 		up_write(&F2FS_I(inode)->i_sem);
-
-		size_changed = true;
 	}
 
 	__setattr_copy(inode, attr);
@@ -858,7 +855,7 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 	}
 
 	/* file size may changed here */
-	f2fs_mark_inode_dirty_sync(inode, size_changed);
+	f2fs_mark_inode_dirty_sync(inode, true);
 
 	/* inode change will produce dirty node pages flushed by checkpoint */
 	f2fs_balance_fs(F2FS_I_SB(inode), true);
-- 
2.19.1



