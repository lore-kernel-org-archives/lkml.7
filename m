Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2172C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23EB20856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732052AbfDBNox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:44:53 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43446 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731476AbfDBNkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:08 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJe0-0002oY-H3; Tue, 02 Apr 2019 14:40:04 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdx-0004wv-M8; Tue, 02 Apr 2019 14:40:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Dmitry Monakhov" <dmonakhov@openvz.org>
Date:   Tue, 02 Apr 2019 14:38:28 +0100
Message-ID: <lsq.1554212308.191495262@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 80/99] ext4: ext4_inline_data_fiemap should respect
 callers argument
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Monakhov <dmonakhov@openvz.org>

commit d952d69e268f833c85c0bafee9f67f9dba85044b upstream.

Currently ext4_inline_data_fiemap ignores requested arguments (start
and len) which may lead endless loop if start != 0.  Also fix incorrect
extent length determination.

Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/ext4.h    |  2 +-
 fs/ext4/extents.c |  3 ++-
 fs/ext4/inline.c  | 19 +++++++++++++------
 3 files changed, 16 insertions(+), 8 deletions(-)

--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2712,7 +2712,7 @@ extern struct buffer_head *ext4_get_firs
 					int *retval);
 extern int ext4_inline_data_fiemap(struct inode *inode,
 				   struct fiemap_extent_info *fieinfo,
-				   int *has_inline);
+				   int *has_inline, __u64 start, __u64 len);
 extern void ext4_inline_data_truncate(struct inode *inode, int *has_inline);
 
 extern int ext4_convert_inline_data(struct inode *inode);
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5153,7 +5153,8 @@ int ext4_fiemap(struct inode *inode, str
 	if (ext4_has_inline_data(inode)) {
 		int has_inline = 1;
 
-		error = ext4_inline_data_fiemap(inode, fieinfo, &has_inline);
+		error = ext4_inline_data_fiemap(inode, fieinfo, &has_inline,
+						start, len);
 
 		if (has_inline)
 			return error;
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1816,11 +1816,12 @@ int ext4_destroy_inline_data(handle_t *h
 
 int ext4_inline_data_fiemap(struct inode *inode,
 			    struct fiemap_extent_info *fieinfo,
-			    int *has_inline)
+			    int *has_inline, __u64 start, __u64 len)
 {
 	__u64 physical = 0;
-	__u64 length;
-	__u32 flags = FIEMAP_EXTENT_DATA_INLINE | FIEMAP_EXTENT_LAST;
+	__u64 inline_len;
+	__u32 flags = FIEMAP_EXTENT_DATA_INLINE | FIEMAP_EXTENT_NOT_ALIGNED |
+		FIEMAP_EXTENT_LAST;
 	int error = 0;
 	struct ext4_iloc iloc;
 
@@ -1829,6 +1830,13 @@ int ext4_inline_data_fiemap(struct inode
 		*has_inline = 0;
 		goto out;
 	}
+	inline_len = min_t(size_t, ext4_get_inline_size(inode),
+			   i_size_read(inode));
+	if (start >= inline_len)
+		goto out;
+	if (start + len < inline_len)
+		inline_len = start + len;
+	inline_len -= start;
 
 	error = ext4_get_inode_loc(inode, &iloc);
 	if (error)
@@ -1837,11 +1845,10 @@ int ext4_inline_data_fiemap(struct inode
 	physical = (__u64)iloc.bh->b_blocknr << inode->i_sb->s_blocksize_bits;
 	physical += (char *)ext4_raw_inode(&iloc) - iloc.bh->b_data;
 	physical += offsetof(struct ext4_inode, i_block);
-	length = i_size_read(inode);
 
 	if (physical)
-		error = fiemap_fill_next_extent(fieinfo, 0, physical,
-						length, flags);
+		error = fiemap_fill_next_extent(fieinfo, start, physical,
+						inline_len, flags);
 	brelse(iloc.bh);
 out:
 	up_read(&EXT4_I(inode)->xattr_sem);

