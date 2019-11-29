Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7DDC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 22:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2AB42464D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 22:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t7YKNY5W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387399AbfK2WCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 17:02:51 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:41093 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfK2WCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 17:02:50 -0500
Received: by mail-yb1-f196.google.com with SMTP id d95so12025459ybi.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 14:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gBFfyve4zeh4DVhdr4q4ORn0Yl45pSjl2PrBaMrz/4E=;
        b=t7YKNY5WqMWU/jvRye+X2w55JXFkqSZaPNDtaeQ0Uc469ILUEST4j4sCN/RfDUVJRt
         WpHgyhgG/L6zG7v/G6NjTZ9+A5ME+lSZDvvJx/EWm0BiPFe5QbtohCKnSaQJJOXl8oRN
         WW1oSZC9jFwjD8CqbpWQoGsGJdvDfgkAKDJjWltMV5iNBkecIhw0JMBFfXA20A1TzHxW
         pbwS6XJtOcjbTrqjLjU7/on7XogtzX1Wb5yaUCml5v0+PvbByZsqDF/HFsevw8Qo7LCZ
         st79wvz+Mraflp10AvIyoI6pAjMKAHeFWzTfnCgivIPLoomMAwzdW6MswGGhH/AudVMj
         yM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gBFfyve4zeh4DVhdr4q4ORn0Yl45pSjl2PrBaMrz/4E=;
        b=co1wZurA6ZmBnnM3xAMC3LcrO3tMg0vTXBkySCSZJPTvq7c6w1jg57NrXoKLj9NeNw
         owMhi83CfX+AmUbhtZhgB5IJspNuzqsuwdqL4KVO9P0ENNpZzd9U/SqH9EHG7WvBLFxk
         wPb0Wk+jNinj9KDFBQAbthdKBDg/YmpfdGVfe7yhab6dqfhpCdCd/MXFgIm0LlkyqAk8
         bDiI32tjHG9krfavQYcPEK58v5xHm2Wd5qaWeJ7wMosu5Uul31BaTCvTofGNRbjyFNza
         dhKoMRjfXt+a2MbW8azf5oJiLZTvZar5Yo2oxNEtu7EdWmBahPNWLZuqCS9yz72RYu4l
         3qYA==
X-Gm-Message-State: APjAAAWaEfBLT9Ye0j6etVXiRP+CR577m8enQfOxJoWZU+47uvoNJdsX
        seg4agokGnnB2v42M39Wc53WYV1oBylX9KH/5MzRFoUx
X-Google-Smtp-Source: APXvYqz2Ccri7VdLSl/UfTzXKgElMvDMOdBy89g3NxMW9dTyG3JrmQhReCS5tL2MvOv1tFmZmyUE7EFFLE1wpugCSwA=
X-Received: by 2002:a25:1909:: with SMTP id 9mr11484703ybz.61.1575064968117;
 Fri, 29 Nov 2019 14:02:48 -0800 (PST)
MIME-Version: 1.0
References: <20191129215916.17105-1-enric.balletbo@collabora.com>
In-Reply-To: <20191129215916.17105-1-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 29 Nov 2019 14:02:37 -0800
Message-ID: <CABXOdTef5QAmZosDFF0Av8=9etj46O6aoxM3k9M9YBJmJynASA@mail.gmail.com>
Subject: Re: [PATCH] power: supply: cros_usbpd: Remove dev_err() getting the
 number of ports
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>, fparent@baylibre.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 1:59 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> When a device has no support to get the charger number of ports, it
> doesn't have to result in a dev_err(), print saying "Could not get
> charger port count" using a dev_info() would suffice. In such case,
> the dev_info() message is already printed but the dev_err() is annoying,
> specially, on those devices that doesn't support the command. So remove
> the dev_err().
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
>  drivers/power/supply/cros_usbpd-charger.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
> index 6cc7c3910e09..ffad9ee03a68 100644
> --- a/drivers/power/supply/cros_usbpd-charger.c
> +++ b/drivers/power/supply/cros_usbpd-charger.c
> @@ -132,11 +132,8 @@ static int cros_usbpd_charger_get_num_ports(struct charger_data *charger)
>         ret = cros_usbpd_charger_ec_command(charger, 0,
>                                             EC_CMD_CHARGE_PORT_COUNT,
>                                             NULL, 0, &resp, sizeof(resp));
> -       if (ret < 0) {
> -               dev_err(charger->dev,
> -                       "Unable to get the number of ports (err:0x%x)\n", ret);
> +       if (ret < 0)
>                 return ret;
> -       }
>
>         return resp.port_count;
>  }
> @@ -148,11 +145,8 @@ static int cros_usbpd_charger_get_usbpd_num_ports(struct charger_data *charger)
>
>         ret = cros_usbpd_charger_ec_command(charger, 0, EC_CMD_USB_PD_PORTS,
>                                             NULL, 0, &resp, sizeof(resp));
> -       if (ret < 0) {
> -               dev_err(charger->dev,
> -                       "Unable to get the number or ports (err:0x%x)\n", ret);
> +       if (ret < 0)
>                 return ret;
> -       }
>
>         return resp.num_ports;
>  }
> --
> 2.20.1
>
