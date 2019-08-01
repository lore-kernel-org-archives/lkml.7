Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1966FC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44D92171F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbfHAPjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 11:39:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbfHAPjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:39:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 426F9A9D99;
        Thu,  1 Aug 2019 15:39:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 71F1C60471;
        Thu,  1 Aug 2019 15:39:37 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  1 Aug 2019 17:39:42 +0200 (CEST)
Date:   Thu, 1 Aug 2019 17:39:36 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, kvm@vger.kernel.org,
        Radim Krcmar <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [patch 4/5] posix-cpu-timers: Defer timer handling to task_work
Message-ID: <20190801153936.GD31538@redhat.com>
References: <20190801143250.370326052@linutronix.de>
 <20190801143658.074833024@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801143658.074833024@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 01 Aug 2019 15:39:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01, Thomas Gleixner wrote:
>
> +static void __run_posix_cpu_timers(struct task_struct *tsk)
> +{
> +	/* FIXME: Init it proper in fork or such */
> +	init_task_work(&tsk->cpu_timer_work, posix_cpu_timers_work);
> +	task_work_add(tsk, &tsk->cpu_timer_work, true);
> +}

What if update_process_times/run_posix_cpu_timers is called again before
this task does task_work_run() ?

somehow it should check that ->cpu_timer_work is not already queued...

Or suppose that this is called when task_work_run() executes this
cpu_timer_work. Looks like you need another flag checked by
__run_posix_cpu_timers() and cleare in posix_cpu_timers_work() ?

Oleg.

