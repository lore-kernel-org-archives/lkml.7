Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5D7C282E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 00:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EBCE21871
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 00:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCD82sAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfDTABH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 20:01:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35062 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfDTABF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 20:01:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id t21so3162891pfh.2;
        Fri, 19 Apr 2019 17:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6Udj6MDjEqWBRWB1i5C2xUr4MKRsbtdhAIzejy8vmow=;
        b=gCD82sAv+ZlkNXlJU9hJbOs5iCAmrfzB3oy6vpYE2sQLlUSPPhCqAr5yIbfLzs3U2r
         c5j7mYHcdZg8kwYaAy2L4pNIRd/77dMRdL1wtDVyuzepwdj+3ydnL5N3uF2ttBXJRJly
         FRdn4Fl5da8xORfgAZPVSg/2e8Fs7CixmAHoKKJkhcEKu+pdHrqvbAcgquSh+9jDHZaj
         VgNTKYnRR0DjmQ/YJwlxtS6KV4L+HdwL6OZBw+c/c+mAUupBEcDgAPg4I1ttpoug+7Hs
         Z+NC5pP9tk5WNC7pMM/TOHWJ457xHAdImb329PU1w0mLif2s+H+R/cZ4gmAO8HCPDzkp
         mdMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6Udj6MDjEqWBRWB1i5C2xUr4MKRsbtdhAIzejy8vmow=;
        b=jmOnmodMTibMPIDtC1x9YmMtBvZu+mD3JKMSVvVXNPRfizIUoNXnykTt2E6PNw7Fow
         RtqEJlUDLlYhooztiw/55eZCgJk+an2NKJAo8UyQoZu9Zr5nIyUtH0T4i2zXujvJ+zRU
         R/6Z0FvPq9g5/ATrc7yHEN+WV6+w+BLGuwR+FI5WUXX/C476LiJr9jN73wIEyZscAwAZ
         q50keJFN71cOZRvjpQ3lCT4CWbavM1hRE7EAQfx+qttZrnMZKKdCQRkEnFbvwcqMNF/o
         2qiekSihF1lwUI3o7EQEa2rERt3tWv57kOPb3QVcqf6CNAI+NpYpNzFB8ceA8O4i/aEk
         22MQ==
X-Gm-Message-State: APjAAAXkEBsqpr4Gs7IH4mX1A6giSwZwCmVwOPL4/Bhb2Mky/qnPVlN8
        QUiV/ILd5mBNsZ5AviYw21nx0xvH9i4=
X-Google-Smtp-Source: APXvYqyK+W7gLzZTugjx0dKijkj5bV/fhfWRonLPt/0OxjNSSdWurcgX8ghBFxSXzyLinNym0awu3Q==
X-Received: by 2002:a63:1b04:: with SMTP id b4mr4199312pgb.305.1555718464537;
        Fri, 19 Apr 2019 17:01:04 -0700 (PDT)
Received: from prsriva-linux.corp.microsoft.com ([2001:4898:80e8:2:5828:72bc:96ef:ce7c])
        by smtp.gmail.com with ESMTPSA id f5sm6699142pgo.75.2019.04.19.17.01.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 17:01:03 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
X-Google-Original-From: Prakhar Srivastava
To:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.vnet.ibm.com, Prakhar Srivastava <prsriva02@gmail.com>,
        Prakhar Srivastava <prsriva@microsoft.com>
Subject: [PATCHv2] use event name instead of enum to make the call generic
Date:   Fri, 19 Apr 2019 17:00:56 -0700
Message-Id: <20190420000057.5222-2-prsriva02@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420000057.5222-1-prsriva02@gmail.com>
References: <20190420000057.5222-1-prsriva02@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prakhar Srivastava <prsriva02@gmail.com>

Signed-off-by: Prakhar Srivastava <prsriva@microsoft.com>
---

remove enaums to control type of buffers entries, instead pass the event name to be used.

 include/linux/ima.h               | 10 ++--------
 kernel/kexec_file.c               |  3 +++
 security/integrity/ima/ima.h      |  2 +-
 security/integrity/ima/ima_main.c | 30 ++++++++++--------------------
 4 files changed, 16 insertions(+), 29 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 733d0cb9dedc..5e41507c57e5 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -14,12 +14,6 @@
 #include <linux/kexec.h>
 struct linux_binprm;
 
-enum __buffer_id {
-	KERNEL_VERSION,
-	KEXEC_CMDLINE,
-	MAX_BUFFER_ID = KEXEC_CMDLINE
-} buffer_id;
-
 #ifdef CONFIG_IMA
 extern int ima_bprm_check(struct linux_binprm *bprm);
 extern int ima_file_check(struct file *file, int mask, int opened);
@@ -29,7 +23,7 @@ extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
 extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
 extern void ima_post_path_mknod(struct dentry *dentry);
-extern void ima_buffer_check(const void *buff, int size, enum buffer_id id);
+extern void ima_buffer_check(const void *buff, int size, char *eventname);
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
 #endif
@@ -72,7 +66,7 @@ static inline void ima_post_path_mknod(struct dentry *dentry)
 }
 
 static inline void ima_buffer_check(const void *buff, int size,
-			enum buffer_id id)
+			char *eventname)
 {
 	return;
 }
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index b118735fea9d..2a5234eb4b28 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -182,6 +182,9 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 			ret = -EINVAL;
 			goto out;
 		}
+
+		ima_buffer_check(image->cmdline_buf, cmdline_len - 1,
+				"kexec_cmdline");
 	}
 
 	/* Call arch image load handlers */
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index b71f2f6f7421..fcade3c103ed 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -181,8 +181,8 @@ enum ima_hooks {
 	FIRMWARE_CHECK,
 	KEXEC_KERNEL_CHECK,
 	KEXEC_INITRAMFS_CHECK,
-	BUFFER_CHECK,
 	POLICY_CHECK,
+	BUFFER_CHECK,
 	MAX_CHECK
 };
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 6408cadaadbb..da82c705a5ed 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -160,8 +160,7 @@ void ima_file_free(struct file *file)
  * (Instead of using the file hash the buffer hash is used).
  * @buff - The buffer that needs to be added to the log
  * @size - size of buffer(in bytes)
- * @id - buffer id, this is differentiator for the various buffers
- * that can be measured.
+ * @id - eventname, event name to be used for buffer measurement.
  *
  * The buffer passed is added to the ima logs.
  * If the sig template is used, then the sig field contains the buffer.
@@ -170,7 +169,7 @@ void ima_file_free(struct file *file)
  * On error cases surface errors from ima calls.
  */
 static int process_buffer_measurement(const void *buff, int size,
-				enum buffer_id id)
+				char *eventname)
 {
 	int ret = -EINVAL;
 	struct ima_template_entry *entry = NULL;
@@ -185,23 +184,13 @@ static int process_buffer_measurement(const void *buff, int size,
 	int violation = 0;
 	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
 
-	if (!buff || size ==  0)
+	if (!buff || size ==  0 || !eventname)
 		goto err_out;
 
 	if (ima_get_action(NULL, 0, BUFFER_CHECK, &pcr) != IMA_MEASURE)
 		goto err_out;
 
-	switch (buffer_id) {
-	case KERNEL_VERSION:
-		name = "Kernel-version";
-		break;
-	case KEXEC_CMDLINE:
-		name = "Kexec-cmdline";
-		break;
-	default:
-		goto err_out;
-	}
-
+	name = eventname;
 	memset(iint, 0, sizeof(*iint));
 	memset(&hash, 0, sizeof(hash));
 
@@ -452,15 +441,16 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
  * ima_buffer_check - based on policy, collect & store buffer measurement
  * @buf: pointer to buffer
  * @size: size of buffer
- * @buffer_id: caller identifier
+ * @eventname: caller identifier
  *
  * Buffers can only be measured, not appraised.  The buffer identifier
- * is used as the measurement list entry name (eg. boot_cmdline).
+ * is used as the measurement list entry name (eg. boot_cmdline,
+ * kernel_version).
  */
-void ima_buffer_check(const void *buf, int size, enum buffer_id id)
+void ima_buffer_check(const void *buf, int size, char *eventname)
 {
-	if (buf && size != 0)
-		process_buffer_measurement(buf, size, id);
+	if (buf && size != 0 && eventname)
+		process_buffer_measurement(buf, size, eventname);
 
 	return;
 }
-- 
2.17.1

