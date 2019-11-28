Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758D9C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D9821774
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNZTygSH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfK1NHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:07:09 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33425 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfK1NHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:07:08 -0500
Received: by mail-lj1-f195.google.com with SMTP id t5so28478374ljk.0;
        Thu, 28 Nov 2019 05:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H/wvGHfazc7nNkLeZ9T3X/8/ZHppwN6jHd4LOpn5RrY=;
        b=WNZTygSHqTU4yQLNpr5rII8B4G1RWvMCXY4WGv2GyAdk8/Zi+rmdAmvV3ckJPDBFBu
         cXp34xb0OgDr2LJbXgQylUNlELXtXRN+jqqs/g2qVKLULzxgkh6RSyx6ADrDXfY0lGRV
         D8FjmZ4nbPaLPQFL5Qe+tbOM5sZSFZU98rs+g1ZoJHDuQGK/JDxn0dDRxRQ5bYWvplzD
         CIr+61pcVYpYW7qedqoefjdvX/fzyu2t5urjGWuLCtCb+hnE01+T2VnvNnE8HpTlrX0h
         eVaLnpaBtz6CV3J3DX2US1t1fDHDEb3HybWx3OLU9XNg6GfhzPacqMXhDcjX+tdQ3bWn
         lxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H/wvGHfazc7nNkLeZ9T3X/8/ZHppwN6jHd4LOpn5RrY=;
        b=XwIMwKgQC1Cg71FXeR0HFPcF9Sn1NJVKYIcWSVC/wcKm4BPOB74nl4bX+6AQL646AQ
         TtghFPyD/i7QjsAHQEQtNiUPLeWE/gBDrAWnT3matknFNrRx+cT/29hFkWsAH/qD1/TS
         /MiHdijP1OYfuV61xouQ9xwufDm7qiAYCRb5zKsbah7GMNUU3FCrLISD0Fdvx/cXUMaq
         CUHoohMOgCAGjkmO+xzEWcyUgUlXbLvZzK7SMsc+SkuzndhhIrCogH6GFYGRTDCuVvjj
         VlspF3qOvq1dORFZSMtxd7UTJdTWFxvk+W1wPsIbJHPtV69gRSWlK6oBY6KQdiI4TQrb
         qb9g==
X-Gm-Message-State: APjAAAUIuF+CItPnNF0lX3c97jNIa4HCkezJe3vUq5TU8Zar6NDOFbKr
        ZD8Dyg7RRZi0+f9fcaOW5xL0k7r9
X-Google-Smtp-Source: APXvYqxWzALWCmutUqc7LcXV7Wc7ujXRAd0faQJGN9pOgTIcNLY2wrzf1j6vOjngCrHDHFyXVUIKlw==
X-Received: by 2002:a2e:3216:: with SMTP id y22mr20001056ljy.95.1574946426008;
        Thu, 28 Nov 2019 05:07:06 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id y192sm3983251lfa.63.2019.11.28.05.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 05:07:05 -0800 (PST)
Subject: Re: [PATCH v2 04/11] soc: pmc: Add blink output clock registration to
 Tegra PMC
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     allison@lohutok.net, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mturquette@baylibre.com, horms+renesas@verge.net.au,
        Jisheng.Zhang@synaptics.com, krzk@kernel.org, arnd@arndb.de,
        spujar@nvidia.com, josephl@nvidia.com, vidyas@nvidia.com,
        daniel.lezcano@linaro.org, mmaddireddy@nvidia.com,
        markz@nvidia.com, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1574830773-14892-1-git-send-email-skomatineni@nvidia.com>
 <1574830773-14892-5-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <10a147f0-9b8e-7212-fefe-027091fe4bf7@gmail.com>
Date:   Thu, 28 Nov 2019 16:07:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1574830773-14892-5-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

27.11.2019 07:59, Sowjanya Komatineni пишет:
> Tegra PMC has blink control to output 32 Khz clock out to Tegra
> blink pin. Blink pad DPD state and enable controls are part of
> Tegra PMC register space.
> 
> Currently Tegra clock driver registers blink control by passing
> PMC address and register offset to clk_register_gate which performs
> direct PMC access during clk_ops and with this when PMC is in secure
> mode, any access from non-secure world does not go through.
> 
> This patch adds blink control registration to the Tegra PMC driver
> using PMC specific clock gate operations that use tegra_pmc_readl
> and tegra_pmc_writel to support both secure mode and non-secure
> mode PMC register access.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index a353f6d0a832..1cfb7797dbd5 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -61,12 +61,15 @@
>  #define  PMC_CNTRL_SYSCLK_OE		BIT(11) /* system clock enable */
>  #define  PMC_CNTRL_SYSCLK_POLARITY	BIT(10) /* sys clk polarity */
>  #define  PMC_CNTRL_PWRREQ_POLARITY	BIT(8)
> +#define  PMC_CNTRL_BLINK_EN		BIT(7)
>  #define  PMC_CNTRL_MAIN_RST		BIT(4)
>  
>  #define PMC_WAKE_MASK			0x0c
>  #define PMC_WAKE_LEVEL			0x10
>  #define PMC_WAKE_STATUS			0x14
>  #define PMC_SW_WAKE_STATUS		0x18
> +#define PMC_DPD_PADS_ORIDE		0x1c
> +#define  PMC_DPD_PADS_ORIDE_BLINK	BIT(20)
>  
>  #define DPD_SAMPLE			0x020
>  #define  DPD_SAMPLE_ENABLE		BIT(0)
> @@ -79,6 +82,7 @@
>  
>  #define PWRGATE_STATUS			0x38
>  
> +#define TEGRA210_PMC_BLINK_TIMER	0x40

This register is common for all Tegra SoCs, therefore TEGRA210_ prefix
isn't needed.

