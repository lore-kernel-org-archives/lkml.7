Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86866C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E03920644
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vZIYuwEi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733036AbfIPNQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 09:16:17 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39114 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732956AbfIPNQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 09:16:17 -0400
Received: by mail-qk1-f196.google.com with SMTP id 4so36258460qki.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 06:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p8H14b8QOC7xyThE796vVQTVHwHGb7hWB3A0YDyKzi8=;
        b=vZIYuwEiPxNk76J3bqFOPMb7hAUUS/X0U7oo+vJzdyuvvkHgRlmK3AFwdDGKPHgJce
         jraHYg6hm4koJfMvBz5DtqLV9BOB7NXmHwMzOsoPDSPJ2BbT6sCeyUTeB2VnjPGQaw9c
         /C3Y8Gj3E9j44l1WvkOQqemf+GvIOoW3kJyNE8cwCp+WdtC/MgML25kVKfu2GzTpy9Ep
         LSSJKi299lQyNl1R5e6sCkvdIo4VuUlksmvaX9lLO6AgoW5olf2/1pn30OOp8TtUdqBC
         wNqvxSVlu5yEmm2Tr9kSx7x+3rWq34rVq3sncVuIm64rI8+cYHjcHPKTDCpW9j0pVOMW
         tuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p8H14b8QOC7xyThE796vVQTVHwHGb7hWB3A0YDyKzi8=;
        b=n+RNugFplBd6xhPWey05G2WIxZ3kYwqCnKB6aagxixKPO48vqVS01c1TqCaKP0o9I9
         mhe195szAAkVB4tkL405v3EqoZc7b7jhdIW7UYxKXz4ZX4WkNWSQ3VXOG0YvDh/HPkJI
         7b4rKDwUSahb8YA9vUpcgvtxvlml8L4TT71uRdSiXPHXnKN77Xw2muo9a8k4z4kwf5de
         ci0pWh9f0J8MY3D9MGbfKr3fk2acjF4oZu+S24ioZH+PA8MZvVuBdLP93wTE9HoYvgtm
         Q+6feG/95lYOhI1HHoeprs/5gAR0ObTEAguC7iJqW7vP3HAD1FHBqRvemxhOVIyDF5Ma
         Aimw==
X-Gm-Message-State: APjAAAXzvk8/TZCBKZfe9zj0zkMjsfNqNTtY/eS6vUj31ib0PQdtFY7k
        +9YkTji3Ak7x9/4kGhhlHn8nqxWok1e15rSvT+xymA==
X-Google-Smtp-Source: APXvYqw2JIJaTfERF5pMhfhzLnLH23suF9vY3fd49RTGa+0vQVfMcg4dlOfYT6eDDrXzOlwQxh/GlMpqslbpzY+szUQ=
X-Received: by 2002:a05:620a:16d2:: with SMTP id a18mr29075565qkn.104.1568639776108;
 Mon, 16 Sep 2019 06:16:16 -0700 (PDT)
MIME-Version: 1.0
References: <1568278589-20400-1-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1568278589-20400-1-git-send-email-yannick.fertre@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Mon, 16 Sep 2019 15:16:05 +0200
Message-ID: <CA+M3ks56v__Lef4wN8KthoLoJ_yYYou8u+-PsJXSUVJQHaimdA@mail.gmail.com>
Subject: Re: [PATCH] drm/stm: dsi: higher pll out only in video burst mode
To:     =?UTF-8?Q?Yannick_Fertr=C3=A9?= <yannick.fertre@st.com>
Cc:     Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu. 12 sept. 2019 =C3=A0 10:57, Yannick Fertr=C3=A9 <yannick.fertre@st.=
com> a =C3=A9crit :
>
> In order to better support video non-burst modes,
> the +20% on pll out is added only in burst mode.
>
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> Reviewed-by: Yannick FERTRE <yannick.fertre@st.com>

Applied on drm-misc-next,
Thanks,
Benjamin

> ---
>  drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/stm/=
dw_mipi_dsi-stm.c
> index a03a642..514efef 100644
> --- a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> +++ b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> @@ -260,8 +260,11 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const str=
uct drm_display_mode *mode,
>         /* Compute requested pll out */
>         bpp =3D mipi_dsi_pixel_format_to_bpp(format);
>         pll_out_khz =3D mode->clock * bpp / lanes;
> +
>         /* Add 20% to pll out to be higher than pixel bw (burst mode only=
) */
> -       pll_out_khz =3D (pll_out_khz * 12) / 10;
> +       if (mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
> +               pll_out_khz =3D (pll_out_khz * 12) / 10;
> +
>         if (pll_out_khz > dsi->lane_max_kbps) {
>                 pll_out_khz =3D dsi->lane_max_kbps;
>                 DRM_WARN("Warning max phy mbps is used\n");
> --
> 2.7.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
