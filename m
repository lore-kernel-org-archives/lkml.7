Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787E7C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D3E3217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWQhd5l0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbfDXAQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 20:16:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45043 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbfDXAPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 20:15:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id z16so3807877pgv.11;
        Tue, 23 Apr 2019 17:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=89tWsU/OT5SYrbjwn65xtN7OxFoXBZMgUvk/yoALgYk=;
        b=iWQhd5l06krXIiYuNCaoAfu33B+mMY6XiKj/UqyC5QO9cxDIdEptfEsXgyBCCTi+3K
         v5gPSSeZQkcCAZ5kYBtN564PrmPc/Fle0qag/MGw9r04/gL4RfpJd1P7IuoKyoXwtX/3
         DSaVKRcnMdfJGI6N+4LXOroRgyLEv0PywkZSW/IB5poFnaoWrvExUv4b1NM5KpEbbBKD
         Ec2SA5dTUeXb29Ti+OS5Xvzv+8GjmzaGPIbhXTldnYiw/AXrevqDKoDJ1/2WsVM00FJL
         OHWoBJpKItxBfPm2w5rgOvEDc2ur/PedQeEfL+LX1I2G1i1fmFIRxIB57o+htk0VL049
         t5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=89tWsU/OT5SYrbjwn65xtN7OxFoXBZMgUvk/yoALgYk=;
        b=kFFhcgm6HJdnuFOAyGMvuPKoVlII+bwqBYz4jVlg9H7Ci8pH3xDW6TUZ8CosvDbqlU
         3YpDZ8bolUkL11KPJRD92eP+QqF+9AV0PxtwIw3oX9D+HI16ln8kOu7UFiC22y59MS5N
         5Ti7r+lPXfjMIW/C9kJMw8Nb6MAHkg/8witGVHbqZxbzSNbJUJGRe1WMb0d9wp2l4dxv
         tDjmJ2CNeILQK85xqJt4r/w/a8XkHv2WVEOfLxFMWVZvYqKDSLEL5eYf2FSpRfwZSweT
         WH01bKEj3Gm+OljDIHalvPQGLMpzlO8E3G3w+eEhcmEyZk5aRVTyo60zkx44NQskRxq1
         gisg==
X-Gm-Message-State: APjAAAUBeoEEg7bw3OzLEQpDRgxQZrPmKkS9w+i7o2kbN60FmK9M8SbF
        HaEPhEII2WWi+f2Y08csSWs9KsIqG3s=
X-Google-Smtp-Source: APXvYqxyyq3ENNshaZc9kqkGoEhF0igoLz3AtTGKletUoYM2tNx41PFEbisTnOOBusmkrIWloxz+9w==
X-Received: by 2002:aa7:8208:: with SMTP id k8mr29977580pfi.69.1556064953277;
        Tue, 23 Apr 2019 17:15:53 -0700 (PDT)
Received: from prsriva-linux.corp.microsoft.com ([2001:4898:80e8:1:d4f:4d24:45fa:d461])
        by smtp.gmail.com with ESMTPSA id n21sm58955712pfb.42.2019.04.23.17.15.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 17:15:51 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
X-Google-Original-From: Prakhar Srivastava
To:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        inux-security-module@vger.kernel.org
Cc:     zohar@linux.ibm.com, ebiederm@xmission.com, vgoyal@redhat.com,
        Prakhar Srivastava <prsriva02@gmail.com>,
        Prakhar Srivastava <prsriva@microsoft.com>
Subject: [PATCH v2 3/5 RFC] since cmdline args can be same for multiple kexec, log entry hash will collide. Prepend the kernel file name to the cmdline args to distinguish between cmdline args passed to subsequent kexec calls
Date:   Tue, 23 Apr 2019 17:15:42 -0700
Message-Id: <20190424001544.7188-3-prsriva02@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190424001544.7188-1-prsriva02@gmail.com>
References: <20190424001544.7188-1-prsriva02@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prakhar Srivastava <prsriva02@gmail.com>

Signed-off-by: Prakhar Srivastava <prsriva@microsoft.com>
---

Currently for soft reboot(kexec_file_load) the kernel file and
signature is measured by IMA. The cmdline args used to load the kernel
is not measured.
The boot aggregate that gets calculated will have no change since the
EFI loader has not been triggered.
Adding the kexec cmdline args measure and kernel version will add some
attestable criteria.

Cmdline args can be same for multiple kexec, log entry
hash will collide. Prepend the kernel file name to the cmdline args to
distinguish between cmdline args passed to subsequent kexec calls

 kernel/kexec_core.c     | 57 +++++++++++++++++++++++++++++++++++++++++
 kernel/kexec_file.c     | 14 ++++++++--
 kernel/kexec_internal.h |  3 +++
 3 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index ae1a3ba24df5..97b77c780311 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1151,3 +1151,60 @@ void __weak arch_kexec_protect_crashkres(void)
 
 void __weak arch_kexec_unprotect_crashkres(void)
 {}
+
+/**
+ * kexec_cmdline_prepend_img_name - prepare the buffer with cmdline
+ * that needs to be measured
+ * @outbuf - out buffer that contains the formated string
+ * @kernel_fd - the file identifier for the kerenel image
+ * @cmdline_ptr - ptr to the cmdline buffer
+ * @cmdline_len - len of the buffer.
+ *
+ * This generates a buffer in the format Kerenelfilename::cmdline
+ *
+ * On success return 0.
+ * On failure return -EINVAL.
+ */
+int kexec_cmdline_prepend_img_name(char **outbuf, int kernel_fd,
+				const char *cmdline_ptr,
+				unsigned long cmdline_len)
+{
+	int ret = -EINVAL;
+	struct fd f = {};
+	int size = 0;
+	char *buf = NULL;
+	char delimiter[] = "::";
+
+	if (!outbuf || !cmdline_ptr)
+		goto out;
+
+	f = fdget(kernel_fd);
+	if (!f.file)
+		goto out;
+
+	size = (f.file->f_path.dentry->d_name.len + cmdline_len - 1+
+			ARRAY_SIZE(delimiter)) - 1;
+
+	buf = kzalloc(size, GFP_KERNEL);
+	if (!buf)
+		goto out;
+
+	memcpy(buf, f.file->f_path.dentry->d_name.name,
+		f.file->f_path.dentry->d_name.len);
+	memcpy(buf + f.file->f_path.dentry->d_name.len,
+		delimiter, ARRAY_SIZE(delimiter) - 1);
+	memcpy(buf + f.file->f_path.dentry->d_name.len +
+		ARRAY_SIZE(delimiter) - 1,
+		cmdline_ptr, cmdline_len - 1);
+
+	*outbuf = buf;
+	ret = size;
+
+	pr_debug("kexec cmdline buff: %s\n", buf);
+
+out:
+	if (f.file)
+		fdput(f);
+
+	return ret;
+}
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 2a5234eb4b28..a487491d55b9 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -126,6 +126,8 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	int ret = 0;
 	void *ldata;
 	loff_t size;
+	char *buff_to_measure = NULL;
+	int buff_to_measure_size = 0;
 
 	ret = kernel_read_file_from_fd(kernel_fd, &image->kernel_buf,
 				       &size, INT_MAX, READING_KEXEC_IMAGE);
@@ -183,8 +185,13 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 			goto out;
 		}
 
-		ima_buffer_check(image->cmdline_buf, cmdline_len - 1,
-				"kexec_cmdline");
+		/* IMA measures the cmdline args passed to the next kernel*/
+		buff_to_measure_size = kexec_cmdline_prepend_img_name(&buff_to_measure,
+			kernel_fd, image->cmdline_buf, image->cmdline_buf_len);
+
+		ima_buffer_check(buff_to_measure, buff_to_measure_size,
+					"kexec_cmdline");
+
 	}
 
 	/* Call arch image load handlers */
@@ -200,6 +207,9 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	/* In case of error, free up all allocated memory in this function */
 	if (ret)
 		kimage_file_post_load_cleanup(image);
+
+	kfree(buff_to_measure);
+
 	return ret;
 }
 
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 799a8a452187..4d34a8ef4637 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -11,6 +11,9 @@ int kimage_load_segment(struct kimage *image, struct kexec_segment *segment);
 void kimage_terminate(struct kimage *image);
 int kimage_is_destination_range(struct kimage *image,
 				unsigned long start, unsigned long end);
+int kexec_cmdline_prepend_img_name(char **outbuf, int kernel_fd,
+				const char *cmdline_ptr,
+				unsigned long cmdline_len);
 
 extern struct mutex kexec_mutex;
 
-- 
2.17.1

