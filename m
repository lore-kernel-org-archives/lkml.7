Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BFFC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E2A20818
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389442AbfCAR2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:28:18 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39500 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728274AbfCAR2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:28:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F032680D;
        Fri,  1 Mar 2019 09:28:14 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E1A03F575;
        Fri,  1 Mar 2019 09:28:13 -0800 (PST)
Date:   Fri, 1 Mar 2019 17:28:10 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] drivers: firmware: psci: Simplify state node parsing
Message-ID: <20190301172810.GR15517@lakrids.cambridge.arm.com>
References: <20190228135919.3747-1-ulf.hansson@linaro.org>
 <20190228135919.3747-6-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228135919.3747-6-ulf.hansson@linaro.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 02:59:17PM +0100, Ulf Hansson wrote:
> Instead of iterating through all the state nodes in DT, to find out how
> many states that needs to be allocated, let's use the number already known
> by the cpuidle driver. In this way we can drop the iteration altogether.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/firmware/psci/psci.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index d50b46a0528f..cbfc936d251c 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -290,26 +290,20 @@ static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
>  static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
>  			struct device_node *cpu_node, int cpu)
>  {
> -	int i, ret = 0, count = 0;
> +	int i, ret = 0, num_state_nodes = drv->state_count - 1;
>  	u32 *psci_states;
>  	struct device_node *state_node;
>  
> -	/* Count idle states */
> -	while ((state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
> -					      count))) {
> -		count++;
> -		of_node_put(state_node);
> -	}
> -

To be honest, I'd rather not tighten the coupling with the cpuidle
driver here. For example, I'm not that happy with the PSCI backend
having to know the driver has a specific WFI state.

IIUC we could get rid of the explicit counting with something like:

	count = of_parse_phandle_with_args(cpu_node, "cpu-idle-states", NULL);

... but I'm not sure that the overall change is a simplification.

Does this change make it easier to plumb in something in future?

Thanks,
Mark.

> -	if (!count)
> -		return -ENODEV;
> -
> -	psci_states = kcalloc(count, sizeof(*psci_states), GFP_KERNEL);
> +	psci_states = kcalloc(num_state_nodes, sizeof(*psci_states),
> +			GFP_KERNEL);
>  	if (!psci_states)
>  		return -ENOMEM;
>  
> -	for (i = 0; i < count; i++) {
> +	for (i = 0; i < num_state_nodes; i++) {
>  		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
> +		if (!state_node)
> +			break;
> +
>  		ret = psci_dt_parse_state_node(state_node, &psci_states[i]);
>  		of_node_put(state_node);
>  
> @@ -319,6 +313,11 @@ static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
>  		pr_debug("psci-power-state %#x index %d\n", psci_states[i], i);
>  	}
>  
> +	if (i != num_state_nodes) {
> +		ret = -ENODEV;
> +		goto free_mem;
> +	}
> +
>  	/* Idle states parsed correctly, initialize per-cpu pointer */
>  	per_cpu(psci_power_state, cpu) = psci_states;
>  	return 0;
> -- 
> 2.17.1
> 
