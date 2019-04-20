Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210FDC282E3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 00:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01C221855
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 00:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYbYmOix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfDTAPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 20:15:51 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36466 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfDTAPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 20:15:50 -0400
Received: by mail-pl1-f195.google.com with SMTP id ck15so3231255plb.3;
        Fri, 19 Apr 2019 17:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WvABMMiydtEeyibegfEfLEBkYjxrs2E70YFNAbmjJWA=;
        b=SYbYmOix/0fDgJ+jIEtXGlSk/S6Iecnq23aqKgohyCHBnrnWnGsxbzrNO/ZmWWpW3v
         5RKHLbf6gXnk0MVse0Yse4fGMotXuE3z3QPPLjuXYUrnJgosGiGyrUPzwZeFFApn4eEX
         ft4nQ7xdDe0dO8cA7wxhQ1pzfSSPRSPe89mOwo7ApCCwud/DQCnNzq61BVJa3dxfeSvz
         b9a/bWeBOHy0kzHUStdtcQB0N4ld510TLHkOu+Z1C/G/8evVkIXaEcLSQKUllQDXqj3f
         xe6JuKDdeeryznq3Kt1AVQxI2C0J4sTgj0qNOPviPNARhysIhN8DMS7lLcQqGG3i+hrE
         MKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WvABMMiydtEeyibegfEfLEBkYjxrs2E70YFNAbmjJWA=;
        b=hYCwrvFwvWgAVEorYtC0TMJK6rQj2Y7ANqH6bibZat66ASruB3c5F07PgAThVqFiX9
         fgzXnZ5wO8ONTk9+BQivuEDJWj33vt/z/vnFI0adzjlv7ciGUOWU3opdn5/I6LTEmvKG
         Ow44nfibDU57yp+iCu8vqZlLsNfrlYqscX4VNhkC5F+6Pr/8kNLYOLKeUeL/zh/RurNB
         BjDGISKtHZsVSogEbfTH/WSye3LN+2z5eP/J19VOMTcSWjtKwfgMKkGB54rYgHxhvkpo
         tvSHoVhhSv3vE3LcJUgtehCNNW/N4cZ94MldJfX6uGTQBZQQrONvZcAC2MrTpEk7cUJy
         tGhA==
X-Gm-Message-State: APjAAAU3zSvVcA3sQz67mWLTdYCLQZkDSxAKwqOm+/NQFcv5+SJHwx8z
        PyEeFWQX9eeFKlQCPHf64hO9k0H8aTc=
X-Google-Smtp-Source: APXvYqyo+o72spNAex9YybsclXDofwBaPYXwVpYYqF434YbuKtAYU1Wf47s61RwT5bLcwkg1nT8Bcg==
X-Received: by 2002:a17:902:31c3:: with SMTP id x61mr6596398plb.143.1555719349744;
        Fri, 19 Apr 2019 17:15:49 -0700 (PDT)
Received: from prsriva-linux.corp.microsoft.com ([2001:4898:80e8:2:5828:72bc:96ef:ce7c])
        by smtp.gmail.com with ESMTPSA id a3sm8339902pfn.182.2019.04.19.17.15.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 17:15:48 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
X-Google-Original-From: Prakhar Srivastava
To:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     zohar@linux.vnet.ibm.com, ebiederm@xmission.com, vgoyal@redhat.com,
        Prakhar Srivastava <prsriva02@gmail.com>,
        Prakhar Srivastava <prsriva@microsoft.com>
Subject: [PATCH v2 1/3 RFC] added ima hook for buffer, being enabled as a policy
Date:   Fri, 19 Apr 2019 17:15:41 -0700
Message-Id: <20190420001543.6760-1-prsriva02@gmail.com>
X-Mailer: git-send-email 2.17.1
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

This adds a new ima hook ima_buffer_check and a policy entry BUFFER_CHECK.
This enables buffer has measurements into ima log

 Documentation/ABI/testing/ima_policy |  1 +
 include/linux/ima.h                  | 13 +++-
 security/integrity/ima/ima.h         |  1 +
 security/integrity/ima/ima_main.c    | 95 ++++++++++++++++++++++++++++
 security/integrity/ima/ima_policy.c  | 14 +++-
 5 files changed, 122 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index bb0f9a135e21..676088c7ab26 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -28,6 +28,7 @@ Description:
 		base: 	func:= [BPRM_CHECK][MMAP_CHECK][FILE_CHECK][MODULE_CHECK]
 				[FIRMWARE_CHECK]
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
+				[BUFFER_CHECK]
 			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
 			       [[^]MAY_EXEC]
 			fsmagic:= hex value
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 7f6952f8d6aa..733d0cb9dedc 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -14,6 +14,12 @@
 #include <linux/kexec.h>
 struct linux_binprm;
 
+enum __buffer_id {
+	KERNEL_VERSION,
+	KEXEC_CMDLINE,
+	MAX_BUFFER_ID = KEXEC_CMDLINE
+} buffer_id;
+
 #ifdef CONFIG_IMA
 extern int ima_bprm_check(struct linux_binprm *bprm);
 extern int ima_file_check(struct file *file, int mask, int opened);
@@ -23,7 +29,7 @@ extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
 extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
 extern void ima_post_path_mknod(struct dentry *dentry);
-
+extern void ima_buffer_check(const void *buff, int size, enum buffer_id id);
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
 #endif
@@ -65,6 +71,11 @@ static inline void ima_post_path_mknod(struct dentry *dentry)
 	return;
 }
 
+static inline void ima_buffer_check(const void *buff, int size,
+			enum buffer_id id)
+{
+	return;
+}
 #endif /* CONFIG_IMA */
 
 #ifndef CONFIG_IMA_KEXEC
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index b563fbd4d122..b71f2f6f7421 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -181,6 +181,7 @@ enum ima_hooks {
 	FIRMWARE_CHECK,
 	KEXEC_KERNEL_CHECK,
 	KEXEC_INITRAMFS_CHECK,
+	BUFFER_CHECK,
 	POLICY_CHECK,
 	MAX_CHECK
 };
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 2aebb7984437..6408cadaadbb 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -155,6 +155,84 @@ void ima_file_free(struct file *file)
 	ima_check_last_writer(iint, inode, file);
 }
 
+/*
+ * process_buffer_measurement - Measure the buffer passed to ima log.
+ * (Instead of using the file hash the buffer hash is used).
+ * @buff - The buffer that needs to be added to the log
+ * @size - size of buffer(in bytes)
+ * @id - buffer id, this is differentiator for the various buffers
+ * that can be measured.
+ *
+ * The buffer passed is added to the ima logs.
+ * If the sig template is used, then the sig field contains the buffer.
+ *
+ * On success return 0.
+ * On error cases surface errors from ima calls.
+ */
+static int process_buffer_measurement(const void *buff, int size,
+				enum buffer_id id)
+{
+	int ret = -EINVAL;
+	struct ima_template_entry *entry = NULL;
+	struct integrity_iint_cache tmp_iint, *iint = &tmp_iint;
+	struct ima_event_data event_data = {iint, NULL, NULL,
+					    NULL, 0, NULL};
+	struct {
+		struct ima_digest_data hdr;
+		char digest[IMA_MAX_DIGEST_SIZE];
+	} hash;
+	char *name = NULL;
+	int violation = 0;
+	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
+
+	if (!buff || size ==  0)
+		goto err_out;
+
+	if (ima_get_action(NULL, 0, BUFFER_CHECK, &pcr) != IMA_MEASURE)
+		goto err_out;
+
+	switch (buffer_id) {
+	case KERNEL_VERSION:
+		name = "Kernel-version";
+		break;
+	case KEXEC_CMDLINE:
+		name = "Kexec-cmdline";
+		break;
+	default:
+		goto err_out;
+	}
+
+	memset(iint, 0, sizeof(*iint));
+	memset(&hash, 0, sizeof(hash));
+
+	event_data.filename = name;
+
+	iint->ima_hash = &hash.hdr;
+	iint->ima_hash->algo = ima_hash_algo;
+	iint->ima_hash->length = hash_digest_size[ima_hash_algo];
+
+	ret = ima_calc_buffer_hash(buff, size, iint->ima_hash);
+	if (ret < 0)
+		goto err_out;
+
+	ret = ima_alloc_init_template(&event_data, &entry);
+	if (ret < 0)
+		goto err_out;
+
+	ret = ima_store_template(entry, violation, NULL,
+					buff, pcr);
+	if (ret < 0) {
+		ima_free_template_entry(entry);
+		goto err_out;
+	}
+
+	return 0;
+
+err_out:
+	pr_err("Error in adding buffer measure: %d\n", ret);
+	return ret;
+}
+
 static int process_measurement(struct file *file, char *buf, loff_t size,
 			       int mask, enum ima_hooks func, int opened)
 {
@@ -370,6 +448,23 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 	return 0;
 }
 
+/**
+ * ima_buffer_check - based on policy, collect & store buffer measurement
+ * @buf: pointer to buffer
+ * @size: size of buffer
+ * @buffer_id: caller identifier
+ *
+ * Buffers can only be measured, not appraised.  The buffer identifier
+ * is used as the measurement list entry name (eg. boot_cmdline).
+ */
+void ima_buffer_check(const void *buf, int size, enum buffer_id id)
+{
+	if (buf && size != 0)
+		process_buffer_measurement(buf, size, id);
+
+	return;
+}
+
 static int read_idmap[READING_MAX_ID] = {
 	[READING_FIRMWARE] = FIRMWARE_CHECK,
 	[READING_MODULE] = MODULE_CHECK,
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 3ab1067db624..cefe1a188f31 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -231,6 +231,12 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 	const struct cred *cred = current_cred();
 	int i;
 
+	// Incase of BUFFER_CHECK, Inode is NULL
+	if (!inode) {
+		if ((rule->flags & IMA_FUNC) && (rule->func == func))
+			return true;
+		return false;
+	}
 	if ((rule->flags & IMA_FUNC) &&
 	    (rule->func != func && func != POST_SETATTR))
 		return false;
@@ -665,6 +671,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			else if (strcmp(args[0].from, "KEXEC_INITRAMFS_CHECK")
 				 == 0)
 				entry->func = KEXEC_INITRAMFS_CHECK;
+			else if (strcmp(args[0].from, "BUFFER_CHECK") == 0)
+				entry->func = BUFFER_CHECK;
 			else if (strcmp(args[0].from, "POLICY_CHECK") == 0)
 				entry->func = POLICY_CHECK;
 			else
@@ -944,7 +952,7 @@ enum {
 	func_file = 0, func_mmap, func_bprm,
 	func_module, func_firmware, func_post,
 	func_kexec_kernel, func_kexec_initramfs,
-	func_policy
+	func_buffer, func_policy
 };
 
 static char *func_tokens[] = {
@@ -956,6 +964,7 @@ static char *func_tokens[] = {
 	"POST_SETATTR",
 	"KEXEC_KERNEL_CHECK",
 	"KEXEC_INITRAMFS_CHECK",
+	"BUFFER_CHECK",
 	"POLICY_CHECK"
 };
 
@@ -1027,6 +1036,9 @@ static void policy_func_show(struct seq_file *m, enum ima_hooks func)
 	case KEXEC_INITRAMFS_CHECK:
 		seq_printf(m, pt(Opt_func), ft(func_kexec_initramfs));
 		break;
+	case BUFFER_CHECK:
+		seq_printf(m, pt(Opt_func), ft(func_buffer));
+		break;
 	case POLICY_CHECK:
 		seq_printf(m, pt(Opt_func), ft(func_policy));
 		break;
-- 
2.17.1

