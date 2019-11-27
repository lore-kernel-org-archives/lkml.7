Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD58CC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944A42154A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574886924;
	bh=HGFXd98nD+PFSmAQmggNFOCRGpwtpq835HAnak/s208=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XfYU/jOTHQoRnoRgVWZN609ap2GJAKzwg7Wgd0NRcKUs117mfc3IDr3GJraO51Eje
	 hYg8S4nFdyEeZCKy72w99+dUI+KXrxNNxrNztmyR3P017H/OuYexMCg5pfKM6HpSOS
	 HnjT3JpLzqlwyTjFtPmqeEp1z1zyMyPmelrm3kOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfK0UfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:35:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:36374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727191AbfK0UfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:35:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75B0621582;
        Wed, 27 Nov 2019 20:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574886918;
        bh=HGFXd98nD+PFSmAQmggNFOCRGpwtpq835HAnak/s208=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a+34tSr2ysbe8Za8UtyNhTbB3+To7lyAzfWtpOzA0Y8rcMmGUH/O4xtbyRFx7lJ7o
         Mklr7TQuJ0MC1QBUrfE8zR2lIgF5MWS4LDXEWRft1pLxXB03WfCkeXbgGD+MI8rkp6
         D4bmjnQL/vRGrNFoe70upKqndVO92T/6fLY92/LA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 043/132] kprobes, x86/ptrace.h: Make regs_get_kernel_stack_nth() not fault on bad stack
Date:   Wed, 27 Nov 2019 21:30:34 +0100
Message-Id: <20191127202939.740492140@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202857.270233486@linuxfoundation.org>
References: <20191127202857.270233486@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

[ Upstream commit c2712b858187f5bcd7b042fe4daa3ba3a12635c0 ]

Andy had some concerns about using regs_get_kernel_stack_nth() in a new
function regs_get_kernel_argument() as if there's any error in the stack
code, it could cause a bad memory access. To be on the safe side, call
probe_kernel_read() on the stack address to be extra careful in accessing
the memory. A helper function, regs_get_kernel_stack_nth_addr(), was added
to just return the stack address (or NULL if not on the stack), that will be
used to find the address (and could be used by other functions) and read the
address with kernel_probe_read().

Requested-by: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20181017165951.09119177@gandalf.local.home
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/ptrace.h | 42 +++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 0d8e0831b1a07..3daec418c822f 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -205,24 +205,52 @@ static inline int regs_within_kernel_stack(struct pt_regs *regs,
 		(kernel_stack_pointer(regs) & ~(THREAD_SIZE - 1)));
 }
 
+/**
+ * regs_get_kernel_stack_nth_addr() - get the address of the Nth entry on stack
+ * @regs:	pt_regs which contains kernel stack pointer.
+ * @n:		stack entry number.
+ *
+ * regs_get_kernel_stack_nth() returns the address of the @n th entry of the
+ * kernel stack which is specified by @regs. If the @n th entry is NOT in
+ * the kernel stack, this returns NULL.
+ */
+static inline unsigned long *regs_get_kernel_stack_nth_addr(struct pt_regs *regs, unsigned int n)
+{
+	unsigned long *addr = (unsigned long *)kernel_stack_pointer(regs);
+
+	addr += n;
+	if (regs_within_kernel_stack(regs, (unsigned long)addr))
+		return addr;
+	else
+		return NULL;
+}
+
+/* To avoid include hell, we can't include uaccess.h */
+extern long probe_kernel_read(void *dst, const void *src, size_t size);
+
 /**
  * regs_get_kernel_stack_nth() - get Nth entry of the stack
  * @regs:	pt_regs which contains kernel stack pointer.
  * @n:		stack entry number.
  *
  * regs_get_kernel_stack_nth() returns @n th entry of the kernel stack which
- * is specified by @regs. If the @n th entry is NOT in the kernel stack,
+ * is specified by @regs. If the @n th entry is NOT in the kernel stack
  * this returns 0.
  */
 static inline unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
 						      unsigned int n)
 {
-	unsigned long *addr = (unsigned long *)kernel_stack_pointer(regs);
-	addr += n;
-	if (regs_within_kernel_stack(regs, (unsigned long)addr))
-		return *addr;
-	else
-		return 0;
+	unsigned long *addr;
+	unsigned long val;
+	long ret;
+
+	addr = regs_get_kernel_stack_nth_addr(regs, n);
+	if (addr) {
+		ret = probe_kernel_read(&val, addr, sizeof(val));
+		if (!ret)
+			return val;
+	}
+	return 0;
 }
 
 #define arch_has_single_step()	(1)
-- 
2.20.1



