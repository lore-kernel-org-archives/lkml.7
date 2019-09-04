Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD100C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9320222CF5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbfIDMDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 08:03:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45246 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbfIDMDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:03:43 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0A743878E42;
        Wed,  4 Sep 2019 12:03:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.63])
        by smtp.corp.redhat.com (Postfix) with SMTP id 80A9019D70;
        Wed,  4 Sep 2019 12:03:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  4 Sep 2019 14:03:41 +0200 (CEST)
Date:   Wed, 4 Sep 2019 14:03:37 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        paulmck <paulmck@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Chris Lameter <cl@linux.com>, Kirill Tkhai <tkhai@yandex.ru>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH 1/2] Fix: sched/membarrier: p->mm->membarrier_state
 racy load
Message-ID: <20190904120336.GC24568@redhat.com>
References: <20190903201135.1494-1-mathieu.desnoyers@efficios.com>
 <20190903202434.GX2349@hirez.programming.kicks-ass.net>
 <1029906102.725.1567543307658.JavaMail.zimbra@efficios.com>
 <20190904112819.GD2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904112819.GD2349@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Wed, 04 Sep 2019 12:03:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04, Peter Zijlstra wrote:
>
> +		struct task_struct *g, *t;
> +
> +		read_lock(&tasklist_lock);
> +		do_each_thread(g, t) {

for_each_process_thread() looks better

> +			if (t->mm == mm) {
> +				atomic_or(MEMBARRIER_STATE_GLOBAL_EXPEDITED,
> +					  &t->membarrier_state);
> +			}

then you also need to change dup_task_struct(), it should clear
->membarrier_state unless CLONE_VM.

And probably unuse_mm() should clear current->membarrier_state too.

Hmm. And it can race with copy_process() anyway, tasklist_lock can't
really help. So copy_process() needs to do

	write_lock_irq(&tasklist_lock);
	...

	if (clone_flags & CLONE_VM)
		p->membarrier_state = current->membarrier_state;
	else
		p->membarrier_state = 0;

Oleg.

