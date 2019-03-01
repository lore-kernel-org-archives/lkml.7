Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CAEC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A0D20848
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389380AbfCARH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:07:27 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39312 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389305AbfCARH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:07:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 121DB80D;
        Fri,  1 Mar 2019 09:07:26 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44B0D3F575;
        Fri,  1 Mar 2019 09:07:24 -0800 (PST)
Date:   Fri, 1 Mar 2019 17:07:21 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] drivers: firmware: psci: Split
 psci_dt_cpu_init_idle()
Message-ID: <20190301170721.GQ15517@lakrids.cambridge.arm.com>
References: <20190228135919.3747-1-ulf.hansson@linaro.org>
 <20190228135919.3747-4-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228135919.3747-4-ulf.hansson@linaro.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 02:59:15PM +0100, Ulf Hansson wrote:
> Let's split the psci_dt_cpu_init_idle() function into two functions. This
> makes the code clearer and provides better re-usability.
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  drivers/firmware/psci/psci.c | 42 ++++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index c80ec1d03274..9788bfc1cf8b 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -270,9 +270,26 @@ static int __init psci_features(u32 psci_func_id)
>  #ifdef CONFIG_CPU_IDLE
>  static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
>  
> +static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
> +{
> +	int err = of_property_read_u32(np, "arm,psci-suspend-param", state);
> +
> +	if (err) {
> +		pr_warn("%pOF missing arm,psci-suspend-param property\n", np);
> +		return err;
> +	}
> +
> +	if (!psci_power_state_is_valid(*state)) {
> +		pr_warn("Invalid PSCI power state %#x\n", *state);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
>  {
> -	int i, ret, count = 0;
> +	int i, ret = 0, count = 0;
>  	u32 *psci_states;
>  	struct device_node *state_node;
>  
> @@ -291,29 +308,16 @@ static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
>  		return -ENOMEM;
>  
>  	for (i = 0; i < count; i++) {
> -		u32 state;
> -
>  		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
> +		ret = psci_dt_parse_state_node(state_node, &psci_states[i]);
> +		of_node_put(state_node);
>  
> -		ret = of_property_read_u32(state_node,
> -					   "arm,psci-suspend-param",
> -					   &state);
> -		if (ret) {
> -			pr_warn(" * %pOF missing arm,psci-suspend-param property\n",
> -				state_node);
> -			of_node_put(state_node);
> +		if (ret)
>  			goto free_mem;
> -		}
>  
> -		of_node_put(state_node);
> -		pr_debug("psci-power-state %#x index %d\n", state, i);
> -		if (!psci_power_state_is_valid(state)) {
> -			pr_warn("Invalid PSCI power state %#x\n", state);
> -			ret = -EINVAL;
> -			goto free_mem;
> -		}
> -		psci_states[i] = state;
> +		pr_debug("psci-power-state %#x index %d\n", psci_states[i], i);
>  	}
> +
>  	/* Idle states parsed correctly, initialize per-cpu pointer */
>  	per_cpu(psci_power_state, cpu) = psci_states;
>  	return 0;
> -- 
> 2.17.1
> 
