Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0423C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81BDD20643
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RToypm0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390161AbfDRTw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 15:52:59 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33442 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfDRTw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 15:52:58 -0400
Received: by mail-oi1-f194.google.com with SMTP id e5so2561406oii.0;
        Thu, 18 Apr 2019 12:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MHnwyGfhVr9Zztuv2ApDOuCX8Y7zltAfnvrToemqRvQ=;
        b=RToypm0LzA7aEPsdwcyZWsDpf7kcuyHilgD6PotVZegNUDJInGcPC/fDzBAYaIiy0x
         AftRuV639VZM/qmxzzm5wsCFHk5FAdzTUOqozhwTOxqkp6rYjzj+UTukmFd8/fD/33Yk
         jfpY1ja1LMNGV8HDnvlsTvc2KzGV3b+aJUl6lKcuBdKEnoge/hDSHtlTDsNnCgH9bc6m
         p1r23wKO/Rt1yKM5j44oTmmoOwcHg04+U4D7aMakK1D/VFpDV36vZpndGFhf1h9Ig2di
         4Y7R7+tmD7AQRVTtloegb8VhOpym7Fc8pw4VxWTprJg1ngV4BKa/oUscmzvJtYDDa8KY
         bkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MHnwyGfhVr9Zztuv2ApDOuCX8Y7zltAfnvrToemqRvQ=;
        b=OVVcC8Ztn6jLPFvwdOPLEtkmVggQpnKAte+ln8sSNUBGlfKqa0EI2wf2lI/kShBUzE
         UtAyzxcpIQshzZQjlPFlqxQRwQgavy+mxxNl5mnxGjmYwP++yyfnvMxKljJZcuDUZkl4
         mPdAzVyh+/DgmyxHM9fZETL0WZd+hU+A2/kfoxMq5bP19cXedguz3VlvoApJcKqhpzsm
         XS1qTxrYSDSgY8bL9cXYsf/wfugUqrXP/P9nl2wj1DBfJQ6Cq3HjrIkUh/YMo8H6JE0C
         uHUDcJpP/Ki7kZM7Jzs0aF+FjU70dJmnl1UxtfoQzFwDo1+9OnHAe3rOMJA6yUcoZ1VY
         IZ4A==
X-Gm-Message-State: APjAAAWxZQpHr/HXNrplVnN/wnLvpER2gWV2CpWzZbo4JQQNnDi+6hcE
        D+g2DcSzBcD2vSMRWmalJGEiryNDGya6sY7KoD+TgJW6
X-Google-Smtp-Source: APXvYqzhRGDYdQYcsQ0iJMDM/aYQoo017EmckJ6XW6iArqLhjBj6Bpkndhtr7fXXiXm4jsqSoVJyGr+edJFUU08wgF4=
X-Received: by 2002:aca:ecd1:: with SMTP id k200mr3131053oih.15.1555617177999;
 Thu, 18 Apr 2019 12:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190417204355.469-1-jbrunet@baylibre.com> <20190417204355.469-4-jbrunet@baylibre.com>
In-Reply-To: <20190417204355.469-4-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 18 Apr 2019 21:52:47 +0200
Message-ID: <CAFBinCCLr2-zBhAUcYsyqF1f0hvH03zoXd9SmSjMU5aA3K7Ytw@mail.gmail.com>
Subject: Re: [PATCH 3/7] mmc: meson-gx: irq is not shared
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Wed, Apr 17, 2019 at 10:44 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> There is no reason for another device to request the MMC irq. It should
> only be used the MMC device.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 8b690ecde4c5..3df50b53f834 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -1328,7 +1328,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
>                host->regs + SD_EMMC_IRQ_EN);
>
>         ret = request_threaded_irq(host->irq, meson_mmc_irq,
> -                                  meson_mmc_irq_thread, IRQF_SHARED,
> +                                  meson_mmc_irq_thread, IRQF_ONESHOT,
>                                    dev_name(&pdev->dev), host);
the commit message reads as if the intention is to remove the IRQF_SHARED flag.
however, the commit message doesn't mention IRQF_ONESHOT (which was
not set before).

if you used IRQF_ONESHOT on purpose then please mention it in the
patch description.


Martin
