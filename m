Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0265CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B7C21852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571436869;
	bh=xYkyonlbbCi3GuGegpMQfZcWMAhNVgBaZPtUflwvvUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jypq0tdwKlracYB4Z6LHhLWMHlpbcsO3EUNdbO++ydlbQp3aEKoLAU/u/KhoqLvOO
	 BUCpn/LiUjjEcgUgSbqM0B0b2ioEnllXgkIscmiYZ7h8sZmV6hykxtimHNQCMJq9mu
	 nwo5USSwcnPYJUvWxN2XrQiOSrSOdcrLF4VfZpOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388908AbfJRWJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:09:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388421AbfJRWJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:09:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC2F52246A;
        Fri, 18 Oct 2019 22:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436539;
        bh=xYkyonlbbCi3GuGegpMQfZcWMAhNVgBaZPtUflwvvUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rKeWGVCxZQDiSMp9PjBd+ewAEmEtKmiJz6l5PceF7+ECoGCU8cdVCHdgbxp9C7WDh
         kz7B7gzF6DNMcIZDkg0iADWP8XFSPm45VUSXqZPSfdZsYUV0zU6jZOsiYvQ0icl5FN
         Si5H8RUgq3tdL+jr9Zw7CTPKs5a7fLDu0vUibUEY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jia Guo <guojia12@huawei.com>, Yiwen Jiang <jiangyiwen@huawei.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Joseph Qi <joseph.qi@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 42/56] ocfs2: clear zero in unaligned direct IO
Date:   Fri, 18 Oct 2019 18:07:39 -0400
Message-Id: <20191018220753.10002-42-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220753.10002-1-sashal@kernel.org>
References: <20191018220753.10002-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia Guo <guojia12@huawei.com>

[ Upstream commit 7a243c82ea527cd1da47381ad9cd646844f3b693 ]

Unused portion of a part-written fs-block-sized block is not set to zero
in unaligned append direct write.This can lead to serious data
inconsistencies.

Ocfs2 manage disk with cluster size(for example, 1M), part-written in
one cluster will change the cluster state from UN-WRITTEN to WRITTEN,
VFS(function dio_zero_block) doesn't do the cleaning because bh's state
is not set to NEW in function ocfs2_dio_wr_get_block when we write a
WRITTEN cluster.  For example, the cluster size is 1M, file size is 8k
and we direct write from 14k to 15k, then 12k~14k and 15k~16k will
contain dirty data.

We have to deal with two cases:
 1.The starting position of direct write is outside the file.
 2.The starting position of direct write is located in the file.

We need set bh's state to NEW in the first case.  In the second case, we
need mapped twice because bh's state of area out file should be set to
NEW while area in file not.

[akpm@linux-foundation.org: coding style fixes]
Link: http://lkml.kernel.org/r/5292e287-8f1a-fd4a-1a14-661e555e0bed@huawei.com
Signed-off-by: Jia Guo <guojia12@huawei.com>
Reviewed-by: Yiwen Jiang <jiangyiwen@huawei.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Joseph Qi <joseph.qi@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/aops.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 99550f4bd159a..ebeec7530cb60 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -2151,13 +2151,30 @@ static int ocfs2_dio_wr_get_block(struct inode *inode, sector_t iblock,
 	struct ocfs2_dio_write_ctxt *dwc = NULL;
 	struct buffer_head *di_bh = NULL;
 	u64 p_blkno;
-	loff_t pos = iblock << inode->i_sb->s_blocksize_bits;
+	unsigned int i_blkbits = inode->i_sb->s_blocksize_bits;
+	loff_t pos = iblock << i_blkbits;
+	sector_t endblk = (i_size_read(inode) - 1) >> i_blkbits;
 	unsigned len, total_len = bh_result->b_size;
 	int ret = 0, first_get_block = 0;
 
 	len = osb->s_clustersize - (pos & (osb->s_clustersize - 1));
 	len = min(total_len, len);
 
+	/*
+	 * bh_result->b_size is count in get_more_blocks according to write
+	 * "pos" and "end", we need map twice to return different buffer state:
+	 * 1. area in file size, not set NEW;
+	 * 2. area out file size, set  NEW.
+	 *
+	 *		   iblock    endblk
+	 * |--------|---------|---------|---------
+	 * |<-------area in file------->|
+	 */
+
+	if ((iblock <= endblk) &&
+	    ((iblock + ((len - 1) >> i_blkbits)) > endblk))
+		len = (endblk - iblock + 1) << i_blkbits;
+
 	mlog(0, "get block of %lu at %llu:%u req %u\n",
 			inode->i_ino, pos, len, total_len);
 
@@ -2241,6 +2258,9 @@ static int ocfs2_dio_wr_get_block(struct inode *inode, sector_t iblock,
 	if (desc->c_needs_zero)
 		set_buffer_new(bh_result);
 
+	if (iblock > endblk)
+		set_buffer_new(bh_result);
+
 	/* May sleep in end_io. It should not happen in a irq context. So defer
 	 * it to dio work queue. */
 	set_buffer_defer_completion(bh_result);
-- 
2.20.1

