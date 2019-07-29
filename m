Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277FEC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC374205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ONNUn0+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbfG2ULq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:11:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44508 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbfG2ULo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:11:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tVzGNh46p11xJCp/QVEqOCFK+AgFdqni/w2NTMqBXpI=; b=ONNUn0+v6UKGefnLp5MlICEj8
        rs8jlW8TeLmb6brykyu7WcXTpzoSEfnFKN2gctJaqCiYf3EOqHq3hx8B3WnL3+pBaZTx59kERW4/k
        01EOXsLxSe8YpwCZOi4DlTw19lrVIKWakVQXSx+P7kPfrhjtA5/OMx4SHf33bdCYIeox6Ksbt/tCf
        j88syn/qIMQNzel7ONs4JM9bF65DxADLWHOubUTPVrsZKg/sakq1GJ/fjoIxJxu5F/giZ6/eTdbzS
        Q294ksVxVF7Ww7lUoe2qtKQATn96WFumplhPzXjaHOUtzF4kbEHfezrdK+nlUlAV7Wj++0ODviCcC
        LvmH7Crbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsBza-0004j9-5c; Mon, 29 Jul 2019 20:11:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 971CE20AF2C00; Mon, 29 Jul 2019 22:11:32 +0200 (CEST)
Date:   Mon, 29 Jul 2019 22:11:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        dietmar.eggemann@arm.com, mingo@redhat.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        mgorman@techsingularity.net, vincent.guittot@linaro.org
Subject: Re: [PATCH 03/14] sched,fair: redefine runnable_load_avg as the sum
 of task_h_load
Message-ID: <20190729201132.GS31398@hirez.programming.kicks-ass.net>
References: <20190722173348.9241-1-riel@surriel.com>
 <20190722173348.9241-4-riel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722173348.9241-4-riel@surriel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 01:33:37PM -0400, Rik van Riel wrote:
> The runnable_load magic is used to quickly propagate information about
> runnable tasks up the hierarchy of runqueues. The runnable_load_avg is
> mostly used for the load balancing code, which only examines the value at
> the root cfs_rq.
> 
> Redefine the root cfs_rq runnable_load_avg to be the sum of task_h_loads
> of the runnable tasks. This works because the hierarchical runnable_load of
> a task is already equal to the task_se_h_load today. This provides enough
> information to the load balancer.
> 
> The runnable_load_avg of the cgroup cfs_rqs does not appear to be
> used for anything, so don't bother calculating those.
> 
> This removes one of the things that the code currently traverses the
> cgroup hierarchy for, and getting rid of it brings us one step closer
> to a flat runqueue for the CPU controller.

Nice!
