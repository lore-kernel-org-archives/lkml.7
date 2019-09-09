Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C047AC4360D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 01:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990D0218AC
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 01:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567992342;
	bh=c5iYQQVsV3m8rZv2AFPoJVLzj+j/X5goBLwITQhY718=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kf4uvDHM4h2MwYqlDDXcaQgRXpQT9+4L6cImv5wRiPDvrZqov2rr1XaDNC7B2bZuK
	 UyQhBjSRaSenF1seAiO2JT7zHFzX+7EjAze/LlrWYM8iijIddYPyD6Z2nmL00Andtt
	 hd5Fvd2nGKSzzi1Spyf3WpdNBanhjFk4Ipgh2nUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbfIIBZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 21:25:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731552AbfIIBZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 21:25:39 -0400
Received: from localhost (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCB5C216C8;
        Mon,  9 Sep 2019 01:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567992339;
        bh=c5iYQQVsV3m8rZv2AFPoJVLzj+j/X5goBLwITQhY718=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zcBrCtlof5t+yUkGL7CbY5BUnlu6NlVsEr+4tM4lhdyApaccv3hBYGyfrTtKPNXy+
         J21mXiHumY44/sSGKnLEQ3MIy2tXZ6G9TKOwELvnaVuoe5GG6/DKKfdrE2+HVa5XO2
         h4RcmlTjOFQK1+22GS2WSlJmOTPtK73rJWSWSltA=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: avoid infinite GC loop due to stale atomic files
Date:   Mon,  9 Sep 2019 02:25:32 +0100
Message-Id: <20190909012532.20454-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20190909012532.20454-1-jaegeuk@kernel.org>
References: <20190909012532.20454-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If committing atomic pages is failed when doing f2fs_do_sync_file(), we can
get commited pages but atomic_file being still set like:

- inmem:    0, atomic IO:    4 (Max.   10), volatile IO:    0 (Max.    0)

If GC selects this block, we can get an infinite loop like this:

f2fs_submit_page_bio: dev = (253,7), ino = 2, page_index = 0x2359a8, oldaddr = 0x2359a8, newaddr = 0x2359a8, rw = READ(), type = COLD_DATA
f2fs_submit_read_bio: dev = (253,7)/(253,7), rw = READ(), DATA, sector = 18533696, size = 4096
f2fs_get_victim: dev = (253,7), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 4355, cost = 1, ofs_unit = 1, pre_victim_secno = 4355, prefree = 0, free = 234
f2fs_iget: dev = (253,7), ino = 6247, pino = 5845, i_mode = 0x81b0, i_size = 319488, i_nlink = 1, i_blocks = 624, i_advise = 0x2c
f2fs_submit_page_bio: dev = (253,7), ino = 2, page_index = 0x2359a8, oldaddr = 0x2359a8, newaddr = 0x2359a8, rw = READ(), type = COLD_DATA
f2fs_submit_read_bio: dev = (253,7)/(253,7), rw = READ(), DATA, sector = 18533696, size = 4096
f2fs_get_victim: dev = (253,7), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 4355, cost = 1, ofs_unit = 1, pre_victim_secno = 4355, prefree = 0, free = 234
f2fs_iget: dev = (253,7), ino = 6247, pino = 5845, i_mode = 0x81b0, i_size = 319488, i_nlink = 1, i_blocks = 624, i_advise = 0x2c

In that moment, we can observe:

[Before]
Try to move 5084219 blocks (BG: 384508)
  - data blocks : 4962373 (274483)
  - node blocks : 121846 (110025)
Skipped : atomic write 4534686 (10)

[After]
Try to move 5088973 blocks (BG: 384508)
  - data blocks : 4967127 (274483)
  - node blocks : 121846 (110025)
Skipped : atomic write 4539440 (10)

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7ae2f3bd8c2f..68b6da734e5f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1997,11 +1997,11 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 			goto err_out;
 
 		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
-		if (!ret) {
-			clear_inode_flag(inode, FI_ATOMIC_FILE);
-			F2FS_I(inode)->i_gc_failures[GC_FAILURE_ATOMIC] = 0;
-			stat_dec_atomic_write(inode);
-		}
+
+		/* doesn't need to check error */
+		clear_inode_flag(inode, FI_ATOMIC_FILE);
+		F2FS_I(inode)->i_gc_failures[GC_FAILURE_ATOMIC] = 0;
+		stat_dec_atomic_write(inode);
 	} else {
 		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 1, false);
 	}
-- 
2.19.0.605.g01d371f741-goog

