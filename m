Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BA7C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B14218DA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbfGVNWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:22:45 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35839 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728819AbfGVNWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:22:44 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45sj2n4jwQz9s8m; Mon, 22 Jul 2019 23:22:41 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     linuxppc-dev@ozlabs.org
Cc:     christian@brauner.io, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Wire up clone3 syscall
Date:   Mon, 22 Jul 2019 23:22:31 +1000
Message-Id: <20190722132231.10169-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up the new clone3 syscall added in commit 7f192e3cd316 ("fork:
add clone3").

This requires a ppc_clone3 wrapper, in order to save the non-volatile
GPRs before calling into the generic syscall code. Otherwise we hit
the BUG_ON in CHECK_FULL_REGS in copy_thread().

Lightly tested using Christian's test code on a Power8 LE VM.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/unistd.h        | 1 +
 arch/powerpc/kernel/entry_64.S           | 5 +++++
 arch/powerpc/kernel/syscalls/syscall.tbl | 1 +
 3 files changed, 7 insertions(+)

diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index 68473c3c471c..b0720c7c3fcf 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -49,6 +49,7 @@
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_VFORK
 #define __ARCH_WANT_SYS_CLONE
+#define __ARCH_WANT_SYS_CLONE3
 
 #endif		/* __ASSEMBLY__ */
 #endif /* _ASM_POWERPC_UNISTD_H_ */
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index d9105fcf4021..0a0b5310f54a 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -487,6 +487,11 @@ _GLOBAL(ppc_clone)
 	bl	sys_clone
 	b	.Lsyscall_exit
 
+_GLOBAL(ppc_clone3)
+       bl      save_nvgprs
+       bl      sys_clone3
+       b       .Lsyscall_exit
+
 _GLOBAL(ppc32_swapcontext)
 	bl	save_nvgprs
 	bl	compat_sys_swapcontext
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index f2c3bda2d39f..6886ecb590d5 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -516,3 +516,4 @@
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
+435	common	clone3				ppc_clone3
-- 
2.20.1

