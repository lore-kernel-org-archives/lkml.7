Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31013C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05AEC24278
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfFCMfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:35:54 -0400
Received: from mga14.intel.com ([192.55.52.115]:64545 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfFCMfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:35:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 05:35:53 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by orsmga005.jf.intel.com with ESMTP; 03 Jun 2019 05:35:49 -0700
Subject: Re: [PATCH 4/9] mmc: sdhci-sprd: Implement the
 get_max_timeout_count() interface
To:     Baolin Wang <baolin.wang@linaro.org>, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc:     vincent.guittot@linaro.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1558346019.git.baolin.wang@linaro.org>
 <ae6e23d4de6bb25cd697412f1402036d5ecc9843.1558346019.git.baolin.wang@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ed5bdd08-7227-4d55-23de-e78e15d315c7@intel.com>
Date:   Mon, 3 Jun 2019 15:34:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ae6e23d4de6bb25cd697412f1402036d5ecc9843.1558346019.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/19 1:11 PM, Baolin Wang wrote:
> Implement the get_max_timeout_count() interface to set the Spredtrum SD
> host controller actual maximum timeout count.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Seems surprising that there isn't a custom ->set_timeout() as well.
Nevertheless:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-sprd.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 31ba7d6..d91281d 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -285,6 +285,12 @@ static void sdhci_sprd_hw_reset(struct sdhci_host *host)
>  	usleep_range(300, 500);
>  }
>  
> +static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
> +{
> +	/* The Spredtrum controller actual maximum timeout count is 1 << 31 */
> +	return 1 << 31;
> +}
> +
>  static struct sdhci_ops sdhci_sprd_ops = {
>  	.read_l = sdhci_sprd_readl,
>  	.write_l = sdhci_sprd_writel,
> @@ -296,6 +302,7 @@ static void sdhci_sprd_hw_reset(struct sdhci_host *host)
>  	.reset = sdhci_reset,
>  	.set_uhs_signaling = sdhci_sprd_set_uhs_signaling,
>  	.hw_reset = sdhci_sprd_hw_reset,
> +	.get_max_timeout_count = sdhci_sprd_get_max_timeout_count,
>  };
>  
>  static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
> 

