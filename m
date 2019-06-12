Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12725C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDEA4208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rulL1S3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437999AbfFLKWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 06:22:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37449 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437986AbfFLKV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:21:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id 22so5934654wmg.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 03:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AFoHMSEj9tVrWcEUPH5FAzB19SGdLo79LhrgprT3fB0=;
        b=rulL1S3rudmYvANWuk91UMefuzuee5m+1kiBg/S4z4W6rohQIQJvVef0Ga8/kNwqJP
         kQbz+GWJXFvKOlUq8wHsIOsVwPqBI6yU4JVUxy8FcXHzelpiTu0d9AnpLnqKnk6brVeP
         0fI7UN+JLLjazssXG03F2xYy4RGi8lRQZddXYhMMtpv3pOhX4qKtG2S8uhFGlc+GLnT6
         pvwprNWkUYEuVh6VpDMyqPFBM3B4d4BM96DCh7LGjxch5bvcQL2oQCAMKcd+OcUFDS/9
         lerJBd9pWHPVwxh6CPJHbt3h+bxG3bzij0XlNY2uclYVY1/q+J8iyOw8VXcY4XYFT3kO
         9meA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AFoHMSEj9tVrWcEUPH5FAzB19SGdLo79LhrgprT3fB0=;
        b=EzH/a8hrao4Q7UPNfe+ISRCwk7tIji7/iV67DJzQy3k+lWUu7rxjn7bkO4CfR3qqp0
         wXfxqj5uO17n9RXxCOlLPIKa0sAQqhr78r2/JctDofb1neme/INAHZOtzN5A/fpNZaNP
         62/4UZbS3glN3LdXEZ9LSPeZ+NFAJiZD8huG0fXrMJ9P//7F2DqNbvYjzNcqwTai2cpp
         NNA9tcVIzn9oXQ3FxvQzbuAheMsGUqg3dwIh5eB1LfGkfWVG+IJpk5hBIajmUIljHHUS
         3vHicIEfZlS1jxF0VsDH1pHeZIlPlQmwVFAAwUl3suqcz8306yJ2Gx5bqAp3UOrUKqQj
         xu6Q==
X-Gm-Message-State: APjAAAUgDCpTl0f57UwnaYPQDY4EqN50ycdoBiqUfDSiip4n6R6Q7fKU
        71xalL6jnMY50ytj1mvHfIqrPJxP7K7EfJIaiGWR3w==
X-Google-Smtp-Source: APXvYqz6AjVcZoYHA6CdaGJpxS+2mtUzECSit9/BS1GTOdIOLeI2k4WuyT2w1sPbw2Vab/weDhNLTVi2+YFEotGwynw=
X-Received: by 2002:a1c:ed07:: with SMTP id l7mr19968400wmh.148.1560334917880;
 Wed, 12 Jun 2019 03:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190612100536.22368-1-yuehaibing@huawei.com>
In-Reply-To: <20190612100536.22368-1-yuehaibing@huawei.com>
From:   Maxime Jourdan <mjourdan@baylibre.com>
Date:   Wed, 12 Jun 2019 12:21:47 +0200
Message-ID: <CAMO6nayiXiOkHSxgZU+oyPdSo5ugcV6XaCdy7P1Riutv+c7XRQ@mail.gmail.com>
Subject: Re: [PATCH -next] media: meson: vdec: Add missing kthread.h
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        gregkh@linuxfoundation.org, Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devel@driverdev.osuosl.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-media@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 12:05 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fix building error:
>
> drivers/staging/media/meson/vdec/vdec.c: In function vdec_recycle_thread:
> drivers/staging/media/meson/vdec/vdec.c:59:10: error: implicit declaration
>  of function kthread_should_stop;
>  did you mean thread_saved_sp? [-Werror=implicit-function-declaration]
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 3e7f51bd9607 ("media: meson: add v4l2 m2m video decoder driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/staging/media/meson/vdec/vdec.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/media/meson/vdec/vdec.c
> index 4e4f9d6..0a1a04f 100644
> --- a/drivers/staging/media/meson/vdec/vdec.c
> +++ b/drivers/staging/media/meson/vdec/vdec.c
> @@ -12,6 +12,7 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/slab.h>
>  #include <linux/interrupt.h>
> +#include <linux/kthread.h>
>  #include <media/v4l2-ioctl.h>
>  #include <media/v4l2-event.h>
>  #include <media/v4l2-ctrls.h>
> --
> 2.7.4
>
>

Thanks for the patch, sorry that this one slipped through.

Acked-by: Maxime Jourdan <mjourdan@baylibre.com>
