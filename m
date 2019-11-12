Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D043CC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BABD222C5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ZYnvrBPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfKLB2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 20:28:15 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38053 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbfKLB2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 20:28:08 -0500
Received: by mail-wm1-f65.google.com with SMTP id z19so1200438wmk.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 17:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Umru6QSobNHT0XPYIylvIbERHxgCyEkBdhGuczS4AHA=;
        b=ZYnvrBPSgUro+Zo7qgA6oXB8Ua81N0YSMlkwoRArTXj06aqAWyq42acqHklPoo4IM4
         3VVbltpwI+ao/lD9labVlMc9EL4T8Ubb/kgm0zxZbdm5ys1hUE+5UkyutKMtDxJdHXB1
         HPUCukUScBBDYu951QBQRrN2O0w9nIHNNFh/q356fZwOp5kJVfN9H/Pq3+T+kgQEdEeZ
         bx8Pp7Ma/1iHIh7NR1gKHgRqKA3zBeTBcu8AU5ZUFs+WhtHB3XvOE/QZCbirLWYZ2znc
         q0YhSsFLvfBsUUN3b7vqpoA54869G6aBrN/DMJ3dseJx5uQOr4rgghFkpgvrHcBOmOdK
         /vGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Umru6QSobNHT0XPYIylvIbERHxgCyEkBdhGuczS4AHA=;
        b=Q/gaQK1anbMDswRs0jRVD9sc74etJ2GgunqMzyCentaf34mm4fs38NYBOx58LEVNXK
         AH3k3rMw7P1EdRZBsPlKrYLDCS7mKIVjj+Vkt1p5PaFtDFh4V6DfscfpRlRexZD2a07f
         mk46ceji1uCX4GohGCtAWEM+z1No4y1/4knzdB/MyKey4dSJC90MSlA1X9T5/n++5qaI
         kLALfQ9xYbXB/cCU87c3whZV3k8uZeHVT0odNP0euS/VYTUHCRODL4KKNLJgiao5ujkO
         rhia9sxg92zQCMIHi5yUTF7tKtpwPpXIUVT0AuZASm6ojOfbRz8RXVjH5CDN/xy9iHtz
         DAMA==
X-Gm-Message-State: APjAAAV+gsKa3ruPmklQZr5kTYGWQd1BLiV3Vz/k9hFLfn2yw0xc7cWz
        zMBlPJdUzJf+gcRgni1UVFDzyqNIzW0=
X-Google-Smtp-Source: APXvYqziRUrLa7U82Jn8xXV8O4xGCCV52ZQbIxorTAJzYRJsjRnZxdfqdMPxmJrpJ1wcKRW+9h0ZTA==
X-Received: by 2002:a1c:6885:: with SMTP id d127mr1486930wmc.64.1573522086711;
        Mon, 11 Nov 2019 17:28:06 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u187sm1508096wme.15.2019.11.11.17.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:28:06 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCHv8 26/34] x86/vdso: Zap vvar pages on switch a time namspace
Date:   Tue, 12 Nov 2019 01:27:15 +0000
Message-Id: <20191112012724.250792-27-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112012724.250792-1-dima@arista.com>
References: <20191112012724.250792-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VVAR page layout depends on whether a task belongs to the root or
non-root time namespace. Whenever a task changes its namespace, the VVAR
page tables are cleared and then they will re-faulted with a
corresponding layout.

Co-developed-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vma.c      | 27 +++++++++++++++++++++++++++
 include/linux/time_namespace.h |  9 +++++++++
 kernel/time/namespace.c        | 10 ++++++++++
 3 files changed, 46 insertions(+)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index d6cb8a16f368..57ada3e95f8d 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -50,6 +50,7 @@ void __init init_vdso_image(const struct vdso_image *image)
 						image->alt_len));
 }
 
+static const struct vm_special_mapping vvar_mapping;
 struct linux_binprm;
 
 static vm_fault_t vdso_fault(const struct vm_special_mapping *sm,
@@ -127,6 +128,32 @@ static struct page *find_timens_vvar_page(struct vm_area_struct *vma)
 
 	return NULL;
 }
+
+/*
+ * The vvar page layout depends on whether a task belongs to the root or
+ * non-root time namespace. Whenever a task changes its namespace, the VVAR
+ * page tables are cleared and then they will re-faulted with a
+ * corresponding layout.
+ * See also the comment near timens_setup_vdso_data() for details.
+ */
+int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
+{
+	struct mm_struct *mm = task->mm;
+	struct vm_area_struct *vma;
+
+	if (down_write_killable(&mm->mmap_sem))
+		return -EINTR;
+
+	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+		unsigned long size = vma->vm_end - vma->vm_start;
+
+		if (vma_is_special_mapping(vma, &vvar_mapping))
+			zap_page_range(vma, vma->vm_start, size);
+	}
+
+	up_write(&mm->mmap_sem);
+	return 0;
+}
 #else
 static inline struct page *find_timens_vvar_page(struct vm_area_struct *vma)
 {
diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index cdb438ba0037..f1cdd3a6f842 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -30,6 +30,9 @@ struct time_namespace {
 extern struct time_namespace init_time_ns;
 
 #ifdef CONFIG_TIME_NS
+extern int vdso_join_timens(struct task_struct *task,
+			    struct time_namespace *ns);
+
 static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
 {
 	kref_get(&ns->kref);
@@ -74,6 +77,12 @@ static inline ktime_t timens_ktime_to_host(clockid_t clockid, ktime_t tim)
 }
 
 #else
+static inline int vdso_join_timens(struct task_struct *task,
+				   struct time_namespace *ns)
+{
+	return 0;
+}
+
 static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
 {
 	return NULL;
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index e14cd1ca387d..0dc0742ed1ee 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -280,6 +280,7 @@ static void timens_put(struct ns_common *ns)
 static int timens_install(struct nsproxy *nsproxy, struct ns_common *new)
 {
 	struct time_namespace *ns = to_time_ns(new);
+	int err;
 
 	if (!current_is_single_threaded())
 		return -EUSERS;
@@ -290,6 +291,10 @@ static int timens_install(struct nsproxy *nsproxy, struct ns_common *new)
 
 	timens_set_vvar_page(current, ns);
 
+	err = vdso_join_timens(current, ns);
+	if (err)
+		return err;
+
 	get_time_ns(ns);
 	put_time_ns(nsproxy->time_ns);
 	nsproxy->time_ns = ns;
@@ -304,6 +309,7 @@ int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
 {
 	struct ns_common *nsc = &nsproxy->time_ns_for_children->ns;
 	struct time_namespace *ns = to_time_ns(nsc);
+	int err;
 
 	/* create_new_namespaces() already incremented the ref counter */
 	if (nsproxy->time_ns == nsproxy->time_ns_for_children)
@@ -311,6 +317,10 @@ int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
 
 	timens_set_vvar_page(tsk, ns);
 
+	err = vdso_join_timens(tsk, ns);
+	if (err)
+		return err;
+
 	get_time_ns(ns);
 	put_time_ns(nsproxy->time_ns);
 	nsproxy->time_ns = ns;
-- 
2.24.0

