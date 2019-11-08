Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E24FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745E9224BD
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qtwhl4XD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732949AbfKHMZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:25:07 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44096 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732852AbfKHMZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 07:25:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bTO0xcbvwLjtm+zh06iSVufDjqQd3IudnQ8GAn9yq40=; b=Qtwhl4XDOLN5q6TTENBaR/iVB
        UYKyfFy5n1zvoI1dsyD45RD1v56QyBo6gmvsGUhai1zrNh8loc5PDCC2VQrvryp4VpyLb5smLdiFM
        5+t62BJNR5cvcs20OQkvX4nJ3sGD2bxMc9N2nXmkikfOoxUa6whgPW1sUaClfACIs1yoy2iN0cU1u
        7f78nb2hYHOK1deIIs5FfnP0egEiICoTguEJF7ASitM4YXs5lrVzAoaSnE37PhfrWHBU1th/8l0TP
        QxN7NWioMfryrPLUCaTQvFTg/DS8o4B7u+7+jxVKYFct6qngEyzO2GcEd/caWUMZVhysRQsxpJAfR
        wuxBf79eg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iT3Jo-0002jg-Lg; Fri, 08 Nov 2019 12:24:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 290B4306D75;
        Fri,  8 Nov 2019 13:23:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0E95729ABB5CB; Fri,  8 Nov 2019 13:24:47 +0100 (CET)
Date:   Fri, 8 Nov 2019 13:24:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, linux-kernel@vger.kernel.org,
        aaron.lwe@gmail.com, valentin.schneider@arm.com, mingo@kernel.org,
        pauld@redhat.com, jdesfossez@digitalocean.com,
        naravamudan@digitalocean.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        kernel-team@android.com, john.stultz@linaro.org
Subject: Re: NULL pointer dereference in pick_next_task_fair
Message-ID: <20191108122447.GQ5671@hirez.programming.kicks-ass.net>
References: <33643a5b-1b83-8605-2347-acd1aea04f93@virtuozzo.com>
 <20191106165437.GX4114@hirez.programming.kicks-ass.net>
 <20191106172737.GM5671@hirez.programming.kicks-ass.net>
 <831c2cd4-40a4-31b2-c0aa-b5f579e770d6@virtuozzo.com>
 <20191107132628.GZ4114@hirez.programming.kicks-ass.net>
 <20191107153848.GA31774@google.com>
 <20191107184356.GF4114@hirez.programming.kicks-ass.net>
 <20191107192907.GA30258@worktop.programming.kicks-ass.net>
 <20191108110212.GA204618@google.com>
 <20191108120034.GK4131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108120034.GK4131@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 01:00:34PM +0100, Peter Zijlstra wrote:
> > That would remove one call site to newidle_balance() too, which I think
> > is good. Hackbench probably won't like that, though.
> 
> Yeah, that fast path really is important. I've got a few patches pending
> there, fixing a few things and that gets me 2% extra on a sched-yield
> benchmark.

That is, the fast path also allows a cpu-cgroup optimization that wins
something in the order of 3% for cgroup workloads.

The cgroup optimization is basically that when we schedule from
fair->fair, we can avoid having to put/set the whole cgroup hierarchy
but only have to update the part that changed.

Couple that with the set_next_buddy() from dequeue_task_fair(), which
results in the next task being more likely to be from the same cgroup,
and you've got a win.


