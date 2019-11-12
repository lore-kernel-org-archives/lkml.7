Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7781C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72803222D2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="gpKRrTBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfKLB2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 20:28:09 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52831 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfKLB2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 20:28:02 -0500
Received: by mail-wm1-f66.google.com with SMTP id l1so1305478wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 17:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uz85eFOmw9eLe/gvfSQH1CU3diio5dCJ/bAD2qd/VU8=;
        b=gpKRrTBpgN66zUcyxXmMiN9olyPrBDZriHy6MODURyKZt2CiBfI3Webvcs+Rocy1uY
         0H8i6IXgHpG40TARF+zrmgkcwXZjG5n6tJQFfR6BFndo2T3GrkhJsQaoUYe+GR/BKymf
         W6kv3+VHoyo8lkX9eFpcqjHzimTnUAAJBHiJLQzXCXDjxCF3tRFMkb2wHDiBQPpGdgAp
         m85mxMcIPx5mizSRZcmy3FKshd3ycQl5hxGQXKRBZBn/mTp4XcuNNmwjt9V+LjfyAQgL
         jqIZ4DjGkqUbrbNJ7t66G1UAbhYQ2Pd0+SO25dpoEbj+sLFCiiWGNkUtWAIl8OiHd0Pm
         StcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uz85eFOmw9eLe/gvfSQH1CU3diio5dCJ/bAD2qd/VU8=;
        b=onn1hvCMP3/lPvhLqW9TqKBvMYNjDEfodm5FYZIKvM3h/763L9w4osSnMDomkBtxy/
         WSPqayZqgR5RpDbe97eTXd88NqMeZ21MKXQmPjn6jBVAV+tEvT8SOhsVHco9UApVmJE3
         nXC8dij84RgQwEyp+Bq3+LEMuovM2MoenpfS/W+dBE8nl0YJfsogZhXzbWTlcOSewvYR
         fu7O1xCocVFfhaNsw8PQWne6SbUSqwk8zssnRAoLt4WyjTefKOh2fR93Lt4exaO6Vt0B
         I3wemI4ilmHKR7tszn2PkDtUPSesH/ZlSoak9t8Jgg1gJQpexOnSAPSFDJpRCCXMPoWO
         uKnw==
X-Gm-Message-State: APjAAAWfcxcLpEVSLkYAzI3ITwk+4MCvijesgmkVyEuPI47gw+ygpw7W
        Ka7G7EO2LbN1UnrdjPPQbUaoaYll9gU=
X-Google-Smtp-Source: APXvYqyKBWNMmVaj5SuoqSYxX5UN3z/BGtBiK0BH5DbbJTqYAWgt0WrrLNo77oGEluBiZj/uKHhbIQ==
X-Received: by 2002:a1c:7d47:: with SMTP id y68mr1483434wmc.157.1573522080001;
        Mon, 11 Nov 2019 17:28:00 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u187sm1508096wme.15.2019.11.11.17.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:27:59 -0800 (PST)
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
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv8 21/34] x86/vdso: Provide vdso_data offset on vvar_page
Date:   Tue, 12 Nov 2019 01:27:10 +0000
Message-Id: <20191112012724.250792-22-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112012724.250792-1-dima@arista.com>
References: <20191112012724.250792-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VDSO support for Time namespace needs to set up a page with the same
layout as VVAR. That timens page will be placed on position of VVAR page
inside namespace. That page has vdso_data->seq set to 1 to enforce
the slow path and vdso_data->clock_mode set to VCLOCK_TIMENS to enforce
the time namespace handling path.

To prepare timens page kernel needs to know the vdso_data offset.
Provide arch_get_vdso_data() helper for locating vdso_data on VVAR page.

Co-developed-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vdso-layout.lds.S |  2 --
 arch/x86/entry/vdso/vma.c             | 11 +++++++++++
 arch/x86/include/asm/vvar.h           |  8 ++++----
 arch/x86/kernel/vmlinux.lds.S         |  4 +---
 include/linux/time_namespace.h        |  1 +
 5 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S
index 93c6dc7812d0..2330daad67c3 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -21,9 +21,7 @@ SECTIONS
 
 	/* Place all vvars at the offsets in asm/vvar.h. */
 #define EMIT_VVAR(name, offset) vvar_ ## name = vvar_page + offset;
-#define __VVAR_KERNEL_LDS
 #include <asm/vvar.h>
-#undef __VVAR_KERNEL_LDS
 #undef EMIT_VVAR
 
 	pvclock_page = vvar_start + PAGE_SIZE;
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 000db8282cc8..5dab706aca2e 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -24,6 +24,17 @@
 #include <asm/cpufeature.h>
 #include <clocksource/hyperv_timer.h>
 
+#undef _ASM_X86_VVAR_H
+#define EMIT_VVAR(name, offset)	\
+	const size_t name ## _offset = offset;
+#include <asm/vvar.h>
+
+struct vdso_data *arch_get_vdso_data(void *vvar_page)
+{
+	return (struct vdso_data *)(vvar_page + _vdso_data_offset);
+}
+#undef EMIT_VVAR
+
 #if defined(CONFIG_X86_64)
 unsigned int __read_mostly vdso64_enabled = 1;
 #endif
diff --git a/arch/x86/include/asm/vvar.h b/arch/x86/include/asm/vvar.h
index 32f5d9a0b90e..ff2de3025388 100644
--- a/arch/x86/include/asm/vvar.h
+++ b/arch/x86/include/asm/vvar.h
@@ -19,10 +19,10 @@
 #ifndef _ASM_X86_VVAR_H
 #define _ASM_X86_VVAR_H
 
-#if defined(__VVAR_KERNEL_LDS)
-
-/* The kernel linker script defines its own magic to put vvars in the
- * right place.
+#ifdef EMIT_VVAR
+/*
+ * EMIT_VVAR() is used by the kernel linker script to put vvars in the
+ * right place. Also, it's used by kernel code to import offsets values.
  */
 #define DECLARE_VVAR(offset, type, name) \
 	EMIT_VVAR(name, offset)
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 3a1a819da137..e3296aa028fe 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -193,12 +193,10 @@ SECTIONS
 		__vvar_beginning_hack = .;
 
 		/* Place all vvars at the offsets in asm/vvar.h. */
-#define EMIT_VVAR(name, offset) 			\
+#define EMIT_VVAR(name, offset)				\
 		. = __vvar_beginning_hack + offset;	\
 		*(.vvar_ ## name)
-#define __VVAR_KERNEL_LDS
 #include <asm/vvar.h>
-#undef __VVAR_KERNEL_LDS
 #undef EMIT_VVAR
 
 		/*
diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index a68b1ab7b5bb..90e82654b4ce 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -37,6 +37,7 @@ extern struct time_namespace *copy_time_ns(unsigned long flags,
 	struct user_namespace *user_ns, struct time_namespace *old_ns);
 extern void free_time_ns(struct kref *kref);
 extern int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk);
+extern struct vdso_data *arch_get_vdso_data(void *vvar_page);
 
 static inline void put_time_ns(struct time_namespace *ns)
 {
-- 
2.24.0

