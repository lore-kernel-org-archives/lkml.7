Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FE9C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 11:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5545D2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 11:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731574AbfHOL24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 07:28:56 -0400
Received: from mga05.intel.com ([192.55.52.43]:60658 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728128AbfHOL24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 07:28:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 04:28:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="184597668"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Aug 2019 04:28:53 -0700
Subject: Re: [PATCH v3 1/3] mmc: sdhci: Add PLL Enable support to internal
 clock setup
To:     "Michael K. Johnson" <johnsonm@danlj.org>
Cc:     ulf.hansson@linaro.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20190726020746.GB12042@people.danlj.org>
 <acc74e9e-ca41-a5dd-780a-615745d70101@intel.com>
 <20190812225611.GA30758@people.danlj.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <d6432410-6431-efdb-4e28-a601493e4916@intel.com>
Date:   Thu, 15 Aug 2019 14:27:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812225611.GA30758@people.danlj.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/19 1:56 AM, Michael K. Johnson wrote:
> The GL9750 and GL9755 chipsets, and possibly others, require PLL Enable
> setup as part of the internal clock setup as described in 3.2.1 Internal
> Clock Setup Sequence of SD Host Controller Simplified Specification
> Version 4.20.  This changes the timeouts to the new specification of
> 150ms for each step and is documented as safe for "prior versions which
> do not support PLL Enable."
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Co-developed-by: Michael K Johnson <johnsonm@danlj.org>

Did you mean for this patch to be "From:" Ben Chuang because otherwise
"Co-developed-by" the author is redundant.

> Signed-off-by: Michael K Johnson <johnsonm@danlj.org>
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 59acf8e3331e..9106ebc7a422 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1636,8 +1636,8 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
>  	clk |= SDHCI_CLOCK_INT_EN;
>  	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>  
> -	/* Wait max 20 ms */
> -	timeout = ktime_add_ms(ktime_get(), 20);
> +	/* Wait max 150 ms */
> +	timeout = ktime_add_ms(ktime_get(), 150);

Should be a separate patch.

>  	while (1) {
>  		bool timedout = ktime_after(ktime_get(), timeout);
>  
> @@ -1653,6 +1653,29 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
>  		udelay(10);
>  	}
>  
> +	if (host->version >= SDHCI_SPEC_410 && host->v4_mode) {
> +		clk |= SDHCI_CLOCK_PLL_EN;
> +		clk &= ~SDHCI_CLOCK_INT_STABLE;
> +		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +		/* Wait max 150 ms */
> +		timeout = ktime_add_ms(ktime_get(), 150);
> +		while (1) {
> +			bool timedout = ktime_after(ktime_get(), timeout);
> +
> +			clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +			if (clk & SDHCI_CLOCK_INT_STABLE)
> +				break;
> +			if (timedout) {
> +				pr_err("%s: PLL clock never stabilised.\n",
> +				       mmc_hostname(host->mmc));
> +				sdhci_dumpregs(host);
> +				return;
> +			}
> +			udelay(10);
> +		}
> +	}
> +
>  	clk |= SDHCI_CLOCK_CARD_EN;
>  	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>  }
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 199712e7adbb..72601a4d2e95 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -114,6 +114,7 @@
>  #define  SDHCI_DIV_HI_MASK	0x300
>  #define  SDHCI_PROG_CLOCK_MODE	0x0020
>  #define  SDHCI_CLOCK_CARD_EN	0x0004
> +#define  SDHCI_CLOCK_PLL_EN	0x0008
>  #define  SDHCI_CLOCK_INT_STABLE	0x0002
>  #define  SDHCI_CLOCK_INT_EN	0x0001
>  
> 

