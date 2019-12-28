Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9D6C2D0C6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 17:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6717208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 17:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stqjHdMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfL1Rje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 12:39:34 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:38817 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfL1Rje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 12:39:34 -0500
Received: by mail-io1-f65.google.com with SMTP id v3so28305278ioj.5
        for <linux-kernel@vger.kernel.org>; Sat, 28 Dec 2019 09:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nkCMArF5O7FXPw9BK2mgjdrIaTyHpsDk1hbsnTlNyJs=;
        b=stqjHdMIvlCCQU7QSqBhhrLQXtLp4MjfeRb6tc8UaWpblVQe6np+9BiXPqJ4FM+lCs
         60yIPCesMBN/wWiJiAb/UrVnMfND7ZNzcTOQv8NTHRm9wqQp/Z2B3sLhGpjRnJzjzfFq
         1rPAFgLDUk5BylE/oIzVbfUub9tQLyIiedJL6E4NH8RAbNTI4ASDEwM8loFlLcAg6BRw
         ug9Vof8O1H3TXd8hOmCok9FwhAGsJLZ3o5EFhr4BoxOGrruWfIgGNS/A0qbdGod3YtHh
         wACkY8OpHm//bPKKEL6nXtEOyYslQqOoaXnMPSQJG4JvdO0PR5nCqAmMp6ngAQXiYLXa
         LSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nkCMArF5O7FXPw9BK2mgjdrIaTyHpsDk1hbsnTlNyJs=;
        b=hulJScJ/1rCmXrGEgBw1cu+YNTQ9Bh3pIy6iMwfLqcqsRd5pjbFCNVc2qayb9FHDDo
         G0aVDvYYju31ym4QcAsfeykf3qXHDK5wkEarcSNwOulrWZ4dLoujUlE2KPOBgpPguTQ2
         VdsnIC9Ys/f4/FkkU96XO47xtdlyFq3mRMP2c03Hs5HbGQAs26f5k2tmNP1Ik3gMXTW5
         098jhmmxRne+6+054MiX1sjWYRAqKmUL//yUzfsNZB/8M50g8ep2NOpjNymjmMbkn0/b
         OGpua2GLaKlDTKxvtLb87yuZuLqpuzWBuHUmS9ceXCPPoXxQGuUFnOhUrmgnxd129K4A
         SDoA==
X-Gm-Message-State: APjAAAXkaBDEuhriqVEwJJgdDArrFx1m4he1CbBb84Jn3mqBXtqKVS1G
        EkOkp/XcCLZm8jb4JJXc9RsfyNVMsdaH0kYUlxw=
X-Google-Smtp-Source: APXvYqyr/5wjv0CAn42AahOFrX+6N7JwDXAu/FKvMB0E9bGBOizVAHxY7kmasrb40gVuFjrfidmQTqq1aCWHimSjN84=
X-Received: by 2002:a6b:c410:: with SMTP id y16mr36580386ioa.18.1577554773160;
 Sat, 28 Dec 2019 09:39:33 -0800 (PST)
MIME-Version: 1.0
References: <20191210203149.7115-1-tiny.windzz@gmail.com>
In-Reply-To: <20191210203149.7115-1-tiny.windzz@gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sun, 29 Dec 2019 01:39:21 +0800
Message-ID: <CAEExFWvd1Md-guT=wgZ1-G69r71KBn64k2yGh0Vqjh_-D8yGuQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: add devm_platform_ioremap_resource_byname() helper
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        vz@mleia.com, khilman@baylibre.com,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        andriy.shevchenko@linux.intel.com,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        mans@mansr.com, treding@nvidia.com, suzuki.poulose@arm.com,
        bgolaszewski@baylibre.com, tglx@linutronix.de
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping...

On Wed, Dec 11, 2019 at 4:31 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> There are currently 300+ instances of using platform_get_resource_byname()
> and devm_ioremap_resource() together in the kernel tree.
>
> This patch wraps these two calls in a single helper.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/base/platform.c         | 22 +++++++++++++++++++++-
>  include/linux/platform_device.h |  3 +++
>  2 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index b6c6c7d97d5b..9c4f5e229600 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -60,6 +60,7 @@ struct resource *platform_get_resource(struct platform_device *dev,
>  }
>  EXPORT_SYMBOL_GPL(platform_get_resource);
>
> +#ifdef CONFIG_HAS_IOMEM
>  /**
>   * devm_platform_ioremap_resource - call devm_ioremap_resource() for a platform
>   *                                 device
> @@ -68,7 +69,7 @@ EXPORT_SYMBOL_GPL(platform_get_resource);
>   *        resource management
>   * @index: resource index
>   */
> -#ifdef CONFIG_HAS_IOMEM
> +
>  void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
>                                              unsigned int index)
>  {
> @@ -78,6 +79,25 @@ void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
>         return devm_ioremap_resource(&pdev->dev, res);
>  }
>  EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);
> +
> +/**
> + * devm_platform_ioremap_resource_byname - call devm_ioremap_resource() for
> + *                                        a platform device
> + *
> + * @pdev: platform device to use both for memory resource lookup as well as
> + *        resource managemend
> + * @name: resource name
> + */
> +void __iomem *
> +devm_platform_ioremap_resource_byname(struct platform_device *pdev,
> +                                     const char *name)
> +{
> +       struct resource *res;
> +
> +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
> +       return devm_ioremap_resource(&pdev->dev, res);
> +}
> +EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource_byname);
>  #endif /* CONFIG_HAS_IOMEM */
>
>  static int __platform_get_irq(struct platform_device *dev, unsigned int num)
> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> index 1b5cec067533..24ff5da9c532 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -63,6 +63,9 @@ extern int platform_irq_count(struct platform_device *);
>  extern struct resource *platform_get_resource_byname(struct platform_device *,
>                                                      unsigned int,
>                                                      const char *);
> +extern void __iomem *
> +devm_platform_ioremap_resource_byname(struct platform_device *pdev,
> +                                     const char *name);
>  extern int platform_get_irq_byname(struct platform_device *, const char *);
>  extern int platform_add_devices(struct platform_device **, int);
>
> --
> 2.17.1
>
