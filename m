Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F298C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 23:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1242085A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 23:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfCQXaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 19:30:15 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:41318 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfCQXaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 19:30:15 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id B3FBF72CC53;
        Mon, 18 Mar 2019 02:30:11 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id A944F7CC74C; Mon, 18 Mar 2019 02:30:11 +0300 (MSK)
Date:   Mon, 18 Mar 2019 02:30:11 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Guan Xuetao <gxt@pku.edu.cn>, Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/13] unicore32: define syscall_get_arch()
Message-ID: <20190317233011.GM16301@altlinux.org>
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
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: Guan Xuetao <gxt@pku.edu.cn>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: linux-audit@redhat.com
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

Notes:
    v2: unchanged

 arch/unicore32/include/asm/syscall.h | 12 ++++++++++++
 include/uapi/linux/audit.h           |  1 +
 2 files changed, 13 insertions(+)
 create mode 100644 arch/unicore32/include/asm/syscall.h

diff --git a/arch/unicore32/include/asm/syscall.h b/arch/unicore32/include/asm/syscall.h
new file mode 100644
index 000000000000..3a6b885476b4
--- /dev/null
+++ b/arch/unicore32/include/asm/syscall.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_UNICORE_SYSCALL_H
+#define _ASM_UNICORE_SYSCALL_H
+
+#include <uapi/linux/audit.h>
+
+static inline int syscall_get_arch(void)
+{
+	return AUDIT_ARCH_UNICORE;
+}
+
+#endif	/* _ASM_UNICORE_SYSCALL_H */
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index bcc0619b046f..3901c51c0b93 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -424,6 +424,7 @@ enum {
 #define AUDIT_ARCH_TILEGX	(EM_TILEGX|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_TILEGX32	(EM_TILEGX|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_TILEPRO	(EM_TILEPRO|__AUDIT_ARCH_LE)
+#define AUDIT_ARCH_UNICORE	(EM_UNICORE|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_X86_64	(EM_X86_64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_XTENSA	(EM_XTENSA)
 
-- 
ldv
