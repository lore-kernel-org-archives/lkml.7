Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12234C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D526C20833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfDOH2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:28:54 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2533 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726034AbfDOH2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:28:52 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id B0EABC79CC1CCD7C4093;
        Mon, 15 Apr 2019 15:28:50 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 15 Apr 2019 15:28:50 +0800
Received: from szvp000201624.huawei.com (10.120.216.130) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 15 Apr 2019 15:28:49 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 06/13] f2fs: fix to do checksum even if inode page is uptodate
Date:   Mon, 15 Apr 2019 15:28:35 +0800
Message-ID: <20190415072842.2438-6-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20190415072842.2438-1-yuchao0@huawei.com>
References: <20190415072842.2438-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-ClientProxiedBy: dggeme710-chm.china.huawei.com (10.1.199.106) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Jungyeon reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=203221

- Overview
When mounting the attached crafted image and running program, this error is reported.

The image is intentionally fuzzed from a normal f2fs image for testing and I enabled option CONFIG_F2FS_CHECK_FS on.

- Reproduces
cc poc_07.c
mkdir test
mount -t f2fs tmp.img test
cp a.out test
cd test
sudo ./a.out

- Messages
 kernel BUG at fs/f2fs/node.c:1279!
 RIP: 0010:read_node_page+0xcf/0xf0
 Call Trace:
  __get_node_page+0x6b/0x2f0
  f2fs_iget+0x8f/0xdf0
  f2fs_lookup+0x136/0x320
  __lookup_slow+0x92/0x140
  lookup_slow+0x30/0x50
  walk_component+0x1c1/0x350
  path_lookupat+0x62/0x200
  filename_lookup+0xb3/0x1a0
  do_fchmodat+0x3e/0xa0
  __x64_sys_chmod+0x12/0x20
  do_syscall_64+0x43/0xf0
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

On below paths, we can have opportunity to readahead inode page
- gc_node_segment -> f2fs_ra_node_page
- gc_data_segment -> f2fs_ra_node_page
- f2fs_fill_dentries -> f2fs_ra_node_page

Unlike synchronized read, on readahead path, we can set page uptodate
before verifying page's checksum, then read_node_page() will trigger
kernel panic once it encounters a uptodated page w/ incorrect checksum.

So considering readahead scenario, we have to do checksum each time
when loading inode page even if it is uptodated.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/inode.c | 4 ++--
 fs/f2fs/node.c  | 7 ++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 03a354d5e6ab..ccb02226dd2c 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -177,8 +177,8 @@ bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct page *page)
 
 	if (provided != calculated)
 		f2fs_msg(sbi->sb, KERN_WARNING,
-			"checksum invalid, ino = %x, %x vs. %x",
-			ino_of_node(page), provided, calculated);
+			"checksum invalid, nid = %lu, ino_of_node = %x, %x vs. %x",
+			page->index, ino_of_node(page), provided, calculated);
 
 	return provided == calculated;
 }
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 58073c5bd221..431d9384d1b6 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1286,9 +1286,10 @@ static int read_node_page(struct page *page, int op_flags)
 	int err;
 
 	if (PageUptodate(page)) {
-#ifdef CONFIG_F2FS_CHECK_FS
-		f2fs_bug_on(sbi, !f2fs_inode_chksum_verify(sbi, page));
-#endif
+		if (!f2fs_inode_chksum_verify(sbi, page)) {
+			ClearPageUptodate(page);
+			return -EBADMSG;
+		}
 		return LOCKED_PAGE;
 	}
 
-- 
2.18.0.rc1

