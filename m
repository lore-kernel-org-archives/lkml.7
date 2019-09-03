Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307E9C3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB7D2173E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfICGmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 02:42:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34000 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725919AbfICGmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 02:42:46 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CFC12872195C1A84D3AA;
        Tue,  3 Sep 2019 14:42:44 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Tue, 3 Sep 2019 14:42:39 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <me@bobcopeland.com>
CC:     <zhongjiang@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-karma-devel@lists.sourceforge.net>
Subject: [PATCH] fs: omfs: Use kmemdup rather than duplicating its implementation in omfs_get_imap
Date:   Tue, 3 Sep 2019 14:39:44 +0800
Message-ID: <1567492784-19304-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup contains the kmalloc + memcpy. hence it is better to use kmemdup
directly. Just replace it.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 fs/omfs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
index b76ec6b..8867cef 100644
--- a/fs/omfs/inode.c
+++ b/fs/omfs/inode.c
@@ -363,12 +363,11 @@ static int omfs_get_imap(struct super_block *sb)
 		bh = sb_bread(sb, block++);
 		if (!bh)
 			goto nomem_free;
-		*ptr = kmalloc(sb->s_blocksize, GFP_KERNEL);
+		*ptr = kmemdup(bh->b_data, sb->s_blocksize, GFP_KERNEL);
 		if (!*ptr) {
 			brelse(bh);
 			goto nomem_free;
 		}
-		memcpy(*ptr, bh->b_data, sb->s_blocksize);
 		if (count < sb->s_blocksize)
 			memset((void *)*ptr + count, 0xff,
 				sb->s_blocksize - count);
-- 
1.7.12.4

