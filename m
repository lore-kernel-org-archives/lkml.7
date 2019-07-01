Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EF4C06511
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95B82133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbfGAKYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 06:24:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40098 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfGAKYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 06:24:51 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hhtUI-0002kx-SR; Mon, 01 Jul 2019 12:24:43 +0200
Date:   Mon, 1 Jul 2019 12:24:42 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Scott Wood <swood@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Message-ID: <20190701102442.35grdpcsbrwyyaco@linutronix.de>
References: <20190627173831.GW26519@linux.ibm.com>
 <20190627181638.GA209455@google.com>
 <20190627184107.GA26519@linux.ibm.com>
 <13761fee4b71cc004ad0d6709875ce917ff28fce.camel@redhat.com>
 <20190627203612.GD26519@linux.ibm.com>
 <20190628141522.GF3402@hirez.programming.kicks-ass.net>
 <20190628155404.GV26519@linux.ibm.com>
 <20190628160408.GH32547@worktop.programming.kicks-ass.net>
 <20190628172056.GW26519@linux.ibm.com>
 <20190701094215.GR3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190701094215.GR3402@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-01 11:42:15 [+0200], Peter Zijlstra wrote:
> I'm not sure if smp_send_reschedule() can be used as self-IPI, some
> hardware doesn't particularly like that IIRC. That is, hardware might
> only have interfaces to IPI _other_ CPUs, but not self.
> 
> The normal scheduler code takes care to not call smp_send_reschedule()
> to self.

and irq_work:
  471ba0e686cb1 ("irq_work: Do not raise an IPI when queueing work on the local CPU")

Sebastian
