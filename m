Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B566C46477
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663DD2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PQ69jBZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731946AbfFLI6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:58:07 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:56945 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728740AbfFLI6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:58:07 -0400
Received: by mail-yb1-f202.google.com with SMTP id y3so14884289ybp.23
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9k1XSYdZALmH5hfa8a4AvP07Lnh/NUnZExR+YT8RVJg=;
        b=PQ69jBZKOHxDO/Whg1h1b3HMn0jb+jBhbwD60f9UYm+KKj3nXwBXrhdSO1xpxRUGI3
         7cK7dIMJfWnffO9DB6tfoM1dDSdPKSkJ5zviaiG1T840kg7O02vo21jucqKNco5vBXtP
         nnT59IGwweHt1bguh+DDlSq8k7cJdN890iHE7pkIZFIRiwBwkDigJQO3Y5kax6nltu55
         ZyUcbSEPVFgAq3EpsoxgujnREHik+31nO+3gVraPCbY3qQjjsgY+kUoRWFwI2ofTy9eU
         wWoxLnJq2S/7lCcEo27WrwwosrCyB4NfDIxMLi4kpcpYa+ddPkAOyd6jbV4xY8bDKkl0
         m7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9k1XSYdZALmH5hfa8a4AvP07Lnh/NUnZExR+YT8RVJg=;
        b=HaO2Iy5F5JrofCqThQW4hPy/WB2x6KeuzjKtRxjMkQaUYVZfEgla7dawsaNxnpd9+Q
         2Ax9+5IvBtWGmwDolcjdsDRIGQEgiWYej5VYHi7S/a2oDmyjEzVmWs5NBzMIsPiuwY1K
         Ws/hBPXfe8AJYrtviTVLWXRUv49ur0R/VDz8XPdGn0DU+yd9bWEOV9DMurhieyJldbNP
         SsG4FLioYPz8pkxK9h6mYWNQ/wJDIS7f5bSgMN8UF4YPjplb+yZM/4DeZKijJkd/wB5Q
         rY38XmVYEn8DeUsHrqYNMdhxc50ftLCH6EL46COQiFqTQxBpkrg/HtpWQC8QRoF6f+1i
         PRFA==
X-Gm-Message-State: APjAAAXaJBdLrdzoVEj7DgcVFljyTocpTwyLF00DMLF7/2QfOmCvcezi
        HuZsRb/ueeWUbSpeVBK+I5tSO3Kew8oRpVX8gYo=
X-Google-Smtp-Source: APXvYqwoFryJoQr+gF8BtttieF5Om0BeVHO4kvoPuVRSm+6q0gxUUv485INZg3A87cHt7LzA7WMZ/J5NiwFziYzUPsE=
X-Received: by 2002:a25:d407:: with SMTP id m7mr37566390ybf.409.1560329886146;
 Wed, 12 Jun 2019 01:58:06 -0700 (PDT)
Date:   Wed, 12 Jun 2019 16:58:00 +0800
Message-Id: <20190612085800.11947-1-huangrandall@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH] f2fs: add boundary check in inline_data_addr
From:   Randall Huang <huangrandall@google.com>
To:     jaegeuk@kernel.org, yuchao0@huawei.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     huangrandall@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add boundary check in case of extra_size is larger
than sizeof array "i_addr"

Signed-off-by: Randall Huang <huangrandall@google.com>
---
 fs/f2fs/f2fs.h | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 760390f380b6..17f3858a00c3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2660,11 +2660,25 @@ static inline bool f2fs_is_drop_cache(struct inode *inode)
 	return is_inode_flag_set(inode, FI_DROP_CACHE);
 }
 
+#define F2FS_TOTAL_EXTRA_ATTR_SIZE			\
+	(offsetof(struct f2fs_inode, i_extra_end) -	\
+	offsetof(struct f2fs_inode, i_extra_isize))	\
+
 static inline void *inline_data_addr(struct inode *inode, struct page *page)
 {
 	struct f2fs_inode *ri = F2FS_INODE(page);
 	int extra_size = get_extra_isize(inode);
 
+	if (extra_size < 0 || extra_size > F2FS_TOTAL_EXTRA_ATTR_SIZE ||
+		extra_size % sizeof(__le32)) {
+		f2fs_msg(F2FS_I_SB(inode)->sb, KERN_ERR,
+			"%s: inode (ino=%lx) has corrupted i_extra_isize: %d, "
+			"max: %zu",
+			__func__, inode->i_ino, extra_size,
+			F2FS_TOTAL_EXTRA_ATTR_SIZE);
+		extra_size = 0;
+	}
+
 	return (void *)&(ri->i_addr[extra_size + DEF_INLINE_RESERVED_SIZE]);
 }
 
@@ -2817,10 +2831,6 @@ static inline int get_inline_xattr_addrs(struct inode *inode)
 	((is_inode_flag_set(i, FI_ACL_MODE)) ? \
 	 (F2FS_I(i)->i_acl_mode) : ((i)->i_mode))
 
-#define F2FS_TOTAL_EXTRA_ATTR_SIZE			\
-	(offsetof(struct f2fs_inode, i_extra_end) -	\
-	offsetof(struct f2fs_inode, i_extra_isize))	\
-
 #define F2FS_OLD_ATTRIBUTE_SIZE	(offsetof(struct f2fs_inode, i_addr))
 #define F2FS_FITS_IN_INODE(f2fs_inode, extra_isize, field)		\
 		((offsetof(typeof(*(f2fs_inode)), field) +	\
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

