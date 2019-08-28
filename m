Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5594EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD2D2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfH1Kuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:50:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:54973 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfH1Kuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:50:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 03:50:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,440,1559545200"; 
   d="scan'208";a="181997044"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.66]) ([10.237.72.66])
  by fmsmga007.fm.intel.com with ESMTP; 28 Aug 2019 03:50:43 -0700
Subject: Re: [PATCH V6 4/5] mmc: sdhci: Export sdhci_abort_tuning function
 symbol
To:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw
References: <20190827003322.2445-1-benchuanggli@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ecd70199-d3c9-b92d-493e-b49e23e6d91c@intel.com>
Date:   Wed, 28 Aug 2019 13:49:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827003322.2445-1-benchuanggli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/08/19 3:33 AM, Ben Chuang wrote:
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> 
> Export sdhci_abort_tuning() function symbols which are used by other SD Host
> controller driver modules.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
> Signed-off-by: Michael K Johnson <johnsonm@danlj.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 3 ++-
>  drivers/mmc/host/sdhci.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 9106ebc7a422..0f2f110534db 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2328,7 +2328,7 @@ void sdhci_reset_tuning(struct sdhci_host *host)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_reset_tuning);
>  
> -static void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode)
> +void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode)
>  {
>  	sdhci_reset_tuning(host);
>  
> @@ -2339,6 +2339,7 @@ static void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode)
>  
>  	mmc_abort_tuning(host->mmc, opcode);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_abort_tuning);
>  
>  /*
>   * We use sdhci_send_tuning() because mmc_send_tuning() is not a good fit. SDHCI
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 72601a4d2e95..437bab3af195 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -797,5 +797,6 @@ void sdhci_start_tuning(struct sdhci_host *host);
>  void sdhci_end_tuning(struct sdhci_host *host);
>  void sdhci_reset_tuning(struct sdhci_host *host);
>  void sdhci_send_tuning(struct sdhci_host *host, u32 opcode);
> +void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode);
>  
>  #endif /* __SDHCI_HW_H */
> 

