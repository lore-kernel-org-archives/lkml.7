Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08B3C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FEF2082C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567696923;
	bh=P0kHaS/yTCHWxD6jPVih6CP4uqK61KZjHX2lKyGh/ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=viG/Cl/XMoaaF9/rM9xbN0r9h8S2gMWkgo+QjdqjeSWSN2wd33a80ZDx+F8jQKdVU
	 siGN/F/G0eUlunzy0lPd4dvGVjgLmtYp5W4EVk/yg4PI11V6rdKD7w61EVxKCFP4jz
	 6EevkGtzmArcNcIT4K/7xl9O/wfG75yHeIpa0GLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390372AbfIEPWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 11:22:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388057AbfIEPWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:22:01 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88AC320820;
        Thu,  5 Sep 2019 15:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567696921;
        bh=P0kHaS/yTCHWxD6jPVih6CP4uqK61KZjHX2lKyGh/ug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jlpxqvcRjz0qeBDiMCK7F7gyzj7A4BmabwGtds9y7edfIblQJbBPLpySpJsvwTbkU
         D3ODt2NPjAuRgr4M39VU3QHvGD8tLSFOpTDBT9cNPIjkN1crFJ5yNwm9GRPWuWb2EC
         omZUSUlzLFcog/QbJmiZlBM7lWMaBzAKYLcljCjI=
Date:   Thu, 5 Sep 2019 17:21:57 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 0/6] posix-cpu-timers: Fallout fixes and permission
 tightening
Message-ID: <20190905152156.GC18251@lenoir>
References: <20190905120339.561100423@linutronix.de>
 <20190905144829.GA18251@lenoir>
 <alpine.DEB.2.21.1909051650030.1902@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1909051650030.1902@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 04:57:10PM +0200, Thomas Gleixner wrote:
> On Thu, 5 Sep 2019, Frederic Weisbecker wrote:
> > On Thu, Sep 05, 2019 at 02:03:39PM +0200, Thomas Gleixner wrote:
> > > Sysbot triggered an issue in the posix timer rework which was trivial to
> > > fix, but after running another test case I discovered that the rework broke
> > > the permission checks subtly. That's also a straightforward fix.
> > > 
> > > Though when staring at it I discovered that the permission checks for
> > > process clocks and process timers are completely bonkers. The only
> > > requirement is that the target PID is a group leader. Which means that any
> > > process can read the clocks and attach timers to any other process without
> > > priviledge restrictions.
> > > 
> > > That's just wrong because the clocks and timers can be used to observe
> > > behaviour and both reading the clocks and arming timers adds overhead and
> > > influences runtime performance of the target process.
> > 
> > Yeah I stumbled upon that by the past and found out the explanation behind
> > in old history: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/kernel/posix-cpu-timers.c?id=a78331f2168ef1e67b53a0f8218c70a19f0b2a4c
> > 
> > "This makes no constraint on who can see whose per-process clocks.  This
> > information is already available for the VIRT and PROF (i.e.  utime and stime)
> > information via /proc.  I am open to suggestions on if/how security
> > constraints on who can see whose clocks should be imposed."
> > 
> > I'm all for mitigating that, let's just hope that won't break some ABIs.
> 
> Well, reading clocks is one part of the issue. Arming timers on any process
> is a different story.

Exactly!

> 
> Also /proc/$PID access can be restricted nowadays. So that posic clock
> stuff should at least have exactly the same restrictions.

Yeah definetly.

> 
> Thanks,
> 
> 	tglx
> 
