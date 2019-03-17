Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBDEC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 23:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1582820872
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 23:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfCQXaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 19:30:01 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:40972 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfCQXaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 19:30:01 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 0440872CC53;
        Mon, 18 Mar 2019 02:29:58 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id E147B7CC74C; Mon, 18 Mar 2019 02:29:57 +0300 (MSK)
Date:   Mon, 18 Mar 2019 02:29:57 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Vincent Chen <vincentc@andestech.com>,
        Greentime Hu <greentime@andestech.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/13] nds32: define syscall_get_arch()
Message-ID: <20190317232957.GJ16301@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syscall_get_arch() is required to be implemented on all architectures
in addition to already implemented syscall_get_nr(),
syscall_get_arguments(), syscall_get_error(), and
syscall_get_return_value() functions in order to extend the generic
ptrace API with PTRACE_GET_SYSCALL_INFO request.

Acked-by: Paul Moore <paul@paul-moore.com>
Acked-by: Vincent Chen <vincentc@andestech.com>
Acked-by: Greentime Hu <greentime@andestech.com>
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: linux-audit@redhat.com
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

Notes:
    v2: added Acked-by

 arch/nds32/include/asm/syscall.h | 9 +++++++++
 include/uapi/linux/audit.h       | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/arch/nds32/include/asm/syscall.h b/arch/nds32/include/asm/syscall.h
index f7e5e86765fe..cc56a3962f8b 100644
--- a/arch/nds32/include/asm/syscall.h
+++ b/arch/nds32/include/asm/syscall.h
@@ -5,6 +5,7 @@
 #ifndef _ASM_NDS32_SYSCALL_H
 #define _ASM_NDS32_SYSCALL_H	1
 
+#include <uapi/linux/audit.h>
 #include <linux/err.h>
 struct task_struct;
 struct pt_regs;
@@ -185,4 +186,12 @@ void syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
 
 	memcpy(&regs->uregs[0] + i, args, n * sizeof(args[0]));
 }
+
+static inline int
+syscall_get_arch(void)
+{
+	return IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)
+		? AUDIT_ARCH_NDS32BE : AUDIT_ARCH_NDS32;
+}
+
 #endif /* _ASM_NDS32_SYSCALL_H */
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index fc94e74c8b77..fb0529da4d49 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -401,6 +401,8 @@ enum {
 #define AUDIT_ARCH_MIPSEL64	(EM_MIPS|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_MIPSEL64N32	(EM_MIPS|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE|\
 				 __AUDIT_ARCH_CONVENTION_MIPS64_N32)
+#define AUDIT_ARCH_NDS32	(EM_NDS32|__AUDIT_ARCH_LE)
+#define AUDIT_ARCH_NDS32BE	(EM_NDS32)
 #define AUDIT_ARCH_OPENRISC	(EM_OPENRISC)
 #define AUDIT_ARCH_PARISC	(EM_PARISC)
 #define AUDIT_ARCH_PARISC64	(EM_PARISC|__AUDIT_ARCH_64BIT)
-- 
ldv
