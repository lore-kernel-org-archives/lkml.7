Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01350C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15252087B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbfHEKQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 06:16:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3758 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728015AbfHEKQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 06:16:31 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3ED3AA3D28D9E43575E3;
        Mon,  5 Aug 2019 18:16:30 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Mon, 5 Aug 2019 18:16:23 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH RESEND] f2fs: fix wrong .available_nid calculation
Date:   Mon, 5 Aug 2019 18:16:20 +0800
Message-ID: <20190805101620.26233-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mkfs, we have counted quota file's node number in cp.valid_node_count,
so we have to avoid wrong substraction of quota node number in
.available_nid calculation.

f2fs_write_check_point_pack()
{
..
	set_cp(valid_node_count, 1 + c.quota_inum + c.lpf_inum);

Fixes: 292c196a3695 ("reserve nid resource for quota sysfile")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index a18b2a895771..d9ba1db2d01e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2964,7 +2964,7 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 
 	/* not used nids: 0, node, meta, (and root counted as valid node) */
 	nm_i->available_nids = nm_i->max_nid - sbi->total_valid_node_count -
-				sbi->nquota_files - F2FS_RESERVED_NODE_NUM;
+						F2FS_RESERVED_NODE_NUM;
 	nm_i->nid_cnt[FREE_NID] = 0;
 	nm_i->nid_cnt[PREALLOC_NID] = 0;
 	nm_i->nat_cnt = 0;
-- 
2.18.0.rc1

