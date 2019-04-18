Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA67C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB46420663
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LE9q+cRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389713AbfDRQAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:00:12 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:41341 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388888AbfDRQAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 12:00:10 -0400
Received: by mail-qt1-f202.google.com with SMTP id d49so2398288qtk.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 09:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0aicKjl/VfmjaDcQcRF8XUkhFRkNGvY6NhvfXGsqHIE=;
        b=LE9q+cRzg/FHUODL/GlmKIk4+enXVXYaMrfT8uHBc//DQlBZcgyYXYPcsCcU6m/Jo2
         9Py7b+tVcoZRggCtcfCL0Q/+m7RtQo+vlTutkgh0pxqclALQbOplwKhpXLkoY2x0mg5v
         /Z2TsZ/YQ0X07D1lYjnr+sGxrUUGeJ+f4fgij3bo/Yv1IK1Vl/0shcO3re/CBWxbgEl3
         Q0j33O7kvOfx9Elq31tM/2Pa0F351DR+5/qbs7Dsf3Ueg1IAdAB6+MDSZUMDM+0RXwaQ
         cF2jCwPLsxD2JxjoKoPzWUDUasV+jPCmwYIWY7qlbxJX+VqrdWzlt3sCR+a3VSK2Bh/4
         DcNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0aicKjl/VfmjaDcQcRF8XUkhFRkNGvY6NhvfXGsqHIE=;
        b=O/XYK1TRqCvmddFW3rnK5lD9kpWwC+R/L7RCEZ25T9sC6AwftNOrR/ZHBHMpyrdNGn
         DXm9hXe43IIQGfHmyaalHOtNDBdCZhAy/B404O10en0q5J0IwSIYjnPkGdLWjkxRuD1T
         mpMD9bxoM94BY8Z5B0KSQkjJWWxzvaleMKjwrmG61GCOUu0BG2B4j3oevfgL+R/bSmj9
         S8RD4rPYDQaZr9Vzh2Z0I9Wi/UygnJXjRgOHOOma+xXwcRR92jcC2NxooRCIc4xt6DGc
         wIiei813yyHcRNJajbLepoj/17Hd8caefMKES4Wmm7KAZzjSnMNf+ItGpsB+meZ4s5sP
         Ic2Q==
X-Gm-Message-State: APjAAAUjP1zpKTViVPdf1jh5wWR4ipx31OTzV34uaAZOA9ORh7B7cvy/
        xjh5eiIMadtRTSXwGYQe8GBaJPwN
X-Google-Smtp-Source: APXvYqxvui4yPi+cuT1TNHqRffTf3USOAbSIa5K4hEOxZAY37I1faGnLV9s22qIWGFtd9ocLVlzpNgc+
X-Received: by 2002:a0c:89a3:: with SMTP id 32mr76711622qvr.116.1555603209523;
 Thu, 18 Apr 2019 09:00:09 -0700 (PDT)
Date:   Thu, 18 Apr 2019 11:59:37 -0400
In-Reply-To: <20190415211945.27343-1-brho@google.com>
Message-Id: <20190418155937.164947-1-brho@google.com>
Mime-Version: 1.0
References: <20190415211945.27343-1-brho@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v2] ext4: fix use-after-free race with debug_want_extra_isize
From:   Barret Rhoden <brho@google.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     syzbot+f584efa0ac7213c226b7@syzkaller.appspotmail.com,
        Jan Kara <jack@suse.cz>, stable@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When remounting with debug_want_extra_isize, we were not performing the
same checks that we do during a normal mount.  That allowed us to set a
value for s_want_extra_isize that reached outside the s_inode_size.

Reported-by: syzbot+f584efa0ac7213c226b7@syzkaller.appspotmail.com
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Barret Rhoden <brho@google.com>
Cc: stable@vger.kernel.org # 4.14.111
---

- Updated tags

Thanks for the review!

 fs/ext4/super.c | 58 +++++++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 6ed4eb81e674..184944d4d8d1 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3513,6 +3513,37 @@ int ext4_calculate_overhead(struct super_block *sb)
 	return 0;
 }
 
+static void ext4_clamp_want_extra_isize(struct super_block *sb)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_super_block *es = sbi->s_es;
+
+	/* determine the minimum size of new large inodes, if present */
+	if (sbi->s_inode_size > EXT4_GOOD_OLD_INODE_SIZE &&
+	    sbi->s_want_extra_isize == 0) {
+		sbi->s_want_extra_isize = sizeof(struct ext4_inode) -
+						     EXT4_GOOD_OLD_INODE_SIZE;
+		if (ext4_has_feature_extra_isize(sb)) {
+			if (sbi->s_want_extra_isize <
+			    le16_to_cpu(es->s_want_extra_isize))
+				sbi->s_want_extra_isize =
+					le16_to_cpu(es->s_want_extra_isize);
+			if (sbi->s_want_extra_isize <
+			    le16_to_cpu(es->s_min_extra_isize))
+				sbi->s_want_extra_isize =
+					le16_to_cpu(es->s_min_extra_isize);
+		}
+	}
+	/* Check if enough inode space is available */
+	if (EXT4_GOOD_OLD_INODE_SIZE + sbi->s_want_extra_isize >
+							sbi->s_inode_size) {
+		sbi->s_want_extra_isize = sizeof(struct ext4_inode) -
+						       EXT4_GOOD_OLD_INODE_SIZE;
+		ext4_msg(sb, KERN_INFO,
+			 "required extra inode space not available");
+	}
+}
+
 static void ext4_set_resv_clusters(struct super_block *sb)
 {
 	ext4_fsblk_t resv_clusters;
@@ -4387,30 +4418,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	} else if (ret)
 		goto failed_mount4a;
 
-	/* determine the minimum size of new large inodes, if present */
-	if (sbi->s_inode_size > EXT4_GOOD_OLD_INODE_SIZE &&
-	    sbi->s_want_extra_isize == 0) {
-		sbi->s_want_extra_isize = sizeof(struct ext4_inode) -
-						     EXT4_GOOD_OLD_INODE_SIZE;
-		if (ext4_has_feature_extra_isize(sb)) {
-			if (sbi->s_want_extra_isize <
-			    le16_to_cpu(es->s_want_extra_isize))
-				sbi->s_want_extra_isize =
-					le16_to_cpu(es->s_want_extra_isize);
-			if (sbi->s_want_extra_isize <
-			    le16_to_cpu(es->s_min_extra_isize))
-				sbi->s_want_extra_isize =
-					le16_to_cpu(es->s_min_extra_isize);
-		}
-	}
-	/* Check if enough inode space is available */
-	if (EXT4_GOOD_OLD_INODE_SIZE + sbi->s_want_extra_isize >
-							sbi->s_inode_size) {
-		sbi->s_want_extra_isize = sizeof(struct ext4_inode) -
-						       EXT4_GOOD_OLD_INODE_SIZE;
-		ext4_msg(sb, KERN_INFO, "required extra inode space not"
-			 "available");
-	}
+	ext4_clamp_want_extra_isize(sb);
 
 	ext4_set_resv_clusters(sb);
 
@@ -5194,6 +5202,8 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 		goto restore_opts;
 	}
 
+	ext4_clamp_want_extra_isize(sb);
+
 	if ((old_opts.s_mount_opt & EXT4_MOUNT_JOURNAL_CHECKSUM) ^
 	    test_opt(sb, JOURNAL_CHECKSUM)) {
 		ext4_msg(sb, KERN_ERR, "changing journal_checksum "
-- 
2.21.0.392.gf8f6787159e-goog

