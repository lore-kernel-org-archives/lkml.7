Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,GAPPY_SUBJECT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88544C468AD
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 10:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5704721670
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 10:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="thNRn6TJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfGFKzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 06:55:37 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40883 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbfGFKz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 06:55:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so11941394wmj.5;
        Sat, 06 Jul 2019 03:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u2RjwdUFNE3OIK/3bCmlFikIsAzp11hkr0vwILrcAOk=;
        b=thNRn6TJGPSAjqCTr1tPi/WxernvhpJlmpA3TOqpdYJiE30WEHmKtQQLBhQkPRLOPw
         6LdBMJiwQeRDj45LsQ+CyPeBPtz6Sm/DVPA/1jFuQwsFGykkDeEEAkecFk+eI93fAHD1
         qYlH4joBKaM50/AAsI6LhYNjkSKoWjJohjBdSbGLIHp32dQu3tN7YZr1eYxcsB+bqXUy
         bX3ZLkExfr5FGb8+TAw/oOIVBNNg7ayqAkWV/3r6PYpzR3qHiM4xg4ORrndOJWzJXK+K
         OUQHzEOkfBbfQCpO4tDaUbNknqB74EkTe516YzXQIsCHfecezahJQP/7fVtAx2XeBD7c
         +9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u2RjwdUFNE3OIK/3bCmlFikIsAzp11hkr0vwILrcAOk=;
        b=eDrGL44MRUA86Mk8sjVGtgkww0yi39ok0Mn2EnsMtKpwyRNyJi73HvJZcxZYNg7TQ+
         u4Gy/RJv7neDJnSInjCwsh4z8BptxWMsJ++2iXcW0CbTHwd61iS92mz7mu6FRxC1QB76
         Rlb/6gKI34MbyMk2MQ7EfSnR8FtfCYFR1uevtyyl26Mx31Ei6zDLE539HKStZGHiXTXF
         gwqAezlNEY6tDElezDXgQ2icGvXZGBUnHqHu28ugFyAtIMsVbLYyM71NV+DLIIYX8RNq
         6UfKhUfoUg0lYaV23z7wEkcBJhVItsqTFx6AMsbRgkr9x5KLKe7dZw+J5Cf43A0ddhds
         TimA==
X-Gm-Message-State: APjAAAXpuhJXa390AkHldeITDMcT8zFQ0uDJTsG6o+FJJEh0I/vkjhIG
        KKqMX19TnfHAId0Boid/T/plGKboALI25g==
X-Google-Smtp-Source: APXvYqxxhkCkToEoUM8bgIOUXQl0J7gFqXqis0ZuQI5jP94wYx8vI8XERZcndoRkmUp3pDS0ZQ935g==
X-Received: by 2002:a1c:5f87:: with SMTP id t129mr8243038wmb.150.1562410524445;
        Sat, 06 Jul 2019 03:55:24 -0700 (PDT)
Received: from localhost (net-93-71-3-102.cust.vodafonedsl.it. [93.71.3.102])
        by smtp.gmail.com with ESMTPSA id h11sm12578794wrx.93.2019.07.06.03.55.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jul 2019 03:55:23 -0700 (PDT)
From:   Salvatore Mesoraca <s.mesoraca16@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Brad Spengler <spender@grsecurity.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christoph Hellwig <hch@infradead.org>,
        James Morris <james.l.morris@oracle.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        PaX Team <pageexec@freemail.hu>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v5 11/12] S.A.R.A.: /proc/*/mem write limitation
Date:   Sat,  6 Jul 2019 12:54:52 +0200
Message-Id: <1562410493-8661-12-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com>
References: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent a task from opening, in "write" mode, any /proc/*/mem
file that operates on the task's mm.
A process could use it to overwrite read-only memory, bypassing
S.A.R.A. restrictions.

Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
---
 security/sara/include/sara_data.h | 18 ++++++++++++++++-
 security/sara/sara_data.c         |  8 ++++++++
 security/sara/wxprot.c            | 41 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/security/sara/include/sara_data.h b/security/sara/include/sara_data.h
index 9216c47..ee95f74 100644
--- a/security/sara/include/sara_data.h
+++ b/security/sara/include/sara_data.h
@@ -15,6 +15,7 @@
 #define __SARA_DATA_H
 
 #include <linux/cred.h>
+#include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/lsm_hooks.h>
 #include <linux/spinlock.h>
@@ -40,6 +41,10 @@ struct sara_shm_data {
 	spinlock_t	lock;
 };
 
+struct sara_inode_data {
+	struct task_struct *task;
+};
+
 
 static inline struct sara_data *get_sara_data(const struct cred *cred)
 {
@@ -79,6 +84,17 @@ static inline struct sara_shm_data *get_sara_shm_data(
 #define lock_sara_shm(X) (spin_lock(&get_sara_shm_data((X))->lock))
 #define unlock_sara_shm(X) (spin_unlock(&get_sara_shm_data((X))->lock))
 
-#endif
+
+static inline struct sara_inode_data *get_sara_inode_data(
+						const struct inode *inode)
+{
+	if (unlikely(!inode->i_security))
+		return NULL;
+	return inode->i_security + sara_blob_sizes.lbs_inode;
+}
+
+#define get_sara_inode_task(X) (get_sara_inode_data((X))->task)
+
+#endif /* CONFIG_SECURITY_SARA_WXPROT */
 
 #endif /* __SARA_H */
diff --git a/security/sara/sara_data.c b/security/sara/sara_data.c
index 9afca37..e875cf0 100644
--- a/security/sara/sara_data.c
+++ b/security/sara/sara_data.c
@@ -17,6 +17,7 @@
 #include <linux/cred.h>
 #include <linux/lsm_hooks.h>
 #include <linux/mm.h>
+#include <linux/slab.h>
 #include <linux/spinlock.h>
 
 static int sara_cred_prepare(struct cred *new, const struct cred *old,
@@ -40,15 +41,22 @@ static int sara_shm_alloc_security(struct kern_ipc_perm *shp)
 	return 0;
 }
 
+static void sara_task_to_inode(struct task_struct *t, struct inode *i)
+{
+	get_sara_inode_task(i) = t;
+}
+
 static struct security_hook_list data_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(cred_prepare, sara_cred_prepare),
 	LSM_HOOK_INIT(cred_transfer, sara_cred_transfer),
 	LSM_HOOK_INIT(shm_alloc_security, sara_shm_alloc_security),
+	LSM_HOOK_INIT(task_to_inode, sara_task_to_inode),
 };
 
 struct lsm_blob_sizes sara_blob_sizes __lsm_ro_after_init = {
 	.lbs_cred = sizeof(struct sara_data),
 	.lbs_ipc = sizeof(struct sara_shm_data),
+	.lbs_inode = sizeof(struct sara_inode_data),
 };
 
 int __init sara_data_init(void)
diff --git a/security/sara/wxprot.c b/security/sara/wxprot.c
index 773d1fd..1a8d132 100644
--- a/security/sara/wxprot.c
+++ b/security/sara/wxprot.c
@@ -22,8 +22,11 @@
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/module.h>
+#include <linux/mount.h>
 #include <linux/printk.h>
 #include <linux/ratelimit.h>
+#include <linux/sched/mm.h>
+#include <linux/sched/task.h>
 #include <linux/spinlock.h>
 #include <linux/xattr.h>
 
@@ -615,6 +618,43 @@ static int sara_file_mprotect(struct vm_area_struct *vma,
 	return 0;
 }
 
+static int sara_file_open(struct file *file)
+{
+	struct task_struct *t;
+	struct mm_struct *mm;
+	u16 sara_wxp_flags = get_current_sara_wxp_flags();
+
+	/*
+	 * Prevent write access to /proc/.../mem
+	 * if it operates on the mm_struct of the
+	 * current process: it could be used to
+	 * bypass W^X.
+	 */
+
+	if (!sara_enabled ||
+	    !wxprot_enabled ||
+	    !(sara_wxp_flags & SARA_WXP_WXORX) ||
+	    !(file->f_mode & FMODE_WRITE))
+		return 0;
+
+	t = get_sara_inode_task(file_inode(file));
+	if (unlikely(t != NULL &&
+		     strcmp(file->f_path.dentry->d_name.name,
+			    "mem") == 0)) {
+		get_task_struct(t);
+		mm = get_task_mm(t);
+		put_task_struct(t);
+		if (unlikely(mm == current->mm))
+			sara_warn_or_goto(error,
+					  "write access to /proc/*/mem");
+		mmput(mm);
+	}
+	return 0;
+error:
+	mmput(mm);
+	return -EACCES;
+}
+
 #ifdef CONFIG_SECURITY_SARA_WXPROT_EMUTRAMP
 static int sara_pagefault_handler(struct pt_regs *regs,
 				  unsigned long error_code,
@@ -778,6 +818,7 @@ static int sara_setprocattr(const char *name, void *value, size_t size)
 	LSM_HOOK_INIT(check_vmflags, sara_check_vmflags),
 	LSM_HOOK_INIT(shm_shmat, sara_shm_shmat),
 	LSM_HOOK_INIT(file_mprotect, sara_file_mprotect),
+	LSM_HOOK_INIT(file_open, sara_file_open),
 #ifdef CONFIG_SECURITY_SARA_WXPROT_EMUTRAMP
 	LSM_HOOK_INIT(pagefault_handler, sara_pagefault_handler),
 #endif
-- 
1.9.1

