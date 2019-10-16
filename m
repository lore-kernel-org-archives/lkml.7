Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5531ECE59D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B3B2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571197099;
	bh=aTlF1dCIbGGZOW/R/ewpTNWIjP68LFU3V8Gpe+w0oDk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=wzkgHRIXuq4CV8VcVOCD5NliL3FajVT+XJYqW8yaltmg0nKsRV4f5HBmct6XYEOno
	 jIa9LdX5GIx7fWAxeXsVq6+aRbtsosSgi6Tjs4Y3Nl9a+InFNbdySZLVN08oR8rGOB
	 /sVoN0SF6BgsZ6Jrh4JP08qrJLbQAkqx46dj8QKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732599AbfJPDiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 23:38:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbfJPDiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 23:38:16 -0400
Received: from paulmck-ThinkPad-P72 (unknown [76.14.14.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0169620663;
        Wed, 16 Oct 2019 03:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571197096;
        bh=aTlF1dCIbGGZOW/R/ewpTNWIjP68LFU3V8Gpe+w0oDk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=votH6JIvpqCRTQIM8DdQnAfm0RxX58+TbB9Es3sEgF8pGOEs16AnzV0hhJjQEQugk
         Y2jQheJOkONh+p1y5h0fbIJBJ2V9ODNl372nJyzZRIYJsfycfWsWQv1GT3RLC++V2I
         WJVhswqsv+gB2SR+2VBH1K5USZhCis3m3jUWrcMk=
Date:   Tue, 15 Oct 2019 20:38:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 2/7] rcu: fix tracepoint string when RCU CPU kthread runs
Message-ID: <20191016033814.GX2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191015102402.1978-1-laijs@linux.alibaba.com>
 <20191015102402.1978-3-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015102402.1978-3-laijs@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 10:23:57AM +0000, Lai Jiangshan wrote:
> "rcu_wait" is incorrct here, use "rcu_run" instead.
> 
> Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  kernel/rcu/tree.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 278798e58698..c351fc280945 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2485,7 +2485,7 @@ static void rcu_cpu_kthread(unsigned int cpu)
>  	int spincnt;
>  
>  	for (spincnt = 0; spincnt < 10; spincnt++) {
> -		trace_rcu_utilization(TPS("Start CPU kthread@rcu_wait"));
> +		trace_rcu_utilization(TPS("Start CPU kthread@rcu_run"));
>  		local_bh_disable();
>  		*statusp = RCU_KTHREAD_RUNNING;
>  		local_irq_disable();
> @@ -2496,7 +2496,7 @@ static void rcu_cpu_kthread(unsigned int cpu)
>  			rcu_core();
>  		local_bh_enable();
>  		if (*workp == 0) {
> -			trace_rcu_utilization(TPS("End CPU kthread@rcu_wait"));
> +			trace_rcu_utilization(TPS("End CPU kthread@rcu_run"));

This one needs to stay as it was because this is where we wait when out
of work.

So I took the first hunk and dropped this second hunk.

Please let me know if I am missing something.

							Thanx, Paul

>  			*statusp = RCU_KTHREAD_WAITING;
>  			return;
>  		}
> -- 
> 2.20.1
> 
