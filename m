Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D0ECA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB99521721
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u+/vQ5rH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390214AbfJ1OiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 10:38:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49892 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730441AbfJ1OiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 10:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xgAOnlp7ZBAWh5vP0sbEuG/b7xjQLYHGCchMpQ5Bwys=; b=u+/vQ5rHWiyiR7BvUFgcsmDHN
        OInbaBhoUtmHdkfA8zfC/FFemUsniSgG/dWVOepfOH3g7BrAVbVKi6LDopAktdnIdTOsd++/b6F4G
        nU8pxCvqjk9BEqpCMOZx8hJpBc8A20xxVPqAtquAak+uesymbr6UVLlBFkf9jY6D2TH/3tIwJW9pG
        yITKfu6lakCSjlFom1DNv61pwEWor8kum2Nu3loZ1M3lsw6gwE35J0KgtrAryY+gUW99l6XnJ5puf
        o/QNBxpjzoCL7Aedp56R8m1yhfjZkNTqQPgwhVNiJTYuFLte13cZ5pk8m99cO7qJ/jKcmTLAu1AhY
        eTbcmh9xA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iP69X-0001zs-J4; Mon, 28 Oct 2019 14:37:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BC0013002B0;
        Mon, 28 Oct 2019 15:36:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 171D62100B87C; Mon, 28 Oct 2019 15:37:49 +0100 (CET)
Date:   Mon, 28 Oct 2019 15:37:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: rt: Make RT capacity aware
Message-ID: <20191028143749.GE4114@hirez.programming.kicks-ass.net>
References: <20191009104611.15363-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009104611.15363-1-qais.yousef@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 11:46:11AM +0100, Qais Yousef wrote:
> Capacity Awareness refers to the fact that on heterogeneous systems
> (like Arm big.LITTLE), the capacity of the CPUs is not uniform, hence
> when placing tasks we need to be aware of this difference of CPU
> capacities.
> 
> In such scenarios we want to ensure that the selected CPU has enough
> capacity to meet the requirement of the running task. Enough capacity
> means here that capacity_orig_of(cpu) >= task.requirement.
> 
> The definition of task.requirement is dependent on the scheduling class.
> 
> For CFS, utilization is used to select a CPU that has >= capacity value
> than the cfs_task.util.
> 
> 	capacity_orig_of(cpu) >= cfs_task.util
> 
> DL isn't capacity aware at the moment but can make use of the bandwidth
> reservation to implement that in a similar manner CFS uses utilization.
> The following patchset implements that:
> 
> https://lore.kernel.org/lkml/20190506044836.2914-1-luca.abeni@santannapisa.it/
> 
> 	capacity_orig_of(cpu)/SCHED_CAPACITY >= dl_deadline/dl_runtime
> 
> For RT we don't have a per task utilization signal and we lack any
> information in general about what performance requirement the RT task
> needs. But with the introduction of uclamp, RT tasks can now control
> that by setting uclamp_min to guarantee a minimum performance point.
> 
> ATM the uclamp value are only used for frequency selection; but on
> heterogeneous systems this is not enough and we need to ensure that the
> capacity of the CPU is >= uclamp_min. Which is what implemented here.
> 
> 	capacity_orig_of(cpu) >= rt_task.uclamp_min
> 
> Note that by default uclamp.min is 1024, which means that RT tasks will
> always be biased towards the big CPUs, which make for a better more
> predictable behavior for the default case.
> 
> Must stress that the bias acts as a hint rather than a definite
> placement strategy. For example, if all big cores are busy executing
> other RT tasks we can't guarantee that a new RT task will be placed
> there.
> 
> On non-heterogeneous systems the original behavior of RT should be
> retained. Similarly if uclamp is not selected in the config.
> 
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>

Works for me; Steve you OK with this?
