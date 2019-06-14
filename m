Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B4DC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30132183E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fx1HBM5q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfFNQhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:37:50 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35745 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfFNQht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:37:49 -0400
Received: by mail-io1-f66.google.com with SMTP id m24so7195258ioo.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 09:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lBW3X80cYHPBDuFyvWPGa2N0D3uF5Rzt0SVdvMxvVQU=;
        b=fx1HBM5q+S+tn1keuQRlE5jVq4UXxnxC5DzfJEemBhG9OAUzFzxAH2U/w9GUedlZNJ
         5AUblfsjugPUVG8VFyYlYZyLATmxfxizYHmsLKElSfvXdIi5DcTPJJyr3hmoxcfouTAY
         Fcn6BJ9xFbKac+6ljMdI43afdmXtsWlCd3iU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lBW3X80cYHPBDuFyvWPGa2N0D3uF5Rzt0SVdvMxvVQU=;
        b=SXrhAhvx5zzXCzRrk6VkRh41VQ1OTozKCcSy8vc3rQh4EpYP2sBYGQZFnO2IMCVWj8
         SlcsSKQA8MaZev+BT7JK7SwK4zD0D4JxWZEyGSgHKTtFdNIF+NnZISZZMvrJIBEhDT/H
         0RZNI+sjRszJw6bdYQQCVEk8pKc+77B1ygwoAJd9R75s3Egs/iQxAzftJEk4PFAMEbOP
         weczurcK2OuCV12StiidLsUOU+L5uqzwVTXJXc2LsY9JZ+BtofLo85/V/gFw5QWymPhU
         owoy1U7O8GqpHdJz0aUT9n2vg6jm3qGHow5QHwuDrq+YrVxBrKNDKxD+aniIB4UbyQHD
         gsUw==
X-Gm-Message-State: APjAAAUftg7C+piWEW3rXJF89luAd3RWl6z44OGiyX1tkm7DfOdpLeBI
        Tp5UcKYXBVF0sxMIm8C85alyBEt3lcI/+MT+RQ/vPQ==
X-Google-Smtp-Source: APXvYqz6lmBngzCc7b9niyKSleSnk374SF2Zt4xvKneHiqH5q8z8QyFckhiSmFODCL3B39u7TxDOSmkAtmhInmwic3g=
X-Received: by 2002:a5d:9dc7:: with SMTP id 7mr14746058ioo.237.1560530268836;
 Fri, 14 Jun 2019 09:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190604152019.16100-1-enric.balletbo@collabora.com> <20190604152019.16100-11-enric.balletbo@collabora.com>
In-Reply-To: <20190604152019.16100-11-enric.balletbo@collabora.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Fri, 14 Jun 2019 09:37:37 -0700
Message-ID: <CAPUE2us+UD+V4yO7iN-TaYxKVFK1fwbCe7wHwNgMZ=0cdvhYug@mail.gmail.com>
Subject: Re: [PATCH 10/10] mfd: cros_ec: Add convenience struct to define
 autodetectable CrOS EC subdevices
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, kernel@collabora.com,
        dtor@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 8:20 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> The CrOS EC is gaining lots of subdevices that are autodetectable by
> sending the EC_FEATURE_GET_CMD, it takes fair amount of boiler plate
> code to add those devices. So, add a struct that can be used to quickly
> add new subdevices without having to duplicate code.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
>  drivers/mfd/cros_ec_dev.c | 132 +++++++++++++++++++++-----------------
>  1 file changed, 74 insertions(+), 58 deletions(-)
>
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 6fcfc8f17e03..49e4ab7ebb71 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -34,6 +34,18 @@ struct cros_feature_to_name {
>         const char *desc;
>  };
>
> +/**
> + * cros_feature_to_cells - CrOS feature id to mfd cells association.
> + * @id: The feature identifier.
> + * @mfd_cells: Pointer to the array of mfd cells that needs to be added.
> + * @num_cells: Number of mfd cells into the array.
> + */
> +struct cros_feature_to_cells {
> +       unsigned int id;
> +       const struct mfd_cell *mfd_cells;
> +       unsigned int num_cells;
> +};
> +
>  static const struct cros_feature_to_name cros_mcu_devices[] = {
>         {
>                 .id     = EC_FEATURE_FINGERPRINT,
> @@ -52,6 +64,48 @@ static const struct cros_feature_to_name cros_mcu_devices[] = {
>         },
>  };
>
> +static const struct mfd_cell cros_ec_cec_cells[] = {
> +       { .name = "cros-ec-cec", },
> +};
> +
> +static const struct mfd_cell cros_ec_rtc_cells[] = {
> +       { .name = "cros-ec-rtc", },
> +};
> +
> +static const struct mfd_cell cros_usbpd_charger_cells[] = {
> +       { .name = "cros-usbpd-charger", },
> +       { .name = "cros-usbpd-logger", },
> +};
> +
> +static const struct cros_feature_to_cells cros_subdevices[] = {
> +       {
> +               .id             = EC_FEATURE_CEC,
> +               .mfd_cells      = cros_ec_cec_cells,
> +               .num_cells      = ARRAY_SIZE(cros_ec_cec_cells),
> +       },
> +       {
> +               .id             = EC_FEATURE_RTC,
> +               .mfd_cells      = cros_ec_rtc_cells,
> +               .num_cells      = ARRAY_SIZE(cros_ec_rtc_cells),
> +       },
> +       {
> +               .id             = EC_FEATURE_USB_PD,
> +               .mfd_cells      = cros_usbpd_charger_cells,
> +               .num_cells      = ARRAY_SIZE(cros_usbpd_charger_cells),
> +       },
> +};
> +
> +static const struct mfd_cell cros_ec_platform_cells[] = {
> +       { .name = "cros-ec-chardev", },
> +       { .name = "cros-ec-debugfs", },
> +       { .name = "cros-ec-lightbar", },
> +       { .name = "cros-ec-sysfs", },
> +};
> +
> +static const struct mfd_cell cros_ec_vbc_cells[] = {
> +       { .name = "cros-ec-vbc", }
> +};
> +
>  static int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
>  {
>         struct cros_ec_command *msg;
> @@ -211,30 +265,6 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
>         kfree(msg);
>  }
>
> -static const struct mfd_cell cros_ec_cec_cells[] = {
> -       { .name = "cros-ec-cec" }
> -};
> -
> -static const struct mfd_cell cros_ec_rtc_cells[] = {
> -       { .name = "cros-ec-rtc" }
> -};
> -
> -static const struct mfd_cell cros_usbpd_charger_cells[] = {
> -       { .name = "cros-usbpd-charger" },
> -       { .name = "cros-usbpd-logger" },
> -};
> -
> -static const struct mfd_cell cros_ec_platform_cells[] = {
> -       { .name = "cros-ec-chardev" },
> -       { .name = "cros-ec-debugfs" },
> -       { .name = "cros-ec-lightbar" },
> -       { .name = "cros-ec-sysfs" },
> -};
> -
> -static const struct mfd_cell cros_ec_vbc_cells[] = {
> -       { .name = "cros-ec-vbc" }
> -};
> -
>  static int ec_device_probe(struct platform_device *pdev)
>  {
>         int retval = -ENOMEM;
> @@ -292,42 +322,28 @@ static int ec_device_probe(struct platform_device *pdev)
>         if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
>                 cros_ec_sensors_register(ec);
>
> -       /* Check whether this EC instance has CEC host command support */
> -       if (cros_ec_check_features(ec, EC_FEATURE_CEC)) {
> -               retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
> -                                        cros_ec_cec_cells,
> -                                        ARRAY_SIZE(cros_ec_cec_cells),
> -                                        NULL, 0, NULL);
> -               if (retval)
> -                       dev_err(ec->dev,
> -                               "failed to add cros-ec-cec device: %d\n",
> -                               retval);
> -       }
> -
> -       /* Check whether this EC instance has RTC host command support */
> -       if (cros_ec_check_features(ec, EC_FEATURE_RTC)) {
> -               retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
> -                                        cros_ec_rtc_cells,
> -                                        ARRAY_SIZE(cros_ec_rtc_cells),
> -                                        NULL, 0, NULL);
> -               if (retval)
> -                       dev_err(ec->dev,
> -                               "failed to add cros-ec-rtc device: %d\n",
> -                               retval);
> -       }
> -
> -       /* Check whether this EC instance has the PD charge manager */
> -       if (cros_ec_check_features(ec, EC_FEATURE_USB_PD)) {
> -               retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
> -                                        cros_usbpd_charger_cells,
> -                                        ARRAY_SIZE(cros_usbpd_charger_cells),
> -                                        NULL, 0, NULL);
> -               if (retval)
> -                       dev_err(ec->dev,
> -                               "failed to add cros-usbpd-charger device: %d\n",
> -                               retval);
> +       /*
> +        * The following subdevices can be detected by sending the
> +        * EC_FEATURE_GET_CMD Embedded Controller device.
> +        */
> +       for (i = 0; i < ARRAY_SIZE(cros_subdevices); i++) {
> +               if (cros_ec_check_features(ec, cros_subdevices[i].id)) {
> +                       retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
> +                                                cros_subdevices[i].mfd_cells,
> +                                                cros_subdevices[i].num_cells,
> +                                                NULL, 0, NULL);
Nit: you can replace mfd_add_devices() call  by mfd_add_hotplug_devices().
> +                       if (retval)
> +                               dev_err(ec->dev,
> +                                       "failed to add %s subdevice: %d\n",
> +                                       cros_subdevices[i].mfd_cells->name,
> +                                       retval);
> +               }
>         }
>
> +       /*
> +        * The following subdevices cannot be detected by sending the
> +        * EC_FEATURE_GET_CMD to the Embedded Controller device.
> +        */
>         retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
>                                  cros_ec_platform_cells,
>                                  ARRAY_SIZE(cros_ec_platform_cells),
> --
> 2.20.1
>
