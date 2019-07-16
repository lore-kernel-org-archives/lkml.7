Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021E1C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 10:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C02206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 10:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HywDJG1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387469AbfGPKwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 06:52:50 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34568 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733037AbfGPKwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 06:52:50 -0400
Received: by mail-ot1-f66.google.com with SMTP id n5so20578789otk.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 03:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yV7fHha/1uJLdSPSLwZnz/qgIkyl6ozZw75QGiLZaR8=;
        b=HywDJG1MdyScI+QJh7uYxU0Y/TqPUTLcWM3yrU9WLg2RGudW3/NGg6pnZaO+TVtzo9
         crMGl5dF8alxyA7rakyiWn5L3uaVLis/vspDk5q4aLpPXdtzrGKZ8OE0nN6dPE+I1adb
         l7Lbl2YNi5PE66lm7ahBd7dK1Sqr02DkHPfE1G/SJgX37ey1bwcPdwi4zW9uKtGUu8M/
         jsnatodL16JvUDo8Y9FPPg+xHf6CI/9cD6lHZWZvmHmvZe9CCzo16icPeNDSJypFT0o/
         oUFUoFEXfBjitw3pO8Ji1ZXgFUNy3C0oweqiG6KYpaC5/SIgroINeXpQsFzLeYPCxlUr
         eHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yV7fHha/1uJLdSPSLwZnz/qgIkyl6ozZw75QGiLZaR8=;
        b=I2JKVMOxqBeXtIhIjU8D1R2KDWS6kVvXlMEMZk9eNh8F1tLwxue3zpIaVyd3XhjMXx
         KkPK6xioAucKWvSltT/EDYkiAMCQbBAXedJdQule3aqjbp3bJSG32rT8jyh1oAtEAtOe
         WjM/zD1FEf+0Y0EMly4FDFH6GOzAS0/0810IyvQrgHfoy6EMFakJwiv0d205t9TmBvw0
         ddmlnlzqowwH4B+6bXRZJV/JPvknguMOrjgZHC3IbcjPwL/OxFDSaegDysKff7cStISr
         QIVXN8BRuXsRGC89NHvalbyC50DC6sJpaC1Lem0VrmqARRoc1c+cGsKM07ZMkgsMAyVo
         tsrQ==
X-Gm-Message-State: APjAAAUImuXQLgWW97UCXF+LJsxUihoGkzdE+WWCQyV8gn0eSBPLIa9B
        YLa2Wu54iOf0cOVD2FKt6oIAlIhRredPZtanHk8MHw==
X-Google-Smtp-Source: APXvYqx2L0oIM/lm53Z/5BgzDRcJnvBfWs+2h9acWP6hfKANHzNXntHk/u+Il8SmOu8YrvJdGzB64XBcBjyYJTOExn0=
X-Received: by 2002:a05:6830:13c2:: with SMTP id e2mr24139721otq.123.1563274369381;
 Tue, 16 Jul 2019 03:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <7ab490e5b311f6cb057c4663d69ef7cbe3318dae.1563266066.git.baolin.wang@linaro.org>
 <07e348a0-6a80-e176-d18d-6a1e54313fa6@intel.com>
In-Reply-To: <07e348a0-6a80-e176-d18d-6a1e54313fa6@intel.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 16 Jul 2019 18:52:37 +0800
Message-ID: <CAMz4ku+eiwNtEg7mPvGKDZrqANXiSokzj6HJkse-xwSvNGqb3A@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: host: sdhci-sprd: Fix the incorrect soft reset
 operation when runtime resuming
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jul 2019 at 18:40, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 16/07/19 11:39 AM, Baolin Wang wrote:
> > In sdhci_runtime_resume_host() function, we will always do software reset
> > for all, which will cause Spreadtrum host controller work abnormally after
> > resuming.
> >
> > Thus for Spreadtrum platform that do not power down the SD/eMMC card during
> > runtime suspend, we should not do software reset for all. To fix this
> > issue, adding a specific reset operation that add one condition to validate
> > the MMC_CAP_AGGRESSIVE_PM to decide if we can do software reset for all or
> > just reset command and data lines.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> > Changes from v2:
> >  - Simplify the sdhci_sprd_reset() by issuing sdhci_reset().
> >
> > Changes from v1:
> >  - Add a specific reset operation instead of changing the core to avoid
> >  affecting other hardware.
> > ---
> >  drivers/mmc/host/sdhci-sprd.c |   19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> > index 603a5d9..bc9393c 100644
> > --- a/drivers/mmc/host/sdhci-sprd.c
> > +++ b/drivers/mmc/host/sdhci-sprd.c
> > @@ -373,6 +373,23 @@ static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
> >       return 1 << 31;
> >  }
> >
> > +static void sdhci_sprd_reset(struct sdhci_host *host, u8 mask)
> > +{
> > +     struct mmc_host *mmc = host->mmc;
> > +
> > +     /*
> > +      * When try to reset controller after runtime suspend, we should not
> > +      * reset for all if the SD/eMMC card is not power down, just reset
> > +      * command and data lines instead. Otherwise will meet some strange
> > +      * behaviors for Spreadtrum host controller.
> > +      */
> > +     if (host->runtime_suspended && (mask & SDHCI_RESET_ALL) &&
> > +         !(mmc->caps & MMC_CAP_AGGRESSIVE_PM))
>
> MMC_CAP_AGGRESSIVE_PM does not necessarily mean that the card will have been
> runtime suspended.
>
> What about checking if the card power is on? i.e.

Yes, you are totally correct. I'll fix this in next version. Thanks
for your comments.

>         if (host->runtime_suspended && (mask & SDHCI_RESET_ALL) &&
>             mmc->ios.power_mode == MMC_POWER_ON)
>
> > +             mask = SDHCI_RESET_CMD | SDHCI_RESET_DATA;
> > +
> > +     sdhci_reset(host, mask);
> > +}
> > +
> >  static struct sdhci_ops sdhci_sprd_ops = {
> >       .read_l = sdhci_sprd_readl,
> >       .write_l = sdhci_sprd_writel,
> > @@ -381,7 +398,7 @@ static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
> >       .get_max_clock = sdhci_sprd_get_max_clock,
> >       .get_min_clock = sdhci_sprd_get_min_clock,
> >       .set_bus_width = sdhci_set_bus_width,
> > -     .reset = sdhci_reset,
> > +     .reset = sdhci_sprd_reset,
> >       .set_uhs_signaling = sdhci_sprd_set_uhs_signaling,
> >       .hw_reset = sdhci_sprd_hw_reset,
> >       .get_max_timeout_count = sdhci_sprd_get_max_timeout_count,
> >
>


-- 
Baolin Wang
Best Regards
