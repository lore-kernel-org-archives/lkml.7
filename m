Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB645C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5EE2089E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbfHUNZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 09:25:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55703 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbfHUNZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 09:25:04 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0Qbm-0004uX-AE; Wed, 21 Aug 2019 15:25:02 +0200
Date:   Wed, 21 Aug 2019 15:25:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [patch 07/44] posix-cpu-timers: Simplify sighand locking in
 run_posix_cpu_timers()
In-Reply-To: <20190821120912.GD16213@lenoir>
Message-ID: <alpine.DEB.2.21.1908211523580.2223@nanos.tec.linutronix.de>
References: <20190819143141.221906747@linutronix.de> <20190819143802.038794711@linutronix.de> <20190821120912.GD16213@lenoir>
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

On Wed, 21 Aug 2019, Frederic Weisbecker wrote:

> On Mon, Aug 19, 2019 at 04:31:48PM +0200, Thomas Gleixner wrote:
> > run_posix_cpu_timers() is called from the timer interrupt. The posix timer
> > expiry always affects the current task which got interrupted.
> > 
> > sighand locking is only racy when done on a foreign task, which must use
> > lock_task_sighand(). But in case of run_posix_cpu_timers() that's
> > pointless.
> > 
> > sighand of a task can only be dropped or changed by the task itself. Drop
> > happens in do_exit()
> 
> Well, that's only in case of autoreap. Otherwise this is dropped by the reaper.

Right, but in the reaper case the task cannot be on the CPU running and
being interrupted by the tick. I might be missing something subtle though.

Thanks,

	tglx
