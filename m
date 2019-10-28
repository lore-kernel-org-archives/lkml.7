Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287AACA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF8521783
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G4fNPx62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbfJ1PYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 11:24:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59184 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfJ1PYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wzqTOdWSiprs38KOBFUNMMK0k7THK4/IC0X8dH0u1NU=; b=G4fNPx62fbipN9nDeu/f5s+nf
        NO9yIj1UogFJcWkqtEoEVuHEP99H6z4UqZzHCeRm4yzyDFFtx+o8AUM1jk38olV09nmG+1HpQuU0M
        u3ckNys0R3GUjOeRr7/WuOjSrJSgoNyCFaoM70BHS5RdLfmYZsuMKPhjXjfnpeOg0pVzroWmYb739
        lDIwdLRnMxIebG1q+zilSjzZwaTHKBEoEnudyMDWl2XzLC+yFDpYJA3e/TSgmFiAFQksNu7a/TZsg
        DxwIEU6vlRsKe55yeA5emFh9LvlXowxWfQLXIHOsyhNt/1D4cpH6XRTjp6aj0/qRg+x7drkVmhxWt
        /EKOBBs9w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iP6sY-0002o9-RT; Mon, 28 Oct 2019 15:24:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 485A13040CB;
        Mon, 28 Oct 2019 16:23:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 760212B4468C9; Mon, 28 Oct 2019 16:24:21 +0100 (CET)
Date:   Mon, 28 Oct 2019 16:24:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, qperret@google.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: Re: [Patch v4 3/6] sched/fair: Enable CFS periodic tick to update
 thermal pressure
Message-ID: <20191028152421.GD4097@hirez.programming.kicks-ass.net>
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
 <1571776465-29763-4-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571776465-29763-4-git-send-email-thara.gopinath@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 04:34:22PM -0400, Thara Gopinath wrote:
> Introduce support in CFS periodic tick to trigger the process of
> computing average thermal pressure for a cpu.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  kernel/sched/fair.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 682a754..4f9c2cb 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -21,6 +21,7 @@
>   *  Copyright (C) 2007 Red Hat, Inc., Peter Zijlstra
>   */
>  #include "sched.h"
> +#include "thermal.h"
>  
>  #include <trace/events/sched.h>
>  
> @@ -7574,6 +7575,8 @@ static void update_blocked_averages(int cpu)
>  		done = false;
>  
>  	update_blocked_load_status(rq, !done);
> +
> +	trigger_thermal_pressure_average(rq);
>  	rq_unlock_irqrestore(rq, &rf);
>  }

This changes only 1 of the 2 implementations of
update_blocked_averages(). Also, how does this interact with
rq->has_blocked_load ?

> @@ -9933,6 +9936,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>  
>  	update_misfit_status(curr, rq);
>  	update_overutilized_status(task_rq(curr));
> +
> +	trigger_thermal_pressure_average(rq);
>  }

This seems to imply all this thermal stuff is fair only, in which case I
could suggest putting those few lines in fair.c. ~45 extra lines on
1e5+ lines really doesn't matter.
