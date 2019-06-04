Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE48C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7566E24107
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digidescorp.com header.i=@digidescorp.com header.b="Osu8bQfm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfFDMcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 08:32:13 -0400
Received: from mail-it1-f178.google.com ([209.85.166.178]:51644 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfFDMcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:32:13 -0400
Received: by mail-it1-f178.google.com with SMTP id m3so33089020itl.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 05:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+jAbZ0t76Z50N6t1Fx45rWslaxTkTOYpMk7T1bcsR10=;
        b=Osu8bQfmEuI4+VDV+LBYrCE2RdZPkarbrDor9JLtGQV0hZDvvNJbgglC6jBV5E1yDC
         oqbMYI5lnde8GYYec7oJEdmeEScQvECneHcOLRAdI6wWoTqoYykhiM4l9F7J2kmLwIOo
         QAsAolLwIgNsZbXK21gcF/NgER20YFZ5zphM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+jAbZ0t76Z50N6t1Fx45rWslaxTkTOYpMk7T1bcsR10=;
        b=cW8oVBAhK9QNtJapvZTeQbN1yPcErcHutrDAr9qOKhgHzM5C0D7hHxNj8FK8c+MLkg
         7Ywn/bbv6ua26Dq6Z+LufiWfCTvOBSCJDsIdQD5IrSOHmO8IAbsUwyYF1RNBE1bZOzDp
         CaEiQWEk2keEWZrpL7OuWrjBO1aGX5COGykPhcWHD9ikXP7ePC+440t3h6LJHW9AYecn
         Mtgp0ypMTzWDVyTV5WKhPWGMGWECyVb4JHO/cltTOaLQMMoiZ5Pe1tsAxUU83LjDB3st
         PysrUMLhRkuuuv6SNwkbjCOs+MuMeoEMnkvyCTxgPZ4+TADzJVC8PkLCVVhfWbDoybl0
         RWjg==
X-Gm-Message-State: APjAAAU+q/dfvpHlpmYLPBGKkTCP9iz4heO6OvKWVZoW8zvwO63pON+S
        sbp46SpAw/WsbM1C40uAhvx8JQ==
X-Google-Smtp-Source: APXvYqyXfokIW2pEMcRXX2hyRaE8Nd9uJ+yEXh5J9EWbZTiCUZrf03+7GaXPeqV+noxZriDETG9uFg==
X-Received: by 2002:a05:660c:844:: with SMTP id f4mr20690252itl.139.1559651532056;
        Tue, 04 Jun 2019 05:32:12 -0700 (PDT)
Received: from iscandar.digidescorp.com (104-51-28-62.lightspeed.cicril.sbcglobal.net. [104.51.28.62])
        by smtp.googlemail.com with ESMTPSA id c91sm871827itd.4.2019.06.04.05.32.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 05:32:11 -0700 (PDT)
From:   Steve Magnani <steve.magnani@digidescorp.com>
X-Google-Original-From: Steve Magnani <steve@digidescorp.com>
To:     Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J . Magnani" <steve@digidescorp.com>
Subject: [PATCH 1/1] udf: Fix incorrect final NOT_ALLOCATED (hole) extent length
Date:   Tue,  4 Jun 2019 07:31:58 -0500
Message-Id: <20190604123158.12741-2-steve@digidescorp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604123158.12741-1-steve@digidescorp.com>
References: <20190604123158.12741-1-steve@digidescorp.com>
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

The first case could represent a design error, if coded intentionally
due to a misinterpretation of scantily-documented ECMA-167 "file tail"
rules. The standard specifies that the tail, if present, consists of
a sequence of "unrecorded and allocated" extents (only).

Signed-off-by: Steven J. Magnani <steve@digidescorp.com>

--- a/fs/udf/inode.c	2019-05-24 21:17:33.659704533 -0500
+++ b/fs/udf/inode.c	2019-05-29 20:32:23.730129419 -0500
@@ -474,7 +474,8 @@ static struct buffer_head *udf_getblk(st
 static int udf_do_extend_file(struct inode *inode,
 			      struct extent_position *last_pos,
 			      struct kernel_long_ad *last_ext,
-			      sector_t blocks)
+			      sector_t blocks,
+			      unsigned long partial_final_block)
 {
 	sector_t add;
 	int count = 0, fake = !(last_ext->extLength & UDF_EXTENT_LENGTH_MASK);
@@ -486,7 +487,7 @@ static int udf_do_extend_file(struct ino
 
 	/* The previous extent is fake and we should not extend by anything
 	 * - there's nothing to do... */
-	if (!blocks && fake)
+	if (!blocks && !partial_final_block && fake)
 		return 0;
 
 	iinfo = UDF_I(inode);
@@ -524,6 +525,10 @@ static int udf_do_extend_file(struct ino
 			add = blocks;
 		blocks -= add;
 		last_ext->extLength += add << sb->s_blocksize_bits;
+		if (blocks == 0 && partial_final_block) {
+			last_ext->extLength -= sb->s_blocksize
+				- partial_final_block;
+		}
 	}
 
 	if (fake) {
@@ -566,6 +571,10 @@ static int udf_do_extend_file(struct ino
 	if (blocks) {
 		last_ext->extLength = EXT_NOT_RECORDED_NOT_ALLOCATED |
 			(blocks << sb->s_blocksize_bits);
+		if (partial_final_block) {
+			last_ext->extLength -= sb->s_blocksize
+					- partial_final_block;
+		}
 		err = udf_add_aext(inode, last_pos, &last_ext->extLocation,
 				   last_ext->extLength, 1);
 		if (err)
@@ -605,6 +614,7 @@ static int udf_extend_file(struct inode
 	int8_t etype;
 	struct super_block *sb = inode->i_sb;
 	sector_t first_block = newsize >> sb->s_blocksize_bits, offset;
+	unsigned long partial_final_block;
 	int adsize;
 	struct udf_inode_info *iinfo = UDF_I(inode);
 	struct kernel_long_ad extent;
@@ -619,15 +629,17 @@ static int udf_extend_file(struct inode
 
 	etype = inode_bmap(inode, first_block, &epos, &eloc, &elen, &offset);
 
+	partial_final_block = newsize & (sb->s_blocksize - 1);
+
 	/* File has extent covering the new size (could happen when extending
 	 * inside a block)? */
-	if (etype != -1)
-		return 0;
-	if (newsize & (sb->s_blocksize - 1))
-		offset++;
-	/* Extended file just to the boundary of the last file block? */
-	if (offset == 0)
-		return 0;
+	if (etype == -1) {
+		if (partial_final_block)
+			offset++;
+	} else {
+		/* Extending file within the last file block */
+		offset = 0;  /* Don't add any new blocks */
+	}
 
 	/* Truncate is extending the file by 'offset' blocks */
 	if ((!epos.bh && epos.offset == udf_file_entry_alloc_offset(inode)) ||
@@ -643,7 +655,8 @@ static int udf_extend_file(struct inode
 				      &extent.extLength, 0);
 		extent.extLength |= etype << 30;
 	}
-	err = udf_do_extend_file(inode, &epos, &extent, offset);
+	err = udf_do_extend_file(inode, &epos, &extent, offset,
+				 partial_final_block);
 	if (err < 0)
 		goto out;
 	err = 0;
@@ -760,7 +773,7 @@ static sector_t inode_getblk(struct inod
 			startnum = (offset > 0);
 		}
 		/* Create extents for the hole between EOF and offset */
-		ret = udf_do_extend_file(inode, &prev_epos, laarr, offset);
+		ret = udf_do_extend_file(inode, &prev_epos, laarr, offset, 0);
 		if (ret < 0) {
 			*err = ret;
 			newblock = 0;
