Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9DCC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF46920675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmLK22y5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfCFQGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:06:40 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32806 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbfCFQGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 11:06:39 -0500
Received: by mail-pg1-f193.google.com with SMTP id h11so8776178pgl.0;
        Wed, 06 Mar 2019 08:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gpisac4kI14rRGMb6zjfkjieiY+JjbxH/CIGBRc3wrU=;
        b=TmLK22y5EYUQkkOwPKtU7hPHHEck79MLBF/XylL2qHXsRACfFKXM9ICPiUMsVmUC6l
         5EK8rDF+Nc7Ws4v8w+OU8EvEnfqJJSF/pryC8rzb+TlUDArUoJg7i2bw6NNgXr1Rtxav
         AhFT48q/cuSPFu/qZLODzyBEWYAyV4x89g/Gw425g9gndtDs6yKdR3xxPhpaPJJbCwdg
         wIr0vlPagVXkqvIUQsRjoJhfoE1gh6nvL45Z2LZmv1rbflqwkhDfFuDa0BLy09a9XYg1
         lktIU03ej8HpO/CtQaeOq0uJ3H+JsUczkCsUVGDvUT7z2py/9CWKomqjhLpyKkh8p2vY
         u6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gpisac4kI14rRGMb6zjfkjieiY+JjbxH/CIGBRc3wrU=;
        b=E2T4N53cUkVzr6iha7jPIX/24x1VGS/Vag0v/g/9d09Hkv0/LS4Gcg7sVgVmvvPwkZ
         L/LHqdWennEbsETBmvCRjpyMZgzdQgWbglZCHhjJtaztUP7YoUxEoJ7z8L0pXGFe0KPS
         Y2vy5fOxrxW+wKncy15rHKCfPslt++vyuS869sR9OJQKrZzLTsLCmAI8bMh8/JpoWBA7
         LvTmz8DA+fjdOiUe3R6eLJ7kufEu3qZKXs7AP3d+37LD2H7mbxvxrpFZ0KyjUbeP9IqH
         mIJ6jhT9HFmWkLUkJDhBj3Clb9hIg5Nwofw7xJ7F4P4KEZSUPU11mImUg51Anx5+P8En
         PIxQ==
X-Gm-Message-State: APjAAAWGy1dMI8Nk+m6atpOS/JCpGPyRKK54JV/QiWfXGIMr1BXcC/wT
        HH0GU/jhZIuwDLVEAfBcwra6amSR
X-Google-Smtp-Source: APXvYqzqMdfWLJb+G4JQnTb0FLPhp4sqpH8fTY03A8UFpSo0El6jqwUc/OoCAZSgefCnUqxTHAjggA==
X-Received: by 2002:aa7:8012:: with SMTP id j18mr8209237pfi.42.1551888399157;
        Wed, 06 Mar 2019 08:06:39 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n15sm3092334pgc.92.2019.03.06.08.06.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 08:06:38 -0800 (PST)
Subject: Re: [PATCH V7 2/3] arm64: defconfig: add support for i.MX system
 controller watchdog
To:     Anson Huang <anson.huang@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        Andy Gross <andy.gross@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1551834095-19950-1-git-send-email-Anson.Huang@nxp.com>
 <1551834095-19950-2-git-send-email-Anson.Huang@nxp.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <37298c83-b9c5-02d8-a3a6-ee571ebc22c4@roeck-us.net>
Date:   Wed, 6 Mar 2019 08:06:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1551834095-19950-2-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/19 5:06 PM, Anson Huang wrote:
> Enable CONFIG_IMX_SC_WDT as module to support i.MX system
> controller watchdog.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
> No changes.
> ---
>   arch/arm64/configs/defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 2d9c390..690f4ba 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -427,6 +427,7 @@ CONFIG_WATCHDOG=y
>   CONFIG_ARM_SP805_WATCHDOG=y
>   CONFIG_S3C2410_WATCHDOG=y
>   CONFIG_IMX2_WDT=y
> +CONFIG_IMX_SC_WDT=m
>   CONFIG_MESON_GXBB_WATCHDOG=m
>   CONFIG_MESON_WATCHDOG=m
>   CONFIG_RENESAS_WDT=y
> 

