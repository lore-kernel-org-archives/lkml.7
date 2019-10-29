Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73384CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5AC20679
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390637AbfJ2Q6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 12:58:46 -0400
Received: from foss.arm.com ([217.140.110.172]:54558 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727279AbfJ2Q6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 12:58:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F44C337;
        Tue, 29 Oct 2019 09:58:45 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C11D13F71F;
        Tue, 29 Oct 2019 09:58:42 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@arm.com,
        catalin.marinas@arm.com, deller@gmx.de, duwe@suse.de,
        James.Bottomley@HansenPartnership.com, james.morse@arm.com,
        jeyu@kernel.org, jpoimboe@redhat.com, jthierry@redhat.com,
        linux-parisc@vger.kernel.org, mark.rutland@arm.com,
        mingo@redhat.com, peterz@infradead.org, svens@stackframe.org,
        takahiro.akashi@linaro.org, will@kernel.org
Subject: [PATCHv2 1/8] ftrace: add ftrace_init_nop()
Date:   Tue, 29 Oct 2019 16:58:25 +0000
Message-Id: <20191029165832.33606-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191029165832.33606-1-mark.rutland@arm.com>
References: <20191029165832.33606-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Architectures may need to perform special initialization of ftrace
callsites, and today they do so by special-casing ftrace_make_nop() when
the expected branch address is MCOUNT_ADDR. In some cases (e.g. for
patchable-function-entry), we don't have an mcount-like symbol and don't
want a synthetic MCOUNT_ADDR, but we may need to perform some
initialization of callsites.

To make it possible to separate initialization from runtime
modification, and to handle cases without an mcount-like symbol, this
patch adds an optional ftrace_init_nop() function that architectures can
implement, which does not pass a branch address.

Where an architecture does not provide ftrace_init_nop(), we will fall
back to the existing behaviour of calling ftrace_make_nop() with
MCOUNT_ADDR.

At the same time, ftrace_code_disable() is renamed to
ftrace_nop_initialize() to make it clearer that it is intended to
intialize a callsite into a disabled state, and is not for disabling a
callsite that has been runtime enabled. The kerneldoc description of rec
arguments is updated to cover non-mcount callsites.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Torsten Duwe <duwe@suse.de>
---
 include/linux/ftrace.h | 35 ++++++++++++++++++++++++++++++++---
 kernel/trace/ftrace.c  |  6 +++---
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 8a8cb3c401b2..9867d90d635e 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -499,7 +499,7 @@ static inline int ftrace_disable_ftrace_graph_caller(void) { return 0; }
 /**
  * ftrace_make_nop - convert code into nop
  * @mod: module structure if called by module load initialization
- * @rec: the mcount call site record
+ * @rec: the call site record (e.g. mcount/fentry)
  * @addr: the address that the call site should be calling
  *
  * This is a very sensitive operation and great care needs
@@ -520,9 +520,38 @@ static inline int ftrace_disable_ftrace_graph_caller(void) { return 0; }
 extern int ftrace_make_nop(struct module *mod,
 			   struct dyn_ftrace *rec, unsigned long addr);
 
+
+/**
+ * ftrace_init_nop - initialize a nop call site
+ * @mod: module structure if called by module load initialization
+ * @rec: the call site record (e.g. mcount/fentry)
+ *
+ * This is a very sensitive operation and great care needs
+ * to be taken by the arch.  The operation should carefully
+ * read the location, check to see if what is read is indeed
+ * what we expect it to be, and then on success of the compare,
+ * it should write to the location.
+ *
+ * The code segment at @rec->ip should contain the contents created by
+ * the compiler
+ *
+ * Return must be:
+ *  0 on success
+ *  -EFAULT on error reading the location
+ *  -EINVAL on a failed compare of the contents
+ *  -EPERM  on error writing to the location
+ * Any other value will be considered a failure.
+ */
+#ifndef ftrace_init_nop
+static inline int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
+{
+	return ftrace_make_nop(mod, rec, MCOUNT_ADDR);
+}
+#endif
+
 /**
  * ftrace_make_call - convert a nop call site into a call to addr
- * @rec: the mcount call site record
+ * @rec: the call site record (e.g. mcount/fentry)
  * @addr: the address that the call site should call
  *
  * This is a very sensitive operation and great care needs
@@ -545,7 +574,7 @@ extern int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr);
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 /**
  * ftrace_modify_call - convert from one addr to another (no nop)
- * @rec: the mcount call site record
+ * @rec: the call site record (e.g. mcount/fentry)
  * @old_addr: the address expected to be currently called to
  * @addr: the address to change to
  *
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f296d89be757..5259d4dea675 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2494,14 +2494,14 @@ struct dyn_ftrace *ftrace_rec_iter_record(struct ftrace_rec_iter *iter)
 }
 
 static int
-ftrace_code_disable(struct module *mod, struct dyn_ftrace *rec)
+ftrace_nop_initialize(struct module *mod, struct dyn_ftrace *rec)
 {
 	int ret;
 
 	if (unlikely(ftrace_disabled))
 		return 0;
 
-	ret = ftrace_make_nop(mod, rec, MCOUNT_ADDR);
+	ret = ftrace_init_nop(mod, rec);
 	if (ret) {
 		ftrace_bug_type = FTRACE_BUG_INIT;
 		ftrace_bug(ret, rec);
@@ -2943,7 +2943,7 @@ static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
 			 * to the NOP instructions.
 			 */
 			if (!__is_defined(CC_USING_NOP_MCOUNT) &&
-			    !ftrace_code_disable(mod, p))
+			    !ftrace_nop_initialize(mod, p))
 				break;
 
 			update_cnt++;
-- 
2.11.0

