Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D329DC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B03206E0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560441852;
	bh=T2azg12apvWS++HL4vLtMOF4yjNH/5aptvXET4B6RXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a/sSCNP6C5GcEEJRVwRJAo79m0ou8WwXk9xHFtPDuMJUs5I+QvA/TKMBtZLr0ZJeC
	 x5u7aJB0aOPih0qG5hgCFYULpywrhmceRSi6L1/4FJZagwv+jtlabzuSJUSydZwhWX
	 SiR5ZuZwyHHH+6ycsHvpGv+MxUspLYKlkFmmwxR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390742AbfFMQEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:04:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731360AbfFMIrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:47:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AC3F2173C;
        Thu, 13 Jun 2019 08:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415624;
        bh=T2azg12apvWS++HL4vLtMOF4yjNH/5aptvXET4B6RXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ppuRKiTkiNNHSPLxE1wPtEc+xfNYKFpQOTOMeUd+4BdF0jJhhhKGANAC1S+je+UwP
         C8p+GUYZald2/1RrcCveSHjmWAgymlG5s+8L9ky9CLBgMQdgTLCsLNq1xTcwC691HE
         hJIlFTofE/rha7RT7lOHpWVP4EFYBNg6D2MccvVE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 043/155] f2fs: fix to avoid panic in f2fs_inplace_write_data()
Date:   Thu, 13 Jun 2019 10:32:35 +0200
Message-Id: <20190613075655.517378170@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075652.691765927@linuxfoundation.org>
References: <20190613075652.691765927@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 05573d6ccf702df549a7bdeabef31e4753df1a90 ]

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
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/segment.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index ddfa2eb7ec58..3d6efbfe180f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3188,13 +3188,18 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
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
2.20.1



