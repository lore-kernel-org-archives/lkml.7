Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB1DC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525342168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571197252;
	bh=DBDLbJTIcpSPn1OJhBMm7f2UB/gktxF5j5aHr/wupAU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=eqGz85ikn+O/UbKtdH48xzxqzmG7nEdFSgIwH6huss8c08es88Im3+ePaKpPF52yc
	 ss75bgTOjN3WDTURneN639tsKlXEQBLHlqMEyVkGrqGdfbYIJiXBh65pVf1ZX5CVqD
	 pldWJES5fpnBx6Zzypvap4HvwpQB/u1c9eokY/Cw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732519AbfJPDkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 23:40:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbfJPDku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 23:40:50 -0400
Received: from paulmck-ThinkPad-P72 (unknown [76.14.14.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63C202086A;
        Wed, 16 Oct 2019 03:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571197249;
        bh=DBDLbJTIcpSPn1OJhBMm7f2UB/gktxF5j5aHr/wupAU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=aDouJLkkIw/uTOzbuyE2DKQ4ori2+pAjwyDFlz8LlKlXWZ4mYC0DQpUprpm/36k+e
         DI7INvPMjTzUG+yDWMoybjV/sDEujllilHikcdiTRisSCwqxWhl1hIAzxYLYZkfpB4
         /iBSQmcQMTytcgf/MswAaycteGb4LzyQxAbTDXAU=
Date:   Tue, 15 Oct 2019 20:40:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     20191015102402.1978-1-laijs@linux.alibaba.com
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 3/7] rcu: trace_rcu_utilization() paired
Message-ID: <20191016034047.GY2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191015102850.2079-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015102850.2079-1-laijs@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 10:28:45AM +0000, Lai Jiangshan wrote:
> The notations include "Start" and "End", it is better
> when there are paired.
> 
> Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  kernel/rcu/tree.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index c351fc280945..7830d5a06e69 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2484,8 +2484,8 @@ static void rcu_cpu_kthread(unsigned int cpu)
>  	char work, *workp = this_cpu_ptr(&rcu_data.rcu_cpu_has_work);
>  	int spincnt;
>  
> +	trace_rcu_utilization(TPS("Start CPU kthread@rcu_run"));
>  	for (spincnt = 0; spincnt < 10; spincnt++) {
> -		trace_rcu_utilization(TPS("Start CPU kthread@rcu_run"));
>  		local_bh_disable();
>  		*statusp = RCU_KTHREAD_RUNNING;
>  		local_irq_disable();

This one is good -- great catch, by the way!

> @@ -2501,6 +2501,7 @@ static void rcu_cpu_kthread(unsigned int cpu)
>  			return;
>  		}
>  	}
> +	trace_rcu_utilization(TPS("End CPU kthread@rcu_run"));
>  	*statusp = RCU_KTHREAD_YIELDING;
>  	trace_rcu_utilization(TPS("Start CPU kthread@rcu_yield"));

But here the addition of "rcu_run" is redundant with the pre-existing
rcu_yield.

So I folded the first hunk into the previous patch and dropped this
one.

As always, please let me know if I am missing something.

							Thanx, Paul

>  	schedule_timeout_interruptible(2);
> -- 
> 2.20.1
> 
