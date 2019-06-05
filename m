Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65F1C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E722075B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfFEVRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 17:17:13 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:44429 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfFEVRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 17:17:12 -0400
Received: from orion.localdomain ([77.2.1.21]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MStKq-1h7jXq059i-00UHZH; Wed, 05 Jun 2019 23:17:04 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH] fs: ntfs: drop unneeded likely() call around IS_ERR()
Date:   Wed,  5 Jun 2019 23:17:02 +0200
Message-Id: <1559769422-23030-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:KhGz3LPXtHFEc3TDhz5N7mtq6XeieAJf1tGgVCFaA6AFyQXtpiT
 9gazZ5Q9mXfMRFWrwXfgze53g6eriCa2Ynv2vTipRgWs3N0okTRbN/9Z64IqrZi1J4ryGqr
 s1qDJjQdQ6mXUr3t5L0auR+0/SRMFMdC6oYA2Z2kTI4h4tGtQnm/zRna1oTMevd0ivOkuZX
 mfmko9S40b9/JlGkb4vtw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q7Qs8JFmvds=:gXGON/PTWFxqE1O5a3J+Od
 ZQ/CL4lBX1gV5BerD74zKzly1hML8CQnJctm1/XDDbi5ZTIXpcTOw5RecBu5iti03cl6CSvwN
 jrVORfIhTFOY8xKPYHo3DqsOr7KdA3MW/FCQw/kwkwR14BBCyTTVIKmq9/cB9F3/rFyzbgH89
 F73NpRunh+vMkpYSBE2i0yrao6Y8CydABv6T/iWIgI0N7urbxwTES422L8kZeJXTwe4W+hZZV
 0/gEufn248xLcsrvkt2ureKWe+7HGlPddN8Px0ErijD+vcJT5P/c3dSWeSNrTEBZMGaDNovZT
 JHnqmU0wC8cS/Ptp6k1Y3C73IF8GDicGWKdQK6GdebGhsYq/FZkuvQBxdOswIBUvzlCPiYwIg
 bxoGSh+wnjuK8Uye4DD0pyfANCpNm5haKuPU1p326k5o1PeyPHuop1qpQG84IzItOdPrcjTDW
 4mGa7RjRvI4wHHnZlxl+zk2l2+Z5T63cnRR3Ln18wpPfvlwU5Re3z/3QxWsdZmVEnoRxH6JBs
 shnkmt4D1qOidtfkZn1MQLayOChk1ZlC3ymewPOeLVHK3Uxdiu3VtQJld8BtP4eDQeIEY9jBy
 +uP3K2lnLAV6ukhldbjcDEVMmETOh5NNXSSBh1yrC4XQJCMCgCNdRnU0AqMpJb+6RjBH+3k5n
 JZ/4/fkU1OYNTUN54Dz+7LNJsirfbnYw9zz2OfaLUleIenhzABeCYyM1ganAwEXUkpfkcjH6q
 gJJVXMWL+f5mB00u+UG4GDHQyZc7c6nmoOG66Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enrico Weigelt <info@metux.net>

IS_ERR() already calls unlikely(), so this extra likely() call
around the !IS_ERR() is not needed.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 fs/ntfs/mft.c     | 8 ++++----
 fs/ntfs/namei.c   | 2 +-
 fs/ntfs/runlist.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 20c841a..06f706b 100644
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
index 2d3cc9e..4e6a44b 100644
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
index 508744a..97932fb 100644
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
-- 
1.9.1

