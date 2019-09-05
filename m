Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191C9C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 23:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4949D206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 23:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FQzdq6xI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389991AbfIEXsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 19:48:25 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40318 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388302AbfIEXsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 19:48:24 -0400
Received: by mail-io1-f68.google.com with SMTP id h144so8701738iof.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 16:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TdzexQoF5loWHf9nViLs5mZFtTWqWxiWfQRVaa/SkTs=;
        b=FQzdq6xIL+HmAfj2br7r/ZOsXYSloAcTvunrlUf6FJad5RQuzxCSMWyFVafIquJ8gv
         6lLJBiUTqULtMKz6FKxd3et93cCUEmWMl7fcqs5xWEtIO7VvJPKPpSLUX1kaxBYxTMS+
         njEhmfEGVTqf5lODOvif/c5JJ5w/kbOmVd8g0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TdzexQoF5loWHf9nViLs5mZFtTWqWxiWfQRVaa/SkTs=;
        b=VbJzmhh/v0xUo4FAIGkQc56ERYigxaYZ8k0LZF9iZrVXpEMH1BKUEUvMc8haKOG1g2
         jAJFDmhNowFnNkbd/wSod4jAf8Be2wj2X1DjXF/R3UHmJt/jhVaa6QGOV666AEzJ9XuW
         TbSPuCReJYTVTFBOBcy7fv34XhtHFpRIdfoHw15w4/sAhzhXzH3kT/oV+IT7JAULZcBC
         +iGDSwtJI4O9n1dff42iBeFkcy+zsbjGJjteT4Vta2Tu/9ArxOh38cQpaByjfFslTtCF
         Ew7PcDXRE2t7pT0pn+6BJXzijzi1LFNt2ykp4AEs0YjXmI0TQLNU0xTR4n2UJEU+vBb6
         486w==
X-Gm-Message-State: APjAAAUe4RbxKL8xF4aQ22vCcBSb+rNADnRlT4eFXQSySiRTw7fuLZaP
        Yfgv8NQJA1rUVX2lLP1rMO0c9oSnCeE=
X-Google-Smtp-Source: APXvYqxgvFZhP9wHxPov1t0yDFjyoDLTIB8+YHvTjsGVX8ruwpKNn7/YBH59dg1UeTvFosECnmojog==
X-Received: by 2002:a02:8807:: with SMTP id r7mr7251032jai.126.1567727303639;
        Thu, 05 Sep 2019 16:48:23 -0700 (PDT)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com. [209.85.166.52])
        by smtp.gmail.com with ESMTPSA id 80sm6562706iou.13.2019.09.05.16.48.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2019 16:48:23 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id p12so8740167iog.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 16:48:22 -0700 (PDT)
X-Received: by 2002:a5e:8d14:: with SMTP id m20mr7461431ioj.52.1567727302507;
 Thu, 05 Sep 2019 16:48:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190903142207.5825-1-ulf.hansson@linaro.org> <20190903142207.5825-9-ulf.hansson@linaro.org>
In-Reply-To: <20190903142207.5825-9-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 5 Sep 2019 16:48:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WYA2BkEJxUbk1sO3KYWDRtjuDNDK90AXPYge24fOxsBw@mail.gmail.com>
Message-ID: <CAD=FV=WYA2BkEJxUbk1sO3KYWDRtjuDNDK90AXPYge24fOxsBw@mail.gmail.com>
Subject: Re: [PATCH 08/11] mmc: core: Fixup processing of SDIO IRQs during
 system suspend/resume
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
> System suspend/resume of SDIO cards, with SDIO IRQs enabled and when using
> MMC_CAP2_SDIO_IRQ_NOTHREAD is unfortunate still suffering from a fragile
> behaviour. Some problems have been taken care of so far, but more issues
> remains.
>
> For example, calling the ->ack_sdio_irq() callback to let host drivers
> re-enable the SDIO IRQs is a bad idea, unless the IRQ have been consumed,
> which may not be the case during system suspend/resume. This may lead to
> that a host driver re-signals the same SDIO IRQ over and over again,
> causing a storm of IRQs and gives a ping-pong effect towards the
> sdio_irq_work().
>
> Moreover, calling the ->enable_sdio_irq() callback at system resume to
> re-enable already enabled SDIO IRQs for the host, causes the runtime PM
> count for some host drivers to become in-balanced. This then leads to the
> host to remain runtime resumed, no matter if it's needed or not.
>
> To fix these problems, let's check if process_sdio_pending_irqs() actually
> consumed the SDIO IRQ, before we continue to ack the IRQ by invoking the
> ->ack_sdio_irq() callback.
>
> Additionally, there should be no need to re-enable SDIO IRQs as the host
> driver already knows if they were enabled at system suspend, thus also
> whether it needs to re-enable them at system resume. For this reason, drop
> the call to ->enable_sdio_irq() during system resume.
>
> In regards to these changes there is yet another issue, which is when there
> is an SDIO IRQ being signaled by the host driver, but after the SDIO card
> has been system suspended. Currently these IRQs are just thrown away, while
> we should at least make sure to try to consume them when the SDIO card has
> been system resumed. Fix this by calling sdio_signal_irq() after system
> resumed the SDIO card.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/sdio.c     | 2 +-
>  drivers/mmc/core/sdio_irq.c | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index c557f1519b77..3114d496495a 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -1015,7 +1015,7 @@ static int mmc_sdio_resume(struct mmc_host *host)
>                 if (!(host->caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD))
>                         wake_up_process(host->sdio_irq_thread);
>                 else if (host->caps & MMC_CAP_SDIO_IRQ)
> -                       host->ops->enable_sdio_irq(host, 1);
> +                       sdio_signal_irq(host);

Is this always safe?  On 1-function cards you won't poll CCCR_INTx so
you'll always signal an interrupt at resume time, won't you?

-Doug
