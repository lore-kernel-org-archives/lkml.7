Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE26C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 00:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4138214AE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 00:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rkkWX21c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfI2AVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 20:21:37 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39567 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbfI2AVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 20:21:36 -0400
Received: by mail-ot1-f66.google.com with SMTP id s22so5407490otr.6
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2019 17:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GqKNHe2wxsr8Qfpq+KczXDkRcW1icZtTDLdjOK6prOA=;
        b=rkkWX21c/g/bofwKmv/UhUhH+4tZu8Krt+PvQUQ937ByXHDcCrQQqzYm+2m17mmTDO
         9JgJHnDp3lHz52uEu1yPv5T0/rsug6ziYxcQUcs4668QGfFcmqipxjP2nu5lTdx7Bjie
         cZuJe0f8sJf8OVE4d5u+NLixduE7Ojodl/MWxKAc6YDxKAaADTH+b5mtE5X+dccxLSVa
         3cKaFVWs+RWS7VVn7/PzVPYpa6pkfVj8wV1j0r0wcW+uOTBa0PeuouXrtJaHxKslK12P
         WuBkLJqbAQfQovjWRc0C37od7hhZELCes6S5ximmORHIKk3ktFQZQ2XOHtmyS++A4xRK
         98Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GqKNHe2wxsr8Qfpq+KczXDkRcW1icZtTDLdjOK6prOA=;
        b=kXKDz+sa7eSqZLh1oYHravoZO7zrSIk8WglYzSHbwVjK0agMN3HDmdt8qlUWHBgo+x
         av2k20Jvm95M/mWL1CwQeLYkA5P9bHSSUqHtgyrj//SH6CpQB7VzMoHei0XmAH4PYMi4
         bJfYjqfGGWKh5RD7GEpyqTijcABeGt/To99j6td2dmDAd1425MQARB6kECrXk+lwGmip
         l4LH0bWoTvtfpZvHXDuQaGqAMjClwhaQq0cHFyguGZnmXZHEAaSI3JmGOXMG9YPt4lX9
         3kPBCIblfuUCWyku0awilvkZSS/SiUXNPSa0Fhmr86R70lYNMUXre1dDJIY+JcLzjGmW
         UvsQ==
X-Gm-Message-State: APjAAAW3rhFC0ATvBxMU2r0JHfOz/WL1kPRa6WAoTSqE7vl4DrFdl2+m
        C6qNbQo1KW5M3HWDg7Tkv48=
X-Google-Smtp-Source: APXvYqzunT2cgNroASE9kGPGmeQRn8lHIBqVUI7AU2JDZ3gtrWVijQBqi/73fwX9AwkS6dmTcFveAw==
X-Received: by 2002:a05:6830:1617:: with SMTP id g23mr8417269otr.366.1569716495534;
        Sat, 28 Sep 2019 17:21:35 -0700 (PDT)
Received: from localhost (ip72-210-101-152.tu.ok.cox.net. [72.210.101.152])
        by smtp.gmail.com with ESMTPSA id 8sm2503637oti.41.2019.09.28.17.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2019 17:21:35 -0700 (PDT)
From:   Jesse Barton <jessebarton95@gmail.com>
To:     valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Jesse Barton <jessebarton95@gmail.com>
Subject: [PATCH 3/3] Staging: exfat: exfat_super.c Fixed coding style issues.
Date:   Sat, 28 Sep 2019 19:21:19 -0500
Message-Id: <20190929002119.20689-1-jessebarton95@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed Coding Style issues

Signed-off-by: Jesse Barton <jessebarton95@gmail.com>
---
 drivers/staging/exfat/exfat_super.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 3c7e2b7c2195..b9656ec06144 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -640,8 +640,7 @@ static int ffs_lookup_file(struct inode *inode, char *path, struct file_id_t *fi
 	return ret;
 }
 
-static int ffs_create_file(struct inode *inode, char *path, u8 mode,
-			 struct file_id_t *fid)
+static int ffs_create_file(struct inode *inode, char *path, u8 mode, struct file_id_t *fid)
 {
 	struct chain_t dir;
 	struct uni_name_t uni_name;
@@ -681,8 +680,7 @@ static int ffs_create_file(struct inode *inode, char *path, u8 mode,
 	return ret;
 }
 
-static int ffs_read_file(struct inode *inode, struct file_id_t *fid, void *buffer,
-		       u64 count, u64 *rcount)
+static int ffs_read_file(struct inode *inode, struct file_id_t *fid, void *buffer, u64 count, u64 *rcount)
 {
 	s32 offset, sec_offset, clu_offset;
 	u32 clu;
@@ -805,8 +803,7 @@ static int ffs_read_file(struct inode *inode, struct file_id_t *fid, void *buffe
 	return ret;
 }
 
-static int ffs_write_file(struct inode *inode, struct file_id_t *fid,
-			void *buffer, u64 count, u64 *wcount)
+static int ffs_write_file(struct inode *inode, struct file_id_t *fid, void *buffer, u64 count, u64 *wcount)
 {
 	bool modified = false;
 	s32 offset, sec_offset, clu_offset;
@@ -1212,8 +1209,7 @@ static void update_parent_info(struct file_id_t *fid,
 	}
 }
 
-static int ffs_move_file(struct inode *old_parent_inode, struct file_id_t *fid,
-		       struct inode *new_parent_inode, struct dentry *new_dentry)
+static int ffs_move_file(struct inode *old_parent_inode, struct file_id_t *fid, struct inode *new_parent_inode, struct dentry *new_dentry)
 {
 	s32 ret;
 	s32 dentry;
@@ -2061,9 +2057,7 @@ static int ffs_read_dir(struct inode *inode, struct dir_entry_t *dir_entry)
 			fs_func->get_uni_name_from_ext_entry(sb, &dir, dentry,
 							     uni_name.name);
 			if (*uni_name.name == 0x0 && p_fs->vol_type != EXFAT)
-				get_uni_name_from_dos_entry(sb,
-						(struct dos_dentry_t *)ep,
-						&uni_name, 0x1);
+				get_uni_name_from_dos_entry(sb, (struct dos_dentry_t *)ep, &uni_name, 0x1);
 			nls_uniname_to_cstring(sb, dir_entry->Name, &uni_name);
 			buf_unlock(sb, sector);
 
@@ -2074,11 +2068,8 @@ static int ffs_read_dir(struct inode *inode, struct dir_entry_t *dir_entry)
 					goto out;
 				}
 			} else {
-				get_uni_name_from_dos_entry(sb,
-						(struct dos_dentry_t *)ep,
-						&uni_name, 0x0);
-				nls_uniname_to_cstring(sb, dir_entry->ShortName,
-						       &uni_name);
+				get_uni_name_from_dos_entry(sb, (struct dos_dentry_t *)ep, &uni_name, 0x0);
+				nls_uniname_to_cstring(sb, dir_entry->ShortName, &uni_name);
 			}
 
 			dir_entry->Size = fs_func->get_entry_size(ep);
@@ -2460,8 +2451,7 @@ static struct dentry *exfat_lookup(struct inode *dir, struct dentry *dentry,
 			err = -ENOMEM;
 			goto error;
 		}
-		ffs_read_file(dir, &fid, EXFAT_I(inode)->target,
-			    i_size_read(inode), &ret);
+		ffs_read_file(dir, &fid, EXFAT_I(inode)->target, i_size_read(inode), &ret);
 		*(EXFAT_I(inode)->target + i_size_read(inode)) = '\0';
 	}
 
@@ -2748,8 +2738,7 @@ static int exfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	EXFAT_I(old_inode)->fid.size = i_size_read(old_inode);
 
-	err = ffs_move_file(old_dir, &(EXFAT_I(old_inode)->fid), new_dir,
-			  new_dentry);
+	err = ffs_move_file(old_dir, &(EXFAT_I(old_inode)->fid), new_dir, new_dentry);
 	if (err) {
 		if (err == FFS_PERMISSIONERR)
 			err = -EPERM;
-- 
2.23.0

