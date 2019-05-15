Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC13C04AB7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 02:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736A72166E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 02:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfEOC2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 22:28:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbfEOC2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 22:28:31 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0153B21726;
        Wed, 15 May 2019 02:28:31 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hQjeg-0005Ow-4t; Tue, 14 May 2019 22:28:30 -0400
Message-Id: <20190515022830.040970789@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 14 May 2019 22:27:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [for-next][PATCH 4/5] livepatch: Remove klp_check_compiler_support()
References: <20190515022747.719887946@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

The only purpose of klp_check_compiler_support() is to make sure that we
are not using ftrace on x86 via mcount (because that's executed only after
prologue has already happened, and that's too late for livepatching
purposes).

Now that mcount is not supported by ftrace any more, there is no need for
klp_check_compiler_support() either.

Link: http://lkml.kernel.org/r/nycvar.YFH.7.76.1905102346100.17054@cbobk.fhfr.pm

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/powerpc/include/asm/livepatch.h | 5 -----
 arch/s390/include/asm/livepatch.h    | 5 -----
 arch/x86/include/asm/livepatch.h     | 5 -----
 kernel/livepatch/core.c              | 8 --------
 4 files changed, 23 deletions(-)

diff --git a/arch/powerpc/include/asm/livepatch.h b/arch/powerpc/include/asm/livepatch.h
index 5070df19d463..c005aee5ea43 100644
--- a/arch/powerpc/include/asm/livepatch.h
+++ b/arch/powerpc/include/asm/livepatch.h
@@ -24,11 +24,6 @@
 #include <linux/sched/task_stack.h>
 
 #ifdef CONFIG_LIVEPATCH
-static inline int klp_check_compiler_support(void)
-{
-	return 0;
-}
-
 static inline void klp_arch_set_pc(struct pt_regs *regs, unsigned long ip)
 {
 	regs->nip = ip;
diff --git a/arch/s390/include/asm/livepatch.h b/arch/s390/include/asm/livepatch.h
index 672f95b12d40..818612b784cd 100644
--- a/arch/s390/include/asm/livepatch.h
+++ b/arch/s390/include/asm/livepatch.h
@@ -13,11 +13,6 @@
 
 #include <asm/ptrace.h>
 
-static inline int klp_check_compiler_support(void)
-{
-	return 0;
-}
-
 static inline void klp_arch_set_pc(struct pt_regs *regs, unsigned long ip)
 {
 	regs->psw.addr = ip;
diff --git a/arch/x86/include/asm/livepatch.h b/arch/x86/include/asm/livepatch.h
index 2f2bdf0662f8..a66f6706c2de 100644
--- a/arch/x86/include/asm/livepatch.h
+++ b/arch/x86/include/asm/livepatch.h
@@ -24,11 +24,6 @@
 #include <asm/setup.h>
 #include <linux/ftrace.h>
 
-static inline int klp_check_compiler_support(void)
-{
-	return 0;
-}
-
 static inline void klp_arch_set_pc(struct pt_regs *regs, unsigned long ip)
 {
 	regs->ip = ip;
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index eb0ee10a1981..112a36ed4a09 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -1220,14 +1220,6 @@ void klp_module_going(struct module *mod)
 
 static int __init klp_init(void)
 {
-	int ret;
-
-	ret = klp_check_compiler_support();
-	if (ret) {
-		pr_info("Your compiler is too old; turning off.\n");
-		return -EINVAL;
-	}
-
 	klp_root_kobj = kobject_create_and_add("livepatch", kernel_kobj);
 	if (!klp_root_kobj)
 		return -ENOMEM;
-- 
2.20.1


