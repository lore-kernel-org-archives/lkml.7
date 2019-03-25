Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8F4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C90F20830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbfCYMVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:21:22 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56424 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729831AbfCYMVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:21:22 -0400
Received: from 79.184.253.239.ipv4.supernova.orange.pl (79.184.253.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id db5a24e253bd52a7; Mon, 25 Mar 2019 13:21:18 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-pm@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 3/4] cpuidle: Export the next timer/tick expiration for a CPU
Date:   Mon, 25 Mar 2019 13:19:22 +0100
Message-ID: <2942111.nn8VVVUCAL@aspire.rjw.lan>
In-Reply-To: <20190227195836.24739-4-ulf.hansson@linaro.org>
References: <20190227195836.24739-1-ulf.hansson@linaro.org> <20190227195836.24739-4-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, February 27, 2019 8:58:35 PM CET Ulf Hansson wrote:
> To be able to predict the sleep duration for a CPU that is entering idle,
> knowing when the next timer/tick is going to expire, is extremely useful.
> Both the teo and the menu cpuidle governors already makes use of this
> information, while selecting an idle state.
> 
> Moving forward, the similar prediction needs to be done, but for a group of
> idle CPUs rather than for a single idle CPU. Following changes implements a
> new genpd governor, which needs this.
> 
> Support this, by sharing a new function called
> tick_nohz_get_next_hrtimer(), which returns the next hrtimer or the next
> tick, whatever that expires first.
> 
> Additionally, when cpuidle is about to invoke the ->enter() callback, then
> call tick_nohz_get_next_hrtimer() and store its return value in the per CPU
> struct cpuidle_device, as to make it available outside cpuidle.
> 
> Do note, at the point when cpuidle calls tick_nohz_get_next_hrtimer(), the
> governor's ->select() callback has already made a decision whether to stop
> the tick or not. In this way, tick_nohz_get_next_hrtimer() actually returns
> the next timer expiration, whatever origin.
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v12:
> 	- New patch.
> 
> ---
>  drivers/cpuidle/cpuidle.c |  8 ++++++++
>  include/linux/cpuidle.h   |  1 +
>  include/linux/tick.h      |  7 ++++++-
>  kernel/time/tick-sched.c  | 12 ++++++++++++
>  4 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 7f108309e871..255365b1a6ab 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -328,6 +328,14 @@ int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  int cpuidle_enter(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  		  int index)
>  {
> +	/*
> +	 * Store the next hrtimer, which becomes either next tick or the next
> +	 * timer event, whatever expires first. Additionally, to make this data
> +	 * useful for consumers outside cpuidle, we rely on that the governor's
> +	 * ->select() callback have decided, whether to stop the tick or not.
> +	 */
> +	dev->next_hrtimer = tick_nohz_get_next_hrtimer();

I would use WRITE_ONCE() to set next_hrtimer here and READ_ONCE() for
reading that value in the next patch, as a matter of annotation if
nothing else.

> +
>  	if (cpuidle_state_is_coupled(drv, index))
>  		return cpuidle_enter_state_coupled(dev, drv, index);
>  	return cpuidle_enter_state(dev, drv, index);

Also I would clear next_hrtimer here to avoid dragging stale values
around.

Apart from this the series LGTM.

Thanks!

