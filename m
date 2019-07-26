Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A887C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9E622BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387513AbfGZVa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 17:30:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbfGZVa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 17:30:56 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2208217D9;
        Fri, 26 Jul 2019 21:30:54 +0000 (UTC)
Date:   Fri, 26 Jul 2019 17:30:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Julia Cartwright <julia@ni.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [patch 10/12] hrtimer: Determine hard/soft expiry mode for
 hrtimer sleepers on RT
Message-ID: <20190726173052.66942a7b@gandalf.local.home>
In-Reply-To: <20190726211623.GP29109@jcartwri.amer.corp.natinst.com>
References: <20190726183048.982726647@linutronix.de>
        <20190726185753.645792403@linutronix.de>
        <20190726211623.GP29109@jcartwri.amer.corp.natinst.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019 21:16:24 +0000
Julia Cartwright <julia@ni.com> wrote:

> > +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > +		if (task_is_realtime(current) && !(mode & HRTIMER_MODE_SOFT))
> > +			mode |= HRTIMER_MODE_HARD;  
> 
> Because this ends up sampling the tasks' scheduling parameters only at
> the time of enqueue, it doesn't take into consideration whether or not
> the task maybe holding a PI lock and later be boosted if contended by an
> RT thread.
> 
> Am I correct in assuming there is an induced inversion here in this
> case, because the deferred wakeup mechanism isn't part of the PI chain?
> 
> If so, is this just to be an accepted limitation at this point?  Is the
> intent to argue this away as bad RT application design? :)
> 

Well, it shouldn't be holding any kernel PI locks (aka spin_lock) when
it sleeps, but may be holding a PI futex. In which case, I would say is
a bad RT application, to have a thread sleep on a non RT timer while
holding a lock that an RT Task might take.

-- Steve
