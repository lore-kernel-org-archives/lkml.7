Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347EAC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02AC22054F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557208546;
	bh=mColmzft8Nb+sAebGjP60wsb9mHLEDd39ULoikCLQWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rcf1RpbE4w336P/tbSjjeA3Q78yCxJ1rlrXRcyoObhvnEf+txF0ub5diAwif8uunW
	 aeFeJ5WcWmrs+4fjn+WXUD/3M2NM4ykshT2kyT0FcFRkincC7I+YXzhHMTIgaXvh9z
	 ob6eL8/JvF//DMeXG5uijCN4UOtAa+UR93hXZ8Pw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfEGFiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:38:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728499AbfEGFiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:38:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85E9D214AE;
        Tue,  7 May 2019 05:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207485;
        bh=mColmzft8Nb+sAebGjP60wsb9mHLEDd39ULoikCLQWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xuSuZiGkT8DszPhGCJZ4NccO+70AoR17ByxGnoaA5Mzi5Acq1+Y+O7tbyEldVFqBY
         tLESniwSAG+mu86tS+edp0aR/adk3NeXlPZAwrUzImS4wqeWNjTLCIq2pa/auBMdmh
         /gnxexnphg8D+EgMNu9P2eRgBA2EOk6WB2h+4GiA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     zhengliang <zhengliang6@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 69/81] f2fs: fix to data block override node segment by mistake
Date:   Tue,  7 May 2019 01:35:40 -0400
Message-Id: <20190507053554.30848-69-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053554.30848-1-sashal@kernel.org>
References: <20190507053554.30848-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/f2fs/super.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2264f27fd26d..036eb1e0d557 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -890,6 +890,10 @@ static int f2fs_drop_inode(struct inode *inode)
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

