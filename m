Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C249C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1017520820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560188176;
	bh=yngxEUZsDeO9jKmEiRe01p0lStP+ET5zKpvRqAHTYfo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xz0FmCwkm69lF9D8ThL4VDygqbFRs6BcC5fZlWpyP7rL/Ktydf+r7vTPzNBTjByIF
	 AOcaijmT6w7h4N5KnHGMf7mdkwj4CDIdEnwIhzXaX7YPJDlQkPtKlrf7BxIXv9LfwF
	 u5VYWXfWN+Sf3dm+uNisZVCgylrBSL3ObxlxPwzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387864AbfFJRgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 13:36:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:32976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387896AbfFJRgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 13:36:15 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE864212F5;
        Mon, 10 Jun 2019 17:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560188174;
        bh=yngxEUZsDeO9jKmEiRe01p0lStP+ET5zKpvRqAHTYfo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=y4R0V50he40BZyVZoGvfZOLeGR9Yrv9zwQ2ODQEkSLmmY6IjxWbijj/cYZaBfHcSE
         lTrnAUVtkiTSKUcD1Kb6twXgMKRGDssIK3Vo0wnibdUaHElr7dxNcBjH4lznkTa1if
         Xevy2XkW1wP3o9PpLrLv5c5l3Tv1RTD6EDFpzrGU=
Received: by mail-qk1-f178.google.com with SMTP id g18so5992388qkl.3;
        Mon, 10 Jun 2019 10:36:13 -0700 (PDT)
X-Gm-Message-State: APjAAAXXg3nU2ZidC90s6jygqUguwjBFL9D7u8SOfV2QDNjYhboV0xVM
        hs2EeKRFBtDGuGuhBChaocnlA5JH1LO+01BQcQ==
X-Google-Smtp-Source: APXvYqyn/jXYaDrSMPJ5/45d6cSJ56wSyTc8w/sQmXvfhvxgcNEUwjnfzw91kiGQ4mdQCXyBdQsntduVxgoYHQwjhCY=
X-Received: by 2002:ae9:f801:: with SMTP id x1mr14208781qkh.151.1560188173041;
 Mon, 10 Jun 2019 10:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190604003218.241354-1-saravanak@google.com> <20190604003218.241354-2-saravanak@google.com>
In-Reply-To: <20190604003218.241354-2-saravanak@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 10 Jun 2019 11:36:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLWfNUJm23x+doJDwyuMLOvqWAnLKGQYcgVct-AyWb9LQ@mail.gmail.com>
Message-ID: <CAL_JsqLWfNUJm23x+doJDwyuMLOvqWAnLKGQYcgVct-AyWb9LQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v1 1/5] of/platform: Speed up of_find_device_by_node()
To:     Saravana Kannan <saravanak@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        David Collins <collinsd@codeaurora.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Why are you resending this rather than replying to Frank's last
comments on the original?

On Mon, Jun 3, 2019 at 6:32 PM Saravana Kannan <saravanak@google.com> wrote:
>
> Add a pointer from device tree node to the device created from it.
> This allows us to find the device corresponding to a device tree node
> without having to loop through all the platform devices.
>
> However, fallback to looping through the platform devices to handle
> any devices that might set their own of_node.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/of/platform.c | 20 +++++++++++++++++++-
>  include/linux/of.h    |  3 +++
>  2 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 04ad312fd85b..1115a8d80a33 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -42,6 +42,8 @@ static int of_dev_node_match(struct device *dev, void *data)
>         return dev->of_node == data;
>  }
>
> +static DEFINE_SPINLOCK(of_dev_lock);
> +
>  /**
>   * of_find_device_by_node - Find the platform_device associated with a node
>   * @np: Pointer to device tree node
> @@ -55,7 +57,18 @@ struct platform_device *of_find_device_by_node(struct device_node *np)
>  {
>         struct device *dev;
>
> -       dev = bus_find_device(&platform_bus_type, NULL, np, of_dev_node_match);
> +       /*
> +        * Spinlock needed to make sure np->dev doesn't get freed between NULL
> +        * check inside and kref count increment inside get_device(). This is
> +        * achieved by grabbing the spinlock before setting np->dev = NULL in
> +        * of_platform_device_destroy().
> +        */
> +       spin_lock(&of_dev_lock);
> +       dev = get_device(np->dev);
> +       spin_unlock(&of_dev_lock);
> +       if (!dev)
> +               dev = bus_find_device(&platform_bus_type, NULL, np,
> +                                     of_dev_node_match);
>         return dev ? to_platform_device(dev) : NULL;
>  }
>  EXPORT_SYMBOL(of_find_device_by_node);
> @@ -196,6 +209,7 @@ static struct platform_device *of_platform_device_create_pdata(
>                 platform_device_put(dev);
>                 goto err_clear_flag;
>         }
> +       np->dev = &dev->dev;
>
>         return dev;
>
> @@ -556,6 +570,10 @@ int of_platform_device_destroy(struct device *dev, void *data)
>         if (of_node_check_flag(dev->of_node, OF_POPULATED_BUS))
>                 device_for_each_child(dev, NULL, of_platform_device_destroy);
>
> +       /* Spinlock is needed for of_find_device_by_node() to work */
> +       spin_lock(&of_dev_lock);
> +       dev->of_node->dev = NULL;
> +       spin_unlock(&of_dev_lock);
>         of_node_clear_flag(dev->of_node, OF_POPULATED);
>         of_node_clear_flag(dev->of_node, OF_POPULATED_BUS);
>
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 0cf857012f11..f2b4912cbca1 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -48,6 +48,8 @@ struct property {
>  struct of_irq_controller;
>  #endif
>
> +struct device;
> +
>  struct device_node {
>         const char *name;
>         phandle phandle;
> @@ -68,6 +70,7 @@ struct device_node {
>         unsigned int unique_id;
>         struct of_irq_controller *irq_trans;
>  #endif
> +       struct device *dev;             /* Device created from this node */
>  };
>
>  #define MAX_PHANDLE_ARGS 16
> --
> 2.22.0.rc1.257.g3120a18244-goog
>
