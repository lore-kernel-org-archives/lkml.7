Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896A7C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6571721906
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbfIRINa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 04:13:30 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59074 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbfIRINa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 04:13:30 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 67232FF8DCCAFA0289D1;
        Wed, 18 Sep 2019 16:13:28 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Wed, 18 Sep 2019 16:13:20 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] erofs: fix return value check in erofs_read_superblock()
Date:   Wed, 18 Sep 2019 08:30:33 +0000
Message-ID: <20190918083033.47780-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of error, the function read_mapping_page() returns
ERR_PTR() not NULL. The NULL test in the return value check
should be replaced with IS_ERR().

Fixes: fe7c2423570d ("erofs: use read_mapping_page instead of sb_bread")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 fs/erofs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index caf9a95173b0..0e369494f2f2 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -105,9 +105,9 @@ static int erofs_read_superblock(struct super_block *sb)
 	int ret;
 
 	page = read_mapping_page(sb->s_bdev->bd_inode->i_mapping, 0, NULL);
-	if (!page) {
+	if (IS_ERR(page)) {
 		erofs_err(sb, "cannot read erofs superblock");
-		return -EIO;
+		return PTR_ERR(page);
 	}
 
 	sbi = EROFS_SB(sb);



