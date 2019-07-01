Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4A0C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A50217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A2o3MTX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbfGAJCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 05:02:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35574 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbfGAJCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 05:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nap7ea9ZuQDK+WQcOoOnWBJHxx44lH5AsQ2GFZK7jcc=; b=A2o3MTX2dBSo4ZP+AF6wKo1o0
        OjeQCaS5lYE0tPjVyEuWkkEmVcJoL3YKVHYK3JevAUqrkF+05SNDF/QKUgCB4LiFYAjvNRsJDyi52
        APEBbS2c924gXzNKlGKcHkLiE0ObDiZLNjTXmclcaHvE2w89auV6h+65OICAwRa+Q86vy4sqfftnS
        eOLz2lTxK5QOpqFuUh/newNO7R4F3NZ9G5VQ5ChZ6NXd4QCMYMAAvQEYYuprQFaqbHTZuAO8Dso3Z
        0Hy7FL9ZBUXWOYHlh/21aLbcdmh+5EeYxbYVucXTsr7V3OfCpIZiVkOYdNfNsL1WS7Vg00j8eG+/A
        xO5dGpHFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhsCM-0007P9-MX; Mon, 01 Jul 2019 09:02:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E32FD20AB58E2; Mon,  1 Jul 2019 11:02:04 +0200 (CEST)
Date:   Mon, 1 Jul 2019 11:02:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     subhra mazumdar <subhra.mazumdar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, Paul Turner <pjt@google.com>,
        riel@surriel.com, morten.rasmussen@arm.com
Subject: Re: [RESEND PATCH v3 0/7] Improve scheduler scalability for fast path
Message-ID: <20190701090204.GQ3402@hirez.programming.kicks-ass.net>
References: <20190627012919.4341-1-subhra.mazumdar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627012919.4341-1-subhra.mazumdar@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 06:29:12PM -0700, subhra mazumdar wrote:
> Hi,
> 
> Resending this patchset, will be good to get some feedback. Any suggestions
> that will make it more acceptable are welcome. We have been shipping this
> with Unbreakable Enterprise Kernel in Oracle Linux.
> 
> Current select_idle_sibling first tries to find a fully idle core using
> select_idle_core which can potentially search all cores and if it fails it
> finds any idle cpu using select_idle_cpu. select_idle_cpu can potentially
> search all cpus in the llc domain. This doesn't scale for large llc domains
> and will only get worse with more cores in future.
> 
> This patch solves the scalability problem by:
>  - Setting an upper and lower limit of idle cpu search in select_idle_cpu
>    to keep search time low and constant
>  - Adding a new sched feature SIS_CORE to disable select_idle_core
> 
> Additionally it also introduces a new per-cpu variable next_cpu to track
> the limit of search so that every time search starts from where it ended.
> This rotating search window over cpus in LLC domain ensures that idle
> cpus are eventually found in case of high load.

Right, so we had a wee conversation about this patch series at OSPM, and
I don't see any of that reflected here :-(

Specifically, given that some people _really_ want the whole L3 mask
scanned to reduce tail latency over raw throughput, while you guys
prefer the other way around, it was proposed to extend the task model.

Specifically something like a latency-nice was mentioned (IIRC) where a
task can give a bias but not specify specific behaviour. This is very
important since we don't want to be ABI tied to specific behaviour.

Some of the things we could tie to this would be:

  - select_idle_siblings; -nice would scan more than +nice,

  - wakeup preemption; when the wakee has a relative smaller
    latency-nice value than the current running task, it might preempt
    sooner and the other way around of course.

  - pack-vs-spread; +nice would pack more with like tasks (since we
    already spread by default [0] I don't think -nice would affect much
    here).


Hmmm?
