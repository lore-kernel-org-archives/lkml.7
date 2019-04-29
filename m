Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D635C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 10:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B0A2087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 10:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NWrXGb7V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfD2Kcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 06:32:35 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:37810 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfD2Kce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 06:32:34 -0400
Received: by mail-ua1-f65.google.com with SMTP id l17so3314969uar.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 03:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8b2cEiOwIFkqDrQwWdAjt6VF1fB8qiQz/fciHm7Mse8=;
        b=NWrXGb7VRDf7VArwNbZq3mfkZ/mEzdLLQOnDoNGqkHD+qe5I+el9Byc7lTeBzTWxV1
         Zcoq5eybd9Y96Vp2t33F73F8kSNFxenatKNwy+u1zdrLGXMOh0t78xdIek371AXeeK+l
         AvqudcclwmvCCZ8TExoiu4OF+pGfNardPP/IywWZwIM94wA1qdMiOpH5c2TU8AKf6M0G
         eg9gFxSk8ndkMUT87GMxIP67sT+3YPIElkGNr+0XJlRt4A6fv2/H1Wr6uY+wjMI+FFF3
         QIqWXkQeMvJZN3INJiqENsnZrrcLg31u/S7KOuuEwve7wACJVc3A6QDklIyKODxDmvmK
         ODFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8b2cEiOwIFkqDrQwWdAjt6VF1fB8qiQz/fciHm7Mse8=;
        b=ukU38pIPO8IQESbSsrI2nyK9u45+rgknX/KE+ksfW88O/sfArlWuFdL1eZ4prXmcwB
         d+GyoNllzzwMfEEK8/kWIwktiVomeEaAcPuhRVahoBRQpJDs3TheH06NMvBQHbY1rhEZ
         1tppM0tpchTYyuuTghFPsTyHLIKpLml5cgoU0d7DvuuLKvS2tSkJsKdpYmQOE1PNKCxG
         b5g2LAWS0Q6J2/hVziZGpBDZeZ4eL2lhVq3serZ+0hOxlwM12+zlFO28dwqDa/peprsF
         N0jQG+pBjm3QlTcCY+7dZtlsrTK6OcX4q28DOKB57o0sHnIVSbfUZTL6WKCNz83Bfv96
         HAuQ==
X-Gm-Message-State: APjAAAUZgg0mcOeyyG0vsdcRfo9aBjiljXoa6vuC73Ev8w2WAJik9zwv
        qAcioNR9gsuqelFQEOXBIE554hf2F7y6cBHTH1QZQA==
X-Google-Smtp-Source: APXvYqxb7hueDVUMb3fMwLwbCdvQGzw8jp5PicLihCwM99lR82KoE8Y14rvJ12sRpOS8QvSPQaWEH10powEv6UMe7HY=
X-Received: by 2002:ab0:2399:: with SMTP id b25mr30989522uan.129.1556533953648;
 Mon, 29 Apr 2019 03:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <1556244405-15863-1-git-send-email-orito.takao@socionext.com>
In-Reply-To: <1556244405-15863-1-git-send-email-orito.takao@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 29 Apr 2019 12:31:57 +0200
Message-ID: <CAPDyKFrBJeBNOPh9H3Yn-6-um2B-9Gt6_pW8Qh0ZGQB26-tq+Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-milbeaut: add Milbeaut SD controller driver
To:     Takao Orito <orito.takao@socionext.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jaswinder Singh <jaswinder.singh@linaro.org>,
        sugaya.taichi@socionext.com, kasai.kazuhiro@socionext.com,
        kanematsu.shinji@socionext.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> +
> +static void sdhci_milbeaut_power_off(struct sdhci_host *host)
> +{
> +       struct f_sdhost_priv *priv = sdhci_priv(host);
> +
> +       gpiod_set_value(priv->power_gpio, 0);
> +       udelay(1000);
> +}
> +
> +static void sdhci_milbeaut_power_on(struct sdhci_host *host)
> +{
> +       struct f_sdhost_priv *priv = sdhci_priv(host);
> +
> +       gpiod_set_value(priv->power_gpio, 1);
> +}
> +

As stated for the DT doc patch, please use a fixed GPIO regulator
instead. In this way you will also get a the OCR mask based upon the
GPIO regulator, which is parsed out by the mmc core when sdhci calls
mmc_regulator_get_supply().

Otherwise, this looks good to me.

[...]

Kind regards
Uffe
