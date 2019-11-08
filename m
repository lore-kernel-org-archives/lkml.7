Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437F4FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1501B2178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfKHPRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 10:17:24 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:53337 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfKHPRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 10:17:23 -0500
Received: from localhost (alyon-657-1-975-54.w92-137.abo.wanadoo.fr [92.137.17.54])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 01487100008;
        Fri,  8 Nov 2019 15:17:20 +0000 (UTC)
Date:   Fri, 8 Nov 2019 16:17:20 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     leoyang.li@nxp.com, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] soc: fsl: Enable COMPILE_TEST
Message-ID: <20191108151720.GB216543@piout.net>
References: <20191108130213.23684-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108130213.23684-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/11/2019 21:02:13+0800, YueHaibing wrote:
> When do COMPILE_TEST buiding for RTC_DRV_FSL_FTM_ALARM,
> we get this warning:
> 
> WARNING: unmet direct dependencies detected for FSL_RCPM
>   Depends on [n]: PM_SLEEP [=y] && (ARM || ARM64)
>   Selected by [m]:
>   - RTC_DRV_FSL_FTM_ALARM [=m] && RTC_CLASS [=y] && (ARCH_LAYERSCAPE || SOC_LS1021A || COMPILE_TEST [=y])
> 
> This enable COMPILE_TEST for FSL_RCPM to fix the issue.
> 
> Fixes: e1c2feb1efa2 ("rtc: fsl-ftm-alarm: allow COMPILE_TEST")

I've removed that patch until the fsl maintainers apply this one.

> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> In commit c6c2d36bc46f ("rtc: fsl-ftm-alarm: Fix build error without PM_SLEEP")
> I posted a wrong kconfig warning(which PM_SLEEP is n), sorry for confusion.
> ---
>  drivers/soc/fsl/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
> index 4df32bc..e142662 100644
> --- a/drivers/soc/fsl/Kconfig
> +++ b/drivers/soc/fsl/Kconfig
> @@ -43,7 +43,7 @@ config DPAA2_CONSOLE
>  
>  config FSL_RCPM
>  	bool "Freescale RCPM support"
> -	depends on PM_SLEEP && (ARM || ARM64)
> +	depends on PM_SLEEP && (ARM || ARM64 || COMPILE_TEST)
>  	help
>  	  The NXP QorIQ Processors based on ARM Core have RCPM module
>  	  (Run Control and Power Management), which performs all device-level
> -- 
> 2.7.4
> 
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
