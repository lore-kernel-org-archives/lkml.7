Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B946C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7722C215EA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfH2NUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 09:20:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:38061 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbfH2NUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:20:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 06:20:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,443,1559545200"; 
   d="scan'208";a="197804381"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.66]) ([10.237.72.66])
  by fmsmga001.fm.intel.com with ESMTP; 29 Aug 2019 06:20:38 -0700
Subject: Re: [PATCH v2] mmc: sdhci: use lower/upper_32_bits() macros for DMA
 addresses
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Piotr Sroka <piotrs@cadence.com>, linux-kernel@vger.kernel.org
References: <20190829112206.22213-1-yamada.masahiro@socionext.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <20e6bfc4-b56a-780f-2dd8-d80af1fd1947@intel.com>
Date:   Thu, 29 Aug 2019 16:19:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829112206.22213-1-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/19 2:22 PM, Masahiro Yamada wrote:
> Currently, the DMA addresses are casted to (u64) for the upper 32bits
> to avoid "right shift count >= width of type" warning.
> 
> <linux/kernel.h> provides macros to address this, and I like the macro
> names are self-documenting.
> 
> I introduced a new helper, sdhci_set_adma_addr() to avoid the code
> duplication.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Even better, thanks!

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
> Changes in v2:
>   - Another way to reduce linu wrapping
> 
>  drivers/mmc/host/sdhci.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 08cc0792c174..66c2cf89ee22 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -668,10 +668,10 @@ void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
>  	/* 32-bit and 64-bit descriptors have these members in same position */
>  	dma_desc->cmd = cpu_to_le16(cmd);
>  	dma_desc->len = cpu_to_le16(len);
> -	dma_desc->addr_lo = cpu_to_le32((u32)addr);
> +	dma_desc->addr_lo = cpu_to_le32(lower_32_bits(addr));
>  
>  	if (host->flags & SDHCI_USE_64_BIT_DMA)
> -		dma_desc->addr_hi = cpu_to_le32((u64)addr >> 32);
> +		dma_desc->addr_hi = cpu_to_le32(upper_32_bits(addr));
>  
>  	*desc += host->desc_sz;
>  }
> @@ -816,6 +816,13 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
>  	}
>  }
>  
> +static void sdhci_set_adma_addr(struct sdhci_host *host, dma_addr_t addr)
> +{
> +	sdhci_writel(host, lower_32_bits(addr), SDHCI_ADMA_ADDRESS);
> +	if (host->flags & SDHCI_USE_64_BIT_DMA)
> +		sdhci_writel(host, upper_32_bits(addr), SDHCI_ADMA_ADDRESS_HI);
> +}
> +
>  static dma_addr_t sdhci_sdma_address(struct sdhci_host *host)
>  {
>  	if (host->bounce_buffer)
> @@ -826,13 +833,10 @@ static dma_addr_t sdhci_sdma_address(struct sdhci_host *host)
>  
>  static void sdhci_set_sdma_addr(struct sdhci_host *host, dma_addr_t addr)
>  {
> -	if (host->v4_mode) {
> -		sdhci_writel(host, addr, SDHCI_ADMA_ADDRESS);
> -		if (host->flags & SDHCI_USE_64_BIT_DMA)
> -			sdhci_writel(host, (u64)addr >> 32, SDHCI_ADMA_ADDRESS_HI);
> -	} else {
> +	if (host->v4_mode)
> +		sdhci_set_adma_addr(host, addr);
> +	else
>  		sdhci_writel(host, addr, SDHCI_DMA_ADDRESS);
> -	}
>  }
>  
>  static unsigned int sdhci_target_timeout(struct sdhci_host *host,
> @@ -1095,12 +1099,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>  			host->flags &= ~SDHCI_REQ_USE_DMA;
>  		} else if (host->flags & SDHCI_USE_ADMA) {
>  			sdhci_adma_table_pre(host, data, sg_cnt);
> -
> -			sdhci_writel(host, host->adma_addr, SDHCI_ADMA_ADDRESS);
> -			if (host->flags & SDHCI_USE_64_BIT_DMA)
> -				sdhci_writel(host,
> -					     (u64)host->adma_addr >> 32,
> -					     SDHCI_ADMA_ADDRESS_HI);
> +			sdhci_set_adma_addr(host, host->adma_addr);
>  		} else {
>  			WARN_ON(sg_cnt != 1);
>  			sdhci_set_sdma_addr(host, sdhci_sdma_address(host));
> 

