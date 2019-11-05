Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FFDCA9ED4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 02:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB54214D9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 02:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbfKECqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 21:46:40 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:42222 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729543AbfKECqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 21:46:39 -0500
Received: from mr5.cc.vt.edu (mr5.cc.vt.edu [IPv6:2607:b400:92:8400:0:72:232:758b])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xA52kcH1010946
        for <linux-kernel@vger.kernel.org>; Mon, 4 Nov 2019 21:46:38 -0500
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xA52kXNc031772
        for <linux-kernel@vger.kernel.org>; Mon, 4 Nov 2019 21:46:38 -0500
Received: by mail-qk1-f197.google.com with SMTP id p68so19897205qkf.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 18:46:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=RZNcm7tJHE7PJ/B2fVNd5i/u7+ifnx25OIt2h3zpLOo=;
        b=LY7aeqQKCQqDiqdkLhlnORlkKN72Grzeji5SQhXs7t2uVT5gIplTBjIdEGr4Vnplqd
         +TP7BKXGpbg7PiPJDEbSYqKG3EclatJ/1lWz4/kBppxs5n9LsCDolX91K74hWdW1j7fk
         OgLnMVqyMCvgnR+UmKTqly2M+SeqPp4tg2wIAsYWKD4JugxdlQhSs/wvWKFgTp6uREa9
         eEUDmFaIriWgbsRvrWnLBla+uc6w3lQhDTKtg4PaEPbhdODF9i2fQvElTf3UGb94knlf
         02lk2q//cTalovW84i77QU3OUGShJPCiA/O5tMJI1qBlmlXAmDlkPRlre08qnVZe0y+k
         J5Hw==
X-Gm-Message-State: APjAAAWOKAmSrHXl+rS6lcO7QqOnmv9zqyiO0VfdDJR5f67uiFf2mUNX
        4JGugjH3LB2Bzh8HgiSPstteh439Khdox22vT55RokPABGDWyyswM++D2Uvcy/OdJm/ZASFkSVi
        QPLYm6eiKzcHrfkA+kU0t6rVfd9ox705xs/k=
X-Received: by 2002:ad4:5349:: with SMTP id v9mr23621305qvs.55.1572921992488;
        Mon, 04 Nov 2019 18:46:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqyXzA6HviTv6QlEgIOFkTmQMi16KNYqK2sd8+KO7QEzhWvkSciXAH9zdUWTp/6s496+Fl8aKA==
X-Received: by 2002:ad4:5349:: with SMTP id v9mr23621285qvs.55.1572921992189;
        Mon, 04 Nov 2019 18:46:32 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id s21sm12156815qtc.12.2019.11.04.18.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 18:46:30 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Jan Kara <jack@suse.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-arch@vger.kernel.org
Subject: [PATCH 1/1] errno.h: Provide EFSBADCRC for everybody
Date:   Mon,  4 Nov 2019 21:46:14 -0500
Message-Id: <20191105024618.194134-1-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Four filesystems have their own defines for this. Move it
into errno.h so it's defined in just one place.

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 fs/ext4/ext4.h                   | 2 --
 fs/f2fs/f2fs.h                   | 2 --
 fs/xfs/xfs_linux.h               | 1 -
 include/linux/jbd2.h             | 2 --
 include/uapi/asm-generic/errno.h | 1 +
 5 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index a86c2585457d..79b3fd8291ab 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3395,6 +3395,4 @@ static inline int ext4_buffer_uptodate(struct buffer_head *bh)
 
 #endif	/* __KERNEL__ */
 
-#define EFSBADCRC	EBADMSG		/* Bad CRC detected */
-
 #endif	/* _EXT4_H */
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 04ebe77569a3..ba23fd18d44a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3751,6 +3751,4 @@ static inline bool is_journalled_quota(struct f2fs_sb_info *sbi)
 	return false;
 }
 
-#define EFSBADCRC	EBADMSG		/* Bad CRC detected */
-
 #endif /* _LINUX_F2FS_H */
diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
index 3409d02a7d21..abdfc506618d 100644
--- a/fs/xfs/xfs_linux.h
+++ b/fs/xfs/xfs_linux.h
@@ -123,7 +123,6 @@ typedef __u32			xfs_nlink_t;
 
 #define ENOATTR		ENODATA		/* Attribute not found */
 #define EWRONGFS	EINVAL		/* Mount with wrong filesystem type */
-#define EFSBADCRC	EBADMSG		/* Bad CRC detected */
 
 #define SYNCHRONIZE()	barrier()
 #define __return_address __builtin_return_address(0)
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 69411d7e0431..e07692fe6f20 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1656,6 +1656,4 @@ static inline tid_t  jbd2_get_latest_transaction(journal_t *journal)
 
 #endif	/* __KERNEL__ */
 
-#define EFSBADCRC	EBADMSG		/* Bad CRC detected */
-
 #endif	/* _LINUX_JBD2_H */
diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/errno.h
index 1d5ffdf54cb0..e4cae9a9ae79 100644
--- a/include/uapi/asm-generic/errno.h
+++ b/include/uapi/asm-generic/errno.h
@@ -55,6 +55,7 @@
 #define	EMULTIHOP	72	/* Multihop attempted */
 #define	EDOTDOT		73	/* RFS specific error */
 #define	EBADMSG		74	/* Not a data message */
+#define EFSBADCRC	EBADMSG	/* Bad CRC detected */
 #define	EOVERFLOW	75	/* Value too large for defined data type */
 #define	ENOTUNIQ	76	/* Name not unique on network */
 #define	EBADFD		77	/* File descriptor in bad state */
-- 
2.24.0.rc1

