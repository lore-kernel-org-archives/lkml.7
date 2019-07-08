Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30647C606AF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D55CE2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y5NBAw/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbfGHL4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 07:56:13 -0400
Received: from mail-vs1-f43.google.com ([209.85.217.43]:45289 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfGHL4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 07:56:13 -0400
Received: by mail-vs1-f43.google.com with SMTP id h28so7998976vsl.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 04:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xo7o6HVE/xn9qpops1z0+On7QRm5OAbCvXp9M/IoyTA=;
        b=Y5NBAw/pna6vKqJfoE2mDarvSAMM8zgFKcnRLHFCnbiwZCesih3Vun1ny1PBvJy4qZ
         rSycH4u2/6AdJrZ1OBqnBOnz/F0F76rwQdGww3xhRMAiuy2w/7jH4dy2K7kRpCrkZdxz
         8/0k2DwbVkMkoSyn8zu7WRJd/J84pIJkfTrGmWp7pTnc5gJwmQQRa6k2iiVRTcqgDDhU
         I/qvq//SP663yolGX+Iafi2gtf70L4/xiev791KSBgr0lmUnlv/qTOnQKfoyhbBg0Q+7
         U/SjWek2W5ccVA8sZVrslUM4M2nJ9J48orRhzpti8BlG+fy6DtWuqTzCJYY4EuaaGZTa
         FBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xo7o6HVE/xn9qpops1z0+On7QRm5OAbCvXp9M/IoyTA=;
        b=pDv6rEpXIC9Ve0n6bOPjqidCXM1xbGT2JC1v3HIDD648xV13ffJl1d4fiurzlndkK+
         9WlntNvnhiqXMoUkVaZkOY+ucC2gvsSAN7SWRt794si9CzpeJj5AcTD7kBHIklcS8A+H
         NHiZOtCsns5A4N58tgXS0Qknn/RmN3gRDUyHVNgqzvd+itj2fIsqTjOT6wYbhf/JjQTG
         GCHBYeFJBBiXP9gPE3lZFvom7HPa3wDHirCnBRgWYJl4g/L9k7kZ2N1N05lQzCJDwzpu
         VODsZXyDtKEk76DDx2NONdwpK0v4EDcgnkQv/wjzTa44yxIZMCNtOjwMaIOFe/KfmqK4
         gwuA==
X-Gm-Message-State: APjAAAVzpnnMZBYbBP7rKE1JmGhz0A9Fk4v3Ra1RmTiCL9WIV2f5q2QC
        mQASusEskiU699fXMxuuiZJuE+F7rEibGupEqj7Xzg==
X-Google-Smtp-Source: APXvYqwu+R5WI9AMsqmD+oHlyrV3nJ+8UBciZuyzYzNb1YU8XDOCPtFx/01zRg+hguwOvH6nfh4HxvYtpTAKU7F2qg4=
X-Received: by 2002:a67:ee5b:: with SMTP id g27mr9881012vsp.165.1562586972066;
 Mon, 08 Jul 2019 04:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190628040751.46196-1-yuehaibing@huawei.com>
In-Reply-To: <20190628040751.46196-1-yuehaibing@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 8 Jul 2019 13:55:36 +0200
Message-ID: <CAPDyKFp=7qPeTgx8tJDHaAvg+w+1z8iWExVUeOyRE=5cud8KBQ@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: sdhci_am654: Make some symbols static
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jun 2019 at 06:09, YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fix sparse warnings:
>
> drivers/mmc/host/sdhci_am654.c:192:6: warning: symbol 'sdhci_j721e_4bit_set_clock' was not declared. Should it be static?
> drivers/mmc/host/sdhci_am654.c:261:18: warning: symbol 'sdhci_j721e_8bit_ops' was not declared. Should it be static?
> drivers/mmc/host/sdhci_am654.c:284:18: warning: symbol 'sdhci_j721e_4bit_ops' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci_am654.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 3b39481..bb90757 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -189,7 +189,8 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
>         }
>  }
>
> -void sdhci_j721e_4bit_set_clock(struct sdhci_host *host, unsigned int clock)
> +static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
> +                                      unsigned int clock)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> @@ -258,7 +259,7 @@ static const struct sdhci_am654_driver_data sdhci_am654_drvdata = {
>         .flags = IOMUX_PRESENT | FREQSEL_2_BIT | STRBSEL_4_BIT | DLL_PRESENT,
>  };
>
> -struct sdhci_ops sdhci_j721e_8bit_ops = {
> +static struct sdhci_ops sdhci_j721e_8bit_ops = {
>         .get_max_clock = sdhci_pltfm_clk_get_max_clock,
>         .get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
>         .set_uhs_signaling = sdhci_set_uhs_signaling,
> @@ -281,7 +282,7 @@ static const struct sdhci_am654_driver_data sdhci_j721e_8bit_drvdata = {
>         .flags = DLL_PRESENT,
>  };
>
> -struct sdhci_ops sdhci_j721e_4bit_ops = {
> +static struct sdhci_ops sdhci_j721e_4bit_ops = {
>         .get_max_clock = sdhci_pltfm_clk_get_max_clock,
>         .get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
>         .set_uhs_signaling = sdhci_set_uhs_signaling,
> --
> 2.7.4
>
>
