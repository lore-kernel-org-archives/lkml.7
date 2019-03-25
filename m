Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F9FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA54F2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n3zobW7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731301AbfCYWLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:11:16 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:46829 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731252AbfCYWLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:11:10 -0400
Received: by mail-vk1-f201.google.com with SMTP id v82so4726064vkd.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oX6b6UXnLFndsb7tObotwtVDLDo+/sc4TNosNTsNVcE=;
        b=n3zobW7nksY3qoybt2xy2r7QRwNaPKsNzK7ZjnA/boc9nKSz+Su7uPl/+JupnTybMv
         /XeeRkIi2xuCtJQmbLrLR+10kfx/wGc61VHvQ7gztx1YC91CrYqyUiUmiGnrNBUfycfD
         jMSyri79P8gFp4TYefUuEvRv2SFiz6IJWZdAQ2fjDOtR35QpGRxpBq25z7Pa2bT1fCJ0
         /lR0QvzHUHFoOvwvj6cJNKhWotq8K+rxaTXRFY6GMl0ENOC8cepO3wUG+cUB419Oeh3M
         iHCvLAYu3WnUBgc0WcHilrF2fTeHWOoOJ+Gz7SCvGHguvir76jDiyLuOY5aFukASBQL6
         G2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oX6b6UXnLFndsb7tObotwtVDLDo+/sc4TNosNTsNVcE=;
        b=pr3Y/0ogeECXL6donqlaTasOnI7CB1QlcWIMERAM+H64O4qFUD8MBkIT4CO/sH4OUS
         0264cWl2HBBDZ/i8a7Pa/eHiNPzbe+9NIy6brZ284nhUdHF6x6pNg6Fktc0FHr/v4RY5
         +ONixD/4Z+ghV8M/tC0YjqFHoBXEO7VLXRTzB3WwaAJ04XClA/KM4mif4QAfIVRNP/9V
         rbAaGHX9rHb/4ZQ63mo3A78BSQoauGrgLPiKNgCxdtyJ5giwgk+fndwYIGlF0KLCJKuj
         jxzW5dKcbk7P5fkJGLgymXGbehqh430N/7XtdNnIihPntlg/dpFRZxuyC7eWJXzW3Xkw
         k+Ew==
X-Gm-Message-State: APjAAAUUYHc08wBUx5tYAlcx/ba+CgANVehgtXkb2GiK+Obpnzdx/o7N
        XgEgq/GxGC4qTbM35R1SAuL5nH1pEvQn5rquM1ejpQ==
X-Google-Smtp-Source: APXvYqzCpwMqlIY8s3ZXJhy4/xktxbcuRE1AUoDFA2gIf7tGU5DXdtz2c+CCt1ERYYG6SQktfyBy5XA5qh59xr5enW0ujA==
X-Received: by 2002:a67:fbc2:: with SMTP id o2mr2467492vsr.78.1553551868925;
 Mon, 25 Mar 2019 15:11:08 -0700 (PDT)
Date:   Mon, 25 Mar 2019 15:09:54 -0700
In-Reply-To: <20190325220954.29054-1-matthewgarrett@google.com>
Message-Id: <20190325220954.29054-28-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 27/27] kexec: Allow kexec_file() with appropriate IMA policy
 when locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Systems in lockdown mode should block the kexec of untrusted kernels.
For x86 and ARM we can ensure that a kernel is trustworthy by validating
a PE signature, but this isn't possible on other architectures. On those
platforms we can use IMA digital signatures instead. Add a function to
determine whether IMA has or will verify signatures for a given event type,
and if so permit kexec_file() even if the kernel is otherwise locked down.
This is restricted to cases where CONFIG_INTEGRITY_TRUSTED_KEYRING is set
in order to prevent an attacker from loading additional keys at runtime.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org
---
 include/linux/ima.h                 |  9 ++++++
 kernel/kexec_file.c                 |  7 +++-
 security/integrity/ima/ima.h        |  2 ++
 security/integrity/ima/ima_main.c   |  2 +-
 security/integrity/ima/ima_policy.c | 50 +++++++++++++++++++++++++++++
 5 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index b5e16b8c50b7..05921227d700 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -127,4 +127,13 @@ static inline int ima_inode_removexattr(struct dentry *dentry,
 	return 0;
 }
 #endif /* CONFIG_IMA_APPRAISE */
+
+#if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
+extern bool ima_appraise_signature(enum kernel_read_file_id func);
+#else
+static inline bool ima_appraise_kexec_signature(enum kernel_read_file_id func)
+{
+	return false;
+}
+#endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
 #endif /* _LINUX_IMA_H */
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 0cfe4f6f7f85..8ffa4b75c620 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -240,7 +240,12 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 
 		ret = 0;
 
-		if (kernel_is_locked_down(reason)) {
+		/* If IMA is guaranteed to appraise a signature on the kexec
+		 * image, permit it even if the kernel is otherwise locked
+		 * down.
+		 */
+		if (!ima_appraise_signature(READING_KEXEC_IMAGE) &&
+		    kernel_is_locked_down(reason)) {
 			ret = -EPERM;
 			goto out;
 		}
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index cc12f3449a72..fe03cc6f1ca4 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -115,6 +115,8 @@ struct ima_kexec_hdr {
 	u64 count;
 };
 
+extern const int read_idmap[];
+
 #ifdef CONFIG_HAVE_IMA_KEXEC
 void ima_load_kexec_buffer(void);
 #else
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 4ffac4f5c647..106f06dee9d1 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -442,7 +442,7 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 	return 0;
 }
 
-static const int read_idmap[READING_MAX_ID] = {
+const int read_idmap[READING_MAX_ID] = {
 	[READING_FIRMWARE] = FIRMWARE_CHECK,
 	[READING_FIRMWARE_PREALLOC_BUFFER] = FIRMWARE_CHECK,
 	[READING_MODULE] = MODULE_CHECK,
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 122797023bdb..f8f1cdb74a4f 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1341,3 +1341,53 @@ int ima_policy_show(struct seq_file *m, void *v)
 	return 0;
 }
 #endif	/* CONFIG_IMA_READ_POLICY */
+
+#if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
+/*
+ * ima_appraise_signature: whether IMA will appraise a given function using
+ * an IMA digital signature. This is restricted to cases where the kernel
+ * has a set of built-in trusted keys in order to avoid an attacker simply
+ * loading additional keys.
+ */
+bool ima_appraise_signature(enum kernel_read_file_id id)
+{
+	struct ima_rule_entry *entry;
+	bool found = false;
+	enum ima_hooks func;
+
+	if (id >= READING_MAX_ID)
+		return false;
+
+	func = read_idmap[id] ?: FILE_CHECK;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, ima_rules, list) {
+		if (entry->action != APPRAISE)
+			continue;
+
+		/*
+		 * A generic entry will match, but otherwise require that it
+		 * match the func we're looking for
+		 */
+		if (entry->func && entry->func != func)
+			continue;
+
+		/*
+		 * We require this to be a digital signature, not a raw IMA
+		 * hash.
+		 */
+		if (entry->flags & IMA_DIGSIG_REQUIRED)
+			found = true;
+
+		/*
+		 * We've found a rule that matches, so break now even if it
+		 * didn't require a digital signature - a later rule that does
+		 * won't override it, so would be a false positive.
+		 */
+		break;
+	}
+
+	rcu_read_unlock();
+	return found;
+}
+#endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
-- 
2.21.0.392.gf8f6787159e-goog

