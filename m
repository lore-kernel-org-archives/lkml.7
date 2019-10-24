Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845E2CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6446321655
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503404AbfJXPy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:54:58 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:43102 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2503391AbfJXPy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:54:56 -0400
Received: from mr2.cc.vt.edu (mr2.cc.vt.edu [IPv6:2607:b400:92:8400:0:90:e077:bf22])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9OFstwF010564
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:55 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9OFsoVs024711
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:55 -0400
Received: by mail-qt1-f199.google.com with SMTP id m20so25413167qtq.16
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 08:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ebz41ETy8wsrwzEhWbgXC3OcDhlPcRnHFiZwy0DcYE8=;
        b=VpYtuf8Q5DPVK75f8XUx+GGhVWnxFYIrOYlC0DP4GBOVD5n35N2+TjwtwYU6LnrXVS
         HmADVJE2mvFfmfTVb6D2Id7yrrjP1uhX4qUNpc6oFR0ZR0Mhf4dpSFlCtSUlDLiuhMQH
         KGpvITpQXxWAsqEtH7pMLTjGqD129qtF0n20mkIohCdeqFsvUfPd4atZMMyMLpOWKBU4
         WzEHUZAL8oaFBiF15NcJzCD/IqJvwXjg+tojKOMi565b/ewoDyTeUszCOTNEpT7HdcIt
         EF6mfdEE9jgEQnosrD2Rv1nilKRYS9vMM7/RMBVxgidZNYusvMKN38hTIxwhZNzj9DBn
         Z0MQ==
X-Gm-Message-State: APjAAAUzikozn2FnL0OENt+GJLeLDq7H2tYeF1dHAiDWgj7h2ZDHwmR/
        rXv5h4AaWVLhb8BV1bcaXDRAkDRXhvclBwPOOmfLCmgMdfhk8AukIlUFXZv0a0D6lBCRKpjI/rz
        mCoxWkEs2UQPdTEZxPzgJcXnUrGevmceXomU=
X-Received: by 2002:ac8:720e:: with SMTP id a14mr4772378qtp.316.1571932489841;
        Thu, 24 Oct 2019 08:54:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxBNlthD7w6u5EwcLS/za3GIA5LDaEJPQnUeoaZMC5ekgSm+p+/++RGitjUZCBI1o2LpNtSJw==
X-Received: by 2002:ac8:720e:: with SMTP id a14mr4772353qtp.316.1571932489482;
        Thu, 24 Oct 2019 08:54:49 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id x133sm12693274qka.44.2019.10.24.08.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:54:48 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/15] staging: exfat: Clean up return codes - FFS_INVALIDFID
Date:   Thu, 24 Oct 2019 11:53:23 -0400
Message-Id: <20191024155327.1095907-13-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Covert FFS_INVALIDFID to -EINVAL

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h       |  1 -
 drivers/staging/exfat/exfat_super.c | 10 +++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 3ff7293fedd2..505751bf1817 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -214,7 +214,6 @@ static inline u16 get_row_index(u16 i)
 #define FFS_NOTMOUNTED          4
 #define FFS_ALIGNMENTERR        5
 #define FFS_SEMAPHOREERR        6
-#define FFS_INVALIDFID          8
 #define FFS_NOTOPENED           12
 #define FFS_MAXOPENED           13
 #define FFS_ERROR               19
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index a0c28fd8824b..485297974ae7 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -693,7 +693,7 @@ static int ffsReadFile(struct inode *inode, struct file_id_t *fid, void *buffer,
 
 	/* check the validity of the given file id */
 	if (!fid)
-		return FFS_INVALIDFID;
+		return -EINVAL;
 
 	/* check the validity of pointer parameters */
 	if (!buffer)
@@ -823,7 +823,7 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 
 	/* check the validity of the given file id */
 	if (!fid)
-		return FFS_INVALIDFID;
+		return -EINVAL;
 
 	/* check the validity of pointer parameters */
 	if (!buffer)
@@ -1228,7 +1228,7 @@ static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
 
 	/* check the validity of the given file id */
 	if (!fid)
-		return FFS_INVALIDFID;
+		return -EINVAL;
 
 	/* check the validity of pointer parameters */
 	if (!new_path || (*new_path == '\0'))
@@ -1349,7 +1349,7 @@ static int ffsRemoveFile(struct inode *inode, struct file_id_t *fid)
 
 	/* check the validity of the given file id */
 	if (!fid)
-		return FFS_INVALIDFID;
+		return -EINVAL;
 
 	/* acquire the lock for file system critical section */
 	down(&p_fs->v_sem);
@@ -2136,7 +2136,7 @@ static int ffsRemoveDir(struct inode *inode, struct file_id_t *fid)
 
 	/* check the validity of the given file id */
 	if (!fid)
-		return FFS_INVALIDFID;
+		return -EINVAL;
 
 	dir.dir = fid->dir.dir;
 	dir.size = fid->dir.size;
-- 
2.23.0

