Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F1BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17E721873
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfCUIEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:04:07 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35241 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfCUIEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:04:06 -0400
Received: by mail-qt1-f194.google.com with SMTP id h39so5668852qte.2;
        Thu, 21 Mar 2019 01:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B5aSoB8DpBn5FH75X4aNsiML3d74yNl4DxW1A3KfLQs=;
        b=KxFaXqM9At8HScoXbf5reE63gnM4Nklt/rdEcMjjtEhfifBT2xQMtdc0HkSJRwI+lW
         0EUvH3/qvEkQ+5WXSuXT1iuemA/EHX12djmFht5K2cfuOfNvCSwlXvMRvuanp+e2VBgT
         yCamnIqdHDbNu4gf9so/1L70B/gJrCbE9Yd8mKmP6iBg+RrGMPQ/HJ2p2yX79kDP0zb3
         lxQPGimEB6gjzUh7ParoxLEFLDdoAlkgJdwHQTktIzOdVVEGLYjTnM+NF41qqyqs09Kw
         Ztz0POwFK4EssJqEPc0wZ/maaAWvuzuXEvWlsUPZ2j9uJqsfwI5sypyYI6tG5RwKsoGo
         F5Ng==
X-Gm-Message-State: APjAAAXybAJikFrfRGBOn0rVUsCMUnnUSp37U9mjoKRSmqsndpoJ1MC+
        tXAJyzoOFBzFOdojfI1XqdfQuo8JG6a4ha8r8bA=
X-Google-Smtp-Source: APXvYqwM9aVu2KtnPm4+zSpXvR/9QE4g7cIhCCmcHFS7/nHor3tj3WP1z/jFTdVqklQFuobFTDJhvPa0aTnYidrQ3aA=
X-Received: by 2002:a0c:9487:: with SMTP id j7mr1920428qvj.180.1553155445400;
 Thu, 21 Mar 2019 01:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <1552342688-6663-1-git-send-email-thor.thayer@linux.intel.com>
In-Reply-To: <1552342688-6663-1-git-send-email-thor.thayer@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Mar 2019 09:03:48 +0100
Message-ID: <CAK8P3a2yH+6idKS-n=t+JkQRyUK0nU_2qiJaQktQP9p_3y_86w@mail.gmail.com>
Subject: Re: [RESEND PATCHv4 0/6] Add SOCFPGA System Manager
To:     thor.thayer@linux.intel.com
Cc:     Lee Jones <lee.jones@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Olof Johansson <olof@lixom.net>,
        David Miller <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Networking <netdev@vger.kernel.org>, soc@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 11:15 PM <thor.thayer@linux.intel.com> wrote:
>
> From: Thor Thayer <thor.thayer@linux.intel.com>
>
> Add MFD driver for SOCFPGA System Manager to handle
> System Manager calls differently for ARM32 vs ARM64.
> The SOCFPGA System Manager includes registers from several
> SOC peripherals.
>
> On ARM32, syscon handles this aggregated register grouping.
> Implement System Manager calls as regmap_mmio similar to syscon
> for ARM32 SOCFPGA systems.
>
> The ARM64 System Manager can only be accessed from priority
> level EL3 so this new MFD driver handles the calls to EL3.

(adding arm@kernel.org)
As discussed with Lee, let's keep the series together and merge it
through the mfd tree.

For all six patches:

Reviewed-by: Arnd Bergmann <arnd@arndb.de>


> Thor Thayer (6):
>   mfd: altera-sysmgr: Add SOCFPGA System Manager
>   Documentation: dt: socfpga: Add S10 System Manager binding
>   ARM: socfpga_defconfig: Enable CONFIG_MTD_ALTERA_SYSMGR
>   arm64: defconfig: Enable CONFIG_MTD_ALTERA_SYSMGR
>   net: stmmac: socfpga: Use shared System Manager driver
>   arm64: dts: stratix10: New System Manager compatible
>
>  .../bindings/arm/altera/socfpga-system.txt         |  12 ++
>  MAINTAINERS                                        |   6 +
>  arch/arm/configs/socfpga_defconfig                 |   1 +
>  arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |   2 +-
>  arch/arm64/configs/defconfig                       |   1 +
>  drivers/mfd/Kconfig                                |  10 +
>  drivers/mfd/Makefile                               |   1 +
>  drivers/mfd/altera-sysmgr.c                        | 211 +++++++++++++++++++++
>  .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |   5 +-
>  include/linux/mfd/altera-sysmgr.h                  |  29 +++
>  10 files changed, 275 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/mfd/altera-sysmgr.c
>  create mode 100644 include/linux/mfd/altera-sysmgr.h
>
> --
> 2.7.4
>
