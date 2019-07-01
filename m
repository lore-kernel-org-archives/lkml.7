Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515B4C06508
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 02:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E492089C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 02:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digidescorp.com header.i=@digidescorp.com header.b="JyW0iPAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfGACj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 22:39:56 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:38419 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfGACjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 22:39:55 -0400
Received: by mail-io1-f51.google.com with SMTP id j6so25260858ioa.5
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 19:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=J470OwdmSpa0rN0oGsbs5IwY5SMMvVOyGiR0ZPlF5nk=;
        b=JyW0iPASpbT/2m+MTGgDg8snxkKoMuwVA5zg+jgo5dmGugAQNRcKWMPq2H5D2Xq0Xs
         yCOSNi0+s5Nl3K+WlqIfRS7YJjbwQk/58DKwCRe/FC9vwJWFUn36tY3yvskKPZPL6ODR
         ZOHlgQ51MlmU1w97Ux4+6f/wZm9UCHsrOlcNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J470OwdmSpa0rN0oGsbs5IwY5SMMvVOyGiR0ZPlF5nk=;
        b=AlE85FDoYnwZfTu1yQRL4B4/biUHaRBKzOvPq8XuT/5TqMhPMZqLvT1T9MQAShIdjH
         9PbM0jK3+UGhqv4A4MEQb8GUFaMxGChhdc+I6EU+HE1rNa/WqhAiBNKeSA39/g/nhXXS
         nPzM8N98xb9hmqbWtBl0YWh/nZ/eDDCo9PyIwAqShHLkeocBbDFqlLt3QGIKpHLWUwGI
         W/Hd698Tw0en9aKQg2UHM2ak8U13OAkl6ZmmHWChtxPIM/r5HpI2lQaZxuuLnuFxccuu
         bYYEDqUOdvFHhbVHo716rCU1+H++E5JhVgsWTZi0Cgm6+46CRuLze8P2HsKJBna1kRCF
         D0xw==
X-Gm-Message-State: APjAAAXTAWJ1Oe/jpgn+Fjv9bJzL0xqZXI88JaiTh0LHE+Wden+NgDbP
        q+1gQNn9A6yleRUhqL7YLR45fcZCqbs=
X-Google-Smtp-Source: APXvYqyXqKbR0ybOE3fdrtqJaC9CBGROxmxDpo8dahySVfCZw4Qe+xb5qA2wOnPRJnD618Gu5n3GcQ==
X-Received: by 2002:a6b:641a:: with SMTP id t26mr7056687iog.3.1561948794232;
        Sun, 30 Jun 2019 19:39:54 -0700 (PDT)
Received: from teton.8.8.8.8 ([50.73.98.161])
        by smtp.googlemail.com with ESMTPSA id s2sm7884553ioj.8.2019.06.30.19.39.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 30 Jun 2019 19:39:53 -0700 (PDT)
From:   "Steven J. Magnani" <steve.magnani@digidescorp.com>
X-Google-Original-From: "Steven J. Magnani" <steve@digidescorp.com>
To:     Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J . Magnani" <steve@digidescorp.com>
Subject: [PATCH v2] udf: Fix incorrect final NOT_ALLOCATED (hole) extent length
Date:   Sun, 30 Jun 2019 21:39:35 -0500
Message-Id: <1561948775-5878-1-git-send-email-steve@digidescorp.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases, using the 'truncate' command to extend a UDF file results
in a mismatch between the length of the file's extents (specifically, due
to incorrect length of the final NOT_ALLOCATED extent) and the information
(file) length. The discrepancy can prevent other operating systems
(i.e., Windows 10) from opening the file.

Two particular errors have been observed when extending a file:

1. The final extent is larger than it should be, having been rounded up
   to a multiple of the block size.

B. The final extent is not shorter than it should be, due to not having
   been updated when the file's information length was increased.

Change since v1:
Simplified udf_do_extend_file() API, partially by factoring out its
handling of the "extending within the last file block" corner case.

Fixes: 2c948b3f86e5 ("udf: Avoid IO in udf_clear_inode")
Signed-off-by: Steven J. Magnani <steve@digidescorp.com>

--- a/fs/udf/inode.c	2019-05-24 21:17:33.659704533 -0500
+++ b/fs/udf/inode.c	2019-06-29 21:10:48.938562957 -0500
@@ -470,13 +470,15 @@ static struct buffer_head *udf_getblk(st
 	return NULL;
 }
 
-/* Extend the file by 'blocks' blocks, return the number of extents added */
+/* Extend the file with new blocks totaling 'new_block_bytes',
+ * return the number of extents added
+ */
 static int udf_do_extend_file(struct inode *inode,
 			      struct extent_position *last_pos,
 			      struct kernel_long_ad *last_ext,
-			      sector_t blocks)
+			      loff_t new_block_bytes)
 {
-	sector_t add;
+	unsigned long add;
 	int count = 0, fake = !(last_ext->extLength & UDF_EXTENT_LENGTH_MASK);
 	struct super_block *sb = inode->i_sb;
 	struct kernel_lb_addr prealloc_loc = {};
@@ -486,7 +488,7 @@ static int udf_do_extend_file(struct ino
 
 	/* The previous extent is fake and we should not extend by anything
 	 * - there's nothing to do... */
-	if (!blocks && fake)
+	if (!new_block_bytes && fake)
 		return 0;
 
 	iinfo = UDF_I(inode);
@@ -517,13 +519,12 @@ static int udf_do_extend_file(struct ino
 	/* Can we merge with the previous extent? */
 	if ((last_ext->extLength & UDF_EXTENT_FLAG_MASK) ==
 					EXT_NOT_RECORDED_NOT_ALLOCATED) {
-		add = ((1 << 30) - sb->s_blocksize -
-			(last_ext->extLength & UDF_EXTENT_LENGTH_MASK)) >>
-			sb->s_blocksize_bits;
-		if (add > blocks)
-			add = blocks;
-		blocks -= add;
-		last_ext->extLength += add << sb->s_blocksize_bits;
+		add = (1 << 30) - sb->s_blocksize -
+			(last_ext->extLength & UDF_EXTENT_LENGTH_MASK);
+		if (add > new_block_bytes)
+			add = new_block_bytes;
+		new_block_bytes -= add;
+		last_ext->extLength += add;
 	}
 
 	if (fake) {
@@ -544,28 +545,27 @@ static int udf_do_extend_file(struct ino
 	}
 
 	/* Managed to do everything necessary? */
-	if (!blocks)
+	if (!new_block_bytes)
 		goto out;
 
 	/* All further extents will be NOT_RECORDED_NOT_ALLOCATED */
 	last_ext->extLocation.logicalBlockNum = 0;
 	last_ext->extLocation.partitionReferenceNum = 0;
-	add = (1 << (30-sb->s_blocksize_bits)) - 1;
-	last_ext->extLength = EXT_NOT_RECORDED_NOT_ALLOCATED |
-				(add << sb->s_blocksize_bits);
+	add = (1 << 30) - sb->s_blocksize;
+	last_ext->extLength = EXT_NOT_RECORDED_NOT_ALLOCATED | add;
 
 	/* Create enough extents to cover the whole hole */
-	while (blocks > add) {
-		blocks -= add;
+	while (new_block_bytes > add) {
+		new_block_bytes -= add;
 		err = udf_add_aext(inode, last_pos, &last_ext->extLocation,
 				   last_ext->extLength, 1);
 		if (err)
 			return err;
 		count++;
 	}
-	if (blocks) {
+	if (new_block_bytes) {
 		last_ext->extLength = EXT_NOT_RECORDED_NOT_ALLOCATED |
-			(blocks << sb->s_blocksize_bits);
+			new_block_bytes;
 		err = udf_add_aext(inode, last_pos, &last_ext->extLocation,
 				   last_ext->extLength, 1);
 		if (err)
@@ -596,6 +596,44 @@ out:
 	return count;
 }
 
+/* Extend the final block of the file to final_block_len bytes */
+static int udf_do_extend_final_block(struct inode *inode,
+				     struct extent_position *last_pos,
+				     struct kernel_long_ad *last_ext,
+				     unsigned long final_block_len)
+{
+	struct super_block *sb = inode->i_sb;
+	struct kernel_lb_addr tmploc;
+	uint32_t tmplen;
+	struct udf_inode_info *iinfo;
+	unsigned long added_bytes;
+
+	iinfo = UDF_I(inode);
+
+	added_bytes = final_block_len -
+		      (last_ext->extLength & (sb->s_blocksize - 1));
+	last_ext->extLength += added_bytes;
+	iinfo->i_lenExtents += added_bytes;
+
+	udf_write_aext(inode, last_pos, &last_ext->extLocation,
+			last_ext->extLength, 1);
+	/*
+	 * We've rewritten the last extent but there may be empty
+	 * indirect extent after it - enter it.
+	 */
+	udf_next_aext(inode, last_pos, &tmploc, &tmplen, 0);
+
+	/* last_pos should point to the last written extent... */
+	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
+		last_pos->offset -= sizeof(struct short_ad);
+	else if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_LONG)
+		last_pos->offset -= sizeof(struct long_ad);
+	else
+		return -EIO;
+
+	return 0;
+}
+
 static int udf_extend_file(struct inode *inode, loff_t newsize)
 {
 
@@ -605,10 +643,12 @@ static int udf_extend_file(struct inode
 	int8_t etype;
 	struct super_block *sb = inode->i_sb;
 	sector_t first_block = newsize >> sb->s_blocksize_bits, offset;
+	unsigned long partial_final_block;
 	int adsize;
 	struct udf_inode_info *iinfo = UDF_I(inode);
 	struct kernel_long_ad extent;
 	int err;
+	int within_final_block;
 
 	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
 		adsize = sizeof(struct short_ad);
@@ -618,18 +658,8 @@ static int udf_extend_file(struct inode
 		BUG();
 
 	etype = inode_bmap(inode, first_block, &epos, &eloc, &elen, &offset);
+	within_final_block = (etype != -1);
 
-	/* File has extent covering the new size (could happen when extending
-	 * inside a block)? */
-	if (etype != -1)
-		return 0;
-	if (newsize & (sb->s_blocksize - 1))
-		offset++;
-	/* Extended file just to the boundary of the last file block? */
-	if (offset == 0)
-		return 0;
-
-	/* Truncate is extending the file by 'offset' blocks */
 	if ((!epos.bh && epos.offset == udf_file_entry_alloc_offset(inode)) ||
 	    (epos.bh && epos.offset == sizeof(struct allocExtDesc))) {
 		/* File has no extents at all or has empty last
@@ -643,7 +673,22 @@ static int udf_extend_file(struct inode
 				      &extent.extLength, 0);
 		extent.extLength |= etype << 30;
 	}
-	err = udf_do_extend_file(inode, &epos, &extent, offset);
+
+	partial_final_block = newsize & (sb->s_blocksize - 1);
+
+	/* File has extent covering the new size (could happen when extending
+	 * inside a block)?
+	 */
+	if (within_final_block) {
+		/* Extending file within the last file block */
+		err = udf_do_extend_final_block(inode, &epos, &extent,
+						partial_final_block);
+	} else {
+		loff_t add = (offset << sb->s_blocksize_bits) |
+			     partial_final_block;
+		err = udf_do_extend_file(inode, &epos, &extent, add);
+	}
+
 	if (err < 0)
 		goto out;
 	err = 0;
@@ -745,6 +790,7 @@ static sector_t inode_getblk(struct inod
 	/* Are we beyond EOF? */
 	if (etype == -1) {
 		int ret;
+		loff_t hole_len;
 		isBeyondEOF = true;
 		if (count) {
 			if (c)
@@ -760,7 +806,8 @@ static sector_t inode_getblk(struct inod
 			startnum = (offset > 0);
 		}
 		/* Create extents for the hole between EOF and offset */
-		ret = udf_do_extend_file(inode, &prev_epos, laarr, offset);
+		hole_len = offset << inode->i_sb->s_blocksize_bits;
+		ret = udf_do_extend_file(inode, &prev_epos, laarr, hole_len);
 		if (ret < 0) {
 			*err = ret;
 			newblock = 0;
