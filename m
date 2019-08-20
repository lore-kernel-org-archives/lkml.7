Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4AFC3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C200F2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LlqGJcsH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfHTAST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 20:18:19 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:52053 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728857AbfHTASQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 20:18:16 -0400
Received: by mail-vs1-f73.google.com with SMTP id 125so1387352vsr.18
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 17:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5YPIjXjcyEp11sfZB0ez9FVAI8/V2zY6x+YQLUd2pLU=;
        b=LlqGJcsHZG0rAhwIjpYeUnvxxoeUAmfOZOt+nqa6LavnvGsUgHr+vl9op71Xg7XcL4
         Aq5jGY8Pid90CkBr6npGC4H4YCMmTaDuhafRm1OhvmyNT+ai3pqE1zTJrhbr2CrofeaH
         GqFg3T0f+5N/J6GDp74sm4b4x5Kv58SKyoGdscTTQjVU/UeISpXH8GrD4xBoTavKg5Cc
         YnBzdR0WnIO4F5OHZsrMjaCkv5B/TJvNRfNoGRRdH2P4LtBCtTgmDfc7mES4vhvRxftf
         dlV9Pa09Z5/KaWa4cco+Rh7Q8KmHeKbHpsK42Q4pZbypI+xwmiYi5QknBZHMMYDj3gwV
         iK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5YPIjXjcyEp11sfZB0ez9FVAI8/V2zY6x+YQLUd2pLU=;
        b=NAZwfT7XlU+S4ZWkmXoE8zkQpzWAtENWLq0XeMrlOrYGx3mNbwB7MUWL27gXMZ25/S
         10Mk0+qAA3vfBy1ulxC8tM8Vzjuf/8ZWCylJihl5HVxDTBRXHJsywfsXokLjBi+MB5V3
         6mSj/0DGlkul18X+9CCyDZQwrwB4+5UDBvadwFJOUaD1zajlePl+dTKkuMlJQ5CZk5x2
         W9BQujCC0X+fX0CgbPSiP0fCQ8XZrEUPU94uvTP5eP/MhlZt5QNQRf2MBddANoxZzXH2
         dqJGB8C+3tCco1KZBHAbIECwTs2CoHELjIs3yO+3RTn/Sg0zmcWnp1gbgk/qtnSiqFSI
         uJmg==
X-Gm-Message-State: APjAAAWYe13bMm1kP5O4098HAqagik9AEfB7Pcf1QLUSWMvaNTrK1tVb
        UJ/6c0Uk/hW4IxTuNHtxECPJsaZESTgCspV9JpRJmw==
X-Google-Smtp-Source: APXvYqwDYnisDv+ixr6874+eJXMW4bVLtplZnZtow9TjHzzaCTwGHu/cXUBpz5qOOOksc7+5hHjiMZD3wHetsHlwBczTFg==
X-Received: by 2002:ab0:32d8:: with SMTP id f24mr8933854uao.121.1566260295200;
 Mon, 19 Aug 2019 17:18:15 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:38 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-3-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 02/29] security: Add a "locked down" LSM hook
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a mechanism to allow LSMs to make a policy decision around whether
kernel functionality that would allow tampering with or examining the
runtime state of the kernel should be permitted.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h |  7 +++++++
 include/linux/security.h  | 32 ++++++++++++++++++++++++++++++++
 security/security.c       |  6 ++++++
 3 files changed, 45 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index b02e8bb6654d..2f4ba9062fb8 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1446,6 +1446,11 @@
  * @bpf_prog_free_security:
  *	Clean up the security information stored inside bpf prog.
  *
+ * @locked_down
+ *     Determine whether a kernel feature that potentially enables arbitrary
+ *     code execution in kernel space should be permitted.
+ *
+ *     @what: kernel feature being accessed
  */
 union security_list_options {
 	int (*binder_set_context_mgr)(struct task_struct *mgr);
@@ -1807,6 +1812,7 @@ union security_list_options {
 	int (*bpf_prog_alloc_security)(struct bpf_prog_aux *aux);
 	void (*bpf_prog_free_security)(struct bpf_prog_aux *aux);
 #endif /* CONFIG_BPF_SYSCALL */
+	int (*locked_down)(enum lockdown_reason what);
 };
 
 struct security_hook_heads {
@@ -2046,6 +2052,7 @@ struct security_hook_heads {
 	struct hlist_head bpf_prog_alloc_security;
 	struct hlist_head bpf_prog_free_security;
 #endif /* CONFIG_BPF_SYSCALL */
+	struct hlist_head locked_down;
 } __randomize_layout;
 
 /*
diff --git a/include/linux/security.h b/include/linux/security.h
index c5dd90981c98..04cf48fab15d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -77,6 +77,33 @@ enum lsm_event {
 	LSM_POLICY_CHANGE,
 };
 
+/*
+ * These are reasons that can be passed to the security_locked_down()
+ * LSM hook. Lockdown reasons that protect kernel integrity (ie, the
+ * ability for userland to modify kernel code) are placed before
+ * LOCKDOWN_INTEGRITY_MAX.  Lockdown reasons that protect kernel
+ * confidentiality (ie, the ability for userland to extract
+ * information from the running kernel that would otherwise be
+ * restricted) are placed before LOCKDOWN_CONFIDENTIALITY_MAX.
+ *
+ * LSM authors should note that the semantics of any given lockdown
+ * reason are not guaranteed to be stable - the same reason may block
+ * one set of features in one kernel release, and a slightly different
+ * set of features in a later kernel release. LSMs that seek to expose
+ * lockdown policy at any level of granularity other than "none",
+ * "integrity" or "confidentiality" are responsible for either
+ * ensuring that they expose a consistent level of functionality to
+ * userland, or ensuring that userland is aware that this is
+ * potentially a moving target. It is easy to misuse this information
+ * in a way that could break userspace. Please be careful not to do
+ * so.
+ */
+enum lockdown_reason {
+	LOCKDOWN_NONE,
+	LOCKDOWN_INTEGRITY_MAX,
+	LOCKDOWN_CONFIDENTIALITY_MAX,
+};
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
@@ -393,6 +420,7 @@ void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+int security_locked_down(enum lockdown_reason what);
 #else /* CONFIG_SECURITY */
 
 static inline int call_lsm_notifier(enum lsm_event event, void *data)
@@ -1210,6 +1238,10 @@ static inline int security_inode_getsecctx(struct inode *inode, void **ctx, u32
 {
 	return -EOPNOTSUPP;
 }
+static inline int security_locked_down(enum lockdown_reason what)
+{
+	return 0;
+}
 #endif	/* CONFIG_SECURITY */
 
 #ifdef CONFIG_SECURITY_NETWORK
diff --git a/security/security.c b/security/security.c
index ef4a0111c8b4..7fc373486d7a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2389,3 +2389,9 @@ void security_bpf_prog_free(struct bpf_prog_aux *aux)
 	call_void_hook(bpf_prog_free_security, aux);
 }
 #endif /* CONFIG_BPF_SYSCALL */
+
+int security_locked_down(enum lockdown_reason what)
+{
+	return call_int_hook(locked_down, 0, what);
+}
+EXPORT_SYMBOL(security_locked_down);
-- 
2.23.0.rc1.153.gdeed80330f-goog

