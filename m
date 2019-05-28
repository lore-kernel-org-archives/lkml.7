Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA251C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD9A208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfE1JYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:24:03 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6930 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726279AbfE1JYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:24:02 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 4E579AB9A14B33D88FD5;
        Tue, 28 May 2019 17:24:00 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 28 May 2019 17:23:59 +0800
Received: from szvp000201624.huawei.com (10.120.216.130) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 28 May 2019 17:23:59 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix sparse warning
Date:   Tue, 28 May 2019 17:23:33 +0800
Message-ID: <20190528092333.42663-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-ClientProxiedBy: dggeme712-chm.china.huawei.com (10.1.199.108) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make C=2 CHECKFLAGS="-D__CHECK_ENDIAN__"

CHECK   dir.c
dir.c:842:50: warning: cast from restricted __le32
CHECK   node.c
node.c:2759:40: warning: restricted __le32 degrades to integer

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/dir.c  | 4 ++--
 fs/f2fs/node.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 59bc46017855..64cb61c42b95 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -828,8 +828,8 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 			int save_len = fstr->len;
 
 			err = fscrypt_fname_disk_to_usr(d->inode,
-						(u32)de->hash_code, 0,
-						&de_name, fstr);
+						(u32)le32_to_cpu(de->hash_code),
+						0, &de_name, fstr);
 			if (err)
 				goto out;
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 18a038a2a9fa..865f1525df32 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2725,7 +2725,7 @@ static void __update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
 		i = 1;
 	}
 	for (; i < NAT_ENTRY_PER_BLOCK; i++) {
-		if (nat_blk->entries[i].block_addr != NULL_ADDR)
+		if (le32_to_cpu(nat_blk->entries[i].block_addr) != NULL_ADDR)
 			valid++;
 	}
 	if (valid == 0) {
-- 
2.18.0.rc1

