Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3F0C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00BCA217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="i9CocGo4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YZs1dOW4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbfHFLZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 07:25:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50580 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfHFLZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 07:25:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 417736050D; Tue,  6 Aug 2019 11:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565090746;
        bh=VZyDa5xwZ3D5C5Lz2pDRthJNOUDBPslSb+tqQto/oEY=;
        h=From:To:Cc:Subject:Date:From;
        b=i9CocGo4xSmqpSfcHurgJee3GRDFWlV4LXFkXa4/MVY6EVTmVy3U1d+R3lOa39ggu
         yECQcoetuG0IhmOsRX5EG4shDtf2Gf9dXd6R3R7iaftVraI3P1T/EifwQ65r9UQhbj
         PhFjuMIKjLxk6xg1+7O89OvzWTIbOiDCInG2jdlU=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CDC326050D;
        Tue,  6 Aug 2019 11:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565090745;
        bh=VZyDa5xwZ3D5C5Lz2pDRthJNOUDBPslSb+tqQto/oEY=;
        h=From:To:Cc:Subject:Date:From;
        b=YZs1dOW4g/bDQTyeDU53v1yjf+3Jt1AXmgOWTHnMDs7NQzobFpdn/tW9JRqaFV8vp
         5dOx08ffxeR3jTa9DvmfHCWsHRPXIEhiF6BhGj0Sfr6c7yFgezYBpS5/2X+A0ZHDjj
         RpvZQdgaBRnji1ixO05bgdS1PyLNk6OQjuQjyAeE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CDC326050D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] f2fs: Fix indefinite loop in f2fs_gc()
Date:   Tue,  6 Aug 2019 16:49:56 +0530
Message-Id: <1565090396-7263-1-git-send-email-stummala@codeaurora.org>
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
v2: fix as per Chao's suggestion to handle this error case

 fs/f2fs/gc.c      | 15 ++++++++++++++-
 fs/f2fs/segment.c |  5 +++++
 fs/f2fs/segment.h |  3 +++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 8974672..321a78a 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -382,6 +382,14 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 			nsearched++;
 		}
 
+		/*
+		 * skip selecting the invalid segno (that is failed due to block
+		 * validity check failed during GC) to avoid endless GC loop in
+		 * such cases.
+		 */
+		if (test_bit(segno, sm->invalid_segmap))
+			goto next;
+
 		secno = GET_SEC_FROM_SEG(sbi, segno);
 
 		if (sec_usage_check(sbi, secno))
@@ -975,6 +983,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	int off;
 	int phase = 0;
 	int submitted = 0;
+	struct sit_info *sit_i = SIT_I(sbi);
 
 	start_addr = START_BLOCK(sbi, segno);
 
@@ -1008,8 +1017,12 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 		}
 
 		/* Get an inode by ino with checking validity */
-		if (!is_alive(sbi, entry, &dni, start_addr + off, &nofs))
+		if (!is_alive(sbi, entry, &dni, start_addr + off, &nofs)) {
+			if (!test_and_set_bit(segno, sit_i->invalid_segmap))
+				f2fs_err(sbi, "invalid blkaddr %u in seg %u is found\n",
+						start_addr + off, segno);
 			continue;
+		}
 
 		if (phase == 2) {
 			f2fs_ra_node_page(sbi, dni.ino);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a661ac3..d45a1d3 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4017,6 +4017,10 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
 		return -ENOMEM;
 #endif
 
+	sit_i->invalid_segmap = f2fs_kvzalloc(sbi, bitmap_size, GFP_KERNEL);
+	if (!sit_i->invalid_segmap)
+		return -ENOMEM;
+
 	/* init SIT information */
 	sit_i->s_ops = &default_salloc_ops;
 
@@ -4518,6 +4522,7 @@ static void destroy_sit_info(struct f2fs_sb_info *sbi)
 #ifdef CONFIG_F2FS_CHECK_FS
 	kvfree(sit_i->sit_bitmap_mir);
 #endif
+	kvfree(sit_i->invalid_segmap);
 	kvfree(sit_i);
 }
 
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index b746028..bc5dbe8 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -246,6 +246,9 @@ struct sit_info {
 	unsigned long long min_mtime;		/* min. modification time */
 	unsigned long long max_mtime;		/* max. modification time */
 
+	/* list of segments to be ignored by GC in case of errors */
+	unsigned long *invalid_segmap;
+
 	unsigned int last_victim[MAX_GC_POLICY]; /* last victim segment # */
 };
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

