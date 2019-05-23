Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D842CC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A479A2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DEtKgYpP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbfEWNRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 09:17:12 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35047 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfEWNRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 09:17:12 -0400
Received: by mail-pl1-f193.google.com with SMTP id p1so2775717plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 06:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kopmk5mvy3G2sPVhmNvkGBCegMtkQbUAC1QtXamn6kQ=;
        b=DEtKgYpPpwGdbF4EcNDd2ZV7eBWZlHpcbgHalwosHws5txIbZNSvv0f0YekrZUq2ww
         Trs96X2AALKE9VRNe9cveE56HD+zlE+STMyYpqgqldesj6HqzSxiJBPKXU84DP+hP+DZ
         gPigezIOLn1FQytjs8mgTXUIUk+VOWvGKIP6ST0zGblcuDIpt2YMDvoI7w2+2IPLaCeT
         IqTR0pCumOBm7YsnP/dEF/L1pwzodGp3czArtm985mxSsP2UE9BhTErDu7mOpiQ+A17N
         absyxnXzb/nx70hx7QQt53dxnZRCY4vwX11ONClSry7eUIpc0yTF3mkuxQwueqMeNMBS
         s2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kopmk5mvy3G2sPVhmNvkGBCegMtkQbUAC1QtXamn6kQ=;
        b=QKbTpdVDL14i1R+iiwfJAQLLc1bGloZTh/7VaGVnLVCrKZhHKFwMex4zOqIobMzZOk
         e8C/NwdMkWVf1woQD7ahVlUteNtvhPmoEIBeA9hfqRyIfHO47mhrDTTe6XMdfQPbOEnr
         Wj2Z4Jk/ujkChSkc09G6+/OdPKdDq8rVvt1G6GvSrzwKe8fvcNW27cWDJkZHzYljuPjb
         7kGyY7G+TkdNr2QH8WWEmWHpTYHwSxkIiijPa4q3hgcrGnZgUdH5YanKHHbNRKC21Uxb
         kExK3iVAZ7Tub35FxPR6/b0367WM0LfymmJLAik6hYNGL+PwiNW88YpzugdKAxNGoSMr
         4uxw==
X-Gm-Message-State: APjAAAUkWFYl2eobrL708UqpdI+jAKC6Xc6gJ/Qv4+86VKa+t/J4/Wc9
        /W7xtNyMNo8EPZetn19U7eQClwW8xv9Y8g==
X-Google-Smtp-Source: APXvYqxkANieYzEE6DMJG1h286DYQm3u0jAfyirRH8il7DT9Y0MRpbf2blOEcPSth+kWaRJwtHZCvw==
X-Received: by 2002:a17:902:9689:: with SMTP id n9mr98509857plp.133.1558617431700;
        Thu, 23 May 2019 06:17:11 -0700 (PDT)
Received: from dragon (98.142.130.235.16clouds.com. [98.142.130.235])
        by smtp.gmail.com with ESMTPSA id x66sm20992216pfx.139.2019.05.23.06.17.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 May 2019 06:17:10 -0700 (PDT)
Date:   Thu, 23 May 2019 21:16:08 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "agross@kernel.org" <agross@kernel.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] arm64: defconfig: Enable CONFIG_QORIQ_THERMAL
Message-ID: <20190523131606.GA21933@dragon>
References: <1558425114-10625-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558425114-10625-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 07:57:05AM +0000, Anson Huang wrote:
> i.MX8MQ needs CONFIG_QORIQ_THERMAL for thermal support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Please send to my kernel.org email address.

Shawn

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index da85808..61be39b 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -420,6 +420,7 @@ CONFIG_SENSORS_INA2XX=m
>  CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
>  CONFIG_CPU_THERMAL=y
>  CONFIG_THERMAL_EMULATION=y
> +CONFIG_QORIQ_THERMAL=m
>  CONFIG_ROCKCHIP_THERMAL=m
>  CONFIG_RCAR_THERMAL=y
>  CONFIG_RCAR_GEN3_THERMAL=y
> -- 
> 2.7.4
> 
