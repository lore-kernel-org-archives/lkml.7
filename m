Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBD5CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F8921734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbfKAJyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 05:54:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5247 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726771AbfKAJyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 05:54:02 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 60DFD2FAC0E85D290225;
        Fri,  1 Nov 2019 17:53:59 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Fri, 1 Nov 2019 17:53:48 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/3] f2fs: clean up check condition for writting beyond EOF
Date:   Fri, 1 Nov 2019 17:53:22 +0800
Message-ID: <20191101095324.9902-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up with below codes suggested by Eric:

__write_data_page()

	unsigned nr_pages = DIV_ROUND_UP(i_size, PAGE_SIZE);

	/*
	 * If the offset is out-of-range of file size,
	 * this page does not have to be written to disk.
	 */
	if (page->index >= nr_pages)
		goto out;

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ba3bcf4c7889..ca7161e38d1f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2204,6 +2204,7 @@ static int __write_data_page(struct page *page, bool *submitted,
 	const pgoff_t end_index = ((unsigned long long) i_size)
 							>> PAGE_SHIFT;
 	loff_t psize = (page->index + 1) << PAGE_SHIFT;
+	unsigned nr_pages = DIV_ROUND_UP(i_size, PAGE_SIZE);
 	unsigned offset = 0;
 	bool need_balance_fs = false;
 	int err = 0;
@@ -2248,8 +2249,7 @@ static int __write_data_page(struct page *page, bool *submitted,
 	 * If the offset is out-of-range of file size,
 	 * this page does not have to be written to disk.
 	 */
-	offset = i_size & (PAGE_SIZE - 1);
-	if ((page->index >= end_index + 1) || !offset)
+	if (page->index >= nr_pages)
 		goto out;
 
 	zero_user_segment(page, offset, PAGE_SIZE);
-- 
2.18.0.rc1

