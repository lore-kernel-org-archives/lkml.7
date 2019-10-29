Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FFDCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86493208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388079AbfJ2MwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:52:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34256 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729253AbfJ2MwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:52:09 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 15E5B4C1CDE853A6DEBF;
        Tue, 29 Oct 2019 20:52:07 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Tue, 29 Oct 2019
 20:52:00 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <s.hauer@pengutronix.de>, <dedekind1@gmail.com>,
        <yi.zhang@huawei.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] ubifs: do_kill_orphans: Fix a memory leak bug
Date:   Tue, 29 Oct 2019 20:58:23 +0800
Message-ID: <1572353903-104711-1-git-send-email-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there are more than one valid snod on the sleb->nodes list,
do_kill_orphans will malloc ino more than once without releasing
previous ino's memory. Finally, it will trigger memory leak.

Fixes: ee1438ce5dc4 ("ubifs: Check link count of inodes when...")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/ubifs/orphan.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/ubifs/orphan.c b/fs/ubifs/orphan.c
index 3b4b411..54d6db6 100644
--- a/fs/ubifs/orphan.c
+++ b/fs/ubifs/orphan.c
@@ -631,12 +631,17 @@ static int do_kill_orphans(struct ubifs_info *c, struct ubifs_scan_leb *sleb,
 	ino_t inum;
 	int i, n, err, first = 1;
 
+	ino = kmalloc(UBIFS_MAX_INO_NODE_SZ, GFP_NOFS);
+	if (!ino)
+		return -ENOMEM;
+
 	list_for_each_entry(snod, &sleb->nodes, list) {
 		if (snod->type != UBIFS_ORPH_NODE) {
 			ubifs_err(c, "invalid node type %d in orphan area at %d:%d",
 				  snod->type, sleb->lnum, snod->offs);
 			ubifs_dump_node(c, snod->node);
-			return -EINVAL;
+			err = -EINVAL;
+			goto out_free;
 		}
 
 		orph = snod->node;
@@ -663,20 +668,18 @@ static int do_kill_orphans(struct ubifs_info *c, struct ubifs_scan_leb *sleb,
 				ubifs_err(c, "out of order commit number %llu in orphan node at %d:%d",
 					  cmt_no, sleb->lnum, snod->offs);
 				ubifs_dump_node(c, snod->node);
-				return -EINVAL;
+				err = -EINVAL;
+				goto out_free;
 			}
 			dbg_rcvry("out of date LEB %d", sleb->lnum);
 			*outofdate = 1;
-			return 0;
+			err = 0;
+			goto out_free;
 		}
 
 		if (first)
 			first = 0;
 
-		ino = kmalloc(UBIFS_MAX_INO_NODE_SZ, GFP_NOFS);
-		if (!ino)
-			return -ENOMEM;
-
 		n = (le32_to_cpu(orph->ch.len) - UBIFS_ORPH_NODE_SZ) >> 3;
 		for (i = 0; i < n; i++) {
 			union ubifs_key key1, key2;
-- 
2.7.4

