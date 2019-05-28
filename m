Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766CEC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A0C92075C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wLR382+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfE1Ixk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 04:53:40 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:42762 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfE1Ixk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 04:53:40 -0400
Received: by mail-vk1-f196.google.com with SMTP id x196so4294863vkd.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 01:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=otb7m42zmtPMOYxJa9kTVp/RQpjQZPIYcZ41JiBmWlg=;
        b=wLR382+hSCCxe2T5KPiqQBij5emBSGtbTPhaRBS9h03dRVeb5PdP0uUYfn6ZK/qUuO
         uPARe7O14ZcvmqESFJZD/XmklLrVblH18k+17bLWxZ0VdYrc0Kxynq7Ugob/STGYOM0i
         o39R15/vk4DZzDcyv0u+upAiydk/l0XLTL0a3bBgEvAGdQyvH5Brwu7Jy6Z9wekFvDpu
         37QQL7Oh+MjTvJSUFff5HIzhMMRjAaO6kfgq0yFnfFj1areAkVnPWE+o/Fi2DlOkfEuN
         blwIOF5zr/1WhAHdMpbznU8UXCnQ7XHy9rXRoktOw6/Wdc8EJRnV+x9Ty18nbKxJv8uF
         cUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=otb7m42zmtPMOYxJa9kTVp/RQpjQZPIYcZ41JiBmWlg=;
        b=ARRJ/mOGbUGQf6Gga9jsvS+Y9Fvwjjn54zNi5xfUKtz3VaUBPsJTMTsbp+8pa1NlD7
         ifYWfVFbe1TH8nLeuDJSp3DW+HToZ4uAVYvPFUSYxrHDDiWqIv89MbNdMVOf7FM/q0yd
         QB/nqVeyHAAInOABFdn7EEtMaw6ySA2v1wedIMik7VbRpY3XvECDSssS/tpMVE6yvgJf
         KWDPuyNC6GRLZaDTh+wT44kUasfdH92VYC16Ck+6aljx7Lz9Ng6Pqf9Ok52JBwYZGR6X
         J9kliOCfhGnM3fqvXzTumaLG+5++yKSx1WXvnq+9X0cevXj82/Z1fj+xfCSicJ8/wskM
         hCBA==
X-Gm-Message-State: APjAAAVEjJX5pg3yRW5JMFfMeUITni2rMjTP/2qHqIJmq93XURQgHeKH
        qJFqMaifIPOD/jrPSQlSEYOHYdt6TIkDMHF8iI6oAnn8
X-Google-Smtp-Source: APXvYqzWzuRafMU/CWmBJC1DK8ofL6hlLAW9j7GgoAJuKT4UQIsembnmRVv2I2SevxQOTjujtjzzRe7TN55tQI2r+AU=
X-Received: by 2002:a1f:bd13:: with SMTP id n19mr8576569vkf.17.1559033619270;
 Tue, 28 May 2019 01:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190523145950.7030-1-jbrunet@baylibre.com>
In-Reply-To: <20190523145950.7030-1-jbrunet@baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 May 2019 10:53:03 +0200
Message-ID: <CAPDyKFp8KErOHTZTg+DdqRvURjG4ohTXiZ-FQd7yKvkpL0z15A@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: fix irq ack
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 May 2019 at 16:59, Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> While cleaning the ISR of the meson-gx and acking only raised irqs,
> the ack of the irq was moved at the very last stage of the function.
>
> This was stable during the initial tests but it triggered issues with
> hs200, under specific loads (like booting android). Acking the irqs
> after calling the mmc_request_done() causes the problem.
>
> Moving the ack back to the original place solves the issue. Since the
> irq is edge triggered, it does not hurt to ack irq even earlier, so
> let's do it early in the ISR.
>
> Fixes: 9c5fdb07a28d ("mmc: meson-gx: ack only raised irq")
> Tested-by: Neil Armstrong <narmstrong@baylibre.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/meson-gx-mmc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 6ef465304052..cb3f6811d69a 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -873,6 +873,9 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>         if (WARN_ON(!host) || WARN_ON(!host->cmd))
>                 return IRQ_NONE;
>
> +       /* ack all raised interrupts */
> +       writel(status, host->regs + SD_EMMC_STATUS);
> +
>         cmd = host->cmd;
>         data = cmd->data;
>         cmd->error = 0;
> @@ -919,9 +922,6 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>         if (ret == IRQ_HANDLED)
>                 meson_mmc_request_done(host->mmc, cmd->mrq);
>
> -       /* ack all raised interrupts */
> -       writel(status, host->regs + SD_EMMC_STATUS);
> -
>         return ret;
>  }
>
> --
> 2.20.1
>
