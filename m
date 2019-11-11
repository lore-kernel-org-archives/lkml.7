Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD6FC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5409021872
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mr3jgn8X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfKKNFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 08:05:24 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41282 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfKKNFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 08:05:22 -0500
Received: by mail-vs1-f65.google.com with SMTP id 190so8628744vss.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 05:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t8vYvx18GD5TBNd1q0mA7jDSSmkQRIuSLUp/v+fUMPA=;
        b=Mr3jgn8X85TRmMABlrppdjqKXTw3KoQ0tkejNY2UUpSNRBX4S1su6qu9/bD/8aiibf
         vL7rp++v1RVTiZIvvNVJG1X/INTj3uzIglB6Lyo55sqFpH6itTcsrScfFVE1T58FOimr
         ZDpg3mH6j2crHZMGuJxEGRFJFiTE4Yn/uC750/u4TFUbXzj7VdPV4YyqpdGkK1wT4RIw
         HW+GpYCl/MWI9UYpf/EyAJaVnNN5MtuI0IR1iSyP3EXmAE8jtWaOlh35qGKFwLNIJOig
         jTo0hoeXucWpQ678zzjlmCLNoBYMP+40Mv0yOB3CVGTFgwkYSpRAzw9qOvdR88GOxXtZ
         2r+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t8vYvx18GD5TBNd1q0mA7jDSSmkQRIuSLUp/v+fUMPA=;
        b=JEw4vZWtDScOqrEGIOTFk3Pl46yJGaFCZ93d9IASBeQ2JVuM9+TpyYkdCY2xjYiNlD
         qXacl2fBO9AgrxYABRAP5kLNQoJAByHzbhrQSCML8UoaIBzf2SsuIgXzuegb10iGzCxj
         eMAtMQ7v0Egzi+fcO7Ah0+kSz2BVIJAMFJJocpjzeXM3DbQEHGWrAvQHGeRTMkfQgLdP
         QbUs7/bo5TRlggAwJnSRL7lXiL78alRoSs8t4gX7T+8rxXi23XbZ5zXG7/R7hfAWB9IS
         0/7GnxYBZ8sNbNpCvhVVLatdVaNH1t1tDVGCxsvJIdasioAOyhY2w1V/Jzt2QXjbeBYU
         0H/g==
X-Gm-Message-State: APjAAAXcaxORHqvFeGfxXOqkPuLyvpEanH/4OY2MaLbszUyOx1WFmGTj
        kZGa1oPrx4gcOlm4GeH/VOcQ1pol6wzpqajfMbv8Rg==
X-Google-Smtp-Source: APXvYqxGAuQCp/8AvEDPLKZli/PbYKhYU1pS5j8TWO3nkfvlnOb8NUdy0lHofs5UupjfdckHmocertmwl5UWj2f467A=
X-Received: by 2002:a67:2e0f:: with SMTP id u15mr19259795vsu.89.1573477521399;
 Mon, 11 Nov 2019 05:05:21 -0800 (PST)
MIME-Version: 1.0
References: <1572590582-11056-1-git-send-email-chun-hung.wu@mediatek.com>
In-Reply-To: <1572590582-11056-1-git-send-email-chun-hung.wu@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 11 Nov 2019 14:04:45 +0100
Message-ID: <CAPDyKFropF-au2OTgyRL8-sO0MKXs3GtZGMqYpWpsKHtfdtpyw@mail.gmail.com>
Subject: Re: [PATCH 1/3] [1/3] mmc: core: expose MMC_CAP2_CQE* to dt
To:     Chun-Hung Wu <chun-hung.wu@mediatek.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Pan Bian <bianpan2016@163.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        DTML <devicetree@vger.kernel.org>, wsd_upstream@mediatek.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Nov 2019 at 07:43, Chun-Hung Wu <chun-hung.wu@mediatek.com> wrote:
>
> Expose MMC_CAP2_CQE and MMC_CAP2_CQE_DCMD
> to host->caps2 if
> 1. "supports-cqe" is defined in dt and
> 2. "disable-cqe-dcmd" is not defined in dt.
>
> Change-Id: I3d172e6bcfac34520c3932a6f8df2e20f2c0d05b
> CR-Id:
> Feature:

Remove these tags please.

> Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
> ---
>  drivers/mmc/core/host.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 105b7a7..efb0dbe 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -319,6 +319,14 @@ int mmc_of_parse(struct mmc_host *host)
>                 host->caps2 |= MMC_CAP2_NO_SD;
>         if (device_property_read_bool(dev, "no-mmc"))
>                 host->caps2 |= MMC_CAP2_NO_MMC;
> +       if (device_property_read_bool(dev, "supports-cqe"))
> +               host->caps2 |= MMC_CAP2_CQE;
> +
> +       /* Must be after "supports-cqe" check */
> +       if (!device_property_read_bool(dev, "disable-cqe-dcmd")) {
> +               if (host->caps2 & MMC_CAP2_CQE)
> +                       host->caps2 |= MMC_CAP2_CQE_DCMD;
> +       }
>
>         /* Must be after "non-removable" check */
>         if (device_property_read_u32(dev, "fixed-emmc-driver-type", &drv_type) == 0) {
> --
> 1.9.1
>

Otherwise, this looks good to me.

Kind regards
Uffe
