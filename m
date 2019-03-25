Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26316C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB87420850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbfCYK07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:26:59 -0400
Received: from mga04.intel.com ([192.55.52.120]:60920 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730361AbfCYK06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:26:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 03:26:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="134505566"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by fmsmga008.fm.intel.com with ESMTP; 25 Mar 2019 03:26:55 -0700
Subject: Re: [PATCH V4 02/10] mmc: sdhci: allow host to specify maximum tuning
 loops
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        riteshh@codeaurora.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, anrao@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
References: <1553402727-23130-1-git-send-email-skomatineni@nvidia.com>
 <1553402727-23130-2-git-send-email-skomatineni@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <a8372001-b4e9-3003-1213-2f652984e701@intel.com>
Date:   Mon, 25 Mar 2019 12:25:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <1553402727-23130-2-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/19 6:45 AM, Sowjanya Komatineni wrote:
> As per the Host Controller Standard Specification Version 4.20,
> limitation of tuning iteration count is removed as PLL locking
> time can be longer than UHS-1 tuning due to larger PVT fluctuation
> and it will result in increase of tuning iteration to complete the
> tuning.
> 
> This patch creates sdhci_host member tuning_loop_count to allow
> hosts to specify maximum tuning iterations and also updates
> execute_tuning to use this specified maximum tuning iteration count.
> 
> Default tuning_loop_count is set to same as existing loop count of
> MAX_TUNING_LOOP which is 40 iterations.
> 
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 5 +++--
>  drivers/mmc/host/sdhci.h | 1 +
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a8141ff9be03..bbc0e0bb7128 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2369,9 +2369,9 @@ static int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
>  
>  	/*
>  	 * Issue opcode repeatedly till Execute Tuning is set to 0 or the number
> -	 * of loops reaches 40 times.
> +	 * of loops reaches tuning loop count.
>  	 */
> -	for (i = 0; i < MAX_TUNING_LOOP; i++) {
> +	for (i = 0; i < host->tuning_loop_count; i++) {
>  		u16 ctrl;
>  
>  		sdhci_send_tuning(host, opcode);
> @@ -3494,6 +3494,7 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
>  	host->cqe_err_ier = SDHCI_CQE_INT_ERR_MASK;
>  
>  	host->tuning_delay = -1;
> +	host->tuning_loop_count = MAX_TUNING_LOOP;
>  
>  	host->sdma_boundary = SDHCI_DEFAULT_BOUNDARY_ARG;
>  
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 01002cba1359..57bb3e3dca89 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -596,6 +596,7 @@ struct sdhci_host {
>  #define SDHCI_TUNING_MODE_3	2
>  	/* Delay (ms) between tuning commands */
>  	int			tuning_delay;
> +	int			tuning_loop_count;
>  
>  	/* Host SDMA buffer boundary. */
>  	u32			sdma_boundary;
> 

