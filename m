Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED83C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914BF2084B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570438434;
	bh=zqjR3DgTlmbb/gaEzv2p8No/78qj4Mo9B9XhbQ1ufWY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mpyFmiaU1/h79ossbrjd9RAMWMfjFfuFSnnViGPs8LHfThFEqz9sN5pv5N1hV5pOq
	 dCW5nc0/MAcjI3yOK6vTsIYzS6UvdO1JaHtrTg/vRAb44kg9pXY5Xmkt1DDWzETDWK
	 BVFbGlPj1mItGSqp0Lr0mf5I1mWhpUuYoBwYJcv4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfJGIxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 04:53:53 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41984 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfJGIxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 04:53:53 -0400
Received: by mail-ot1-f65.google.com with SMTP id c10so10282687otd.9;
        Mon, 07 Oct 2019 01:53:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CJwKV7c7t/InKjt3W1JAfd08/WuICvTQvlCpRokAAT4=;
        b=JZsJbEAtMupq39HYi7Swlw74wlZB/YN+0NI8P5hHgWhnpFwsFYte+lK81acNG5IwcP
         WbdXnFGca2T6Q3/0UAfm9V8n/f7SdBQB5Vs83JrgCcQspa+KL4XOFEzTOh4iUhq9g1HX
         PIQbxBxRAd3MbA3atIkpAfydFj8wr4/17I1WMELd5mxBRDaz6MYth3BF4SyuPA/T+riZ
         7kkmry5fYP7/aan03TMyJS3+2hbTLB+uzs2zKzI/1UBuTrXJ20pEYpzZ0bWnzrZdgUpO
         8THbp/iTu0dJHrxfkcTzVH49hP5RzO1YwE8+o7lp/RftEVMbQuz44gLkyAWtdIk45l1M
         LG5A==
X-Gm-Message-State: APjAAAUsDzTC9EzJdq2M6w3qDVOv+k2BT4wuxOCQq+nBzfjMnCGdhy15
        8akzIhCNv7f9qjCOlQfk/4Po0TskhAE48Fb0TL0=
X-Google-Smtp-Source: APXvYqxd7Uuq1CmQMDkAVpN2R6vBlawdYZlMBeX0j4oXaYN2xzYqLJ3l+UKWnYWMoDRX3+SxZt8bj7LwTwzcq8QMQPg=
X-Received: by 2002:a9d:5a0f:: with SMTP id v15mr20698608oth.266.1570438432341;
 Mon, 07 Oct 2019 01:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191005210449.3926-1-hdegoede@redhat.com> <20191005210449.3926-2-hdegoede@redhat.com>
In-Reply-To: <20191005210449.3926-2-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Oct 2019 10:53:40 +0200
Message-ID: <CAJZ5v0jXoUG+iP+ydhTpnNKTaUJB7vWQhvFbZOK25eU4aGzPaA@mail.gmail.com>
Subject: Re: [PATCH 1/3] driver core: platform: Add platform_get_irq_byname_optional()
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>, Stephen Boyd <swboyd@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 5, 2019 at 11:04 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Some drivers (e.g dwc3) first try to get an IRQ byname and then fall
> back to the one at index 0. In this case we do not want the error(s)
> printed by platform_get_irq_byname(). This commit adds a new
> platform_get_irq_byname_optional(), which does not print errors, for this.
>
> While at it also improve the kdoc text for platform_get_irq_byname() a bit.
>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=205037
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

No issues found:

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/platform.c         | 46 ++++++++++++++++++++++++++++-----
>  include/linux/platform_device.h |  2 ++
>  2 files changed, 41 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index b6c6c7d97d5b..b230beb6ccb4 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -241,12 +241,8 @@ struct resource *platform_get_resource_byname(struct platform_device *dev,
>  }
>  EXPORT_SYMBOL_GPL(platform_get_resource_byname);
>
> -/**
> - * platform_get_irq_byname - get an IRQ for a device by name
> - * @dev: platform device
> - * @name: IRQ name
> - */
> -int platform_get_irq_byname(struct platform_device *dev, const char *name)
> +static int __platform_get_irq_byname(struct platform_device *dev,
> +                                    const char *name)
>  {
>         struct resource *r;
>
> @@ -262,11 +258,47 @@ int platform_get_irq_byname(struct platform_device *dev, const char *name)
>         if (r)
>                 return r->start;
>
> -       dev_err(&dev->dev, "IRQ %s not found\n", name);
>         return -ENXIO;
>  }
> +
> +/**
> + * platform_get_irq_byname - get an IRQ for a device by name
> + * @dev: platform device
> + * @name: IRQ name
> + *
> + * Get an IRQ like platform_get_irq(), but then by name rather then by index.
> + *
> + * Return: IRQ number on success, negative error number on failure.
> + */
> +int platform_get_irq_byname(struct platform_device *dev, const char *name)
> +{
> +       int ret;
> +
> +       ret = __platform_get_irq_byname(dev, name);
> +       if (ret < 0 && ret != -EPROBE_DEFER)
> +               dev_err(&dev->dev, "IRQ %s not found\n", name);
> +
> +       return ret;
> +}
>  EXPORT_SYMBOL_GPL(platform_get_irq_byname);
>
> +/**
> + * platform_get_irq_byname_optional - get an optional IRQ for a device by name
> + * @dev: platform device
> + * @name: IRQ name
> + *
> + * Get an optional IRQ by name like platform_get_irq_byname(). Except that it
> + * does not print an error message if an IRQ can not be obtained.
> + *
> + * Return: IRQ number on success, negative error number on failure.
> + */
> +int platform_get_irq_byname_optional(struct platform_device *dev,
> +                                    const char *name)
> +{
> +       return __platform_get_irq_byname(dev, name);
> +}
> +EXPORT_SYMBOL_GPL(platform_get_irq_byname_optional);
> +
>  /**
>   * platform_add_devices - add a numbers of platform devices
>   * @devs: array of platform devices to add
> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> index 1b5cec067533..f2688404d1cd 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -64,6 +64,8 @@ extern struct resource *platform_get_resource_byname(struct platform_device *,
>                                                      unsigned int,
>                                                      const char *);
>  extern int platform_get_irq_byname(struct platform_device *, const char *);
> +extern int platform_get_irq_byname_optional(struct platform_device *dev,
> +                                           const char *name);
>  extern int platform_add_devices(struct platform_device **, int);
>
>  struct platform_device_info {
> --
> 2.23.0
>
