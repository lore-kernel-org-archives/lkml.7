Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA24C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD15821835
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbf/w4wR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbfI2Owv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 10:52:51 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44764 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728755AbfI2Owu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 10:52:50 -0400
Received: by mail-ot1-f65.google.com with SMTP id 21so6176709otj.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 07:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TuQBzokrIQjU04hS9z9tpm+3owsaSXEdS+yrcXoFd0k=;
        b=nbf/w4wRM+AUHtVnX5T4/p8oS4rU/12e3IB5Booi+KHT1DHxPRxm49Uf2Es2keN5NL
         vNhZbqWu8s1lITAh7svneOEag91n1p77YSHe+nQ66K+FnRpY8ucQ0Hy9D6uS9BRcfxhI
         pbnhTNtGOmUcbtokTgGXy0vmfM6t4NliIWyEiwKiAL+TF/iwKQGe3ZAcOurdiS3pO5NT
         cfy30sApywr9+SMAu+ULSaLvgGuQoaWm40VC3KWboqS3tcwZaUKEv+CzvW82F8Dmyy0r
         xbxSmduSme/48raCnZknIamEwiHRQ3QCrhbH2pozpAaatUPHmW73hDxwvCkx8RVI33TU
         C5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TuQBzokrIQjU04hS9z9tpm+3owsaSXEdS+yrcXoFd0k=;
        b=qn/AV1MIFVb+qC/+t8jHOpA9KIkozXsEnAF3wyqyEoozDONDMEM8kTRq9vb3pehjxF
         Rr6+I48kj4l7rLkobG85S2FMwSAD5A+z8b+KSGTuJ3snZ7QPNXd6gJ8+NlVdRfaeJgjy
         BORevDYaewWGCqCpTDA2WfUq980G6YSaMzng4zaqp6iaSLD0+m2EDX6+f9VqLjrbaEAi
         OxFZVi5CRvB+KcpYtXP5CisfWz/eHN0PZmVRe9zdEjLN/L+g7T9+KJZPvF/Aai1DDNhm
         1wp0o3k4ncGO0gvvgR+xWksWeirZY6BZmba6TPIJNRZASlOBch7fsTpA4Qc08NHEJjHI
         hkIg==
X-Gm-Message-State: APjAAAW5Y7YaiLLe3IgX7aJ5MiEgFtP6O/jwEdkMUMqz5jUTSPbSJfAV
        KvxuVCu+5r5vKa7ATVrBRks=
X-Google-Smtp-Source: APXvYqyXqq/uFbrm4KBpZZUbvFWrHm0lufOMPPXQ/0zyWXyjsLS8BJjqtwdz4q/8SOuwo6iu9EVVwg==
X-Received: by 2002:a9d:6e8f:: with SMTP id a15mr10528237otr.306.1569768769422;
        Sun, 29 Sep 2019 07:52:49 -0700 (PDT)
Received: from localhost (ip72-210-101-152.tu.ok.cox.net. [72.210.101.152])
        by smtp.gmail.com with ESMTPSA id h32sm2927106otb.46.2019.09.29.07.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 07:52:49 -0700 (PDT)
From:   Jesse Barton <jessebarton95@gmail.com>
To:     valdis.kletnieks@vt.edu
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Jesse Barton <jessebarton95@gmail.com>
Subject: [PATCH 3/3] Staging: exfat: exfat_super.c Fixed coding style issues.
Date:   Sun, 29 Sep 2019 09:52:45 -0500
Message-Id: <20190929145245.38816-1-jessebarton95@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed function argument wrapping to new line.


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

