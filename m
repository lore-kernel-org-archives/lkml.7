Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1E2C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76CD20828
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfF1PoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 11:44:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbfF1PoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:44:15 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61BDE214DA;
        Fri, 28 Jun 2019 15:44:13 +0000 (UTC)
Date:   Fri, 28 Jun 2019 11:44:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Scott Wood <swood@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Message-ID: <20190628114411.5d9ab351@gandalf.local.home>
In-Reply-To: <20190628104045.GA8394@X58A-UD3R>
References: <20190627103455.01014276@gandalf.local.home>
        <20190627153031.GA249127@google.com>
        <20190627155506.GU26519@linux.ibm.com>
        <CAEXW_YSEN_OL3ftTLN=M-W70WSuCgHJqU-R9VhS=A3uVj_AL+A@mail.gmail.com>
        <20190627173831.GW26519@linux.ibm.com>
        <20190627181638.GA209455@google.com>
        <20190627184107.GA26519@linux.ibm.com>
        <13761fee4b71cc004ad0d6709875ce917ff28fce.camel@redhat.com>
        <20190627203612.GD26519@linux.ibm.com>
        <20190628073138.GB13650@X58A-UD3R>
        <20190628104045.GA8394@X58A-UD3R>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jun 2019 19:40:45 +0900
Byungchul Park <byungchul.park@lge.com> wrote:

> Wait.. I got a little bit confused on recordering.
> 
> This 'STORE rcu_read_lock_nesting = 0' can happen before
> 'STORE rcu_read_unlock_special.b.exp_hint = false' regardless of the
> order a compiler generated to by the barrier(), because anyway they
> are independent so it's within an arch's right.
> 
> Then.. is this scenario possible? Or all archs properly deal with
> interrupts across this kind of reordering?

As Paul stated, interrupts are synchronization points. Archs can only
play games with ordering when dealing with entities outside the CPU
(devices and other CPUs). But if you have assembly that has two stores,
and an interrupt comes in, the arch must guarantee that the stores are
done in that order as the interrupt sees it.

If this is not the case, there's a hell of a lot more broken in the
kernel than just this, and "barrier()" would also be meaningless, as
that is used mostly to deal with interrupts.

-- Steve
