Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0C4C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 02:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3F621019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 02:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eROfEuBN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbfEWCv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 22:51:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35350 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729879AbfEWCv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 22:51:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id d126so180140pfd.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 19:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IQeVd/84/xR4UF/8mxB5+jIJHDbqJkh066X1hA8pE4U=;
        b=eROfEuBNv8XrjbmYrwNaxcEgMqBNbDWE7LwFChWurrOGGhpYfYgyc6zd457U9DPvkb
         Y8hB8raBTgWJbw+wwXqYqrOUa0lPYk8CUxH51IvlP4C18qJRjDxzd93RXZSe/e0ickWL
         EVMembvBlMR6hyC9yPWP8H+oX3hRpB+ceX9Og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IQeVd/84/xR4UF/8mxB5+jIJHDbqJkh066X1hA8pE4U=;
        b=TnnitsQ+FkxNCbIpoaQzPpQeos28HqODiayKx6WU2ErFdHWFA5r0EVhwjhW8FlxX4C
         rlvGhwAr836+pCVspw3lKCKmmt3OjeXWg5XeyoUpvfpVb/Ow4bj4NGOtxDIftHVDBDqY
         fdlP44poo4rYaHTuUp5OSf9R0iFHaFsBtuWWBULweKulkcPrt7Tro0UTBaI+hsEz0xLH
         X+hYS/uSpmg6zj2ARNYe6SqouqP+pqPEMGi0whvtSQiiBCdw36Qu8tUQ3f8jv122mMil
         3p7RdbwoK1fL+p/tGqpv82h7Ih4R8Ees77sNMYUypX3YtYQiPmg0C4N0yXELhmhxdWq5
         dkJw==
X-Gm-Message-State: APjAAAU/4b93Ll9hehmk4tz7yid9BGH2N3GenW7Sep77WdQ5Gmturjkw
        d2O1cwREtt5YC4Jti4MirEG1TQ==
X-Google-Smtp-Source: APXvYqzIwk+Yq92qpe20eEs6VVhu+ZObr2Z9NJbXovcghc1bax3W3UqwKw8rX8AX7Z5paltFAk3KSA==
X-Received: by 2002:a62:1844:: with SMTP id 65mr87911224pfy.127.1558579887745;
        Wed, 22 May 2019 19:51:27 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id q19sm42812174pff.96.2019.05.22.19.51.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 19:51:27 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH 1/3] fs: introduce kernel_pread_file* support
Date:   Wed, 22 May 2019 19:51:11 -0700
Message-Id: <20190523025113.4605-2-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190523025113.4605-1-scott.branden@broadcom.com>
References: <20190523025113.4605-1-scott.branden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kernel_pread_file* support to kernel to allow for partial read
of files with an offset into the file.  Existing kernel_read_file
functions call new kernel_pread_file functions with offset=0 and
flags=KERNEL_PREAD_FLAG_WHOLE.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 fs/exec.c          | 77 ++++++++++++++++++++++++++++++++++++----------
 include/linux/fs.h | 15 +++++++++
 2 files changed, 75 insertions(+), 17 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index d88584ebf07f..ba56450acfb3 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -892,10 +892,14 @@ struct file *open_exec(const char *name)
 }
 EXPORT_SYMBOL(open_exec);
 
-int kernel_read_file(struct file *file, void **buf, loff_t *size,
-		     loff_t max_size, enum kernel_read_file_id id)
-{
-	loff_t i_size, pos;
+int kernel_pread_file(struct file *file, void **buf, loff_t *size,
+		      loff_t pos, loff_t max_size, unsigned int flags,
+		      enum kernel_read_file_id id)
+{
+	loff_t alloc_size;
+	loff_t buf_pos;
+	loff_t read_end;
+	loff_t i_size;
 	ssize_t bytes = 0;
 	int ret;
 
@@ -915,21 +919,31 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 		ret = -EINVAL;
 		goto out;
 	}
-	if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
+
+	/* Default read to end of file */
+	read_end = i_size;
+
+	/* Allow reading partial portion of file */
+	if ((flags & KERNEL_PREAD_FLAG_PART) &&
+	    (i_size > (pos + max_size)))
+		read_end = pos + max_size;
+
+	alloc_size = read_end - pos;
+	if (i_size > SIZE_MAX || (max_size > 0 && alloc_size > max_size)) {
 		ret = -EFBIG;
 		goto out;
 	}
 
 	if (id != READING_FIRMWARE_PREALLOC_BUFFER)
-		*buf = vmalloc(i_size);
+		*buf = vmalloc(alloc_size);
 	if (!*buf) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	pos = 0;
-	while (pos < i_size) {
-		bytes = kernel_read(file, *buf + pos, i_size - pos, &pos);
+	buf_pos = 0;
+	while (pos < read_end) {
+		bytes = kernel_read(file, *buf + buf_pos, read_end - pos, &pos);
 		if (bytes < 0) {
 			ret = bytes;
 			goto out_free;
@@ -937,14 +951,16 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 
 		if (bytes == 0)
 			break;
+
+		buf_pos += bytes;
 	}
 
-	if (pos != i_size) {
+	if (pos != read_end) {
 		ret = -EIO;
 		goto out_free;
 	}
 
-	ret = security_kernel_post_read_file(file, *buf, i_size, id);
+	ret = security_kernel_post_read_file(file, *buf, alloc_size, id);
 	if (!ret)
 		*size = pos;
 
@@ -960,10 +976,20 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 	allow_write_access(file);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(kernel_pread_file);
+
+int kernel_read_file(struct file *file, void **buf, loff_t *size,
+		     loff_t max_size, enum kernel_read_file_id id)
+{
+	return kernel_pread_file(file, buf, size, 0, max_size,
+				 KERNEL_PREAD_FLAG_WHOLE, id);
+}
 EXPORT_SYMBOL_GPL(kernel_read_file);
 
-int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
-			       loff_t max_size, enum kernel_read_file_id id)
+int kernel_pread_file_from_path(const char *path, void **buf,
+				loff_t *size, loff_t pos,
+				loff_t max_size, unsigned int flags,
+				enum kernel_read_file_id id)
 {
 	struct file *file;
 	int ret;
@@ -975,14 +1001,23 @@ int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	ret = kernel_read_file(file, buf, size, max_size, id);
+	ret = kernel_pread_file(file, buf, size, pos, max_size, flags, id);
 	fput(file);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(kernel_pread_file_from_path);
+
+int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
+			       loff_t max_size, enum kernel_read_file_id id)
+{
+	return kernel_pread_file_from_path(path, buf, size, 0, max_size,
+					   KERNEL_PREAD_FLAG_WHOLE, id);
+}
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
 
-int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
-			     enum kernel_read_file_id id)
+int kernel_pread_file_from_fd(int fd, void **buf, loff_t *size, loff_t pos,
+			      loff_t max_size, unsigned int flags,
+			      enum kernel_read_file_id id)
 {
 	struct fd f = fdget(fd);
 	int ret = -EBADF;
@@ -990,11 +1025,19 @@ int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
 	if (!f.file)
 		goto out;
 
-	ret = kernel_read_file(f.file, buf, size, max_size, id);
+	ret = kernel_pread_file(f.file, buf, size, pos, max_size, flags, id);
 out:
 	fdput(f);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(kernel_pread_file_from_fd);
+
+int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
+			     enum kernel_read_file_id id)
+{
+	return kernel_pread_file_from_fd(fd, buf, size, 0, max_size,
+					 KERNEL_PREAD_FLAG_WHOLE, id);
+}
 EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);
 
 ssize_t read_code(struct file *file, unsigned long addr, loff_t pos, size_t len)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f7fdfe93e25d..033a3e7f0015 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2942,10 +2942,25 @@ static inline const char *kernel_read_file_id_str(enum kernel_read_file_id id)
 	return kernel_read_file_str[id];
 }
 
+/* Flags used by kernel_pread_file functions */
+#define KERNEL_PREAD_FLAG_WHOLE	0x0000 /* Only Allow reading of whole file */
+#define KERNEL_PREAD_FLAG_PART	0x0001 /* Allow reading part of file */
+
+extern int kernel_pread_file(struct file *file, void **buf, loff_t *size,
+			     loff_t pos, loff_t max_size, unsigned int flags,
+			     enum kernel_read_file_id id);
 extern int kernel_read_file(struct file *, void **, loff_t *, loff_t,
 			    enum kernel_read_file_id);
+extern int kernel_pread_file_from_path(const char *path, void **buf,
+				       loff_t *size, loff_t pos,
+				       loff_t max_size, unsigned int flags,
+				       enum kernel_read_file_id id);
 extern int kernel_read_file_from_path(const char *, void **, loff_t *, loff_t,
 				      enum kernel_read_file_id);
+extern int kernel_pread_file_from_fd(int fd, void **buf, loff_t *size,
+				    loff_t pos, loff_t max_size,
+				    unsigned int flags,
+				    enum kernel_read_file_id id);
 extern int kernel_read_file_from_fd(int, void **, loff_t *, loff_t,
 				    enum kernel_read_file_id);
 extern ssize_t kernel_read(struct file *, void *, size_t, loff_t *);
-- 
2.17.1

