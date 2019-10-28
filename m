Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269C0CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C05208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733189AbfJ1IUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 04:20:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:17624 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729786AbfJ1IUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 04:20:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 01:20:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,239,1569308400"; 
   d="scan'208";a="198017817"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.55]) ([10.237.72.55])
  by fmsmga008.fm.intel.com with ESMTP; 28 Oct 2019 01:20:06 -0700
Subject: Re: [PATCH v4 2/3] mmc: host: sdhci: Add request_done ops for struct
 sdhci_ops
To:     Baolin Wang <baolin.wang@linaro.org>, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang7@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1571722391.git.baolin.wang@linaro.org>
 <487c2e45810c6dc6485638474136e375cb567807.1571722391.git.baolin.wang@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <50696230-75f4-3de4-7424-c33d531ee159@intel.com>
Date:   Mon, 28 Oct 2019 10:19:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <487c2e45810c6dc6485638474136e375cb567807.1571722391.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/19 8:58 AM, Baolin Wang wrote:
> Add request_done ops for struct sdhci_ops as a preparation in case some
> host controllers have different method to complete one request, such as
> supporting request completion of MMC software queue.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c |   12 ++++++++++--
>  drivers/mmc/host/sdhci.h |    2 ++
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index b056400..850241f 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2729,7 +2729,10 @@ static bool sdhci_request_done(struct sdhci_host *host)
>  
>  	spin_unlock_irqrestore(&host->lock, flags);
>  
> -	mmc_request_done(host->mmc, mrq);
> +	if (host->ops->request_done)
> +		host->ops->request_done(host, mrq);

For hsq, couldn't this result in sdhci_request() being called interrupt
context here.

To prevent that you would need to add a condition to sdhci_defer_done() so
it always defers when using hsq.

That would be a separate patch.

> +	else
> +		mmc_request_done(host->mmc, mrq);
>  
>  	return false;
>  }
> @@ -3157,7 +3160,12 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>  
>  	/* Process mrqs ready for immediate completion */
>  	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
> -		if (mrqs_done[i])
> +		if (!mrqs_done[i])
> +			continue;
> +
> +		if (host->ops->request_done)
> +			host->ops->request_done(host, mrqs_done[i]);
> +		else
>  			mmc_request_done(host->mmc, mrqs_done[i]);
>  	}
>  
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0ed3e0e..d89cdb9 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -644,6 +644,8 @@ struct sdhci_ops {
>  	void	(*voltage_switch)(struct sdhci_host *host);
>  	void	(*adma_write_desc)(struct sdhci_host *host, void **desc,
>  				   dma_addr_t addr, int len, unsigned int cmd);
> +	void	(*request_done)(struct sdhci_host *host,
> +				struct mmc_request *mrq);
>  };
>  
>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> 

