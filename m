Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29106C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F9D2245B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q67Eo3FK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfKSTdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 14:33:22 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44363 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfKSTdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 14:33:21 -0500
Received: by mail-lj1-f194.google.com with SMTP id g3so24667350ljl.11;
        Tue, 19 Nov 2019 11:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K/wS8YbexkELQZx4ScpHh2pnM5m90l0vHV4bZJCcSQo=;
        b=q67Eo3FKgEaS5G/rWOxTm80yl+6l9H4pWDOOImts/4fXTWTZmPG6aIc33CdhRS2uPn
         qoh1Y5hans7jOz8KNE852BxHSaZ8q9+jOS627/ysBRKjdQosU8eQY4YrFyRIaMy4klM/
         aZFFSboxln6pwVrLG2q4fg6O1YL6Kf1WEUncbNuqZ50N5XcV8ArpR4G28ePXKx6FmfK6
         8xoMdMHiCww75QhTX3LcJ5/llnw3UM/zTaeukb33hgfgbbH55UUU6+MUYwrxqbekyFve
         u4yNSU6bXxFwghXGMf9qzWW8QP3r+fFj+QGABECIfMgAn4RguN9odp3fI7zxHewWf4C3
         Be4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K/wS8YbexkELQZx4ScpHh2pnM5m90l0vHV4bZJCcSQo=;
        b=NGPlsCbifjPud3+xiFZ2pfmJZh/UCDYUnazePn9yTMeH8EI6ACjZTRpbmm9HiBMmAH
         g7bMTmXPlm7KzG6XDjNymWDP+nBA150E764+Qc6V8IaSge7moASYBkdlT/4/a8v5ZsmV
         2iUQopmTxw+XmTmJ0LfzgBEI405EvRwVDw3DkfxINqGy4FgrK3JsP6xeKmERiS2pb2Hn
         6Swc7W5+uLKN0mjsCnTC+xAWl15XaQ2hoZ4eH1ExMK2bcBjR/A2NqpIFCdCl9bnawlQC
         WcjtOSpUdwSsDyd5UPGmSjD7fON86K1H5ETAaDJWX9LvDV+vAMKaNoyEKt9jK/XAHdJu
         wB1A==
X-Gm-Message-State: APjAAAXdVk0xduytTRpj85p/W6hJKvzgq4pDjeQzi+8cwuMNwo5vA4Nb
        gyDQknjpp8mzHxAEzI57rfgeY46h
X-Google-Smtp-Source: APXvYqz2gspdc0F3FICZmbVQdHPpPDhQRv79xHk1LxQJ4OxABwHf2HoY3lN+1YKeOKiS+0Afk0NRuw==
X-Received: by 2002:a2e:8188:: with SMTP id e8mr5346065ljg.152.1574191998403;
        Tue, 19 Nov 2019 11:33:18 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id g23sm12278480ljn.63.2019.11.19.11.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2019 11:33:17 -0800 (PST)
Subject: Re: [PATCH v1 10/17] clk: tegra: Remove tegra_pmc_clk_init along with
 clk ids
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
References: <1574146234-3871-1-git-send-email-skomatineni@nvidia.com>
 <1574146234-3871-11-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c61ad48b-1975-e6b6-2618-b52c7fe3d4c4@gmail.com>
Date:   Tue, 19 Nov 2019 22:33:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1574146234-3871-11-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

19.11.2019 09:50, Sowjanya Komatineni пишет:
> Current Tegra clock driver registers PMC clocks clk_out_1, clk_out_2,
> clk_out_3 and blink output in tegra_pmc_init() which does direct Tegra
> PMC access during clk_ops and these PMC register read and write access
> will not happen when PMC is in secure mode.
> 
> Any direct PMC register access from non-secure world will not go
> through and all the PMC clocks and blink control are done in Tegra PMC
> driver with PMC as clock provider.
> 
> This patch removes tegra_pmc_clk_init along with corresponding clk ids
> from Tegra clock driver.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/clk/tegra/Makefile       |  1 -
>  drivers/clk/tegra/clk-id.h       |  7 -------
>  drivers/clk/tegra/clk-tegra114.c | 33 ------------------------------
>  drivers/clk/tegra/clk-tegra124.c | 44 +++++-----------------------------------
>  drivers/clk/tegra/clk-tegra20.c  | 24 ----------------------
>  drivers/clk/tegra/clk-tegra210.c | 32 -----------------------------
>  drivers/clk/tegra/clk-tegra30.c  | 32 -----------------------------
>  drivers/clk/tegra/clk.h          |  1 -
>  8 files changed, 5 insertions(+), 169 deletions(-)
> 
> diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
> index df966ca06788..1f7c30f87ece 100644
> --- a/drivers/clk/tegra/Makefile
> +++ b/drivers/clk/tegra/Makefile
> @@ -12,7 +12,6 @@ obj-y					+= clk-sdmmc-mux.o
>  obj-y					+= clk-super.o
>  obj-y					+= clk-tegra-audio.o
>  obj-y					+= clk-tegra-periph.o
> -obj-y					+= clk-tegra-pmc.o
>  obj-y					+= clk-tegra-fixed.o
>  obj-y					+= clk-tegra-super-gen4.o
>  obj-$(CONFIG_TEGRA_CLK_EMC)		+= clk-emc.o

Why clk-tegra-pmc.c itself isn't removed?

[snip]

