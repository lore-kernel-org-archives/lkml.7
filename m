Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFA0C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1BE3208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfDZJ6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:58:13 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:32908 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726279AbfDZJ6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:58:07 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 16619E47877840E95F80;
        Fri, 26 Apr 2019 17:58:02 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 26 Apr 2019 17:58:00 +0800
Received: from szvp000201624.huawei.com (10.120.216.130) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 26 Apr 2019 17:58:01 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        <drosen@google.com>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: fix to avoid potential negative .f_bfree
Date:   Fri, 26 Apr 2019 17:57:53 +0800
Message-ID: <20190426095754.85784-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-ClientProxiedBy: dggeme711-chm.china.huawei.com (10.1.199.107) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calculating .f_bfree value in f2fs_statfs(), sbi->unusable_block_count
can be increased after the judgment condition, result in overflow of
.f_bfree in later calculation. This patch fixes to use a temporary signed
variable to save the calculation result of .f_bfree.

	if (unlikely(buf->f_bfree <= sbi->unusable_block_count))
 		buf->f_bfree = 0;
 	else
		buf->f_bfree -= sbi->unusable_block_count;

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2376bb01b5c4..fcc9793dbc2c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1216,6 +1216,7 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	u64 id = huge_encode_dev(sb->s_bdev->bd_dev);
 	block_t total_count, user_block_count, start_count;
 	u64 avail_node_count;
+	long long bfree;
 
 	total_count = le64_to_cpu(sbi->raw_super->block_count);
 	user_block_count = sbi->user_block_count;
@@ -1226,10 +1227,12 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_blocks = total_count - start_count;
 	buf->f_bfree = user_block_count - valid_user_blocks(sbi) -
 						sbi->current_reserved_blocks;
-	if (unlikely(buf->f_bfree <= sbi->unusable_block_count))
+
+	bfree = buf->f_bfree - sbi->unusable_block_count;
+	if (unlikely(bfree < 0))
 		buf->f_bfree = 0;
 	else
-		buf->f_bfree -= sbi->unusable_block_count;
+		buf->f_bfree = bfree;
 
 	if (buf->f_bfree > F2FS_OPTION(sbi).root_reserved_blocks)
 		buf->f_bavail = buf->f_bfree -
-- 
2.18.0.rc1

