Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16899C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7AD21783
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IzxWzCwH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfKKOrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:47:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48682 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfKKOrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oCNRFDxevZECSVcGoUUcvgGC2/nu5iH17pcPCmTn75g=; b=IzxWzCwHMY+h2YaetyIUG1aVzY
        JA6QJADL98llxMJSTPaEfUnKk0U4SWATbcasHbrEVuEiyf+m+dISxJc+2PYgcDyIJCYmrJ4sT/VHt
        9cyxTrEJUJNYCJcXwCezIcf3Er5HnQdK38C/5wr8DNQxe0JGQfdYEcPemJOgjNT9LuK0dYpdmMw9T
        Xl78H+e6+01k/I02Assw4vj84XWul6MbtfJ9MTMNKmnaKgpBYlUVoxpIjRmYyW/5zPegsPV9L6cO9
        e1M21WJUf/7VYJzBFpr09PhhOFlT1trQNqlH7gkcvhXiIiO11gAU10+YwOLvWzGyMaf5JlScGY/Ox
        KBgvAixA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUAyB-0006a2-J3; Mon, 11 Nov 2019 14:47:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 08945307092;
        Mon, 11 Nov 2019 15:45:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A58F429A37A90; Mon, 11 Nov 2019 15:47:03 +0100 (CET)
Message-Id: <20191111132458.284298307@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 11 Nov 2019 14:13:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, jeyu@kernel.org, alexei.starovoitov@gmail.com,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Subject: [PATCH -v5 14/17] module: Remove set_all_modules_text_*()
References: <20191111131252.921588318@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there are no users of set_all_modules_text_*() left, remove
it.

While it appears nds32 uses it, it does not have STRICT_MODULE_RWX and
therefore ends up with the NOP stubs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
---
 arch/nds32/kernel/ftrace.c |   12 ------------
 include/linux/module.h     |    4 ----
 kernel/module.c            |   43 -------------------------------------------
 3 files changed, 59 deletions(-)

--- a/arch/nds32/kernel/ftrace.c
+++ b/arch/nds32/kernel/ftrace.c
@@ -89,18 +89,6 @@ int __init ftrace_dyn_arch_init(void)
 	return 0;
 }
 
-int ftrace_arch_code_modify_prepare(void)
-{
-	set_all_modules_text_rw();
-	return 0;
-}
-
-int ftrace_arch_code_modify_post_process(void)
-{
-	set_all_modules_text_ro();
-	return 0;
-}
-
 static unsigned long gen_sethi_insn(unsigned long addr)
 {
 	unsigned long opcode = 0x46000000;
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -846,13 +846,9 @@ extern int module_sysfs_initialized;
 #define __MODULE_STRING(x) __stringify(x)
 
 #ifdef CONFIG_STRICT_MODULE_RWX
-extern void set_all_modules_text_rw(void);
-extern void set_all_modules_text_ro(void);
 extern void module_enable_ro(const struct module *mod, bool after_init);
 extern void module_disable_ro(const struct module *mod);
 #else
-static inline void set_all_modules_text_rw(void) { }
-static inline void set_all_modules_text_ro(void) { }
 static inline void module_enable_ro(const struct module *mod, bool after_init) { }
 static inline void module_disable_ro(const struct module *mod) { }
 #endif
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2029,49 +2029,6 @@ static void module_enable_nx(const struc
 	frob_writable_data(&mod->init_layout, set_memory_nx);
 }
 
-/* Iterate through all modules and set each module's text as RW */
-void set_all_modules_text_rw(void)
-{
-	struct module *mod;
-
-	if (!rodata_enabled)
-		return;
-
-	mutex_lock(&module_mutex);
-	list_for_each_entry_rcu(mod, &modules, list) {
-		if (mod->state == MODULE_STATE_UNFORMED)
-			continue;
-
-		frob_text(&mod->core_layout, set_memory_rw);
-		frob_text(&mod->init_layout, set_memory_rw);
-	}
-	mutex_unlock(&module_mutex);
-}
-
-/* Iterate through all modules and set each module's text as RO */
-void set_all_modules_text_ro(void)
-{
-	struct module *mod;
-
-	if (!rodata_enabled)
-		return;
-
-	mutex_lock(&module_mutex);
-	list_for_each_entry_rcu(mod, &modules, list) {
-		/*
-		 * Ignore going modules since it's possible that ro
-		 * protection has already been disabled, otherwise we'll
-		 * run into protection faults at module deallocation.
-		 */
-		if (mod->state == MODULE_STATE_UNFORMED ||
-			mod->state == MODULE_STATE_GOING)
-			continue;
-
-		frob_text(&mod->core_layout, set_memory_ro);
-		frob_text(&mod->init_layout, set_memory_ro);
-	}
-	mutex_unlock(&module_mutex);
-}
 #else /* !CONFIG_STRICT_MODULE_RWX */
 static void module_enable_nx(const struct module *mod) { }
 #endif /*  CONFIG_STRICT_MODULE_RWX */


