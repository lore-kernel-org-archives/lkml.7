Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EE7C74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B03620872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XSctE8NX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbfGKP0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 11:26:22 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38960 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbfGKP0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 11:26:21 -0400
Received: by mail-pl1-f195.google.com with SMTP id b7so3211352pls.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 08:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xDOt/R012GpKF8HFEzGHxZ6VjWpUHMuTKXU3bjn70dk=;
        b=XSctE8NXzUrCLSA48gznsH/hlb0BzkA5MbyTNJycR46hL6HiqrgU/6XHxtjagPCsv0
         Vo4OMLScsUWTecg2LnFFpgUXJx7kXpn2DKRdohk/ZxtTbLQTwScsWKBBA/fqN09ZwpZH
         vL25IK6OAQx/Lydn0fgtrOITuktmovLNBnzi7SMhC1mwfgd6PJlGsLNEaFv8FC4zaaDB
         2ZoY2vdtm1JzNKi22EAZ8IjEMtitc645F+sidjRLsoP/lvLgDVE7c6oT+9Q0uQLSUvQ5
         pSTsqU1epdgnfCqfXlB4MjudmmiF77Nmvf1V4DYhkuIQPpNh9YBKJj3cB7MG57BETduu
         Gb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xDOt/R012GpKF8HFEzGHxZ6VjWpUHMuTKXU3bjn70dk=;
        b=GaKLdzQadc+rRt8FN5zzThRNhF/Ny92fJuKqE1cobrFet8BEGR8u0i3/UWSHumv0f3
         tno6fJj6Ki4g/N6r8YPVYtMbyMJjNStXmswzxRpqfbhcY7dUGP9XUSfM0NaMvF5gd2bx
         GyuEy2sbVb/ubRVSFF/nSKF9wfpObLx/uH/zLhAJC/bKgx/3yqoVnB4mCUMEP01KzlBU
         DGASRFnCnRLI0gF0bzRcmkwmwQ4V+PBD9tyGYpyrmGS0/mV1C7uPFLwsYGckm2lfwMVD
         M5kTpZJkH3YL32fDcISWQx+UWibEge5CYDyDxwqFIs9InEfgoQEVBcnt/nyetkxsdAqS
         H2kg==
X-Gm-Message-State: APjAAAW1T/Yz5eojomddYnB2M6HojfoXlP56Pt41GiZQ5dYHPKFittHo
        Q2/2WGWGujPxakV5MnMzAKUeQA==
X-Google-Smtp-Source: APXvYqwBujVJjsQORJ3cp1UkTkrULW8ipykYaV1DbpWN8jqWqpo9mYpGbrYwdO7z3fWkki2TUSWFgQ==
X-Received: by 2002:a17:902:b713:: with SMTP id d19mr5304484pls.267.1562858780510;
        Thu, 11 Jul 2019 08:26:20 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c98sm5642922pje.1.2019.07.11.08.26.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 08:26:19 -0700 (PDT)
Date:   Thu, 11 Jul 2019 08:27:30 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     sboyd@kernel.org, david.brown@linaro.org, jassisinghbrar@gmail.com,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org,
        will.deacon@arm.com, arnd@arndb.de, horms+renesas@verge.net.au,
        heiko@sntech.de, sibis@codeaurora.org,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, vkoul@kernel.org, niklas.cassel@linaro.org,
        georgi.djakov@linaro.org, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org
Subject: Re: [PATCH v3 14/14] arm64: defconfig: Enable HFPLL
Message-ID: <20190711152730.GN7234@tuxbook-pro>
References: <20190625164733.11091-1-jorge.ramirez-ortiz@linaro.org>
 <20190625164733.11091-15-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625164733.11091-15-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25 Jun 09:47 PDT 2019, Jorge Ramirez-Ortiz wrote:

> The high frequency pll is required on compatible Qualcomm SoCs to
> support the CPU frequency scaling feature.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index fbbc065415d4..7cc4ad24dfe5 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -671,6 +671,7 @@ CONFIG_MSM_MMCC_8996=y
>  CONFIG_MSM_GCC_8998=y
>  CONFIG_QCS_GCC_404=y
>  CONFIG_SDM_GCC_845=y
> +CONFIG_QCOM_HFPLL=y
>  CONFIG_HWSPINLOCK=y
>  CONFIG_HWSPINLOCK_QCOM=y
>  CONFIG_ARM_MHU=y
> -- 
> 2.21.0
> 
