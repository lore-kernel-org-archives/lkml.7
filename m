Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E0FC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1641206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfJJPD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 11:03:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfJJPD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 11:03:28 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9522B206A1;
        Thu, 10 Oct 2019 15:03:27 +0000 (UTC)
Date:   Thu, 10 Oct 2019 11:03:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] ftrace/module: Allow ftrace to make only loaded module
 text read-write
Message-ID: <20191010110326.75131dbf@gandalf.local.home>
In-Reply-To: <20191010105515.5eba7f31@gandalf.local.home>
References: <20191009223638.60b78727@oasis.local.home>
        <20191010073121.GN2311@hirez.programming.kicks-ass.net>
        <20191010093329.GI2359@hirez.programming.kicks-ass.net>
        <20191010093650.GJ2359@hirez.programming.kicks-ass.net>
        <20191010122909.GK2359@hirez.programming.kicks-ass.net>
        <20191010105515.5eba7f31@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 10:55:15 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

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

I guess I should have commented this, but the big reason for the split
between ftrace_module_init() and ftrace_module_enable() is that we add
the nops when the module is still UNFORMED, but we only enable it when
the module is COMING or beyond, and not UNFORMED.

-- Steve
