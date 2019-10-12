Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C50ECE587
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 19:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BEAA2089C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 19:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GvtWWssI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbfJLTQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 15:16:25 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:33001 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729679AbfJLTQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 15:16:19 -0400
Received: by mail-pf1-f201.google.com with SMTP id z4so10244952pfn.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 12:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6PNxQptqFZv6r7KIq1szAGaXtND1cZM6S6IWMEOmUXc=;
        b=GvtWWssIS1EIVUdbLh2WfKcReIx5BeqxA4y/iDMumOgVaRZjvAvOsXv2DSrj7efJkA
         BMKEqFhC1gwAktf1nwfztGDt5cXsm4YwKEuEImuVTBSuVmcaK/cfh1RnH9n3jlBeNaEf
         oAy6C7zroHshvIt5v5qI3DPxyYYfoZ95UlKhxcymO4AcE+OZkxs+HSiG8h9ADevFq61/
         kNwLX6vZ6RHGWtRlyKegsKtqLhslkrQCr0WWEyz9lccyMc0Lh4Wm0gh6yLDdrdsKS5L+
         CA2+kbo3A9wlFHEueQCU+2drPOIHVmvsSHLZB7Uqy65VKVMA2dPDPY+hA2ZRUrNencyP
         R4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6PNxQptqFZv6r7KIq1szAGaXtND1cZM6S6IWMEOmUXc=;
        b=SrcV+3lRBKEBUc6WNCOfzeLFDntnonRBVK+Pq97XCXgvOuQSy8NheXkrCXod9nuDy9
         IihaNpmB0Bp4w/8mH//PdDRLzBs5A+wcj0vXIbxPjt3NN5sd1QZVgkSJbq0c4INGcggl
         GaYuLd+wqxq948paqvG5gsll+ZHA3T1Vr1R5UjMqBXDIamqk7Rfz8CTz7DH1FqFBd2Fw
         GkWWGUdxN5azwfpk+11b4xnkWX86LRGxVbnq1y05jUCJTRV2S8lzScvyCS5KVQ63mrH9
         ILlMLEe0uCF4wmFVbMJjWEcca02VlW1BcxzZ1MNYbf2q7dWHOCPAAUMCMxzRGKHiMqHX
         6MtQ==
X-Gm-Message-State: APjAAAUF5SA8yD1Hhq5rIVmbMjdNVVj2XAWl+30HftCzWhrcT5XDdDwo
        iItus44Ib8HWXoOH7lVyT2fC98BkV+A=
X-Google-Smtp-Source: APXvYqyR5SApLhBuK0TWfjw/u4u40CRYLmSyjyjFPsvdMpFvY9T6D2Plo8rbAy8YRuZBbY+JaIwDLSDR7C0=
X-Received: by 2002:a65:62d2:: with SMTP id m18mr23615514pgv.117.1570907778962;
 Sat, 12 Oct 2019 12:16:18 -0700 (PDT)
Date:   Sat, 12 Oct 2019 12:15:59 -0700
In-Reply-To: <20191012191602.45649-1-dancol@google.com>
Message-Id: <20191012191602.45649-5-dancol@google.com>
Mime-Version: 1.0
References: <20191012191602.45649-1-dancol@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH 4/7] Teach SELinux about a new userfaultfd class
From:   Daniel Colascione <dancol@google.com>
To:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        lokeshgidra@google.com, dancol@google.com, nnk@google.com
Cc:     nosh@google.com, timmurray@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the secure anonymous inode LSM hook we just added to let SELinux
policy place restrictions on userfaultfd use. The create operation
applies to processes creating new instances of these file objects;
transfer between processes is covered by restrictions on read, write,
and ioctl access already checked inside selinux_file_receive.

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 fs/userfaultfd.c                    |  4 +-
 include/linux/userfaultfd_k.h       |  2 +
 security/selinux/hooks.c            | 68 +++++++++++++++++++++++++++++
 security/selinux/include/classmap.h |  2 +
 4 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 29f920fb236e..1123089c3d55 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1014,8 +1014,6 @@ static __poll_t userfaultfd_poll(struct file *file, poll_table *wait)
 	}
 }
 
-static const struct file_operations userfaultfd_fops;
-
 static int resolve_userfault_fork(struct userfaultfd_ctx *ctx,
 				  struct userfaultfd_ctx *new,
 				  struct uffd_msg *msg)
@@ -1934,7 +1932,7 @@ static void userfaultfd_show_fdinfo(struct seq_file *m, struct file *f)
 }
 #endif
 
-static const struct file_operations userfaultfd_fops = {
+const struct file_operations userfaultfd_fops = {
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo	= userfaultfd_show_fdinfo,
 #endif
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index ac9d71e24b81..549c8b0cca52 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -30,6 +30,8 @@
 
 extern int sysctl_unprivileged_userfaultfd;
 
+extern const struct file_operations userfaultfd_fops;
+
 extern vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason);
 
 extern ssize_t mcopy_atomic(struct mm_struct *dst_mm, unsigned long dst_start,
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9625b99e677f..0b3a36cbfbdc 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -92,6 +92,10 @@
 #include <linux/fsnotify.h>
 #include <linux/fanotify.h>
 
+#ifdef CONFIG_USERFAULTFD
+#include <linux/userfaultfd_k.h>
+#endif
+
 #include "avc.h"
 #include "objsec.h"
 #include "netif.h"
@@ -2943,6 +2947,69 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	return 0;
 }
 
+static int selinux_inode_init_security_anon(struct inode *inode,
+					    const char *name,
+					    const struct file_operations *fops)
+{
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
+	struct common_audit_data ad;
+	struct inode_security_struct *isec;
+
+	if (unlikely(IS_PRIVATE(inode)))
+		return 0;
+
+	/*
+	 * We shouldn't be creating secure anonymous inodes before LSM
+	 * initialization completes.
+	 */
+	if (unlikely(!selinux_state.initialized))
+		return -EBUSY;
+
+	isec = selinux_inode(inode);
+
+	/*
+	 * We only get here once per ephemeral inode.  The inode has
+	 * been initialized via inode_alloc_security but is otherwise
+	 * untouched, so check that the state is as
+	 * inode_alloc_security left it.
+	 */
+	BUG_ON(isec->initialized != LABEL_INVALID);
+	BUG_ON(isec->sclass != SECCLASS_FILE);
+
+#ifdef CONFIG_USERFAULTFD
+	if (fops == &userfaultfd_fops)
+		isec->sclass = SECCLASS_UFFD;
+#endif
+
+	if (isec->sclass == SECCLASS_FILE) {
+		printk(KERN_WARNING "refusing to create secure anonymous inode "
+		       "of unknown type");
+		return -EOPNOTSUPP;
+	}
+	/*
+	 * Always give secure anonymous inodes the sid of the
+	 * creating task.
+	 */
+
+	isec->sid = tsec->sid;
+	isec->initialized = LABEL_INITIALIZED;
+
+	/*
+	 * Now that we've initialized security, check whether we're
+	 * allowed to actually create this type of anonymous inode.
+	 */
+
+	ad.type = LSM_AUDIT_DATA_INODE;
+	ad.u.inode = inode;
+
+	return avc_has_perm(&selinux_state,
+			    tsec->sid,
+			    isec->sid,
+			    isec->sclass,
+			    FILE__CREATE,
+			    &ad);
+}
+
 static int selinux_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
 	return may_create(dir, dentry, SECCLASS_FILE);
@@ -6840,6 +6907,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(inode_alloc_security, selinux_inode_alloc_security),
 	LSM_HOOK_INIT(inode_free_security, selinux_inode_free_security),
 	LSM_HOOK_INIT(inode_init_security, selinux_inode_init_security),
+	LSM_HOOK_INIT(inode_init_security_anon, selinux_inode_init_security_anon),
 	LSM_HOOK_INIT(inode_create, selinux_inode_create),
 	LSM_HOOK_INIT(inode_link, selinux_inode_link),
 	LSM_HOOK_INIT(inode_unlink, selinux_inode_unlink),
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 32e9b03be3dd..41bc5da78048 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -244,6 +244,8 @@ struct security_class_mapping secclass_map[] = {
 	  {"map_create", "map_read", "map_write", "prog_load", "prog_run"} },
 	{ "xdp_socket",
 	  { COMMON_SOCK_PERMS, NULL } },
+	{ "uffd",
+	  { COMMON_FILE_PERMS, NULL } },
 	{ NULL }
   };
 
-- 
2.23.0.700.g56cf767bdb-goog

