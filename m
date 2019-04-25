Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEB6C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0ADF20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Lld6tyvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbfDYQOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:14:50 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35745 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbfDYQOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:14:47 -0400
Received: by mail-ed1-f65.google.com with SMTP id y67so420598ede.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=94OQRrOKnY5O5ahGfFGdFMKz2bWV3oMoeoHeI8YdIHQ=;
        b=Lld6tyvDbHUL0zLJEO+g7jNNYlCwkbN9kPsTvh1KFdVtxCkmIZ43TE1+jWIBN2clO3
         uGahpeOhC1PrRAT7oX2+k4pN8hAtCz2Ccw/4GtQziQFoT0GXsXyfuIofhJ1ZyZ2JDsHL
         r5K828QV4XzXMVkq6psaeQnm7xvYT82Z89s2WBU/ASk2M8wrbonn66zxX+qoBCRnd6ab
         fTDIxzbchqw0ixMzjpQWWGjjpzB029tugQiWRaVR5AJv5UW0fQZpNoDkjW6BGxZyRNca
         Cfa1GMoqEsphxYXwYb0jn6Ay9pQijRf25ZSsaYkv1Lj+A3GN5Uip3Zs5F3NgMp4UJTHq
         IJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=94OQRrOKnY5O5ahGfFGdFMKz2bWV3oMoeoHeI8YdIHQ=;
        b=StibQZE9M7o12lIIz5KlLRhrxi72r7KtdB+22oGtEXQF8Blx6N+tNFwU7JY/rW4cKC
         U9lcSWxzRM+tHurX8FpaAxz3d0y6Is3YFWZTYzttzaJOhMq+a0+toXBD2r6t0G0/5T1i
         1+dgUprmR9m74/373+01R2TMbqJuN+Sse+QNaHD0sblEBtiScpIGN0QV60rO+nwgv6Bo
         KGPQOvWdzO/Udo4JLcvtD2J6ngVpssD8wtDvXuyVT+SNIftKlToey/PfXrLt8tKRaXcq
         CfxIStR/2O0UftOoMv1O2ftWcpHH7vmVeECskEh9DcvZhHoa+fGr7LK7Cnn6l0t2sFFk
         ZuWA==
X-Gm-Message-State: APjAAAW1PAjARCJIM0WyRnvPfIZCb040GDOBy7OVjWpbwnF8YwJFiKHs
        bIh24Vo6DtXgrmbv42jpcIVSk8GxCi4=
X-Google-Smtp-Source: APXvYqwZ8Se+mjp8hzgUY6P5IBexDUVmwhh5f0ksumsrwP4eNP8c65vsUEbzG/+ZIC4llOTHFs/Qdw==
X-Received: by 2002:a50:adda:: with SMTP id b26mr11390663edd.2.1556208885140;
        Thu, 25 Apr 2019 09:14:45 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id br19sm4147042ejb.48.2019.04.25.09.14.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 09:14:44 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCHv3 16/27] x86/vdso: Switch image on setns()/unshare()/clone()
Date:   Thu, 25 Apr 2019 17:14:05 +0100
Message-Id: <20190425161416.26600-17-dima@arista.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190425161416.26600-1-dima@arista.com>
References: <20190425161416.26600-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it has been discussed on timens RFC, adding a new conditional branch
`if (inside_time_ns)` on VDSO for all processes is undesirable.
It will add a penalty for everybody as branch predictor may mispredict
the jump. Also there are instruction cache lines wasted on cmp/jmp.

Those effects of introducing time namespace are very much unwanted
having in mind how much work have been spent on micro-optimisation
vdso code.

Addressing those problems, there are two versions of VDSO's .so:
for host tasks (without any penalty) and for processes inside of time
namespace with clk_to_ns() that subtracts offsets from host's time.

Whenever a user does setns()/unshare() or clone() with CLONE_TIMENS,
change VDSO image in mm and zap existing VVAR/VDSO page tables.
They will be re-faulted with corresponding image and VVAR offsets.

Co-developed-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vma.c   | 29 +++++++++++++++++++++++++++++
 arch/x86/include/asm/vdso.h |  1 +
 kernel/time_namespace.c     | 11 +++++++++++
 3 files changed, 41 insertions(+)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 6aae9c0d400d..28628950214d 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -25,6 +25,7 @@
 #include <asm/cpufeature.h>
 #include <asm/mshyperv.h>
 #include <asm/page.h>
+#include <asm/tlb.h>
 
 #if defined(CONFIG_X86_64)
 unsigned int __read_mostly vdso64_enabled = 1;
@@ -189,6 +190,34 @@ static const struct vm_special_mapping vvar_mapping = {
 	.mremap = vvar_mremap,
 };
 
+#ifdef CONFIG_TIME_NS
+int vdso_join_timens(struct task_struct *task, bool inside_ns)
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
+		if (vma_is_special_mapping(vma, &vdso_mapping))
+			zap_page_range(vma, vma->vm_start, size);
+	}
+
+	up_write(&mm->mmap_sem);
+	return 0;
+}
+#else /* CONFIG_TIME_NS */
+int vdso_join_timens(struct task_struct *task, bool inside_ns)
+{
+	return -ENXIO;
+}
+#endif
+
 /*
  * Add vdso and vvar mappings to current process.
  * @image          - blob to map
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index a620c7f23425..583133446874 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -46,6 +46,7 @@ extern struct vdso_image vdso_image_32;
 extern void __init init_vdso_image(struct vdso_image *image);
 
 extern int map_vdso_once(const struct vdso_image *image, unsigned long addr);
+extern int vdso_join_timens(struct task_struct *task, bool inside_ns);
 
 #endif /* __ASSEMBLER__ */
 
diff --git a/kernel/time_namespace.c b/kernel/time_namespace.c
index 4828447721ec..e806accc4eaf 100644
--- a/kernel/time_namespace.c
+++ b/kernel/time_namespace.c
@@ -14,6 +14,7 @@
 #include <linux/proc_ns.h>
 #include <linux/sched/task.h>
 #include <linux/mm.h>
+#include <asm/vdso.h>
 
 static struct ucounts *inc_time_namespaces(struct user_namespace *ns)
 {
@@ -155,11 +156,16 @@ static void timens_put(struct ns_common *ns)
 static int timens_install(struct nsproxy *nsproxy, struct ns_common *new)
 {
 	struct time_namespace *ns = to_time_ns(new);
+	int ret;
 
 	if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN) ||
 	    !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
 		return -EPERM;
 
+	ret = vdso_join_timens(current, ns != &init_time_ns);
+	if (ret)
+		return ret;
+
 	get_time_ns(ns);
 	get_time_ns(ns);
 	put_time_ns(nsproxy->time_ns);
@@ -174,10 +180,15 @@ int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
 {
 	struct ns_common *nsc = &nsproxy->time_ns_for_children->ns;
 	struct time_namespace *ns = to_time_ns(nsc);
+	int ret;
 
 	if (nsproxy->time_ns == nsproxy->time_ns_for_children)
 		return 0;
 
+	ret = vdso_join_timens(tsk, ns != &init_time_ns);
+	if (ret)
+		return ret;
+
 	get_time_ns(ns);
 	put_time_ns(nsproxy->time_ns);
 	nsproxy->time_ns = ns;
-- 
2.21.0

