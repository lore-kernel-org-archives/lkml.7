Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6AEC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 21:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA582075E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 21:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="faVO0Z2X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfKTVFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 16:05:23 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48158 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfKTVFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 16:05:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V6mmgxtkXDcIQX6qcqCxCHnDmuVgMT2R3iVxZ3C6yPE=; b=faVO0Z2XZSMV08kbBojdX5+/b
        ifwe+BJWp/QGCOQIWP3sMMKcJaMRH9nOqeh7yQcbLpwaLlSQNdiENL3VlgdsQ227vj5eANPQ23MuL
        iYvzSnvd5b7A4K7NhrnLL3kpiDDufJwztgmuom3zK9RsueuB3gtjGc+8eQEbUUtiKWbYsViSxCn5X
        eZzsOVi1Z6jXHqNKtw8gaQcgCGc2jBMdjsu+s8Bd4F/Hhr+1xptGmlIMhpInlP9QtoAEDYjS+J6sp
        ilZSLfSqeWBBV5VrLi9rd+rbnMjRyYfw6dcOFNjUxI+3WfGPwGvW3lXVO7c9iKEXRLcWvQzC8iCU7
        cTMiVW3SQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iXX9Y-0000QA-65; Wed, 20 Nov 2019 21:04:44 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id F11B3980E2F; Wed, 20 Nov 2019 22:04:40 +0100 (CET)
Date:   Wed, 20 Nov 2019 22:04:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/6] sched/cputime: Support other fields on
 kcpustat_field()
Message-ID: <20191120210440.GR3079@worktop.programming.kicks-ass.net>
References: <20191119232218.4206-1-frederic@kernel.org>
 <20191119232218.4206-2-frederic@kernel.org>
 <20191120115142.GA89662@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120115142.GA89662@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 12:51:42PM +0100, Ingo Molnar wrote:
> * Frederic Weisbecker <frederic@kernel.org> wrote:

> > +		/*
> > +		 * Nice VS unnice cputime accounting may be inaccurate if
> > +		 * the nice value has changed since the last vtime update.
> > +		 * But proper fix would involve interrupting target on nice
> > +		 * updates which is a no go on nohz_full.
> 
> Well, we actually already interrupt the target in both sys_nice() and 
> sys_setpriority() etc. syscall variants: we call set_user_nice() which 
> calls resched_curr() and the task is sent an IPI and runs through a 
> reschedule.

I think we can easily avoid doing that IPI when we find it is the only
task on that runqueue. Which is exactly the case for NOHZ_FULL.

