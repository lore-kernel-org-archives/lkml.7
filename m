Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A77CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF077218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GB4VqiUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfCUKdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:33:11 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40418 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbfCUKdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 06:33:11 -0400
Received: by mail-vs1-f65.google.com with SMTP id z18so3350962vso.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 03:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oZrnXSxv+k8pHkhZLIgJFzD8ArnkTbjPYr0AE7LyOx8=;
        b=GB4VqiUUQH/uqWgHkQt+bxYtO3+Mxwg2S5z39OFT9/7rNes3Xcd0ivAQnwq7DgWAIv
         hY0jvggYYsYz8Kb9pOstVsjljvUiZsEY5y/ZTy/I1zDbKHIWPeJtUwUSJ0bPYMizGTEg
         7YKbewp6JC9zofvFJYAb1nyQOiiqw+IPnIjuDwMzD5bKzfXc5DE5H3BMxsvAfTmKSC6X
         eHBiNf6n6LSGrboqf8XGfuaY68NFbOsVmWIcn/slt5SfHyPO/Ry3P2t1SacM2eARYHch
         bo2HSm6C1iAUTrj3rEzny43/OWZFxx9049YGJDRj+2+UUq07zWNsxHp0qowN41SrtVtF
         GPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oZrnXSxv+k8pHkhZLIgJFzD8ArnkTbjPYr0AE7LyOx8=;
        b=M8/LE90La3EYjV+pwJV7GdUZxTu97zp8JRzIf0IHJcWStUP7esLjvGhXijN8NZSHKI
         s/niuLXraaHjKHbmMehttN2f9X5xDDQx2RK22jo5h2KWU+pcoLpi3bC6bVuf04rXXRpX
         tVPR/Hmu8iVrz2P9rQ7p2HMzUIY33f+2jJb6pxUObWXUA94Gvs5+BeHTZSFmDgHDZvSA
         KRa5WZCgh9MWddDUt54G/ZtIUfXvHNAhGzFvQUZ4EB2thLBewYvrembA7GsAZS0Dtv5L
         sQM2kPRFVW/O3vCQb6aHCZ4U9pd4VqVcyd8wnG8zTbFleqkrUy1d5HLD1maLhqq5DI7P
         f9LQ==
X-Gm-Message-State: APjAAAUTVd+p4Wed9Es1s6qU5lVghXGBFJsWHKTCBTAN6D/JVwr9Ls93
        Z/qEeyJVUhOjrFBQPnHYouL9WQBENFJV2clDfv94Fw==
X-Google-Smtp-Source: APXvYqz8X2gsOqnhHE45RXJEMXRzdpWdkLyy8mubHlWVIjQWU6q13QnF2vmH6J3tuBYKSlPOuUKnD/H+vQcacgvALz0=
X-Received: by 2002:a67:c902:: with SMTP id w2mr1412864vsk.191.1553164390102;
 Thu, 21 Mar 2019 03:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <1552513552-23423-1-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1552513552-23423-1-git-send-email-skomatineni@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Mar 2019 11:32:34 +0100
Message-ID: <CAPDyKFp30v1H0KfPFeOc5Ut1dW5tec7cT7NFk6j0VT+DWkAODw@mail.gmail.com>
Subject: Re: [PATCH V3 01/10] mmc: tegra: fix ddr signaling for non-ddr modes
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

Is this a fix and/or shall I tag it for stable?

The series looks good to me, however I am awaiting two more acks from
Adrian on patch 2 and patch3.

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
