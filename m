Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51D2C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5000D206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vhR+gIYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfDCQfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:35:13 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:39867 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDCQfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:35:12 -0400
Received: by mail-yb1-f194.google.com with SMTP id b88so6533282ybi.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 09:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1eUzAyh5WgapSTCxgv9/1r3N5Uh+brvnKH2jJHFe8wM=;
        b=vhR+gIYiNJwtdhnJJZHpe4nqD8anWcWjYKaAK1dq2iVvh4f4p7qXRBq3CFjNX58ZLb
         K1Ki2I37ivuoA7RLCAH5naYW7g0QPVjoH27R/BQ1g+enMoubxjOq1tsw5heJIDN73bMs
         4A9K2CHNk7pZjrv0sAg9l6MiBKrD0qZqILnOK294p5x1WARTD5JH58jvDhnHC1Ofjn9c
         8y+IF+uaIbvVkeS85naWYUCNFd9bvaFw4tJfdjwKLfluBcksc3BE0+Oce3+MEgWCkN8G
         Y4x66DGD6XLHknNP0JAyn9dGHlrzBTRbnHU5CqpkeiYyKdLQm9+ejmyDf0e8ulA6Hz1p
         yltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1eUzAyh5WgapSTCxgv9/1r3N5Uh+brvnKH2jJHFe8wM=;
        b=KzLz9wB7ja5NhmtMfFGWMVRKOcypxoPw19I0G3JJ363IqRICFhbabbJtGqCmhzkX6t
         L3nU17Gy/CR0zVuQEOy5uDHQWt2zgBqxbmxsO/htNs1Ein9cXrP++mqoY6h+mvlRLg1h
         jQuVHk7ofcXMGOxPmzPWIEuEUA4IDyyUerbSzBO2Gnyz730a3z5MjsD7P2OuVJDWi1ha
         1ouxdMdJSYB5jTcy6MQNppFhS692UqWFSF52hu3gRU/s9lMAgxkky4ko83j4gJ7u1+tF
         xSlq6ki/jgOLsfFE2catmX5mOVpiERdXZEwrKL2Enr4psboI+77YXUpAscBM5q0+v/jL
         GTjg==
X-Gm-Message-State: APjAAAUZqzKTbGGm50em3G/D2KkdGQcERXlM0b76IEhUURyVjAC7YSK8
        0ElbcgDvp7/dRUQBvUZGJ6XyXvPC17sQappAb4gH4w==
X-Google-Smtp-Source: APXvYqzJVQRpxCsUdBaR1NqMdk9VB8eYV6FLeReR9mDTxx8FZUf+4t6f1U1JrPgLs8udoZr8N/JpT1qGDSKgEeTgWM4=
X-Received: by 2002:a25:8106:: with SMTP id o6mr862538ybk.53.1554309311693;
 Wed, 03 Apr 2019 09:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190403140529.23103-1-enric.balletbo@collabora.com> <20190403140529.23103-2-enric.balletbo@collabora.com>
In-Reply-To: <20190403140529.23103-2-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 3 Apr 2019 09:35:00 -0700
Message-ID: <CABXOdTf+0d1EVgeDMoqCPJTBja6ahjHp+nX_aSCx2NOeSV15sQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mfd: cros_ec: Instantiate the CrOS USB PD logger driver
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>, jflat@chromium.org,
        kernel@collabora.com, Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Dmitry Torokhov <dtor@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 7:05 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Add the cros-usbpd-logger driver for logging event data for the USB PD
> charger available in the Embedded Controller on ChromeOS systems. The
> logging feature is logically separate functionality from charge manager,
> hence is instantiated as a different driver.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> Lee, this is send as separate patch because touches the MFD subsystem,
> apart from that the driver won't be instantiated if [1/2] is not
> merged, which I think is not a problem, it is safe for both go through
> their subsystem separately.
>
> Thanks,
>  Enric
>
> Changes in v2: None
>
Not really. Changes in v2: Dropped unrelated whitespace changes.

Other than that,

Reviewed-by: Guenetr Roeck <linux@roeck-us.net>

>  drivers/mfd/cros_ec_dev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 0638a0d82d97..3e33fa5b8657 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -612,7 +612,8 @@ static const struct mfd_cell cros_ec_rtc_cells[] = {
>  };
>
>  static const struct mfd_cell cros_usbpd_charger_cells[] = {
> -       { .name = "cros-usbpd-charger" }
> +       { .name = "cros-usbpd-charger" },
> +       { .name = "cros-usbpd-logger" },
>  };
>
>  static const struct mfd_cell cros_ec_platform_cells[] = {
> --
> 2.20.1
>
