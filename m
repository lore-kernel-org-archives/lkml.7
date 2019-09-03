Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877B1C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 03:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5557B217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 03:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f6GrosI0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfICDWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 23:22:38 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39314 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfICDWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 23:22:37 -0400
Received: by mail-pl1-f195.google.com with SMTP id bd8so933761plb.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 20:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jRZjBMyGv80xAQC7s33gam9Ckf3o8Pfle8efSqPMXgw=;
        b=f6GrosI0QIkCUKNeMhcqlSO4/8rCTMIn4OR0fcybLTac9ENK7suUAHJ4jfqzBd+NhT
         eWRWviXByZB7JQbqM/CrsjHbu0L+Xl+Me67c0/U8STdPBMr751awGiyGwpRAfMgjaWfv
         DiScNMgn8gRZXTSItfmOEoGKc/tki45ht/0vV0+uQc0DXTIiJ7AOrCTBF4VicQTbZVW+
         9Go9v0Hu0+BJgwnECe1AXJ6jcntj24PQn8BBJxX3iZws/uXflQcS20vLfsZTRmngVPc7
         E0AhU0YJYiAjApwioQTTtcBG0mLXskyVC8OnyuizAmNyP2IYG1dbdJOwZL9lnDExXtR9
         6NoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jRZjBMyGv80xAQC7s33gam9Ckf3o8Pfle8efSqPMXgw=;
        b=mmY+1ha/Lf0tjxDFqO3ux1tCnShBee/t3QcRsI6pUM2KS98kdt3EUI1ecLend/MjHm
         3Q7jTsfzgv6IP0NnINjjLrOKK5cexFelA+70ix16ZuluC98hO0iAoBWHL2TkuI3NbuXP
         zh9/14OQk64mxobdFCnRxdBKqNQw2B1GJvyLXtN91xmDdfZDiVmuUkdFgkBQddHya82g
         iGssbRqlI1SC+IlRvBiYu0orxYNK5FhKMVx4WjvaRW/p0GkyZt2vlc2LGuOGg+Ev59yE
         CmkCwBhTN8PL6hgqf21oibzh2aaJ+Y9KeifmyzndNMUA7mtzzkMKcIxbcqIABbE1Fkb+
         eCtw==
X-Gm-Message-State: APjAAAU0R2KHxDqKPtT/AdL8hHWIkvGdvWwzcQBkDUSzsFMKzwjzWmk1
        0uyMU06IGShk4Dk+uAI3lKqh3A==
X-Google-Smtp-Source: APXvYqwVw+D1Itw5DwUiGmgA/MHAj1uXcwQjCWqKXTRuwWUOS4waChIRinNTMSG/lnWRGWR5Hvo6bA==
X-Received: by 2002:a17:902:31a4:: with SMTP id x33mr33259889plb.68.1567480957176;
        Mon, 02 Sep 2019 20:22:37 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x10sm13072767pjo.4.2019.09.02.20.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 20:22:36 -0700 (PDT)
Date:   Mon, 2 Sep 2019 20:22:34 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     catalin.marinas@arm.com, will@kernel.org, olof@lixom.net,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: defconfig: Enable Qualcomm QUSB2 PHY
Message-ID: <20190903032234.GU6167@minitux>
References: <20190902130724.12030-1-lee.jones@linaro.org>
 <20190902130724.12030-3-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902130724.12030-3-lee.jones@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02 Sep 06:07 PDT 2019, Lee Jones wrote:

> Tested on the Lenovo Yoga C630 where this patch enables USB.
> Without it USB devices are not enumerated.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index af7ca722b519..a94d002182ee 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -770,6 +770,7 @@ CONFIG_PHY_HISTB_COMBPHY=y
>  CONFIG_PHY_HISI_INNO_USB2=y
>  CONFIG_PHY_MVEBU_CP110_COMPHY=y
>  CONFIG_PHY_QCOM_QMP=m
> +CONFIG_PHY_QCOM_QUSB2=m
>  CONFIG_PHY_QCOM_USB_HS=y
>  CONFIG_PHY_RCAR_GEN3_PCIE=y
>  CONFIG_PHY_RCAR_GEN3_USB2=y
> -- 
> 2.17.1
> 
