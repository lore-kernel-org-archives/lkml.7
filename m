Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF752C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 04:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F008218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 04:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfCVEPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 00:15:43 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:54794 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfCVEPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 00:15:42 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id A160972CC53;
        Fri, 22 Mar 2019 07:15:39 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 95D817CC74C; Fri, 22 Mar 2019 07:15:39 +0300 (MSK)
Date:   Fri, 22 Mar 2019 07:15:39 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Richard Kuo <rkuo@codeaurora.org>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH linux-next v8 2/7] hexagon: define syscall_get_error() and
 syscall_get_return_value()
Message-ID: <20190322041539.GC27266@altlinux.org>
References: <20190322041409.GA27266@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322041409.GA27266@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syscall_get_* functions are required to be implemented on all
architectures in order to extend the generic ptrace API with
PTRACE_GET_SYSCALL_INFO request.

This adds remaining 2 syscall_get_* functions as documented in
asm-generic/syscall.h: syscall_get_error and syscall_get_return_value.

Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: linux-hexagon@vger.kernel.org
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

Notes:
    v8: moved syscall_get_arch to separate audit patchset
    v7: unchanged
    v6: added missing includes
    v5: added syscall_get_error and syscall_get_return_value
    v4: unchanged
    v3: unchanged
    v2: unchanged

 arch/hexagon/include/asm/syscall.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/hexagon/include/asm/syscall.h b/arch/hexagon/include/asm/syscall.h
index 47b0bc3f16be..b6a02ea3ea7f 100644
--- a/arch/hexagon/include/asm/syscall.h
+++ b/arch/hexagon/include/asm/syscall.h
@@ -22,6 +22,8 @@
 #define _ASM_HEXAGON_SYSCALL_H
 
 #include <uapi/linux/audit.h>
+#include <linux/err.h>
+#include <asm/ptrace.h>
 
 typedef long (*syscall_fn)(unsigned long, unsigned long,
 	unsigned long, unsigned long,
@@ -46,6 +48,18 @@ static inline void syscall_get_arguments(struct task_struct *task,
 	memcpy(args, &(&regs->r00)[i], n * sizeof(args[0]));
 }
 
+static inline long syscall_get_error(struct task_struct *task,
+				     struct pt_regs *regs)
+{
+	return IS_ERR_VALUE(regs->r00) ? regs->r00 : 0;
+}
+
+static inline long syscall_get_return_value(struct task_struct *task,
+					    struct pt_regs *regs)
+{
+	return regs->r00;
+}
+
 static inline int syscall_get_arch(struct task_struct *task)
 {
 	return AUDIT_ARCH_HEXAGON;
-- 
ldv
