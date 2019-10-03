Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116DCC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAAB72133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tB61CORY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbfJCKBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 06:01:36 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40847 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729549AbfJCKBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 06:01:34 -0400
Received: by mail-ua1-f68.google.com with SMTP id i13so692921uaq.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 03:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uHKag2bPeIrKn3P3JL++KZXHOUiSqvzC6FW+io/WAWI=;
        b=tB61CORYFCnZCCgtX/7tBf5GZo8LBiZKhGioOaGJzzpb8cJobceohsclc9d3TSx2Ms
         gDMya2+gozduxCQu4OBxalqIv+w/0Ly2PAjfrFzSwrVFnYPAcuhscugtdJ/+3CPJjVZS
         WgWhAs+MOvzKeGM8YBzLUFIRBnu/OZLUWQygHQw3dPOYGTwiu36Umvm1G5wDMiFFsu52
         eRlWq2b0JnfgifVKuJHxt5/TN1kR/9tsrtNG9LqG+y6b3XE2bkKEWs7mpDck/dV9wsto
         c0aRIK0hJmi8qY6wvE2Hc4tjjZffUNMhUMxXynemXaqiX56CFoLfa5ImgUQkAFtrmgEz
         7ECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uHKag2bPeIrKn3P3JL++KZXHOUiSqvzC6FW+io/WAWI=;
        b=UreNBcjfIkhlinVHudiCXnKjCoW7X2Hn00vpfqfLz1gDEd2aBPwP1Nyv5c1unOHGmr
         4+ZyNVIdWRUckUQ2POXTRzrtUls8bLwxNQEuwEzV9xcCIaGWMFCUSRTpP5a5DgwGChfZ
         bzLWO4Fq5orxfeDWEOSFdIWypzUJM/UFVoD/mzDOgR01m61uBlNMlXJcNyEZaavbLIrv
         YzQAdJnX6ImfTx+JNrM7ISj4F++GyV2NI0GiRM3u8Ea0su3K8eH0rKhFXsAwdrSrgMA9
         +69CWh0Smf/dj5w1v7jW1RpulhyvLag5M0S4/BG+1tCrCpW8jWNZfyZUoqaoTJNYxGfU
         Mxlw==
X-Gm-Message-State: APjAAAXqhQPvSBk3M/rKsbfPE0sGfPanmuNeXdPGMk/DaAEtLPSUHmOw
        WZllw3L/iOT/kIjdn9sbODxUkWa2qyVZPtCQy7yTew==
X-Google-Smtp-Source: APXvYqzTDm00zk91vFvREWyGzPJxPgoqb2kptShBcyIpkjlZmQw1Y15ISJjosvfcEfo8nniMu9cvOnaP5V5MtXXxzsg=
X-Received: by 2002:ab0:6190:: with SMTP id h16mr2422735uan.129.1570096893220;
 Thu, 03 Oct 2019 03:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <1568079631-28808-1-git-send-email-orito.takao@socionext.com>
In-Reply-To: <1568079631-28808-1-git-send-email-orito.takao@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Oct 2019 12:00:57 +0200
Message-ID: <CAPDyKFq6wbscGGq_0Q3_8eGLXk-+xBtmPbjq97jiejR7Qd_QbA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] mmc: sdhci-milbeaut: add Milbeaut SD driver
To:     Takao Orito <orito.takao@socionext.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jaswinder Singh <jaswinder.singh@linaro.org>,
        sugaya.taichi@socionext.com, kasai.kazuhiro@socionext.com,
        kanematsu.shinji@socionext.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Sep 2019 at 03:39, Takao Orito <orito.takao@socionext.com> wrote:
>
> The following patches add driver for SD Host controller on
> Socionext's Milbeaut M10V platforms.
>
> SD Host controller on Milbeaut consists of two controller parts.
> One is core controller F_SDH30, this is similar to sdhci-fujitsu
> controller.
> Another is bridge controller. This bridge controller is not compatible
> with sdhci-fujitsu controller. This is special for Milbeaut series.
>
> It has the several parts,
>  - reset control
>  - clock enable / select for SDR50/25/12
>  - hold control of DATA/CMD line
>  - select characteristics for WP/CD/LED line
>  - Re-tuning control for mode3
>  - Capability setting
>    Timeout Clock / Base Clock / Timer Count for Re-Tuning /
>    Debounce period
> These requires special procedures at reset or clock enable/change or
>  further tuning of clock.
>
> Takao Orito (2):
>   dt-bindings: mmc: add DT bindings for Milbeaut SD controller
>   mmc: sdhci-milbeaut: add Milbeaut SD controller driver
>
>  .../devicetree/bindings/mmc/sdhci-milbeaut.txt     |  30 ++
>  drivers/mmc/host/Kconfig                           |  11 +
>  drivers/mmc/host/Makefile                          |   1 +
>  drivers/mmc/host/sdhci-milbeaut.c                  | 362 +++++++++++++++++++++
>  drivers/mmc/host/sdhci_f_sdh30.c                   |  26 +-
>  drivers/mmc/host/sdhci_f_sdh30.h                   |  32 ++
>  6 files changed, 437 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
>  create mode 100644 drivers/mmc/host/sdhci-milbeaut.c
>  create mode 100644 drivers/mmc/host/sdhci_f_sdh30.h
>
> --
> 1.9.1
>
>

Applied for next, thanks!

Kind regards
Uffe
