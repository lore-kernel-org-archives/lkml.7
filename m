Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D69C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D512320661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbfCFISy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 03:18:54 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:60776 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728951AbfCFISy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 03:18:54 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4AA281918403D2E65BFC;
        Wed,  6 Mar 2019 16:18:52 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Wed, 6 Mar 2019 16:18:41 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: remove wrong comment in f2fs_invalidate_page()
Date:   Wed, 6 Mar 2019 16:18:33 +0800
Message-ID: <20190306081833.74065-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 8c242db9b8c0 ("f2fs: fix stale ATOMIC_WRITTEN_PAGE private pointer"),
we've started to not skip clear private flag for atomic_write page
truncation, so removing old wrong comment in f2fs_invalidate_page().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 14ee7dd0c6bc..c36d7aa682d1 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2711,7 +2711,6 @@ void f2fs_invalidate_page(struct page *page, unsigned int offset,
 
 	clear_cold_data(page);
 
-	/* This is atomic written page, keep Private */
 	if (IS_ATOMIC_WRITTEN_PAGE(page))
 		return f2fs_drop_inmem_page(inode, page);
 
-- 
2.18.0.rc1

