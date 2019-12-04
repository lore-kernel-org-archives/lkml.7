Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776CEC2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BDE42053B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="CDaJqeQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfLDJiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 04:38:21 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:40068 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfLDJiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 04:38:21 -0500
Received: by mail-vs1-f66.google.com with SMTP id g23so4398167vsr.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 01:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WKSRUXAknnFGuVSfHxGReWQUvxVO29cQQA2zNwSpULM=;
        b=CDaJqeQsxOZakv4IT6D02OCbik+0JlBE+4lW70GNPFrDEFKnnoc3a8bqcNSiwepcwC
         cbJnJpVsMMkkV7fnsnKqSi6b2MIMjGBTbQJw9WC/Sf+OKijQ7fegzoqei60yfDYakOCD
         QHYwwu9vOBc510u62DIDNsNyh68brak/HneiZJLEhbTx3JBFur6r9Zqr0gY+gq7a9Cfn
         ZbZHvB1xp5BrhFFyEoGJAwDj06xILJWc9gqVAk7NROWUX4cZoUix68cPuk9SNW1m45QQ
         756cGhUjUX4q6Fgm5/5AZXXZvhghT6WshaTKrVS6kYt7GIyAcuYQsp1PtTACJAE4NqsX
         RdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WKSRUXAknnFGuVSfHxGReWQUvxVO29cQQA2zNwSpULM=;
        b=Hn33oJqePS1DeXKEHlXTtYQCLGWWRVz+lCKVpbfTjiwPBFohwFrkKz/IhuQ/elCXDn
         WHxCWBy0AVhMlcC5LxmyAfEuxdXdQNF4N0RnaoFbTeemPNxFUiOrDMJaxtlvhIGXxhD6
         vhuXSc62oH/6ZixN9COS8NxghGp50cL/CXvKTGGXbs9+9Z0pATMtC3djWED+5HcIm1+3
         Gx2gB5gdl8jUM4mnXazBdrS5Kt7FdSCznTq0nohFnaKKDD5d0lD/JnNSZ3bwp4qdPPx7
         ES0MSEakRwxnSoW0QV4YBVzNE015knRsnGZJyhf+L8MEIfhjqkC5+kiHTnl1b2iO7oud
         hC9Q==
X-Gm-Message-State: APjAAAUCysRsRrEVkpgHfWGWUcW1HxDuQuAQzRMJi3EUZiuE7Rf8qca0
        pyEzsJMMYPZ6OcoYcZeE8INGTLBR5JfIHMKp3rMGEA==
X-Google-Smtp-Source: APXvYqxrL3FunHxe+ypKQfT/9GTtMwGi/xMYe45gMeFuXII2RAGl5/rsBU+x3Cj/hRM/BBU+FzxbdlSSvE4RNraI958=
X-Received: by 2002:a67:f8cf:: with SMTP id c15mr1068522vsp.27.1575452299891;
 Wed, 04 Dec 2019 01:38:19 -0800 (PST)
MIME-Version: 1.0
References: <20191030182132.25763-1-f.fainelli@gmail.com> <20191030182132.25763-6-f.fainelli@gmail.com>
In-Reply-To: <20191030182132.25763-6-f.fainelli@gmail.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 4 Dec 2019 15:08:08 +0530
Message-ID: <CAHLCerP=3uFsj_fxGcWiKppWfOoYQRmLq1PhEZvC8ZURr=sh5A@mail.gmail.com>
Subject: Re: [PATCH 5/6] thermal: brcmstb_thermal: Restructure interrupt registration
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        "maintainer:BROADCOM STB AVS TMON DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:BROADCOM STB AVS TMON DRIVER" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 11:52 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> If we are successful grabbing the interrupt resource, then register an
> interrupt handler, this makes it easier to support the interrupt as
> being optional, which is it for 7216.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/broadcom/brcmstb_thermal.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
> index 41d4a142707c..64f715053ce9 100644
> --- a/drivers/thermal/broadcom/brcmstb_thermal.c
> +++ b/drivers/thermal/broadcom/brcmstb_thermal.c
> @@ -339,16 +339,15 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
>         priv->thermal = thermal;
>
>         irq = platform_get_irq(pdev, 0);
> -       if (irq < 0) {
> -               dev_err(&pdev->dev, "could not get IRQ\n");
> -               return irq;
> -       }
> -       ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> -                                       brcmstb_tmon_irq_thread, IRQF_ONESHOT,
> -                                       DRV_NAME, priv);
> -       if (ret < 0) {
> -               dev_err(&pdev->dev, "could not request IRQ: %d\n", ret);
> -               return ret;
> +       if (irq >= 0) {
> +               ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +                                               brcmstb_tmon_irq_thread,
> +                                               IRQF_ONESHOT,
> +                                               DRV_NAME, priv);
> +               if (ret < 0) {
> +                       dev_err(&pdev->dev, "could not request IRQ: %d\n", ret);
> +                       return ret;
> +               }
>         }
>
>         dev_info(&pdev->dev, "registered AVS TMON of-sensor driver\n");
> --
> 2.17.1
>
