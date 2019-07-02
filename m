Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE07CC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94068206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfGBQRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 12:17:14 -0400
Received: from foss.arm.com ([217.140.110.172]:52906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbfGBQRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 12:17:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D41228;
        Tue,  2 Jul 2019 09:17:13 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF22E3F246;
        Tue,  2 Jul 2019 09:17:12 -0700 (PDT)
Date:   Tue, 2 Jul 2019 17:17:10 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] stacktrace: Use PF_KTHREAD to check for kernel threads
Message-ID: <20190702161710.GB34718@lakrids.cambridge.arm.com>
References: <alpine.DEB.2.21.1907021750100.1802@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907021750100.1802@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 05:53:35PM +0200, Thomas Gleixner wrote:
> !current->mm is not a reliable indicator for kernel threads as they might
> temporarily use a user mm. Check for PF_KTHREAD instead.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

As a heads-up, I started looking into cleaning up bogus mm checks
tree-wide, since there are a number that look suspicious (e.g. arm64's
arch_dup_task_struct() and x86's __kernel_fpu_begin()).

I was hoping to add an is_kthread(tsk) helper to push people in the
right direction [1].

Thanks,
Mark.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=sched/kthread-cleanup

> ---
> --- a/kernel/stacktrace.c
> +++ b/kernel/stacktrace.c
> @@ -228,7 +228,7 @@ unsigned int stack_trace_save_user(unsig
>  	};
>  
>  	/* Trace user stack if not a kernel thread */
> -	if (!current->mm)
> +	if (current->flags & PF_KTHREAD)
>  		return 0;
>  
>  	arch_stack_walk_user(consume_entry, &c, task_pt_regs(current));
