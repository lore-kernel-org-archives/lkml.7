Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58DBC28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2314248CE
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559395948;
	bh=iKod4ujLD3GMf7gRtRiDoKCO56odgA9jojar++NJ1ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k+8EaXqi3YGSNASdOW4C6c3A56byn7ThfJz2Mh03kkX3BSPzBa/o/9EoGZLkZetoJ
	 MOztLOqO4qqdIYTVKKTn6PpkJXS5jcgvxrHyX2PJD/TmJXjG8kryyeZl8CRP7elqzO
	 9ww9MvunN+Uxq4L6nhhiNM9anj6/KJbtjXzbWaaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbfFANYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:24:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729296AbfFANYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:24:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFFE4264C3;
        Sat,  1 Jun 2019 13:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395483;
        bh=iKod4ujLD3GMf7gRtRiDoKCO56odgA9jojar++NJ1ys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hR0e1qudBoOAvRR6qMrYI+LmniMvd+TZlWFBNF98Z1LQ2ztpsRW2Y1xUBPi/zjEVV
         EKIlXxUFh9DtzabPGUAYKqanX2hIb13YR8Cl9fk/IboHeW8CtH9gFj9xESzyhXnAmE
         xNSlWiQz53DybbbzofnIMC1RZ1Su3bIfcn64ytZA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.14 28/99] f2fs: fix to clear dirty inode in error path of f2fs_iget()
Date:   Sat,  1 Jun 2019 09:22:35 -0400
Message-Id: <20190601132346.26558-28-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601132346.26558-1-sashal@kernel.org>
References: <20190601132346.26558-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 546d22f070d64a7b96f57c93333772085d3a5e6d ]

As Jungyeon reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=203217

- Overview
When mounting the attached crafted image and running program, I got this error.
Additionally, it hangs on sync after running the program.

The image is intentionally fuzzed from a normal f2fs image for testing and I enabled option CONFIG_F2FS_CHECK_FS on.

- Reproduces
cc poc_test_05.c
mkdir test
mount -t f2fs tmp.img test
sudo ./a.out
sync

- Messages
 kernel BUG at fs/f2fs/inode.c:707!
 RIP: 0010:f2fs_evict_inode+0x33f/0x3a0
 Call Trace:
  evict+0xba/0x180
  f2fs_iget+0x598/0xdf0
  f2fs_lookup+0x136/0x320
  __lookup_slow+0x92/0x140
  lookup_slow+0x30/0x50
  walk_component+0x1c1/0x350
  path_lookupat+0x62/0x200
  filename_lookup+0xb3/0x1a0
  do_readlinkat+0x56/0x110
  __x64_sys_readlink+0x16/0x20
  do_syscall_64+0x43/0xf0
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

During inode loading, __recover_inline_status() can recovery inode status
and set inode dirty, once we failed in following process, it will fail
the check in f2fs_evict_inode, result in trigger BUG_ON().

Let's clear dirty inode in error path of f2fs_iget() to avoid panic.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 50818b519df8b..e02ed16bc35cd 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -397,6 +397,7 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 	return inode;
 
 bad_inode:
+	f2fs_inode_synced(inode);
 	iget_failed(inode);
 	trace_f2fs_iget_exit(inode, ret);
 	return ERR_PTR(ret);
-- 
2.20.1

