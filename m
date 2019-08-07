Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BBFC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 09:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD24321883
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 09:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbfHGJHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 05:07:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:26308 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726881AbfHGJHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 05:07:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 02:07:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,357,1559545200"; 
   d="scan'208";a="176131076"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by fmsmga007.fm.intel.com with ESMTP; 07 Aug 2019 02:07:05 -0700
Subject: Re: [PATCH v2 1/2] mmc: sdhci: Add PLL Enable support to internal
 clock setup
To:     "Michael K. Johnson" <johnsonm@danlj.org>, ulf.hansson@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20190726020746.GB12042@people.danlj.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <acc74e9e-ca41-a5dd-780a-615745d70101@intel.com>
Date:   Wed, 7 Aug 2019 12:05:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726020746.GB12042@people.danlj.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/19 5:07 AM, Michael K. Johnson wrote:
> The GL9750 and GL9755 chipsets, and possibly others, require PLL Enable
> setup as part of the internal clock setup as described in 3.2.1 Internal
> Clock Setup Sequence of SD Host Controller Simplified Specification
> Version 4.20.  This changes the timeouts to the new specification of
> 150ms for each step and is documented as safe for "prior versions which
> do not support PLL Enable."
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
> Signed-off-by: Michael K Johnson <johnsonm@danlj.org>
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 59acf8e3331e..14957578bf2e 100644
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
>  	while (1) {
>  		bool timedout = ktime_after(ktime_get(), timeout);
>  
> @@ -1650,7 +1650,28 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
>  			sdhci_dumpregs(host);
>  			return;
>  		}
> -		udelay(10);
> +		usleep_range(10,15);

There is still one place that calls ->set_clock() under spinlock, so that
needs to stay udelay(10) for now.

> +	}
> +

PLL Enable is only valid from v4.1 i.e.

	if (host->version >= SDHCI_SPEC_410 && host->v4_mode)


> +	clk |= SDHCI_CLOCK_PLL_EN;
> +	clk &= ~SDHCI_CLOCK_INT_STABLE;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +	/* Wait max 150 ms */
> +	timeout = ktime_add_ms(ktime_get(), 150);
> +	while (1) {
> +		bool timedout = ktime_after(ktime_get(), timeout);
> +
> +		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +		if (clk & SDHCI_CLOCK_INT_STABLE)
> +			break;
> +		if (timedout) {
> +			pr_err("%s: PLL clock never stabilised.\n",
> +			       mmc_hostname(host->mmc));
> +			sdhci_dumpregs(host);
> +			return;
> +		}
> +		usleep_range(10,15);
>  	}
>  
>  	clk |= SDHCI_CLOCK_CARD_EN;
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

