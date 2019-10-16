Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F8AC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 06:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27C22067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 06:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k14SKKFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbfJPGDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 02:03:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33870 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbfJPGDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 02:03:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id k20so6260638pgi.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 23:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T3AaA+xd4mdUluLNxKlBwgWXimT50aOOjAm086WDcRg=;
        b=k14SKKFhg+MCKc7BkdTTbY/cz6o/SmHSY8ToObQ0N3Ebxydl6rVf5aFzX7VN6car4K
         MVLvLuo5tPDV1vE2Y1g0BfCdHJLPN9IkyNreQ6v3qLFCXgz+OndJti7vTbUVkurFv98N
         VLVYRHiPkPB10KrEmCxI+DOIuzVE28mfq1VacfbhjBxQlrdyZ0ucWQQuIJSMhggmP4S5
         /XupeyH/jxzmR9mNFa9jdSxMGEUpFhm/gq2qcmvUSmanqapuzD+B4kCS66LqLc/YWS15
         W92yFJU1W4GTbix9eHzEB6/PeZJa+5lUgC4KWiOVo8JPqgyQGGyZrCAxByTKeAZW75yg
         ZJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T3AaA+xd4mdUluLNxKlBwgWXimT50aOOjAm086WDcRg=;
        b=meXeDxuXAbOMJ03uUkcVPfQHayRomAtxW0SV/HA1L0gOzILqvn39YG12Q7CMoFeCEg
         iQamxHrEQfjrVjF1QbSyP2K+7FoloK2tga6QniUOVskiKK4qjXqwby46vFCvS2qTR33x
         yAz1glJONPUYF1iW+MaFgqjZVzwM+MBUrTUHd+CyjG7xd6idZ8YqJtVnadJWquCb0hXd
         h4yZOZDdcyUPpJ9uuUtBryW19uQwFlSU+oIkJ3BDpDLp0abRPT6LeHWKa3MYSji71bm6
         mIPQrW4tE3+/JCyI5FbHEDbCmQ/lOF6UvIxaMMBFZxnVG/AYFOtHIWniGr/RMsblRHsF
         4XeQ==
X-Gm-Message-State: APjAAAVa+XwDtJAOwZWFWOEiBstCv6R/l74jw0Tg8NRlGWVBIDM6EfSN
        cT6ozbmQ5X7YmGHb/YFk+XN1Qw==
X-Google-Smtp-Source: APXvYqzLK05iyhTKyl1v2KloPGgrLB7LEacVf7SN+L9WsqFPB+PouwGTpqa5kkyY5DfZba02HDvQOg==
X-Received: by 2002:a65:6091:: with SMTP id t17mr398775pgu.159.1571205822925;
        Tue, 15 Oct 2019 23:03:42 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p24sm9426321pgc.72.2019.10.15.23.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 23:03:42 -0700 (PDT)
Date:   Tue, 15 Oct 2019 23:03:39 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Maxime Ripard <mripard@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Alex Elder <elder@linaro.org>
Subject: Re: [PATCH] arm64: defconfig: Enable Qualcomm remoteproc dependencies
Message-ID: <20191016060339.GB4731@tuxbook-pro>
References: <20191009001442.15719-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009001442.15719-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08 Oct 17:14 PDT 2019, Bjorn Andersson wrote:

> Enable the the power domains, reset controllers and remote block device
> memory access drivers necessary to boot the Audio, Compute and Modem
> DSPs on Qualcomm SDM845.
> 
> None of the power domains are system critical, but needs to be builtin
> as the driver core prohibits probe deferal past late initcall.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Thanks Alex & Vinod!

Applied.

> ---
>  arch/arm64/configs/defconfig | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index c9a867ac32d4..42f042ba1039 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -732,10 +732,13 @@ CONFIG_RPMSG_QCOM_GLINK_SMEM=m
>  CONFIG_RPMSG_QCOM_SMD=y
>  CONFIG_RASPBERRYPI_POWER=y
>  CONFIG_IMX_SCU_SOC=y
> +CONFIG_QCOM_AOSS_QMP=y
>  CONFIG_QCOM_COMMAND_DB=y
>  CONFIG_QCOM_GENI_SE=y
>  CONFIG_QCOM_GLINK_SSR=m
> +CONFIG_QCOM_RMTFS_MEM=m
>  CONFIG_QCOM_RPMH=y
> +CONFIG_QCOM_RPMHPD=y
>  CONFIG_QCOM_SMEM=y
>  CONFIG_QCOM_SMD_RPM=y
>  CONFIG_QCOM_SMP2P=y
> @@ -780,6 +783,8 @@ CONFIG_PWM_ROCKCHIP=y
>  CONFIG_PWM_SAMSUNG=y
>  CONFIG_PWM_SUN4I=m
>  CONFIG_PWM_TEGRA=m
> +CONFIG_RESET_QCOM_AOSS=y
> +CONFIG_RESET_QCOM_PDC=m
>  CONFIG_RESET_TI_SCI=y
>  CONFIG_PHY_XGENE=y
>  CONFIG_PHY_SUN4I_USB=y
> -- 
> 2.18.0
> 
