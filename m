Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7CDC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F6720828
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HcCxby0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387466AbfIEJbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 05:31:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46110 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731306AbfIEJbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 05:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9RD+YDd+bL9dLE8aDPXeDMgQEDl+xz6cGixfqwcR1Rw=; b=HcCxby0xFotVIfK2DaQ8o2pYU
        0tWCJ+L+DSDMHFkuNYxZOnExkCtDwDp95W7BxW95bo4qnOFfXxeGEZBLFp9fXgQQ9fHiWs5c23H+u
        kPjtoeJ5yDaq5o4odJszTQ7iLurIWQPuM5YdjvWbZO8V8DQba7NYVIzZwmXBWmYLPuTAjJugiSPFv
        mlahJqN6I8Oa0Dia48ONZ/0CZGJn+TR7TJcxxNQP3lvrLbRBAr2bASDQv5ruLvKuT1QE//anFkChN
        EB4qYQqJfYMyv89CRsK9Sv14WpMYA9u7LrZHiVSgXqnC1NlOyJ2ms7LiloK+JwqvqlpKfZX3dALrb
        /sGRM0Kkw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5o6z-0002UZ-PM; Thu, 05 Sep 2019 09:31:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 040A0305E47;
        Thu,  5 Sep 2019 11:30:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E064820EFA5D9; Thu,  5 Sep 2019 11:31:27 +0200 (CEST)
Date:   Thu, 5 Sep 2019 11:31:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     subhra mazumdar <subhra.mazumdar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, parth@linux.ibm.com,
        patrick.bellasi@arm.com
Subject: Re: [RFC PATCH 7/9] sched: search SMT before LLC domain
Message-ID: <20190905093127.GI2349@hirez.programming.kicks-ass.net>
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
 <20190830174944.21741-8-subhra.mazumdar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830174944.21741-8-subhra.mazumdar@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 10:49:42AM -0700, subhra mazumdar wrote:
> Search SMT siblings before all CPUs in LLC domain for idle CPU. This helps
> in L1 cache locality.
> ---
>  kernel/sched/fair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8856503..94dd4a32 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6274,11 +6274,11 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  			return i;
>  	}
>  
> -	i = select_idle_cpu(p, sd, target);
> +	i = select_idle_smt(p, target);
>  	if ((unsigned)i < nr_cpumask_bits)
>  		return i;
>  
> -	i = select_idle_smt(p, target);
> +	i = select_idle_cpu(p, sd, target);
>  	if ((unsigned)i < nr_cpumask_bits)
>  		return i;
>  

But it is absolutely conceptually wrong. An idle core is a much better
target than an idle sibling.
