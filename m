Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD76C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 20:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5AB7214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 20:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MbH1S6za"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389889AbfDRUfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 16:35:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32908 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbfDRUfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 16:35:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id h5so1625975pfo.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 13:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BbxZ1Wm3vrcS9rLeR0qxSNVZn0SFBfcNjWi2YkD4UlA=;
        b=MbH1S6za1ShbicEWvBz4SvdQrGZEtT2+ggWSg/UIQoXd/22DBvpUlLbUamWzGMGZU6
         Xjy6X2VgGHPCwwlJJ+EFTgj9GA40yTdwhK6uQu3wplSyCVb0dODkl2COmAod+1kn5SZS
         p/PpQWsHKmzWdBJ2ZslhHdNHypKgHSmfeAoy+0I834YIQp/shyH/Nl8dr1ki2RSY8Xru
         uyUhs9QQWCOL24hZZmOpYfBaf+uTUcEMxUu0syEHqk4R2wT4bM45VpFLC6wHvWqO1xfA
         lBOzlXU/V0l7DKbVEVopqf/4knCZz2FzM53ZoXkZgSghf2N6ByBfVLgeG1HZGROSw1Nb
         YYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BbxZ1Wm3vrcS9rLeR0qxSNVZn0SFBfcNjWi2YkD4UlA=;
        b=lgrvq0fbihu0gdskmYKx+72N+MP/UfZKYoGBZN3WnktcYynwb4HoKa31inGV+/orfk
         s7+hACBxWeXul1EWiY95DDB6WNWT9j/qRyg0YqKwsY5JrTMG9bQCZRrtyy062Nas3N8b
         zgjg0SGTafZSeJj13rJwJrOWC7LBnjea6KuiqRfQxNPvzhB/7Fc3vvwsdG08aJP3bF7n
         AHuni84PzsvU0LRZj79E5pQlSCmk3gIbmcOcI3ccmpFaANkQvNFMVB+RHigcS4YnAREz
         3A2A2eQKoWHuc6jqqr73u4J6BwRmbm4dobhHIuoVRMMrphiyD5TbkomYzhCDRpc5RwQs
         2Dfw==
X-Gm-Message-State: APjAAAV45dGhx99pGg2T8ZVs8p9mdR1y3GwU9509EHjtN3/RAPcYZM+u
        grR1cbrqxWD1ArAM4n8Xqov7U5IeaMkFKCid9g6AYQ==
X-Google-Smtp-Source: APXvYqwJu5yh75P2ZTkxNCKTm19mCqS0f4dpN9Cz+/MNhiMAUzkgt2ELcK9WvoF55QgihDmewEjQ5sRxNZQ3THh5GlU=
X-Received: by 2002:a63:e850:: with SMTP id a16mr86906748pgk.195.1555619742538;
 Thu, 18 Apr 2019 13:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <1555617500-10862-1-git-send-email-linux@roeck-us.net> <1555617500-10862-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1555617500-10862-3-git-send-email-linux@roeck-us.net>
From:   Patrick Venture <venture@google.com>
Date:   Thu, 18 Apr 2019 13:35:31 -0700
Message-ID: <CAO=notxzQUyRJ4L7w6o4Cdbwp-Sg4FXyMDgJUN-7YPm9JgiQuw@mail.gmail.com>
Subject: Re: [PATCH 2/6] hwmon: (aspeed-pwm-tacho) Use devm_thermal_of_cooling_device_register
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-pm@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mykola Kostenok <c_mykolak@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 12:58 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Use devm_thermal_of_cooling_device_register() to register the cooling
> device. As a side effect, this fixes a driver bug:
> thermal_cooling_device_unregister() was not called on removal.
>
> Fixes: f198907d2ff6d ("hwmon: (aspeed-pwm-tacho) cooling device support.")
> Cc: Mykola Kostenok <c_mykolak@mellanox.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Patrick Venture <venture@google.com>

> ---
>  drivers/hwmon/aspeed-pwm-tacho.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
> index c4dd6301e7c8..0daf0b32aa4a 100644
> --- a/drivers/hwmon/aspeed-pwm-tacho.c
> +++ b/drivers/hwmon/aspeed-pwm-tacho.c
> @@ -830,10 +830,8 @@ static int aspeed_create_pwm_cooling(struct device *dev,
>         }
>         snprintf(cdev->name, MAX_CDEV_NAME_LEN, "%pOFn%d", child, pwm_port);
>
> -       cdev->tcdev = thermal_of_cooling_device_register(child,
> -                                                        cdev->name,
> -                                                        cdev,
> -                                                        &aspeed_pwm_cool_ops);
> +       cdev->tcdev = devm_thermal_of_cooling_device_register(dev, child,
> +                                       cdev->name, cdev, &aspeed_pwm_cool_ops);
>         if (IS_ERR(cdev->tcdev))
>                 return PTR_ERR(cdev->tcdev);
>
> --
> 2.7.4
>
