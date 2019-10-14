Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA0EC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99328217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YGISSYCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732810AbfJNOdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:33:04 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38346 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731121AbfJNOdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:33:03 -0400
Received: by mail-qt1-f194.google.com with SMTP id j31so25713842qta.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 07:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lhb0CAAW9Vb27xAG0hrpBqjko/4KesG+1qmqJasPplE=;
        b=YGISSYCxqNj4LZ0pTXTQb4Ol+zJLX0xDR1k0kusL+ftupVzKo5XLvuxExaTUoF7Dwu
         PfuE3ZcyyfuGB358iQ60d5DbbcP85UlXpmioxYbkGdtuiUvIPsk1+H6nmrBrCQ5g5sgb
         I1YNvkPhaWKFsZydhbwCejH632z5U4okTdMJSlYzlcYcEDLBHfPqcdEs7cBQ2vk9hS1o
         WrkGfHn140jkchZQ9k8MzKWZRoWRea5CM/HKlZ1f3EzhEfRx4Kwa4YxOQPhV41XKUTCV
         /RzuHPig+xFjE+CEcxOG0Jkyb3NR/yK4L3AODwxRItsoDRBXRMO2o+Dzx4FCUdQWinra
         gLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lhb0CAAW9Vb27xAG0hrpBqjko/4KesG+1qmqJasPplE=;
        b=ZMmBc/a+UvzLuYbvpToc0/+kAoRytU+pvuZVee03o215IjkNQWXOpYJX0GGREyRm/Z
         VL6oWBQNNWNnWjqmWKHE+zfTYgcyuFRaQMImNSvGRkZSZSv5h6ZDkSeZ1n/PQGO6Su2/
         XjJeMa7sRwDwEoa4AvFqWgCkIbWUHG6t4lOstuqytLXJsXpiRDB7exwSJev2og5Vo7BN
         ijoXnGOhqV9O2LnMtaVBwaBQSY4puodI+Mz2ff1nfjt9MAA23rl3bKtJmTN6xo9bV1PB
         Ke4+w4vHSB296SDgpaA3xpAagPc/tT5nRPwum2w1bq4W5KnDmgMxDjff6kKFZOQbvvoY
         5zPA==
X-Gm-Message-State: APjAAAUzD0NV0JTw2ZcWfHOORxbssZA3ZvO8scH1MCxrgkyU+Ifpa9ks
        HcVykF/Izvn3RDHAMV8bW+R2mw+EDEIzc9jMz3f6Ml975yU=
X-Google-Smtp-Source: APXvYqzqApQH0vYoqWCT/6nEdWxRtz9wDSy1LZGDtLWmC+LY2R2iGNq+ZZTWMXAN+eZZctaIQ1Ow8N95LIXXdI2Af8w=
X-Received: by 2002:a05:6214:841:: with SMTP id dg1mr30723344qvb.55.1571063582732;
 Mon, 14 Oct 2019 07:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191012065255.23249-1-daniel.lezcano@linaro.org> <20191012065255.23249-5-daniel.lezcano@linaro.org>
In-Reply-To: <20191012065255.23249-5-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 14 Oct 2019 20:02:51 +0530
Message-ID: <CAP245DWwMcCHbeh0t7MizmxK4fr9jZvdVeVYYRLGJcCcA=QFcg@mail.gmail.com>
Subject: Re: [PATCH 05/11] thermal: Move set_trips function to the internal header
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
> The function is not used in other place than the thermal directory. It

Grammar nit: is not used any place other than the thermal directory

> does not make sense to export its definition in the global header as
> there is no use of it.
>
> Move its the definition in the internal header and allow better
> self-encapsulation.

Grammar nit: Move the definition to the internal header

If you respin please fix the same for other patches in the series.




>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/thermal_core.h | 2 ++
>  include/linux/thermal.h        | 3 ---
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index 6f6e0dcba4f2..301f5603def1 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -72,6 +72,8 @@ struct thermal_trip {
>         enum thermal_trip_type type;
>  };
>
> +void thermal_zone_set_trips(struct thermal_zone_device *tz);
> +
>  /*
>   * This structure is used to describe the behavior of
>   * a certain cooling device on a certain trip point
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 88e1faa3d72c..761d77571533 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -398,7 +398,6 @@ int thermal_zone_unbind_cooling_device(struct thermal_zone_device *, int,
>                                        struct thermal_cooling_device *);
>  void thermal_zone_device_update(struct thermal_zone_device *,
>                                 enum thermal_notify_event);
> -void thermal_zone_set_trips(struct thermal_zone_device *);
>
>  struct thermal_cooling_device *thermal_cooling_device_register(const char *,
>                 void *, const struct thermal_cooling_device_ops *);
> @@ -444,8 +443,6 @@ static inline int thermal_zone_unbind_cooling_device(
>  static inline void thermal_zone_device_update(struct thermal_zone_device *tz,
>                                               enum thermal_notify_event event)
>  { }
> -static inline void thermal_zone_set_trips(struct thermal_zone_device *tz)
> -{ }
>  static inline struct thermal_cooling_device *
>  thermal_cooling_device_register(char *type, void *devdata,
>         const struct thermal_cooling_device_ops *ops)
> --
> 2.17.1
>
