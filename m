Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6485C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14822230F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731661AbfKTOQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:16:07 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:45688 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730191AbfKTOQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:16:07 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2BFB02E04DBF7C2534C7;
        Wed, 20 Nov 2019 22:16:03 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 20 Nov 2019
 22:15:55 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <willy@infradead.org>, <viro@zeniv.linux.org.uk>,
        <hughd@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <houtao1@huawei.com>, <yi.zhang@huawei.com>,
        <zhengbin13@huawei.com>
Subject: [PATCH] tmpfs: use ida to get inode number
Date:   Wed, 20 Nov 2019 22:23:18 +0800
Message-ID: <1574259798-144561-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a script to test tmpfs, after 10 days, there will be files share the
same inode number, thus bug happens.
The script is as follows:
while(1) {
  create a file
  dlopen it
  ...
  remove it
}

I have tried to change last_ino type to unsigned long, while this was
rejected, see details on https://patchwork.kernel.org/patch/11023915.

Use ida to get inode number, from the fs_mark test, performance impact
is small.

CPU core: 128  memory: 8G
Use fs_mark to create ten million files first in tmpfs.

Then test performance in the following command(test five times):
rm -rf /tmp/fsmark_test
sync
echo 3 > /proc/sys/vm/drop_caches
sleep 10
fs_mark -t 20 -s 0 -n 102400 -D 64 -N 1600 -L 3 -d /tmp/fsmark_test

result is file creation speed(Files/sec).
get_next_ino  |  use ida
439506.7      |  423219.0
441453.0      |  406832.7
439868.0      |  441283.3
445642.3      |  428221.3
441776.7      |  438129.0
average:
441649.34     |  427537.06

Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 mm/shmem.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 5b93877..6b5e01b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -258,6 +258,7 @@ static const struct inode_operations shmem_dir_inode_operations;
 static const struct inode_operations shmem_special_inode_operations;
 static const struct vm_operations_struct shmem_vm_ops;
 static struct file_system_type shmem_fs_type;
+static DEFINE_IDA(shmem_inode_ida);

 bool vma_is_shmem(struct vm_area_struct *vma)
 {
@@ -1138,6 +1139,7 @@ static void shmem_evict_inode(struct inode *inode)

 	simple_xattrs_free(&info->xattrs);
 	WARN_ON(inode->i_blocks);
+	ida_simple_remove(&shmem_inode_ida, inode->i_ino);
 	shmem_free_inode(inode->i_sb);
 	clear_inode(inode);
 }
@@ -2213,13 +2215,20 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 	struct inode *inode;
 	struct shmem_inode_info *info;
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
+	int i_ino;

 	if (shmem_reserve_inode(sb))
 		return NULL;

+	i_ino = ida_simple_get(&shmem_inode_ida, 0, 0, GFP_KERNEL);
+	if (i_ino < 0) {
+		shmem_free_inode(sb);
+		return NULL;
+	}
+
 	inode = new_inode(sb);
 	if (inode) {
-		inode->i_ino = get_next_ino();
+		inode->i_ino = i_ino;
 		inode_init_owner(inode, dir, mode);
 		inode->i_blocks = 0;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
@@ -2263,8 +2272,11 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 		}

 		lockdep_annotate_inode_mutex_key(inode);
-	} else
+	} else {
+		ida_simple_remove(&shmem_inode_ida, i_ino);
 		shmem_free_inode(sb);
+	}
+
 	return inode;
 }

--
2.7.4

