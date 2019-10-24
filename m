Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3758FCA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1855620684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409869AbfJXPyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:54:36 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:54488 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2409854AbfJXPyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:54:33 -0400
Received: from mr3.cc.vt.edu (mr3.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9OFsW2M026928
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:32 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9OFsRpB003935
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:32 -0400
Received: by mail-qk1-f200.google.com with SMTP id v143so23739400qka.21
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 08:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=CFX2Xv2E2XFYpCFGhPq9au3w9hrjHGnjTLte4Rd/YmA=;
        b=P1aaJEBttQaOLysl+1VVFN2Ap4yRNtPtd83qdhZWjDKTq6uLuOpKCqtRLnGsVq/Y8U
         ZA19zDCkK03mMsZfDE8aSQQpMUyR+bVOzOb4UxBqHdzKYvGAW3U8b8RhAoBhyBkEst2G
         t1hxGRFCLC6epDHK49xuBWR1YCOYbY/qCcPp3+3gJdYPyyxgYVx7GRHTdDImi3Z0Mn8Q
         jXZX3OdOyI2ez0TbmId7A2p0+g66O8N7QO5uMRPT9qErifS/nCiDHJtX1JrRFsR9CJsi
         Ttmq9IVUP0sZbdeIGn2GKldJaGGA21Ii2A8sa5EYRFJdknNUteYcPosZvsDjFZVlTp7/
         YCWA==
X-Gm-Message-State: APjAAAUpiM5VpHzyM2SmodEW6g8Z2PIQt6af7ffM7gxH4B8Izoae2FVG
        xJWADdD+6OxDxVImKFFOCaiZo2K6dslYVWxIAdNaWfe3cRLTJc9RH0VdGjrPPIg0VDiSsT4giT2
        3aOsarTw4xH0BSIjE1OEEkXIzcW9NSJGLC5U=
X-Received: by 2002:ac8:741a:: with SMTP id p26mr4892056qtq.143.1571932466666;
        Thu, 24 Oct 2019 08:54:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwdcgzw8DZoEnTBhImp4GLM2YUeJK+MhsCB366bACFRrmA0VURtroFgd+2o8FGC37yHNwzjPg==
X-Received: by 2002:ac8:741a:: with SMTP id p26mr4892026qtq.143.1571932466279;
        Thu, 24 Oct 2019 08:54:26 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id x133sm12693274qka.44.2019.10.24.08.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:54:25 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/15] staging: exfat: Clean up return codes - FFS_INVALIDPATH
Date:   Thu, 24 Oct 2019 11:53:18 -0400
Message-Id: <20191024155327.1095907-8-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert FFS_INVALIDPATH to -EINVAL

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h       |  1 -
 drivers/staging/exfat/exfat_core.c  | 10 +++++-----
 drivers/staging/exfat/exfat_super.c | 10 +++++-----
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index c56363652c5d..00e5e37100ce 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -214,7 +214,6 @@ static inline u16 get_row_index(u16 i)
 #define FFS_NOTMOUNTED          4
 #define FFS_ALIGNMENTERR        5
 #define FFS_SEMAPHOREERR        6
-#define FFS_INVALIDPATH         7
 #define FFS_INVALIDFID          8
 #define FFS_NOTOPENED           12
 #define FFS_MAXOPENED           13
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index ba5680123b0f..23c369fb98e5 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -2124,7 +2124,7 @@ s32 get_num_entries_and_dos_name(struct super_block *sb, struct chain_t *p_dir,
 
 	num_entries = p_fs->fs_func->calc_num_entries(p_uniname);
 	if (num_entries == 0)
-		return FFS_INVALIDPATH;
+		return -EINVAL;
 
 	if (p_fs->vol_type != EXFAT) {
 		nls_uniname_to_dosname(sb, p_dosname, p_uniname, &lossy);
@@ -2136,7 +2136,7 @@ s32 get_num_entries_and_dos_name(struct super_block *sb, struct chain_t *p_dir,
 		} else {
 			for (r = reserved_names; *r; r++) {
 				if (!strncmp((void *)p_dosname->name, *r, 8))
-					return FFS_INVALIDPATH;
+					return -EINVAL;
 			}
 
 			if (p_dosname->name_case != 0xFF)
@@ -2257,11 +2257,11 @@ s32 resolve_path(struct inode *inode, char *path, struct chain_t *p_dir,
 	struct file_id_t *fid = &(EXFAT_I(inode)->fid);
 
 	if (strscpy(name_buf, path, sizeof(name_buf)) < 0)
-		return FFS_INVALIDPATH;
+		return -EINVAL;
 
 	nls_cstring_to_uniname(sb, p_uniname, name_buf, &lossy);
 	if (lossy)
-		return FFS_INVALIDPATH;
+		return -EINVAL;
 
 	fid->size = i_size_read(inode);
 
@@ -2659,7 +2659,7 @@ s32 move_file(struct inode *inode, struct chain_t *p_olddir, s32 oldentry,
 	/* check if the source and target directory is the same */
 	if (fs_func->get_entry_type(epmov) == TYPE_DIR &&
 	    fs_func->get_entry_clu0(epmov) == p_newdir->dir)
-		return FFS_INVALIDPATH;
+		return -EINVAL;
 
 	buf_lock(sb, sector_mov);
 
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 2c294e238d7b..5b35e3683605 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -2356,7 +2356,7 @@ static int exfat_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 
 	err = ffsCreateFile(dir, (u8 *)dentry->d_name.name, FM_REGULAR, &fid);
 	if (err) {
-		if (err == FFS_INVALIDPATH)
+		if (err == -EINVAL)
 			err = -EINVAL;
 		else if (err == -EEXIST)
 			err = -EEXIST;
@@ -2567,7 +2567,7 @@ static int exfat_symlink(struct inode *dir, struct dentry *dentry,
 
 	err = ffsCreateFile(dir, (u8 *)dentry->d_name.name, FM_SYMLINK, &fid);
 	if (err) {
-		if (err == FFS_INVALIDPATH)
+		if (err == -EINVAL)
 			err = -EINVAL;
 		else if (err == -EEXIST)
 			err = -EEXIST;
@@ -2637,7 +2637,7 @@ static int exfat_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 
 	err = ffsCreateDir(dir, (u8 *)dentry->d_name.name, &fid);
 	if (err) {
-		if (err == FFS_INVALIDPATH)
+		if (err == -EINVAL)
 			err = -EINVAL;
 		else if (err == -EEXIST)
 			err = -EEXIST;
@@ -2691,7 +2691,7 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 
 	err = ffsRemoveDir(dir, &(EXFAT_I(inode)->fid));
 	if (err) {
-		if (err == FFS_INVALIDPATH)
+		if (err == -EINVAL)
 			err = -EINVAL;
 		else if (err == -EEXIST)
 			err = -ENOTEMPTY;
@@ -2748,7 +2748,7 @@ static int exfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 	if (err) {
 		if (err == -EPERM)
 			err = -EPERM;
-		else if (err == FFS_INVALIDPATH)
+		else if (err == -EINVAL)
 			err = -EINVAL;
 		else if (err == -EEXIST)
 			err = -EEXIST;
-- 
2.23.0

