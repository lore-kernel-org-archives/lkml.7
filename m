Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14243C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 09:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E159A2070D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 09:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfG1JGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 05:06:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:47070 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725880AbfG1JGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 05:06:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 85C1BAC0C;
        Sun, 28 Jul 2019 09:06:51 +0000 (UTC)
Subject: Re: [patch 11/12] hrtimer: Prepare support for PREEMPT_RT
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20190726183048.982726647@linutronix.de>
 <20190726185753.737767218@linutronix.de>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <42299f02-ff29-f7e3-45f0-b9fef041aec9@suse.com>
Date:   Sun, 28 Jul 2019 11:06:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190726185753.737767218@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.07.19 20:30, Thomas Gleixner wrote:
> From: Anna-Maria Gleixner <anna-maria@linutronix.de>
> 
> When PREEMPT_RT is enabled, the soft interrupt thread can be preempted.  If
> the soft interrupt thread is preempted in the middle of a timer callback,
> then calling hrtimer_cancel() can lead to two issues:
> 
>    - If the caller is on a remote CPU then it has to spin wait for the timer
>      handler to complete. This can result in unbound priority inversion.
> 
>    - If the caller originates from the task which preempted the timer
>      handler on the same CPU, then spin waiting for the timer handler to
>      complete is never going to end.
> 
> To avoid these issues, add a new lock to the timer base which is held
> around the execution of the timer callbacks. If hrtimer_cancel() detects
> that the timer callback is currently running, it blocks on the expiry
> lock. When the callback is finished, the expiry lock is dropped by the
> softirq thread which wakes up the waiter and the system makes progress.
> 
> This addresses both the priority inversion and the life lock issues.
> 
> The same issue can happen in virtual machines when the vCPU which runs a
> timer callback is scheduled out. If a second vCPU of the same guest calls
> hrtimer_cancel() it will spin wait for the other vCPU to be scheduled back
> in. The expiry lock mechanism would avoid that. It'd be trivial to enable
> this when paravirt spinlocks are enabled in a guest, but it's not clear
> whether this is an actual problem in the wild, so for now it's an RT only
> mechanism.

As in virtual machines the soft interrupt thread preemption should not
be an issue, I guess the spinning is "just" sub-optimal (similar to not
using paravirt spinlocks).

In case we'd want to change that I'd rather not special case timers, but
apply a more general solution to the quite large amount of similar
cases: I assume the majority of cpu_relax() uses are affected, so adding
a paravirt op cpu_relax() might be appropriate.

That could be put under CONFIG_PARAVIRT_SPINLOCK. If called in a guest
it could ask the hypervisor to give up the physical cpu voluntarily
(in Xen this would be a "yield" hypercall).


Juergen
