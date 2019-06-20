Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C281C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 00:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BEB2084B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 00:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAfCDZtb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730969AbfFTAzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 20:55:09 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44962 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfFTAzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 20:55:09 -0400
Received: by mail-io1-f66.google.com with SMTP id s7so863952iob.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 17:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TtRmoGkruvSLmzfQNJOK7azAgtOLlfsMtrzHrOo4/EY=;
        b=lAfCDZtb1DwM/J4pfSrTFUM1Gf1Z8Q0qa8RroSoOHbQFdXC+JlWuqk+9DpbtKNbUqM
         +jpapJ+X1tyieQ+hB/nueI2gDlWuoGBe19Wg1ov12wf2d38Bm6+oSnJhmHGHgaWAp1jP
         j44nbi6/Q27y9S1CDvzXrrKuoOMms+uJdbAOmO9hQnrOpw79u2MfLQ2C4YAgKHf/hfWm
         dQ0janRJuPz3fT8Tg1J6tgkhLdVwNNttDaNN/YLjP8GAVFryj346xrR+VETmeOzsabrd
         yFO9gRdiSG+3uFOBsN3GVl/TBlI6RoSkNa0qyeQ+qqp7dFyw16a397Wl/+ZkDjdxUBNO
         hyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TtRmoGkruvSLmzfQNJOK7azAgtOLlfsMtrzHrOo4/EY=;
        b=t81BmYL+KEYa2v3uSCsPKpYXM/aVV8g9Ld9HEFLY3KK/bQwIiXHS9bmC/X2biNR7VY
         HCD1c4oWbHjiT4bYMqKtFQsAwqTk93I0/hDO/oyIQOgv167NEfQZRlylLzb1yBnwljMl
         Y8g1Vlonu4ClioHLtIHg/ROEh1DVWXHtcVQM4qXQmujs19nYlaV6qirQdnGgT+i79YnY
         vclo9Uugr0nbz3nOJNO6KjBsbksbNBMBZ1cbgYTGGKgPMPUg26fSWxLhgD4D3W1N4RdM
         xuX3TV7ZyNSa0vHoHYO+EYt5xK0d/zv3xlwvn83sso3TxgBxxtjtnAYfrtid+afDe2mZ
         /aTQ==
X-Gm-Message-State: APjAAAWfTb9+OknBLjYeeKq5vDkYS7Sg5l4ujOL9aS4EHq2J8WSKWUTE
        XSSqli+gtRBNe2TodDlKVz3zJ0IbDkkQUV042qM=
X-Google-Smtp-Source: APXvYqxIgWgfJa2h5v6NfHhR7cOJHthRCEx86Lv174iQxMcy7T6lqxw5CbcrwtneXmJpukC89D1achahMJKKogLvl+w=
X-Received: by 2002:a5e:aa15:: with SMTP id s21mr17458310ioe.221.1560992108640;
 Wed, 19 Jun 2019 17:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190618185502.3839-1-krzk@kernel.org> <20190618185502.3839-2-krzk@kernel.org>
In-Reply-To: <20190618185502.3839-2-krzk@kernel.org>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Thu, 20 Jun 2019 08:54:57 +0800
Message-ID: <CAKGbVbvMVRiWXf8E8hpym_F7ovoXeeTc92-hh6hA6802487jOg@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/lima: Reduce the amount of logs on deferred probe
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        lima@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like lima_clk_init will have the same problem if devm_clk_get
returns -EPROBE_DEFER.

Regards,
Qiang

On Wed, Jun 19, 2019 at 2:55 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> There is no point to print deferred probe (and its failures to get
> resources) as an error.  For example getting a regulator causes three
> unneeded error messages:
>
>     lima 13000000.gpu: failed to get regulator: -517
>     lima 13000000.gpu: regulator init fail -517
>     lima 13000000.gpu: Fatal error during GPU init
>
> Also do not print clock rates before the initialization finishes
> because they will be duplicated after deferral.  Each probe step already
> prints error so remove the final error message "Fatal error during GPU
> init".
>
> In case of multiple probe tries this would pollute the dmesg.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/gpu/drm/lima/lima_device.c | 17 ++++++-----------
>  drivers/gpu/drm/lima/lima_drv.c    |  4 +---
>  2 files changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_device.c b/drivers/gpu/drm/lima/lima_device.c
> index 570d0e93f9a9..bb2eaa4f370e 100644
> --- a/drivers/gpu/drm/lima/lima_device.c
> +++ b/drivers/gpu/drm/lima/lima_device.c
> @@ -80,7 +80,6 @@ const char *lima_ip_name(struct lima_ip *ip)
>  static int lima_clk_init(struct lima_device *dev)
>  {
>         int err;
> -       unsigned long bus_rate, gpu_rate;
>
>         dev->clk_bus = devm_clk_get(dev->dev, "bus");
>         if (IS_ERR(dev->clk_bus)) {
> @@ -94,12 +93,6 @@ static int lima_clk_init(struct lima_device *dev)
>                 return PTR_ERR(dev->clk_gpu);
>         }
>
> -       bus_rate = clk_get_rate(dev->clk_bus);
> -       dev_info(dev->dev, "bus rate = %lu\n", bus_rate);
> -
> -       gpu_rate = clk_get_rate(dev->clk_gpu);
> -       dev_info(dev->dev, "mod rate = %lu", gpu_rate);
> -
>         err = clk_prepare_enable(dev->clk_bus);
>         if (err)
>                 return err;
> @@ -145,7 +138,8 @@ static int lima_regulator_init(struct lima_device *dev)
>                 dev->regulator = NULL;
>                 if (ret == -ENODEV)
>                         return 0;
> -               dev_err(dev->dev, "failed to get regulator: %d\n", ret);
> +               if (ret != -EPROBE_DEFER)
> +                       dev_err(dev->dev, "failed to get regulator: %d\n", ret);
>                 return ret;
>         }
>
> @@ -297,10 +291,8 @@ int lima_device_init(struct lima_device *ldev)
>         }
>
>         err = lima_regulator_init(ldev);
> -       if (err) {
> -               dev_err(ldev->dev, "regulator init fail %d\n", err);
> +       if (err)
>                 goto err_out0;
> -       }
>
>         ldev->empty_vm = lima_vm_create(ldev);
>         if (!ldev->empty_vm) {
> @@ -343,6 +335,9 @@ int lima_device_init(struct lima_device *ldev)
>         if (err)
>                 goto err_out5;
>
> +       dev_info(ldev->dev, "bus rate = %lu\n", clk_get_rate(ldev->clk_bus));
> +       dev_info(ldev->dev, "mod rate = %lu", clk_get_rate(ldev->clk_gpu));
> +
>         return 0;
>
>  err_out5:
> diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_drv.c
> index b29c26cd13b2..cebc44592e47 100644
> --- a/drivers/gpu/drm/lima/lima_drv.c
> +++ b/drivers/gpu/drm/lima/lima_drv.c
> @@ -307,10 +307,8 @@ static int lima_pdev_probe(struct platform_device *pdev)
>         ldev->ddev = ddev;
>
>         err = lima_device_init(ldev);
> -       if (err) {
> -               dev_err(&pdev->dev, "Fatal error during GPU init\n");
> +       if (err)
>                 goto err_out1;
> -       }
>
>         /*
>          * Register the DRM device with the core and the connectors with
> --
> 2.17.1
>
