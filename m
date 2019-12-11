Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4613DC2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF26208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576079099;
	bh=Ij6qeap0hI6cFj/+9nasKGNk7xnnnew3c0gdzp7vhk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GLK+Ewl7NEENIK4eGvDTz6UeIB1V6vlM6RhpPS3L3eqzh/B6iNTsXE6GUzRSEfOZ+
	 S+6roRdX3D2oNoV2+04MJW/kCcCdq0QNE59GQ0dG7/TKxJHXHoBChkO7+pohHoefKu
	 CQe/9hEmcCv96A15IEp1U6k0eFn2FbSafV195U2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733302AbfLKP1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:27:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:60874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733249AbfLKP1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:27:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0E082173E;
        Wed, 11 Dec 2019 15:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576078028;
        bh=Ij6qeap0hI6cFj/+9nasKGNk7xnnnew3c0gdzp7vhk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pv/16BXy/j7OhieDdsEVXRERHQyYdG/k+KPPodQnTnpnJDV3HgEC4W18ISxAQyErF
         Y+PNOV+mdSEcgBQEyYWYrk5r7ajYupV1z/baPuDewxNXOV3XS8/+U/bNscQQpzAkHw
         hSZE9CkGXI+i5h4ejbyXC+VLq1rlP8T+ESk02bxc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Jan Kara <jack@suse.cz>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
        linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 23/79] ext4: update direct I/O read lock pattern for IOCB_NOWAIT
Date:   Wed, 11 Dec 2019 10:25:47 -0500
Message-Id: <20191211152643.23056-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211152643.23056-1-sashal@kernel.org>
References: <20191211152643.23056-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Bobrowski <mbobrowski@mbobrowski.org>

[ Upstream commit 548feebec7e93e58b647dba70b3303dcb569c914 ]

This patch updates the lock pattern in ext4_direct_IO_read() to not
block on inode lock in cases of IOCB_NOWAIT direct I/O reads. The
locking condition implemented here is similar to that of 942491c9e6d6
("xfs: fix AIM7 regression").

Fixes: 16c54688592c ("ext4: Allow parallel DIO reads")
Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
Link: https://lore.kernel.org/r/c5d5e759f91747359fbd2c6f9a36240cf75ad79f.1572949325.git.mbobrowski@mbobrowski.org
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/inode.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index f8a0af11a31e8..00d25a0643913 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3839,7 +3839,13 @@ static ssize_t ext4_direct_IO_read(struct kiocb *iocb, struct iov_iter *iter)
 	 * writes & truncates and since we take care of writing back page cache,
 	 * we are protected against page writeback as well.
 	 */
-	inode_lock_shared(inode);
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!inode_trylock_shared(inode))
+			return -EAGAIN;
+	} else {
+		inode_lock_shared(inode);
+	}
+
 	ret = filemap_write_and_wait_range(mapping, iocb->ki_pos,
 					   iocb->ki_pos + count - 1);
 	if (ret)
-- 
2.20.1

