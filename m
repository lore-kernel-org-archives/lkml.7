Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FB3C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376D227DB1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nHkL5geT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbfFCImK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 04:42:10 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39536 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbfFCImK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:42:10 -0400
Received: by mail-ot1-f65.google.com with SMTP id r21so2821717otq.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 01:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v07iYjGp5nWV9CSxAvLDHJlP76eeAiLKXDinb2hN/Lw=;
        b=nHkL5geTJxbfuQTgK6/8G88ruDwULcnsHmwJzcmvL2oHp0myFdfE1FhPnKasmXKmIC
         Wfd3WTWIxsd+dUj98ycDxuRSzGLYPqt/VQNY/7pH+/qeqPhHcOI7KGX/GJ5FajyXLlW1
         cwF76Go8yIl0bRyDwUgpJp9tHHczY09bKqLsVeOfr9OrUvp6aHIjWYi3ldceuTVP2inL
         WZE18/rqHWgtq98O/eF6M9w5rWQWMDjCuZcQQtCrEn+iRPN0fjfXIXKdH9E0CUcthvzE
         kxxLecILJ6UbOTzN0sRITkxwwx6iP1LqU59LacFnojwKM4GslL38Fj+SBrn6mSIKkWV9
         F3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v07iYjGp5nWV9CSxAvLDHJlP76eeAiLKXDinb2hN/Lw=;
        b=QvIHJ7SHgKC1tu5ejJw937ONiMoDnrv6FOqEaevMs9+9URnMjHKCkPkrxoLUrYvSKK
         jzkhb7908ZmIFHBjPUJXMSxsEHvGs9xEjEsM/FfPxyK/obkVTq+0lXXPKsvGA3k3R3n+
         me85cwdXzejiePz7I1BuSfBnMzI1eHlbPHis4zQb9DoxBLoD5+J+eWC1POkD2J5KS3KN
         BrLIKv+ycga0eeGtBI1tXO8cEnpmRwSuzBsxlWhnKaZFPvYFijyd7w6s2mdgl4c25wQT
         TbZxD8OhsX0MRrkpBfV0+c64KjiEMKbcUtmcp1Kwa7dI6/nwBW3vcqlBSJp2McOjMFcK
         G3oQ==
X-Gm-Message-State: APjAAAXJprZ06fNwRsYfT91s0+PWrsFFB/kFr6XJqzoWT3K0HARLyDfR
        2SAvM6KlmJXbbS+JL8iAUSBMIR2NnYldzmSFqj8k1w==
X-Google-Smtp-Source: APXvYqwYLd2dpHu6nvkvw3MVvAzbMJxHXUfJpurp+73sDV/UA282/GSNQJj+tD3erUPCO+itTcUjCH4KgWdFE0lty5s=
X-Received: by 2002:a9d:529:: with SMTP id 38mr328019otw.145.1559551329341;
 Mon, 03 Jun 2019 01:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1558346019.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1558346019.git.baolin.wang@linaro.org>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 3 Jun 2019 16:41:56 +0800
Message-ID: <CAMz4ku+E=kFgWrvm_wzM2XQQUyYZhc5uokcGEAEbEKpNAYZQ7g@mail.gmail.com>
Subject: Re: [PATCH 0/9] Add SD host controller support for SC9860 platform
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian & Ulf,

On Mon, 20 May 2019 at 18:12, Baolin Wang <baolin.wang@linaro.org> wrote:
>
> This patch set adds optional clock support, HS400 enhanced strobe mode support,
> PHY DLL configuration and other optimization to make the SD host controller
> can work well on the Spreadtrum SC9860 platform.

Do you have any comments for this patch set? Thanks.

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


-- 
Baolin Wang
Best Regards
