Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D50CA9EBB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E8921D7C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfKDBqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 20:46:38 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:39796 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729034AbfKDBqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 20:46:38 -0500
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xA41kavI025878
        for <linux-kernel@vger.kernel.org>; Sun, 3 Nov 2019 20:46:36 -0500
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xA41kVF2017933
        for <linux-kernel@vger.kernel.org>; Sun, 3 Nov 2019 20:46:36 -0500
Received: by mail-qt1-f198.google.com with SMTP id u26so17367913qtq.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 17:46:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=u019LskbZP8VabhKx0LyX0aafFHStxhhypj6hGUDhZI=;
        b=bAxUXcquZ7f5fxaGFNH6KHy1Ia1vB3hGXOUXrha6FTp135wJLGx4EjdnigNZVoTneq
         G/5mX/Dq/9YPUWiBkf8o7PrMxwdR4k/+4F1rmQlX62+Nge9BvF7ynLbdWBY6cQJA+zbM
         2wsgT2fmp0xzNcaairlc6U3/Nlhwc+GFkbpx6uarGhfgDFP49WETBK6oULugEfUOFky6
         KWBmas1sISli6K2f5uplvqqGTlZjrRzOSiNr76wv1VJ53xZxk4pm04AaBARSh2ipTS3f
         0lKWhUhzy6DdSc1qal4H0BQAwUu1ojWpSaHk8KZ439whHUj7VdSI9MEgRJmOmLRzyXXZ
         oMVQ==
X-Gm-Message-State: APjAAAVSpfphhLAmhTQt9V2Spoh1sEw8YLMvaTp2h+i6NPB8hoRFhItB
        S5/lyZ4siJqN2BRNMZ8ptzdiV11jwHjYKjEv+2R0kXuwBjTtXIxiw0MDAfAC+r6XszYASbykZZn
        nb+fWUi5VKgLpRiNMQVh1luZ9xS/tuWurYLA=
X-Received: by 2002:a05:620a:55c:: with SMTP id o28mr2946035qko.131.1572831991124;
        Sun, 03 Nov 2019 17:46:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqznKEGc1reQwrrCOPSY2doBOSCbE/tClL79ar8NfSr1UVzD6c1z7N4vRQ6vDpjYeS+IjtXGMg==
X-Received: by 2002:a05:620a:55c:: with SMTP id o28mr2946018qko.131.1572831990805;
        Sun, 03 Nov 2019 17:46:30 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id d2sm8195354qkg.77.2019.11.03.17.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 17:46:29 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/10] staging: exfat: Collapse redundant return code translations
Date:   Sun,  3 Nov 2019 20:45:04 -0500
Message-Id: <20191104014510.102356-9-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
References: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we no longer use odd internal return codes, we can
heave the translation code over the side, and just pass the
error code back up the call chain.

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat_super.c | 92 +++++------------------------
 1 file changed, 14 insertions(+), 78 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 5d538593b5f6..a97a61a60517 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -650,7 +650,7 @@ static int ffsCreateFile(struct inode *inode, char *path, u8 mode,
 	struct uni_name_t uni_name;
 	struct super_block *sb = inode->i_sb;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-	int ret;
+	int ret = 0;
 
 	/* check the validity of pointer parameters */
 	if (!fid || !path || (*path == '\0'))
@@ -2366,19 +2366,9 @@ static int exfat_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	pr_debug("%s entered\n", __func__);
 
 	err = ffsCreateFile(dir, (u8 *)dentry->d_name.name, FM_REGULAR, &fid);
-	if (err) {
-		if (err == -EINVAL)
-			err = -EINVAL;
-		else if (err == -EEXIST)
-			err = -EEXIST;
-		else if (err == -ENOSPC)
-			err = -ENOSPC;
-		else if (err == -ENAMETOOLONG)
-			err = -ENAMETOOLONG;
-		else
-			err = -EIO;
+	if (err)
 		goto out;
-	}
+
 	INC_IVERSION(dir);
 	curtime = current_time(dir);
 	dir->i_ctime = curtime;
@@ -2543,13 +2533,9 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 	EXFAT_I(inode)->fid.size = i_size_read(inode);
 
 	err = ffsRemoveFile(dir, &(EXFAT_I(inode)->fid));
-	if (err) {
-		if (err == -EPERM)
-			err = -EPERM;
-		else
-			err = -EIO;
+	if (err)
 		goto out;
-	}
+
 	INC_IVERSION(dir);
 	curtime = current_time(dir);
 	dir->i_mtime = curtime;
@@ -2589,27 +2575,14 @@ static int exfat_symlink(struct inode *dir, struct dentry *dentry,
 	pr_debug("%s entered\n", __func__);
 
 	err = ffsCreateFile(dir, (u8 *)dentry->d_name.name, FM_SYMLINK, &fid);
-	if (err) {
-		if (err == -EINVAL)
-			err = -EINVAL;
-		else if (err == -EEXIST)
-			err = -EEXIST;
-		else if (err == -ENOSPC)
-			err = -ENOSPC;
-		else
-			err = -EIO;
+	if (err)
 		goto out;
-	}
+
 
 	err = ffsWriteFile(dir, &fid, (char *)target, len, &ret);
 
 	if (err) {
 		ffsRemoveFile(dir, &fid);
-
-		if (err == -ENOSPC)
-			err = -ENOSPC;
-		else
-			err = -EIO;
 		goto out;
 	}
 
@@ -2666,19 +2639,9 @@ static int exfat_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	pr_debug("%s entered\n", __func__);
 
 	err = ffsCreateDir(dir, (u8 *)dentry->d_name.name, &fid);
-	if (err) {
-		if (err == -EINVAL)
-			err = -EINVAL;
-		else if (err == -EEXIST)
-			err = -EEXIST;
-		else if (err == -ENOSPC)
-			err = -ENOSPC;
-		else if (err == -ENAMETOOLONG)
-			err = -ENAMETOOLONG;
-		else
-			err = -EIO;
+	if (err)
 		goto out;
-	}
+
 	INC_IVERSION(dir);
 	curtime = current_time(dir);
 	dir->i_ctime = curtime;
@@ -2727,19 +2690,9 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 	EXFAT_I(inode)->fid.size = i_size_read(inode);
 
 	err = ffsRemoveDir(dir, &(EXFAT_I(inode)->fid));
-	if (err) {
-		if (err == -EINVAL)
-			err = -EINVAL;
-		else if (err == -EEXIST)
-			err = -ENOTEMPTY;
-		else if (err == -ENOENT)
-			err = -ENOENT;
-		else if (err == -EBUSY)
-			err = -EBUSY;
-		else
-			err = -EIO;
+	if (err)
 		goto out;
-	}
+
 	INC_IVERSION(dir);
 	curtime = current_time(dir);
 	dir->i_mtime = curtime;
@@ -2787,21 +2740,9 @@ static int exfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	err = ffsMoveFile(old_dir, &(EXFAT_I(old_inode)->fid), new_dir,
 			  new_dentry);
-	if (err) {
-		if (err == -EPERM)
-			err = -EPERM;
-		else if (err == -EINVAL)
-			err = -EINVAL;
-		else if (err == -EEXIST)
-			err = -EEXIST;
-		else if (err == -ENOENT)
-			err = -ENOENT;
-		else if (err == -ENOSPC)
-			err = -ENOSPC;
-		else
-			err = -EIO;
+	if (err)
 		goto out;
-	}
+
 	INC_IVERSION(new_dir);
 	curtime = current_time(new_dir);
 	new_dir->i_ctime = curtime;
@@ -3161,12 +3102,7 @@ static int exfat_bmap(struct inode *inode, sector_t sector, sector_t *phys,
 
 	err = ffsMapCluster(inode, clu_offset, &cluster);
 
-	if (err) {
-		if (err == -ENOSPC)
-			return -ENOSPC;
-		else
-			return -EIO;
-	} else if (cluster != CLUSTER_32(~0)) {
+	if (!err && (cluster != CLUSTER_32(~0))) {
 		*phys = START_SECTOR(cluster) + sec_offset;
 		*mapped_blocks = p_fs->sectors_per_clu - sec_offset;
 	}
-- 
2.24.0.rc1

