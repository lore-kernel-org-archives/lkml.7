Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58DAC282E3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 00:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973DF21855
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 00:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caxaNmAr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfDTAPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 20:15:54 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43128 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbfDTAPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 20:15:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id n8so3208101plp.10;
        Fri, 19 Apr 2019 17:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=89tWsU/OT5SYrbjwn65xtN7OxFoXBZMgUvk/yoALgYk=;
        b=caxaNmAr98e1Z07q/VdVXR2cdbkxvt0ij/qD+nz6st0OJIM66GbQdII6QNhy2G683g
         GcefLJltQFAWVCX+J1EkWLoC9k9fG2YB04sREBg51JY6Q172mvr7kRMf9e63J6ijHm5O
         mLAFGvTIJ71j/q5mFEM89+wuPyMfIJm2qZAzLo6pvBlxm4+u/ycM7/vWLqzPpUmbpKyG
         4+4utrKZxBxIx8se+azpuwQ/U4+K3qdXbRHYsNijuRNIcI7qNCObPlQhjEoWyYpOBMLy
         /ZdTWacRBSYVJbWQrVAwF4Zf8sPQBFM2DQ2Uk/YFDInx1WnWhCMcScnCkGleN2PQXcT5
         4mtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=89tWsU/OT5SYrbjwn65xtN7OxFoXBZMgUvk/yoALgYk=;
        b=Y7kAMaLNyPebPHI0BgJDZuCAhi9ovbktER1uZtbXPtapW+Fu1NRFxBqsoDmcqku/Jc
         cqOH2+Y+xN3AZvlasm4GO/Hcs+U4fuc97LuhqnCJ8MCFpHmTIuIplZa9yKjai62u/llC
         QGJVzuJi2d8suae5CwoVE49TTw6Ly5kPL4mgxzMFMhOsGIBmwQMIoHiGH6SpT2RVM6Xi
         MlnBq7GZo0rInkeR7sBOdCczoVzJlAmWxF2L3ujoF+Zs15E9+MSyWFcgpzQqJyjgNQKs
         eNASMRimO+fsziYkbW/8PwJQGFGGRG3WLCY+tZvoU1LTyZjb9zJvD6GpgEYFyxwzg+G1
         g7jA==
X-Gm-Message-State: APjAAAU1a0SLRbTKYPk6LxuAbKwWhCbbZW3014EQ/YOxaLs9P5KvVNwg
        XsT4VPSaUuPsCdDoE9WWtsjEZGDpj1E=
X-Google-Smtp-Source: APXvYqyTxq2Z5dU4I+e4VPdnoXkBsRm6nfrvXB314dNiWiHFwvVNPMKMA8xHlPMfe5wK+uMnS5XiJA==
X-Received: by 2002:a17:902:ea8d:: with SMTP id cv13mr65059plb.23.1555719352046;
        Fri, 19 Apr 2019 17:15:52 -0700 (PDT)
Received: from prsriva-linux.corp.microsoft.com ([2001:4898:80e8:2:5828:72bc:96ef:ce7c])
        by smtp.gmail.com with ESMTPSA id a3sm8339902pfn.182.2019.04.19.17.15.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 17:15:51 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
X-Google-Original-From: Prakhar Srivastava
To:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     zohar@linux.vnet.ibm.com, ebiederm@xmission.com, vgoyal@redhat.com,
        Prakhar Srivastava <prsriva02@gmail.com>,
        Prakhar Srivastava <prsriva@microsoft.com>
Subject: [PATCH v2 3/3 RFC] since cmdline args can be same for multiple kexec, log entry hash will collide. Prepend the kernel file name to the cmdline args to distinguish between cmdline args passed to subsequent kexec calls
Date:   Fri, 19 Apr 2019 17:15:43 -0700
Message-Id: <20190420001543.6760-3-prsriva02@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420001543.6760-1-prsriva02@gmail.com>
References: <20190420001543.6760-1-prsriva02@gmail.com>
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

