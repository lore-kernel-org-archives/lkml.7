Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69909C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442B420715
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KbvsZSYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfKNMyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 07:54:05 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46076 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfKNMyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 07:54:04 -0500
Received: by mail-vs1-f66.google.com with SMTP id n9so3748878vsa.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 04:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FD4rWZvRtjq6yENRSiMKVtNcvX/RF09g3K3VFm1ugEY=;
        b=KbvsZSYDIxGePu0L2CAqFoQQVRCU4t6p5EltIbJBOhwSNAhoQsyCYOzW0153Cy2o5c
         BQIKv5nM+jFnLIpIexEEpsh5XGW34sIZYZfmpsIwbLJgpGl1+3x01FltLTF4Hg6l/5Yu
         eFVzTOXa+ib5Jn/X/SxZ7s5Lw3u1PsMv/egwElA4H7geGX7efG+H45OITVmIu05Nf3fH
         1LCasBR65pP+mkf0BywJD3p3ccp9RH50QoR2GS8UDs5az3fRm+an5Z2Ch+5VoIdu0QkD
         BhZk8w4tT85ZkO1tA8zqS1DyX0rvKIyyygoXhZLKm0lixVgndIdRvwCYqnoSs7ByxSIS
         0LcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FD4rWZvRtjq6yENRSiMKVtNcvX/RF09g3K3VFm1ugEY=;
        b=au2ViuQHw/2jGCsfkmLdbHrMkxtZHfAXeskBB1hr0yrRo7Nrw2OgODM6pETRaXAw/z
         8G8p9ihspKeuFUDMExlO8TEKZNzvfhK/zFOfiHGBEpSpy9zCQTinDXKzGeqjhLxMsSXn
         q845E7rmQM+JYzotrd1PYwF3A4jJlsvSfB3pcE91Nn9KkFxXGG96gzsD6gtjXk39ysBC
         3vK7cMZ8bdp3OkPjzmho2Xyqz4osQuvNWwjdNwuhmz21i8uTzNjIv1yEbQTw484pLAvz
         cC9xJKby45Uhu2qzBoaSiTgL36wYD4Fxc/o6BGMQ44q2XzDW2IhZ4fXrnyrfP3IcdOaG
         kMeA==
X-Gm-Message-State: APjAAAW2ED8UkonRBpHPLuNok2F5P4sZT3Iv7Xk5IqiXUxWB81z4On4W
        fKSfMYIkpR5c5E0qtKHU6XxcgxLT4nhMnfvN11u8Ow==
X-Google-Smtp-Source: APXvYqxi7fyU4+jooeOZ+IRMiLOIyKT3tKM38JWeDbD8Q0d7jOcsPdRO0XHDqMVmSK/f+8kswp6EKP9vA+qe0OrmOpg=
X-Received: by 2002:a67:ef4e:: with SMTP id k14mr5486988vsr.165.1573736043630;
 Thu, 14 Nov 2019 04:54:03 -0800 (PST)
MIME-Version: 1.0
References: <20191108160900.3280960-1-thierry.reding@gmail.com>
In-Reply-To: <20191108160900.3280960-1-thierry.reding@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Nov 2019 13:53:27 +0100
Message-ID: <CAPDyKFpA6iYmTVt84CDics2pWdSnjwQhgW31aaH8sdDtXgyAnQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc_spi: Use proper debounce time for CD GPIO
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@denx.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Nov 2019 at 17:09, Thierry Reding <thierry.reding@gmail.com> wrote:
>
> From: Thierry Reding <treding@nvidia.com>
>
> According to the comment, board files used to specify 1 ms for the
> debounce time. gpiod_set_debounce() needs the debounce time to be
> specified in units of microseconds, so make sure to multiply the value
> by 1000.
>
> Note that, according to the git log, the board files actually did
> specify 1 us for bounce times, but that seems really low. Device tree
> bindings for this type of GPIO typically specify the debounce times in
> milliseconds, so setting this default value to 1 ms seems like it would
> be somewhat safer.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Applied for next, thanks!

Kind regards
Uffe



> ---
>  drivers/mmc/host/mmc_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 66e354d51ee9..74c6cfbf9172 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -1421,7 +1421,7 @@ static int mmc_spi_probe(struct spi_device *spi)
>          * Index 0 is card detect
>          * Old boardfiles were specifying 1 ms as debounce
>          */
> -       status = mmc_gpiod_request_cd(mmc, NULL, 0, false, 1, NULL);
> +       status = mmc_gpiod_request_cd(mmc, NULL, 0, false, 1000, NULL);
>         if (status == -EPROBE_DEFER)
>                 goto fail_add_host;
>         if (!status) {
> --
> 2.23.0
>
