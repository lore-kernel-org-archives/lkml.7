Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419C8C48BD9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165B72146E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561655108;
	bh=VtbDzrEliM8ZNaN7HaceyqdJC4IAY9HnrzQS56Uhm2A=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=x5x/R5t2Y3SVoC83oTpq6t9cglaVO8mAWfDPtVLeY/Qb2BZyaNsfwikB5SIiVukqj
	 WdgqlW0V+BSQunQRcrz7BVo8WVOA0Ws603uX5AMHG40ymCElYkN+BZsk8C6pGZiUtQ
	 /ToGBTEjgEymQYx9No/krpSB0Xy/sxQ8qfluHQTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfF0RFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbfF0RFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:05:06 -0400
Received: from localhost (unknown [104.132.1.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C257F20659;
        Thu, 27 Jun 2019 17:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561655105;
        bh=VtbDzrEliM8ZNaN7HaceyqdJC4IAY9HnrzQS56Uhm2A=;
        h=From:To:Cc:Subject:Date:From;
        b=zC1Ze2DpXm5s0+vhbpsM3KmvnE494N6tYjhLyy/LLyEY5Ssc3jod5fPxmSZKRGHSW
         63FMhpChlaD9x2wXpVODyZtPmbl8W+zmJfCT1+syTJ97E1LcNgiu4olbdPv/zfpsPi
         cSSyiXQkFSU14EbrEYw/WzxyZHHR4OeEYtlpVNkU=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: allocate blocks for pinned file
Date:   Thu, 27 Jun 2019 10:05:04 -0700
Message-Id: <20190627170504.71700-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows fallocate to allocate physical blocks for pinned file.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e7c368db8185..cdfd4338682d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1528,7 +1528,12 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 	if (off_end)
 		map.m_len++;
 
-	err = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_AIO);
+	if (f2fs_is_pinned_file(inode))
+		map.m_seg_type = CURSEG_COLD_DATA;
+
+	err = f2fs_map_blocks(inode, &map, 1, (f2fs_is_pinned_file(inode) ?
+						F2FS_GET_BLOCK_PRE_DIO :
+						F2FS_GET_BLOCK_PRE_AIO));
 	if (err) {
 		pgoff_t last_off;
 
-- 
2.19.0.605.g01d371f741-goog

