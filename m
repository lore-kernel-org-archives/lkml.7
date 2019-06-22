Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC12C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7AE520656
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p7vfmYbi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfFVAFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 20:05:10 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:41613 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfFVAFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 20:05:06 -0400
Received: by mail-pg1-f201.google.com with SMTP id x3so4999065pgp.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 17:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TMklhc9+XfiI8L3K2AutSbeZaJ7HLQ2HsXG+mlV/TZs=;
        b=p7vfmYbicP0O5OJzjFHdr94n1dC4CJO8yX/92U2d2BTbbGPpuy00yXNd9NLehfmCFV
         5XqqdDRq+j7IDKg4ECOxaLzyDNdD8IRWnSj4RlJg+fnqujjgDyfVtsIJ9EOZPvHQpXUF
         rFQ6bRCqsV8oHm1TLKJCR1V5tdwwsJJaH3HL1oCf+hG2ILKmD0gxGnsJmF9ggXD1qJsP
         dyX+p6/3+RHtCJNz5ZK7L9Ir/FRDlefa1IqIXWmOpCGGurVyGN5/+sfdEvh3UMqC2Utp
         4zkAY8boj/uZNoZnDEBzHHNWlw88TuW2EXhkMlcVLRtlhNAVlAt/WOZPPBD7NHwAMiy5
         zcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TMklhc9+XfiI8L3K2AutSbeZaJ7HLQ2HsXG+mlV/TZs=;
        b=cHg7stljlKKjR3ddaGfjMko2Cv4RD3tu5NBCXWVRzNWzqawXh5b5EYItAmBR+zWd4B
         etQWhiQhPmMnbazPXc7Q2P0QDNagr3/DzuK6n1R+JMxQwaYEpr96Tvaf17xZdqErSKEd
         soKVJQ+TALnlcRIei3vkiUUV/eGWIHGcQ/6O/Xq7j5oxXWXON5+0Xy5rZaTlD1d7KxHU
         vQkUJ0EElLJ6FPe993NIWwL26tEZ99eqitpaHFBJna2JcoT6Vh1++yfEYM4Z9X6Ge+qM
         s1UQtiSORoEWv/+rN4oo8/F34g7KLzOtr4PYqZiSlgCPgNbqBPb+sUE6VsEnGJ5DbsqF
         gobA==
X-Gm-Message-State: APjAAAXOg0McvAXpPR+2mUkIgXsmHB1lpksttfii4O9N5QMEp7uBWztf
        uC13ynYNYYB8PvNb0xrwRgmd34FTlagnRloSG8DyCw==
X-Google-Smtp-Source: APXvYqyiFQ+2Cd5OSyAvJhYhgYOd8VHPKVlHOgHk3dAwEgc6MxZt9cRi1sgqABuTYgGBeTygjlYiJdOudBsv5yQQd+2tYg==
X-Received: by 2002:a63:2258:: with SMTP id t24mr12689918pgm.236.1561161904729;
 Fri, 21 Jun 2019 17:05:04 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:54 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-26-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 25/29] kexec: Allow kexec_file() with appropriate IMA
 policy when locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
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
Acked-by: Mimi Zohar <zohar@linux.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org
---
 include/linux/ima.h                 |  9 ++++++
 kernel/kexec_file.c                 | 11 +++++--
 security/integrity/ima/ima.h        |  2 ++
 security/integrity/ima/ima_main.c   |  2 +-
 security/integrity/ima/ima_policy.c | 50 +++++++++++++++++++++++++++++
 5 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index dc12fbcf484c..c30954acc660 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -132,4 +132,13 @@ static inline int ima_inode_removexattr(struct dentry *dentry,
 	return 0;
 }
 #endif /* CONFIG_IMA_APPRAISE */
+
+#if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
+extern bool ima_appraise_signature(enum kernel_read_file_id func);
+#else
+static inline bool ima_appraise_signature(enum kernel_read_file_id func)
+{
+	return false;
+}
+#endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
 #endif /* _LINUX_IMA_H */
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 27adb4312b03..539d0ca855bc 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -237,8 +237,15 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 			goto out;
 		}
 
-		ret = security_locked_down(LOCKDOWN_KEXEC);
-		if (ret)
+		ret = 0;
+
+		/* If IMA is guaranteed to appraise a signature on the kexec
+		 * image, permit it even if the kernel is otherwise locked
+		 * down.
+		 */
+		if (!ima_appraise_signature(READING_KEXEC_IMAGE) &&
+		    security_locked_down(LOCKDOWN_KEXEC)) {
+			ret = -EPERM;
 			goto out;
 
 		break;
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index d213e835c498..3bc62062cfe8 100644
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
index 357edd140c09..927fe889201a 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -473,7 +473,7 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 	return 0;
 }
 
-static const int read_idmap[READING_MAX_ID] = {
+const int read_idmap[READING_MAX_ID] = {
 	[READING_FIRMWARE] = FIRMWARE_CHECK,
 	[READING_FIRMWARE_PREALLOC_BUFFER] = FIRMWARE_CHECK,
 	[READING_MODULE] = MODULE_CHECK,
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index e0cc323f948f..8784449918e2 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1339,3 +1339,53 @@ int ima_policy_show(struct seq_file *m, void *v)
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
2.22.0.410.gd8fdbe21b5-goog

