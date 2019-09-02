Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6895EC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 19:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FFD821883
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 19:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfIBTDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 15:03:53 -0400
Received: from valentin-vidic.from.hr ([94.229.67.141]:56565 "EHLO
        valentin-vidic.from.hr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfIBTDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 15:03:53 -0400
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id 65E2A3A32A; Mon,  2 Sep 2019 21:03:45 +0200 (CEST)
From:   Valentin Vidic <vvidic@valentin-vidic.from.hr>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>
Subject: [PATCH] staging: exfat: cleanup blank line warnings
Date:   Mon,  2 Sep 2019 21:03:29 +0200
Message-Id: <20190902190329.18685-1-vvidic@valentin-vidic.from.hr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch.pl warnings:

  CHECK: Please don't use multiple blank lines
  CHECK: Blank lines aren't necessary after an open brace '{'
  CHECK: Please use a blank line after function/struct/union/enum
         declarations

Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
---
 drivers/staging/exfat/exfat.h       | 1 +
 drivers/staging/exfat/exfat_core.c  | 4 ----
 drivers/staging/exfat/exfat_super.c | 1 -
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index bae180e10609..e41754bbdeab 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -170,6 +170,7 @@ static inline u16 get_col_index(u16 i)
 {
 	return i >> LOW_INDEX_BIT;
 }
+
 static inline u16 get_row_index(u16 i)
 {
 	return i & ~HIGH_INDEX_MASK;
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 9f76ca175c80..46b9f4455da1 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -11,7 +11,6 @@
 #include <linux/slab.h>
 #include "exfat.h"
 
-
 static void __set_sb_dirty(struct super_block *sb)
 {
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
@@ -1711,7 +1710,6 @@ struct entry_set_cache_t *get_entry_set_in_dir(struct super_block *sb,
 	if (ret != FFS_SUCCESS)
 		return NULL;
 
-
 	/* byte offset in cluster */
 	byte_offset &= p_fs->cluster_size - 1;
 
@@ -1726,7 +1724,6 @@ struct entry_set_cache_t *get_entry_set_in_dir(struct super_block *sb,
 	if (buf == NULL)
 		goto err_out;
 
-
 	ep = (struct dentry_t *)(buf + off);
 	entry_type = p_fs->fs_func->get_entry_type(ep);
 
@@ -1853,7 +1850,6 @@ void release_entry_set(struct entry_set_cache_t *es)
 	kfree(es);
 }
 
-
 static s32 __write_partial_entries_in_entry_set(struct super_block *sb,
 						struct entry_set_cache_t *es,
 						sector_t sec, s32 off, u32 count)
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index d9787635a373..15970b34e38f 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -3017,7 +3017,6 @@ static void exfat_truncate(struct inode *inode, loff_t old_size)
 
 static int exfat_setattr(struct dentry *dentry, struct iattr *attr)
 {
-
 	struct exfat_sb_info *sbi = EXFAT_SB(dentry->d_sb);
 	struct inode *inode = dentry->d_inode;
 	unsigned int ia_valid;
-- 
2.20.1

