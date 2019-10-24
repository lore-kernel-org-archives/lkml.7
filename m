Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF8ECA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1556921655
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503293AbfJXPyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:54:14 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:42696 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2409778AbfJXPyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:54:13 -0400
Received: from mr4.cc.vt.edu (mail.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9OFsBoQ009976
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:11 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9OFs6tR014730
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:11 -0400
Received: by mail-qk1-f199.google.com with SMTP id s14so23826131qkg.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 08:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3IhcIWhcLHyE2F3fnkVjEngCjGh0YImaBO6o0ZZAEbo=;
        b=bbU3GFHpZ8SLleApso7KnJwrTy6In/KOXLSL4ac3xwvO2+Ex9941HLzUejoKuSIOK0
         SwwkmfocSD/iay6TPJVzEQ3ZP+iIE8xkY71ms7GrbGp8pyFhgWj6u69jMAVsNH+cUmHR
         THxZO1E5REh7ThbISMMy6lVMrENLWvW4q46YWI5SQGKjHSsOMkKerDBiMdocdobdVFzb
         BWlV2/0LXvGlYb2RB710JmFh2vjp7jgCsGadwi6L0Zog+DbCXK8lzlFTmcKQ6Hs8dPB3
         UMbdwReeucC+RVc5pDux+j/GMHogwchVIbsIImH/60L79f7olvIyDiVrPYQE87mB1/37
         DJvA==
X-Gm-Message-State: APjAAAXiL0HKQLxC9hBfHCE28t4gqHYlphmUJIyO9r4oIKY1vuOx5tf5
        q0m54zqZ3DVF0ibNbSJZsmZQNYesW1rjVh4NMcA7wOhKD+NUZmD7rF/yKO2KHDojqemqTDOaQWz
        JmXWwgMUTedyZ3XRqM3WCSQ0i3SLSYDsP0SY=
X-Received: by 2002:ac8:29a5:: with SMTP id 34mr4805490qts.56.1571932446585;
        Thu, 24 Oct 2019 08:54:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwAI1z9zAUExWF3+sgx/j9IB7U3ETV+dIINDgdeUTKX2tzo6cDj3OUk321lOKMWSA6TZLpYgA==
X-Received: by 2002:ac8:29a5:: with SMTP id 34mr4805446qts.56.1571932446273;
        Thu, 24 Oct 2019 08:54:06 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id x133sm12693274qka.44.2019.10.24.08.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:54:05 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/15] staging: exfat: Clean up return codes - FFS_NOTFOUND
Date:   Thu, 24 Oct 2019 11:53:13 -0400
Message-Id: <20191024155327.1095907-3-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert FFS_NOTFOUND to -ENOENT

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h       | 1 -
 drivers/staging/exfat/exfat_super.c | 6 +++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 4aca4ae44a98..1d82de4e1a5c 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -216,7 +216,6 @@ static inline u16 get_row_index(u16 i)
 #define FFS_SEMAPHOREERR        6
 #define FFS_INVALIDPATH         7
 #define FFS_INVALIDFID          8
-#define FFS_NOTFOUND            9
 #define FFS_FILEEXIST           10
 #define FFS_PERMISSIONERR       11
 #define FFS_NOTOPENED           12
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 273fe2310e76..50fc097ded69 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -572,7 +572,7 @@ static int ffsLookupFile(struct inode *inode, char *path, struct file_id_t *fid)
 	dentry = p_fs->fs_func->find_dir_entry(sb, &dir, &uni_name, num_entries,
 					       &dos_name, TYPE_ALL);
 	if (dentry < -1) {
-		ret = FFS_NOTFOUND;
+		ret = -ENOENT;
 		goto out;
 	}
 
@@ -2695,7 +2695,7 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 			err = -EINVAL;
 		else if (err == FFS_FILEEXIST)
 			err = -ENOTEMPTY;
-		else if (err == FFS_NOTFOUND)
+		else if (err == -ENOENT)
 			err = -ENOENT;
 		else if (err == FFS_DIRBUSY)
 			err = -EBUSY;
@@ -2752,7 +2752,7 @@ static int exfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 			err = -EINVAL;
 		else if (err == FFS_FILEEXIST)
 			err = -EEXIST;
-		else if (err == FFS_NOTFOUND)
+		else if (err == -ENOENT)
 			err = -ENOENT;
 		else if (err == -ENOSPC)
 			err = -ENOSPC;
-- 
2.23.0

