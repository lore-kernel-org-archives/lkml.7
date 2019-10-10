Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D24C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 17:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42C62067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 17:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ghFet/M2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfJJRBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 13:01:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33390 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfJJRBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 13:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aaCNf5DPTtnvU+MCaAQMV2HAXaDI7hDnwEEid6nSG7Q=; b=ghFet/M20GTnBUrx3E0tuNKN+
        NlMX7n5wHzf2qCV7jUJ+RoPVbkslDs9JwV0xRuV9pwPwS7w2tLt48ohxDhUbpw7Npvel2KpG9ugG/
        3jHHtlOhhz3BEFuxBAIcZsHyrl1u/mXeulVRqK+OkAWSVi5OYjlqVB5A2q54yKIq4UL0uAePOiDiC
        pGS/1ctYOqo80G2ae+cw9Phc8poev9/QOTx3tTH9lPOQhq5SmE8emBjJVRRdXkh1Wj7to62R32QPi
        WV0gaMzbU5UTKEv2lfdi012aBo60XN+gVwU6hlLvL33H6gwYzmnB4f0YzKoQuovntjER8JZzWHX6U
        dJchBBQLA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIboQ-000298-ME; Thu, 10 Oct 2019 17:01:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ABAFF3008C1;
        Thu, 10 Oct 2019 19:00:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 03B2C220F94C3; Thu, 10 Oct 2019 19:01:11 +0200 (CEST)
Date:   Thu, 10 Oct 2019 19:01:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] ftrace/module: Allow ftrace to make only loaded module
 text read-write
Message-ID: <20191010170111.GQ2328@hirez.programming.kicks-ass.net>
References: <20191009223638.60b78727@oasis.local.home>
 <20191010073121.GN2311@hirez.programming.kicks-ass.net>
 <20191010093329.GI2359@hirez.programming.kicks-ass.net>
 <20191010093650.GJ2359@hirez.programming.kicks-ass.net>
 <20191010122909.GK2359@hirez.programming.kicks-ass.net>
 <20191010105515.5eba7f31@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010105515.5eba7f31@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 10:55:15AM -0400, Steven Rostedt wrote:

> OK, so basically this moves the enabling of function tracing from
> within the ftrace_module_enable() code without releasing the
> ftrace_lock mutex.
> 
> But we have an issue with the state of the module here, as it is still
> set as MODULE_STATE_UNFORMED. Let's look at what happens if we have:
> 
> 
> 	CPU0				CPU1
> 	----				----
>  echo function > current_tracer
> 				modprobe foo
> 				  enable foo functions to be traced
> 				  (foo function records not disabled)
>  echo nop > current_tracer
> 
>    disable all functions being
>    traced including foo functions
> 
>    arch calls set_all_modules_text_rw()
>     [skips UNFORMED modules, which foo still is ]
> 
> 				  set foo's text to read-only
> 				  foo's state to COMING
> 
>    tries to disable foo's functions
>    foo's text is read-only
> 
>    BUG trying to write to ro text!!!
> 
> 
> Like I said, this is very subtle. It may no longer be a bug on x86
> with your patches, but it will bug on ARM or anything else that still
> uses set_all_modules_text_rw() in the ftrace prepare code.

I can't immediately follow, but I think we really should go there.

For now, something like this might work:

--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -34,6 +34,8 @@
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
+static int ftrace_poke_late = 0;
+
 int ftrace_arch_code_modify_prepare(void)
     __acquires(&text_mutex)
 {
@@ -43,12 +45,15 @@ int ftrace_arch_code_modify_prepare(void
 	 * ftrace has it set to "read/write".
 	 */
 	mutex_lock(&text_mutex);
+	ftrace_poke_late = 1;
 	return 0;
 }
 
 int ftrace_arch_code_modify_post_process(void)
     __releases(&text_mutex)
 {
+	text_poke_finish();
+	ftrace_poke_late = 0;
 	mutex_unlock(&text_mutex);
 	return 0;
 }
@@ -116,7 +121,10 @@ ftrace_modify_code_direct(unsigned long
 		return ret;
 
 	/* replace the text with the new text */
-	text_poke_early((void *)ip, new_code, MCOUNT_INSN_SIZE);
+	if (ftrace_poke_late)
+		text_poke_queue((void *)ip, new_code, MCOUNT_INSN_SIZE, NULL);
+	else
+		text_poke_early((void *)ip, new_code, MCOUNT_INSN_SIZE);
 	return 0;
 }
 
