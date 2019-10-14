Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D20ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1872133F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P3sNmpyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732707AbfJNOcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:32:47 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38294 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731121AbfJNOcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:32:46 -0400
Received: by mail-qt1-f195.google.com with SMTP id j31so25712488qta.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 07:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jh1Xv42HTTtwmxhqCtdsejKM5Dntl522tkuHl33kJk4=;
        b=P3sNmpyIcNeZD8fTLdWrBX33rU5etmRObYsN7svAbj/KLbvBzmApjwe6VGVsBMYkrc
         MSZSn2Xa52REQ+SucE4Qjb8+3zVJ+6UXGOhtbBgSzrTrn0dT60miOIrGkxtwDdy8o22Y
         j0LLclmpkGiH4Y6AQPrBIONh3tvZOZdxXpZygb5HvpxN8O/Ud4IYcq5dT28vs/vxaFvc
         iIDv29xAYBdGNemMkERNjs0KNPKweyp7uw2nLPTqW4nalduFQQ5vKO1be46GRSukIhzp
         TnipCB10FhP1HcjZr5B1YmKFkn+0oIDWk0OQpTP1clVP77fd4SnA4f38CIq8eBGiQ+qO
         nQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jh1Xv42HTTtwmxhqCtdsejKM5Dntl522tkuHl33kJk4=;
        b=nK5yDkU8tcZmkF4uf9bv+gaDL5pBxD67CJF3+J2X3trbBs0TI+NZ3YMqaGxk70Bcmu
         U3jWG9r4L6+CZ1I5kX01g58LtjxOe/WsLE0TcYfM+X/OG9V/5SyzwIoMieh3CAN78kJ4
         egcFoK2appg74mk+4ZsuJLWuKEFc5X1T5T0d/WqlJDZ46r1UuQp0MKFySRWc5aEanZwS
         UCf4NPLOQHcyuQm7K/oSw0vlRmuV1SYgKOw1tXS6GJ9iUOK3NE6kW6BOJH9x553rVxpO
         ABZfTpSwbStbM9AWAb9SuXvuJszTYJmXjtOvHaOAi5w0IqdIQOY4aJaaz3uW0XSdyz1p
         kfGw==
X-Gm-Message-State: APjAAAXfusOd8HVUoZa0wb2O/U4zl8UEIaL3GI3AVMbLnNzR1+fG3H0W
        so+m2xhLLss/XlAr5t/tZwJGmPe1VUBNA92LmBR2lQ==
X-Google-Smtp-Source: APXvYqzsoWPEP43Z3L5Dz9F518H/l7kj+qgoYmNx43PzKG2znUoHJURuJXgYUPmIPO7QICQ5OslDnJsAKHNNAKXjEkE=
X-Received: by 2002:aed:2a3b:: with SMTP id c56mr34156048qtd.343.1571063565275;
 Mon, 14 Oct 2019 07:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191012065255.23249-1-daniel.lezcano@linaro.org> <20191012065255.23249-11-daniel.lezcano@linaro.org>
In-Reply-To: <20191012065255.23249-11-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 14 Oct 2019 20:02:34 +0530
Message-ID: <CAP245DVpV3-qkawjAyHYk5Ke9W_uoFy3FEHMM5z3036WD2dh6w@mail.gmail.com>
Subject: Re: [PATCH 11/11] thermal: Move thermal governor structure to
 internal header
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2019 at 12:23 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The thermal governor structure is a big structure where no
> user should change value inside except via helper functions.
>
> Move the structure to the internal header thus preventing external
> code to be tempted by hacking the structure's variables.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/thermal_core.h | 20 ++++++++++++++++++++
>  include/linux/thermal.h        | 21 +--------------------
>  2 files changed, 21 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index c75309d858ce..e54150fa4c5b 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -46,6 +46,26 @@ struct thermal_attr {
>         char name[THERMAL_NAME_LENGTH];
>  };
>
> +/**
> + * struct thermal_governor - structure that holds thermal governor information
> + * @name:      name of the governor
> + * @bind_to_tz: callback called when binding to a thermal zone.  If it
> + *             returns 0, the governor is bound to the thermal zone,
> + *             otherwise it fails.
> + * @unbind_from_tz:    callback called when a governor is unbound from a
> + *                     thermal zone.
> + * @throttle:  callback called for every trip point even if temperature is
> + *             below the trip point temperature
> + * @governor_list:     node in thermal_governor_list (in thermal_core.c)
> + */
> +struct thermal_governor {
> +       char name[THERMAL_NAME_LENGTH];
> +       int (*bind_to_tz)(struct thermal_zone_device *tz);
> +       void (*unbind_from_tz)(struct thermal_zone_device *tz);
> +       int (*throttle)(struct thermal_zone_device *tz, int trip);
> +       struct list_head        governor_list;
> +};
> +
>  static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
>  {
>         return cdev->ops->get_requested_power && cdev->ops->state2power &&
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 8daa179918a1..04264e8a2bce 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -45,6 +45,7 @@
>
>  struct thermal_zone_device;
>  struct thermal_cooling_device;
> +struct thermal_governor;
>  struct thermal_instance;
>  struct thermal_attr;
>
> @@ -206,26 +207,6 @@ struct thermal_zone_device {
>         enum thermal_notify_event notify_event;
>  };
>
> -/**
> - * struct thermal_governor - structure that holds thermal governor information
> - * @name:      name of the governor

AFAICT, some drivers actually like to specify what governor to use
when calling thermal_zone_device_register(), by passing the
thermal_zone_params parameter. You will probably need to provide for
helper functions to return the value of governor name, I think.

> - * @bind_to_tz: callback called when binding to a thermal zone.  If it
> - *             returns 0, the governor is bound to the thermal zone,
> - *             otherwise it fails.
> - * @unbind_from_tz:    callback called when a governor is unbound from a
> - *                     thermal zone.
> - * @throttle:  callback called for every trip point even if temperature is
> - *             below the trip point temperature
> - * @governor_list:     node in thermal_governor_list (in thermal_core.c)
> - */
> -struct thermal_governor {
> -       char name[THERMAL_NAME_LENGTH];
> -       int (*bind_to_tz)(struct thermal_zone_device *tz);
> -       void (*unbind_from_tz)(struct thermal_zone_device *tz);
> -       int (*throttle)(struct thermal_zone_device *tz, int trip);
> -       struct list_head        governor_list;
> -};
> -
>  /* Structure that holds binding parameters for a zone */
>  struct thermal_bind_params {
>         struct thermal_cooling_device *cdev;
> --
> 2.17.1
>
