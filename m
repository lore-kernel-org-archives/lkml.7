Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1BFCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8793B208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BHZDurOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389734AbfJ1Pm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 11:42:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59360 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfJ1Pm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Y9FSTf7Pat5WWzPypxPIrhd4tE/BrFztAPkC/CBMzFk=; b=BHZDurOtErHBKB2DAcyrHqi5L
        6/neIbxbmxrz9jPSfWQz2z1WDDoxI1OlZ5sFtaQpT/40FR7GAylGq3cfBglhSVDySz79zVrHkI4Xl
        4ei0vvZVpP5Jgp/dd8oi7WXPI88oMH259hdL95lx6gGO6tVAznOd2zK0fm2cYJ0y91bUmq7ediqhH
        Roent3/QBbA/JaHgOp5PMMRBqsUbMQ4npfkFaBlfqBtNNO5nQm5vt01DevpO/mcq/S2DwaL/Dsxe2
        fmx7sgXUGwyVjjnALnqbVj8tAtQf56LXgF2RmK5MY1Ne0UojHb0oze7bEOpsJ9KPGMBA+S2w1ixTu
        1bjKjoLDA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iP79o-0003Jw-DW; Mon, 28 Oct 2019 15:42:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5201D300E4D;
        Mon, 28 Oct 2019 16:41:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8823C2B4468CD; Mon, 28 Oct 2019 16:42:10 +0100 (CET)
Date:   Mon, 28 Oct 2019 16:42:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, qperret@google.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: Re: [Patch v4 6/6] sched: thermal: Enable tuning of decay period
Message-ID: <20191028154210.GG4097@hirez.programming.kicks-ass.net>
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
 <1571776465-29763-7-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571776465-29763-7-git-send-email-thara.gopinath@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 04:34:25PM -0400, Thara Gopinath wrote:
> Thermal pressure follows pelt signas which means the
> decay period for thermal pressure is the default pelt
> decay period. Depending on soc charecteristics and thermal
> activity, it might be beneficial to decay thermal pressure
> slower, but still in-tune with the pelt signals.
> One way to achieve this is to provide a command line parameter
> to set the decay coefficient to an integer between 0 and 10.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
> v3->v4:
> 	- Removed the sysctl setting to tune decay period and instead
> 	  introduced a command line parameter to control it. The rationale
> 	  here being changing decay period of a PELT signal runtime can
> 	  result in a skewed average value for atleast some cycles.

TBH, I don't care too much about that. If you touch a knob, you'd better
know what it does anyway.

>  void trigger_thermal_pressure_average(struct rq *rq)
>  {
> -	update_thermal_load_avg(rq_clock_task(rq), rq,
> +	update_thermal_load_avg(rq_clock_task(rq) >>
> +				sched_thermal_decay_coeff, rq,

You see, 'coefficient' means 'multiplicative factor', but what we have
here is a negative exponent. More specifically it is a power-of-2
exponent, and we typically call them '_shift', given how we use them
with 'shift' operators.
