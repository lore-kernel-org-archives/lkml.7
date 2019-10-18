Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60045CA9EA3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E0E222C9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rrG58SLf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504961AbfJRHwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 03:52:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42940 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504748AbfJRHv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 03:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AnrAvBi79y4TItSeXuQcpTaE9C1hPCQEL0V9rsZVf4w=; b=rrG58SLfMRbbHWqLd8oOKuK6Me
        1qdN5KGaano3RfiEWEK/E6VOum+kaL5Tupbh1BwC8v+yTM9R0zkroz6KFOXU5I+SIDpPXdeTkYqPr
        CYq/WUIt3bTErfGatQC2FBtVxHbqOizUrLeeDzfkquerfR9Bz2SR04bO+mdDp7+GhBID/ZBjtx+z3
        hTqOTAI8zrZga0dscqQFJ42RYktw1TVN7DjGyUJTvwZm83c7LLwPHcgE/HGGCMMYBkSvTDDO5wqAz
        56XFOLbUPxv7w1r0+fE75YQr2i9FOU8Zr6VsAwzO9h7reTA0iSCSkY51u1BCWlsDAArOdlvbE3I8l
        V9/butEQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLN2h-0001Sc-6H; Fri, 18 Oct 2019 07:51:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 29AC3301245;
        Fri, 18 Oct 2019 09:50:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7126D2B17811C; Fri, 18 Oct 2019 09:51:15 +0200 (CEST)
Message-Id: <20191018074634.858645375@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 18 Oct 2019 09:35:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, jeyu@kernel.org
Subject: [PATCH v4 16/16] ftrace: Merge ftrace_module_{init,enable}()
References: <20191018073525.768931536@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because of how some architectures used set_all_modules_text_*() there
was a dependency between the module state and its memory protection
state. This then required ftrace to be split into two functions, see
commit:

  a949ae560a51 ("ftrace/module: Hardcode ftrace_module_init() call into load_module()")

Now that set_all_modules_text_*() is dead and burried, this is no
longer relevant and we can merge the ftrace_module hooks again.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/ftrace.h |    2 
 kernel/module.c        |    3 -
 kernel/trace/ftrace.c  |  124 +++++++++++++++++++------------------------------
 3 files changed, 49 insertions(+), 80 deletions(-)

--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -579,7 +579,6 @@ static inline int ftrace_modify_call(str
 extern int ftrace_arch_read_dyn_info(char *buf, int size);
 
 extern int skip_trace(unsigned long ip);
-extern void ftrace_module_init(struct module *mod);
 extern void ftrace_module_enable(struct module *mod);
 extern void ftrace_release_mod(struct module *mod);
 
@@ -590,7 +589,6 @@ static inline int skip_trace(unsigned lo
 static inline int ftrace_force_update(void) { return 0; }
 static inline void ftrace_disable_daemon(void) { }
 static inline void ftrace_enable_daemon(void) { }
-static inline void ftrace_module_init(struct module *mod) { }
 static inline void ftrace_module_enable(struct module *mod) { }
 static inline void ftrace_release_mod(struct module *mod) { }
 static inline int ftrace_text_reserved(const void *start, const void *end)
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3836,9 +3836,6 @@ static int load_module(struct load_info
 
 	dynamic_debug_setup(mod, info->debug, info->num_debug);
 
-	/* Ftrace init must be called in the MODULE_STATE_UNFORMED state */
-	ftrace_module_init(mod);
-
 	/* Finally it's fully formed, ready to start executing. */
 	err = complete_formation(mod, info);
 	if (err)
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5564,6 +5564,8 @@ static int ftrace_cmp_ips(const void *a,
 	return 0;
 }
 
+static int referenced_filters(struct dyn_ftrace *rec);
+
 static int ftrace_process_locs(struct module *mod,
 			       unsigned long *start,
 			       unsigned long *end)
@@ -5656,6 +5658,49 @@ static int ftrace_process_locs(struct mo
 	ftrace_update_code(mod, start_pg);
 	if (!mod)
 		local_irq_restore(flags);
+
+#ifdef CONFIG_MODULES
+	if (ftrace_disabled || !mod)
+		goto out_loop;
+
+	do_for_each_ftrace_rec(pg, rec) {
+		int cnt;
+		/*
+		 * do_for_each_ftrace_rec() is a double loop.
+		 * module text shares the pg. If a record is
+		 * not part of this module, then skip this pg,
+		 * which the "break" will do.
+		 */
+		if (!within_module_core(rec->ip, mod) &&
+		    !within_module_init(rec->ip, mod))
+			break;
+
+		cnt = 0;
+
+		/*
+		 * When adding a module, we need to check if tracers are
+		 * currently enabled and if they are, and can trace this record,
+		 * we need to enable the module functions as well as update the
+		 * reference counts for those function records.
+		 */
+		if (ftrace_start_up)
+			cnt += referenced_filters(rec);
+
+		/* This clears FTRACE_FL_DISABLED */
+		rec->flags = cnt;
+
+		if (ftrace_start_up && cnt) {
+			int failed = __ftrace_replace_code(rec, 1);
+			if (failed) {
+				ftrace_bug(failed, rec);
+				goto out_loop;
+			}
+		}
+
+	} while_for_each_ftrace_rec();
+
+ out_loop:
+#endif
 	ret = 0;
  out:
 	mutex_unlock(&ftrace_lock);
@@ -5823,85 +5868,14 @@ void ftrace_release_mod(struct module *m
 
 void ftrace_module_enable(struct module *mod)
 {
-	struct dyn_ftrace *rec;
-	struct ftrace_page *pg;
-
-	mutex_lock(&ftrace_lock);
-
-	if (ftrace_disabled)
-		goto out_unlock;
-
-	/*
-	 * If the tracing is enabled, go ahead and enable the record.
-	 *
-	 * The reason not to enable the record immediately is the
-	 * inherent check of ftrace_make_nop/ftrace_make_call for
-	 * correct previous instructions.  Making first the NOP
-	 * conversion puts the module to the correct state, thus
-	 * passing the ftrace_make_call check.
-	 *
-	 * We also delay this to after the module code already set the
-	 * text to read-only, as we now need to set it back to read-write
-	 * so that we can modify the text.
-	 */
-	if (ftrace_start_up)
-		ftrace_arch_code_modify_prepare();
-
-	do_for_each_ftrace_rec(pg, rec) {
-		int cnt;
-		/*
-		 * do_for_each_ftrace_rec() is a double loop.
-		 * module text shares the pg. If a record is
-		 * not part of this module, then skip this pg,
-		 * which the "break" will do.
-		 */
-		if (!within_module_core(rec->ip, mod) &&
-		    !within_module_init(rec->ip, mod))
-			break;
-
-		cnt = 0;
-
-		/*
-		 * When adding a module, we need to check if tracers are
-		 * currently enabled and if they are, and can trace this record,
-		 * we need to enable the module functions as well as update the
-		 * reference counts for those function records.
-		 */
-		if (ftrace_start_up)
-			cnt += referenced_filters(rec);
-
-		/* This clears FTRACE_FL_DISABLED */
-		rec->flags = cnt;
-
-		if (ftrace_start_up && cnt) {
-			int failed = __ftrace_replace_code(rec, 1);
-			if (failed) {
-				ftrace_bug(failed, rec);
-				goto out_loop;
-			}
-		}
-
-	} while_for_each_ftrace_rec();
-
- out_loop:
-	if (ftrace_start_up)
-		ftrace_arch_code_modify_post_process();
-
- out_unlock:
-	mutex_unlock(&ftrace_lock);
+	if (!(ftrace_disabled || !mod->num_ftrace_callsites)) {
+		ftrace_process_locs(mod, mod->ftrace_callsites,
+				    mod->ftrace_callsites + mod->num_ftrace_callsites);
+	}
 
 	process_cached_mods(mod->name);
 }
 
-void ftrace_module_init(struct module *mod)
-{
-	if (ftrace_disabled || !mod->num_ftrace_callsites)
-		return;
-
-	ftrace_process_locs(mod, mod->ftrace_callsites,
-			    mod->ftrace_callsites + mod->num_ftrace_callsites);
-}
-
 static void save_ftrace_mod_rec(struct ftrace_mod_map *mod_map,
 				struct dyn_ftrace *rec)
 {


