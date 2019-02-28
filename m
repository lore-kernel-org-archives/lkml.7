Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E54EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78072171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDAzVIu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732565AbfB1MdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:33:22 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34937 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfB1MdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:33:22 -0500
Received: by mail-qt1-f193.google.com with SMTP id p48so23231630qtk.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 04:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UCpcITDh37pB7hTzOvWzBVVS5sQcqpETOzj+ndabSAI=;
        b=tDAzVIu7UPnEItgZdOmZpDqdR14vcPQpq1hQQ+ltLmGXMW4uzgwvJ6Srn8oua14ZIm
         uqriMOcao0NTyRGv48KhV4ltBJjAd6hd6M3TNsDUjj0XTpvHxW5YCRd/6WDCNxu/BqBj
         FrgSif8Czyb5kuQCVs12hW5vjqESkTsROafbojk0oRHoGcUnK2cXGw4uBF/8N5fKMrRo
         aScRaDuhNg6HEpqkjpSTRSw7ga1jkmkRq4/y6MSz48sZBbfH8eOlcAO8Nu3yenifT+SY
         VucASk1oZb19A6aKs/3IDNQbMqWfIBDVMJfP5Th4zoHQgN2l5aaxbrURBiIlij3i8fcy
         KsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UCpcITDh37pB7hTzOvWzBVVS5sQcqpETOzj+ndabSAI=;
        b=k7dJOtI39T1o2cj93+Byd5HSo1U/4L0xXqjxutujtJEHhmsKqqngyq/mWJwLYY/dUS
         8G19vWNQfu2Kn+I0rH7rRu+Y4QVNkn0RUKXUn4NkU0LZil/nkyQqetMUSai0/Jd12taA
         9K/zLv7Kj/29kPrkKXwJfSN1AFjnf/mlRhz0i64WOCJk+MoGwCzfuQ1o9JaQNQ5RBhX1
         DD/0vc4PO0XcdUP+OxDTbmFhYacWxFQgwPzzXRLyItbFtYJCyvR5HU6JkLtTHdu1vM7N
         swZtU8jmyYZW1rP7SZ7eRut3uOnpPggxYQOGXJ/Kx8lXkd2R8UMsPOqunm7Ca2BmPXEi
         xRuw==
X-Gm-Message-State: APjAAAVdJM8if3zAZ/poBwisp19MjeZunkGP6OznckSVbzoDpN/Eo1e1
        oBQRbHLW79hY2+a54DRZMW8lCgbZPCKzTSNqErw=
X-Google-Smtp-Source: APXvYqzgWyKlCUTixfA3FK9+IfuD5TXPoPz/A7qrcbGrGVWzrjcSUSQiYMk8mbtKXySJf8C4tNIspT8cca5zLzIqZls=
X-Received: by 2002:a0c:95c9:: with SMTP id t9mr6246378qvt.220.1551357200496;
 Thu, 28 Feb 2019 04:33:20 -0800 (PST)
MIME-Version: 1.0
References: <1550999629-31791-1-git-send-email-rushikesh.s.kadam@intel.com>
In-Reply-To: <1550999629-31791-1-git-send-email-rushikesh.s.kadam@intel.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 28 Feb 2019 13:33:09 +0100
Message-ID: <CAFqH_53uR6fJepJ7s9gYBFSE=0oviaFOgn=h0KcEjKwiTu+Btw@mail.gmail.com>
Subject: Re: [PATCH] cros_ec: instantiate properly Intel ISH MCU device
To:     Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@google.com>,
        Jett Rink <jettrink@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Based on the discussion we had, only some few comments.

Missatge de Rushikesh S Kadam <rushikesh.s.kadam@intel.com> del dia
dg., 24 de febr. 2019 a les 10:15:
>
> Intel Integrated Sensor Hub (ISH) is also a MCU running EC
> having feature bit EC_FEATURE_ISH. Instantiate it as a special
> CrOS EC device with device name 'cros_ish'.
>
> Signed-off-by: Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
> ---
>  drivers/mfd/cros_ec_dev.c            | 10 ++++++++++
>  include/linux/mfd/cros_ec.h          |  1 +
>  include/linux/mfd/cros_ec_commands.h |  2 ++

Better if you use the "mfd: cros_ec:" prefix in the next version so
it's clear that this should go through the MFD tree.

>  3 files changed, 13 insertions(+)
>
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 2d0fee4..be499b8 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -414,6 +414,16 @@ static int ec_device_probe(struct platform_device *pdev)
>         device_initialize(&ec->class_dev);
>         cdev_init(&ec->cdev, &fops);
>
> +       /* check whether this is actually a Intel ISH rather than an EC */

"Check whether this is actually an Integrated Sensor Hub (ISH) rather
than an EC"?

> +       if (cros_ec_check_features(ec, EC_FEATURE_ISH)) {
> +               dev_info(dev, "Intel ISH MCU detected.\n");

 dev_info(dev, "CrOS ISH MCU detected.\n"); ?

> +               /*
> +                * Help userspace differentiating ECs from ISH MCU,
> +                * regardless of the probing order.
> +                */
> +               ec_platform->ec_name = CROS_EC_DEV_ISH_NAME;
> +       }
> +
>         /*
>          * Add the class device
>          * Link to the character device for creating the /dev entry
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> index de8b588..00c5765 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -24,6 +24,7 @@
>
>  #define CROS_EC_DEV_NAME "cros_ec"
>  #define CROS_EC_DEV_PD_NAME "cros_pd"
> +#define CROS_EC_DEV_ISH_NAME "cros_ish"
>
>  /*
>   * The EC is unresponsive for a time after a reboot command.  Add a
> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
> index fc91082..9276c3c 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -856,6 +856,8 @@ enum ec_feature_code {
>         EC_FEATURE_RTC = 27,
>         /* EC supports CEC commands */
>         EC_FEATURE_CEC = 35,
> +       /* The MCU is an Intel Integrated Sensor Hub */
> +       EC_FEATURE_ISH = 40,

Just a note that we will have a trivial conflict to solve with
https://lkml.org/lkml/2019/2/27/723

>  };
>
>  #define EC_FEATURE_MASK_0(event_code) (1UL << (event_code % 32))
> --
> 1.9.1
>

Best regards,
Enric
