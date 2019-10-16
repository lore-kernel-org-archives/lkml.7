Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FE0ECE59D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D31F2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571213177;
	bh=ULxWxdAcTuFv0r9XFK5unvh1UhCWUCjT+N+FdMDZkiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Pk4tNT1o96Yb2AJIhRWstaS9jJDp5MR4O/MzSdsphaw5PzYwrz2C4Wm35c/PvkWaZ
	 4Qx/KDZHdrdtXpGu7Esa+izT+xmb8Sw7kcyM4AHn3a4Qvv0uHoo/OQxyq9/UfHV78P
	 8GMepTaT1Zd6FNSF1pB1ZN7ZmaCfAFrDRV+pnV9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404046AbfJPIGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:06:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388733AbfJPIGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:06:15 -0400
Received: from localhost (unknown [171.76.123.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4519E20650;
        Wed, 16 Oct 2019 08:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571213175;
        bh=ULxWxdAcTuFv0r9XFK5unvh1UhCWUCjT+N+FdMDZkiI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aYJcH+jghu4SsAyCK/ysYaa/1+B6G1abNBYHIc7qHCoFNltm6aNS/+LRguSfHc5uB
         MKoxw22mhR9Yk+e8H9gkIIn3Gr1vnIPmi/kYgCOOwV+XZrWQGzzikTDPRXYOf2YUiJ
         wHW1Hnw3M1ZlGIoV5pow6OcYhynrU+Hxtw/3Dqpw=
Date:   Wed, 16 Oct 2019 13:36:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Maxime Ripard <mripard@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: Enable Qualcomm pseudo rng
Message-ID: <20191016080607.GH2654@vkoul-mobl>
References: <20191011235035.374569-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011235035.374569-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-10-19, 16:50, Bjorn Andersson wrote:
> Most Qualcomm platforms contain a pseudo random number generator
> hardware block. Enable the driver for this block.

This enabled and loads the driver, but doesn't enable the usage.

We also need CONFIG_CRYPTO_RNG2 but that gets selected so that part is
fine. For userspace we need CONFIG_CRYPTO_USER_API_RNG to be added so
that kernel exports interface to users. So can you add that as well.

Thanks
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index a5953b0b382d..688c8f200034 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -855,6 +855,7 @@ CONFIG_NLS_ISO8859_1=y
>  CONFIG_SECURITY=y
>  CONFIG_CRYPTO_ECHAINIV=y
>  CONFIG_CRYPTO_ANSI_CPRNG=y
> +CONFIG_CRYPTO_DEV_QCOM_RNG=m
>  CONFIG_DMA_CMA=y
>  CONFIG_CMA_SIZE_MBYTES=32
>  CONFIG_PRINTK_TIME=y
> -- 
> 2.23.0

-- 
~Vinod
