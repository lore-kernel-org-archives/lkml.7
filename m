Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB30C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B107D21721
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570623830;
	bh=dk0NDPEVpUH/ohNfjsTod12FNP7vnhvBuHyiIhkRLSo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=f3kcGZObhGhxqGpRPGn9ScLXwLNbjH9DgJsyoeYDLgxG4bAWj+PZXkkPloOxLO+ZN
	 6OeJA0FG3GQXyp4rMformfT4xpBmK7OruHTAmdQLnOxZW3XbeU6hOuwJTAmrOGClnH
	 aiRCY8/cTzK0Fu0oLieE7sBZOIs3/MXooNleDcsY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbfJIMXt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 08:23:49 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45968 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbfJIMXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 08:23:49 -0400
Received: by mail-ot1-f68.google.com with SMTP id 41so1500342oti.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 05:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=786VH1kGJ/rECMWxJlcHmp7jm+mycjsFPVtWK6MiJZE=;
        b=LPlg7fFe3RgFLRKzx1q/59Ll8jZa16ehPEhRHP0RL53X8mehXPGtECtBEsq8vJ0l3E
         mwlEnmVgINr8rFqbXYuIaVLzluws4xyMZErK8XIlOpy3sJwVfPDNxpge2VBQ7m+AxH2x
         tF9j6dg1ftn42CrL3hgADzleK/1tb1kQh2tStdMfChFFwuJB5q3S1W0WTAfZ2ElPDj28
         NqPTChhzccjccdU8vdZz13Zk1J2cFrW7Y9PHhGSNEmLaqFji0OKVI+Ik+et1yN9uIwlz
         5qcWLfPJ5vl5EXzVkB9nALtkrGu7DItoZbgThuRm7rPSdZ76LYgVYrsyREA2zn2WJWXE
         P0HA==
X-Gm-Message-State: APjAAAWR0/oKuNGXPNWq026nhDrWh/wZncwxMPmUyrcMrHfJf9qo1lu3
        IKGT7YlKA48tKKknas4KDrbJo7z0jOFIN1WRJNk=
X-Google-Smtp-Source: APXvYqyFdUhXDtizVnSbz3YgZ7rvOOxDeuKaZi0vzb//b7JgfEJWNpyFIToXbadW0XmEP1wMIctTaBn7l5VA7NMYkWE=
X-Received: by 2002:a9d:5907:: with SMTP id t7mr2442799oth.118.1570623826618;
 Wed, 09 Oct 2019 05:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190828083411.2496-1-thierry.reding@gmail.com> <20191009093746.12095-1-uwe@kleine-koenig.org>
In-Reply-To: <20191009093746.12095-1-uwe@kleine-koenig.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Oct 2019 14:23:35 +0200
Message-ID: <CAJZ5v0grWcpL4wRdOk-zMX7aD2Awrp-Xa1xVYxZp+RF0ySw=5Q@mail.gmail.com>
Subject: Re: [PATCH] driver core: simplify definitions of platform_get_irq*
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 11:39 AM Uwe Kleine-König <uwe@kleine-koenig.org> wrote:
>
> platform_get_irq_optional is just a wrapper for __platform_get_irq. So
> rename __platform_get_irq to platform_get_irq_optional and drop
> platform_get_irq_optional's previous implementation. This way there is
> one function and one indirection less without loss of functionality.
>
> Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>

Makes sense to me:

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/platform.c | 47 ++++++++++++++++++-----------------------
>  1 file changed, 21 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index b6c6c7d97d5b..60ff536b46f1 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -80,7 +80,24 @@ void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
>  EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);
>  #endif /* CONFIG_HAS_IOMEM */
>
> -static int __platform_get_irq(struct platform_device *dev, unsigned int num)
> +/**
> + * platform_get_irq_optional - get an optional IRQ for a device
> + * @dev: platform device
> + * @num: IRQ number index
> + *
> + * Gets an IRQ for a platform device. Device drivers should check the return
> + * value for errors so as to not pass a negative integer value to the
> + * request_irq() APIs. This is the same as platform_get_irq(), except that it
> + * does not print an error message if an IRQ can not be obtained.
> + *
> + * Example:
> + *             int irq = platform_get_irq_optional(pdev, 0);
> + *             if (irq < 0)
> + *                     return irq;
> + *
> + * Return: IRQ number on success, negative error number on failure.
> + */
> +int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
>  {
>  #ifdef CONFIG_SPARC
>         /* sparc does not have irqs represented as IORESOURCE_IRQ resources */
> @@ -144,6 +161,7 @@ static int __platform_get_irq(struct platform_device *dev, unsigned int num)
>         return -ENXIO;
>  #endif
>  }
> +EXPORT_SYMBOL_GPL(platform_get_irq_optional);
>
>  /**
>   * platform_get_irq - get an IRQ for a device
> @@ -165,7 +183,7 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
>  {
>         int ret;
>
> -       ret = __platform_get_irq(dev, num);
> +       ret = platform_get_irq_optional(dev, num);
>         if (ret < 0 && ret != -EPROBE_DEFER)
>                 dev_err(&dev->dev, "IRQ index %u not found\n", num);
>
> @@ -173,29 +191,6 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
>  }
>  EXPORT_SYMBOL_GPL(platform_get_irq);
>
> -/**
> - * platform_get_irq_optional - get an optional IRQ for a device
> - * @dev: platform device
> - * @num: IRQ number index
> - *
> - * Gets an IRQ for a platform device. Device drivers should check the return
> - * value for errors so as to not pass a negative integer value to the
> - * request_irq() APIs. This is the same as platform_get_irq(), except that it
> - * does not print an error message if an IRQ can not be obtained.
> - *
> - * Example:
> - *             int irq = platform_get_irq_optional(pdev, 0);
> - *             if (irq < 0)
> - *                     return irq;
> - *
> - * Return: IRQ number on success, negative error number on failure.
> - */
> -int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
> -{
> -       return __platform_get_irq(dev, num);
> -}
> -EXPORT_SYMBOL_GPL(platform_get_irq_optional);
> -
>  /**
>   * platform_irq_count - Count the number of IRQs a platform device uses
>   * @dev: platform device
> @@ -206,7 +201,7 @@ int platform_irq_count(struct platform_device *dev)
>  {
>         int ret, nr = 0;
>
> -       while ((ret = __platform_get_irq(dev, nr)) >= 0)
> +       while ((ret = platform_get_irq_optional(dev, nr)) >= 0)
>                 nr++;
>
>         if (ret == -EPROBE_DEFER)
> --
> 2.23.0
>
