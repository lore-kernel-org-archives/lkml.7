Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0B4C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B96208CA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H5bN1m2R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbfFLNhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 09:37:03 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:45009 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfFLNhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 09:37:02 -0400
Received: by mail-vs1-f68.google.com with SMTP id v129so10209922vsb.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 06:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BABX3wm/uPiARrYOfymklE5+rTe/+m67h9A9bynznZ4=;
        b=H5bN1m2Rb/0vMGayybrruflAJpUjiSXjFE5PMmPknSuP/U3a8mDUG2Zg8VPSHqZDXB
         wb89ojyDVROM4TpGtkmoyLW1tzr6ulYZZ5cLhvUBt4WVSt1qL1yAQZg/j8iguw0sIJt2
         +xaAht0S3qLeOSCZxIc+E27U96xZBjPww6yBK25KPgYYfH3ZpndZ1J8K4M1VvkEs6f67
         N17TYLOwqI42UumjlHT+xX9Gr7XXlZ4tyITasWGKer17d6rEoJGPiQGiuzpQU1pfCpsn
         tc+7cTSwYMpEfnl7NhiY6H56z7VccXoO8I5RGkcP1cDo4kVXs6bruXCtmVzg4Zw1Rrs1
         Chqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BABX3wm/uPiARrYOfymklE5+rTe/+m67h9A9bynznZ4=;
        b=XxCznEy6EDZJ5LpqbibwRHszXYgMT7VoRMFAZvJ1xUq0aTlPSwqQCQGJHLKciRvCg2
         U28AufSOR4P6ppVqI1htc9Y4TLrRwsvoAWjpPt4HcFsGEDM3+vmT0T4IiP9E4fJVty2w
         VauASZW3LcO2QYIZHc4QVcvSyTNWg3Yy2Ua/NLSW57gF+WQsPmq13aSaxsfp922xAN5K
         JEumhDgcSVV1OY0rwjEli8hZwJ9WMlxAcwiRLkqinuSU4NDV/z2JWhTKQs+k0QFH+box
         HuOfu0BDdPFCgsBYrjtvnWpe1eipMUHI4oLESNgrKeIAKnl9RTUVjwPRFDY4p9LSw+/A
         RmbQ==
X-Gm-Message-State: APjAAAWk6bHdFGAjOJNW53chv1Rry7k89rNj/gXt7uDzzEV9F6BKyl5o
        ZVZdx7/o5/5C1Kk4PeUTWheM7+oCoyAcL79dyG1wYA==
X-Google-Smtp-Source: APXvYqwipTQ2cy0/IremT2vBBV9KiYlUsGqRj77DQjXEwmIHkmMN8TbkFbYRstALSE7Y2iflpWorEFNWthgd/9f2EfY=
X-Received: by 2002:a67:ee5b:: with SMTP id g27mr10792054vsp.165.1560346621530;
 Wed, 12 Jun 2019 06:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190610185354.35310-1-rrangel@chromium.org>
In-Reply-To: <20190610185354.35310-1-rrangel@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 12 Jun 2019 15:36:25 +0200
Message-ID: <CAPDyKFppNgL_kZPV-QS6ZiJErde5ea8Nj-sQTy_vXhW9jfXhpg@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: sdhci: sdhci-pci-o2micro: Correctly set bus
 width when tuning
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "ernest.zhang" <ernest.zhang@bayhubtech.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2019 at 20:54, Raul E Rangel <rrangel@chromium.org> wrote:
>
> sdhci_send_tuning uses mmc->ios.bus_width to determine the block size.
> Without this patch the block size would be set incorrectly when the
> bus_width == 8 which results in tuning failing.
>
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> ---
>
>  drivers/mmc/host/sdhci-pci-o2micro.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index b29bf4e7dcb48..dd21315922c87 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -115,6 +115,7 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>          */
>         if (mmc->ios.bus_width == MMC_BUS_WIDTH_8) {
>                 current_bus_width = mmc->ios.bus_width;
> +               mmc->ios.bus_width = MMC_BUS_WIDTH_4;

This looks wrong.

mmc->ios.bus_width is not supposed to be updated by a host driver, but
rather the value should only be read.

>                 sdhci_set_bus_width(host, MMC_BUS_WIDTH_4);
>         }
>
> @@ -126,8 +127,10 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>
>         sdhci_end_tuning(host);
>
> -       if (current_bus_width == MMC_BUS_WIDTH_8)
> +       if (current_bus_width == MMC_BUS_WIDTH_8) {
> +               mmc->ios.bus_width = MMC_BUS_WIDTH_8;

Ditto.

>                 sdhci_set_bus_width(host, current_bus_width);
> +       }
>
>         host->flags &= ~SDHCI_HS400_TUNING;
>         return 0;
> --
> 2.22.0.rc2.383.gf4fbbf30c2-goog
>

Kind regards
Uffe
