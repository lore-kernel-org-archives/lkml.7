Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49659C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 07:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25B84206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 07:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfKKHp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 02:45:26 -0500
Received: from mga07.intel.com ([134.134.136.100]:26367 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfKKHp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 02:45:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Nov 2019 23:45:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,291,1569308400"; 
   d="scan'208";a="206660971"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.197]) ([10.237.72.197])
  by orsmga003.jf.intel.com with ESMTP; 10 Nov 2019 23:45:21 -0800
Subject: Re: [PATCH v6 4/4] mmc: host: sdhci: Add a variable to defer to
 complete requests if needed
To:     Baolin Wang <baolin.wang@linaro.org>, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang7@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1573456283.git.baolin.wang@linaro.org>
 <119d3285ab610967b43f7c822dfdc0ebb8d521cb.1573456284.git.baolin.wang@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <d4ff481f-1ed9-bd24-db9b-61e0479de12f@intel.com>
Date:   Mon, 11 Nov 2019 09:44:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <119d3285ab610967b43f7c822dfdc0ebb8d521cb.1573456284.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/19 9:34 AM, Baolin Wang wrote:
> When using the host software queue, it will trigger the next request in
> irq handler without a context switch. But the sdhci_request() can not be
> called in interrupt context when using host software queue for some host
> drivers, due to the get_cd() ops can be sleepable.
> 
> But for some host drivers, such as Spreadtrum host driver, the card is
> nonremovable, so the get_cd() ops is not sleepable, which means we can
> complete the data request and trigger the next request in irq handler
> to remove the context switch for the Spreadtrum host driver.
> 
> Thus we still need introduce a variable in struct sdhci_host to indicate
> that we will always to defer to complete requests if the sdhci_request()
> can not be called in interrupt context for some host drivers, when using
> the host software queue.

Sorry, I assumed you would set host->always_defer_done in = true for the
Spreadtrum host driver in patch "mmc: host: sdhci-sprd: Add software queue
support" and put this patch before it.

> 
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c |    2 +-
>  drivers/mmc/host/sdhci.h |    1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 850241f..4bef066 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3035,7 +3035,7 @@ static inline bool sdhci_defer_done(struct sdhci_host *host,
>  {
>  	struct mmc_data *data = mrq->data;
>  
> -	return host->pending_reset ||
> +	return host->pending_reset || host->always_defer_done ||
>  	       ((host->flags & SDHCI_REQ_USE_DMA) && data &&
>  		data->host_cookie == COOKIE_MAPPED);
>  }
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index d89cdb9..a73ce89 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -533,6 +533,7 @@ struct sdhci_host {
>  	bool pending_reset;	/* Cmd/data reset is pending */
>  	bool irq_wake_enabled;	/* IRQ wakeup is enabled */
>  	bool v4_mode;		/* Host Version 4 Enable */
> +	bool always_defer_done;	/* Always defer to complete requests */
>  
>  	struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];	/* Requests done */
>  	struct mmc_command *cmd;	/* Current command */
> 

