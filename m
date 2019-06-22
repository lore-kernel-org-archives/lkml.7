Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EFFC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E3E2168B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q/D1El3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfFVAEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 20:04:08 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:32789 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfFVAEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 20:04:07 -0400
Received: by mail-qt1-f202.google.com with SMTP id r40so9843008qtk.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 17:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9daZa8/hqWzZuaGJLkwK103skAzbS3nFdoLOu7tsdHI=;
        b=Q/D1El3SijlLetTLADKIIte9tNRO98kykcjbvezzo8iX6ULzwvyyXXdR2qZPh+3i26
         1WbNkZ6l3vwcaw8ME7qaLeDwp41bwD8t/A4G9dsbhAxAbvpREcXGQ5PqicC98CXO/SXo
         8a73xkKgdAoHHhuRTn6JlCmlG9PTKLfbzl/vOxwt9G7grClG0hHLcwxVwxKwvl3J+SEk
         3mevF2DkRMytAztapn/3JDjXUkKUTvfId2XjFQ5pLAYBV0Xq7UVfKkb29LQ9TBVy2oCs
         hz0L+DiU6+PWc2LmT61ysG+fhiMaCTqt+tS+LRej/8oi9MH2EY+0zf/c+80BfhWsCciQ
         JlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9daZa8/hqWzZuaGJLkwK103skAzbS3nFdoLOu7tsdHI=;
        b=mPAJTr9wV1Uq5iO4bRPAeVVONLfDS7g1WJIGgGCKUvmMl3kDXSLb8pTH2g5SoLsoC6
         TaYAPKosHB0Mjr7bXfkRSrWP0XJbostr/QOL6vbhjGEohee7BPigWCxvvcwTf2NJ/pbZ
         QpSzNCXRRmZXqysvF+6NSj0tILB6H6pkNYEvbA4mxmOpeLfsAIUX3+NtIaY5rTeOx0Bn
         QRMJdstrgkcs4qn+vyGHSlI3toGZW4/6Vy9qil+vuaYHUqi3O97f0y4myEVF+ZrKSF0K
         iasNJy1/w59x5XGkfohTCOqb73pxK/Med95Jg2sO9kg2sRJBifGy7GvTI6hfEzuOuWsm
         3RDQ==
X-Gm-Message-State: APjAAAWMfnrWwkXhofRC86SYU2zsAEKVvIdx82ZU0VzkmAYR/HgWOjMr
        I8JLy0fwClB6u+Vqq5M9PNmPVzIORNXaapLmb7dIqg==
X-Google-Smtp-Source: APXvYqwEm732Qi02MQbmz5tHeH6REx4WGkn9c9y7/nSYBQO4mNr3qvTP2Xoo1l1CqZZadwnLtOwC5reFPVHmU9iHyMc2Ng==
X-Received: by 2002:a05:6214:222:: with SMTP id j2mr45977128qvt.121.1561161846752;
 Fri, 21 Jun 2019 17:04:06 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:31 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-3-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 02/29] security: Add a "locked down" LSM hook
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a mechanism to allow LSMs to make a policy decision around whether
kernel functionality that would allow tampering with or examining the
runtime state of the kernel should be permitted.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 include/linux/lsm_hooks.h |  2 ++
 include/linux/security.h  | 11 +++++++++++
 security/security.c       |  6 ++++++
 3 files changed, 19 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 66fd1eac7a32..df2aebc99838 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1790,6 +1790,7 @@ union security_list_options {
 	int (*bpf_prog_alloc_security)(struct bpf_prog_aux *aux);
 	void (*bpf_prog_free_security)(struct bpf_prog_aux *aux);
 #endif /* CONFIG_BPF_SYSCALL */
+	int (*locked_down)(enum lockdown_reason what);
 };
 
 struct security_hook_heads {
@@ -2027,6 +2028,7 @@ struct security_hook_heads {
 	struct hlist_head bpf_prog_alloc_security;
 	struct hlist_head bpf_prog_free_security;
 #endif /* CONFIG_BPF_SYSCALL */
+	struct hlist_head locked_down;
 } __randomize_layout;
 
 /*
diff --git a/include/linux/security.h b/include/linux/security.h
index 1bb6fb2f1523..9eaf02e70707 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -76,6 +76,12 @@ enum lsm_event {
 	LSM_POLICY_CHANGE,
 };
 
+enum lockdown_reason {
+	LOCKDOWN_NONE,
+	LOCKDOWN_INTEGRITY_MAX,
+	LOCKDOWN_CONFIDENTIALITY_MAX,
+};
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
@@ -389,6 +395,7 @@ void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+int security_locked_down(enum lockdown_reason what);
 #else /* CONFIG_SECURITY */
 
 static inline int call_lsm_notifier(enum lsm_event event, void *data)
@@ -1189,6 +1196,10 @@ static inline int security_inode_getsecctx(struct inode *inode, void **ctx, u32
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
index 487e1f3eb2df..553f50e9a106 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2382,3 +2382,9 @@ void security_bpf_prog_free(struct bpf_prog_aux *aux)
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
2.22.0.410.gd8fdbe21b5-goog

