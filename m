Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881F4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550832195D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nuc/Ty7j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfCUKdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:33:33 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46763 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbfCUKdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 06:33:31 -0400
Received: by mail-vs1-f65.google.com with SMTP id w26so3324468vsk.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 03:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aZQ8/8MhDLy+D1rcVkis2Mvu5gJiDkVbzo8EgLSxyiQ=;
        b=Nuc/Ty7jGZE+T2dkWTKOROGWyFbHWUO241duNxx1Nshjl1m9FV1odhuZ1EPCO6gc0E
         FY7t9MsnxpFEUarcFT+ZVHTjeK6laKQInA02mYGFK9YgiqZawlj2qdLEO6NZGBQeE+ho
         7PUJcDvRiTb6zB79e1kj7tnvj1yf9MkTOVHDLCw8xbWhiuh5oaR2BKigvpSKo17Bd/u8
         g6r88rMHzRx5+wW8ECNOpmY+6m+MqLw19zLjk0VCsl/Zn3J5w/NlWwLqO4ULyLGxvuPv
         lbprB1Dxqz+vFk5cyUuY0viHpbq05VJ3LYvORoKHNIkAJQ0wrA0u5TOuqGv3RvIW48yC
         UNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aZQ8/8MhDLy+D1rcVkis2Mvu5gJiDkVbzo8EgLSxyiQ=;
        b=uWr+cn4cZ3ftj6TObTtDJ6KCIAYzJ+ixLKj39lx2OAE7VnDOHJH0UIfvOljFfwgtl/
         J+qzhpox9pmcrcX2nJaXTvrxrKlhuEbKqtH3gLMhaSS6f/gA2yCV6pKdnkI4K8WdPYYV
         zdavugpxkctvwRm+LX9rNu5tI8Ea+EPcwsE62lIVtg2U/Yse3Pkv27DS8C4RF75RhReq
         mA6FXOzoMMnRxrst7SBL2xk9qRpf3sSttqLphwrJlblS/KY/1KnXItmN6wEcsXizQ4EM
         KT16Vd4nq6MzbvWMcPzNa73Uldo2kTBgnJGA6fCgNwOquoqGBJCxV4e3frCgUV8a36P6
         VaKw==
X-Gm-Message-State: APjAAAUZVowKjNru0wSzVNqKgnbI8UI+Wt5Rvd5ucAZT8US3nVnexkRq
        ezCXyfOlT/pvo6EJibgyq6Py0ihJf/hHIuyT5+opCA==
X-Google-Smtp-Source: APXvYqxscuQ4vDFC/TlmF8nM+mpRsnJorJFZUDQ8qjo70+x9H+waK9DJqD3wjrvz2RY8IzSdf3WEZQhZRSMwPvmV7hc=
X-Received: by 2002:a05:6102:157:: with SMTP id a23mr1489488vsr.34.1553164410305;
 Thu, 21 Mar 2019 03:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <1552513552-23423-1-git-send-email-skomatineni@nvidia.com> <1552513552-23423-5-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1552513552-23423-5-git-send-email-skomatineni@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Mar 2019 11:32:54 +0100
Message-ID: <CAPDyKFq4ZVaMmvefuVqGs84E7xg5VgvU-Ecq1MYJdmBhuEm7xA@mail.gmail.com>
Subject: Re: [PATCH V3 05/10] arm64: tegra: fix default tap and trim values
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, anrao@nvidia.com,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019 at 22:45, Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
> Default tap and trim values are incorrect for Tegra186 SDMMC4.
> This patch fixes it.
>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Is this a fix and/or for stable?

In either case, I am leaving this for arm-soc.

Kind regards
Uffe


> ---
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> index 97aeb946ed5e..472f55fe9488 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> @@ -317,8 +317,8 @@
>                 nvidia,pad-autocal-pull-down-offset-1v8-timeout = <0x0a>;
>                 nvidia,pad-autocal-pull-up-offset-3v3-timeout = <0x0a>;
>                 nvidia,pad-autocal-pull-down-offset-3v3-timeout = <0x0a>;
> -               nvidia,default-tap = <0x5>;
> -               nvidia,default-trim = <0x9>;
> +               nvidia,default-tap = <0x9>;
> +               nvidia,default-trim = <0x5>;
>                 nvidia,dqs-trim = <63>;
>                 mmc-hs400-1_8v;
>                 status = "disabled";
> --
> 2.7.4
>
