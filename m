Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9327C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8776821848
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RuaAqYMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfJBXmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 19:42:01 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36173 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfJBXmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 19:42:01 -0400
Received: by mail-pl1-f196.google.com with SMTP id j11so599094plk.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 16:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=NTX0hkNxI05pnkppFwzWTqjYZZHE2LejCZuC9WmiKB0=;
        b=RuaAqYMGq6ZNHIeNyfRBleyOdT3qbOpk/MH7msZ+uzQd4zfMjwSbeKowJyaVBIXvZU
         e3ehgl3JtM8H8MCAj5clnFljDK9COp0ujetbeasrlPkVSPNRS9hKxxJVQzw8Jh+h4XJl
         N4i1UMuHVi6KLKg6ETIRJiderlGsTRvCULbMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=NTX0hkNxI05pnkppFwzWTqjYZZHE2LejCZuC9WmiKB0=;
        b=B1OYt9NHEq4OBSIU3VfBqeEuG9XkN7ukYmymibCsBF5jve8wooeicLExhtp5/qet+f
         L3uk1eMVUP4WGozKcZshXGc/RfR0GlOnSw2hkRQTxZ0uh8voTkz3XHtP0Ltmv3Pq+B74
         yblrXsMMqiwdpQZTlXMoiYC1oMiad0Xeh4nHj5A5Tr160ErrvGK5lNYKKX0lPpPSqgX1
         VABMTLss3cNMjfSHz/E6hjSIcAYe5piuG5vP0HMD+y9ccuG/qMmZIUGCjFB3qK/VJcCy
         3MIudUO2MI5IoMSUhKp5FhOohEKFdcLzfDVewJqOLV9JzGSJUA3SVN/IzAWYZ4PWuVxh
         hkaw==
X-Gm-Message-State: APjAAAUaqq6wsRu4y+asU/1zA+MD1xEi8seN9wcs1xjYVFloQvBtdIqn
        Lya7Oiu3AS1b+U/xoqUMxBifNw==
X-Google-Smtp-Source: APXvYqy10qOgEi5CzIB/8gJv+NIva4xGBBOMqbDLDaqcYRruLZ/BQ1X8YbXNB1TkhaEHhOVlG+SuEg==
X-Received: by 2002:a17:902:7782:: with SMTP id o2mr6111131pll.165.1570059720606;
        Wed, 02 Oct 2019 16:42:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c8sm438671pga.42.2019.10.02.16.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 16:41:59 -0700 (PDT)
Date:   Wed, 2 Oct 2019 16:41:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau 
        <jeremie.galarneau@efficios.com>, s.mesoraca16@gmail.com,
        viro@zeniv.linux.org.uk, dan.carpenter@oracle.com,
        akpm@linux-foundation.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        kernel-hardening@lists.openwall.com, linux-audit@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v3] audit: Report suspicious O_CREAT usage
Message-ID: <201910021640.B01FA41@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This renames the very specific audit_log_link_denied() to
audit_log_path_denied() and adds the AUDIT_* type as an argument. This
allows for the creation of the new AUDIT_ANOM_CREAT that can be used to
report the fifo/regular file creation restrictions that were introduced
in commit 30aba6656f61 ("namei: allow restricted O_CREAT of FIFOs and
regular files").

Signed-off-by: Kees Cook <keescook@chromium.org>
---
v3:
 - retain existing operation names (paul)
v2:
 - fix build failure typo in CONFIG_AUDIT=n case
 - improve operations naming (paul)
---
 fs/namei.c                 |  8 ++++++--
 include/linux/audit.h      |  5 +++--
 include/uapi/linux/audit.h |  1 +
 kernel/audit.c             | 11 ++++++-----
 4 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 671c3c1a3425..2dda552bcf7a 100644
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
 
@@ -1031,6 +1031,10 @@ static int may_create_in_sticky(struct dentry * const dir,
 	    (dir->d_inode->i_mode & 0020 &&
 	     ((sysctl_protected_fifos >= 2 && S_ISFIFO(inode->i_mode)) ||
 	      (sysctl_protected_regular >= 2 && S_ISREG(inode->i_mode))))) {
+		const char *operation = S_ISFIFO(inode->i_mode) ?
+					"sticky_create_fifo" :
+					"sticky_create_regular";
+		audit_log_path_denied(AUDIT_ANOM_CREAT, operation);
 		return -EACCES;
 	}
 	return 0;
diff --git a/include/linux/audit.h b/include/linux/audit.h
index aee3dc9eb378..f9ceae57ca8d 100644
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
+static inline void audit_log_path_denied(int type, const char *operation)
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
index da8dc0db5bd3..d75485aa25ff 100644
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
