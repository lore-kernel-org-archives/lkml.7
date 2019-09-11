Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4947EC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 14:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2079F20872
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 14:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iivHYily"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfIKOVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 10:21:43 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36286 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbfIKOVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 10:21:42 -0400
Received: by mail-vs1-f67.google.com with SMTP id v19so8698062vsv.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 07:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nNQLAaHUHZxYUSMT1J/A7Ih8261Mrki+Cw1p0rlmNX8=;
        b=iivHYilyJ9TUXUdXgier7M4mee7Duyop+p71Pl0nbuxXPTlfMHKqCIGolPaaZd22/k
         svQ2bCrwbMKIpp7+8b0gd9FndAX30QzO35/WWOtFgdW+xR8cP4eOezOkIqN6y6bdhAXJ
         89arpp3uJxACcHBmfs1GGOgkA/u6GpWx/MVnYSq249JYt0Cj+sXxlSTeS5adQ0SQ6tYG
         O8HAJ9audr9wZEFM+1BFpFoPax7anXjFppESWGrptWZoOP207nPn1Dxk4NcGPnAqBYwU
         V35EkNpWg1bXMNMHBV8bglEXqT/7ySG03XYvxdK/luK4PkmVQb/Ii3RODRwIEW6eQSjj
         auOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nNQLAaHUHZxYUSMT1J/A7Ih8261Mrki+Cw1p0rlmNX8=;
        b=LsQ4Ge01BiTHaMQNtW6Hsb7+cKKK2s93yn3fp2XcrOjecXmKfm/lZkQ0m22vcOl6lf
         icN/AByomhzcg6hKGP5D5qfumyXmN3E7w766iF2lwCbeP+HCh/76uJZaiagpDYlW23+h
         hTHK2gRN7wOWRWyd4vQu0riQPpXuyhVfXLs4iHHy/dWYCHE2gYVirOhGxuWxExSdJqFA
         OBt+xptDt0pohtCK1BstovVsLqRA1DH9CxTd7PzcT3xQg1K5BBsLPVorTWDjMf3jKGYa
         4eSv1Jw20YLoY0mdHVkZ9kOF84w1WXMa1Nk6BiANMY4S4Sx/biGqBA3gRYU0lzE54XFV
         PEUQ==
X-Gm-Message-State: APjAAAVki0OT3MreNz81ApISF6y9yrpU2GTM34KzUp5WQQpRnrjDkXpu
        C/MZqVrLf4q6Tr8QC/+cDHx+6VdWT1dIAdGt1oNFkg==
X-Google-Smtp-Source: APXvYqzvX0jRUjotQgNbokEtb0cVlv2nwPsN8d5DgMZaTbJuMOC5uy7G2qiEtJ7AyLBysxY8B/tN+1Ihh21RRcbdtAI=
X-Received: by 2002:a67:e246:: with SMTP id w6mr6456701vse.200.1568211701960;
 Wed, 11 Sep 2019 07:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190908101236.2802-1-ulf.hansson@linaro.org>
In-Reply-To: <20190908101236.2802-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 11 Sep 2019 16:21:06 +0200
Message-ID: <CAPDyKFrx1pGSp56fZ6ksmWKpv66mMdPas=VE3V6JwF4J_xwCKQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] mmc: core: PM fixes/improvements for SDIO IRQs
To:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Sep 2019 at 12:12, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Changes in v2:
>         - Added reviewed/tested-by tags.
>         - Updated some changelogs.
>         - Renamed sdio_irq_enabled() to sdio_irq_claimed().
>         - Don't set sdio_irq_pending when resuming SDIO card, but just queue the
>         work.
>
> The power management support for SDIO cards have slowly been improved, but
> there are still quite some serious problems, especially when dealing with the
> so called SDIO IRQs during system suspend/resume.
>
> This series makes some additional improvements to this code in the mmc core,
> but also includes some needed adaptations for the sdhci, the dw_mmc and the
> mtk-sd host drivers.
>
> The series is also available at:
> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git sdio_irq_suspend_next_v2
>
> Kind regards
> Uffe
>
>
> Matthias Kaehlcke (1):
>   mmc: core: Move code to get pending SDIO IRQs to a function
>
> Ulf Hansson (10):
>   mmc: core: Add helper function to indicate if SDIO IRQs is enabled
>   mmc: dw_mmc: Re-store SDIO IRQs mask at system resume
>   mmc: mtk-sd: Re-store SDIO IRQs mask at system resume
>   mmc: core: Clarify sdio_irq_pending flag for
>     MMC_CAP2_SDIO_IRQ_NOTHREAD
>   mmc: core: Clarify that the ->ack_sdio_irq() callback is mandatory
>   mmc: core: WARN if SDIO IRQs are enabled for non-powered card in
>     suspend
>   mmc: core: Fixup processing of SDIO IRQs during system suspend/resume
>   mmc: sdhci: Drop redundant check in sdhci_ack_sdio_irq()
>   mmc: sdhci: Drop redundant code for SDIO IRQs
>   mmc: sdhci: Convert to use sdio_irq_claimed()
>
>  drivers/mmc/core/sdio.c            |  4 ++-
>  drivers/mmc/core/sdio_irq.c        | 57 +++++++++++++++++++-----------
>  drivers/mmc/host/dw_mmc.c          |  4 +++
>  drivers/mmc/host/mtk-sd.c          |  3 ++
>  drivers/mmc/host/sdhci-esdhc-imx.c | 34 ++++++++----------
>  drivers/mmc/host/sdhci.c           | 12 ++-----
>  drivers/mmc/host/sdhci.h           |  6 ----
>  include/linux/mmc/host.h           | 10 ++++++
>  8 files changed, 75 insertions(+), 55 deletions(-)
>
> --
> 2.17.1
>

So, I have queued this up for next (using v3 of patch 3), thanks all
for reviewing and testing!

Kind regards
Uffe
