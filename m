Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1882EC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24E922CEC
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vvlTxI5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731985AbfIEH3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 03:29:42 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:36745 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731699AbfIEH3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 03:29:41 -0400
Received: by mail-vk1-f193.google.com with SMTP id b25so262935vkk.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 00:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uBfs4YkHZgtMLprfzNd0i3dDb2iTuL+OjOCmqmK9w1M=;
        b=vvlTxI5a5SLMaTrqP9ZEdG5a/NyJ9OtSDs05uwqN9iYWj8F4/xZeN2pHdwBofFvxtR
         FE1p1toqXbV8+T75o7w/W4d0rsxQcKhddqNHveuteEB7kS5IjLaQEypmYCPAk7Awz+uk
         UOawqVHAkxsO+dMNUDlcq6x2Oews9PvEHKbx2BRNDFXQ7SaMyYsGM5LwL87JcEhDCf11
         uyZaRdBAb0jCOkNnMz3N38yYr1eeCU4W3RNwBT+6Ag+YmhqJ9GhByE51mtuR8KG/g9NQ
         aSHUa5uMHWUpSbNKXC1kVcdEwAkxg94H9PYUmILtSkJIgSPMBLAQlQ0ZneIwB8r3LX7u
         aEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uBfs4YkHZgtMLprfzNd0i3dDb2iTuL+OjOCmqmK9w1M=;
        b=mN3V4/H6Pe4zYK/1IBfdE1nJsbI1BrU396vdAEgRENV5uJ61Oh+BoyIBrXyHTFed3M
         vbBOQEpwa9vsIoNAyPbM6ekcsRJN8uWvYAqwGz+gnViOyPsXJ739UGW9FtOB7xROxT5c
         O01fmoX734u9Fp91ZbwATsjzrSydy1pUGup73RFj83WFcebVjVg1BHeMmLuFbZhJCQbb
         qi6SYq1ihJK6QoONcAeCT7I38GHtOGeN8uvMg4vX/q2H8brl4uXEOsNv2M1lHTMVCQ+5
         IKa2mbZcSwESvoTqmiLC+nLekILEdAUChK3tK6p1CS6nGoKSbhs4ZXKFGPG+p5EVrYnq
         0A/A==
X-Gm-Message-State: APjAAAUTDZH41x5aLUAt39tmoUvEXwVG0HrTe7AkXGV1ivowZtR2ICVj
        4roKJfxGyqc6D7APhs+BIwUibb2gjAvLEBcBHSphEw==
X-Google-Smtp-Source: APXvYqwcWUJBRRXfpd2mPOlpgDJEpvpFsrXG9kvj6xlKXECr6mPtD638auCxApkUIpWoI7nQ2nUt1SJsJaHOl04CPlc=
X-Received: by 2002:a1f:5602:: with SMTP id k2mr755971vkb.36.1567668580847;
 Thu, 05 Sep 2019 00:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190903142207.5825-1-ulf.hansson@linaro.org> <20190903142207.5825-3-ulf.hansson@linaro.org>
 <20190905001422.GH70797@google.com>
In-Reply-To: <20190905001422.GH70797@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Sep 2019 09:29:04 +0200
Message-ID: <CAPDyKFryCPu+VWGoc2CV3dgUN+aLNjH8BC5qPjsbCBpUKN=GqQ@mail.gmail.com>
Subject: Re: [PATCH 02/11] mmc: dw_mmc: Re-store SDIO IRQs mask at system resume
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2019 at 02:14, Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Tue, Sep 03, 2019 at 04:21:58PM +0200, Ulf Hansson wrote:
> > In cases when SDIO IRQs have been enabled, runtime suspend is prevented by
> > the driver. However, this still means dw_mci_runtime_suspend|resume() gets
> > called during system suspend/resume, via pm_runtime_force_suspend|resume().
> > This means during system suspend/resume, the register context of the dw_mmc
> > device most likely loses its register context, even in cases when SDIO IRQs
> > have been enabled.
> >
> > To re-enable the SDIO IRQs during system resume, the dw_mmc driver
> > currently relies on the mmc core to re-enable the SDIO IRQs when it resumes
> > the SDIO card, but this isn't the recommended solution. Instead, it's
> > better to deal with this locally in the dw_mmc driver, so let's do that.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/mmc/host/dw_mmc.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > index eea52e2c5a0c..f114710e82b4 100644
> > --- a/drivers/mmc/host/dw_mmc.c
> > +++ b/drivers/mmc/host/dw_mmc.c
> > @@ -3460,6 +3460,10 @@ int dw_mci_runtime_resume(struct device *dev)
> >       /* Force setup bus to guarantee available clock output */
> >       dw_mci_setup_bus(host->slot, true);
> >
> > +     /* Re-enable SDIO interrupts. */
> > +     if (sdio_irq_enabled(host->slot->mmc))
> > +             __dw_mci_enable_sdio_irq(host->slot, 1);
> > +
> >       /* Now that slots are all setup, we can enable card detect */
> >       dw_mci_enable_cd(host);
>
> Looks reasonable to me, besides the bikeshedding over
> 'sdio_irq_enabled' (in "mmc: core: Add helper function to indicate
> if SDIO IRQs is enabled").
>
> One thing I wonder is why this change is only needed for dw_mmc and
> mtk-sd, but not for others like sunxi_mmc. Any insights for a SDIO
> newb?

mtk-sd and dw_mmc is using MMC_CAP2_SDIO_IRQ_NOTHREAD and
sdio_signal_irq(). This is also the case for sdhci, but sdhci is
already internally dealing restoring SDIO IRQs during system resume.

The other host drivers haven't yet converted to
MMC_CAP2_SDIO_IRQ_NOTHREAD. I have a series for that, not yet
completed and thus not ready to be posted. Once that happens, all host
drivers needs to care about re-enabling SDIO IRQs durings system
resume as well.

For those host that currently doesn't use MMC_CAP2_SDIO_IRQ_NOTHREAD,
the core wakes up the sdio_irq_thread from mmc_sdio_resume(), which
later will calls the ->enable_sdio_irq().

Perhaps I should add some information about this in the changelog, let
me think about it for the next version.

Kind regards
Uffe
