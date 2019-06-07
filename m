Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CA0C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 10:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDEC208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 10:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zbnOXGvF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfFGKOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 06:14:50 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40176 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfFGKOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 06:14:49 -0400
Received: by mail-vs1-f68.google.com with SMTP id c24so818139vsp.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 03:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=exv6uaKs/w9K/r+eTG/OXTm7v4+gG8Cb0PW6M8MWkjE=;
        b=zbnOXGvFCxdKw4gEXDarNXkIo1ogtJ4OyMi+io8MTS+gt+f/ZFsoOxyzx1PwyXav02
         jtyXcElR1DCj/ODjpeJ7o3Swd1u06WwUcHKYDbEvevMBGmv7jSS6CwUxuyy6H+4F0rg0
         BLbMA3Gq44ERPyLBl8QNWyDboeqf7AmgIuLpatg0BB+YQXfzwwS8mmKQ4MzUL+tLQQ65
         CyzKAQ6x+XThvbDg7p//1P+s5XXTLX5fIsz3vy7b4g2aeZzycvXgz9Arm30bcU4EoE5Z
         k5L04Nw8AdGccpHjMhhlghE2YMcPxA2OiVWxJUWdkipapjX3/sU05o3OiSEdvRM1nmeH
         Z88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=exv6uaKs/w9K/r+eTG/OXTm7v4+gG8Cb0PW6M8MWkjE=;
        b=Nocci8Z+sFYfOEj/W0ZrRHfOFPf4wCAeSEVaG1W7pyjoNYbLGdKnNwlqwmRfbhpXv9
         YkNGknWYUyLscDUPB18ux8bzyc/nU3jLOyO0oMx1gvOHyu+WLzW+fmtPARfd+Av8Lk0J
         JpNRpzHsmg/ocAh1+Apne9beQVYsFvvOhLmouTw6jmfAgIItK/6JcMrjWvdLnXJABLy7
         M9NMJGT5IgjJKMDdC5awjlFkT7e/jd1ZVrnaOdZZovlg7PjVl4fzfKd3aaK0DFv0etN7
         olHc+joEUQl4dp0VATvFSOPk+PzDvAqAp6XHKWRSdncvAOoSGurqIKBRtC8pTyXW6hEL
         b+rw==
X-Gm-Message-State: APjAAAU4bgqsjG/E3xfSBSNqc8u6qd/w8JhwtF7Mo46JQy50uryD0DVt
        CagWaPqrb7WQL3+jM4QIA5ZZPlP7FheGDnizxYxKtA==
X-Google-Smtp-Source: APXvYqylZ2mMNJN0GZ+tkcBJFp0Pxsn2dMa8uZ/gDV/oYdZgfbZH5RPj7MB61Gch6nfJjl3vnl9u9pIocmgL15Up8nk=
X-Received: by 2002:a67:ebc5:: with SMTP id y5mr16672869vso.34.1559902488004;
 Fri, 07 Jun 2019 03:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190605142312.6072-1-thierry.reding@gmail.com>
In-Reply-To: <20190605142312.6072-1-thierry.reding@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 7 Jun 2019 12:14:11 +0200
Message-ID: <CAPDyKFrK-65d3PJYOd=7GGABsmXs9C+y4o8Y7=KW225OjhaE8Q@mail.gmail.com>
Subject: Re: [PATCH] driver: core: Allow subsystems to continue deferring probe
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Rob

On Wed, 5 Jun 2019 at 16:23, Thierry Reding <thierry.reding@gmail.com> wrote:
>
> From: Thierry Reding <treding@nvidia.com>
>
> Some subsystems, such as pinctrl, allow continuing to defer probe
> indefinitely. This is useful for devices that depend on resources
> provided by devices that are only probed after the init stage.
>
> One example of this can be seen on Tegra, where the DPAUX hardware
> contains pinmuxing controls for pins that it shares with an I2C
> controller. The I2C controller is typically used for communication
> with a monitor over HDMI (DDC). However, other instances of the I2C
> controller are used to access system critical components, such as a
> PMIC. The I2C controller driver will therefore usually be a builtin
> driver, whereas the DPAUX driver is part of the display driver that
> is loaded from a module to avoid bloating the kernel image with all
> of the DRM/KMS subsystem.
>
> In this particular case the pins used by this I2C/DDC controller
> become accessible very late in the boot process. However, since the
> controller is only used in conjunction with display, that's not an
> issue.
>
> Unfortunately the driver core currently outputs a warning message
> when a device fails to get the pinctrl before the end of the init
> stage. That can be confusing for the user because it may sound like
> an unwanted error occurred, whereas it's really an expected and
> harmless situation.
>
> In order to eliminate this warning, this patch allows callers of the
> driver_deferred_probe_check_state() helper to specify that they want
> to continue deferring probe, regardless of whether we're past the
> init stage or not. All of the callers of that function are updated
> for the new signature, but only the pinctrl subsystem passes a true
> value in the new persist parameter if appropriate.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Overall this looks good to me. I guess Greg prefers a separate
function, which sets a flag for the device to switch to this new
behavior. That seems like a reasonable change to make and avoids
changing calls to driver_deferred_probe_check_state().

Kind regards
Uffe

> ---
>  drivers/base/dd.c            | 17 ++++++++++++-----
>  drivers/base/power/domain.c  |  2 +-
>  drivers/iommu/of_iommu.c     |  2 +-
>  drivers/pinctrl/devicetree.c | 10 ++++++----
>  include/linux/device.h       |  2 +-
>  5 files changed, 21 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 0df9b4461766..25ffbadf4187 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -238,23 +238,30 @@ __setup("deferred_probe_timeout=", deferred_probe_timeout_setup);
>  /**
>   * driver_deferred_probe_check_state() - Check deferred probe state
>   * @dev: device to check
> + * @persist: Boolean flag indicating whether drivers should keep trying to
> + *   probe after built-in drivers have had a chance to probe. This is useful
> + *   for built-in drivers that rely on resources provided by modular drivers.
>   *
>   * Returns -ENODEV if init is done and all built-in drivers have had a chance
> - * to probe (i.e. initcalls are done), -ETIMEDOUT if deferred probe debug
> - * timeout has expired, or -EPROBE_DEFER if none of those conditions are met.
> + * to probe (i.e. initcalls are done) and unless persist is set, -ETIMEDOUT if
> + * deferred probe debug timeout has expired, or -EPROBE_DEFER if none of those
> + * conditions are met.
>   *
>   * Drivers or subsystems can opt-in to calling this function instead of directly
>   * returning -EPROBE_DEFER.
>   */
> -int driver_deferred_probe_check_state(struct device *dev)
> +int driver_deferred_probe_check_state(struct device *dev, bool persist)
>  {
>         if (initcalls_done) {
>                 if (!deferred_probe_timeout) {
>                         dev_WARN(dev, "deferred probe timeout, ignoring dependency");
>                         return -ETIMEDOUT;
>                 }
> -               dev_warn(dev, "ignoring dependency for device, assuming no driver");
> -               return -ENODEV;
> +
> +               if (!persist) {
> +                       dev_warn(dev, "ignoring dependency for device, assuming no driver");
> +                       return -ENODEV;
> +               }
>         }
>         return -EPROBE_DEFER;
>  }
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 33c30c1e6a30..effa5276a773 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2423,7 +2423,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>                 mutex_unlock(&gpd_list_lock);
>                 dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
>                         __func__, PTR_ERR(pd));
> -               return driver_deferred_probe_check_state(base_dev);
> +               return driver_deferred_probe_check_state(base_dev, false);
>         }
>
>         dev_dbg(dev, "adding to PM domain %s\n", pd->name);
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index f04a6df65eb8..70f3946b088a 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -117,7 +117,7 @@ static int of_iommu_xlate(struct device *dev,
>          * a proper probe-ordering dependency mechanism in future.
>          */
>         if (!ops)
> -               return driver_deferred_probe_check_state(dev);
> +               return driver_deferred_probe_check_state(dev, false);
>
>         return ops->of_xlate(dev, iommu_spec);
>  }
> diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
> index f7e354f85518..c808bf567d24 100644
> --- a/drivers/pinctrl/devicetree.c
> +++ b/drivers/pinctrl/devicetree.c
> @@ -111,13 +111,15 @@ static int dt_to_map_one_config(struct pinctrl *p,
>
>                 np_pctldev = of_get_next_parent(np_pctldev);
>                 if (!np_pctldev || of_node_is_root(np_pctldev)) {
> +                       bool persist = false;
> +
>                         of_node_put(np_pctldev);
> -                       ret = driver_deferred_probe_check_state(p->dev);
>                         /* keep deferring if modules are enabled unless we've timed out */
> -                       if (IS_ENABLED(CONFIG_MODULES) && !allow_default && ret == -ENODEV)
> -                               ret = -EPROBE_DEFER;
> +                       if (IS_ENABLED(CONFIG_MODULES) && !allow_default)
> +                               persist = true;
>
> -                       return ret;
> +                       return driver_deferred_probe_check_state(p->dev,
> +                                                                persist);
>                 }
>                 /* If we're creating a hog we can use the passed pctldev */
>                 if (hog_pctldev && (np_pctldev == p->dev->of_node)) {
> diff --git a/include/linux/device.h b/include/linux/device.h
> index e0649f6adf2e..ecf59dfcbfb7 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -340,7 +340,7 @@ struct device *driver_find_device(struct device_driver *drv,
>                                   int (*match)(struct device *dev, void *data));
>
>  void driver_deferred_probe_add(struct device *dev);
> -int driver_deferred_probe_check_state(struct device *dev);
> +int driver_deferred_probe_check_state(struct device *dev, bool persist);
>
>  /**
>   * struct subsys_interface - interfaces to device functions
> --
> 2.21.0
>
