Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6952C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 11:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F61920851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 11:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfCHL4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 06:56:49 -0500
Received: from mga14.intel.com ([192.55.52.115]:1168 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbfCHL4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 06:56:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 03:56:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,455,1544515200"; 
   d="scan'208";a="129914297"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by fmsmga008.fm.intel.com with ESMTP; 08 Mar 2019 03:56:42 -0800
Subject: Re: [PATCH V1 03/11] mmc: sdhci: add support for post tuning process
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        riteshh@codeaurora.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, anrao@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
References: <1551504025-3541-1-git-send-email-skomatineni@nvidia.com>
 <1551504025-3541-3-git-send-email-skomatineni@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <d3fa9c16-0561-e708-dec2-12d2526027cd@intel.com>
Date:   Fri, 8 Mar 2019 13:55:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1551504025-3541-3-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/03/19 7:20 AM, Sowjanya Komatineni wrote:
> This patch adds support for post tuning process needed for some hosts
> to perform after successful completion of HW tuning.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/mmc/host/sdhci.c | 6 +++++-
>  drivers/mmc/host/sdhci.h | 1 +
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index e9e919218006..976d4d1e2400 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2392,8 +2392,12 @@ static int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
>  
>  		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>  		if (!(ctrl & SDHCI_CTRL_EXEC_TUNING)) {
> -			if (ctrl & SDHCI_CTRL_TUNED_CLK)
> +			if (ctrl & SDHCI_CTRL_TUNED_CLK) {
> +				if (host->ops->post_tuning)
> +					host->ops->post_tuning(host);
>  				return 0; /* Success! */

I think you can hook .execute_tuning and just check if the return value is
zero before doing post tuning. i.e. something like:

	host->mmc_host_ops.execute_tuning = tegra_sdhci_execute_tuning;

int tegra_sdhci_execute_tuning(blah)
{
	int err;

	err = sdhci_execute_tuning(blah);
	if (!err)
		tegra_sdhci_post_tuning(host);
}

> +			}
> +
>  			break;
>  		}
>  
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index c80e0d6f9b10..236d67778645 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -639,6 +639,7 @@ struct sdhci_ops {
>  	void		(*reset)(struct sdhci_host *host, u8 mask);
>  	int	(*platform_execute_tuning)(struct sdhci_host *host, u32 opcode);
>  	int	(*get_max_tuning_loop_count)(struct sdhci_host *host);
> +	void	(*post_tuning)(struct sdhci_host *host);
>  	void	(*set_uhs_signaling)(struct sdhci_host *host, unsigned int uhs);
>  	void	(*hw_reset)(struct sdhci_host *host);
>  	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
> 

