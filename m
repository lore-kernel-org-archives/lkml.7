Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F48CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE0D21A4C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503427AbfJXPzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:55:03 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:43148 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2503416AbfJXPzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:55:01 -0400
Received: from mr5.cc.vt.edu (mr5.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:72:232:758b])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9OFt0gg010631
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 11:55:00 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9OFst6Y008914
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 11:55:00 -0400
Received: by mail-qt1-f200.google.com with SMTP id 44so18986362qtu.20
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 08:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mKYQgkdrOcxaJG1/I+xHruVK3kJltVz/Dfh6PTgio0A=;
        b=QIewAGIt/Os2n8Lou98gm37g5myCIfziRt7ZsLl4dl2Te2Rij2KcbdayXPFGW/YxS2
         ZB33/QOwYB5VUs+E8zxo5j6WK3nmNqGD0MT9orzRgOvAfoF9trZiT+fx0f2iADj+xS7d
         Wkqz4E34VuLifijGJtcvor2ttH6qqyCiAbJMKKKybHZywnpIgLp5FCg+kl6DOrCnOV4Z
         IM1k3ShHcnTqQFn9DVbhjugx8nsn1GLeDR0mr+7+d7WhO4GtOliMg+Ga3M5YN3+7vLEh
         9e6uPIfZ1VubcQtJhqPBiclCOCiJqq6EWfpSgza00UnYoWwJYq2xzk/DDOuJ0owhuVTO
         ymDw==
X-Gm-Message-State: APjAAAVbYRA72z4qYCbfZFXS5+JTjUhv0gQwexJRL0cHjm5cWQv8qSv6
        sg3e1s+VG8TUdfBzOSTaZqL37/2uVbCsZpCf4A7fstGDalXc2Inl/cW1daCfBMso0alcrztGTJ6
        6Z9m7qg2ASSfe2Q8LiqsHIMBCLk8KqqTRGm8=
X-Received: by 2002:a05:620a:a11:: with SMTP id i17mr4327945qka.8.1571932495489;
        Thu, 24 Oct 2019 08:54:55 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyBrVaIJteJcQXxhFIlm9h7aiHD0cqlxngappG//fbG0T2zTue8017dAvBplJWZQtda/eD7SA==
X-Received: by 2002:a05:620a:a11:: with SMTP id i17mr4327910qka.8.1571932495088;
        Thu, 24 Oct 2019 08:54:55 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id x133sm12693274qka.44.2019.10.24.08.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:54:53 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/15] staging: exfat: Clean up return codes - FFS_ERROR
Date:   Thu, 24 Oct 2019 11:53:24 -0400
Message-Id: <20191024155327.1095907-14-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert FFS_ERROR to -EINVAL

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h       |  1 -
 drivers/staging/exfat/exfat_core.c  |  8 ++++----
 drivers/staging/exfat/exfat_super.c | 20 ++++++++++----------
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 505751bf1817..2ca2710601ae 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -216,7 +216,6 @@ static inline u16 get_row_index(u16 i)
 #define FFS_SEMAPHOREERR        6
 #define FFS_NOTOPENED           12
 #define FFS_MAXOPENED           13
-#define FFS_ERROR               19
 
 #define NUM_UPCASE              2918
 
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 7e637a8e19d3..7efc5d08cada 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -587,7 +587,7 @@ void exfat_chain_cont_cluster(struct super_block *sb, u32 chain, s32 len)
 static s32 __load_upcase_table(struct super_block *sb, sector_t sector,
 			       u32 num_sectors, u32 utbl_checksum)
 {
-	int i, ret = FFS_ERROR;
+	int i, ret = -EINVAL;
 	u32 j;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
@@ -662,7 +662,7 @@ static s32 __load_upcase_table(struct super_block *sb, sector_t sector,
 			brelse(tmp_bh);
 		return FFS_SUCCESS;
 	}
-	ret = FFS_ERROR;
+	ret = -EINVAL;
 error:
 	if (tmp_bh)
 		brelse(tmp_bh);
@@ -672,7 +672,7 @@ static s32 __load_upcase_table(struct super_block *sb, sector_t sector,
 
 static s32 __load_default_upcase_table(struct super_block *sb)
 {
-	int i, ret = FFS_ERROR;
+	int i, ret = -EINVAL;
 	u32 j;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 
@@ -847,7 +847,7 @@ static s32 __write_partial_entries_in_entry_set(struct super_block *sb,
 	return FFS_SUCCESS;
 err_out:
 	pr_debug("%s failed\n", __func__);
-	return FFS_ERROR;
+	return -EINVAL;
 }
 
 /* write back all entries in entry set */
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 485297974ae7..0ce27a6babee 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -492,7 +492,7 @@ static int ffsGetVolInfo(struct super_block *sb, struct vol_info_t *info)
 
 	/* check the validity of pointer parameters */
 	if (!info)
-		return FFS_ERROR;
+		return -EINVAL;
 
 	/* acquire the lock for file system critical section */
 	down(&p_fs->v_sem);
@@ -555,7 +555,7 @@ static int ffsLookupFile(struct inode *inode, char *path, struct file_id_t *fid)
 
 	/* check the validity of pointer parameters */
 	if (!fid || !path || (*path == '\0'))
-		return FFS_ERROR;
+		return -EINVAL;
 
 	/* acquire the lock for file system critical section */
 	down(&p_fs->v_sem);
@@ -648,7 +648,7 @@ static int ffsCreateFile(struct inode *inode, char *path, u8 mode,
 
 	/* check the validity of pointer parameters */
 	if (!fid || !path || (*path == '\0'))
-		return FFS_ERROR;
+		return -EINVAL;
 
 	/* acquire the lock for file system critical section */
 	down(&p_fs->v_sem);
@@ -697,7 +697,7 @@ static int ffsReadFile(struct inode *inode, struct file_id_t *fid, void *buffer,
 
 	/* check the validity of pointer parameters */
 	if (!buffer)
-		return FFS_ERROR;
+		return -EINVAL;
 
 	/* acquire the lock for file system critical section */
 	down(&p_fs->v_sem);
@@ -827,7 +827,7 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 
 	/* check the validity of pointer parameters */
 	if (!buffer)
-		return FFS_ERROR;
+		return -EINVAL;
 
 	/* acquire the lock for file system critical section */
 	down(&p_fs->v_sem);
@@ -1232,7 +1232,7 @@ static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
 
 	/* check the validity of pointer parameters */
 	if (!new_path || (*new_path == '\0'))
-		return FFS_ERROR;
+		return -EINVAL;
 
 	/* acquire the lock for file system critical section */
 	down(&p_fs->v_sem);
@@ -1455,7 +1455,7 @@ static int ffsSetAttr(struct inode *inode, u32 attr)
 		if (p_fs->dev_ejected)
 			ret = -EIO;
 		else
-			ret = FFS_ERROR;
+			ret = -EINVAL;
 
 		if (p_fs->vol_type == EXFAT)
 			release_entry_set(es);
@@ -1747,7 +1747,7 @@ static int ffsMapCluster(struct inode *inode, s32 clu_offset, u32 *clu)
 
 	/* check the validity of pointer parameters */
 	if (!clu)
-		return FFS_ERROR;
+		return -EINVAL;
 
 	/* acquire the lock for file system critical section */
 	down(&p_fs->v_sem);
@@ -1899,7 +1899,7 @@ static int ffsCreateDir(struct inode *inode, char *path, struct file_id_t *fid)
 
 	/* check the validity of pointer parameters */
 	if (!fid || !path || (*path == '\0'))
-		return FFS_ERROR;
+		return -EINVAL;
 
 	/* acquire the lock for file system critical section */
 	down(&p_fs->v_sem);
@@ -1945,7 +1945,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 
 	/* check the validity of pointer parameters */
 	if (!dir_entry)
-		return FFS_ERROR;
+		return -EINVAL;
 
 	/* check if the given file ID is opened */
 	if (fid->type != TYPE_DIR)
-- 
2.23.0

