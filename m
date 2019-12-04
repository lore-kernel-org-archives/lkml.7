Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD090C2BBE2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8334B2053B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="KmCelkED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfLDJiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 04:38:55 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:35381 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfLDJiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 04:38:54 -0500
Received: by mail-vk1-f196.google.com with SMTP id o187so1942276vka.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 01:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kBM+7sKdP9ujCe9ALp3o3fbTa5VggqfmCZsELUt7gmY=;
        b=KmCelkEDW//pN0sIHhURzAdIgLRrtV4W3ZvTphxbkEmsYa1UnJ8NBPQ6XL/j0Bldte
         kJyRTSZQ+yPMegb0hHGLLP/ToYjBXYveq8S5Swj1BjlkIp3xFREhO+MPg+AiRGAiqibI
         p1TqIRD0ZqDISySdUxlmYNiOhjm3vULrjvK394FDYqQym+DAcYdt61u2UBwvkjBm2J0V
         Yo4ZP5rt0xsVN6qBRHM4UkVQX/Qo2ZiEHo0Ipxym4ZMYrruHY2nBXI0odgsaghVkmVtV
         rsEMmkg4qNTOwmkU5ESS+kg0giexdzQjnQ9Qd2EAPb35bPQRkSChyoHVSMRHqmOKCPuG
         g3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kBM+7sKdP9ujCe9ALp3o3fbTa5VggqfmCZsELUt7gmY=;
        b=tG/ALrnXiDf79mCVmLBnbJz5TeAIX/4yNvyJNtfZwx0HwTFAaHcJe6HR257FgB0zd4
         oOaZiRWXjmLGcLCvlbocJQugartb5ueiGaXIOQm1RkJclT3r0VJhK4quneKjV0EBHD9G
         7Dh7i0txydmaM/EhNfFEo6CD+6+pDbiQNbAtTOF5AyVbv5gfNa+UogEb1Y9uksulB+SS
         Tyv2KobdUVUZR9VKIwbXBnke12Q3WuYwA6PLbL0cpBRfqrHVwj7n5epAdmQ+e9j5YToy
         53JH+IXT1E6MVxXCZ1a8GuFKShcgHfS65RrSHBao7YgsIV6ai1goISAOvDK4XFDurcu8
         Enag==
X-Gm-Message-State: APjAAAXnfP6WMI3hImKvIDtO3DHnetKy3oIn2gfYHgYx8YkGTUjY6nis
        v17cVWvmXlllx/psSdFvTPo2tv0y2OkTq2NFCtdrew==
X-Google-Smtp-Source: APXvYqwiUoUoPZvgpG+ifopwxSLWwG1iOG5+9d9DmpNIKyb1VOCcZCyapnluKjwiXLoMcJdRA6EYd8bNW2NVGYtZ3eU=
X-Received: by 2002:ac5:c4f8:: with SMTP id b24mr1401815vkl.79.1575452333245;
 Wed, 04 Dec 2019 01:38:53 -0800 (PST)
MIME-Version: 1.0
References: <20191030182132.25763-1-f.fainelli@gmail.com> <20191030182132.25763-7-f.fainelli@gmail.com>
In-Reply-To: <20191030182132.25763-7-f.fainelli@gmail.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 4 Dec 2019 15:08:41 +0530
Message-ID: <CAHLCerPyJxsLs5at4dQ7GdDXpC85UijNNhJbKSoDsdLW2do00w@mail.gmail.com>
Subject: Re: [PATCH 6/6] thermal: brcmstb_thermal: Register different ops per process
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
> Since we do not have interrupts on BCM7216, we cannot have trip point
> crossing, the thermal subsystem expects us to provide a NULL set_trips
> operation in that case, so make it possible to provide per-process
> thermal_zone_of_device_ops
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/broadcom/brcmstb_thermal.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
> index 64f715053ce9..a75a335d1bb3 100644
> --- a/drivers/thermal/broadcom/brcmstb_thermal.c
> +++ b/drivers/thermal/broadcom/brcmstb_thermal.c
> @@ -96,6 +96,7 @@ static struct avs_tmon_trip avs_tmon_trips[] = {
>  struct brcmstb_thermal_params {
>         unsigned int offset;
>         unsigned int mult;
> +       const struct thermal_zone_of_device_ops *of_ops;
>  };
>
>  struct brcmstb_thermal_priv {
> @@ -278,19 +279,25 @@ static int brcmstb_set_trips(void *data, int low, int high)
>         return 0;
>  }
>
> -static const struct thermal_zone_of_device_ops of_ops = {
> +static const struct thermal_zone_of_device_ops brcmstb_16nm_of_ops = {
>         .get_temp       = brcmstb_get_temp,
> -       .set_trips      = brcmstb_set_trips,
>  };
>
>  static const struct brcmstb_thermal_params brcmstb_16nm_params = {
>         .offset = 457829,
>         .mult   = 557,
> +       .of_ops = &brcmstb_16nm_of_ops,
> +};
> +
> +static const struct thermal_zone_of_device_ops brcmstb_28nm_of_ops = {
> +       .get_temp       = brcmstb_get_temp,
> +       .set_trips      = brcmstb_set_trips,
>  };
>
>  static const struct brcmstb_thermal_params brcmstb_28nm_params = {
>         .offset = 410040,
>         .mult   = 487,
> +       .of_ops = &brcmstb_28nm_of_ops,
>  };
>
>  static const struct of_device_id brcmstb_thermal_id_table[] = {
> @@ -329,7 +336,7 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
>         platform_set_drvdata(pdev, priv);
>
>         thermal = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, priv,
> -                                                      &of_ops);
> +                                                      priv->temp_params.of_ops);
>         if (IS_ERR(thermal)) {
>                 ret = PTR_ERR(thermal);
>                 dev_err(&pdev->dev, "could not register sensor: %d\n", ret);
> --
> 2.17.1
>
