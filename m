Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F245C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5978622DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566402690;
	bh=goM8/MfDDt7plG+VlIxG+HH8lndGGP/l2/1zTb4jU7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LCIbMZ5YY8CdvE3Aj9zLObOrMHAYZE1owsMn0u+ShgVDwt1UPLZH+B8A+fQfFWTJJ
	 s4SlhuwH4f3u3D3qcWIyWmqr0Rnmqq8fGPBtKgIzlzR/0Hr9U41TjofrnGsofiX2n7
	 5ZX6HUNPyiREaZomMLDc6t6osgd2h7w7ZOtmFpUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbfHUPv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 11:51:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbfHUPv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 11:51:28 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E9CF22DD3;
        Wed, 21 Aug 2019 15:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566402687;
        bh=goM8/MfDDt7plG+VlIxG+HH8lndGGP/l2/1zTb4jU7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X8pSkhINd9uFeYoIS5Vie2INPFPgj5Bk0zN9YCgvDXVihwJCNhG1x76CsydaQCRGy
         3wQ7VG6NgUvmmcyxv83FN27K3SssyddE6ISO6mhJUtq1nKk6ZFqccJlfEE/5YzCT/d
         Rufel1BOQxBHVrh0Y5pkztZj2X+WwJzHhHrxOhgM=
Date:   Wed, 21 Aug 2019 17:51:25 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [patch 04/44] posix-cpu-timers: Fixup stale comment
Message-ID: <20190821155125.GB22020@lenoir>
References: <20190819143141.221906747@linutronix.de>
 <20190819143801.747233612@linutronix.de>
 <20190820142658.GG2093@lenoir>
 <alpine.DEB.2.21.1908201946320.2223@nanos.tec.linutronix.de>
 <20190820204803.GH2093@lenoir>
 <alpine.DEB.2.21.1908202331080.2223@nanos.tec.linutronix.de>
 <20190820225604.GI2093@lenoir>
 <alpine.DEB.2.21.1908211525150.2223@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908211525150.2223@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 03:31:39PM +0200, Thomas Gleixner wrote:
> On Wed, 21 Aug 2019, Frederic Weisbecker wrote:
> > So I propose to change the behaviour of case 1) so that $TARGET doesn't call
> > posix_cpu_timers_exit(). We instead wait for $OWNER to exit and call
> > exit_itimers()  -> timer_delete_hook($ITIMER) -> posix_cpu_timer_del($ITIMER).
> > It is going to find $TARGET as the target of $ITIMER but no more sighand. Then
> > finally it removes $ITIMER from $TARGET->cputime_expires.
> > We basically do the same thing as in 2) but without locking sighand since it's NULL
> > on $TARGET at this time.
> 
> But what do we win with that? Horrors like this:
> 
> task A		task B	   	task C
> 
>      		arm_timer(A)	arm_timer(A)
> 
> do_exit()
> 
> 		del_timer(A)	del_timer(A)
> 		no sighand	no_sighand
> 		 list_del()       list_del()
> 
> Guess how well concurrent list deletion works.
> 
> We must remove armed timers from the task/signal _before_ dropping sighand,
> really.

Ah right, there can be concurrent owners, nevermind.
