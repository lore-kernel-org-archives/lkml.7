Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFD5C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051562089D
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573920641;
	bh=Cyz/ltkVZ79YYSWUegWFEuN6IGPYYvpiwX20k9pvej8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DrpD1KtcTFk31X6vQL/qaEVP3m8PUnrPsK0lBDBq8PXI6arCWpwzGgUhfZaNQPOf+
	 /SY8NjEVPBoaRysrBaD/0zPtvFe9rKsVshiWHmqLgMieXrKWu0iz8xVvCwsHolMUpy
	 kXyAmfsQ5xOozzml7h3CG7oPeje+X3LS4WNT1wkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbfKPPsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:48:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:55914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728795AbfKPPsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:48:41 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6E7420895;
        Sat, 16 Nov 2019 15:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919321;
        bh=Cyz/ltkVZ79YYSWUegWFEuN6IGPYYvpiwX20k9pvej8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2DuFa7T3CdrK5/vnYSSW0UvUp46eF9Ki9C1f668E7RUJDbV7njf7SY7iBQSP+NNCQ
         Ee2v6NjGpmjAhFyAXd69S466ZqK70VO3IFw2oPhi+eXPsNF+jL6B+O9eGpJ7/TIv3W
         3/56Z00PHaEg6cvD48p92KHO37b9/feP8naHyA4g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chao Yu <yuchao0@huawei.com>, Weichao Guo <guoweichao@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.14 063/150] f2fs: fix to spread clear_cold_data()
Date:   Sat, 16 Nov 2019 10:46:01 -0500
Message-Id: <20191116154729.9573-63-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154729.9573-1-sashal@kernel.org>
References: <20191116154729.9573-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 2baf07818549c8bb8d7b3437e889b86eab56d38e ]

We need to drop PG_checked flag on page as well when we clear PG_uptodate
flag, in order to avoid treating the page as GCing one later.

Signed-off-by: Weichao Guo <guoweichao@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c    | 8 +++++++-
 fs/f2fs/dir.c     | 1 +
 fs/f2fs/segment.c | 4 +++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index cc57294451940..ac3fa4bbed2d9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1445,6 +1445,7 @@ int do_write_data_page(struct f2fs_io_info *fio)
 	/* This page is already truncated */
 	if (fio->old_blkaddr == NULL_ADDR) {
 		ClearPageUptodate(page);
+		clear_cold_data(page);
 		goto out_writepage;
 	}
 got_it:
@@ -1597,8 +1598,10 @@ static int __write_data_page(struct page *page, bool *submitted,
 
 out:
 	inode_dec_dirty_pages(inode);
-	if (err)
+	if (err) {
 		ClearPageUptodate(page);
+		clear_cold_data(page);
+	}
 
 	if (wbc->for_reclaim) {
 		f2fs_submit_merged_write_cond(sbi, inode, 0, page->index, DATA);
@@ -2158,6 +2161,8 @@ void f2fs_invalidate_page(struct page *page, unsigned int offset,
 		}
 	}
 
+	clear_cold_data(page);
+
 	/* This is atomic written page, keep Private */
 	if (IS_ATOMIC_WRITTEN_PAGE(page))
 		return drop_inmem_page(inode, page);
@@ -2176,6 +2181,7 @@ int f2fs_release_page(struct page *page, gfp_t wait)
 	if (IS_ATOMIC_WRITTEN_PAGE(page))
 		return 0;
 
+	clear_cold_data(page);
 	set_page_private(page, 0);
 	ClearPagePrivate(page);
 	return 1;
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index c0c933ad43c8d..4abefd841b6c7 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -745,6 +745,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 		clear_page_dirty_for_io(page);
 		ClearPagePrivate(page);
 		ClearPageUptodate(page);
+		clear_cold_data(page);
 		inode_dec_dirty_pages(dir);
 		remove_dirty_inode(dir);
 	}
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9e5fca35e47d0..2cd0d126ef8fa 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -251,8 +251,10 @@ static int __revoke_inmem_pages(struct inode *inode,
 		}
 next:
 		/* we don't need to invalidate this in the sccessful status */
-		if (drop || recover)
+		if (drop || recover) {
 			ClearPageUptodate(page);
+			clear_cold_data(page);
+		}
 		set_page_private(page, 0);
 		ClearPagePrivate(page);
 		f2fs_put_page(page, 1);
-- 
2.20.1

