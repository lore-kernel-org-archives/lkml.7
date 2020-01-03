Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E3CC2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 09:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93EDA2053B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 09:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgACJup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 04:50:45 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:58032 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725972AbgACJup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 04:50:45 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D9219473D041D0E29CB6;
        Fri,  3 Jan 2020 17:50:42 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 3 Jan 2020 17:50:36 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: compress: fix NULL pointer dereference
Date:   Fri, 3 Jan 2020 17:50:33 +0800
Message-ID: <20200103095033.8024-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] SMP PTI
 CPU: 11 PID: 70359 Comm: kworker/u256:4 Tainted: G           OE     5.5.0-rc1 #36
 Hardware name: Xen HVM domU, BIOS 4.1.2_115-908.790. 06/05/2017
 Workqueue: writeback wb_workfn (flush-251:0)
 RIP: 0010:f2fs_write_single_data_page+0x4f/0x700 [f2fs]
 Call Trace:
  ? __next_timer_interrupt+0xc0/0xc0
  ? finish_wait+0x32/0x70
  ? congestion_wait+0xa5/0x120
  f2fs_write_multi_pages+0xc7/0x810 [f2fs]
  f2fs_write_cache_pages+0x6c0/0x790 [f2fs]
  ? select_task_rq_fair+0x584/0x800
  ? atomic_notifier_chain_unregister+0x30/0x70
  ? __set_page_dirty_nobuffers+0x101/0x150
  f2fs_write_data_pages+0x2cd/0x320 [f2fs]
  ? f2fs_update_inode+0x9c/0x4f0 [f2fs]
  ? do_writepages+0x1a/0x60
  do_writepages+0x1a/0x60
  __writeback_single_inode+0x3d/0x340
  writeback_sb_inodes+0x225/0x4a0
  wb_writeback+0xf7/0x320
  ? wb_workfn+0xa8/0x450
  ? _raw_spin_unlock_bh+0xa/0x20
  wb_workfn+0xa8/0x450
  ? finish_task_switch+0x75/0x2a0
  process_one_work+0x15e/0x3e0
  worker_thread+0x4c/0x440
  ? rescuer_thread+0x350/0x350
  kthread+0xf8/0x130
  ? kthread_unpark+0x70/0x70
  ret_from_fork+0x35/0x40

In scenario of truncate vs writeback, we need to check page's mapping
before access it during writeback.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index fa67ffd9d79d..9e8fba78db4d 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -932,6 +932,7 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 					enum iostat_type io_type,
 					bool compressed)
 {
+	struct address_space *mapping = cc->inode->i_mapping;
 	int i, _submitted;
 	int ret, err = 0;
 
@@ -939,6 +940,11 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 		if (!cc->rpages[i])
 			continue;
 retry_write:
+		if (cc->rpages[i]->mapping != mapping) {
+			unlock_page(cc->rpages[i]);
+			continue;
+		}
+
 		BUG_ON(!PageLocked(cc->rpages[i]));
 
 		ret = f2fs_write_single_data_page(cc->rpages[i], &_submitted,
-- 
2.18.0.rc1

