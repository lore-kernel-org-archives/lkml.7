Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D29C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F60C2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWRmnDUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgAGRyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 12:54:20 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46444 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbgAGRyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:54:20 -0500
Received: by mail-qt1-f196.google.com with SMTP id g1so430083qtr.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 09:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xxa54UV2Vg61xS7a6/4buHx3TcgbpOdUVruv7YtU9QQ=;
        b=JWRmnDUkHrcvnyJPveLJb0KZ1y9DSrLECIJnuPaUhGKzR+Ih7LyASR5S6WuqVwA9ri
         keEd9KuMtjZiy3pdt5RLdpbX9pSpOYPeAGZKl3W744JNm85GaqnV7DHwzZTpK/T9US3f
         sbTm2gZV3gWjC46TrRQejdGBuJlv2HIbuQFraP2zyZT8sm50OJZa5VV43yJocrCsc9Ud
         kcp4EFANCaJOVKkEURplzEB6oDq5mRvNExwXfACzZUWIQNo+XHSwEbVuQyoqvqwg6pUr
         l2N4ppJO9CkbtRIIAbI49xwF9IPBpXQYSrQlnu0WaXqFLHZzLChNQ/M3a3DYC6+Moi76
         jxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xxa54UV2Vg61xS7a6/4buHx3TcgbpOdUVruv7YtU9QQ=;
        b=qIa0ofg5LoofP32hgSyjz+ZVElmz8CjGi7+9+iAW6xJthHtsMUjv7UHnEv/TgJZPo4
         gSrTQsfbbrdqWtdxLJe8MJFeLB54lJK+oKlKtGV6l1SBAo3OrMysDPT/vD5kaf+tsCDS
         nQgezdpsqxfdkxeMOdi12ccC5CLwU1CTQMAtld6KdJWDA6mmeMaieLDWbJoZO8F8m7Lx
         vddziHX88Py/LM89xcqgFeCU6rC0/rw/SjRPEdQPvac1p+xSTigzZpDJUk4jsa5tJnmc
         +qFfdr8qXP5IVmOrchPCXKgKReFHmkkw+9E4XThy6WmlwjuOKwfH00bcjxfelZTWCWTY
         u60A==
X-Gm-Message-State: APjAAAWkI0oelwkpM8cB4bCuajlTuWEF/LxeAAJ9El8YICdyo6UmROzs
        xLgK0E0wPAKzQNP9MjchncbyEy5G/CxErixsdy8=
X-Google-Smtp-Source: APXvYqxLT9CUJX2eLgdAhMsGz9J/Tqc4X4qKoGPgHcPJbKnkvetwlRotHbV6cEKhj/U8uO4mypkisecWHXdw/A9hH3I=
X-Received: by 2002:ac8:1769:: with SMTP id u38mr155457qtk.160.1578419659040;
 Tue, 07 Jan 2020 09:54:19 -0800 (PST)
MIME-Version: 1.0
References: <20191210100645.12138-1-enric.balletbo@collabora.com>
In-Reply-To: <20191210100645.12138-1-enric.balletbo@collabora.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Tue, 7 Jan 2020 18:54:07 +0100
Message-ID: <CAFqH_533XXhJqpSURPVkSLCQpaA-owwx6S-8TECOsG35+5e2=w@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec: Match implementation with headers
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lee Jones <lee.jones@linaro.org>,
        Evan Green <evgreen@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter, Benson,

Missatge de Enric Balletbo i Serra <enric.balletbo@collabora.com> del
dia dt., 10 de des. 2019 a les 11:09:
>
> The 'cros_ec' core driver is the common interface for the cros_ec
> transport drivers to do the shared operations to register, unregister,
> suspend and resume. The interface is provided by including the header
> 'include/linux/platform_data/cros_ec_proto.h', however, instead of have
> the implementation of these functions in cros_ec_proto.c, it is in
> 'cros_ec.c', which is a different kernel module. Apart from being a bad
> practice, this can induce confusions allowing the users of the cros_ec
> protocol to call these functions.
>
> The register, unregister, suspend and resume functions *should* only be
> called by the different transport drivers (i2c, spi, lpc, etc.), so make
> this a bit less confusing by moving these functions from the public
> in-kernel space to a private include in platform/chrome, and then, the
> interface for cros_ec module and for the cros_ec_proto module is clean.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Can I get a review from you if you're fine with this change?

Thanks,
 Enric


> ---
>
>  drivers/platform/chrome/cros_ec.c           |  2 ++
>  drivers/platform/chrome/cros_ec.h           | 25 +++++++++++++++++++++
>  drivers/platform/chrome/cros_ec_i2c.c       |  2 ++
>  drivers/platform/chrome/cros_ec_ishtp.c     |  2 ++
>  drivers/platform/chrome/cros_ec_lpc.c       |  1 +
>  drivers/platform/chrome/cros_ec_rpmsg.c     |  2 ++
>  drivers/platform/chrome/cros_ec_spi.c       |  2 ++
>  include/linux/platform_data/cros_ec_proto.h | 16 -------------
>  8 files changed, 36 insertions(+), 16 deletions(-)
>  create mode 100644 drivers/platform/chrome/cros_ec.h
>
> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
> index 6d6ce86a1408..65c3207d2d90 100644
> --- a/drivers/platform/chrome/cros_ec.c
> +++ b/drivers/platform/chrome/cros_ec.c
> @@ -18,6 +18,8 @@
>  #include <linux/suspend.h>
>  #include <asm/unaligned.h>
>
> +#include "cros_ec.h"
> +
>  #define CROS_EC_DEV_EC_INDEX 0
>  #define CROS_EC_DEV_PD_INDEX 1
>
> diff --git a/drivers/platform/chrome/cros_ec.h b/drivers/platform/chrome/cros_ec.h
> new file mode 100644
> index 000000000000..dc80550f5eaa
> --- /dev/null
> +++ b/drivers/platform/chrome/cros_ec.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * ChromeOS Embedded Controller core interface.
> + *
> + * Copyright (C) 2012 Google, Inc
> + */
> +
> +#ifndef __CROS_EC_H
> +#define __CROS_EC_H
> +
> +/*
> + * The EC is unresponsive for a time after a reboot command.  Add a
> + * simple delay to make sure that the bus stays locked.
> + */
> +#define EC_REBOOT_DELAY_MS     50
> +
> +int cros_ec_register(struct cros_ec_device *ec_dev);
> +int cros_ec_unregister(struct cros_ec_device *ec_dev);
> +
> +int cros_ec_suspend(struct cros_ec_device *ec_dev);
> +int cros_ec_resume(struct cros_ec_device *ec_dev);
> +
> +bool cros_ec_handle_event(struct cros_ec_device *ec_dev);
> +
> +#endif /* __CROS_EC_H */
> diff --git a/drivers/platform/chrome/cros_ec_i2c.c b/drivers/platform/chrome/cros_ec_i2c.c
> index 9bd97bc8454b..6119eccd8a18 100644
> --- a/drivers/platform/chrome/cros_ec_i2c.c
> +++ b/drivers/platform/chrome/cros_ec_i2c.c
> @@ -14,6 +14,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>
> +#include "cros_ec.h"
> +
>  /**
>   * Request format for protocol v3
>   * byte 0      0xda (EC_COMMAND_PROTOCOL_3)
> diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/chrome/cros_ec_ishtp.c
> index e5996821d08b..e1fdb491a9a7 100644
> --- a/drivers/platform/chrome/cros_ec_ishtp.c
> +++ b/drivers/platform/chrome/cros_ec_ishtp.c
> @@ -14,6 +14,8 @@
>  #include <linux/platform_data/cros_ec_proto.h>
>  #include <linux/intel-ish-client-if.h>
>
> +#include "cros_ec.h"
> +
>  /*
>   * ISH TX/RX ring buffer pool size
>   *
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> index dccf479c6625..3e8ddd84bc41 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -23,6 +23,7 @@
>  #include <linux/printk.h>
>  #include <linux/suspend.h>
>
> +#include "cros_ec.h"
>  #include "cros_ec_lpc_mec.h"
>
>  #define DRV_NAME "cros_ec_lpcs"
> diff --git a/drivers/platform/chrome/cros_ec_rpmsg.c b/drivers/platform/chrome/cros_ec_rpmsg.c
> index bd068afe43b5..dbc3f5523b83 100644
> --- a/drivers/platform/chrome/cros_ec_rpmsg.c
> +++ b/drivers/platform/chrome/cros_ec_rpmsg.c
> @@ -13,6 +13,8 @@
>  #include <linux/rpmsg.h>
>  #include <linux/slab.h>
>
> +#include "cros_ec.h"
> +
>  #define EC_MSG_TIMEOUT_MS      200
>  #define HOST_COMMAND_MARK      1
>  #define HOST_EVENT_MARK                2
> diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
> index a831bd5a5b2f..46786d2d679a 100644
> --- a/drivers/platform/chrome/cros_ec_spi.c
> +++ b/drivers/platform/chrome/cros_ec_spi.c
> @@ -14,6 +14,8 @@
>  #include <linux/spi/spi.h>
>  #include <uapi/linux/sched/types.h>
>
> +#include "cros_ec.h"
> +
>  /* The header byte, which follows the preamble */
>  #define EC_MSG_HEADER                  0xec
>
> diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> index 119b9951c055..f490e208540a 100644
> --- a/include/linux/platform_data/cros_ec_proto.h
> +++ b/include/linux/platform_data/cros_ec_proto.h
> @@ -21,12 +21,6 @@
>  #define CROS_EC_DEV_SCP_NAME   "cros_scp"
>  #define CROS_EC_DEV_TP_NAME    "cros_tp"
>
> -/*
> - * The EC is unresponsive for a time after a reboot command.  Add a
> - * simple delay to make sure that the bus stays locked.
> - */
> -#define EC_REBOOT_DELAY_MS             50
> -
>  /*
>   * Max bus-specific overhead incurred by request/responses.
>   * I2C requires 1 additional byte for requests.
> @@ -206,10 +200,6 @@ struct cros_ec_dev {
>
>  #define to_cros_ec_dev(dev)  container_of(dev, struct cros_ec_dev, class_dev)
>
> -int cros_ec_suspend(struct cros_ec_device *ec_dev);
> -
> -int cros_ec_resume(struct cros_ec_device *ec_dev);
> -
>  int cros_ec_prepare_tx(struct cros_ec_device *ec_dev,
>                        struct cros_ec_command *msg);
>
> @@ -222,10 +212,6 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
>  int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
>                             struct cros_ec_command *msg);
>
> -int cros_ec_register(struct cros_ec_device *ec_dev);
> -
> -int cros_ec_unregister(struct cros_ec_device *ec_dev);
> -
>  int cros_ec_query_all(struct cros_ec_device *ec_dev);
>
>  int cros_ec_get_next_event(struct cros_ec_device *ec_dev,
> @@ -238,8 +224,6 @@ int cros_ec_check_features(struct cros_ec_dev *ec, int feature);
>
>  int cros_ec_get_sensor_count(struct cros_ec_dev *ec);
>
> -bool cros_ec_handle_event(struct cros_ec_device *ec_dev);
> -
>  /**
>   * cros_ec_get_time_ns() - Return time in ns.
>   *
> --
> 2.20.1
>
