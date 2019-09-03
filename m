Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F23C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F6222D6D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fa33lR9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbfICOwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:52:18 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38952 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbfICOwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:52:16 -0400
Received: by mail-vs1-f68.google.com with SMTP id y62so11470813vsb.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 07:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZwoxSskeP0023k+XOLK7qG1mfuenS/a51g77gLnDidE=;
        b=Fa33lR9t7UgiD8FO8rUeW2DVG3Nv4mjXNYBCR/EGzrJTPKb6tzmtE0h96gDu5DZJbk
         dzVwPLR8SXffeq49jjnD/jCRKWKvOW71V9cVVKCBGKhGwQFZmDiPEXuNRk/DMjApoXTw
         +eQQoOLHW8BH+SR8Ak8nD1aIA94HNlogEgnlmn3OqopmA1e2pdiR4L4LKJ2QoYe+Qp+l
         UvQIjcQqPScxkltSFzRxFI7O+VwNc+lIVFFTvkd09gL2k1YXZ5NzUczfyXJXocIIWET6
         CBEJWXJ2bmtX+YI0J2a56uha5NjAX3ldZE+OnnRZT/sYmnSmFel9Xul35wtutHem3YOL
         U1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZwoxSskeP0023k+XOLK7qG1mfuenS/a51g77gLnDidE=;
        b=RC0+1kLekGfVS+eJZvo8hnFpSvUHIKE75aw2834q3PluuQ4tXcjgPwPYJyRW5US/c0
         bA4DUPTqWJvzTYa6H2iNzMsgjBF+7v6ZGvjU6dpv9q8wBe2KunPLY0QKjBiz6zroCTRA
         uZn217q2ZuHBLTHY0ZORbBfiWml27H9NV6+onyYblWTj+6PKwBTODKM23+ASIeBuDM1m
         tsYAYuzJ6HKswRYsl/8T+faLi6og5vjX/g/qB4gWOqp9aGW2+IXswrPeS1tyNFZYCdPu
         2xrDN/06Um8DBKRyuuBJz801cTIf/Z+orL2dbBunLKdZ9LEcJ6lZekPpckUzEzMZQD/u
         +V/A==
X-Gm-Message-State: APjAAAUJs1MKCWx9seo5/NxuI2rqaperk1l2q65Dd7DE7Dca+i9/AVdy
        3ePBc6eyL2oTA/0C1mt4mygA2gHs3/OybTkohpaAMQ==
X-Google-Smtp-Source: APXvYqxyKdAe+67a84cVralvrTfBWlQLBTBDbGFtaZa2djugNbwh3dVLkKbYtbj6MuCPe9Vu0KOOjWZI1bOfSON+L/w=
X-Received: by 2002:a67:983:: with SMTP id 125mr13634122vsj.191.1567522335355;
 Tue, 03 Sep 2019 07:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190903115114.33053-1-alcooperx@gmail.com>
In-Reply-To: <20190903115114.33053-1-alcooperx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 3 Sep 2019 16:51:39 +0200
Message-ID: <CAPDyKFqaNBH3Thwy1O+KXkcsgM2gMrm9zNGYWH8vVP+Y2vSLdA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Fix incorrect switch to HS mode
To:     Al Cooper <alcooperx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2019 at 13:51, Al Cooper <alcooperx@gmail.com> wrote:
>
> When switching from any MMC speed mode that requires 1.8v
> (HS200, HS400 and HS400ES) to High Speed (HS) mode, the system
> ends up configured for SDR12 with a 50MHz clock which is an illegal
> mode.
>
> This happens because the SDHCI_CTRL_VDD_180 bit in the
> SDHCI_HOST_CONTROL2 register is left set and when this bit is
> set, the speed mode is controlled by the SDHCI_CTRL_UHS field
> in the SDHCI_HOST_CONTROL2 register. The SDHCI_CTRL_UHS field
> will end up being set to 0 (SDR12) by sdhci_set_uhs_signaling()
> because there is no UHS mode being set.
>
> The fix is to change sdhci_set_uhs_signaling() to set the
> SDHCI_CTRL_UHS field to SDR25 (which is the same as HS) for
> any switch to HS mode.
>
> This was found on a new eMMC controller that does strict checking
> of the speed mode and the corresponding clock rate. It caused the
> switch to HS400 mode to fail because part of the sequence to switch
> to HS400 requires a switch from HS200 to HS before going to HS400.
>
> This fix was suggested by Adrian Hunter
>
> Signed-off-by: Al Cooper <alcooperx@gmail.com>

Should this be applied for fixes and tagged for stable you think?

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 61d845fe0b97..068149640ecd 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1858,7 +1858,9 @@ void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
>                 ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
>         else if (timing == MMC_TIMING_UHS_SDR12)
>                 ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
> -       else if (timing == MMC_TIMING_UHS_SDR25)
> +       else if (timing == MMC_TIMING_SD_HS ||
> +                timing == MMC_TIMING_MMC_HS ||
> +                timing == MMC_TIMING_UHS_SDR25)
>                 ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
>         else if (timing == MMC_TIMING_UHS_SDR50)
>                 ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
> --
> 2.17.1
>
