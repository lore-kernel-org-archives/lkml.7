Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5671CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0500204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389692AbfKDWRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:17:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39031 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389083AbfKDWRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:17:08 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iRkel-0008F2-Mq; Mon, 04 Nov 2019 23:17:03 +0100
Date:   Mon, 4 Nov 2019 23:17:02 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Scott Wood <swood@redhat.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] timers/nohz: Update nohz load even if tick already
 stopped
In-Reply-To: <813ed21938aa47b15f35f8834ffd98ad4dd27771.camel@redhat.com>
Message-ID: <alpine.DEB.2.21.1911042315390.17054@nanos.tec.linutronix.de>
References: <20191028150716.22890-1-frederic@kernel.org>  <20191029100506.GJ4114@hirez.programming.kicks-ass.net>  <52d963553deda810113accd8d69b6dffdb37144f.camel@redhat.com>  <20191030133130.GY4097@hirez.programming.kicks-ass.net>
 <813ed21938aa47b15f35f8834ffd98ad4dd27771.camel@redhat.com>
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

On Fri, 1 Nov 2019, Scott Wood wrote:
> On Wed, 2019-10-30 at 14:31 +0100, Peter Zijlstra wrote:
> > Oh argh! that's a bit radical of the remote tick. The normal tick runs
> > just fine on idle CPUs, so lets mirror that.
> > 
> > How's this then?

....
 
> 
> Needs to be tick_nohz_tick_stopped_cpu(cpu)
> 
> After fixing that, I get:
> 
> [    7.439068] WARNING: CPU: 20 PID: 7 at /home/root/linux/kernel/sched/core.c:3681 sched_tick_remote+0x132/0x150

So I'm going to apply Scotts patch if nobody comes up with a better idea
until tomorrow.

Thanks,

	tglx
