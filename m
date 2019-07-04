Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79ADEC0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 21:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46DED21850
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 21:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gsi9+IiX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfGDVRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 17:17:35 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35925 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfGDVRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 17:17:35 -0400
Received: by mail-io1-f67.google.com with SMTP id h6so15125700ioh.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 14:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J5dPnDAPBmP/tM3oNFl3Flqbnxl9DAbnY6d65OzlCvo=;
        b=Gsi9+IiXPXqbpEbRKWtBGjqiJl9m0d/8ymXKcotU8ncCURfv40xEbz2dquZFw4or66
         eIf/FYjcWJ/OdLG8r0pYQ6ol+nJ8onV7P+isl3lNeKOoJK+koxGBAfhUodRaCD15DV72
         UDkaiZj6DeW8QLkJ9ELFAj1pDGsER3j6m7qCIQwUu/wBGznuarnpo8dX0UbaxEJ6XYfG
         nKVki5CAbgWkAHqs8Jow0JR+eeeQvoIuudtcafCdIFeEfK5P1FGVJADh2roLiMHnij8s
         iP+0csz198iwegCn04NbD+j+VcmFCDpDQ7Jauvcjc/rx+Q59DzgxwesL2oOL33n8CfXX
         aIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J5dPnDAPBmP/tM3oNFl3Flqbnxl9DAbnY6d65OzlCvo=;
        b=sH1aAZ7MTYaBSKu1b9l8LG9edHbXwJsxUoZeqUpSFGp09Tsn1yQv+tQ7W30HS9Lqd4
         BJu4/jJpvcGn85mYt3Kl3Uh1Kkur8FhHNxwNPl8JFCRyfQQ1DE42/DaN6/Yil1FD294Y
         vL/h+CReQcP6Sjm8IMjcn1CNq11ZKU42qRYLgr2qzmJGtIoF7cWNRnRDaQtH6527alSJ
         7/mZO+mPGPjbC7BjMAOhlF6/kHAMa5GldPoUGLuQgGVaBGYNGglAyWjr/ucfuAzqeSiN
         FGIEP4MgE0v2w8s8Btv3AWx9p7SWb6mv6IV9SfMzrNIZQ61a10r6OJ6g49zzvI9Rte6b
         6dyg==
X-Gm-Message-State: APjAAAWGdRWMnkNXuYQxfHjG32l3SNrf7QfoGR7+zBy9+wPLoqz2DcR3
        V0uORDHrzyOnFPuZQEm8q9kIsOYtImjojhsVU1M=
X-Google-Smtp-Source: APXvYqyXgphH1YInaQ3tW6Xa+Qf2b6hYKckv2K14fRTjEcmfsoUfC1Yzd0/dQ3hSXONkj3etn9g7KzbHckLCR0oBTqM=
X-Received: by 2002:a5e:8508:: with SMTP id i8mr444389ioj.108.1562275054349;
 Thu, 04 Jul 2019 14:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190704084617.3602-1-gregkh@linuxfoundation.org>
 <20190704084617.3602-2-gregkh@linuxfoundation.org> <20190704093200.GM13424@localhost>
 <20190704104311.GA16681@kroah.com> <20190704121143.GA5007@kroah.com>
In-Reply-To: <20190704121143.GA5007@kroah.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Thu, 4 Jul 2019 14:17:22 -0700
Message-ID: <CAKdAkRQ4W7wjYjZcBn4_s+PD26pv_8mrjUt-ne24GkimGEXoiA@mail.gmail.com>
Subject: Re: [PATCH 01/12 v2] Platform: add a dev_groups pointer to struct platform_driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Richard Gong <richard.gong@linux.intel.com>,
        Romain Izard <romain.izard.pro@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mans Rullgard <mans@mansr.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Jul 4, 2019 at 5:15 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Platform drivers like to add sysfs groups to their device, but right now
> they have to do it "by hand".  The driver core should handle this for
> them, but there is no way to get to the bus-default attribute groups as
> all platform devices are "special and unique" one-off drivers/devices.
>
> To combat this, add a dev_groups pointer to platform_driver which allows
> a platform driver to set up a list of default attributes that will be
> properly created and removed by the platform driver core when a probe()
> function is successful and removed right before the device is unbound.

Why is this limited to platform bus? Drivers for other buses also
often want to augment list of their attributes during probe(). I'd
move it to generic probe handling.

>
> Cc: Richard Gong <richard.gong@linux.intel.com>
> Cc: Romain Izard <romain.izard.pro@gmail.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Mans Rullgard <mans@mansr.com>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v2: addressed Johan's comments by reordering when we remove the files
>     from the device, and clean up on an error in a nicer way.  Ended up
>     making the patch smaller overall, always nice.
>
>  drivers/base/platform.c         | 16 +++++++++++++++-
>  include/linux/platform_device.h |  1 +
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 713903290385..74428a1e03f3 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -614,8 +614,20 @@ static int platform_drv_probe(struct device *_dev)
>
>         if (drv->probe) {
>                 ret = drv->probe(dev);
> -               if (ret)
> +               if (ret) {
> +                       dev_pm_domain_detach(_dev, true);
> +                       goto out;
> +               }
> +       }
> +       if (drv->dev_groups) {
> +               ret = device_add_groups(_dev, drv->dev_groups);
> +               if (ret) {
> +                       if (drv->remove)
> +                               drv->remove(dev);
>                         dev_pm_domain_detach(_dev, true);
> +                       return ret;
> +               }
> +               kobject_uevent(&_dev->kobj, KOBJ_CHANGE);

We already emit KOBJ_BIND when we finish binding device to a driver,
regardless of the bus. I know we still need to teach systemd to handle
it properly, but I think it is better than sprinkling KOBJ_CHANGE
around.

Thanks.

-- 
Dmitry
