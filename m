Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4ECC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E3D2175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbfDEIMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 04:12:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47225 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfDEIMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 04:12:31 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCJxc-0004ol-9m; Fri, 05 Apr 2019 10:12:28 +0200
Date:   Fri, 5 Apr 2019 10:12:27 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: WARN_ON: userstacktrace on irq events
In-Reply-To: <20190403121640.70128095@gandalf.local.home>
Message-ID: <alpine.DEB.2.21.1904051000290.1802@nanos.tec.linutronix.de>
References: <20190403121640.70128095@gandalf.local.home>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2019, Steven Rostedt wrote:
> Juri reported this from the -rt kernel, but I can easily trigger it in
> mainline. By simply doing:
> 
>  # cd /sys/kernel/tracing
>  # echo 1 > options/userstacktrace
>  # echo 1 > events/irq/enable
> This is simply caused by the irq trace events doing a user stack trace:
> 
> ftrace_trace_userstack {
>   save_stack_trace_user {
>     __save_stack_trace_user {
>       copy_stack_frame {
>         access_ok {
> 	  WARN_ON_IN_IRQ()
> 
> BOOM! Warn on.
> 
> Can we make that access_ok() call in the copy_stack_frame not trigger
> the warning just if we are in an interrupt?

You really want to have access_ok_atomic() or such which does not have the
WARN and use that in copy_stack_frame(). That's fine here because the
actual copy is inside a pagefault disabled region.

Thanks,

	tglx
