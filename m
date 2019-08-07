Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADB1C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8348E229F3
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="efSOo94g";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N8UzHViw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbfHGIw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:52:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34568 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfHGIwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:52:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EB88B6058E; Wed,  7 Aug 2019 08:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565167944;
        bh=JaEajRU+IxjI/7TzRSEFLT1wAK8wQcmKonkieOXdyf0=;
        h=From:To:Cc:Subject:Date:From;
        b=efSOo94gALen372yW6OEvDuQpkfvM1gtCWwm6W8Wh4yYo5YtRjnrY+oSBZDQUckHq
         PYZazUZqqu3rIWrAGtMgdgBDdyZgvYS5c8TWHOEvRwhPhPKcXf3hrewkwpE4Pd8nBl
         3hxg/yVYsAVB1w8ZkP6/daZl4Foo/H6xQ3GxWRMs=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4EEDB6058E;
        Wed,  7 Aug 2019 08:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565167940;
        bh=JaEajRU+IxjI/7TzRSEFLT1wAK8wQcmKonkieOXdyf0=;
        h=From:To:Cc:Subject:Date:From;
        b=N8UzHViwD8VdUBwbH3A5B0CsirmWA1kNMdAVodKtfkYs2xd9v/23M7gnULVsk8OVH
         wKG6F0il+kZmnfudRCe9e3AUXu3hHvWKp/6oBA1IgzE2wA8fnBmQzeVuSU0TTE/Ebo
         hMS/JMlDDaigNjHbhWZzkBhSRiAFQJCi0qAHwg5s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4EEDB6058E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] f2fs: Fix indefinite loop in f2fs_gc()
Date:   Wed,  7 Aug 2019 14:22:07 +0530
Message-Id: <1565167927-23305-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Policy - Foreground GC, LFS and greedy GC mode.

Under this policy, f2fs_gc() loops forever to GC as it doesn't have
enough free segements to proceed and thus it keeps calling gc_more
for the same victim segment.  This can happen if the selected victim
segment could not be GC'd due to failed blkaddr validity check i.e.
is_alive() returns false for the blocks set in current validity map.

Fix this by keeping track of such invalid segments and skip those
segments for selection in get_victim_by_default() to avoid endless
GC loop under such error scenarios.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
v3: address Chao's comments and also add logic to clear invalid_segmap

 fs/f2fs/gc.c      | 25 +++++++++++++++++++++++--
 fs/f2fs/segment.c | 10 +++++++++-
 fs/f2fs/segment.h |  3 +++
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 8974672..f7b9602 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -382,6 +382,14 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 			nsearched++;
 		}
 
+		/*
+		 * skip selecting the invalid segno (that is failed due to block
+		 * validity check failure during GC) to avoid endless GC loop in
+		 * such cases.
+		 */
+		if (test_bit(segno, sm->invalid_segmap))
+			goto next;
+
 		secno = GET_SEC_FROM_SEG(sbi, segno);
 
 		if (sec_usage_check(sbi, secno))
@@ -602,8 +610,13 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 {
 	struct page *node_page;
 	nid_t nid;
-	unsigned int ofs_in_node;
+	unsigned int ofs_in_node, segno;
 	block_t source_blkaddr;
+	unsigned long offset;
+	struct sit_info *sit_i = SIT_I(sbi);
+
+	segno = GET_SEGNO(sbi, blkaddr);
+	offset = GET_BLKOFF_FROM_SEG0(sbi, blkaddr);
 
 	nid = le32_to_cpu(sum->nid);
 	ofs_in_node = le16_to_cpu(sum->ofs_in_node);
@@ -627,8 +640,16 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	source_blkaddr = datablock_addr(NULL, node_page, ofs_in_node);
 	f2fs_put_page(node_page, 1);
 
-	if (source_blkaddr != blkaddr)
+	if (source_blkaddr != blkaddr) {
+		if (unlikely(check_valid_map(sbi, segno, offset))) {
+			if (!test_and_set_bit(segno, sit_i->invalid_segmap)) {
+				f2fs_err(sbi, "mismatched blkaddr %u (source_blkaddr %u) in seg %u\n",
+						blkaddr, source_blkaddr, segno);
+				f2fs_bug_on(sbi, 1);
+			}
+		}
 		return false;
+	}
 	return true;
 }
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a661ac3..c3ba9e7 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -806,6 +806,7 @@ static void __remove_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
 		enum dirty_type dirty_type)
 {
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
+	struct sit_info *sit_i = SIT_I(sbi);
 
 	if (test_and_clear_bit(segno, dirty_i->dirty_segmap[dirty_type]))
 		dirty_i->nr_dirty[dirty_type]--;
@@ -817,9 +818,11 @@ static void __remove_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
 		if (test_and_clear_bit(segno, dirty_i->dirty_segmap[t]))
 			dirty_i->nr_dirty[t]--;
 
-		if (get_valid_blocks(sbi, segno, true) == 0)
+		if (get_valid_blocks(sbi, segno, true) == 0) {
 			clear_bit(GET_SEC_FROM_SEG(sbi, segno),
 						dirty_i->victim_secmap);
+			clear_bit(segno, sit_i->invalid_segmap);
+		}
 	}
 }
 
@@ -4017,6 +4020,10 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
 		return -ENOMEM;
 #endif
 
+	sit_i->invalid_segmap = f2fs_kvzalloc(sbi, bitmap_size, GFP_KERNEL);
+	if (!sit_i->invalid_segmap)
+		return -ENOMEM;
+
 	/* init SIT information */
 	sit_i->s_ops = &default_salloc_ops;
 
@@ -4518,6 +4525,7 @@ static void destroy_sit_info(struct f2fs_sb_info *sbi)
 #ifdef CONFIG_F2FS_CHECK_FS
 	kvfree(sit_i->sit_bitmap_mir);
 #endif
+	kvfree(sit_i->invalid_segmap);
 	kvfree(sit_i);
 }
 
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index b746028..3918155c 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -246,6 +246,9 @@ struct sit_info {
 	unsigned long long min_mtime;		/* min. modification time */
 	unsigned long long max_mtime;		/* max. modification time */
 
+	/* bitmap of segments to be ignored by GC in case of errors */
+	unsigned long *invalid_segmap;
+
 	unsigned int last_victim[MAX_GC_POLICY]; /* last victim segment # */
 };
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

