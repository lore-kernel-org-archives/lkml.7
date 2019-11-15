Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA9DC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CF320718
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q1j/WVVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfKOKSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:18:51 -0500
Received: from merlin.infradead.org ([205.233.59.134]:58990 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbfKOKSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YDvUZ1Hjvu2Y0zfQ41yF7z6oWVUTYWyxCjOIEg/zrLM=; b=Q1j/WVVWMgR7ADpplI8+Mh5xy
        Lb1pi3AMLogapbukX3zscigH6wuB6DKf23ZZ5ebNPh9FQbyjTGgf0fOup7UmbFGP1tx/Ux6gpTYd/
        s/Bd3Pmzk77VpAC6h5GdeGfDmeMGv2CfWs2ZrZMvbTALF963pM38VPU2MvCt5dZx2H7b/Jlihig8u
        IuL2XtaNbDEAnjHsUo36PpjOdrMxrEFJuOXVXcpHhcKbZwbQZXXZEkI9wrrdykX7v+pcK/c+R/RQ+
        nAdU/plUCfG5Zzipe+NfSVt0/DzFu8RXrzvkgTXcQGaeSAXhuutNa88peREFz+HTk+Nq7SAUezzug
        xrRKaIaXQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVYgT-0006CB-1p; Fri, 15 Nov 2019 10:18:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 162E3303D9F;
        Fri, 15 Nov 2019 11:17:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 286A22B128BE7; Fri, 15 Nov 2019 11:18:31 +0100 (CET)
Date:   Fri, 15 Nov 2019 11:18:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
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
Message-ID: <20191115101831.GW5671@hirez.programming.kicks-ass.net>
References: <20191106030807.31091-1-frederic@kernel.org>
 <20191106030807.31091-4-frederic@kernel.org>
 <20191115101648.GC4131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115101648.GC4131@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 11:16:48AM +0100, Peter Zijlstra wrote:
> On Wed, Nov 06, 2019 at 04:08:01AM +0100, Frederic Weisbecker wrote:
> > The cputime niceness is determined while checking the target's nice value
> > at cputime accounting time. Under vtime this happens on context switches,
> > user exit and guest exit. But nice value updates while the target is
> > running are not taken into account.
> > 
> > So if a task runs tickless for 10 seconds in userspace but it has been
> > reniced after 5 seconds from -1 (not nice) to 1 (nice), on user exit
> > vtime will account the whole 10 seconds as CPUTIME_NICE because it only
> > sees the latest nice value at accounting time which is 1 here. Yet it's
> > wrong, 5 seconds should be accounted as CPUTIME_USER and 5 seconds as
> > CPUTIME_NICE.
> > 
> > In order to solve this, we now cover nice updates withing three cases:
> > 
> > * If the nice updater is the current task, although we are in kernel
> >   mode there can be pending user or guest time in the cache to flush
> >   under the prior nice state. Account these if any. Also toggle the
> >   vtime nice flag for further user/guest cputime accounting.
> > 
> > * If the target runs on a different CPU, we interrupt it with an IPI to
> >   update the vtime state in place. If the task is running in user or
> >   guest, the pending cputime is accounted under the prior nice state.
> >   Then the vtime nice flag is toggled for further user/guest cputime
> >   accounting.
> 
> But but but, I thought the idea was to _never_ send interrupts to
> NOHZ_FULL cpus ?!?

That is, isn't the cure worse than the problem? I mean, who bloody cares
about silly accounting crud more than not getting interrupts on their
NOHZ_FULL cpus.
