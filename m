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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218F8C0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 10:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12E321670
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 10:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kc2cJKhD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfGFKzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 06:55:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40872 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfGFKzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 06:55:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so11941179wmj.5;
        Sat, 06 Jul 2019 03:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tntZg8r5S9LwiMO7vss45dOAl1fEVW4KEshHq7hSndk=;
        b=kc2cJKhDmxsorvbYBJN4L4LP1TLlMTnFPLFX6zgkZebJ/WsFIMzWWYWhtSgVtP7zMQ
         0cOB3K0BaSp0V5QtNPW6SGBa+vrt3q/HL19vYWaeS7qrfH+dWKn9nfeK/a+K8xeUEotp
         5ZmpQDndExIKqNYdSvxCEi9NPZMxIGZK9+ornVkxCqrBSuxArZeonMC6E7vUvtjhX4VT
         5szWyZvmeouxknBYxB9Wbjm9LbY7t21Y+4zZ9LjC/eMDRTlMMT+GuGm2SSyALI9h5Hng
         oeLX0GzYFtaj78gVuuV1vufxWfJg/xwaAdrvfKBhwc/EYZdO2fu2pXy4SOCaITR4HIIa
         gRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tntZg8r5S9LwiMO7vss45dOAl1fEVW4KEshHq7hSndk=;
        b=NFOL/YE4Wsu5HD9kmsFQn4vHaLaIj7vTd4rEZ6j96+ITKdV2wzd2bF+bCAmMzpp5hU
         B6n2nGYWWHghWRpT0kz3126s0FC2vdKYti/7KP+bcdjsEWR3ae2Wrf2zps/IsZQkUZw6
         LgaX2TH4XuEL5ZUg96C0E5zHxzRHArZU9vSKzdk4dqW43OYY9Ek4f6I+jbTeZE7lQU3o
         FSJrTXKjQhf5l23mFwyjfuoV9XlE8SJC0xAkm5ZUr76+3+VIkJK2dY7xliP3FhKOuEAu
         7oe64yiT7fRO5EU9ttvx8g/pwtU2+f9+w8HulDURxvAor1qQeVsGIjps29q/dqxhnMGY
         6r+w==
X-Gm-Message-State: APjAAAVV58V274DPlV7EfnwgEU7WyvDrDK5U/6r9yB53nKRRwPQHnVfJ
        X8Bbc4A4tug5Fv+ow4MmemQwnOHpv1Qm1g==
X-Google-Smtp-Source: APXvYqyT5FvHevvfORCP5Opw4y7yO1x8K1YKmTYR/PUKpHFg48nVRxzDqlQiuBD7tLbShBXcjqdbVA==
X-Received: by 2002:a1c:b706:: with SMTP id h6mr7598997wmf.119.1562410514962;
        Sat, 06 Jul 2019 03:55:14 -0700 (PDT)
Received: from localhost (net-93-71-3-102.cust.vodafonedsl.it. [93.71.3.102])
        by smtp.gmail.com with ESMTPSA id h11sm12578794wrx.93.2019.07.06.03.55.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jul 2019 03:55:14 -0700 (PDT)
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
Subject: [PATCH v5 03/12] S.A.R.A.: cred blob management
Date:   Sat,  6 Jul 2019 12:54:44 +0200
Message-Id: <1562410493-8661-4-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com>
References: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creation of the S.A.R.A. cred blob management "API".
In order to allow S.A.R.A. to be stackable with other LSMs, it doesn't use
the "security" field of struct cred, instead it uses an ad hoc field named
security_sara.
This solution is probably not acceptable for upstream, so this part will
be modified as soon as the LSM stackable cred blob management will be
available.

Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
---
 security/sara/Makefile            |  2 +-
 security/sara/include/sara_data.h | 84 +++++++++++++++++++++++++++++++++++++++
 security/sara/main.c              |  7 ++++
 security/sara/sara_data.c         | 69 ++++++++++++++++++++++++++++++++
 4 files changed, 161 insertions(+), 1 deletion(-)
 create mode 100644 security/sara/include/sara_data.h
 create mode 100644 security/sara/sara_data.c

diff --git a/security/sara/Makefile b/security/sara/Makefile
index 8acd291..14bf7a8 100644
--- a/security/sara/Makefile
+++ b/security/sara/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_SECURITY_SARA) := sara.o
 
-sara-y := main.o securityfs.o utils.o
+sara-y := main.o securityfs.o utils.o sara_data.o
diff --git a/security/sara/include/sara_data.h b/security/sara/include/sara_data.h
new file mode 100644
index 0000000..9216c47
--- /dev/null
+++ b/security/sara/include/sara_data.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * S.A.R.A. Linux Security Module
+ *
+ * Copyright (C) 2017 Salvatore Mesoraca <s.mesoraca16@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __SARA_DATA_H
+#define __SARA_DATA_H
+
+#include <linux/cred.h>
+#include <linux/init.h>
+#include <linux/lsm_hooks.h>
+#include <linux/spinlock.h>
+
+int sara_data_init(void) __init;
+
+extern struct lsm_blob_sizes sara_blob_sizes __lsm_ro_after_init;
+
+#ifdef CONFIG_SECURITY_SARA_WXPROT
+
+struct sara_data {
+	unsigned long	relro_page;
+	struct file	*relro_file;
+	u16		wxp_flags;
+	u16		execve_flags;
+	bool		relro_page_found;
+	bool		mmap_blocked;
+};
+
+struct sara_shm_data {
+	bool		no_exec;
+	bool		no_write;
+	spinlock_t	lock;
+};
+
+
+static inline struct sara_data *get_sara_data(const struct cred *cred)
+{
+	return cred->security + sara_blob_sizes.lbs_cred;
+}
+
+#define get_current_sara_data() get_sara_data(current_cred())
+
+#define get_sara_wxp_flags(X) (get_sara_data((X))->wxp_flags)
+#define get_current_sara_wxp_flags() get_sara_wxp_flags(current_cred())
+
+#define get_sara_execve_flags(X) (get_sara_data((X))->execve_flags)
+#define get_current_sara_execve_flags() get_sara_execve_flags(current_cred())
+
+#define get_sara_relro_page(X) (get_sara_data((X))->relro_page)
+#define get_current_sara_relro_page() get_sara_relro_page(current_cred())
+
+#define get_sara_relro_file(X) (get_sara_data((X))->relro_file)
+#define get_current_sara_relro_file() get_sara_relro_file(current_cred())
+
+#define get_sara_relro_page_found(X) (get_sara_data((X))->relro_page_found)
+#define get_current_sara_relro_page_found() \
+	get_sara_relro_page_found(current_cred())
+
+#define get_sara_mmap_blocked(X) (get_sara_data((X))->mmap_blocked)
+#define get_current_sara_mmap_blocked() get_sara_mmap_blocked(current_cred())
+
+
+static inline struct sara_shm_data *get_sara_shm_data(
+					const struct kern_ipc_perm *ipc)
+{
+	return ipc->security + sara_blob_sizes.lbs_ipc;
+}
+
+#define get_sara_shm_no_exec(X) (get_sara_shm_data((X))->no_exec)
+#define get_sara_shm_no_write(X) (get_sara_shm_data((X))->no_write)
+#define lock_sara_shm(X) (spin_lock(&get_sara_shm_data((X))->lock))
+#define unlock_sara_shm(X) (spin_unlock(&get_sara_shm_data((X))->lock))
+
+#endif
+
+#endif /* __SARA_H */
diff --git a/security/sara/main.c b/security/sara/main.c
index 52e6d18..dc5dda4 100644
--- a/security/sara/main.c
+++ b/security/sara/main.c
@@ -18,6 +18,7 @@
 #include <linux/printk.h>
 
 #include "include/sara.h"
+#include "include/sara_data.h"
 #include "include/securityfs.h"
 
 static const int sara_version = SARA_VERSION;
@@ -93,6 +94,11 @@ static int __init sara_init(void)
 		goto error;
 	}
 
+	if (sara_data_init()) {
+		pr_crit("impossible to initialize creds.\n");
+		goto error;
+	}
+
 	pr_debug("initialized.\n");
 
 	if (sara_enabled)
@@ -112,4 +118,5 @@ static int __init sara_init(void)
 	.name = "sara",
 	.enabled = &sara_enabled,
 	.init = sara_init,
+	.blobs = &sara_blob_sizes,
 };
diff --git a/security/sara/sara_data.c b/security/sara/sara_data.c
new file mode 100644
index 0000000..9afca37
--- /dev/null
+++ b/security/sara/sara_data.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * S.A.R.A. Linux Security Module
+ *
+ * Copyright (C) 2017 Salvatore Mesoraca <s.mesoraca16@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include "include/sara_data.h"
+
+#ifdef CONFIG_SECURITY_SARA_WXPROT
+#include <linux/cred.h>
+#include <linux/lsm_hooks.h>
+#include <linux/mm.h>
+#include <linux/spinlock.h>
+
+static int sara_cred_prepare(struct cred *new, const struct cred *old,
+			     gfp_t gfp)
+{
+	*get_sara_data(new) = *get_sara_data(old);
+	return 0;
+}
+
+static void sara_cred_transfer(struct cred *new, const struct cred *old)
+{
+	*get_sara_data(new) = *get_sara_data(old);
+}
+
+static int sara_shm_alloc_security(struct kern_ipc_perm *shp)
+{
+	struct sara_shm_data *d;
+
+	d = get_sara_shm_data(shp);
+	spin_lock_init(&d->lock);
+	return 0;
+}
+
+static struct security_hook_list data_hooks[] __lsm_ro_after_init = {
+	LSM_HOOK_INIT(cred_prepare, sara_cred_prepare),
+	LSM_HOOK_INIT(cred_transfer, sara_cred_transfer),
+	LSM_HOOK_INIT(shm_alloc_security, sara_shm_alloc_security),
+};
+
+struct lsm_blob_sizes sara_blob_sizes __lsm_ro_after_init = {
+	.lbs_cred = sizeof(struct sara_data),
+	.lbs_ipc = sizeof(struct sara_shm_data),
+};
+
+int __init sara_data_init(void)
+{
+	security_add_hooks(data_hooks, ARRAY_SIZE(data_hooks), "sara");
+	return 0;
+}
+
+#else /* CONFIG_SECURITY_SARA_WXPROT */
+
+struct lsm_blob_sizes sara_blob_sizes __lsm_ro_after_init = { };
+
+int __init sara_data_init(void)
+{
+	return 0;
+}
+
+#endif
-- 
1.9.1

