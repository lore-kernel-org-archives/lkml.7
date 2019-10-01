Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70926C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AEDD20659
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="incc1FUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388839AbfJAQsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:48:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40348 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388815AbfJAQsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:48:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id x127so8406460pfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 09:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=20rYn1QbDb7O1Jy/WEQnWDY4kyWThv4W3UDnp8d9vY0=;
        b=incc1FUxNcuHOGOSdHcLUvYZ+S9DvRryel7pL2XWNa0CD0Rh/KNc8lcVsA5KIAMO4t
         bA+Tmct/udrc4HNV2LqKjNIhg9aJ4k+p/2Wm6+Dz/JEQYhHmuYCTv+51hclaJoKsi84v
         ZBQ9Fxz5MkV9S48MZoVRuyZwJ8B3m3Jq1xWWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=20rYn1QbDb7O1Jy/WEQnWDY4kyWThv4W3UDnp8d9vY0=;
        b=cZwppg7FoRanydD2kCDdWCeIj7PHLFHV6PqJN7EVY8dId94GlLyN+xYZMfWnrRD0AU
         0YB1/nG9S75YntUc3QA+Hzsdui8u1Pe05p8GLUUL7Gk5oyKh/J+PTJ+e1EoIN6E8QiOI
         446yKqrPsB/twccV1PAnunQLJO+hbVLKZz7NlasygLQF7Xstp0uzFpb9JY7cA3BhpmeN
         KSSn3W/YJ+0fkXXhAU1N7ZLx2EHFEdvDdXMC6Vj0NKol+n8Pm3dExTc5z99FvGb6Anzr
         QJHtG1xvJ0MH6m3TxeWArf8GNybRbdju7zhhKyaLI9QwgPPyhytgSI2AWomwO7XrSKWt
         VRTw==
X-Gm-Message-State: APjAAAVHaenB/4V+dXo3buJ4MByZ4ysmjTCTXNlUgCWe2E4mDdIVlDiK
        a7KVnE5NJN4g0TIX4BitRQpYrw==
X-Google-Smtp-Source: APXvYqyQdM54m8I3epULb9G/NnqJjXeZcpNK3uSgKyfYIzayyiRPCSEbx2BiWIr88Kk9uq04ooueQw==
X-Received: by 2002:a63:6b49:: with SMTP id g70mr29953089pgc.92.1569948526763;
        Tue, 01 Oct 2019 09:48:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q204sm17704948pfc.11.2019.10.01.09.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 09:48:45 -0700 (PDT)
Date:   Tue, 1 Oct 2019 09:48:44 -0700
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
Subject: [PATCH v2] audit: Report suspicious O_CREAT usage
Message-ID: <201910010945.CAABF57@keescook>
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
regular files"). Additionally further clarifies the existing
"operations" strings.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
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
index 671c3c1a3425..2d5d245ae723 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -925,7 +925,7 @@ static inline int may_follow_link(struct nameidata *nd)
 		return -ECHILD;
 
 	audit_inode(nd->name, nd->stack[0].link.dentry, 0);
-	audit_log_link_denied("follow_link");
+	audit_log_path_denied(AUDIT_ANOM_LINK, "sticky_follow_link");
 	return -EACCES;
 }
 
@@ -993,7 +993,7 @@ static int may_linkat(struct path *link)
 	if (safe_hardlink_source(inode) || inode_owner_or_capable(inode))
 		return 0;
 
-	audit_log_link_denied("linkat");
+	audit_log_path_denied(AUDIT_ANOM_LINK, "unowned_linkat");
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
