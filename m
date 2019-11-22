Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3FFC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67DC2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402312;
	bh=y40CnV5sHXNfG/OegqL8DiLflmo4CWKLC0HwFbpNTzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k+CxEnlVMzMd45k196ngV+31d8q6vCqfcIFxJO6uONC3ma5fYthpWjKakxtGq6jl6
	 h2L017S6Blm6DV3RZ7c0opnHfx8Ev6nxpAh/sjQnJ7PJMAv8XywoZ5FnD+u3eFmYyh
	 f030sBIMP+pG77H4ctbCTPf63nG5Bjtb9mCXq8Mo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbfKVF61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:58:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:36770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727833AbfKVF6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:58:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BCBD2072D;
        Fri, 22 Nov 2019 05:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402286;
        bh=y40CnV5sHXNfG/OegqL8DiLflmo4CWKLC0HwFbpNTzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N/qZL745Wc/0VGWUHqIEwcRDLXqbBzHvM5dS6eFV/9r7bFhZm/u44hdGc6Itjn8Gt
         bVmmhvnoLsofJ/xkCHy8tXd6hD3aKFfWbIaxpMM8tDeG2KBKhvmTPNfmyjIV+5oPf8
         sGHkzGf4T01KiVi5olZsUuSI6RfWIH0OQ+zBIHzs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     zhengliang <zhengliang6@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.14 125/127] f2fs: fix to data block override node segment by mistake
Date:   Fri, 22 Nov 2019 00:55:42 -0500
Message-Id: <20191122055544.3299-123-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122055544.3299-1-sashal@kernel.org>
References: <20191122055544.3299-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhengliang <zhengliang6@huawei.com>

[ Upstream commit a0770e13c8da83bdb64738c0209ab02dd3cfff8b ]

v4: Rearrange the previous three versions.

The following scenario could lead to data block override by mistake.

TASK A            |  TASK kworker                                            |     TASK B                                            |       TASK C
                  |                                                          |                                                       |
open              |                                                          |                                                       |
write             |                                                          |                                                       |
close             |                                                          |                                                       |
                  |  f2fs_write_data_pages                                   |                                                       |
                  |    f2fs_write_cache_pages                                |                                                       |
                  |      f2fs_outplace_write_data                            |                                                       |
                  |        f2fs_allocate_data_block (get block in seg S,     |                                                       |
                  |                                  S is full, and only     |                                                       |
                  |                                  have this valid data    |                                                       |
                  |                                  block)                  |                                                       |
                  |          allocate_segment                                |                                                       |
                  |          locate_dirty_segment (mark S as PRE)            |                                                       |
                  |        f2fs_submit_page_write (submit but is not         |                                                       |
                  |                                written on dev)           |                                                       |
unlink            |                                                          |                                                       |
 iput_final       |                                                          |                                                       |
  f2fs_drop_inode |                                                          |                                                       |
    f2fs_truncate |                                                          |                                                       |
 (not evict)      |                                                          |                                                       |
                  |                                                          | write_checkpoint                                      |
                  |                                                          |  flush merged bio but not wait file data writeback    |
                  |                                                          |  set_prefree_as_free (mark S as FREE)                 |
                  |                                                          |                                                       | update NODE/DATA
                  |                                                          |                                                       | allocate_segment (select S)
                  |     writeback done                                       |                                                       |

So we need to guarantee io complete before truncate inode in f2fs_drop_inode.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Zheng Liang <zhengliang6@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0f3209b23c940..331f16a7c676f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -668,6 +668,10 @@ static int f2fs_drop_inode(struct inode *inode)
 			sb_start_intwrite(inode->i_sb);
 			f2fs_i_size_write(inode, 0);
 
+			f2fs_submit_merged_write_cond(F2FS_I_SB(inode),
+					inode, NULL, 0, DATA);
+			truncate_inode_pages_final(inode->i_mapping);
+
 			if (F2FS_HAS_BLOCKS(inode))
 				f2fs_truncate(inode);
 
-- 
2.20.1

