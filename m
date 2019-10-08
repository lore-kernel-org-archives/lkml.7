Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB59C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160AE218AC
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r+DgLo7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfJHRjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 13:39:31 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42784 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfJHRja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 13:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7mN2uRVrNBa851TOjCoSypqhGYuGGBF+I76EoO/K6j0=; b=r+DgLo7b05l0q8vi7/Yh3VmUs
        Xe/4iS4aWYQrnjn3ytyVHx4sCzKzxn2849Nxnq47Iq1n892BH0eBR0IoafLt7XNgA+k8zduxvtbWw
        +qy5bUZHE4UALRknq/VElO2sCQNjq77U8P/vFCQrMgYyuFKTEt/Um9wx/EW2/N3O48KFg4rrxNi9P
        pF5vHI/0KY0lWDTO3cu3/6uPOHxh10wAe3unO2T7FiCtGzI7pcBdEeagCDGPi/+DAFd98U40CvCF5
        3kPjXXzTpSDKkr6KlFgSL7zX7XF1gK7ENVnnrZOdymcN3XJhh9LcDZ8VKpdib+w7pRYAuTKJCO1+M
        drr0gbkNg==;
Received: from [31.161.223.134] (helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHtS6-0004Aj-VY; Tue, 08 Oct 2019 17:39:18 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D56789802E0; Tue,  8 Oct 2019 19:39:10 +0200 (CEST)
Date:   Tue, 8 Oct 2019 19:39:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Phil Auld <pauld@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH v3 04/10] sched/fair: rework load_balance
Message-ID: <20191008173910.GB22902@worktop.programming.kicks-ass.net>
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
 <1568878421-12301-5-git-send-email-vincent.guittot@linaro.org>
 <c752dd1a-731e-aae3-6a2c-aecf88901ac0@arm.com>
 <CAKfTPtBQNJfNmBqpuaefsLzsTrGxJ=2bTs+tRdbOAa9J3eKuVw@mail.gmail.com>
 <31cac0c1-98e4-c70e-e156-51a70813beff@arm.com>
 <20191008141642.GQ2294@hirez.programming.kicks-ass.net>
 <b4e29e48-a97c-67e5-a284-6ddc13222c5b@arm.com>
 <20191008153002.GA21999@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008153002.GA21999@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 05:30:02PM +0200, Vincent Guittot wrote:

> This is how I plan to get ride of the problem:
> +		if (busiest->group_weight == 1 || sds->prefer_sibling) {
> +			unsigned int nr_diff = busiest->sum_h_nr_running;
> +			/*
> +			 * When prefer sibling, evenly spread running tasks on
> +			 * groups.
> +			 */
> +			env->migration_type = migrate_task;
> +			lsub_positive(&nr_diff, local->sum_h_nr_running);
> +			env->imbalance = nr_diff >> 1;
> +			return;
> +		}

I'm thinking the max_t(long, 0, ...); variant reads a lot simpler and
really _should_ work given that -fno-strict-overflow / -fwrapv mandates
2s complement.
