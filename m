Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B0EC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2437C2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qk+JfLLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfLLPEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:04:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59264 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728624AbfLLPEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:04:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rnKPEPHq5zWJRr2D9M8D7b1LZbRScvFVrRnHqxj8R2Y=; b=Qk+JfLLq7VE+GfWfLz9sBZPDG
        RbfdAD7UVvPSwk+5qsrwzipk3m6cYByNZmYuaEZDxb186BGsGu3DzU5KQzhPiTSNujtPXM8IP5/uS
        996MttNeOxiAldY20deJCtPv6xa+LrcH+bbOlxznh0H0//johEHSu0frJ4N5Et3Cd74LKWfWp3T+s
        FsnylRaDG6sDaEghhqcx7mSzQ9CnwZtYvJ6DJS8yy/X9Yg4CMtndj+OuPOOHad5DBt4nB13KYb/UO
        V9t4f6VmybuDBuc1lgmBFe60y3GDRIgYr7Xm5ln1dac6hpLOrsUE/qWrythI3Y/oriSkR/SQ/Z1wM
        w4Yfqghnw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifQ11-0000oE-Pv; Thu, 12 Dec 2019 15:04:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 29CB4304D2B;
        Thu, 12 Dec 2019 16:03:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9053920120E34; Thu, 12 Dec 2019 16:04:29 +0100 (CET)
Date:   Thu, 12 Dec 2019 16:04:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Cheng Jian <cj.chengjian@huawei.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        chenwandun@huawei.com, xiexiuqi@huawei.com, liwei391@huawei.com,
        huawei.libin@huawei.com, bobo.shaobowang@huawei.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org
Subject: Re: [PATCH] sched/fair: Optimize select_idle_cpu
Message-ID: <20191212150429.GZ2827@hirez.programming.kicks-ass.net>
References: <20191212144102.181510-1-cj.chengjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212144102.181510-1-cj.chengjian@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 10:41:02PM +0800, Cheng Jian wrote:
> select_idle_cpu will scan the LLC domain for idle CPUs,
> it's always expensive. so commit
>     1ad3aaf3fcd2 ("sched/core: Implement new approach to scale select_idle_cpu()")
> introduces a way to limit how many CPUs we scan.
> 
> But this also lead to the following issue:
> 
> Our threads are all bind to the front CPUs of the LLC domain,
> and now all the threads runs on the last CPU of them. nr is
> always less than the cpumask_weight, for_each_cpu_wrap can't
> find the CPU which our threads can run on, so the threads stay
> at the last CPU all the time.
> 
> Fixes: 1ad3aaf3fcd2 ("sched/core: Implement new approach to scale select_idle_cpu()")
> Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
> ---
>  kernel/sched/fair.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 08a233e97a01..16a29b570803 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5834,6 +5834,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>  	s64 delta;
>  	int this = smp_processor_id();
>  	int cpu, nr = INT_MAX, si_cpu = -1;
> +	struct cpumask cpus;

NAK, you must not put a cpumask on stack.
