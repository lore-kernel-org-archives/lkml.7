Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEAAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC7520879
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OpFFhfXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfCKJ6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:58:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41729 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfCKJ6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:58:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id n2so4316711wrw.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 02:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J63OSK6jJV4RYXnglHExqatZ+hdW5fSRwa/MBq2INCM=;
        b=OpFFhfXt3p+3HgVr5AUJKNNRt6mXqaAXIYk8IwXFMaVNmo3gAouXRY3qM1zn9gOH2G
         8rSNlKOvjfGItABJyV3K1mDod5HePxVvk3faPZfRmG/4aCwN/KQ9ernsoCzNmRD5yP4l
         RCqMYt5KPcsh8J3BOpEJSsaJU62na5FR34aDp9TiF1DTiFNU7V0yWXJnBLPArc7BrlPE
         prjn5rTauwNPDCL5fDSgQolCWDarftydCgtLzSQgCb/+35WE53kY63dyckT/8HaxBjmS
         EBIXJj2c3CdOvC9ZhAVNgBAPgNAQl7ujDvgXovF0kLOJBg6aQEgrL50ML1AF8qXhvV3J
         TqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J63OSK6jJV4RYXnglHExqatZ+hdW5fSRwa/MBq2INCM=;
        b=Umh8hndsnx5jcmWydb22ONHelhTPjtQVcfx5/bDTIaJUClA8xQYbFOnNYA8m6u8rfA
         MRGpSM7t0JvzhPah3c2N+krUANVRcJtcR0WE7HrgtTBzbzNfFyR57bbZYvIsUy7qfY1z
         o/FXUCeZvgAZIP2L+0tZirBKOkHtzaZNwGolbT3yRa1LzsxbL43ocxTXrvyWPuLHY2rM
         fPdHCANsYXcUfZC3U33BXuRnC248oHMmEzKKWTSR23A0Git3qmr+owrs9eJ6DyvtbpHd
         JBEAE9BokO1hQqS9YoaN0KPn+N1V1TBx3AGjn8kFmurkj4T7vIoIlnt6nEEmRC0PwHdX
         Tvpg==
X-Gm-Message-State: APjAAAU2pb7hcu1JWv5QlvJlpFGCyGyM01WIXbzcwBoSDg76hOhWMmrS
        zNrEZQtia9CGP4ZrLFu4/0IUDvWeLjbmlS1X3S3OcA==
X-Google-Smtp-Source: APXvYqzLQTudfyo5nuWqkKT9H6qp0gB9vcc45ut23eJmjVkjXYRlG6eVFyRl8AkTy+4LBn2twNDwudkCEMtxwYIzfsI=
X-Received: by 2002:a05:6000:124d:: with SMTP id j13mr18519993wrx.102.1552298329638;
 Mon, 11 Mar 2019 02:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190204095532.27185-1-narmstrong@baylibre.com>
In-Reply-To: <20190204095532.27185-1-narmstrong@baylibre.com>
From:   Maxime Jourdan <mjourdan@baylibre.com>
Date:   Mon, 11 Mar 2019 10:58:38 +0100
Message-ID: <CAMO6nazS_vvx4z+AFZjfX6K8ipB0-Cqoqaj0-WXN_DDWQ_T4xg@mail.gmail.com>
Subject: Re: [PATCH] drm/meson: handle when meson_canvas_get returns -EPROBE_DEFER
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     daniel@ffwll.ch, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,
On Mon, Feb 4, 2019 at 10:55 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> When meson_canvas is not yet probed, meson_canvas_get returns -EPROBE_DEFER.
>
> Handle this case but deferring the probe of the drm driver aswell.
>
> Fixes: 66cae477c380 ("drm/meson: Use optional canvas provider")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
> index ef4afaadaf8d..17e55d63daff 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -236,6 +236,9 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>                         meson_canvas_free(priv->canvas, priv->canvas_id_vd1_1);
>                         goto free_drm;
>                 }
> +       } else if (PTR_ERR(priv->canvas) == -EPROBE_DEFER) {
> +               ret = PTR_ERR(priv->canvas);
> +               goto free_drm;
>         } else {
>                 priv->canvas = NULL;
>
> --
> 2.20.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

With the upcoming patch series that aims at removing the DMC register
range from the DRM driver's control, this fix will be incorporated,
although rewritten because of code modifications in this partilcular
area.

Maxime
