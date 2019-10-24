Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E9AC47E49
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A700D21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409800AbfJXPyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:54:10 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:42592 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2409775AbfJXPyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:54:09 -0400
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9OFs8Da009826
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:08 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9OFs2Zp020763
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:08 -0400
Received: by mail-qt1-f199.google.com with SMTP id l5so6446605qtj.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 08:54:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=tuGYBWrQiV3Prr8/Sny44VGd46bwM8gjFYJUSWIv6Nc=;
        b=I0EjRRuIdsTmN4K3ZB10XKi4mZY35NiY8e3zWqyuZK1DUWZKPPWfmlcpE0vdYjcxem
         USFJT84Yq132m6I1YMAuEKKhJnlF7QHFndbl1zZiH426MpksXSQw8KgTRjYxYtx/4BZ3
         nTuW/MsMfjcLWAHLJ7537En9A8K1pLdKQUUN1AN3BWsyDYyL0ndya6hhume1J3IZ7Uy0
         1CNfB+4/VIWukjR6we8USFIBPQB0PB/nE7vtRC0mD99Q0vDYeggSKOPJ9DatGeMk3cGC
         XN1IhC1ckr7Y3DWRRO/s0op6gcvr5SpW+uvZVbMAgLEWNhWhcb+6gjCPY7ijj/3I/0vh
         elfg==
X-Gm-Message-State: APjAAAUAjg7fjU5CkwZlENDAvn+mYgfFTtEK7CJD0J3m75LieSZuykxK
        VfbYf0n5XbgoTWz/Y7BydXO0Z2TN8H3MAiybjk8zsIqF+esNVgSM72O8Ge5BTI3vZANjnnqRd6H
        TQgVwvpjWkdnpgMwETC3XEWlhYtpxXA1brHE=
X-Received: by 2002:a37:a50a:: with SMTP id o10mr14378910qke.115.1571932442684;
        Thu, 24 Oct 2019 08:54:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyp9z4sJf1v688STQmfBLUgM0AOlYZiO7i697T5YoUg+IxbY7V8VeP0mdjKzMV0FQf6gc+SiA==
X-Received: by 2002:a37:a50a:: with SMTP id o10mr14378878qke.115.1571932442323;
        Thu, 24 Oct 2019 08:54:02 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id x133sm12693274qka.44.2019.10.24.08.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:54:01 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/15] staging: exfat: Clean up return codes - FFS_FULL
Date:   Thu, 24 Oct 2019 11:53:12 -0400
Message-Id: <20191024155327.1095907-2-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start cleaning up the odd scheme of return codes, starting with FFS_FULL

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h       |  1 -
 drivers/staging/exfat/exfat_core.c  | 10 +++++-----
 drivers/staging/exfat/exfat_super.c | 16 ++++++++--------
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 8738e41dd5a5..4aca4ae44a98 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -221,7 +221,6 @@ static inline u16 get_row_index(u16 i)
 #define FFS_PERMISSIONERR       11
 #define FFS_NOTOPENED           12
 #define FFS_MAXOPENED           13
-#define FFS_FULL                14
 #define FFS_EOF                 15
 #define FFS_DIRBUSY             16
 #define FFS_MEMORYERR           17
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 7332e69fcbcd..af1ccd686e01 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -2369,7 +2369,7 @@ s32 create_dir(struct inode *inode, struct chain_t *p_dir,
 	/* find_empty_entry must be called before alloc_cluster */
 	dentry = find_empty_entry(inode, p_dir, num_entries);
 	if (dentry < 0)
-		return FFS_FULL;
+		return -ENOSPC;
 
 	clu.dir = CLUSTER_32(~0);
 	clu.size = 0;
@@ -2380,7 +2380,7 @@ s32 create_dir(struct inode *inode, struct chain_t *p_dir,
 	if (ret < 0)
 		return FFS_MEDIAERR;
 	else if (ret == 0)
-		return FFS_FULL;
+		return -ENOSPC;
 
 	ret = clear_cluster(sb, clu.dir);
 	if (ret != FFS_SUCCESS)
@@ -2472,7 +2472,7 @@ s32 create_file(struct inode *inode, struct chain_t *p_dir,
 	/* find_empty_entry must be called before alloc_cluster() */
 	dentry = find_empty_entry(inode, p_dir, num_entries);
 	if (dentry < 0)
-		return FFS_FULL;
+		return -ENOSPC;
 
 	/* (1) update the directory entry */
 	/* fill the dos name directory entry information of the created file.
@@ -2571,7 +2571,7 @@ s32 rename_file(struct inode *inode, struct chain_t *p_dir, s32 oldentry,
 		newentry = find_empty_entry(inode, p_dir, num_new_entries);
 		if (newentry < 0) {
 			buf_unlock(sb, sector_old);
-			return FFS_FULL;
+			return -ENOSPC;
 		}
 
 		epnew = get_entry_in_dir(sb, p_dir, newentry, &sector_new);
@@ -2682,7 +2682,7 @@ s32 move_file(struct inode *inode, struct chain_t *p_olddir, s32 oldentry,
 	newentry = find_empty_entry(inode, p_newdir, num_new_entries);
 	if (newentry < 0) {
 		buf_unlock(sb, sector_mov);
-		return FFS_FULL;
+		return -ENOSPC;
 	}
 
 	epnew = get_entry_in_dir(sb, p_newdir, newentry, &sector_new);
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 0264be92c2be..273fe2310e76 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -1045,7 +1045,7 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 		*wcount = write_bytes;
 
 	if (num_alloced == 0)
-		ret = FFS_FULL;
+		ret = -ENOSPC;
 
 	else if (p_fs->dev_ejected)
 		ret = FFS_MEDIAERR;
@@ -1801,7 +1801,7 @@ static int ffsMapCluster(struct inode *inode, s32 clu_offset, u32 *clu)
 			ret = FFS_MEDIAERR;
 			goto out;
 		} else if (num_alloced == 0) {
-			ret = FFS_FULL;
+			ret = -ENOSPC;
 			goto out;
 		}
 
@@ -2360,7 +2360,7 @@ static int exfat_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 			err = -EINVAL;
 		else if (err == FFS_FILEEXIST)
 			err = -EEXIST;
-		else if (err == FFS_FULL)
+		else if (err == -ENOSPC)
 			err = -ENOSPC;
 		else if (err == FFS_NAMETOOLONG)
 			err = -ENAMETOOLONG;
@@ -2571,7 +2571,7 @@ static int exfat_symlink(struct inode *dir, struct dentry *dentry,
 			err = -EINVAL;
 		else if (err == FFS_FILEEXIST)
 			err = -EEXIST;
-		else if (err == FFS_FULL)
+		else if (err == -ENOSPC)
 			err = -ENOSPC;
 		else
 			err = -EIO;
@@ -2583,7 +2583,7 @@ static int exfat_symlink(struct inode *dir, struct dentry *dentry,
 	if (err) {
 		ffsRemoveFile(dir, &fid);
 
-		if (err == FFS_FULL)
+		if (err == -ENOSPC)
 			err = -ENOSPC;
 		else
 			err = -EIO;
@@ -2641,7 +2641,7 @@ static int exfat_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 			err = -EINVAL;
 		else if (err == FFS_FILEEXIST)
 			err = -EEXIST;
-		else if (err == FFS_FULL)
+		else if (err == -ENOSPC)
 			err = -ENOSPC;
 		else if (err == FFS_NAMETOOLONG)
 			err = -ENAMETOOLONG;
@@ -2754,7 +2754,7 @@ static int exfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 			err = -EEXIST;
 		else if (err == FFS_NOTFOUND)
 			err = -ENOENT;
-		else if (err == FFS_FULL)
+		else if (err == -ENOSPC)
 			err = -ENOSPC;
 		else
 			err = -EIO;
@@ -3109,7 +3109,7 @@ static int exfat_bmap(struct inode *inode, sector_t sector, sector_t *phys,
 	err = ffsMapCluster(inode, clu_offset, &cluster);
 
 	if (err) {
-		if (err == FFS_FULL)
+		if (err == -ENOSPC)
 			return -ENOSPC;
 		else
 			return -EIO;
-- 
2.23.0

