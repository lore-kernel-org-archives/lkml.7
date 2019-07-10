Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5154CC74A36
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 19:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231AE2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 19:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbfGJTNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 15:13:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727612AbfGJTNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 15:13:38 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2428420651;
        Wed, 10 Jul 2019 19:13:37 +0000 (UTC)
Date:   Wed, 10 Jul 2019 15:13:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sodagudi Prasad <psodagud@codeaurora.org>,
        gregkh@linuxfoundation.org, john.stultz@linaro.org,
        chang-an.chen@mediatek.com, mingo@kernel.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org
Subject: Re: sched_clock and device suspend/resume
Message-ID: <20190710151334.49158be3@gandalf.local.home>
In-Reply-To: <alpine.DEB.2.21.1907102104490.1758@nanos.tec.linutronix.de>
References: <1d6ef4687c87dd4d2ec88d0d593a9c1d@codeaurora.org>
        <20190710113609.7b63c5d6@gandalf.local.home>
        <alpine.DEB.2.21.1907102034190.1758@nanos.tec.linutronix.de>
        <20190710145744.7279b355@gandalf.local.home>
        <alpine.DEB.2.21.1907102104490.1758@nanos.tec.linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ Removed the two emails that were bouncing ]

On Wed, 10 Jul 2019 21:06:57 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> > > > sched_clock_continuous() ? (I know, horrible name), that simply keeps
> > > > track of the time delta at suspend and returns:
> > > > 
> > > > 	sched_clock() + delta;    
> > > 
> > > Which you get already when you do
> > > 
> > > # echo boot > /sys/kernel/debug/tracing/trace_clock
> > >   
> > 
> > So basically the answer here is to change printk to use
> > ktime_get_boot_fast_ns() instead of local_clock()?  
> 
> Aargh. That was tracing.
> 
> There was a patchset floating around which actually implemented that clock
> choice for sched_clock as well. Don't know why that was never merged.

Will it cause issues with the scheduler though. If it doesn't stop
during suspend, can't that make the scheduler think that processes were
using the CPU during the entire suspend and screw up the accounting?

-- Steve
