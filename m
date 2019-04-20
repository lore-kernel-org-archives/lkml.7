Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B50AC282E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 00:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F83E21479
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 00:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCdyD0t8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfDTAPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 20:15:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41281 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfDTAPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 20:15:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id 188so3153626pfd.8;
        Fri, 19 Apr 2019 17:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eMFDUMGPg9svBemR3kNl+I7JDj7h3EAZp1KY9ojzIcE=;
        b=SCdyD0t8NDNzdihEGSsf3RbYesAe2cvCjKRDzLZ6UW1K5RtzF79MbDe2MLUIy8cb6l
         E8yyJ8jdY+UVOXHUZ2hpgKspfXuh9pYIhU3SAeC0y4JoPsUzZsQZtK7DksLqgX027LTm
         JUSSvDs63zk+d2Ckb804pXjs7NKaCYg6bwUyrJu0og1VtBd7iM9cRUY+iSDzDpXx91wh
         H9oHFzTDFulekT7YQQfolAHzilNitl3GaW0Da87rm3e/93iFkDrPfGUSd9UmcC2+EFVs
         5cD7Ozg7ffHKPesRwOdlNhsh6vdv8peRlNwVeT/isklPUbpUvG2UAy6mVr66sKZ1BCJ1
         L51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eMFDUMGPg9svBemR3kNl+I7JDj7h3EAZp1KY9ojzIcE=;
        b=c1dQwSo6X93aLR+X5JwvpTSFOrXwe/Fn3Fax7axuomGnHpT9ZUiTKeVfiPgfzHo9Zd
         de+vijzEorglyoTbLl30fs5bMtvRYMvBZcGAv2oqG7GIzNcWJySb3WnIfUTVBxJzTGwr
         z7DEOo4MtFvelUAihP3RuXhFdJoUk1VLXc18tqdYW5DLaFf2hCKRgNTXvnnbUDD2J/lX
         WFvrcVYAg5/1rxqavSHFeQFbkuR2OoTyUp5GcA7Ch3k0v6DLyciw4nUtcOUQ/zukkIYk
         ITz2n2Oxj+qScxtl2NqK9dVftcjtfRd5mysmn6JFKWj7G+RVGHJ8e06nVhbdfIorGJkK
         78MQ==
X-Gm-Message-State: APjAAAVdQjoaBwyEd8oN4KuBCGuuMgHEH89Bs1YRgFepL8ffAhLyS1n2
        0jnOhoXk+pE+ydIE4yRqawMmWaNNjiA=
X-Google-Smtp-Source: APXvYqywUZe67MMD7vU+EraF76aWxm0b0ZHyJFcqF1pio2hb63Lew//h5HGHhSc7MAvrgv2RC48DXA==
X-Received: by 2002:a63:10c:: with SMTP id 12mr6846302pgb.276.1555719350968;
        Fri, 19 Apr 2019 17:15:50 -0700 (PDT)
Received: from prsriva-linux.corp.microsoft.com ([2001:4898:80e8:2:5828:72bc:96ef:ce7c])
        by smtp.gmail.com with ESMTPSA id a3sm8339902pfn.182.2019.04.19.17.15.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 17:15:49 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
X-Google-Original-From: Prakhar Srivastava
To:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     zohar@linux.vnet.ibm.com, ebiederm@xmission.com, vgoyal@redhat.com,
        Prakhar Srivastava <prsriva02@gmail.com>,
        Prakhar Srivastava <prsriva@microsoft.com>
Subject: [PATCH v2 2/3 RFC] use event name instead of enum to make the call generic
Date:   Fri, 19 Apr 2019 17:15:42 -0700
Message-Id: <20190420001543.6760-2-prsriva02@gmail.com>
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

remove enums to control type of buffers entries, instead pass the event name to be used.

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

