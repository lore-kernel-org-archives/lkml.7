Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA66C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE7120659
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575410852;
	bh=dJRyQapT6rNWPi9x2ro/xRn3/Z/BWbeUocntIPdTaVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QXkSDhXAb83ytaCmvbdBHz8F75v7OBuJDqmcQlN8M5UO9uzgI/4PLnFad2UZwhT92
	 1Bg3mK7NU2KLOZY1Zu8TIp8qc/X3xXSHuMpr8aKS51yUwfDFGIzKZojzXRL4kcJwi/
	 AI/3Zo3BOY1cSKBIFCvyPn2OHNU0+UNgug8fWt2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfLCWHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:07:30 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36823 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbfLCWHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:07:30 -0500
Received: by mail-oi1-f196.google.com with SMTP id c16so4915401oic.3;
        Tue, 03 Dec 2019 14:07:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BwKTMzYHU8KC/723XteTIPp1IXDMUZwn/2LYWS85bsY=;
        b=ZvPydDWc8UpJafzDEiijaM71pD4rREwsbhpBiOmA72j5GXB8EwphdPHWXrfqcoISAo
         I+sj1SXsyAo3AeCXy1b5LwI9AF/C3Tzz8bWXQcg2P0EWATnvmfBac30zkqj9HG+ACyWq
         Qi9WvBcAeJpuVzJbSVRReoZxVF7LzWWrPNS6cpmoKh6GxjQVnVE+06gB20aJskv1Fkk5
         InwN0Mk9QKNtEYU6SVnuYLq4mjsWxrbuF1IbpIfjt2a7PbBDNxFRLirKAa/gGjxWBP9j
         SHOLzQlbBOEncYdX187Wr+Tf4n1lm6CN6QyeVljIDDV75uPNsR4RPHhSWYNSA4ZtMZxc
         Im5w==
X-Gm-Message-State: APjAAAUPb154d1wS5mIn8GI9vUQQRh9sNWyfPXXLtBkxlbOMz5EW6Qsd
        PHo8IDHlFNw6NabGTilT2w==
X-Google-Smtp-Source: APXvYqxahROn5+cYweochttTrXtRy81KujPWooahfcQ7HtSD3QLFajv2JM+bmDVevohuS4iZJ3j+zA==
X-Received: by 2002:a54:4f8e:: with SMTP id g14mr185570oiy.144.1575410848747;
        Tue, 03 Dec 2019 14:07:28 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m7sm96146otl.20.2019.12.03.14.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 14:07:27 -0800 (PST)
Date:   Tue, 3 Dec 2019 16:07:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, digetx@gmail.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, tglx@linutronix.de, mark.rutland@arm.com,
        allison@lohutok.net, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mturquette@baylibre.com, horms+renesas@verge.net.au,
        Jisheng.Zhang@synaptics.com, krzk@kernel.org, arnd@arndb.de,
        spujar@nvidia.com, josephl@nvidia.com, vidyas@nvidia.com,
        daniel.lezcano@linaro.org, mmaddireddy@nvidia.com,
        markz@nvidia.com, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 11/17] dt-bindings: clock: tegra: Remove pmc clock ids
 from clock dt-bindings
Message-ID: <20191203220727.GA22716@bogus>
References: <1574146234-3871-1-git-send-email-skomatineni@nvidia.com>
 <1574146234-3871-12-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574146234-3871-12-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 10:50:28PM -0800, Sowjanya Komatineni wrote:
> clk_out_1, clk_out_2, clk_out_3, blink are part of Tegra pmc clocks.
> 
> This patch removes ids for these clocks from Tegra clock dt-bindings.

Your commit message should answer why, not what.

This is not a backwards compatible change if any of these IDs are used. 

> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  include/dt-bindings/clock/tegra114-car.h        | 14 +++++++-------
>  include/dt-bindings/clock/tegra124-car-common.h | 14 +++++++-------
>  include/dt-bindings/clock/tegra20-car.h         |  2 +-
>  include/dt-bindings/clock/tegra210-car.h        | 14 +++++++-------
>  include/dt-bindings/clock/tegra30-car.h         | 14 +++++++-------
>  5 files changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/include/dt-bindings/clock/tegra114-car.h b/include/dt-bindings/clock/tegra114-car.h
> index bb5c2c999c05..9175cd0571b5 100644
> --- a/include/dt-bindings/clock/tegra114-car.h
> +++ b/include/dt-bindings/clock/tegra114-car.h
> @@ -270,10 +270,10 @@
>  #define TEGRA114_CLK_AUDIO3 242
>  #define TEGRA114_CLK_AUDIO4 243
>  #define TEGRA114_CLK_SPDIF 244
> -#define TEGRA114_CLK_CLK_OUT_1 245
> -#define TEGRA114_CLK_CLK_OUT_2 246
> -#define TEGRA114_CLK_CLK_OUT_3 247
> -#define TEGRA114_CLK_BLINK 248
> +/* 245 */
> +/* 246 */
> +/* 247 */
> +/* 248 */
>  /* 249 */
>  /* 250 */
>  /* 251 */
> @@ -333,9 +333,9 @@
>  #define TEGRA114_CLK_AUDIO3_MUX 303
>  #define TEGRA114_CLK_AUDIO4_MUX 304
>  #define TEGRA114_CLK_SPDIF_MUX 305
> -#define TEGRA114_CLK_CLK_OUT_1_MUX 306
> -#define TEGRA114_CLK_CLK_OUT_2_MUX 307
> -#define TEGRA114_CLK_CLK_OUT_3_MUX 308
> +/* 306 */
> +/* 307 */
> +/* 308 */
>  #define TEGRA114_CLK_DSIA_MUX 309
>  #define TEGRA114_CLK_DSIB_MUX 310
>  #define TEGRA114_CLK_XUSB_SS_DIV2 311
> diff --git a/include/dt-bindings/clock/tegra124-car-common.h b/include/dt-bindings/clock/tegra124-car-common.h
> index 0c4f5be0a742..90a0c5e7eb5f 100644
> --- a/include/dt-bindings/clock/tegra124-car-common.h
> +++ b/include/dt-bindings/clock/tegra124-car-common.h
> @@ -269,10 +269,10 @@
>  #define TEGRA124_CLK_AUDIO3 242
>  #define TEGRA124_CLK_AUDIO4 243
>  #define TEGRA124_CLK_SPDIF 244
> -#define TEGRA124_CLK_CLK_OUT_1 245
> -#define TEGRA124_CLK_CLK_OUT_2 246
> -#define TEGRA124_CLK_CLK_OUT_3 247
> -#define TEGRA124_CLK_BLINK 248
> +/* 245 */
> +/* 246 */
> +/* 247 */
> +/* 248 */
>  /* 249 */
>  /* 250 */
>  /* 251 */
> @@ -332,9 +332,9 @@
>  #define TEGRA124_CLK_AUDIO3_MUX 303
>  #define TEGRA124_CLK_AUDIO4_MUX 304
>  #define TEGRA124_CLK_SPDIF_MUX 305
> -#define TEGRA124_CLK_CLK_OUT_1_MUX 306
> -#define TEGRA124_CLK_CLK_OUT_2_MUX 307
> -#define TEGRA124_CLK_CLK_OUT_3_MUX 308
> +/* 306 */
> +/* 307 */
> +/* 308 */
>  /* 309 */
>  /* 310 */
>  #define TEGRA124_CLK_SOR0_LVDS 311 /* deprecated */
> diff --git a/include/dt-bindings/clock/tegra20-car.h b/include/dt-bindings/clock/tegra20-car.h
> index b21a0eb32921..fe541f627965 100644
> --- a/include/dt-bindings/clock/tegra20-car.h
> +++ b/include/dt-bindings/clock/tegra20-car.h
> @@ -131,7 +131,7 @@
>  #define TEGRA20_CLK_CCLK 108
>  #define TEGRA20_CLK_HCLK 109
>  #define TEGRA20_CLK_PCLK 110
> -#define TEGRA20_CLK_BLINK 111
> +/* 111 */
>  #define TEGRA20_CLK_PLL_A 112
>  #define TEGRA20_CLK_PLL_A_OUT0 113
>  #define TEGRA20_CLK_PLL_C 114
> diff --git a/include/dt-bindings/clock/tegra210-car.h b/include/dt-bindings/clock/tegra210-car.h
> index 44f60623f99b..a3d8d3e75728 100644
> --- a/include/dt-bindings/clock/tegra210-car.h
> +++ b/include/dt-bindings/clock/tegra210-car.h
> @@ -304,10 +304,10 @@
>  #define TEGRA210_CLK_AUDIO3 274
>  #define TEGRA210_CLK_AUDIO4 275
>  #define TEGRA210_CLK_SPDIF 276
> -#define TEGRA210_CLK_CLK_OUT_1 277
> -#define TEGRA210_CLK_CLK_OUT_2 278
> -#define TEGRA210_CLK_CLK_OUT_3 279
> -#define TEGRA210_CLK_BLINK 280
> +/* 277 */
> +/* 278 */
> +/* 279 */
> +/* 280 */
>  #define TEGRA210_CLK_SOR0_LVDS 281 /* deprecated */
>  #define TEGRA210_CLK_SOR0_OUT 281
>  #define TEGRA210_CLK_SOR1_OUT 282
> @@ -386,9 +386,9 @@
>  #define TEGRA210_CLK_AUDIO3_MUX 353
>  #define TEGRA210_CLK_AUDIO4_MUX 354
>  #define TEGRA210_CLK_SPDIF_MUX 355
> -#define TEGRA210_CLK_CLK_OUT_1_MUX 356
> -#define TEGRA210_CLK_CLK_OUT_2_MUX 357
> -#define TEGRA210_CLK_CLK_OUT_3_MUX 358
> +/* 356 */
> +/* 357 */
> +/* 358 */
>  #define TEGRA210_CLK_DSIA_MUX 359
>  #define TEGRA210_CLK_DSIB_MUX 360
>  /* 361 */
> diff --git a/include/dt-bindings/clock/tegra30-car.h b/include/dt-bindings/clock/tegra30-car.h
> index 3c90f1535551..20ef2462d9e1 100644
> --- a/include/dt-bindings/clock/tegra30-car.h
> +++ b/include/dt-bindings/clock/tegra30-car.h
> @@ -230,11 +230,11 @@
>  #define TEGRA30_CLK_AUDIO3 204
>  #define TEGRA30_CLK_AUDIO4 205
>  #define TEGRA30_CLK_SPDIF 206
> -#define TEGRA30_CLK_CLK_OUT_1 207 /* (extern1) */
> -#define TEGRA30_CLK_CLK_OUT_2 208 /* (extern2) */
> -#define TEGRA30_CLK_CLK_OUT_3 209 /* (extern3) */
> +/* 207 */
> +/* 208 */
> +/* 209 */
>  #define TEGRA30_CLK_SCLK 210
> -#define TEGRA30_CLK_BLINK 211
> +/* 211 */
>  #define TEGRA30_CLK_CCLK_G 212
>  #define TEGRA30_CLK_CCLK_LP 213
>  #define TEGRA30_CLK_TWD 214
> @@ -260,9 +260,9 @@
>  /* 297 */
>  /* 298 */
>  /* 299 */
> -#define TEGRA30_CLK_CLK_OUT_1_MUX 300
> -#define TEGRA30_CLK_CLK_OUT_2_MUX 301
> -#define TEGRA30_CLK_CLK_OUT_3_MUX 302
> +/* 300 */
> +/* 301 */
> +/* 302 */
>  #define TEGRA30_CLK_AUDIO0_MUX 303
>  #define TEGRA30_CLK_AUDIO1_MUX 304
>  #define TEGRA30_CLK_AUDIO2_MUX 305
> -- 
> 2.7.4
> 
