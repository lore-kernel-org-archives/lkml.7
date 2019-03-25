Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6BBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6C12084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rhX9I4Xu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfCYN1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:27:40 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:38812 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbfCYN1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:27:38 -0400
Received: by mail-ua1-f66.google.com with SMTP id d4so2962140uap.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 06:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JLnR71Z2kfLVjXiIDyKCEvvb5JgntoZoJbPKm7dtaek=;
        b=rhX9I4Xub/iMrS65nsr3i9hsceiPX3vf2DiSf7jTK+SQprK9VqvPsBkMD0kHqlS134
         2xGKkhGT16CxG0zoBKNkt69f2Ujbe7cp2bcAxhpac+nW3xCRDfJMbTUlBrYwoUUtgXXS
         ID86kRAH7l2SuBlflBpf28b9TLOFjCP2d2EIZySLiu8yXrHysataOSnguwn9AoW7vzkN
         IIqmRAbw4oETMVPq6VLmHzKfj3yoMvYHJJFEsoDm4DcKc+CGPajCQ9uPeoQjxEAVUUGo
         e1RCAw0v6X/TAlDHeZNuMVh0p415t/obibdtBLvwJT1jykobFGjGMjx6QGzUsWJcRUW6
         enrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JLnR71Z2kfLVjXiIDyKCEvvb5JgntoZoJbPKm7dtaek=;
        b=KJv92ukDtMWI1Co1VLgtM4OgCbR+COJBoyOCGygZoWXxkzvWjrkUnLh3TbblzD2Vwy
         ji84zQF4JaerIAEc0L5jcGrujw+Xz5uX3BkKfGGBGWl9S5q+Z4qdng5cylVwn88ellSd
         14bQoXcNDQnFrYaXCuLm7eYYQLXZoJbsso3qybXG/+dDJqa2rjGSJcLN7mZenNB46Erg
         5qnVlmVaSzo3UjgqlEEBEFMfr6e7Q1hhRKibgJd+qA5QmWjPdmtc1YJPQbqK3uq09Y1/
         EbP3E/5urABEqROZ2Jl9McHlF9T5EbbpRQ7bBpmDiOmK9jo8XMK8LFlyX7ZbFT2uumjV
         QYqQ==
X-Gm-Message-State: APjAAAVjk8l/rqarEvs8mvZohBtGRpM968yI0AdS1oRZ4XyyrADpmH4Y
        MHTRNYyc94RbxThMErnddgh+Qo68q/oI+zc51eZ1Vg==
X-Google-Smtp-Source: APXvYqw/8vYc+6Z4uklzbcVbqX32RhphQsy/BF7Y5WIqmLNeVGtvSZ6xbRP2ex99mDPnpbi4/Hth2uox9pTvf6Ax0VY=
X-Received: by 2002:a9f:3c01:: with SMTP id u1mr14398484uah.19.1553520456734;
 Mon, 25 Mar 2019 06:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <1553402727-23130-1-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1553402727-23130-1-git-send-email-skomatineni@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 25 Mar 2019 14:27:00 +0100
Message-ID: <CAPDyKFoBJBunAU_cBocmNGSN5DwDYaLVd_BR6MYwysQKAwUkxw@mail.gmail.com>
Subject: Re: [PATCH V4 01/10] mmc: tegra: fix ddr signaling for non-ddr modes
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

On Sun, 24 Mar 2019 at 05:45, Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
> ddr_signaling is set to true for DDR50 and DDR52 modes but is
> not set back to false for other modes. This programs incorrect
> host clock when mode change happens from DDR52/DDR50 to other
> SDR or HS modes like incase of mmc_retune where it switches
> from HS400 to HS DDR and then from HS DDR to HS mode and then
> to HS200.
>
> This patch fixes the ddr_signaling to set properly for non DDR
> modes.
>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Applied the series for next, except patch 5 and 10 as those are from arm-soc.

In regards to $subject patch I added a stable tag.

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-tegra.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 32e62904c0d3..46086dd43bfb 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -779,6 +779,7 @@ static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
>         bool set_dqs_trim = false;
>         bool do_hs400_dll_cal = false;
>
> +       tegra_host->ddr_signaling = false;
>         switch (timing) {
>         case MMC_TIMING_UHS_SDR50:
>         case MMC_TIMING_UHS_SDR104:
> --
> 2.7.4
>
