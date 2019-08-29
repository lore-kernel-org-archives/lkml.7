Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA30C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D2C2189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbfH2Qvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 12:51:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37508 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbfH2Qvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:51:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id d16so4552508wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 09:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WRm9Dlayh6LoOp5c/Pq7/z+hWsqAetw4GK4CPNMVmzM=;
        b=R24AMfsw6a00hT+u7Dxn05otu4djZi3JvrThgF+M7q2jLozuE+NJJAxbYe6Sc4bkY6
         r2XAAbBhftfj6ZxgiGDxOwxfrxHT/GQPFS3ZVJka/6JP/mwekU1p8xhCIiu32r+ByrGX
         OtgG2PngpjkzZqdW/KljzgBIYjGOONzS9OhH/HptLY9xfqUWGJxk1SnmGrz5UeERsKBV
         b6KWhzsF/tS8feqlAI2ktfPkPJPNjFXDdZXpDc6RkJOun+us9PiUAe6Cqf8W59eInqBO
         JPGVRIeybYnpxSeIWDKIFUQuqCqNK3ssDSCo8tztwNLyyfHzziyYHBDPpy+oA1lfFpbk
         iAgw==
X-Gm-Message-State: APjAAAW334KvZH/XykbmupuhY9MnhbrscAJFQUB41BdLj4Wt9j5a4YQc
        I75eW7gLbyN4MOi4E9laBn8L6gqpSHg=
X-Google-Smtp-Source: APXvYqxS8+iLPfnMOsQV2WHXPP0Xm+FMBUv/lN9MF07WLkCm1A7Ap2UXdrdTCdBt6n09CFaXPCIcHQ==
X-Received: by 2002:a1c:be15:: with SMTP id o21mr12562188wmf.140.1567097505283;
        Thu, 29 Aug 2019 09:51:45 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id o14sm8340770wrg.64.2019.08.29.09.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 09:51:44 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-kernel@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH v3 11/11] ntfs: remove (un)?likely() from IS_ERR() conditions
Date:   Thu, 29 Aug 2019 19:50:25 +0300
Message-Id: <20190829165025.15750-11-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829165025.15750-1-efremov@linux.com>
References: <20190829165025.15750-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"likely(!IS_ERR(x))" is excessive. IS_ERR() already uses
unlikely() internally.

Signed-off-by: Denis Efremov <efremov@linux.com>
Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-ntfs-dev@lists.sourceforge.net
---
 fs/ntfs/mft.c     | 12 ++++++------
 fs/ntfs/namei.c   |  2 +-
 fs/ntfs/runlist.c |  2 +-
 fs/ntfs/super.c   |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 20c841a906f2..3aac5c917afe 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -71,7 +71,7 @@ static inline MFT_RECORD *map_mft_record_page(ntfs_inode *ni)
 	}
 	/* Read, map, and pin the page. */
 	page = ntfs_map_page(mft_vi->i_mapping, index);
-	if (likely(!IS_ERR(page))) {
+	if (!IS_ERR(page)) {
 		/* Catch multi sector transfer fixup errors. */
 		if (likely(ntfs_is_mft_recordp((le32*)(page_address(page) +
 				ofs)))) {
@@ -154,7 +154,7 @@ MFT_RECORD *map_mft_record(ntfs_inode *ni)
 	mutex_lock(&ni->mrec_lock);
 
 	m = map_mft_record_page(ni);
-	if (likely(!IS_ERR(m)))
+	if (!IS_ERR(m))
 		return m;
 
 	mutex_unlock(&ni->mrec_lock);
@@ -271,7 +271,7 @@ MFT_RECORD *map_extent_mft_record(ntfs_inode *base_ni, MFT_REF mref,
 		m = map_mft_record(ni);
 		/* map_mft_record() has incremented this on success. */
 		atomic_dec(&ni->count);
-		if (likely(!IS_ERR(m))) {
+		if (!IS_ERR(m)) {
 			/* Verify the sequence number. */
 			if (likely(le16_to_cpu(m->sequence_number) == seq_no)) {
 				ntfs_debug("Done 1.");
@@ -1303,7 +1303,7 @@ static int ntfs_mft_bitmap_extend_allocation_nolock(ntfs_volume *vol)
 	read_unlock_irqrestore(&mftbmp_ni->size_lock, flags);
 	rl = ntfs_attr_find_vcn_nolock(mftbmp_ni,
 			(ll - 1) >> vol->cluster_size_bits, NULL);
-	if (unlikely(IS_ERR(rl) || !rl->length || rl->lcn < 0)) {
+	if (IS_ERR(rl) || unlikely(!rl->length || rl->lcn < 0)) {
 		up_write(&mftbmp_ni->runlist.lock);
 		ntfs_error(vol->sb, "Failed to determine last allocated "
 				"cluster of mft bitmap attribute.");
@@ -1734,7 +1734,7 @@ static int ntfs_mft_data_extend_allocation_nolock(ntfs_volume *vol)
 	read_unlock_irqrestore(&mft_ni->size_lock, flags);
 	rl = ntfs_attr_find_vcn_nolock(mft_ni,
 			(ll - 1) >> vol->cluster_size_bits, NULL);
-	if (unlikely(IS_ERR(rl) || !rl->length || rl->lcn < 0)) {
+	if (IS_ERR(rl) || unlikely(!rl->length || rl->lcn < 0)) {
 		up_write(&mft_ni->runlist.lock);
 		ntfs_error(vol->sb, "Failed to determine last allocated "
 				"cluster of mft data attribute.");
@@ -1776,7 +1776,7 @@ static int ntfs_mft_data_extend_allocation_nolock(ntfs_volume *vol)
 	do {
 		rl2 = ntfs_cluster_alloc(vol, old_last_vcn, nr, lcn, MFT_ZONE,
 				true);
-		if (likely(!IS_ERR(rl2)))
+		if (!IS_ERR(rl2))
 			break;
 		if (PTR_ERR(rl2) != -ENOSPC || nr == min_nr) {
 			ntfs_error(vol->sb, "Failed to allocate the minimal "
diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index 2d3cc9e3395d..4e6a44bc654c 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -115,7 +115,7 @@ static struct dentry *ntfs_lookup(struct inode *dir_ino, struct dentry *dent,
 		dent_ino = MREF(mref);
 		ntfs_debug("Found inode 0x%lx. Calling ntfs_iget.", dent_ino);
 		dent_inode = ntfs_iget(vol->sb, dent_ino);
-		if (likely(!IS_ERR(dent_inode))) {
+		if (!IS_ERR(dent_inode)) {
 			/* Consistency check. */
 			if (is_bad_inode(dent_inode) || MSEQNO(mref) ==
 					NTFS_I(dent_inode)->seq_no ||
diff --git a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
index 508744a93180..97932fb5179c 100644
--- a/fs/ntfs/runlist.c
+++ b/fs/ntfs/runlist.c
@@ -951,7 +951,7 @@ runlist_element *ntfs_mapping_pairs_decompress(const ntfs_volume *vol,
 	}
 	/* Now combine the new and old runlists checking for overlaps. */
 	old_rl = ntfs_runlists_merge(old_rl, rl);
-	if (likely(!IS_ERR(old_rl)))
+	if (!IS_ERR(old_rl))
 		return old_rl;
 	ntfs_free(rl);
 	ntfs_error(vol->sb, "Failed to merge runlists.");
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 29621d40f448..7dc3bc604f78 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1475,7 +1475,7 @@ static bool load_and_init_usnjrnl(ntfs_volume *vol)
 	kfree(name);
 	/* Get the inode. */
 	tmp_ino = ntfs_iget(vol->sb, MREF(mref));
-	if (unlikely(IS_ERR(tmp_ino) || is_bad_inode(tmp_ino))) {
+	if (IS_ERR(tmp_ino) || unlikely(is_bad_inode(tmp_ino))) {
 		if (!IS_ERR(tmp_ino))
 			iput(tmp_ino);
 		ntfs_error(vol->sb, "Failed to load $UsnJrnl.");
-- 
2.21.0

