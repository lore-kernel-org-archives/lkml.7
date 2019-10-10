Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4ABFC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 12:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06DB208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 12:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s+ewWJ1a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733139AbfJJM3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 08:29:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55404 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbfJJM3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 08:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cyGuSzlLK8Ww0fG0pIigUmbAo7iv2JCMlIrCcI1UaGw=; b=s+ewWJ1aI+0TvhFWpyoUsiS8j
        BQ3MdBlHPwvCQPSMpBcX75ijEm1UAiMKA0sclLRnU/HBpyrhRzW7XfExwcxzXdAuxz+rqlUkyzk4K
        Q6iypNrLimKvAn6+moYHZI7vs7kOh3pPZRfZNYcoWLfirOOnO1+YNu+JwRlzaKWMys+K4C6MiHVVf
        kZ+LGZfoMZTVawVqs+r3yb8JIE50VcGoPmPQCCOetVeVgNw9edAp0eheyOkiYDCx9FaPN8UmlV2Vr
        2363XWsvvHe/0Bo2KY71OQ2RmF2VB+TdmzKceHvnOPVtGeW4D5TJoUYSw2kTkBH+mIAQrLEV+ItC4
        YAKIR6ZGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIXZ9-00069s-8n; Thu, 10 Oct 2019 12:29:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 461BB301224;
        Thu, 10 Oct 2019 14:28:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4D96C202F4F4F; Thu, 10 Oct 2019 14:29:09 +0200 (CEST)
Date:   Thu, 10 Oct 2019 14:29:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] ftrace/module: Allow ftrace to make only loaded module
 text read-write
Message-ID: <20191010122909.GK2359@hirez.programming.kicks-ass.net>
References: <20191009223638.60b78727@oasis.local.home>
 <20191010073121.GN2311@hirez.programming.kicks-ass.net>
 <20191010093329.GI2359@hirez.programming.kicks-ass.net>
 <20191010093650.GJ2359@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010093650.GJ2359@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 11:36:50AM +0200, Peter Zijlstra wrote:
> On Thu, Oct 10, 2019 at 11:33:29AM +0200, Peter Zijlstra wrote:

> > I don't see any reason what so ever..
> > 
> > load_module()
> >   ...
> >   complete_formation()
> >     mutex_lock(&module_mutex);
> >     ...
> >     module_enable_ro();
> >     module_enable_nx();
> >     module_enable_x();
> > 
> >     mod->state = MODULE_STATE_COMING;
> >     mutex_unlock(&module_mutex);
> > 
> >   prepare_coming_module()
> >     ftrace_module_enable();
> >     ...
> > 
> > IOW, we're doing ftrace_module_enable() immediately after we flip it
> > RO+X. There is nothing in between that we can possibly rely on.
> > 
> > I was going to put:
> > 
> >   blocking_notifier_call_chain(&module_notify_list,
> > 			       MODULE_STATE_UNFORMED, mod);
> > 
> > right before module_enable_ro(), in complete_formation(), for jump_label
> > and static_call. It looks like ftrace (and possibly klp) want that too.
> 
> Also, you already have ftrace_module_init() right before that. The only
> thing inbetween ftrace_module_init() and ftrace_module_enable() is
> verify_exported_symbols() and module_bug_finalize().
> 
> Do you really need that for patching stuff?

If you rework the locking slightly, such that you have to call
ftrace_process_locs() with ftrace_lock already held, then it looks like
you can squash ftrace_module_enable() right in there.

There is absolutely no fundamental reason you cannot patch it from
ftrace_module_init().

Yes, your code is anal about checking the NOPs, so you first have to
write NOPs before you can write CALLs, if it is enabled. But afaict you
really can do all that from ftrace_module_init(), as long as you do it
all under the same ftrace_lock section.

If you have two sections, like now, then there is indeed that race that
ftrace can get enabled in between, and all the confusion that that
brings.

That is, what's fundamentally buggered about something like this?

---
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 62a50bf399d6..5f7113f100ce 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5626,6 +5626,48 @@ static int ftrace_process_locs(struct module *mod,
 	ftrace_update_code(mod, start_pg);
 	if (!mod)
 		local_irq_restore(flags);
+
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
+
 	ret = 0;
  out:
 	mutex_unlock(&ftrace_lock);
@@ -5793,73 +5835,6 @@ void ftrace_release_mod(struct module *mod)
 
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
-
 	process_cached_mods(mod->name);
 }
 
