Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72079C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3D4218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbfC2RMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:12:33 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:41482 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729791AbfC2RMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 13:12:32 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 9E7A372CCAD;
        Fri, 29 Mar 2019 20:12:30 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 91A177CC74C; Fri, 29 Mar 2019 20:12:30 +0300 (MSK)
Date:   Fri, 29 Mar 2019 20:12:30 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] csky: fix syscall_get_arguments() and syscall_set_arguments()
Message-ID: <20190329171230.GB32456@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

C-SKY syscall arguments are located in orig_a0,a1,a2,a3,regs[0],regs[1]
fields of struct pt_regs.

Due to an off-by-one bug and a bug in pointer arithmetic
syscall_get_arguments() was reading orig_a0,regs[1..5] fields instead.
Likewise, syscall_set_arguments() was writing orig_a0,regs[1..5] fields
instead.

Fixes: 4859bfca11c7d ("csky: System Call")
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: stable@vger.kernel.org # v4.20+
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 arch/csky/include/asm/syscall.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/csky/include/asm/syscall.h b/arch/csky/include/asm/syscall.h
index d637445737b7..9a9cd81e66c1 100644
--- a/arch/csky/include/asm/syscall.h
+++ b/arch/csky/include/asm/syscall.h
@@ -49,10 +49,11 @@ syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
 	if (i == 0) {
 		args[0] = regs->orig_a0;
 		args++;
-		i++;
 		n--;
+	} else {
+		i--;
 	}
-	memcpy(args, &regs->a1 + i * sizeof(regs->a1), n * sizeof(args[0]));
+	memcpy(args, &regs->a1 + i, n * sizeof(args[0]));
 }
 
 static inline void
@@ -63,10 +64,11 @@ syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
 	if (i == 0) {
 		regs->orig_a0 = args[0];
 		args++;
-		i++;
 		n--;
+	} else {
+		i--;
 	}
-	memcpy(&regs->a1 + i * sizeof(regs->a1), args, n * sizeof(regs->a0));
+	memcpy(&regs->a1 + i, args, n * sizeof(regs->a1));
 }
 
 static inline int
-- 
ldv
