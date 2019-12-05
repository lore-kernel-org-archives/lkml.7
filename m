Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33601C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 04:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053B22073B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 04:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="kCXSBxmL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbfLEENt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 23:13:49 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:42598 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbfLEENs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 23:13:48 -0500
Received: by mail-ua1-f67.google.com with SMTP id 31so721565uas.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 20:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JxvM8PAlC3uvNhbaAB15+7WItiOZ6wH5Zn3knWGZWuw=;
        b=kCXSBxmLW+TqYCxs2sT0nBzziphSgXA3YYH5gIvHSWYjFZSzA6I5Fdq1HyTqaMxMbF
         arIYwUzl/3ibdejY7UW4g9bRwp2MVIph3pzrL4XMMzfjea5E2jGEIpzuaus0EKmTOr5T
         am+tMyLWXrUfKXFoEDWTUq/2zcdLVp7gUAH8Z6B+haV4odWOEJfDdrK6IiBFd7rTxpAg
         7zLfoo9mMbVjFltpgcjSUNKXJ5nMP4ivfo5Zym9f8kwKBFVpFhsiFvQL2msPJY6vVqZm
         3HKX+3208wOLBBzS0LFE85jGtdh59F4FX4vkSpkVXOXMDSKkgSmSynMZbYOLrsAfutpv
         yMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JxvM8PAlC3uvNhbaAB15+7WItiOZ6wH5Zn3knWGZWuw=;
        b=S1t5O9RAA5+gVZsYCwSjykPwkzvLqpZrESLhOAT1+ePc4L0sgjYZ7DMep13kFLrkPt
         jKklO1SEbRLN5aPFfAZ9w+F80mi1kAFSpOJA7gHSR1zYb1NHNbudgTe8p54Ju68cNRKh
         bxP6Iir0Bvwt8Ahu7IuZ+ywvtIF9J6AzbuYkKUJEI9zCfJCEQ2gv4ixsqhh4jajLKuf8
         K3mTIxbqfRKusb3RCZCLPpIi38vXT8/JS78VafS6Ly+jlIiFwdScMF7Wv3yQyI6Voque
         Deu85LU+f+EMfPfYHVBek2Oq246V9LRiOWJzY5VVRS84rmLsbOhoYb3xJ8yY1HQr80AG
         BIFg==
X-Gm-Message-State: APjAAAXrHElyfmCM9gpBqEKzi9R4xMqv4dnQZAZAjt1qBEJiR4FSr1BT
        7xHfhvWSLJ4R4iYVghDoyDWFv2le1z38Nny6mLSy4g==
X-Google-Smtp-Source: APXvYqwYYa/cidXWFxshvoMEaPsB7oB/yql/7E9JhsWl1/fft6dQ6Lyu2lP6ClpVONrYxXDEmpT4o+3xxoQcO1Tt+k4=
X-Received: by 2002:ab0:30eb:: with SMTP id d11mr5654186uam.67.1575519227435;
 Wed, 04 Dec 2019 20:13:47 -0800 (PST)
MIME-Version: 1.0
References: <CAHLCerOD2wOJq7QNGBOcLvkMz4wvc1+6Hk2+ZD__NFged3tLcw@mail.gmail.com>
 <20191204215618.125826-1-wvw@google.com> <20191204215618.125826-2-wvw@google.com>
In-Reply-To: <20191204215618.125826-2-wvw@google.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Thu, 5 Dec 2019 09:43:36 +0530
Message-ID: <CAHLCerMQ_734AFe=QCg+qi3TOvYPMB95NPP_EEHNbuODBSEfog@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] thermal: fix and clean up tz and cdev registration
To:     Wei Wang <wvw@google.com>
Cc:     Wei Wang <wei.vince.wang@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

On Thu, Dec 5, 2019 at 3:26 AM Wei Wang <wvw@google.com> wrote:
>
> Make cooling device registration behavior consistent with

Consistent how? Please add details.

> thermal zone. This patch also cleans up a unnecessary
> nullptr check.
>
> Signed-off-by: Wei Wang <wvw@google.com>
> ---
>  drivers/thermal/thermal_core.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index d4481cc8958f..64fbb59c2f44 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -954,8 +954,16 @@ __thermal_cooling_device_register(struct device_node *np,
>         struct thermal_zone_device *pos = NULL;
>         int result;
>
> -       if (type && strlen(type) >= THERMAL_NAME_LENGTH)
> -               return ERR_PTR(-EINVAL);
> +       if (!type || !type[0]) {
> +           pr_err("Error: No cooling device type defined\n");
> +           return ERR_PTR(-EINVAL);
> +       }
> +
> +       if (strlen(type) >= THERMAL_NAME_LENGTH) {
> +           pr_err("Error: Cooling device name (%s) too long, "
> +                  "should be under %d chars\n", type, THERMAL_NAME_LENGTH);

Consider fitting into a single greppable string as "Error: Cooling
device name over %d chars: %s\n"

> +           return ERR_PTR(-EINVAL);
> +       }
>
>         if (!ops || !ops->get_max_state || !ops->get_cur_state ||
>             !ops->set_cur_state)
> @@ -972,7 +980,7 @@ __thermal_cooling_device_register(struct device_node *np,
>         }
>
>         cdev->id = result;
> -       strlcpy(cdev->type, type ? : "", sizeof(cdev->type));
> +       strlcpy(cdev->type, type, sizeof(cdev->type));
>         mutex_init(&cdev->lock);
>         INIT_LIST_HEAD(&cdev->thermal_instances);
>         cdev->np = np;
> @@ -1250,7 +1258,7 @@ thermal_zone_device_register(const char *type, int trips, int mask,
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       if (type && strlen(type) >= THERMAL_NAME_LENGTH) {
> +       if (strlen(type) >= THERMAL_NAME_LENGTH) {
>                 pr_err("Error: Thermal zone name (%s) too long, should be under %d chars\n",
>                        type, THERMAL_NAME_LENGTH);
>                 return ERR_PTR(-EINVAL);
> --
> 2.24.0.393.g34dc348eaf-goog
>
