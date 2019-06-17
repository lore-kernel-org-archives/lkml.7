Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66856C31E58
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD532087F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GhSJZeoC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbfFQLf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 07:35:58 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35002 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbfFQLf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:35:57 -0400
Received: by mail-vs1-f66.google.com with SMTP id u124so5887450vsu.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 04:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=otnv9cTgTfe5r23dfOto9MZjGxvYYJ6GS/smezsERbw=;
        b=GhSJZeoC/oXLyZ+TRiMZ0YoXyHryTR3BQ9q66WqrqpWj4KduSA9n3Udj3Q7AiY94c7
         ApmEGyvfHjEeCnF+Bow7WWJquaPIFB/gMPr49O2j6bcgghpvg0XWk/cc4JHNjEdz7yxi
         3icABA7wUklyEK6MablY/noFcwcUfOP3MqD3ooi54cey/mH1qVhQzu81icq43SWOvl8k
         3VEbBqiExhkaV+MutYoQNaN0MHEf5ou1YKkOclJVHN73qhp9Gh04uCnDKw/GCo4h7T5N
         RUktUXFcT0j/RWnPTbUMjGO6Ottd0/ODo86n5mbFPW0+6YhmJ6Jg4cX0RsNVBFGx7ZPt
         uZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=otnv9cTgTfe5r23dfOto9MZjGxvYYJ6GS/smezsERbw=;
        b=mo/j4qqPpy485j45YTfPSyh/eYs1XPX/Zyn2L6w98fmlRuEgufXETuASpI6ypFy/tR
         DY5D8msqBbheKXMvNoTcdkZi1aTH98xzXCY+ip0mpbZsVOwmo7WFEx2rOn1mXuh8RyeJ
         c7Hf0W8QfLKhfG4UIE4m7NDuV2yyOaGBXsHMPt7oaAdRd4e95gvQt+m7qx+X6DIu1YVx
         XALYG22HiCJDHTkHomUcgt1zOztGgHZya6WT61gP9nBO3PuVGyKemOM7so491zUm9Osc
         GYCweQYv+FUNAU0M5/P1aTwGArpMhUQCJOGKZP3abNeSFwtGsczOLPXFVINfgfRFLAFT
         /E1Q==
X-Gm-Message-State: APjAAAXBsCO0evjCP4DzbA8AmrwjdXKsDcZxz00nrQQtB5DfLwzXDx26
        0ub2rky2AJAppHmR5oWXpyBRWzy9zouhg3rqXNPRIw==
X-Google-Smtp-Source: APXvYqwBVjsPbGBBhP5ZVvSPIZSSHx/Xzfdo7b8id4zHbReP84EdzxehZlurqqpezNNACpbcKL5o3Jdqu3aySrLPFcM=
X-Received: by 2002:a67:ee5b:: with SMTP id g27mr9846vsp.165.1560771356174;
 Mon, 17 Jun 2019 04:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190614082954.39648-1-yinbo.zhu@nxp.com>
In-Reply-To: <20190614082954.39648-1-yinbo.zhu@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Jun 2019 13:35:20 +0200
Message-ID: <CAPDyKFq-zb3aA7SjFPxx3-xDb+UUwEGG5EK1UW951LyQnBNopA@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: sdhci-of-esdhc: set the sd clock divisor value
 above 3
To:     Yinbo Zhu <yinbo.zhu@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yangbo Lu <yangbo.lu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jun 2019 at 10:28, Yinbo Zhu <yinbo.zhu@nxp.com> wrote:
>
> From: Yangbo Lu <yangbo.lu@nxp.com>
>
> This patch is to set the sd clock divisor value above 3 in tuning mode
>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index d4ec0a959a75..c4af026c3fba 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -824,9 +824,17 @@ static int esdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_esdhc *esdhc = sdhci_pltfm_priv(pltfm_host);
>         bool hs400_tuning;
> +       unsigned int clk;
>         u32 val;
>         int ret;
>
> +       /* For tuning mode, the sd clock divisor value
> +        * must be larger than 3 according to reference manual.
> +        */
> +       clk = esdhc->peripheral_clock / 3;
> +       if (host->clock > clk)
> +               esdhc_of_set_clock(host, clk);
> +
>         if (esdhc->quirk_limited_clk_division &&
>             host->flags & SDHCI_HS400_TUNING)
>                 esdhc_of_set_clock(host, host->clock);
> --
> 2.17.1
>
