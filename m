Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF33C341A9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54C524723
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QnHe2UaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfLMMJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 07:09:44 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48656 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfLMMJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 07:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Nr1I6SS3feCDCxDX98WOBu5+rrE0sIel3SECkfzkxLQ=; b=QnHe2UaIVxReuM76bdKA79ENXD
        jnOHkBqFLlG4vig16AARH8jVMlLFarljq6FVA/8VUssKra++ftkU5+IT/qqaIo9fpJlRAFinnHeRK
        8NE0VzhZgXyBj3HiFq2I6wKnVAyLD0PbqQ4y8xz7VdKECMin6Ys+V6F3S92nAB2h+bPFcT0Bx2kFK
        zSW9zbuee/d6ZPGLF5jV1JkJrU6cgzVlm5VbzANKYpO0fqV1tUJeXV5aHRLeZ6EubTRPx3ZTTFTrt
        sn1gEJCN7JVtYvCYpTGXHFxkxrQzIGA/6H9+mJmkHhtFAcfbHUjnqU8QgNnAVSPCujDRKODz5xdyJ
        oedNkF9w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifjky-0003YE-Km; Fri, 13 Dec 2019 12:09:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DDF9330602B;
        Fri, 13 Dec 2019 13:07:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A37B72B1886CA; Fri, 13 Dec 2019 13:09:13 +0100 (CET)
Date:   Fri, 13 Dec 2019 13:09:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     "chengjian (D)" <cj.chengjian@huawei.com>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, chenwandun@huawei.com,
        xiexiuqi@huawei.com, liwei391@huawei.com, huawei.libin@huawei.com,
        bobo.shaobowang@huawei.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Subject: Re: [PATCH] sched/fair: Optimize select_idle_cpu
Message-ID: <20191213120913.GB2844@hirez.programming.kicks-ass.net>
References: <20191212144102.181510-1-cj.chengjian@huawei.com>
 <20191212152406.GB2827@hirez.programming.kicks-ass.net>
 <d40ac385-626f-e86f-b2cb-69adf10a193a@huawei.com>
 <6d188305-66ab-81cf-6340-34d155dcaf3b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d188305-66ab-81cf-6340-34d155dcaf3b@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 11:28:00AM +0000, Valentin Schneider wrote:
> On 13/12/2019 09:57, chengjian (D) wrote:
> > 
> > in select_idle_smt()
> > 
> > /*
> >  * Scan the local SMT mask for idle CPUs.
> >  */
> > static int select_idle_smt(struct task_struct *p, int target)
> > {
> >     int cpu, si_cpu = -1;
> > 
> >     if (!static_branch_likely(&sched_smt_present))
> >         return -1;
> > 
> >     for_each_cpu(cpu, cpu_smt_mask(target)) {
> >         if (!cpumask_test_cpu(cpu, p->cpus_ptr))
> >             continue;
> >         if (available_idle_cpu(cpu))
> >             return cpu;
> >         if (si_cpu == -1 && sched_idle_cpu(cpu))
> >             si_cpu = cpu;
> >     }
> > 
> >     return si_cpu;
> > }
> > 
> > 
> > Why don't we do the same thing in this function,
> > 
> > although cpu_smt_present () often has few CPUs.
> > 
> > it is better to determine the 'p->cpus_ptr' first.
> > 
> > 
> 
> Like you said the gains here would probably be small - the highest SMT
> count I'm aware of is SMT8 (POWER9). Still, if we end up with both
> select_idle_core() and select_idle_cpu() using that pattern, it would make
> sense IMO to align select_idle_smt() with those.

The cpumask_and() operation added would also have cost. I really don't
see that paying off.

The other sites have the problem that we combine an iteration limit with
affinity constraints. This loop doesn't do that and therefore doesn't
suffer the problem.
