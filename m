Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB899C10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD800207FF
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbfJBTQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 15:16:34 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:57406 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726669AbfJBTQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 15:16:33 -0400
Received: from mr5.cc.vt.edu (inbound.smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x92JGWXl025353
        for <linux-kernel@vger.kernel.org>; Wed, 2 Oct 2019 15:16:32 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x92JGRP0003524
        for <linux-kernel@vger.kernel.org>; Wed, 2 Oct 2019 15:16:32 -0400
Received: by mail-qt1-f200.google.com with SMTP id i10so314134qtq.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 12:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=4CMlpYrN8diNNsNoFQmvsP2oa4AEZl4aDzgp/marTlA=;
        b=Z0RScsrzkLHvbbxWFZqxARpBYTQu8rF58SVFixSBz7L0O5yT9NCzBGiAr0Gv80vZZp
         YeUGCpfREmNA/b7uxx9XeeliYrrwIkLvuxwnJDzLaisi7+SEvjaFGjB9IvIH5p5eu7zZ
         fD6/XgGy+9DyS4YJIq1pCbgc+Tm4bXxVBxaIetGQtf1icx1t5aWamd1Wnf2cbRIFMlV+
         MPqWHtFmeUnoW3+AHqsK7XO/4Z0SbbDtwDmuAlXV7wKyh/c9g4S4JFsrV8n65cRJKu0+
         rciUCUobhEWoYYTdRMq3cMuVurWxg5RmzOG/desXfLfn2MqrElCDqEt33uKNcr6H1lsW
         RbMg==
X-Gm-Message-State: APjAAAXYPfXDQuq9S4OeQyd4hBDVTerdvHQaXtcchBtoOiW8KAiwOh87
        XcNEHzeJxS34qQp5pY0EbFkPyAIIWRnnWihajufFoDoykjhb+TNnrZFb7bv7jsTA1omBookc7EB
        44o8IGm4fRhhq1zFy5CkvVtgU8y88fLAYHUc=
X-Received: by 2002:ac8:2fe5:: with SMTP id m34mr5232175qta.224.1570043786640;
        Wed, 02 Oct 2019 12:16:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzkwVZPcXYKi4Jv+iqb5hMX6PYRd4iZbasi8to50k/E5HcZysC0giTxd9BhaVaFD5kjJAJPBw==
X-Received: by 2002:ac8:2fe5:: with SMTP id m34mr5232151qta.224.1570043786333;
        Wed, 02 Oct 2019 12:16:26 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::9ca])
        by smtp.gmail.com with ESMTPSA id p2sm56019qkk.60.2019.10.02.12.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 12:16:25 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     gregkh@linuxfoundation.org
cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/staging/exfat - fix fs_sync() calls.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Wed, 02 Oct 2019 15:16:24 -0400
Message-ID: <11092.1570043784@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The majority of them were totally backwards.  Change the logic
so that if DELAYED_SYNC *isn't* in the config, we actually flush to disk
before flagging the file system as clean.

That leaves two calls in the DELAYED_SYNC case.  More detailed
analysis is needed to make sure that's what's really needed, or if other
call sites also need a fs_sync() call.  This patch is at least "less wrong"
than the code was, but further changes should be another patch.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 5f6caee819a6..2526044569ee 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -458,7 +458,7 @@ static int ffsUmountVol(struct super_block *sb)
 	/* acquire the lock for file system critical section */
 	down(&p_fs->v_sem);
 
-	fs_sync(sb, false);
+	fs_sync(sb, true);
 	fs_set_vol_flags(sb, VOL_CLEAN);
 
 	if (p_fs->vol_type == EXFAT) {
@@ -666,8 +666,8 @@ static int ffsCreateFile(struct inode *inode, char *path, u8 mode,
 	/* create a new file */
 	ret = create_file(inode, &dir, &uni_name, mode, fid);
 
-#ifdef CONFIG_EXFAT_DELAYED_SYNC
-	fs_sync(sb, false);
+#ifndef CONFIG_EXFAT_DELAYED_SYNC
+	fs_sync(sb, true);
 	fs_set_vol_flags(sb, VOL_CLEAN);
 #endif
 
@@ -1039,8 +1039,8 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 		release_entry_set(es);
 	}
 
-#ifdef CONFIG_EXFAT_DELAYED_SYNC
-	fs_sync(sb, false);
+#ifndef CONFIG_EXFAT_DELAYED_SYNC
+	fs_sync(sb, true);
 	fs_set_vol_flags(sb, VOL_CLEAN);
 #endif
 
@@ -1179,8 +1179,8 @@ static int ffsTruncateFile(struct inode *inode, u64 old_size, u64 new_size)
 	if (fid->rwoffset > fid->size)
 		fid->rwoffset = fid->size;
 
-#ifdef CONFIG_EXFAT_DELAYED_SYNC
-	fs_sync(sb, false);
+#ifndef CONFIG_EXFAT_DELAYED_SYNC
+	fs_sync(sb, true);
 	fs_set_vol_flags(sb, VOL_CLEAN);
 #endif
 
@@ -1327,8 +1327,8 @@ static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
 						num_entries + 1);
 	}
 out:
-#ifdef CONFIG_EXFAT_DELAYED_SYNC
-	fs_sync(sb, false);
+#ifndef CONFIG_EXFAT_DELAYED_SYNC
+	fs_sync(sb, true);
 	fs_set_vol_flags(sb, VOL_CLEAN);
 #endif
 
@@ -1389,8 +1389,8 @@ static int ffsRemoveFile(struct inode *inode, struct file_id_t *fid)
 	fid->start_clu = CLUSTER_32(~0);
 	fid->flags = (p_fs->vol_type == EXFAT) ? 0x03 : 0x01;
 
-#ifdef CONFIG_EXFAT_DELAYED_SYNC
-	fs_sync(sb, false);
+#ifndef CONFIG_EXFAT_DELAYED_SYNC
+	fs_sync(sb, true);
 	fs_set_vol_flags(sb, VOL_CLEAN);
 #endif
 
@@ -1478,8 +1478,8 @@ static int ffsSetAttr(struct inode *inode, u32 attr)
 		release_entry_set(es);
 	}
 
-#ifdef CONFIG_EXFAT_DELAYED_SYNC
-	fs_sync(sb, false);
+#ifndef CONFIG_EXFAT_DELAYED_SYNC
+	fs_sync(sb, true);
 	fs_set_vol_flags(sb, VOL_CLEAN);
 #endif
 
@@ -1916,8 +1916,8 @@ static int ffsCreateDir(struct inode *inode, char *path, struct file_id_t *fid)
 
 	ret = create_dir(inode, &dir, &uni_name, fid);
 
-#ifdef CONFIG_EXFAT_DELAYED_SYNC
-	fs_sync(sb, false);
+#ifndef CONFIG_EXFAT_DELAYED_SYNC
+	fs_sync(sb, true);
 	fs_set_vol_flags(sb, VOL_CLEAN);
 #endif
 
@@ -2177,8 +2177,8 @@ static int ffsRemoveDir(struct inode *inode, struct file_id_t *fid)
 	fid->start_clu = CLUSTER_32(~0);
 	fid->flags = (p_fs->vol_type == EXFAT) ? 0x03 : 0x01;
 
-#ifdef CONFIG_EXFAT_DELAYED_SYNC
-	fs_sync(sb, false);
+#ifndef CONFIG_EXFAT_DELAYED_SYNC
+	fs_sync(sb, true);
 	fs_set_vol_flags(sb, VOL_CLEAN);
 #endif
 

