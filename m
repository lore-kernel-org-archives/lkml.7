Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225E4C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CB220857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389466AbfCARco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:32:44 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39652 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728142AbfCARco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:32:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5798E80D;
        Fri,  1 Mar 2019 09:32:43 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B50D3F575;
        Fri,  1 Mar 2019 09:32:41 -0800 (PST)
Date:   Fri, 1 Mar 2019 17:32:39 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] drivers: firmware: psci: Announce support for OS
 initiated suspend mode
Message-ID: <20190301173238.GT15517@lakrids.cambridge.arm.com>
References: <20190228135919.3747-1-ulf.hansson@linaro.org>
 <20190228135919.3747-8-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228135919.3747-8-ulf.hansson@linaro.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 02:59:19PM +0100, Ulf Hansson wrote:
> PSCI firmware v1.0+, supports two different modes for CPU_SUSPEND. The
> Platform Coordinated mode, which is the default and mandatory mode, while
> support for the OS initiated (OSI) mode is optional.
> 
> In some cases it's interesting for the user/developer to know if the OSI
> mode is supported by the PSCI FW. Therefore, let's print a message to the
> log, if that is the case.
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  drivers/firmware/psci/psci.c | 21 ++++++++++++++++++++-
>  include/uapi/linux/psci.h    |  5 +++++
>  2 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index 14d25b54b9f2..417d43886948 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -95,6 +95,11 @@ static inline bool psci_has_ext_power_state(void)
>  				PSCI_1_0_FEATURES_CPU_SUSPEND_PF_MASK;
>  }
>  
> +static inline bool psci_has_osi_support(void)
> +{
> +	return psci_cpu_suspend_feature & PSCI_1_0_OS_INITIATED;
> +}
> +
>  static inline bool psci_power_state_loses_context(u32 state)
>  {
>  	const u32 mask = psci_has_ext_power_state() ?
> @@ -659,10 +664,24 @@ static int __init psci_0_1_init(struct device_node *np)
>  	return 0;
>  }
>  
> +static int __init psci_1_0_init(struct device_node *np)
> +{
> +	int err;
> +
> +	err = psci_0_2_init(np);
> +	if (err)
> +		return err;
> +
> +	if (psci_has_osi_support())
> +		pr_info("OSI mode supported.\n");
> +
> +	return 0;
> +}
> +
>  static const struct of_device_id psci_of_match[] __initconst = {
>  	{ .compatible = "arm,psci",	.data = psci_0_1_init},
>  	{ .compatible = "arm,psci-0.2",	.data = psci_0_2_init},
> -	{ .compatible = "arm,psci-1.0",	.data = psci_0_2_init},
> +	{ .compatible = "arm,psci-1.0",	.data = psci_1_0_init},
>  	{},
>  };
>  
> diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
> index b3bcabe380da..581f72085c33 100644
> --- a/include/uapi/linux/psci.h
> +++ b/include/uapi/linux/psci.h
> @@ -49,6 +49,7 @@
>  
>  #define PSCI_1_0_FN_PSCI_FEATURES		PSCI_0_2_FN(10)
>  #define PSCI_1_0_FN_SYSTEM_SUSPEND		PSCI_0_2_FN(14)
> +#define PSCI_1_0_FN_SET_SUSPEND_MODE		PSCI_0_2_FN(15)
>  
>  #define PSCI_1_0_FN64_SYSTEM_SUSPEND		PSCI_0_2_FN64(14)
>  
> @@ -97,6 +98,10 @@
>  #define PSCI_1_0_FEATURES_CPU_SUSPEND_PF_MASK	\
>  			(0x1 << PSCI_1_0_FEATURES_CPU_SUSPEND_PF_SHIFT)
>  
> +#define PSCI_1_0_OS_INITIATED			BIT(0)
> +#define PSCI_1_0_SUSPEND_MODE_PC		0
> +#define PSCI_1_0_SUSPEND_MODE_OSI		1
> +
>  /* PSCI return values (inclusive of all PSCI versions) */
>  #define PSCI_RET_SUCCESS			0
>  #define PSCI_RET_NOT_SUPPORTED			-1
> -- 
> 2.17.1
> 
