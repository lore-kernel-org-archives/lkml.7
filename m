Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09174C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D187920818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfKLVNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 16:13:51 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:44490 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727482AbfKLVNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:13:48 -0500
Received: from mr2.cc.vt.edu (mr2.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:90:e077:bf22])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xACLDlcB012803
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 16:13:47 -0500
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xACLDgHn026697
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 16:13:47 -0500
Received: by mail-qv1-f69.google.com with SMTP id m12so9524887qvv.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 13:13:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=G+XEM7NqA7duBgC178Q7ObGQk8ZeoGEeRJMM3ee4yAQ=;
        b=rbNenstvx2/BkK5BwMnYGsYT33fTbRCRHRWgjfwBIZCGAGiZ91gu/rJ3jUN/QudwlU
         c8+BceNHL9hN0Uj0L0HR+A6lZTRU8zUBWuGQ5Km2DDo/LwZr+g7InKEQcF+NYdynKQ1K
         uQRrcxGFL8hPqvIjspC8cKnaD4UTcUcTb1YPYfuBpTo2cbmBIvDixPIATDLuIBIKWnS1
         mFnuarCB9Op83gtCASpCqe4zTL3gG7UmGq8DXSqCIvVhBycalYasaMGsnEJWqPuISDUl
         +rd2ax+RzAwBSXKBW44+NSTthqmaWTdIU+y4x/e6blZ1aN/P2KG124tectpkNkvW8+xu
         hxCA==
X-Gm-Message-State: APjAAAUC/pTu5BSK6hInBMJcoieBoug1VSMr4631xUTCaxCfGZPI3hRs
        IFCmwvwXsIzuOsJTTgGavG4PWA6NuvKmy1omqeIWdjZarnw1iM2POm40olS/BEqJP5qPWJd/V8y
        eebee0N+lBPt1TwO1ahnJRSloht8Lwj+IQu8=
X-Received: by 2002:ac8:1494:: with SMTP id l20mr13675948qtj.356.1573593222067;
        Tue, 12 Nov 2019 13:13:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqzF5gO4XlN15JxU3WTA3jUQX9UNDZq3E87aaI55II1ymFJHv5aHH+FQzD+IV+eipDN7UN+WIA==
X-Received: by 2002:ac8:1494:: with SMTP id l20mr13675845qtj.356.1573593220899;
        Tue, 12 Nov 2019 13:13:40 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id 130sm9674214qkd.33.2019.11.12.13.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 13:13:40 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] staging: exfat: Clean up the namespace pollution part 3
Date:   Tue, 12 Nov 2019 16:12:33 -0500
Message-Id: <20191112211238.156490-8-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112211238.156490-1-Valdis.Kletnieks@vt.edu>
References: <20191112211238.156490-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions are only used in the local file, make them static

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h      | 6 ------
 drivers/staging/exfat/exfat_core.c | 8 ++++----
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 5044523ccb97..407dbb017c5f 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -758,8 +758,6 @@ void fs_set_vol_flags(struct super_block *sb, u32 new_flag);
 void fs_error(struct super_block *sb);
 
 /* cluster management functions */
-s32 clear_cluster(struct super_block *sb, u32 clu);
-u32 find_last_cluster(struct super_block *sb, struct chain_t *p_chain);
 s32 count_num_clusters(struct super_block *sb, struct chain_t *dir);
 void exfat_chain_cont_cluster(struct super_block *sb, u32 chain, s32 len);
 
@@ -782,8 +780,6 @@ void init_strm_entry(struct strm_dentry_t *ep, u8 flags, u32 start_clu,
 		     u64 size);
 void init_name_entry(struct name_dentry_t *ep, u16 *uniname);
 
-s32 find_location(struct super_block *sb, struct chain_t *p_dir, s32 entry,
-		  sector_t *sector, s32 *offset);
 struct dentry_t *get_entry_in_dir(struct super_block *sb, struct chain_t *p_dir,
 				  s32 entry, sector_t *sector);
 struct entry_set_cache_t *get_entry_set_in_dir(struct super_block *sb,
@@ -797,8 +793,6 @@ s32 write_partial_entries_in_entry_set(struct super_block *sb,
 				       struct dentry_t *ep, u32 count);
 s32 search_deleted_or_unused_entry(struct super_block *sb,
 				   struct chain_t *p_dir, s32 num_entries);
-s32 find_empty_entry(struct inode *inode, struct chain_t *p_dir,
-		     s32 num_entries);
 s32 count_dos_name_entries(struct super_block *sb, struct chain_t *p_dir,
 			   u32 type);
 void update_dir_checksum(struct super_block *sb, struct chain_t *p_dir,
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 5a01fc25f31d..3ea51d12c38d 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -125,7 +125,7 @@ void fs_error(struct super_block *sb)
  *  Cluster Management Functions
  */
 
-s32 clear_cluster(struct super_block *sb, u32 clu)
+static s32 clear_cluster(struct super_block *sb, u32 clu)
 {
 	sector_t s, n;
 	s32 ret = 0;
@@ -294,7 +294,7 @@ static void exfat_free_cluster(struct super_block *sb, struct chain_t *p_chain,
 		p_fs->used_clusters -= num_clusters;
 }
 
-u32 find_last_cluster(struct super_block *sb, struct chain_t *p_chain)
+static u32 find_last_cluster(struct super_block *sb, struct chain_t *p_chain)
 {
 	u32 clu, next;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
@@ -1186,7 +1186,7 @@ static s32 _walk_fat_chain(struct super_block *sb, struct chain_t *p_dir,
 	return 0;
 }
 
-s32 find_location(struct super_block *sb, struct chain_t *p_dir, s32 entry,
+static s32 find_location(struct super_block *sb, struct chain_t *p_dir, s32 entry,
 		  sector_t *sector, s32 *offset)
 {
 	s32 off, ret;
@@ -1583,7 +1583,7 @@ s32 search_deleted_or_unused_entry(struct super_block *sb,
 	return -1;
 }
 
-s32 find_empty_entry(struct inode *inode, struct chain_t *p_dir, s32 num_entries)
+static s32 find_empty_entry(struct inode *inode, struct chain_t *p_dir, s32 num_entries)
 {
 	s32 ret, dentry;
 	u32 last_clu;
-- 
2.24.0

