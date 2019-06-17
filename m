Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770A7C31E59
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FDBB20861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gzjXdC3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfFQMlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:41:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44133 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfFQMlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:41:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16so9760658wrl.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 05:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WOOxpm7ozZave7X/hBH3gYwbNXHHvhxtj5pINcFfpmM=;
        b=gzjXdC3SyBjROxKdZINhmdO+YOBW7w31ZU3bhz19+zQh6bKN9So0wH9jBV6ITP3QUn
         ++GtUH3piNFnSVVsYe0do04ZpfDbpYv26fFZeVjgXw4FxfZMuesrcH65TQFpGFp8T2Mp
         WjsMvhOjYwEJgwznc9B2blDBrgh5Im/R0KZukg1QIvyOQ6bKIAIomK2vt2EHNT694ecI
         Ki1oy53r5lVNwvL9uYiGc8r3yraGmX7LD06ibLUeaFxuzIjDYoAPXMzGUibsgvm4o1gH
         I+5Fztidy7Qtl2+7beYTnPuFR0ckvioG+IkKs0zm660+0nvPLoG7vkjcvr9q3kD4cMfL
         tFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WOOxpm7ozZave7X/hBH3gYwbNXHHvhxtj5pINcFfpmM=;
        b=ldtQOVIEO1lIC4Z0VsYwxQ/UHc7L0p1jWCcJSV231I6n7/hq1oKyQZcmnWF0FgE8cU
         hrzJ1A6J9OH+50U77jkaEvnRffHWVLQsTAWt0bBP1w/shuLntBjTYp5eKII4jL+W5isS
         bE2m/wcUiM3yBbbN0tXd4oORJ1l6PtdfuS9ujbmeqX3dZwAiG7+ZSpGN6lj3Z8A3sEZC
         N2AkaHVUuJvg+Qip/u3OttBFlGTdGsL/MbtNwAthljdK3eBX0kyOtikXw5HKJ125KYT8
         bYXJLbON3AAotAEiCHGt34TWXDpnmRgus3gIIAqqf+kwaGSqqlJtJsre0YuMrII9SzvY
         5w4g==
X-Gm-Message-State: APjAAAXTnh5kB/6S9XCYOkeNNntm14/WqXC+QrdG59iTI4vrxSmpIwFD
        AvkfEqBBvG8KV5bIxgagZVg97fH6MmDaCa11vYD6SQ==
X-Google-Smtp-Source: APXvYqzpuPnI+gsxO4zp+HzWS3tA15wt/2tfOqTOkMZ8lgfnUBjUyQc5aSZTXucpdJWE7KyO86xEbW+pmWZ5wCwQiQ0=
X-Received: by 2002:a5d:4ec1:: with SMTP id s1mr23708512wrv.19.1560775262236;
 Mon, 17 Jun 2019 05:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190617111718.2277220-1-arnd@arndb.de>
In-Reply-To: <20190617111718.2277220-1-arnd@arndb.de>
From:   Maxime Jourdan <mjourdan@baylibre.com>
Date:   Mon, 17 Jun 2019 14:40:51 +0200
Message-ID: <CAMO6nazK5uo3deCqKEAGqB4TfEp9W1u2bkWaMNg_DMtSw=E2YQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] media: meson: include linux/kthread.h
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arnd,
On Mon, Jun 17, 2019 at 1:17 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Without this header, we get a compilation error in some configurations:
>
> drivers/staging/media/meson/vdec/vdec.c: In function 'vdec_recycle_thread':
> drivers/staging/media/meson/vdec/vdec.c:59:10: error: implicit declaration of function 'kthread_should_stop' [-Werror=implicit-function-declaration]
>
> Fixes: 3e7f51bd9607 ("media: meson: add v4l2 m2m video decoder driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/staging/media/meson/vdec/vdec.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/media/meson/vdec/vdec.c
> index 0a1a04fd5d13..eb335a0f2bdd 100644
> --- a/drivers/staging/media/meson/vdec/vdec.c
> +++ b/drivers/staging/media/meson/vdec/vdec.c
> @@ -8,6 +8,7 @@
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> +#include <linux/kthread.h>
>  #include <linux/platform_device.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/slab.h>
> --
> 2.20.0
>

Thanks for the patch, a similar one has already been sent by Yue
Haibing and is sitting in media/master at the moment [0]. My apologies
for this oversight.

Regards,
Maxime

[0] https://git.linuxtv.org/media_tree.git/commit/?id=3510c68d32bf3a188c077b5fb87339379f4e6b43
