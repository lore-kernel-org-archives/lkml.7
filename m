Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9E8C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE904212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rbswCChL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbfFGLDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 07:03:00 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44895 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbfFGLC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 07:02:59 -0400
Received: by mail-vs1-f66.google.com with SMTP id v129so877548vsb.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 04:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WUmbq4ZzrfgjJ6I/bdvOaFhtKBJjK9tscZns2i4i8ls=;
        b=rbswCChLasSiMv/BxkP+oqC6iQQ5YnOz2jHk8PMbC0zI9S1v/bznWuilMUyjrXLufI
         tBofULNs3jx0Ow9VaFVaYGxRQvzU82XBOlfJq5ISmCxvw20vVp1FfCTxng7lgcVr/fDO
         9wrhKxb2wX1Yw4awvXoH22X4YIcDGC6/cJSCWFxWFhrLqcAiXL7rOZA4rvSseDG3GeJK
         31m3sVPpE6DB+jvHavpdf3g+3NF6N3xKjgE5q+umHY3ZNSGHOuODtFu5/PLVhF8yEkSj
         HarLC+t7Wt+PP1PnEAgWPPTvHxQkqLFcoM4i2QNtsCkOcRNrm5xargwrFL5jAii+1OSc
         4kmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WUmbq4ZzrfgjJ6I/bdvOaFhtKBJjK9tscZns2i4i8ls=;
        b=SA4aqdqdDnBCEM14eYa8/Ayf81wzDdVQ9GwJqkEcTGw6AnreCkMb3Dl3T79Mq7ojc9
         HyYVIjbUARDfhIEVbrze9+qh5d/WLFv6E43lCHX8b5SKgzpEcwLZa8CRZmwbDVzB32wl
         z5Aa55q3j5juwoNwIwdRga3UPoSHefJWWiAbXFJhsQYnQd7oqBvcY1CfkNHvou6iRJT8
         y7eMHnUjO28bkZaCj51KP3cIzRJS/ZKAfpXp/l1CGDgXvmSJyTFtbBm7vUeooMENBrXU
         Zs/XzEjKwLi8qfzVW8ZmJK1c170w2W5AYKs27jXIfhqHaqMNsEkVbsq+jTyeQtJ5O/mu
         +QkA==
X-Gm-Message-State: APjAAAWHSfxscl9M7OqpBNlcqEMnPHaA8SjWPFBvVEa5NEpoD9r7cVzS
        8Ea1AKf1rEcpXQ7txiHl6K0lGsUyaOvhMlbIShKQUw==
X-Google-Smtp-Source: APXvYqzDuz5mV6Jsi2xrh1eBdn+z7KJtHM7z3KIMpeuQwSP0He+fkG995ke/oRmFwgQo/qgul6kuZ3xCxNzlcCOd13U=
X-Received: by 2002:a67:706:: with SMTP id 6mr11457746vsh.200.1559905378848;
 Fri, 07 Jun 2019 04:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559635435.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1559635435.git.baolin.wang@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 7 Jun 2019 13:02:22 +0200
Message-ID: <CAPDyKFp+UXDrrferK0zP7nPFtvkq6UU29vhJu3HCEUiKcAOsJQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Add SD host controller support for SC9860 platform
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jun 2019 at 10:14, Baolin Wang <baolin.wang@linaro.org> wrote:
>
> This patch set adds optional clock support, HS400 enhanced strobe mode support,
> PHY DLL configuration and other optimization to make the SD host controller
> can work well on the Spreadtrum SC9860 platform.
>
> Changes from v1:
>  - Add acked-tags from Adrian.
>  - Fix one mistake by changing MMC_TIMING_MMC_HS to MMC_TIMING_SD_HS in patch 8.
>
> Baolin Wang (9):
>   mmc: sdhci-sprd: Check the enable clock's return value correctly
>   dt-bindings: mmc: sprd: Add another optional clock documentation
>   mmc: sdhci-sprd: Add optional gate clock support
>   mmc: sdhci-sprd: Implement the get_max_timeout_count() interface
>   mmc: sdhci-sprd: Add HS400 enhanced strobe mode
>   mmc: sdhci-sprd: Enable PHY DLL to make clock stable
>   dt-bindings: mmc: sprd: Add PHY DLL delay documentation
>   mmc: sdhci-sprd: Add PHY DLL delay configuration
>   arm64: dts: sprd: Add Spreadtrum SD host controller support
>
>  .../devicetree/bindings/mmc/sdhci-sprd.txt         |   19 +++
>  arch/arm64/boot/dts/sprd/whale2.dtsi               |   35 ++++
>  drivers/mmc/host/sdhci-sprd.c                      |  171 +++++++++++++++++++-
>  3 files changed, 217 insertions(+), 8 deletions(-)
>
> --
> 1.7.9.5
>

Patch 1 -> patch 8, applied for next, thanks!

Patch 9 is for arm-soc.

Kind regards
Uffe
