Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC99FC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA0F2133F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H+qGvGlE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfJGIDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 04:03:39 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41270 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfJGIDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 04:03:38 -0400
Received: by mail-oi1-f195.google.com with SMTP id w65so10865371oiw.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 01:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u8VJVRDT3OUyLjgNXAgYtCNyTR8O6tuL+6GMwd0XRpk=;
        b=H+qGvGlEcaQ+IHSaoAsaQZbUszEa1otR3hOTR7ftfNmWzFYDGduMcgUMPUKsWZNSJ5
         3Fnw5ij962RVc8pyahylWZ9SAvgpp7/pQuGAsZsWMulWcs9Z0iRt6R0jCTIpGrYacYS+
         LBMz19RIy6gjh8l19t0LTCuKqpwBqNKE0V7A2HvDxQab5KrXAkpfQJaen8xzK0ay1/BJ
         6kw/qthdKxrLxBxe5aCb48ENorlxg5+SyxB5qsbgLj4epEyjN4nm8xlGXTzHoocjlWpo
         1glbHjIG2bdxjI0m1DhrDA5lqjwddhALaZQnu0sF3CVeeMu6bNm52YTyWbSIKRObyFPd
         sseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u8VJVRDT3OUyLjgNXAgYtCNyTR8O6tuL+6GMwd0XRpk=;
        b=tbjWB3HdBzIbAKxFUiaAkXedWylzv7mxx0C0Zt762rUNu7owMz7m9J03BtpsMY20cG
         OisBLZaodYr0OnzMrdTcyO3Ymor98i5ENMWkJklXMi7aQdju8Ts8YjNguEi5Dlhipssp
         440P33yZZZ3vWVtj2lzszG0szqeM5JOeQZpuTsJ9cww9mnSHSFAn0oO2ODReXlbi5rYH
         0mRgJK5u/l7uy1hF8nACHQeEjhqVd87tyxQTLMh1CiL8mO2D3ruzYja9ThCYQ1om+A0N
         XjuWlrrnbfqa0RrH5W9C88/nvPWLX1x069j3PluBG6EXfUHI5O9qVvVNBcuyd6yMRWqh
         GTVQ==
X-Gm-Message-State: APjAAAUvU025HB2cYnk5SVawLxi5rIHGP6QqQkkg16Q1Qu5ZR3NYcnwX
        KlAMHoYak0iu9Z+dWlGsBHlE5QT4eltZ18+kcUBfXw==
X-Google-Smtp-Source: APXvYqxrk4oSwQNbx4cUVbslaxhQDxOfVuNNMC5RyNTNeaNvN1uU067TDZ4r53WKZPoLTRzbKIOJfVloYi9/iWye3FI=
X-Received: by 2002:aca:1308:: with SMTP id e8mr17564514oii.145.1570435417434;
 Mon, 07 Oct 2019 01:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20191007071610.65714-1-cychiang@chromium.org>
In-Reply-To: <20191007071610.65714-1-cychiang@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Mon, 7 Oct 2019 16:03:26 +0800
Message-ID: <CA+Px+wWkr1xmSpgEkSaGS7UZu8TKUYvSnbjimBRH29=kDtcHKA@mail.gmail.com>
Subject: Re: [PATCH] firmware: vpd: Add an interface to read VPD value
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Hung-Te Lin <hungte@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Brown <broonie@kernel.org>, dgreid@chromium.org,
        Tzung-Bi Shih <tzungbi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 3:16 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
>
> Add an interface for other driver to query VPD value.
> This will be used for ASoC machine driver to query calibration
> data stored in VPD for smart amplifier speaker resistor
> calibration.
>
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
>  drivers/firmware/google/vpd.c              | 16 ++++++++++++++++
>  include/linux/firmware/google/google_vpd.h | 18 ++++++++++++++++++
>  2 files changed, 34 insertions(+)
>  create mode 100644 include/linux/firmware/google/google_vpd.h
>
> diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/google/vpd.c
> index db0812263d46..71e9d2da63be 100644
> --- a/drivers/firmware/google/vpd.c
> +++ b/drivers/firmware/google/vpd.c
> @@ -65,6 +65,22 @@ static ssize_t vpd_attrib_read(struct file *filp, struct kobject *kobp,
>                                        info->bin_attr.size);
>  }
>
> +int vpd_attribute_read_value(bool ro, const char *key,
> +                            char **value, u32 value_len)
> +{
> +       struct vpd_attrib_info *info;
> +       struct vpd_section *sec = ro ? &ro_vpd : &rw_vpd;
> +
> +       list_for_each_entry(info, &sec->attribs, list) {
> +               if (strcmp(info->key, key) == 0) {
> +                       *value = kstrndup(info->value, value_len, GFP_KERNEL);

Value is not necessary a NULL-terminated string.
kmalloc(info->bin_attr.size) and memcpy(...) would make the most
sense.

The value_len parameter makes less sense.  It seems the caller knows
the length of the value in advance.
Suggest to change the value_len to report the length of value.  I.e.
*value_len = info->bin_attr.size;

Also please check the return value for memory allocation-like
functions (e.g. kstrndup, kmalloc) so that *value won't be NULL but
the function returned 0.

> +                       return 0;
> +               }
> +       }
> +       return -EINVAL;
> +}
> +EXPORT_SYMBOL(vpd_attribute_read_value);
> +
>  /*
>   * vpd_section_check_key_name()
>   *
> diff --git a/include/linux/firmware/google/google_vpd.h b/include/linux/firmware/google/google_vpd.h
> new file mode 100644
> index 000000000000..6f1160f28af8
> --- /dev/null
> +++ b/include/linux/firmware/google/google_vpd.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Google VPD interface.
> + *
> + * Copyright 2019 Google Inc.
> + */
> +
> +/* Interface for reading VPD value on Chrome platform. */
> +
> +#ifndef __GOOGLE_VPD_H
> +#define __GOOGLE_VPD_H
> +
> +#include <linux/types.h>
> +
> +int vpd_attribute_read_value(bool ro, const char *key,
> +                            char **value, u32 value_len);
> +
> +#endif  /* __GOOGLE_VPD_H */
> --
> 2.23.0.581.g78d2f28ef7-goog
>
