Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B09BC74A36
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 19:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1FB20838
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 19:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbfGJTQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 15:16:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48461 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbfGJTQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 15:16:03 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hlI4D-00018t-VR; Wed, 10 Jul 2019 21:15:50 +0200
Date:   Wed, 10 Jul 2019 21:15:49 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
cc:     Sodagudi Prasad <psodagud@codeaurora.org>,
        gregkh@linuxfoundation.org, john.stultz@linaro.org,
        chang-an.chen@mediatek.com, mingo@kernel.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org
Subject: Re: sched_clock and device suspend/resume
In-Reply-To: <20190710151334.49158be3@gandalf.local.home>
Message-ID: <alpine.DEB.2.21.1907102114480.1758@nanos.tec.linutronix.de>
References: <1d6ef4687c87dd4d2ec88d0d593a9c1d@codeaurora.org> <20190710113609.7b63c5d6@gandalf.local.home> <alpine.DEB.2.21.1907102034190.1758@nanos.tec.linutronix.de> <20190710145744.7279b355@gandalf.local.home> <alpine.DEB.2.21.1907102104490.1758@nanos.tec.linutronix.de>
 <20190710151334.49158be3@gandalf.local.home>
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

On Wed, 10 Jul 2019, Steven Rostedt wrote:
> 
> [ Removed the two emails that were bouncing ]
> 
> On Wed, 10 Jul 2019 21:06:57 +0200 (CEST)
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > > > > sched_clock_continuous() ? (I know, horrible name), that simply keeps
> > > > > track of the time delta at suspend and returns:
> > > > > 
> > > > > 	sched_clock() + delta;    
> > > > 
> > > > Which you get already when you do
> > > > 
> > > > # echo boot > /sys/kernel/debug/tracing/trace_clock
> > > >   
> > > 
> > > So basically the answer here is to change printk to use
> > > ktime_get_boot_fast_ns() instead of local_clock()?  
> > 
> > Aargh. That was tracing.
> > 
> > There was a patchset floating around which actually implemented that clock
> > choice for sched_clock as well. Don't know why that was never merged.
> 
> Will it cause issues with the scheduler though. If it doesn't stop
> during suspend, can't that make the scheduler think that processes were
> using the CPU during the entire suspend and screw up the accounting?

Duh. My brain is not working.

Not sched_clock, the patches were for printk so you could select a printk
clock. Can't find them right now.

Thanks,

	tglx
