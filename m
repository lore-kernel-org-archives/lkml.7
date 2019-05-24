Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C49C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E43217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NCJDg9xp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KbvxFmnv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390824AbfEXKoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 06:44:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49232 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390578AbfEXKoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 06:44:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EF415611FC; Fri, 24 May 2019 10:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558694645;
        bh=HF7FUic2Qgap5t9eKuxI7oyYoQWtLjSkiQ9P+5lmjgA=;
        h=From:To:Cc:Subject:Date:From;
        b=NCJDg9xpM3m7Tr78OqD7WJBPCTV8Eaq/qGbuC7+HQaM/CIZOJP4tORbuXzvsqFjKW
         E++8fOAhFf+BJxjR9J3Iu3ijtsVhQHgaJOj44V+MvrJwXTxarGdtaeoPURC3/ww+GF
         MuBmCRdMXuF0XKAhzZLNaZ39DH9rxeufjzoh6RcQ=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3EAFB60C5F;
        Fri, 24 May 2019 10:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558694644;
        bh=HF7FUic2Qgap5t9eKuxI7oyYoQWtLjSkiQ9P+5lmjgA=;
        h=From:To:Cc:Subject:Date:From;
        b=KbvxFmnvnO6HucGm9IgtDjyI71UXjCLu9Fa0t4OsNNZV3YlobN6ZhhNvIOGA6ZQxB
         n2VgvVUOv0xlRf6L28u+vkxgHON1z1O5JR9HY/vs96NLaE+cT0e+HUP3bapWuQL02e
         g3QZW3sy3nJ2pkA0dIwv2EVIyl1oZNz2z0KpdZgc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3EAFB60C5F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: add errors=panic mount option
Date:   Fri, 24 May 2019 16:13:51 +0530
Message-Id: <1558694631-12481-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add errors=panic mount option for debugging purpose. It can be
set dynamically when the config option CONFIG_F2FS_CHECK_FS
is not enabled.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/f2fs.h  |  9 +++++++--
 fs/f2fs/super.c | 21 +++++++++++++++++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9b3d997..95adedb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -32,8 +32,12 @@
 #define f2fs_bug_on(sbi, condition)					\
 	do {								\
 		if (unlikely(condition)) {				\
-			WARN_ON(1);					\
-			set_sbi_flag(sbi, SBI_NEED_FSCK);		\
+			if (test_opt(sbi, ERRORS_PANIC)) {		\
+				BUG_ON(condition);			\
+			} else {					\
+				WARN_ON(1);				\
+				set_sbi_flag(sbi, SBI_NEED_FSCK);	\
+			}						\
 		}							\
 	} while (0)
 #endif
@@ -99,6 +103,7 @@ struct f2fs_fault_info {
 #define F2FS_MOUNT_INLINE_XATTR_SIZE	0x00800000
 #define F2FS_MOUNT_RESERVE_ROOT		0x01000000
 #define F2FS_MOUNT_DISABLE_CHECKPOINT	0x02000000
+#define F2FS_MOUNT_ERRORS_PANIC		0x04000000
 
 #define F2FS_OPTION(sbi)	((sbi)->mount_opt)
 #define clear_opt(sbi, option)	(F2FS_OPTION(sbi).opt &= ~F2FS_MOUNT_##option)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 912e261..7d6d96a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -137,6 +137,7 @@ enum {
 	Opt_fsync,
 	Opt_test_dummy_encryption,
 	Opt_checkpoint,
+	Opt_errors,
 	Opt_err,
 };
 
@@ -196,6 +197,7 @@ enum {
 	{Opt_fsync, "fsync_mode=%s"},
 	{Opt_test_dummy_encryption, "test_dummy_encryption"},
 	{Opt_checkpoint, "checkpoint=%s"},
+	{Opt_errors, "errors=%s"},
 	{Opt_err, NULL},
 };
 
@@ -788,6 +790,23 @@ static int parse_options(struct super_block *sb, char *options)
 			}
 			kvfree(name);
 			break;
+		case Opt_errors:
+#ifndef CONFIG_F2FS_CHECK_FS
+			name = match_strdup(&args[0]);
+			if (!name)
+				return -ENOMEM;
+
+			if (strlen(name) == 5 && !strncmp(name, "panic", 5)) {
+				set_opt(sbi, ERRORS_PANIC);
+			} else {
+				kvfree(name);
+				return -EINVAL;
+			}
+			kvfree(name);
+			f2fs_msg(sb, KERN_INFO,
+				"debug mode errors=panic enabled\n");
+#endif
+			break;
 		default:
 			f2fs_msg(sb, KERN_ERR,
 				"Unrecognized mount option \"%s\" or missing value",
@@ -1417,6 +1436,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_printf(seq, ",fsync_mode=%s", "strict");
 	else if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_NOBARRIER)
 		seq_printf(seq, ",fsync_mode=%s", "nobarrier");
+	if (test_opt(sbi, ERRORS_PANIC))
+		seq_printf(seq, ",errors=%s", "panic");
 	return 0;
 }
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

