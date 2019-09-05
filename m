Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A674CC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D5020820
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388676AbfIEO5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 10:57:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43173 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfIEO5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 10:57:14 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i5tCB-00038e-IJ; Thu, 05 Sep 2019 16:57:11 +0200
Date:   Thu, 5 Sep 2019 16:57:10 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 0/6] posix-cpu-timers: Fallout fixes and permission
 tightening
In-Reply-To: <20190905144829.GA18251@lenoir>
Message-ID: <alpine.DEB.2.21.1909051650030.1902@nanos.tec.linutronix.de>
References: <20190905120339.561100423@linutronix.de> <20190905144829.GA18251@lenoir>
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

On Thu, 5 Sep 2019, Frederic Weisbecker wrote:
> On Thu, Sep 05, 2019 at 02:03:39PM +0200, Thomas Gleixner wrote:
> > Sysbot triggered an issue in the posix timer rework which was trivial to
> > fix, but after running another test case I discovered that the rework broke
> > the permission checks subtly. That's also a straightforward fix.
> > 
> > Though when staring at it I discovered that the permission checks for
> > process clocks and process timers are completely bonkers. The only
> > requirement is that the target PID is a group leader. Which means that any
> > process can read the clocks and attach timers to any other process without
> > priviledge restrictions.
> > 
> > That's just wrong because the clocks and timers can be used to observe
> > behaviour and both reading the clocks and arming timers adds overhead and
> > influences runtime performance of the target process.
> 
> Yeah I stumbled upon that by the past and found out the explanation behind
> in old history: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/kernel/posix-cpu-timers.c?id=a78331f2168ef1e67b53a0f8218c70a19f0b2a4c
> 
> "This makes no constraint on who can see whose per-process clocks.  This
> information is already available for the VIRT and PROF (i.e.  utime and stime)
> information via /proc.  I am open to suggestions on if/how security
> constraints on who can see whose clocks should be imposed."
> 
> I'm all for mitigating that, let's just hope that won't break some ABIs.

Well, reading clocks is one part of the issue. Arming timers on any process
is a different story.

Also /proc/$PID access can be restricted nowadays. So that posic clock
stuff should at least have exactly the same restrictions.

Thanks,

	tglx

