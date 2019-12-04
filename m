Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89895C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586B22073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vvoOr97X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbfLDXqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 18:46:34 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:48276 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbfLDXqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 18:46:34 -0500
Received: by mail-pj1-f73.google.com with SMTP id o34so738748pjb.15
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 15:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=XbMDMBiURPy3ztmL5BAB2zOV5tyLvPs4cZrgza5Nb04=;
        b=vvoOr97XSjgqRQXRYI8xsRGNB6sMUmPJTH35AVLEBHzUCUIf4TKeH576HHqX2DdT0w
         DhkNeyy0KVEz2UHvNOJCElCM2pXaipK4dATie/v1T8VW/ccwD1N0GFTfowS08R32R1SI
         +apUVj/M3+8f8mDGLFFC94QGu82UmZUQrHi0cMEPAnZ9V/l7nxaNUos7BqQ8bONSu77b
         elzOYuGfWpDdmLcLjbijtSEn/4qf5nzJdt1AFxRQsf3rOyD09xoS07pye9fewtGQ/USy
         M9kZ2gfcTq7zc9Bwb/bv3Z0+6u7faqvqCb6Zr0iadYYGSy5kwc/GvSJ90Btej1GZgtnk
         2m1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=XbMDMBiURPy3ztmL5BAB2zOV5tyLvPs4cZrgza5Nb04=;
        b=akovUNlmvNseieFnuF5AITZ760cVt4LvdmfCxomYHOhbXD3lGuombZPEe+zSL9/K+s
         14D8k64IiD9yct4Xc2ufSwnbM/21yf/z9X5v+AUZ40YLTPCJyenXNERdqq3M4eiw5AbS
         3vZnSibekVf7nSL0b23y6Wn7Ax2V1ouRUMmzvJAkH3pe7Dc3DUauk2GSLmHPQ62GetOD
         tH56Ua6bIVdcpe0lSVVhwu05FeD05Xlf5DoymINIPXL97i1hetVQPAnOdawn9eo6byBy
         XxaiiiCAaWKM9SoezHCzCEjANFz2bchLu+JQa/2Vmw70As24Hzyiq9R7UudFYRorKiMJ
         eYaw==
X-Gm-Message-State: APjAAAXi9/wI9gFlu5H5LKhg0PEt/NPalIof3r61wUcgnGEb5JWVPAUT
        4gbaaqYeVYjuZNTTHvknJu88e9RjWii7SP1QMEuYpQ==
X-Google-Smtp-Source: APXvYqz47avrpcjXVQ+1KDiyygY87m+93a0IsuajGxXEGgl8sxMDZj0iTIaMcFs25SnHdkR0uy27q47QcmEbuf3o5rKViw==
X-Received: by 2002:a65:56c9:: with SMTP id w9mr6061182pgs.296.1575503193275;
 Wed, 04 Dec 2019 15:46:33 -0800 (PST)
Date:   Wed,  4 Dec 2019 15:45:22 -0800
Message-Id: <20191204234522.42855-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v1] staging: exfat: fix multiple definition error of `rename_file'
From:   Brendan Higgins <brendanhiggins@google.com>
To:     valdis.kletnieks@vt.edu
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, davidgow@google.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`rename_file' was exported but not properly namespaced causing a
multiple definition error because `rename_file' is already defined in
fs/hostfs/hostfs_user.c:

ld: drivers/staging/exfat/exfat_core.o: in function `rename_file':
drivers/staging/exfat/exfat_core.c:2327: multiple definition of
`rename_file'; fs/hostfs/hostfs_user.o:fs/hostfs/hostfs_user.c:350:
first defined here
make: *** [Makefile:1077: vmlinux] Error 1

This error can be reproduced on ARCH=um by selecting:

CONFIG_EXFAT_FS=y
CONFIG_HOSTFS=y

Add a namespace prefix exfat_* to fix this error.

Reported-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Cc: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/exfat/exfat.h       | 4 ++--
 drivers/staging/exfat/exfat_core.c  | 4 ++--
 drivers/staging/exfat/exfat_super.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 2aac1e000977e..51c665a924b76 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -805,8 +805,8 @@ s32 create_dir(struct inode *inode, struct chain_t *p_dir,
 s32 create_file(struct inode *inode, struct chain_t *p_dir,
 		struct uni_name_t *p_uniname, u8 mode, struct file_id_t *fid);
 void remove_file(struct inode *inode, struct chain_t *p_dir, s32 entry);
-s32 rename_file(struct inode *inode, struct chain_t *p_dir, s32 old_entry,
-		struct uni_name_t *p_uniname, struct file_id_t *fid);
+s32 exfat_rename_file(struct inode *inode, struct chain_t *p_dir, s32 old_entry,
+		      struct uni_name_t *p_uniname, struct file_id_t *fid);
 s32 move_file(struct inode *inode, struct chain_t *p_olddir, s32 oldentry,
 	      struct chain_t *p_newdir, struct uni_name_t *p_uniname,
 	      struct file_id_t *fid);
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index d2d3447083c7b..7017e22b0f7a8 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -2322,8 +2322,8 @@ void remove_file(struct inode *inode, struct chain_t *p_dir, s32 entry)
 	fs_func->delete_dir_entry(sb, p_dir, entry, 0, num_entries);
 }
 
-s32 rename_file(struct inode *inode, struct chain_t *p_dir, s32 oldentry,
-		struct uni_name_t *p_uniname, struct file_id_t *fid)
+s32 exfat_rename_file(struct inode *inode, struct chain_t *p_dir, s32 oldentry,
+		      struct uni_name_t *p_uniname, struct file_id_t *fid)
 {
 	s32 ret, newentry = -1, num_old_entries, num_new_entries;
 	sector_t sector_old, sector_new;
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 6e481908c59f6..9f91853b189b0 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -1262,8 +1262,8 @@ static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
 	fs_set_vol_flags(sb, VOL_DIRTY);
 
 	if (olddir.dir == newdir.dir)
-		ret = rename_file(new_parent_inode, &olddir, dentry, &uni_name,
-				  fid);
+		ret = exfat_rename_file(new_parent_inode, &olddir, dentry,
+					&uni_name, fid);
 	else
 		ret = move_file(new_parent_inode, &olddir, dentry, &newdir,
 				&uni_name, fid);
-- 
2.24.0.393.g34dc348eaf-goog

