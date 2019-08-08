Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB425C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 00:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE0321873
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 00:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k5u0bIMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730612AbfHHAHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 20:07:34 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:53676 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730579AbfHHAHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 20:07:31 -0400
Received: by mail-pf1-f202.google.com with SMTP id 191so57804182pfy.20
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 17:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WTiH4YTrH3kpcM05qpaK8fMoTjQf+8p0ghLlYf37sU8=;
        b=k5u0bIMeReHa+u8U1oaho5+bd9aZVBkqeL9pAoxaP/N2Vfv5BYLzVOAuYRJmpKdX/w
         YCY2N8bXrxG2q5KaaEX4M8E2e94BNqAOrDA6ynwmLf7fynrtSjoX6JkHYvM/e07TQKed
         YRWoCaLmIVkLEbdXPEkIoTEXjZBVM0FFBcsKRQFlR6n7HkvIWTWa8PXKMPyv/w9EgqHf
         LACKT+bboiR4A3usw7+OWkBN7rH73WpzNsAbUS/33tgPYYV+KNSUUZ7KqsIpq/XUNRvv
         2lkXE8txTKe5MwTrcCAoMsOG2+b/Cgl4yxF0ilAZKinN8gWE2Oyuht3tWnKGnogdhwEr
         J+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WTiH4YTrH3kpcM05qpaK8fMoTjQf+8p0ghLlYf37sU8=;
        b=rBwCW6zf6E20Jq+MLqbvLAFd0Cy1ZEfjafuNj9FCFRkh/xIuro3bP8QFR+QHCbpVnF
         m8hqDb/rhlRU1S/OQcJ0+kOAT075pMqW7yZaRv5dG2WsmTlS/mBFwsgCJ+9Filexhqs3
         6DAND26bzlxDeFnTtq0YkRonQecD21nM7a4/mfb7kn/6H+R9QnJih4Kdxu9Yjve+QTvP
         PjW3bzaEE/KBOyMkYsuxvWPjxpNn3IBirSgnaO50Si0kgTEFEFpK3V+uzzPLilr7sxTc
         dxzuK5GXFPrREG0NWYODPAWrHagJB7LDoh6VEckONSKwH/DTUxNfoiX8/F5n11yYSzw4
         jheQ==
X-Gm-Message-State: APjAAAViqcXgtN6V5EhwBTrVC54ZGKNQMu/WrQ6XoqL/gnIwaGI2L3Yd
        MNb/cc3dyus4L52YH3YRO2ZSENDplNFMWiuA6QvaiQ==
X-Google-Smtp-Source: APXvYqxWHpV4mvpFZRJ3iXuI2aome6WLXxXC8tZDwzQxqBjNyTSrD9vZ1m43zjxpBJARmgFJ6BoorgmzrSXy8rvXL+Mn/g==
X-Received: by 2002:a63:7709:: with SMTP id s9mr9754003pgc.296.1565222849856;
 Wed, 07 Aug 2019 17:07:29 -0700 (PDT)
Date:   Wed,  7 Aug 2019 17:06:54 -0700
In-Reply-To: <20190808000721.124691-1-matthewgarrett@google.com>
Message-Id: <20190808000721.124691-3-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V38 02/29] security: Add a "locked down" LSM hook
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
 include/linux/lsm_hooks.h |  2 ++
 include/linux/security.h  | 32 ++++++++++++++++++++++++++++++++
 security/security.c       |  6 ++++++
 3 files changed, 40 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index aebb0e032072..29c22cf40113 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1807,6 +1807,7 @@ union security_list_options {
 	int (*bpf_prog_alloc_security)(struct bpf_prog_aux *aux);
 	void (*bpf_prog_free_security)(struct bpf_prog_aux *aux);
 #endif /* CONFIG_BPF_SYSCALL */
+	int (*locked_down)(enum lockdown_reason what);
 };
 
 struct security_hook_heads {
@@ -2046,6 +2047,7 @@ struct security_hook_heads {
 	struct hlist_head bpf_prog_alloc_security;
 	struct hlist_head bpf_prog_free_security;
 #endif /* CONFIG_BPF_SYSCALL */
+	struct hlist_head locked_down;
 } __randomize_layout;
 
 /*
diff --git a/include/linux/security.h b/include/linux/security.h
index 66a2fcbe6ab0..c2b1204e8e26 100644
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
 
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
@@ -1205,6 +1233,10 @@ static inline int security_inode_getsecctx(struct inode *inode, void **ctx, u32
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
index 90f1e291c800..ce6c945bf347 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2392,3 +2392,9 @@ void security_bpf_prog_free(struct bpf_prog_aux *aux)
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
2.22.0.770.g0f2c4a37fd-goog

