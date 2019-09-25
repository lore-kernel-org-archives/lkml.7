Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A662FC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 21:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF2921D7A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 21:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PhYrdbXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393522AbfIYVCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 17:02:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37718 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfIYVCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 17:02:37 -0400
Received: by mail-pf1-f194.google.com with SMTP id y5so196734pfo.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 14:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=7xhrP95QBYJiSF2YxdsM/vyNYpW4G7L9q0PwFgts0Eg=;
        b=PhYrdbXFW7DxjoTBihqkbscUj3ihaM+7AY9Uko1qzd/uFoRL8eCcWcrRFhuukFI+Oz
         tHzDS4E8nYIttCuj/nMIfyN+ttt8eZInD6Ld0sgEK6AuJlEQGAUO5CV2x0pMB6curxMS
         NQeJZM+/oKiZHqo7s+oNvkBKelSGTUnca6lg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=7xhrP95QBYJiSF2YxdsM/vyNYpW4G7L9q0PwFgts0Eg=;
        b=N1i4VHaGlNOZykAcJxm9a+BYfJLA4s8C6ODqUlmUuQyGuW+ld7kXS9xN0FRrRi9tyx
         472akzd9mXx9744tyQpYjFVCYCnIfnFVpx5mslkwYqlN0ZniZ6KNj8RVCvNZnapd4UZV
         5jIWR2KLPTTo3k4Pw8KCTUZu3n7NBJXtfBFNUBG5FwiGI7K+Gn/bxiTJoujDI6p26pOi
         d3MPJDQWLzrDiPPzPQSJ/x15YnDqW+z3foqs0ixs3iYZS707gTCOxSpdh6eQYKEhYCt8
         sEr8RXIbpUExLenPvIRJwAz5mFhF95Abh3toxEVAO/hoo0hLBGczXw6ryiyDPo1PDasr
         h5Kw==
X-Gm-Message-State: APjAAAWDtljf1yw4Pj6LzYLvKjfhjZ4pD+2odSccLeAJrILtVHPxE4NY
        PXt7kBcdtDMw52qPcjUKj6jVyQ==
X-Google-Smtp-Source: APXvYqy8enN66HCBAXgdyj2WiN3UN+3QBv7218MOZV3xhCqI5u1BW3NXe4CmUibg81qEWdaXeJbpZA==
X-Received: by 2002:a17:90a:8c14:: with SMTP id a20mr8916240pjo.45.1569445355367;
        Wed, 25 Sep 2019 14:02:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p66sm13856502pfg.127.2019.09.25.14.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 14:02:34 -0700 (PDT)
Date:   Wed, 25 Sep 2019 14:02:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau 
        <jeremie.galarneau@efficios.com>, s.mesoraca16@gmail.com,
        viro@zeniv.linux.org.uk, dan.carpenter@oracle.com,
        akpm@linux-foundation.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        kernel-hardening@lists.openwall.com, linux-audit@redhat.com,
        torvalds@linux-foundation.org
Subject: [PATCH] audit: Report suspicious O_CREAT usage
Message-ID: <201909251348.A1542A52@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This renames the very specific audit_log_link_denied() to
audit_log_path_denied() and adds the AUDIT_* type as an argument. This
allows for the creation of the new AUDIT_ANOM_CREAT that can be used to
report the fifo/regular file creation restrictions that were introduced
in commit 30aba6656f61 ("namei: allow restricted O_CREAT of FIFOs and
regular files"). Without this change, discovering that the restriction
is enabled can be very challenging:
https://lore.kernel.org/lkml/CA+jJMxvkqjXHy3DnV5MVhFTL2RUhg0WQ-XVFW3ngDQOdkFq0PA@mail.gmail.com

Reported-by: Jérémie Galarneau <jeremie.galarneau@efficios.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
This is not a complete fix because reporting was broken in commit
15564ff0a16e ("audit: make ANOM_LINK obey audit_enabled and
audit_dummy_context")
which specifically goes against the intention of these records: they
should _always_ be reported. If auditing isn't enabled, they should be
ratelimited.

Instead of using audit, should this just go back to using
pr_ratelimited()?
---
 fs/namei.c                 |  7 +++++--
 include/linux/audit.h      |  5 +++--
 include/uapi/linux/audit.h |  1 +
 kernel/audit.c             | 11 ++++++-----
 4 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 671c3c1a3425..0e60f81e1d5a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -925,7 +925,7 @@ static inline int may_follow_link(struct nameidata *nd)
 		return -ECHILD;
 
 	audit_inode(nd->name, nd->stack[0].link.dentry, 0);
-	audit_log_link_denied("follow_link");
+	audit_log_path_denied(AUDIT_ANOM_LINK, "follow_link");
 	return -EACCES;
 }
 
@@ -993,7 +993,7 @@ static int may_linkat(struct path *link)
 	if (safe_hardlink_source(inode) || inode_owner_or_capable(inode))
 		return 0;
 
-	audit_log_link_denied("linkat");
+	audit_log_path_denied(AUDIT_ANOM_LINK, "linkat");
 	return -EPERM;
 }
 
@@ -1031,6 +1031,9 @@ static int may_create_in_sticky(struct dentry * const dir,
 	    (dir->d_inode->i_mode & 0020 &&
 	     ((sysctl_protected_fifos >= 2 && S_ISFIFO(inode->i_mode)) ||
 	      (sysctl_protected_regular >= 2 && S_ISREG(inode->i_mode))))) {
+		audit_log_path_denied(AUDIT_ANOM_CREAT,
+				      S_ISFIFO(inode->i_mode) ? "fifo"
+							      : "regular");
 		return -EACCES;
 	}
 	return 0;
diff --git a/include/linux/audit.h b/include/linux/audit.h
index aee3dc9eb378..b3715e2ee1c5 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -156,7 +156,8 @@ extern void		    audit_log_d_path(struct audit_buffer *ab,
 					     const struct path *path);
 extern void		    audit_log_key(struct audit_buffer *ab,
 					  char *key);
-extern void		    audit_log_link_denied(const char *operation);
+extern void		    audit_log_path_denied(int type,
+						  const char *operation);
 extern void		    audit_log_lost(const char *message);
 
 extern int audit_log_task_context(struct audit_buffer *ab);
@@ -217,7 +218,7 @@ static inline void audit_log_d_path(struct audit_buffer *ab,
 { }
 static inline void audit_log_key(struct audit_buffer *ab, char *key)
 { }
-static inline void audit_log_link_denied(const char *string)
+static inline void audit_log_path_denied(int type, const char *string);
 { }
 static inline int audit_log_task_context(struct audit_buffer *ab)
 {
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index c89c6495983d..3ad935527177 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -143,6 +143,7 @@
 #define AUDIT_ANOM_PROMISCUOUS      1700 /* Device changed promiscuous mode */
 #define AUDIT_ANOM_ABEND            1701 /* Process ended abnormally */
 #define AUDIT_ANOM_LINK		    1702 /* Suspicious use of file links */
+#define AUDIT_ANOM_CREAT	    1703 /* Suspicious file creation */
 #define AUDIT_INTEGRITY_DATA	    1800 /* Data integrity verification */
 #define AUDIT_INTEGRITY_METADATA    1801 /* Metadata integrity verification */
 #define AUDIT_INTEGRITY_STATUS	    1802 /* Integrity enable status */
diff --git a/kernel/audit.c b/kernel/audit.c
index da8dc0db5bd3..ed7402ac81b6 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2155,18 +2155,19 @@ void audit_log_task_info(struct audit_buffer *ab)
 EXPORT_SYMBOL(audit_log_task_info);
 
 /**
- * audit_log_link_denied - report a link restriction denial
- * @operation: specific link operation
+ * audit_log_path_denied - report a path restriction denial
+ * @type: audit message type (AUDIT_ANOM_LINK, AUDIT_ANOM_CREAT, etc)
+ * @operation: specific operation name
  */
-void audit_log_link_denied(const char *operation)
+void audit_log_path_denied(int type, const char *operation)
 {
 	struct audit_buffer *ab;
 
 	if (!audit_enabled || audit_dummy_context())
 		return;
 
-	/* Generate AUDIT_ANOM_LINK with subject, operation, outcome. */
-	ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_ANOM_LINK);
+	/* Generate log with subject, operation, outcome. */
+	ab = audit_log_start(audit_context(), GFP_KERNEL, type);
 	if (!ab)
 		return;
 	audit_log_format(ab, "op=%s", operation);
-- 
2.17.1


-- 
Kees Cook
