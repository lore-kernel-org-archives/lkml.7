Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB47DCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 08:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F9920663
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 08:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbfJ2Ix6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 04:53:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41284 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729834AbfJ2Ix6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 04:53:58 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D8AEA5E32F7D3CF7C640;
        Tue, 29 Oct 2019 16:53:55 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 29 Oct 2019
 16:53:48 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <s.hauer@pengutronix.de>, <dedekind1@gmail.com>,
        <yi.zhang@huawei.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ubifs: do_kill_orphans: Fix a memory leak bug
Date:   Tue, 29 Oct 2019 17:01:10 +0800
Message-ID: <1572339670-68694-1-git-send-email-chengzhihao1@huawei.com>
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
 fs/ubifs/orphan.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/ubifs/orphan.c b/fs/ubifs/orphan.c
index 3b4b411..f211ed3 100644
--- a/fs/ubifs/orphan.c
+++ b/fs/ubifs/orphan.c
@@ -673,9 +673,11 @@ static int do_kill_orphans(struct ubifs_info *c, struct ubifs_scan_leb *sleb,
 		if (first)
 			first = 0;
 
-		ino = kmalloc(UBIFS_MAX_INO_NODE_SZ, GFP_NOFS);
-		if (!ino)
-			return -ENOMEM;
+		if (!ino) {
+			ino = kmalloc(UBIFS_MAX_INO_NODE_SZ, GFP_NOFS);
+			if (!ino)
+				return -ENOMEM;
+		}
 
 		n = (le32_to_cpu(orph->ch.len) - UBIFS_ORPH_NODE_SZ) >> 3;
 		for (i = 0; i < n; i++) {
-- 
2.7.4

