Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F412C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 23:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72732067D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 23:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gicLTwd9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389853AbfIEXrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 19:47:21 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:32809 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389695AbfIEXrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 19:47:21 -0400
Received: by mail-io1-f65.google.com with SMTP id m11so8785552ioo.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 16:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=siNwSdIYFNtVZ3AHic9j9ZXRlU43cbV/eECxgsuYWQ0=;
        b=gicLTwd9Yg/AWWDtsWsMOScBKzSbHe6y74CyVJLLUU+pK0fluT99gtJrzBRk3xEMr1
         RXVe+9H9EosBTGKbhvtnZbGwpqQph+kg3r/esw7b+DnXQgWFMwqNrhftMkXkPvjPDQU4
         AJQ7C1xsKnUa+qe7oAzgOdZkRhzz/18iO7PCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=siNwSdIYFNtVZ3AHic9j9ZXRlU43cbV/eECxgsuYWQ0=;
        b=QS9No0ieKii1O78foI1m0FdJXpPfDzngbTaBARucCRu7kepVrgRNtWzRZ8xy9gRMjw
         L18alj8pqVc5VVMbpdRL5IZzoW3YCEMHTmkahoxVj2Gq+30hLOIln8Y/vrghoFCnEtad
         BihpgTOIXxdWcyGDd8QTa0bRlsMcvLtagPweijxPGOThkk9h0Dxz+3MMpoaaxYuhslsX
         +gI8XdMY2FnM0q7ngWwIwSbBWwjgxd+5fz+6K/fa7wk++q+TCifowdGq8ixO2Q6gvUcn
         FmXpglW9uipY9tJCndusidaGbtx3peqCnIs/CR5CC05zCXwkNf4LRS2j7q+n1+hw8gNc
         M5Ng==
X-Gm-Message-State: APjAAAXo+ZwvlQyFtFBFXSmWV04uIgBw7nCciiCAsJ37WFh6oKP5LExJ
        K7lnPYYjxpin83Vss5T1IhXgVNlp/2A=
X-Google-Smtp-Source: APXvYqzBgVWrQEMuw7GVAxwYK0L+OAXRFyfLGgKMrcOAYgZrBFyphkk317ggtz48nnsYq2fvEJOaIQ==
X-Received: by 2002:a6b:cac2:: with SMTP id a185mr7600440iog.142.1567727239874;
        Thu, 05 Sep 2019 16:47:19 -0700 (PDT)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com. [209.85.166.41])
        by smtp.gmail.com with ESMTPSA id u124sm5785602ioe.63.2019.09.05.16.47.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2019 16:47:18 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id b136so8764999iof.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 16:47:17 -0700 (PDT)
X-Received: by 2002:a6b:ee17:: with SMTP id i23mr6820804ioh.168.1567727237453;
 Thu, 05 Sep 2019 16:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190903142207.5825-1-ulf.hansson@linaro.org> <20190903142207.5825-3-ulf.hansson@linaro.org>
In-Reply-To: <20190903142207.5825-3-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 5 Sep 2019 16:47:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XaaC=RpCiF09WAuhmDgte3EmFjFxk9y7xpX=HBwaRr9g@mail.gmail.com>
Message-ID: <CAD=FV=XaaC=RpCiF09WAuhmDgte3EmFjFxk9y7xpX=HBwaRr9g@mail.gmail.com>
Subject: Re: [PATCH 02/11] mmc: dw_mmc: Re-store SDIO IRQs mask at system resume
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 3, 2019 at 7:22 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> In cases when SDIO IRQs have been enabled, runtime suspend is prevented by
> the driver. However, this still means dw_mci_runtime_suspend|resume() gets
> called during system suspend/resume, via pm_runtime_force_suspend|resume().
> This means during system suspend/resume, the register context of the dw_mmc
> device most likely loses its register context, even in cases when SDIO IRQs
> have been enabled.

Even if they weren't lost the resume code currently has this statement:

mci_writel(host, INTMASK, SDMMC_INT_CMD_DONE | SDMMC_INT_DATA_OVER |
   SDMMC_INT_TXDR | SDMMC_INT_RXDR |
   DW_MCI_ERROR_FLAGS);

...so that would have clobbered any existing state even if register
state wasn't lost.  ;-)

> To re-enable the SDIO IRQs during system resume, the dw_mmc driver
> currently relies on the mmc core to re-enable the SDIO IRQs when it resumes
> the SDIO card, but this isn't the recommended solution. Instead, it's
> better to deal with this locally in the dw_mmc driver, so let's do that.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/host/dw_mmc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index eea52e2c5a0c..f114710e82b4 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3460,6 +3460,10 @@ int dw_mci_runtime_resume(struct device *dev)
>         /* Force setup bus to guarantee available clock output */
>         dw_mci_setup_bus(host->slot, true);
>
> +       /* Re-enable SDIO interrupts. */
> +       if (sdio_irq_enabled(host->slot->mmc))
> +               __dw_mci_enable_sdio_irq(host->slot, 1);
> +

There's a slight bit of subtleness here and I guess we need to figure
out if it matters.  From testing things seem to work OK so maybe we're
fine, but just to explain what's bugging me:

If we got an SDIO interrupt that was never ACKed then this is going to
act like an implicit ACK.  Notice that dw_mci_ack_sdio_irq() is
exactly this call because when the SDIO IRQ fires we mask it out.
...then unmask when Acked.

Specifically after your series is applied, I think this is what
happens if an interrupt fires while the SDIO bus is officially
suspended:

1. dw_mci_interrupt() will get called which will mask the SDIO IRQ and
then call sdio_signal_irq()

2. sdio_signal_irq() will queue some delayed work.

3. The work will call sdio_run_irqs()

4. sdio_run_irqs() _won't_ ack the IRQ, so it will stay disabled.

5. When we get to the resume we'll re-enable the interrupt.

I guess that's fine, but it is a little weird that we might not really
be restoring it simply because it got disabled due to the clobbering
of INTMASK but also because we implicitly skipped Acking an interrupt
that fired.


I wonder if the correct fix is to just add an explit zeroing of the
INTMASK (so mask all interrupts) in dw_mmc's suspend callback.  Then
there's no possible way we could get an interrupt during suspend...



-Doug
