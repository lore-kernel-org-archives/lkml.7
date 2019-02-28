Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E812C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB2F20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367905;
	bh=nEspNuCH+xpcUbdLYQxhd6Lf5xyNqvNwM+07D8kp1lM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gsj3vbELCvwR/lVTFspBmf2uS+fr16YmrWpOGZYXa+NveAAY2g/H0lQUc4Oj7Wquo
	 Ixrs7oq9iYGmQcQ96WXv087aYPVn6ZoMyf7ZdR9h6hUwAZclUJbKFRAE/E02ItBr4p
	 tgHofEu6cuUAhYl9ADII232LA/HmUC81/4c9Ee1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389157AbfB1Pbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:31:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:41606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387456AbfB1PJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:09:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A445F206B8;
        Thu, 28 Feb 2019 15:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366547;
        bh=nEspNuCH+xpcUbdLYQxhd6Lf5xyNqvNwM+07D8kp1lM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Azb6oJXlQy51zzCq/Pjjt2rw6C/+hllkUoG9WSzURfYvMYkUIV5lM5NYg7oZfsPB
         vwoG4r9z4eHXDsr9jggGgJQspYk6ydcKQjP0eLUYdEfGlOxci9Bk8bk8b1DKDvNiV3
         n7pWnhF8ot1o6Shwv6wH8PFTRpBoEaIwpXQh+nmA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Omar Sandoval <osandov@fb.com>, Jens Axboe <axboe@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 35/81] debugfs: debugfs_lookup() should return NULL if not found
Date:   Thu, 28 Feb 2019 10:07:27 -0500
Message-Id: <20190228150813.10256-35-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[ Upstream commit 37ea7b630ae5cdea4e8ff381d9d23abfef5939e6 ]

Lots of callers of debugfs_lookup() were just checking NULL to see if
the file/directory was found or not.  By changing this in ff9fb72bc077
("debugfs: return error values, not NULL") we caused some subsystems to
easily crash.

Fixes: ff9fb72bc077 ("debugfs: return error values, not NULL")
Reported-by: syzbot+b382ba6a802a3d242790@syzkaller.appspotmail.com
Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Jens Axboe <axboe@fb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/debugfs/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index b16f8035b1af7..29c68c5d44d5f 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -254,8 +254,8 @@ MODULE_ALIAS_FS("debugfs");
  * @parent: a pointer to the parent dentry of the file.
  *
  * This function will return a pointer to a dentry if it succeeds.  If the file
- * doesn't exist or an error occurs, %ERR_PTR(-ERROR) will be returned.  The
- * returned dentry must be passed to dput() when it is no longer needed.
+ * doesn't exist or an error occurs, %NULL will be returned.  The returned
+ * dentry must be passed to dput() when it is no longer needed.
  *
  * If debugfs is not enabled in the kernel, the value -%ENODEV will be
  * returned.
@@ -265,17 +265,17 @@ struct dentry *debugfs_lookup(const char *name, struct dentry *parent)
 	struct dentry *dentry;
 
 	if (IS_ERR(parent))
-		return parent;
+		return NULL;
 
 	if (!parent)
 		parent = debugfs_mount->mnt_root;
 
 	dentry = lookup_one_len_unlocked(name, parent, strlen(name));
 	if (IS_ERR(dentry))
-		return dentry;
+		return NULL;
 	if (!d_really_is_positive(dentry)) {
 		dput(dentry);
-		return ERR_PTR(-EINVAL);
+		return NULL;
 	}
 	return dentry;
 }
-- 
2.19.1

