Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6109EC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 03:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A50207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 03:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfK0Djn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 22:39:43 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:51842 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726454AbfK0Djn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 22:39:43 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9C7981D57FCE35DA8437;
        Wed, 27 Nov 2019 11:39:41 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Wed, 27 Nov 2019
 11:39:30 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <hughd@google.com>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH] mm/shmem.c: don't set 'seals' to 'F_SEAL_SEAL' in shmem_get_inode
Date:   Wed, 27 Nov 2019 12:00:51 +0800
Message-ID: <20191127040051.39169-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'seals' is set to 'F_SEAL_SEAL' in shmem_get_inode, which means "prevent
further seals from being set", thus sealing API will be useless and many
code in shmem.c will never be reached. For example:

shmem_setattr
	if ((newsize < oldsize && (info->seals & F_SEAL_SHRINK)) ||
	    (newsize > oldsize && (info->seals & F_SEAL_GROW)))
		return -EPERM;

So, initialize 'seals' to zero is more reasonable.

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 mm/shmem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 165fa6332993..7b032b347bda 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2256,7 +2256,6 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 		memset(info, 0, (char *)inode - (char *)info);
 		spin_lock_init(&info->lock);
 		atomic_set(&info->stop_eviction, 0);
-		info->seals = F_SEAL_SEAL;
 		info->flags = flags & VM_NORESERVE;
 		INIT_LIST_HEAD(&info->shrinklist);
 		INIT_LIST_HEAD(&info->swaplist);
-- 
2.17.2

