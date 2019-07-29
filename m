Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A28BC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7412087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfG2J6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 05:58:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53103 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfG2J6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 05:58:37 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hs2QD-0006V0-KF; Mon, 29 Jul 2019 11:58:25 +0200
Date:   Mon, 29 Jul 2019 11:58:24 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Guenter Roeck <linux@roeck-us.net>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>
Subject: Re: sched: Unexpected reschedule of offline CPU#2!
In-Reply-To: <20190729093545.GV31381@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1907291156170.1791@nanos.tec.linutronix.de>
References: <20190727164450.GA11726@roeck-us.net> <20190729093545.GV31381@hirez.programming.kicks-ass.net>
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

On Mon, 29 Jul 2019, Peter Zijlstra wrote:
> On Sat, Jul 27, 2019 at 09:44:50AM -0700, Guenter Roeck wrote:
> > [   61.348866] Call Trace:
> > [   61.349392]  kick_ilb+0x90/0xa0
> > [   61.349629]  trigger_load_balance+0xf0/0x5c0
> > [   61.349859]  ? check_preempt_wakeup+0x1b0/0x1b0
> > [   61.350057]  scheduler_tick+0xa7/0xd0
> 
> kick_ilb() iterates nohz.idle_cpus_mask to find itself an idle_cpu().
> 
> idle_cpus_mask() is set from nohz_balance_enter_idle() and cleared from
> nohz_balance_exit_idle(). nohz_balance_enter_idle() is called from
> __tick_nohz_idle_stop_tick() when entering nohz idle, this includes the
> cpu_is_offline() clause of the idle loop.
> 
> However, when offline, cpu_active() should also be false, and this
> function should no-op.

Ha. That reboot mess is not clearing cpu active as it's not going through
the regular cpu hotplug path. It's using reboot IPI which 'stops' the cpus
dead in their tracks after clearing cpu online....

Thanks,

	tglx
