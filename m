Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEB9C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4C020835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfCGJbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:31:50 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5216 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726359AbfCGJbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 04:31:47 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 187B66FA6488964AC747;
        Thu,  7 Mar 2019 17:31:45 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Thu, 7 Mar 2019 17:31:37 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: don't trigger read IO for beyond EOF page
Date:   Thu, 7 Mar 2019 17:31:30 +0800
Message-ID: <20190307093130.28556-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In f2fs_mpage_readpages(), if page is beyond EOF, we should just
zero out it, but previously, before checking previous mapping
info, we missed to check filesize boundary, fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index fa6318549af5..912fdcc2dbb8 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1551,6 +1551,9 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 		if (last_block > last_block_in_file)
 			last_block = last_block_in_file;
 
+		/* just zeroing out page which is beyond EOF */
+		if (block_in_file >= last_block)
+			goto zero_out;
 		/*
 		 * Map blocks using the previous result first.
 		 */
@@ -1563,16 +1566,11 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 		 * Then do more f2fs_map_blocks() calls until we are
 		 * done with this page.
 		 */
-		map.m_flags = 0;
+		map.m_lblk = block_in_file;
+		map.m_len = last_block - block_in_file;
 
-		if (block_in_file < last_block) {
-			map.m_lblk = block_in_file;
-			map.m_len = last_block - block_in_file;
-
-			if (f2fs_map_blocks(inode, &map, 0,
-						F2FS_GET_BLOCK_DEFAULT))
-				goto set_error_page;
-		}
+		if (f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_DEFAULT))
+			goto set_error_page;
 got_it:
 		if ((map.m_flags & F2FS_MAP_MAPPED)) {
 			block_nr = map.m_pblk + block_in_file - map.m_lblk;
@@ -1587,6 +1585,7 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 								DATA_GENERIC))
 				goto set_error_page;
 		} else {
+zero_out:
 			zero_user_segment(page, 0, PAGE_SIZE);
 			if (!PageUptodate(page))
 				SetPageUptodate(page);
-- 
2.18.0.rc1

