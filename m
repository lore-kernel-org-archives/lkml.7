Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80706C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1B3227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576698808;
	bh=oS+AG2W5xIw5h2v3qbAX39cjDnuHu/f0/3ob1+ENrWI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=A7gfQDLsXpW1m71owFGHRStj+IlOV/xB2B19LvEBat2WaxzdKGx/qUXkIbkpo9ZLV
	 RmG/v+vQzsLwmiPBFjxpK0qi1gOuhn+GK63BJkfM1ttkv7JO01FdzJfT0sH+WBsaJi
	 VuwPU4qsxCP2FGfvKyURuaQ615RASWepBxRTAYHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfLRTx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:53:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:43380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbfLRTx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 14:53:27 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6780D2082E;
        Wed, 18 Dec 2019 19:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576698806;
        bh=oS+AG2W5xIw5h2v3qbAX39cjDnuHu/f0/3ob1+ENrWI=;
        h=From:To:Cc:Subject:Date:From;
        b=MubHMAQ9WWOqoArz7Fi8Yibz7XyLUuFeg1Dql3rgMkyEFN8Qt6AGUjdBFxwZIm+db
         lEYrt8R3IboTPPHE5IEjdky2VpeFrbtZz/4qU9UmZU1G7KrVMvGj/4CN9/aXvuFAxp
         TfT/KdHFyy37YI23DyaPN+DuHuC7yGDhJdmDHAg0=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: cover f2fs_lock_op in expand_inode_data case
Date:   Wed, 18 Dec 2019 11:53:24 -0800
Message-Id: <20191218195324.17360-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We were missing to cover f2fs_lock_op in this case.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4ea9bf9e8701..0b74f94ac8ee 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1646,12 +1646,13 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 			if (err && err != -ENODATA && err != -EAGAIN)
 				goto out_err;
 		}
-
+		f2fs_lock_op(sbi);
 		down_write(&sbi->pin_sem);
 		map.m_seg_type = CURSEG_COLD_DATA_PINNED;
 		f2fs_allocate_new_segments(sbi, CURSEG_COLD_DATA);
 		err = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_DIO);
 		up_write(&sbi->pin_sem);
+		f2fs_unlock_op(sbi);
 
 		done += map.m_len;
 		len -= map.m_len;
@@ -1661,7 +1662,9 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 
 		map.m_len = done;
 	} else {
+		f2fs_lock_op(sbi);
 		err = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_AIO);
+		f2fs_unlock_op(sbi);
 	}
 out_err:
 	if (err) {
-- 
2.24.0.525.g8f36a354ae-goog

