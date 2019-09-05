Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644BDC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 18:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A7F206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 18:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731995AbfIESz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 14:55:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44047 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729782AbfIESz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 14:55:26 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i5wuh-0007Un-Ji; Thu, 05 Sep 2019 20:55:23 +0200
Date:   Thu, 5 Sep 2019 20:55:22 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 2/6] posix-cpu-timers: Fix permission check regression
In-Reply-To: <20190905173148.GE18251@lenoir>
Message-ID: <alpine.DEB.2.21.1909052054200.1902@nanos.tec.linutronix.de>
References: <20190905120339.561100423@linutronix.de> <20190905120539.797994508@linutronix.de> <20190905173148.GE18251@lenoir>
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
> On Thu, Sep 05, 2019 at 02:03:41PM +0200, Thomas Gleixner wrote:
> > +	if (gettime) {
> > +		/*
> > +		 * For clock_gettime() the task does not need to be the
> > +		 * actual group leader. tsk->sighand gives access to the
> > +		 * group's clock.
> > +		 */
> 
> I'm a bit confused with the explanation. Why is it fine to do so with clock
> and not with timer? tsk->sighand gives access to the group's timer as
> well.

Timer stores the target task and that's the group leader for process wide
while clock read is just momentary. Lemme rephrase that.

Thanks,

	tglx
