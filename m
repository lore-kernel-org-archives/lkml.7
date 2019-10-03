Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F8FC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4066A2133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FuER+l0g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbfJCKB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 06:01:57 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45788 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729643AbfJCKBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 06:01:55 -0400
Received: by mail-vs1-f65.google.com with SMTP id d204so1258885vsc.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 03:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bQZgMiPBlch+da9eCpuVvMh7cDd98498ZGUQ3xlwUWM=;
        b=FuER+l0gj2hl/fxpTFxvQ3nYlHiIWdyz8MM9HC+XQxx5GTIH0AH9LvMxKjOxn40Vro
         o+KyzVClab/FiyZjLNkL5uvla+jp3D7dYdVVtEYEy44JiAKab3nvxz4nJd6Ys5vh0SUy
         royoVNCuLwNLyUgLj8W8Kuh10mXwzsJo9jNwQvoyIDXn2nmCgvO3lybBQKlhuooIgcTk
         MTwDkH6MQUPFv7fjj6JIj4n7fE/l+oVA44YgZLiT1EaCIAO6iROTdyF8i9qsSVZy9x6O
         L44zkMJjvgyat95nf/WiY2dPlBJluv73B32vxzs2rYOxLxVvrEFQWW3MjOncsHTUgB4g
         T4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bQZgMiPBlch+da9eCpuVvMh7cDd98498ZGUQ3xlwUWM=;
        b=Med7Ur9LEyoB8LAT4tNiZmbgzB0l9oVH19qGHP4qWFcK54W2FH6/PstG+s25wboXn/
         MrR97vVXl0bLYOdlcjVrvcYQS33emfvWWL+yHZoZdcVDc4yvrFhG8snEjLtytgorkCdv
         gFsUUqLGSMPOk8rx/sUTbyUtBatfxbQmnOCrUuv+ytoDsLy+QSVzkil4JjT0QI1ed5MG
         gasub4p4ZbVMmsgAkEObGvoVC4syhHUECISOnwT/Z8qYvVFJl/KequHjPvwEWO1aFzQM
         PqX+xM1uFtT54b8HRX7/xZ9VPr1eXiTcBrsWGjRLS2E9h+hhdswM8ciZdzeu2Rh4yWoT
         tsQQ==
X-Gm-Message-State: APjAAAVtJRCqm6aBIT2knvgr4DuZnDXM7tbaIpTv36z0Ak/In/sQwgCG
        AlXkwwOA3F6bCQNcvMuosuz02a8hCBUAdEx9RWy31Q==
X-Google-Smtp-Source: APXvYqzuSKcUmTZ9N2NNO3rEXGfkm5tGlVKGyINBteWvalYdV0+g5zqRsur4hFkbU0QLK6GOzgBpgwJYcfHAKQXzTWE=
X-Received: by 2002:a67:e414:: with SMTP id d20mr4534032vsf.191.1570096914812;
 Thu, 03 Oct 2019 03:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190916154546.24982-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190916154546.24982-1-manivannan.sadhasivam@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Oct 2019 12:01:18 +0200
Message-ID: <CAPDyKFqsZ1mZ53b9wLruATzi+ymFrUCLhxzx7NFUq48p5w0Gtw@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Add SD/MMC driver for Actions Semi S900 SoC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, thomas.liau@actions-semi.com,
        linux-actions@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Sep 2019 at 17:46, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Hello,
>
> This patchset adds SD/MMC driver for Actions Semi S900 SoC from Owl
> family SoCs. There are 4 SD/MMC controller present in this SoC but
> only 2 are enabled currently for Bubblegum96 board to access uSD and
> onboard eMMC. SDIO support for this driver is not currently implemented.
>
> Note: Currently, driver uses 2 completion mechanisms for maintaining
> the coherency between SDC and DMA interrupts and I know that it is not
> efficient. Hence, I'd like to hear any suggestions for reimplementing
> the logic if anyone has.
>
> With this driver, this patchset also fixes one clk driver issue and enables
> the Actions Semi platform in ARM64 defconfig.
>
> Thanks,
> Mani
>
> Changes in v4:
>
> * Incorporated review comments from Rob on dt binding
>
> Changes in v3:
>
> * Incorporated a review comment from Andreas on board dts patch
> * Modified the MAINTAINERS entry for devicetree YAML binding
>
> Changes in v2:
>
> * Converted the devicetree bindings to YAML
> * Misc changes to bubblegum devicetree as per the review from Andreas
> * Dropped the read/write wrappers and renamed all functions to use owl-
>   prefix as per the review from Ulf
> * Renamed clk_val_best to owl_clk_val_best and added Reviewed-by tag
>   from Stephen
>
> Manivannan Sadhasivam (7):
>   clk: actions: Fix factor clk struct member access
>   dt-bindings: mmc: Add Actions Semi SD/MMC/SDIO controller binding
>   arm64: dts: actions: Add MMC controller support for S900
>   arm64: dts: actions: Add uSD and eMMC support for Bubblegum96
>   mmc: Add Actions Semi Owl SoCs SD/MMC driver
>   MAINTAINERS: Add entry for Actions Semi SD/MMC driver and binding
>   arm64: configs: Enable Actions Semi platform in defconfig
>
>  .../devicetree/bindings/mmc/owl-mmc.yaml      |  59 ++
>  MAINTAINERS                                   |   2 +
>  .../boot/dts/actions/s900-bubblegum-96.dts    |  62 ++
>  arch/arm64/boot/dts/actions/s900.dtsi         |  45 ++
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/clk/actions/owl-factor.c              |   7 +-
>  drivers/mmc/host/Kconfig                      |   8 +
>  drivers/mmc/host/Makefile                     |   1 +
>  drivers/mmc/host/owl-mmc.c                    | 696 ++++++++++++++++++
>  9 files changed, 877 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/owl-mmc.yaml
>  create mode 100644 drivers/mmc/host/owl-mmc.c
>
> --
> 2.17.1
>

I have picked up the mmc patches for next and as Stephen picked the
clock patch, the rest are now for arm-soc, I guess!?

Kind regards
Uffe
