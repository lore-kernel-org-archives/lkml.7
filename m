Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B03C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 15:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0FE2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 15:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573831629;
	bh=pAx6jZ1XB8mi9ltuZhOPbIMX5S3a/NY493zOjLonUHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ealeyb3HaqS6HwR+qnnZt0EGRj+gvw9MApsK1Tn8l22DndI+DJ/jwPzqaBc4l70ll
	 IpWC+HYECxYUyNgAEmqLHGNJ66THRKmot/xF2s01vymOQPVoBpdEMkqCqZT7s93KTp
	 +Wjk4svNPs6oOImSJRH54IRgtbVG+W77k2t1kT1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfKOP1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 10:27:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:41334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727443AbfKOP1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 10:27:07 -0500
Received: from localhost (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EA2420732;
        Fri, 15 Nov 2019 15:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573831627;
        bh=pAx6jZ1XB8mi9ltuZhOPbIMX5S3a/NY493zOjLonUHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P9T4xTQfN8N/WtX5JqhNbsmJws8AwrlScsSewrGCusD35LctRLs4ZB01WM1jI7yEk
         NdchnXejTdXtW5MIgLX7gROlst7RhPDjrJE4QHoioPUMyu66dYKc0PZSUh8He2eVEy
         JISMHfinM/sznFr6ns5WEzs/i6wF+vmsBkIf8ats=
Date:   Fri, 15 Nov 2019 16:27:04 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Pavel Machek <pavel@ucw.cz>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH 3/9] sched/vtime: Handle nice updates under vtime
Message-ID: <20191115152703.GA21265@lenoir>
References: <20191106030807.31091-1-frederic@kernel.org>
 <20191106030807.31091-4-frederic@kernel.org>
 <20191115101648.GC4131@hirez.programming.kicks-ass.net>
 <20191115101831.GW5671@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115101831.GW5671@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 11:18:31AM +0100, Peter Zijlstra wrote:
> On Fri, Nov 15, 2019 at 11:16:48AM +0100, Peter Zijlstra wrote:
> > On Wed, Nov 06, 2019 at 04:08:01AM +0100, Frederic Weisbecker wrote:
> > > The cputime niceness is determined while checking the target's nice value
> > > at cputime accounting time. Under vtime this happens on context switches,
> > > user exit and guest exit. But nice value updates while the target is
> > > running are not taken into account.
> > > 
> > > So if a task runs tickless for 10 seconds in userspace but it has been
> > > reniced after 5 seconds from -1 (not nice) to 1 (nice), on user exit
> > > vtime will account the whole 10 seconds as CPUTIME_NICE because it only
> > > sees the latest nice value at accounting time which is 1 here. Yet it's
> > > wrong, 5 seconds should be accounted as CPUTIME_USER and 5 seconds as
> > > CPUTIME_NICE.
> > > 
> > > In order to solve this, we now cover nice updates withing three cases:
> > > 
> > > * If the nice updater is the current task, although we are in kernel
> > >   mode there can be pending user or guest time in the cache to flush
> > >   under the prior nice state. Account these if any. Also toggle the
> > >   vtime nice flag for further user/guest cputime accounting.
> > > 
> > > * If the target runs on a different CPU, we interrupt it with an IPI to
> > >   update the vtime state in place. If the task is running in user or
> > >   guest, the pending cputime is accounted under the prior nice state.
> > >   Then the vtime nice flag is toggled for further user/guest cputime
> > >   accounting.
> > 
> > But but but, I thought the idea was to _never_ send interrupts to
> > NOHZ_FULL cpus ?!?
> 
> That is, isn't the cure worse than the problem? I mean, who bloody cares
> about silly accounting crud more than not getting interrupts on their
> NOHZ_FULL cpus.

Yeah indeed. I tend to sacrifice everything for correctness but perhaps we can live with
small issues like nice accounting not being accounted to the right place if that
can avoid disturbing nohz_full CPUs. Also who cares about renicing a task that is
supposed to run alone.

So here is what I can do: I'll make a simplified version of that set which accounts
on top of the task_nice() value found on accounting time (context switch, user exit,
guest exit) and if some user ever complains, I can still bring back that IPI solution.

Thanks.
