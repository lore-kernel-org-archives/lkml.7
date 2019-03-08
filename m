Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4F8C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF94620684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfCHMs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:48:58 -0500
Received: from mga07.intel.com ([134.134.136.100]:4733 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfCHMs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:48:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 04:48:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,455,1544515200"; 
   d="scan'208";a="129923647"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by fmsmga008.fm.intel.com with ESMTP; 08 Mar 2019 04:48:52 -0800
Subject: Re: [PATCH v2 1/3] mmc: sdhci-of-arasan: Add DTS property to disable
 DCMDs.
To:     Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        shawn.lin@rock-chips.com, ulf.hansson@linaro.org
Cc:     Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Lin Huang <hl@rock-chips.com>,
        Tony Xie <tony.xie@rock-chips.com>,
        Randy Li <ayaka@soulik.info>,
        Vicente Bergas <vicencb@gmail.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20190307084329.25416-1-christoph.muellner@theobroma-systems.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <9136f429-251a-87d3-8d6e-bf07c6882c8a@intel.com>
Date:   Fri, 8 Mar 2019 14:47:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190307084329.25416-1-christoph.muellner@theobroma-systems.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/03/19 10:43 AM, Christoph Muellner wrote:
> Direct commands (DCMDs) are an optional feature of eMMC 5.1's command
> queue engine (CQE). The Arasan eMMC 5.1 controller uses the CQHCI,
> which exposes a control register bit to enable the feature.
> The current implementation sets this bit unconditionally.
> 
> This patch allows to suppress the feature activation,
> by specifying the property disable-cqe-dcmd.
> 
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index c9e3e050ccc8..88dc3f00a5be 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -832,7 +832,10 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  		host->mmc_host_ops.start_signal_voltage_switch =
>  					sdhci_arasan_voltage_switch;
>  		sdhci_arasan->has_cqe = true;
> -		host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
> +		host->mmc->caps2 |= MMC_CAP2_CQE;
> +
> +		if (!of_property_read_bool(np, "disable-cqe-dcmd"))
> +			host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;
>  	}
>  
>  	ret = sdhci_arasan_add_host(sdhci_arasan);
> 

