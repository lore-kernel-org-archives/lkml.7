Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A36C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C22020873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571155762;
	bh=lymXH+CPJkzOEgsYwzTlX/oqBJpN6j+gCshs086u74w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Dzc9nPSN7HmXglfkuzbsuKc16KAyYILOIXV66C80lwv4wYzO44aCqR6kpdPnhpgwR
	 HPmZLu4KkgWCYvktg3/TrD2XbqWxJVWrPu0cafUvW4nALtwRbmnkL8+iNXqHnHzAsR
	 YV3HdGQrarmMLRjMacVnffJRYvQK1q/gNlvWJzm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfJOQJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 12:09:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbfJOQJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 12:09:20 -0400
Received: from linux-8ccs (ip5f5adbbb.dynamic.kabel-deutschland.de [95.90.219.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C99720640;
        Tue, 15 Oct 2019 16:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571155759;
        bh=lymXH+CPJkzOEgsYwzTlX/oqBJpN6j+gCshs086u74w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=keT8Xy6ws5k0dTABCEb/07xm4QdknpNXD7BlPsuKOrr5mu1hvDUp+kNr0xR/HbDAV
         QXm9pJmMjmHPQOVe/NQe13Zw2/KClK+0q8wj/hWA7sTgTTbs+lQg+esvwuvWpj7UUG
         WAjTjWb+5Bi/Q9WAv/m2pFZPL94VohATMMdvYaqo=
Date:   Tue, 15 Oct 2019 18:09:13 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [PATCH v3 5/6] x86/ftrace: Use text_poke()
Message-ID: <20191015160912.GB21110@linux-8ccs>
References: <20191007081945.10951536.8@infradead.org>
 <20191008104335.6fcd78c9@gandalf.local.home>
 <20191009224135.2dcf7767@oasis.local.home>
 <20191010092054.GR2311@hirez.programming.kicks-ass.net>
 <20191010091956.48fbcf42@gandalf.local.home>
 <20191010140513.GT2311@hirez.programming.kicks-ass.net>
 <20191010115449.22044b53@gandalf.local.home>
 <20191010172819.GS2328@hirez.programming.kicks-ass.net>
 <20191011125903.GN2359@hirez.programming.kicks-ass.net>
 <20191015092802.5c9aea5e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191015092802.5c9aea5e@gandalf.local.home>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Steven Rostedt [15/10/19 09:28 -0400]:
>On Fri, 11 Oct 2019 14:59:03 +0200
>Peter Zijlstra <peterz@infradead.org> wrote:
>
>> On Thu, Oct 10, 2019 at 07:28:19PM +0200, Peter Zijlstra wrote:
>>
>> > Really the best solution is to move all the poking into
>> > ftrace_module_init(), before we mark it RO+X. That's what I'm going to
>> > do for jump_label and static_call as well, I just need to add that extra
>> > notifier callback.
>>
>> OK, so I started writing that patch... or rather, I wrote the patch and
>> started on the Changelog when I ran into trouble describing why we need
>> it.
>>
>> That is, I'm struggling to explain why we cannot flip
>> prepare_coming_module() and complete_formation().
>>
>> Yes, it breaks ftrace, but I'm thinking that is all it breaks. So let me
>> see if we can cure that.
>
>You are mainly worried about making text that is executable into
>read-write again. What if we kept my one patch that just changed the
>module in ftrace_module_enable() from read-only to read-write, but
>before we ever set it executable.
>
>Jessica, would this patch break anything?
>
>It moves the setting of the module execution to after calling both
>ftrace_module_enable() and klp_module_coming().
>
>This would make it possible to do the module code and still keep with
>the no executable code becoming writable.
>
>-- Steve
>
>diff --git a/kernel/module.c b/kernel/module.c
>index ff2d7359a418..6e2fd40a6ed9 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -3728,7 +3728,6 @@ static int complete_formation(struct module *mod, struct load_info *info)
>
> 	module_enable_ro(mod, false);
> 	module_enable_nx(mod);
>-	module_enable_x(mod);
>
> 	/* Mark state as coming so strong_try_module_get() ignores us,
> 	 * but kallsyms etc. can see us. */
>@@ -3751,6 +3750,11 @@ static int prepare_coming_module(struct module *mod)
> 	if (err)
> 		return err;
>
>+	/* Make module executable after ftrace is enabled */
>+	mutex_lock(&module_mutex);
>+	module_enable_x(mod);
>+	mutex_unlock(&module_mutex);
>+
> 	blocking_notifier_call_chain(&module_notify_list,
> 				     MODULE_STATE_COMING, mod);
> 	return 0;

As long as we enable x before parse_args(), which this patch does, then
I don't think this change would break anything.

