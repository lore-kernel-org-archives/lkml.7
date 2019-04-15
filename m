Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0270FC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BAB206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfDOHbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:31:25 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:45622 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725851AbfDOHbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:31:05 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id AA9E8B7DF60FF1B436AE;
        Mon, 15 Apr 2019 15:31:03 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 15 Apr 2019 15:31:03 +0800
Received: from szvp000201624.huawei.com (10.120.216.130) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 15 Apr 2019 15:31:02 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 11/13] f2fs: fix to avoid panic in f2fs_inplace_write_data()
Date:   Mon, 15 Apr 2019 15:30:52 +0800
Message-ID: <20190415073054.2577-3-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20190415073054.2577-1-yuchao0@huawei.com>
References: <20190415073054.2577-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-ClientProxiedBy: dggeme710-chm.china.huawei.com (10.1.199.106) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Jungyeon reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=203239

- Overview
When mounting the attached crafted image and running program, following errors are reported.
Additionally, it hangs on sync after running program.

The image is intentionally fuzzed from a normal f2fs image for testing.
Compile options for F2FS are as follows.
CONFIG_F2FS_FS=y
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_CHECK_FS=y

- Reproduces
cc poc_15.c
./run.sh f2fs
sync

- Kernel messages
 ------------[ cut here ]------------
 kernel BUG at fs/f2fs/segment.c:3162!
 RIP: 0010:f2fs_inplace_write_data+0x12d/0x160
 Call Trace:
  f2fs_do_write_data_page+0x3c1/0x820
  __write_data_page+0x156/0x720
  f2fs_write_cache_pages+0x20d/0x460
  f2fs_write_data_pages+0x1b4/0x300
  do_writepages+0x15/0x60
  __filemap_fdatawrite_range+0x7c/0xb0
  file_write_and_wait_range+0x2c/0x80
  f2fs_do_sync_file+0x102/0x810
  do_fsync+0x33/0x60
  __x64_sys_fsync+0xb/0x10
  do_syscall_64+0x43/0xf0
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

The reason is f2fs_inplace_write_data() will trigger kernel panic due
to data block locates in node type segment.

To avoid panic, let's just return error code and set SBI_NEED_FSCK to
give a hint to fsck for latter repairing.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b59d1c85863b..8388d2abacb5 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3184,13 +3184,18 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 {
 	int err;
 	struct f2fs_sb_info *sbi = fio->sbi;
+	unsigned int segno;
 
 	fio->new_blkaddr = fio->old_blkaddr;
 	/* i/o temperature is needed for passing down write hints */
 	__get_segment_type(fio);
 
-	f2fs_bug_on(sbi, !IS_DATASEG(get_seg_entry(sbi,
-			GET_SEGNO(sbi, fio->new_blkaddr))->type));
+	segno = GET_SEGNO(sbi, fio->new_blkaddr);
+
+	if (!IS_DATASEG(get_seg_entry(sbi, segno)->type)) {
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		return -EFAULT;
+	}
 
 	stat_inc_inplace_blocks(fio->sbi);
 
-- 
2.18.0.rc1

