Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A795C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0570220652
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfDZIlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:41:55 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36789 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfDZIlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:41:55 -0400
Received: by mail-ot1-f67.google.com with SMTP id y22so1999570oto.3;
        Fri, 26 Apr 2019 01:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fOOeIldUij2enaAoYk//mEkVemYKH25iSm5tQIuc9E4=;
        b=YX6N0eHKzxWFFpYjiVl7saZ9SYlMr4gJs4nuSTKrnKkvt8p+8x8wI7IW9COSBOa/nZ
         BSbHiXSxN4nutaiFK4AfW+JklSXD2gQFSPaLRn0TwawXUQd+4Pttb3w6ea7GQG7T+j/+
         fP3sBY8UsiblFhUzslLZiNd6cJ07sBgoLKOxqv1mFz32Y51c7nVdI8/1lDuI9EN3PU3E
         hm2YgndLsJk53Bdafvc2gDfS3cMgAFve1mC8jfb+1rcetphtYzT/rW2SQHCFGhBCV6sv
         CkzbghqDYoim2ucuU1YaURTS36o4CtlAWT2dl/AtAAslSBO7hMX73iqsrpVyyBMbZWf4
         hT1Q==
X-Gm-Message-State: APjAAAUxUeHnDclV0lwBC1J199dnMZKDRrqZFBlye5qmgw++hf6nLWrU
        UHDIdIAgzh7kITi2HHEcrlnn8viqQw0Vwc/A+lc=
X-Google-Smtp-Source: APXvYqx0PwBOXk6l6GyYnKzMr1/qDiRp/QNy5mEbTactNwJYBRtbjakRDsCzpu6lFDTC1cbFCSzSYeGHpDPVm0uALMs=
X-Received: by 2002:a9d:6e0a:: with SMTP id e10mr24638570otr.281.1556268113979;
 Fri, 26 Apr 2019 01:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <1555489717-28294-1-git-send-email-bianpan2016@163.com>
In-Reply-To: <1555489717-28294-1-git-send-email-bianpan2016@163.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Fri, 26 Apr 2019 10:41:43 +0200
Message-ID: <CA+7wUswSXNvLbYG4RxquH1rc9KmtCaE5N2iWe9K6SWG8MOnsdw@mail.gmail.com>
Subject: Re: mmc: core: fix possible use after free of host
To:     Pan Bian <bianpan2016@163.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Tony Lindgren <tony@atomide.com>, linux-mmc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 10:28 AM Pan Bian <bianpan2016@163.com> wrote:
>
> In the function mmc_alloc_host, the function put_device is called to
> release allocated resources when mmc_gpio_alloc fails. Finally, the
> function pointed by host->class_dev.class->dev_release (i.e.,
> mmc_host_classdev_release) is used to release resources including the
> host structure. However, after put_device, host is used and released
> again. Resulting in a use-after-free bug.
>
> Fixes: 1ed21719448("mmc: core: fix error path in mmc_host_alloc")

The original commit 1ed21719448 looks correct to me (see
mmc_host_classdev_release).

> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  drivers/mmc/core/host.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 3a4402a..f8ac567 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -429,8 +429,6 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>
>         if (mmc_gpio_alloc(host)) {
>                 put_device(&host->class_dev);
> -               ida_simple_remove(&mmc_host_ida, host->index);
> -               kfree(host);
>                 return NULL;
>         }
>
> --
> 2.7.4
>
>
