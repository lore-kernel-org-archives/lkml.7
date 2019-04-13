Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A9BC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B272084E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfDMUyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 16:54:46 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:34869 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfDMUyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 16:54:46 -0400
Received: by mail-vk1-f194.google.com with SMTP id g24so2888508vki.2;
        Sat, 13 Apr 2019 13:54:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ognk4lz2NDKt1DvD/X12198HfbOIyneoWr847fqKsa4=;
        b=PHu1AI7nR3zd4DoKcBAeFTiDvpgzwNs5Im63A5Ykp0n/gcCbgdvzmm4Bmei3nG1HcH
         eFsRmR9DqeVpgZl5vNJRSnXe1V11tlVPEIifq+Xn57esSCJwxodIjKA3VjCXrqCLZN2F
         wzsDyr1lQoF41im5Hil+odH7mJLLqYmMZiL9LBu9yX9ln+dYLZDyeUF0NvUb3mPu1QAT
         X5FBanLKOAmIq7zVPrpQ+br68fsk4h7Tmj8yr4KaUQSpBRT349a/ejxKCXeqZcgyx3hm
         XT+ABt63RiEgVEIQRy6mpEm3DriYY+bSQX66yEATkBRNWy/oe3Q2ozC2EDsDT89/3EfQ
         rsDw==
X-Gm-Message-State: APjAAAXCfG9uNegTSVoc+lCeCQNAetg1POj1m9GOHyjebaajq4J5h16v
        kABbcDUnb0VKThlZb5Zg8R8kUR53QXAGZg==
X-Google-Smtp-Source: APXvYqwv3V8ZyHxCWYExIpQywnX8nFC3rJdZ1OA3aV4RypgIwI1SHfCFCKjKhnQm6jXi1nKzqGusqQ==
X-Received: by 2002:a1f:23c5:: with SMTP id j188mr34821935vkj.39.1555188884730;
        Sat, 13 Apr 2019 13:54:44 -0700 (PDT)
Received: from localhost.localdomain ([201.240.145.139])
        by smtp.gmail.com with ESMTPSA id g184sm11132244vkd.31.2019.04.13.13.54.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 13:54:44 -0700 (PDT)
From:   Shawn Landden <shawn@git.icu>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Landden <shawn@git.icu>
Subject: [PATCH] new flag COPY_FILE_RANGE_FILESIZE for copy_file_range()
Date:   Sat, 13 Apr 2019 15:54:39 -0500
Message-Id: <20190413205439.9623-1-shawn@git.icu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If flags includes COPY_FILE_RANGE_FILESIZE then the length
copied is the length of the file. off_in and off_out are
ignored. len must be 0 or the file size.

This implementation saves a call to stat() in the common case
of copying files. It does not fix any race conditions, but that
is possible in the future with this interface.

EAGAIN: If COPY_FILE_RANGE_FILESIZE was passed and len is not 0
or the file size.

Signed-off-by: Shawn Landden <shawn@git.icu>
CC: <linux-api@vger.kernel.org>
---
 fs/read_write.c           | 14 +++++++++++++-
 include/uapi/linux/stat.h |  4 ++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 61b43ad7608e..6d06361f0856 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1557,7 +1557,7 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 	struct inode *inode_out = file_inode(file_out);
 	ssize_t ret;
 
-	if (flags != 0)
+	if ((flags & ~COPY_FILE_RANGE_FILESIZE) != 0)
 		return -EINVAL;
 
 	if (S_ISDIR(inode_in->i_mode) || S_ISDIR(inode_out->i_mode))
@@ -1565,6 +1565,18 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode))
 		return -EINVAL;
 
+	if (flags & COPY_FILE_RANGE_FILESIZE) {
+		struct kstat stat;
+		int error;
+		error = vfs_getattr(&file_in->f_path, &stat,
+				    STATX_SIZE, 0);
+		if (error < 0)
+			return error;
+		if (!(len == 0 || len == stat.size))
+			return -EAGAIN;
+		len = stat.size;
+	}
+
 	ret = rw_verify_area(READ, file_in, &pos_in, len);
 	if (unlikely(ret))
 		return ret;
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 7b35e98d3c58..1075aa4666ef 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -170,5 +170,9 @@ struct statx {
 
 #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
 
+/*
+ * Flags for copy_file_range()
+ */
+#define COPY_FILE_RANGE_FILESIZE	0x00000001 /* Copy the full length of the input file */
 
 #endif /* _UAPI_LINUX_STAT_H */
-- 
2.20.1

