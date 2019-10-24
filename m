Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51030CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E36720684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409856AbfJXPyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:54:33 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:54450 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2409841AbfJXPy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:54:28 -0400
Received: from mr1.cc.vt.edu (mr1.cc.vt.edu [IPv6:2607:b400:92:8300:0:31:1732:8aa4])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9OFsRoR026872
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:27 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9OFsLud023262
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:26 -0400
Received: by mail-qk1-f199.google.com with SMTP id x186so23865950qke.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 08:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=y2kqeSz6fnHPq1JqCLRz1dPQKvUyqY/VKk0ymtbQ1zc=;
        b=oBY08cecn7vC0AmdJBjg6nXWu5VGmZypiOdJClGBA5RvTmNipEF66BIyojh1G6bss2
         5bOgjUjPG6NcYCMzqq6fZbhvrchYZ4SFgPPlNgJveSLrve1kgGepP5gGCYkKb4CdT9Ce
         Z/KL7/Nzya12R3duyWYdB7JuteuwL8r9fvD+QjlmvGWb48rp+ey+Qhi0NhcY9yiOFdPD
         1BCcYlqzPUnyWnlZXww6sJbttD/a60sgnakWwvxz1ljnhfCvWoxDx4RRVIwvVpo9Xo4A
         9xOoO0SYASz2NEYxuOHdyNqjwyVCjsn/0YIF0W7lPY3FWNQhlT9bwjVQrtbscNezTGmi
         yEAQ==
X-Gm-Message-State: APjAAAVmXHhnaso6W9GWm5dB08/8DYfCSAAi7VX1qKMX60IcduUfxURR
        Ko5xVXgYX3nbg4p2/JydE0trMBS8X/kgn1svDdwocvnCmfpcZBjo+h4UobYwDUZWljXHapbrQ1w
        9hbsB7onYZGZFI7jDKJuGdcVMFPOOkhzO8Js=
X-Received: by 2002:ac8:237b:: with SMTP id b56mr5044135qtb.264.1571932461742;
        Thu, 24 Oct 2019 08:54:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyYVSakr7YLSim5uj/9sHAYIeDosKyPSoG0JshER6gQZYAXIyY/PLR8t9YrUZsYttao5idbKQ==
X-Received: by 2002:ac8:237b:: with SMTP id b56mr5044105qtb.264.1571932461413;
        Thu, 24 Oct 2019 08:54:21 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id x133sm12693274qka.44.2019.10.24.08.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:54:20 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/15] staging: exfat: Clean up return codes - FFS_FILEEXIST
Date:   Thu, 24 Oct 2019 11:53:17 -0400
Message-Id: <20191024155327.1095907-7-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert FFS_FILEEXIST to -EEXIST

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h       |  1 -
 drivers/staging/exfat/exfat_core.c  |  2 +-
 drivers/staging/exfat/exfat_super.c | 14 +++++++-------
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index a2b865788697..c56363652c5d 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -216,7 +216,6 @@ static inline u16 get_row_index(u16 i)
 #define FFS_SEMAPHOREERR        6
 #define FFS_INVALIDPATH         7
 #define FFS_INVALIDFID          8
-#define FFS_FILEEXIST           10
 #define FFS_NOTOPENED           12
 #define FFS_MAXOPENED           13
 #define FFS_EOF                 15
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index af1ccd686e01..ba5680123b0f 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -2103,7 +2103,7 @@ static s32 fat_generate_dos_name(struct super_block *sb, struct chain_t *p_dir,
 	}
 
 	if ((count == 0) || (count >= 1024))
-		return FFS_FILEEXIST;
+		return -EEXIST;
 	fat_attach_count_to_dos_name(p_dosname->name, count);
 
 	/* Now dos_name has DOS~????.EXT */
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index eb3c3642abca..2c294e238d7b 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -1288,7 +1288,7 @@ static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
 			new_clu.flags = new_fid->flags;
 
 			if (!is_dir_empty(sb, &new_clu)) {
-				ret = FFS_FILEEXIST;
+				ret = -EEXIST;
 				goto out;
 			}
 		}
@@ -2156,7 +2156,7 @@ static int ffsRemoveDir(struct inode *inode, struct file_id_t *fid)
 	clu_to_free.flags = fid->flags;
 
 	if (!is_dir_empty(sb, &clu_to_free)) {
-		ret = FFS_FILEEXIST;
+		ret = -EEXIST;
 		goto out;
 	}
 
@@ -2358,7 +2358,7 @@ static int exfat_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	if (err) {
 		if (err == FFS_INVALIDPATH)
 			err = -EINVAL;
-		else if (err == FFS_FILEEXIST)
+		else if (err == -EEXIST)
 			err = -EEXIST;
 		else if (err == -ENOSPC)
 			err = -ENOSPC;
@@ -2569,7 +2569,7 @@ static int exfat_symlink(struct inode *dir, struct dentry *dentry,
 	if (err) {
 		if (err == FFS_INVALIDPATH)
 			err = -EINVAL;
-		else if (err == FFS_FILEEXIST)
+		else if (err == -EEXIST)
 			err = -EEXIST;
 		else if (err == -ENOSPC)
 			err = -ENOSPC;
@@ -2639,7 +2639,7 @@ static int exfat_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	if (err) {
 		if (err == FFS_INVALIDPATH)
 			err = -EINVAL;
-		else if (err == FFS_FILEEXIST)
+		else if (err == -EEXIST)
 			err = -EEXIST;
 		else if (err == -ENOSPC)
 			err = -ENOSPC;
@@ -2693,7 +2693,7 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 	if (err) {
 		if (err == FFS_INVALIDPATH)
 			err = -EINVAL;
-		else if (err == FFS_FILEEXIST)
+		else if (err == -EEXIST)
 			err = -ENOTEMPTY;
 		else if (err == -ENOENT)
 			err = -ENOENT;
@@ -2750,7 +2750,7 @@ static int exfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 			err = -EPERM;
 		else if (err == FFS_INVALIDPATH)
 			err = -EINVAL;
-		else if (err == FFS_FILEEXIST)
+		else if (err == -EEXIST)
 			err = -EEXIST;
 		else if (err == -ENOENT)
 			err = -ENOENT;
-- 
2.23.0

