Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF98C4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DCBF2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d/mwWVfm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733096AbfIJL4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 07:56:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35606 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732008AbfIJL4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 07:56:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id g7so19676252wrx.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 04:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fFz8YZRCL6C0W3zDLuAn1hD9LuCSoyLjLV0WVySuCIs=;
        b=d/mwWVfm8N8nWpk2rm3dvnygC8+vI+RR7bAE9isIWbzYVPVY6IF449wd1prgiYsr54
         vMsiBoGNafqRieyRDnQ0nVkOfLWRnocaxrGrwxYDKE9XjczgyM/VrQIKYT7fF0Dmhtiw
         2VX8NF4bE8gL1FHptMJ9bruscFd21e3Npc7ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fFz8YZRCL6C0W3zDLuAn1hD9LuCSoyLjLV0WVySuCIs=;
        b=Gj1g7XhQxJIkXXk2MK1ieP2V2Ynr4HuEi2ZSMuT+RLeiGMxAuNgBxYbQeBlIE+cDWv
         FEIrGi/o4Cr38qCxjVKuuw2jZajU4o6eYWsIJkRA3zzYg+c62CRgHY+4DLH5xy/KZwMF
         oWUW3kTPYbx4rdTkmTYhkpRXOHt4TOO6nZwWqbKHSzgCFyU258G66sVLN+5i29PvesB+
         DooLyHjmzLrJCY01xipolLrefsYaO81rQsSNO5PJzNvGhcAf3Zeslg4JbRHrZDq6SLYV
         TWObqe22aOLzRk/hCkfKqRdGBvwPJR5pS8SPPS3dK3er+f1nd1uUuDqz3q1nZUfxV4w3
         jkXQ==
X-Gm-Message-State: APjAAAV5z2350DqiZfcqOvV5Mh4mQ0WMY8Sbzz75nuTOc4q44T+ccYUA
        jhdiJtFW0RYjX3AAE7dBsdq2QlIkr+Q=
X-Google-Smtp-Source: APXvYqyquiCnLNFVIZCBecAJwbrRsHhJkrlT57UUhcOwi+WJMCuUh8z7GvOmBsiDp0NaD9HE3hT31w==
X-Received: by 2002:a5d:49c3:: with SMTP id t3mr26705536wrs.151.1568116590867;
        Tue, 10 Sep 2019 04:56:30 -0700 (PDT)
Received: from kpsingh-kernel.c.hoisthospitality.com (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id q19sm23732935wra.89.2019.09.10.04.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 04:56:30 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [RFC v1 05/14] krsi: Initialize KRSI hooks and create files in securityfs
Date:   Tue, 10 Sep 2019 13:55:18 +0200
Message-Id: <20190910115527.5235-6-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910115527.5235-1-kpsingh@chromium.org>
References: <20190910115527.5235-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

The LSM creates files in securityfs for each hook registered with the
LSM.

    /sys/kernel/security/bpf/<h_name>

The initialization of the hooks is done collectively in an internal
header "hooks.h" which results in:

* Creation of a file for the hook in the securityfs.
* Allocation of a krsi_hook data structure which stores a pointer to the
  dentry of the newly created file in securityfs.
* A pointer to the krsi_hook data structure is stored in the private
  d_fsdata of dentry of the file created in securityFS.

These files will later be used to specify an attachment target during
BPF_PROG_LOAD.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 security/krsi/Makefile            |  4 +-
 security/krsi/include/hooks.h     | 21 ++++++++
 security/krsi/include/krsi_fs.h   | 19 +++++++
 security/krsi/include/krsi_init.h | 45 ++++++++++++++++
 security/krsi/krsi.c              | 16 +++++-
 security/krsi/krsi_fs.c           | 88 +++++++++++++++++++++++++++++++
 6 files changed, 191 insertions(+), 2 deletions(-)
 create mode 100644 security/krsi/include/hooks.h
 create mode 100644 security/krsi/include/krsi_fs.h
 create mode 100644 security/krsi/include/krsi_init.h
 create mode 100644 security/krsi/krsi_fs.c

diff --git a/security/krsi/Makefile b/security/krsi/Makefile
index 660cc1f422fd..4586241f16e1 100644
--- a/security/krsi/Makefile
+++ b/security/krsi/Makefile
@@ -1 +1,3 @@
-obj-$(CONFIG_SECURITY_KRSI) := krsi.o ops.o
+obj-$(CONFIG_SECURITY_KRSI) := krsi.o krsi_fs.o ops.o
+
+ccflags-y := -I$(srctree)/security/krsi -I$(srctree)/security/krsi/include
diff --git a/security/krsi/include/hooks.h b/security/krsi/include/hooks.h
new file mode 100644
index 000000000000..e070c452b5de
--- /dev/null
+++ b/security/krsi/include/hooks.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * The hooks for the KRSI LSM are declared in this file.
+ *
+ * This header MUST NOT be included directly and should
+ * be only used to initialize the hooks lists.
+ *
+ * Format:
+ *
+ *   KRSI_HOOK_INIT(TYPE, NAME, LSM_HOOK, KRSI_HOOK_FN)
+ *
+ * KRSI adds one layer of indirection between the name of the hook and the name
+ * it exposes to the userspace in Security FS to prevent the userspace from
+ * breaking in case the name of the hook changes in the kernel or if there's
+ * another LSM hook that maps better to the represented security behaviour.
+ */
+KRSI_HOOK_INIT(PROCESS_EXECUTION,
+	       process_execution,
+	       bprm_check_security,
+	       krsi_process_execution)
diff --git a/security/krsi/include/krsi_fs.h b/security/krsi/include/krsi_fs.h
new file mode 100644
index 000000000000..38134661d8d6
--- /dev/null
+++ b/security/krsi/include/krsi_fs.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _KRSI_FS_H
+#define _KRSI_FS_H
+
+#include <linux/bpf.h>
+#include <linux/fs.h>
+#include <linux/types.h>
+
+bool is_krsi_hook_file(struct file *f);
+
+/*
+ * The name of the directory created in securityfs
+ *
+ *	/sys/kernel/security/<dir_name>
+ */
+#define KRSI_SFS_NAME "krsi"
+
+#endif /* _KRSI_FS_H */
diff --git a/security/krsi/include/krsi_init.h b/security/krsi/include/krsi_init.h
new file mode 100644
index 000000000000..68755182a031
--- /dev/null
+++ b/security/krsi/include/krsi_init.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _KRSI_INIT_H
+#define _KRSI_INIT_H
+
+#include "krsi_fs.h"
+
+enum krsi_hook_type {
+	PROCESS_EXECUTION,
+	__MAX_KRSI_HOOK_TYPE, /* delimiter */
+};
+
+extern int krsi_fs_initialized;
+/*
+ * The LSM creates one file per hook.
+ *
+ * A pointer to krsi_hook data structure is stored in the
+ * private fsdata of the dentry of the per-hook file created
+ * in securityfs.
+ */
+struct krsi_hook {
+	/*
+	 * The name of the security hook, a file with this name will be created
+	 * in the securityfs.
+	 */
+	const char *name;
+	/*
+	 * The type of the LSM hook, the LSM uses this to index the list of the
+	 * hooks to run the eBPF programs that may have been attached.
+	 */
+	enum krsi_hook_type h_type;
+	/*
+	 * The dentry of the file created in securityfs.
+	 */
+	struct dentry *h_dentry;
+};
+
+extern struct krsi_hook krsi_hooks_list[];
+
+#define krsi_for_each_hook(hook) \
+	for ((hook) = &krsi_hooks_list[0]; \
+	     (hook) < &krsi_hooks_list[__MAX_KRSI_HOOK_TYPE]; \
+	     (hook)++)
+
+#endif /* _KRSI_INIT_H */
diff --git a/security/krsi/krsi.c b/security/krsi/krsi.c
index 9ce4f56fb78d..77d7e2f91172 100644
--- a/security/krsi/krsi.c
+++ b/security/krsi/krsi.c
@@ -2,13 +2,27 @@
 
 #include <linux/lsm_hooks.h>
 
+#include "krsi_init.h"
+
+struct krsi_hook krsi_hooks_list[] = {
+	#define KRSI_HOOK_INIT(TYPE, NAME, H, I) \
+		[TYPE] = { \
+			.h_type = TYPE, \
+			.name = #NAME, \
+		},
+	#include "hooks.h"
+	#undef KRSI_HOOK_INIT
+};
+
 static int krsi_process_execution(struct linux_binprm *bprm)
 {
 	return 0;
 }
 
 static struct security_hook_list krsi_hooks[] __lsm_ro_after_init = {
-	LSM_HOOK_INIT(bprm_check_security, krsi_process_execution),
+	#define KRSI_HOOK_INIT(T, N, HOOK, IMPL) LSM_HOOK_INIT(HOOK, IMPL),
+	#include "hooks.h"
+	#undef KRSI_HOOK_INIT
 };
 
 static int __init krsi_init(void)
diff --git a/security/krsi/krsi_fs.c b/security/krsi/krsi_fs.c
new file mode 100644
index 000000000000..604f826cee5c
--- /dev/null
+++ b/security/krsi/krsi_fs.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/types.h>
+#include <linux/security.h>
+
+#include "krsi_fs.h"
+#include "krsi_init.h"
+
+extern struct krsi_hook krsi_hooks_list[];
+
+static struct dentry *krsi_dir;
+
+static const struct file_operations krsi_hook_ops = {
+	.llseek = generic_file_llseek,
+};
+
+int krsi_fs_initialized;
+
+bool is_krsi_hook_file(struct file *f)
+{
+	return f->f_op == &krsi_hook_ops;
+}
+
+static void __init krsi_free_hook(struct krsi_hook *h)
+{
+	securityfs_remove(h->h_dentry);
+	h->h_dentry = NULL;
+}
+
+static int __init krsi_init_hook(struct krsi_hook *h, struct dentry *parent)
+{
+	struct dentry *h_dentry;
+	int ret;
+
+	h_dentry = securityfs_create_file(h->name, 0600, parent,
+			NULL, &krsi_hook_ops);
+
+	if (IS_ERR(h_dentry))
+		return PTR_ERR(h_dentry);
+	h_dentry->d_fsdata = h;
+	h->h_dentry = h_dentry;
+	return 0;
+
+error:
+	securityfs_remove(h_dentry);
+	return ret;
+}
+
+static int __init krsi_fs_init(void)
+{
+
+	struct krsi_hook *hook;
+	int ret;
+
+	krsi_dir = securityfs_create_dir(KRSI_SFS_NAME, NULL);
+	if (IS_ERR(krsi_dir)) {
+		ret = PTR_ERR(krsi_dir);
+		pr_err("Unable to create krsi sysfs dir: %d\n", ret);
+		krsi_dir = NULL;
+		return ret;
+	}
+
+	/*
+	 * If there is an error in initializing a hook, the initialization
+	 * logic makes sure that it has been freed, but this means that
+	 * cleanup should be called for all the other hooks. The cleanup
+	 * logic handles uninitialized data.
+	 */
+	krsi_for_each_hook(hook) {
+		ret = krsi_init_hook(hook, krsi_dir);
+		if (ret < 0)
+			goto error;
+	}
+
+	krsi_fs_initialized = 1;
+	return 0;
+error:
+	krsi_for_each_hook(hook)
+		krsi_free_hook(hook);
+	securityfs_remove(krsi_dir);
+	return ret;
+}
+
+late_initcall(krsi_fs_init);
-- 
2.20.1

