Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63498C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 18:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3892520840
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 18:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388479AbfCASRt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 13:17:49 -0500
Received: from gloria.sntech.de ([185.11.138.130]:58312 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728212AbfCASRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 13:17:49 -0500
Received: from p57b77bb0.dip0.t-ipconnect.de ([87.183.123.176] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gzmis-0005RF-Gk; Fri, 01 Mar 2019 19:17:26 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Christoph Muellner <christoph.muellner@theobroma-systems.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawn.lin@rock-chips.com,
        ulf.hansson@linaro.org, adrian.hunter@intel.com,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Randy Li <ayaka@soulik.info>,
        Tony Xie <tony.xie@rock-chips.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: mmc: Add DTS property to disable DCMDs on Arasan controllers
Date:   Fri, 01 Mar 2019 19:17:25 +0100
Message-ID: <9535423.1mel94qINy@phil>
In-Reply-To: <20190301164349.60589-1-christoph.muellner@theobroma-systems.com>
References: <20190301164349.60589-1-christoph.muellner@theobroma-systems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 1. März 2019, 17:43:45 CET schrieb Christoph Muellner:
> Direct commands (DCMDs) are an optional feature of eMMC 5.1's command
> queue engine (CQE). The Arasan eMMC 5.1 controller uses the CQHCI,
> which exposes a control register bit to enable the feature.
> The current implementation sets this bit unconditionally.
> 
> This patch allows to surpress the feature activation,
> by specifying the property disable-cqe-dcmd.
> 
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>

Patch subject is needs improvement :-) .
I did scratch my head a lot regarding "where is the code change"
until I actually looked into the patch itself, so you probably want

	mmc: sdhci-of-arasan: Add DTS property to disable DCMDs

or similar instead of "dt-bindings: ..." here to match the subsystem.


Heiko

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




