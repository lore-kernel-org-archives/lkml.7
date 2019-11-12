Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41958C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 02:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17851206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 02:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfKLCLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 21:11:01 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:48048 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727093AbfKLCK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 21:10:58 -0500
Received: from mr4.cc.vt.edu (inbound.smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xAC2AvAF011562
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 21:10:57 -0500
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xAC2AqJA016276
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 21:10:57 -0500
Received: by mail-qt1-f200.google.com with SMTP id l8so19151992qtq.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 18:10:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mKMDzYn7O8CzU1QL2MbSfadNjjAv2gJEQl4nRG3tJ/I=;
        b=pyQm611oToc0/McjTgwRufhA4QSNrXAnRIG2aKfY+azkp4ndj0N9iIaw+NJsqPSzmp
         5xpf/hsaIhXrQYKz5WMUxSneFoNPwneiKgqxrhUndKFH0pkZHIKwa4/v3TjASRQtHNNF
         eGoIcO9QIXg/Mq21FLr4SbOsAbHUBqpozzKDpXEEAiOFB0zWCHwl8kx9VFOxC1m0ZK9j
         yeHQUipOdt3v2W7515GHHRVfKOMDQl6CK2C4C17L1BSfX4IqDhOptUdSwqChqCyI1l6h
         5ry0WFgbYrSep30HB+UivNj6PRImDCn40hT/0+klR2ivys0XyWGq3us2TG8Sjh5M+9V/
         +m8Q==
X-Gm-Message-State: APjAAAUnExXymuCG6v0tri3N9uxKGsX7fLzwho/r3v8UY6PVPOoUdhzA
        2SpaT/IhALMaDWZOe3X1ugvhh5grIVXInFTPhXInvVHLxnihWtYnHCy/zesKRFGa5hZlh8+plXC
        wiR1jLHFUUsu5G7Fk3zrfOK9mTBV0gOl/FDk=
X-Received: by 2002:ae9:ef0a:: with SMTP id d10mr12907171qkg.262.1573524651815;
        Mon, 11 Nov 2019 18:10:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqzBCHnK5zn+Y3sfl5pBsECOdz/SspzS/RWeqUG1JiE5JC74y8qvdBI3OPJ3biaNwpctsllt/w==
X-Received: by 2002:ae9:ef0a:: with SMTP id d10mr12907161qkg.262.1573524651460;
        Mon, 11 Nov 2019 18:10:51 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id o195sm8004767qke.35.2019.11.11.18.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 18:10:50 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     gregkh@linuxfoundation.org
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/9] staging: exfat: Collapse redundant return code translations
Date:   Mon, 11 Nov 2019 21:09:56 -0500
Message-Id: <20191112021000.42091-9-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112021000.42091-1-Valdis.Kletnieks@vt.edu>
References: <20191112021000.42091-1-Valdis.Kletnieks@vt.edu>
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
2.24.0

