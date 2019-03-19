Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6E0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FEE213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfCSLJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 07:09:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49618 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbfCSLJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 07:09:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACCA21650;
        Tue, 19 Mar 2019 04:09:52 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E4B53F614;
        Tue, 19 Mar 2019 04:09:50 -0700 (PDT)
Subject: Re: [PATCH v2] mmc: dw_mmc: Fix to avoid potential NULL pointer
 dereference
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>, linux-mmc@vger.kernel.org,
        kjlu@umn.edu, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-rockchip@lists.infradead.org, Kukjin Kim <kgene@kernel.org>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20190319014551.16559-1-pakki001@umn.edu>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f3363524-f764-6652-9b16-3a8b0d30e6df@arm.com>
Date:   Tue, 19 Mar 2019 11:09:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190319014551.16559-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2019 01:45, Aditya Pakki wrote:
> of_match_node can fail and return NULL in case no matching structure.
> The patches checks for such a scenario and returns -ENXIO.

FWIW, it looks like most of these instances could be cleaned up even 
more with of_device_get_match_data().

In general, do bear in mind that adding these NULL checks *everywhere* 
will in many cases just amount to useless dead code - a pure DT-based 
driver can usually freely assume of_match_node() returns non-NULL for 
its own device and match table in its probe routine, because that probe 
routine only ever gets called if of_driver_match_device() has already 
made the same match in the first place.

Robin.

> ---
> V1: Added files dw_mmc-zx.c and dw_mmc-rockchip.c
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>   drivers/mmc/host/dw_mmc-exynos.c   | 2 ++
>   drivers/mmc/host/dw_mmc-k3.c       | 2 ++
>   drivers/mmc/host/dw_mmc-pltfm.c    | 2 ++
>   drivers/mmc/host/dw_mmc-rockchip.c | 2 ++
>   drivers/mmc/host/dw_mmc-zx.c       | 2 ++
>   5 files changed, 10 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index d46c3439b508..8a75d7314606 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -554,6 +554,8 @@ static int dw_mci_exynos_probe(struct platform_device *pdev)
>   	int ret;
>   
>   	match = of_match_node(dw_mci_exynos_match, pdev->dev.of_node);
> +	if (!match)
> +		return -ENXIO;
>   	drv_data = match->data;
>   
>   	pm_runtime_get_noresume(&pdev->dev);
> diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
> index 89cdb3d533bb..cc50b7546a20 100644
> --- a/drivers/mmc/host/dw_mmc-k3.c
> +++ b/drivers/mmc/host/dw_mmc-k3.c
> @@ -459,6 +459,8 @@ static int dw_mci_k3_probe(struct platform_device *pdev)
>   	const struct of_device_id *match;
>   
>   	match = of_match_node(dw_mci_k3_match, pdev->dev.of_node);
> +	if (!match)
> +		return -ENXIO;
>   	drv_data = match->data;
>   
>   	return dw_mci_pltfm_register(pdev, drv_data);
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
> index 58c13e21bd5a..b1948989f617 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -82,6 +82,8 @@ static int dw_mci_pltfm_probe(struct platform_device *pdev)
>   
>   	if (pdev->dev.of_node) {
>   		match = of_match_node(dw_mci_pltfm_match, pdev->dev.of_node);
> +		if (!match)
> +			return -ENXIO;
>   		drv_data = match->data;
>   	}
>   
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> index 8c86a800a8fd..20e3471260ea 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -344,6 +344,8 @@ static int dw_mci_rockchip_probe(struct platform_device *pdev)
>   		return -ENODEV;
>   
>   	match = of_match_node(dw_mci_rockchip_match, pdev->dev.of_node);
> +	if (!match)
> +		return -ENXIO;
>   	drv_data = match->data;
>   
>   	pm_runtime_get_noresume(&pdev->dev);
> diff --git a/drivers/mmc/host/dw_mmc-zx.c b/drivers/mmc/host/dw_mmc-zx.c
> index c06b5393312f..abea35431045 100644
> --- a/drivers/mmc/host/dw_mmc-zx.c
> +++ b/drivers/mmc/host/dw_mmc-zx.c
> @@ -213,6 +213,8 @@ static int dw_mci_zx_probe(struct platform_device *pdev)
>   	const struct of_device_id *match;
>   
>   	match = of_match_node(dw_mci_zx_match, pdev->dev.of_node);
> +	if (!match)
> +		return -ENXIO;
>   	drv_data = match->data;
>   
>   	return dw_mci_pltfm_register(pdev, drv_data);
> 
