Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC409C04AB0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0182082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BNjPq9C+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfEFH0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 03:26:03 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35681 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfEFH0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 03:26:03 -0400
Received: by mail-qt1-f193.google.com with SMTP id d20so3557157qto.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 00:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WNzn2D4LRFx0zq3ZMJPIJy2EHlJS0W/qRQO2E0djUbU=;
        b=BNjPq9C+fBd/dv+/34M6FL3Z2Pm8FqkPX6Z0HermdNoQMhO2azmmLW0MQfnj03p0b7
         G6hf2mwmU8G01N1ZkBrVVnNTG3r/otxtMeOTBFZyxhj9vjvZCeYarFlh3Z+YyBY0s7Q/
         n5Ij8Ly4cHNdL1GIhiFJUJEIk2EyVcRbn5+YyKfmsJgOjDdssNnRASzFPFZlWcaJ1nZL
         6qsOPoYcGCuqWRDZU55zWXSw6lOexvFw8+spMo1mmr7iFZQvKXYQdHz2IovIeSjmrZGM
         B4ttVnpCIIV/hKVyr9iZSiQvZCjroyPAYOk7dvqikc9cLkahrr/tOydJFEwW4Kjn48A2
         qiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WNzn2D4LRFx0zq3ZMJPIJy2EHlJS0W/qRQO2E0djUbU=;
        b=tClw+cLsgwUelZPTLvwZay1m41W1T+j64VmtwzsiVUcq0Td/eu2YlkmcYsOTbp2TB+
         mnjDYAp2+HxHsG8SbIYqd4dOUjFqNcgttq92PFnS+kh0RLkmHS6U/uJy7J7e/LQPkxs5
         MYBZ/TvOFvzesmjcmV/SP4U44BQ6+iICO1Rx6GNeKXOnUPuYQutA1/8mAaLgodKmxNrL
         W1nLpA1ZBCrS0KfufwuH9kstogLbpyUKQz/RU03qfBM4edpzaF3X5PT7n6C6sLzl3Hal
         zPInELe84j+ZuRCxGZ83GYbw0EFbwzvzH+FjcJ/D4OEyhpQgE1h/zE1+N08ZTce2xD3K
         OzGA==
X-Gm-Message-State: APjAAAUyvqIJI2s7nq0gIzcQWZYcJgcpo0+YiPwBI9IbdoN+dXcgdBYH
        /KlZQeQ4wJFEPtP8lpftYIASbm1YjgewhZMPWDd6pA==
X-Google-Smtp-Source: APXvYqw4GFj4q4UVpUiDKBHF6OghiHzU5JrTfWPLaCo7KAV2UX+jBKeVBbLTsVkPr/PjAhKVuoZEyF0uUBi9eKD6m8o=
X-Received: by 2002:aed:3fad:: with SMTP id s42mr20026506qth.335.1557127562156;
 Mon, 06 May 2019 00:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <1556114601-30936-1-git-send-email-fabien.dessenne@st.com>
 <1556114601-30936-3-git-send-email-fabien.dessenne@st.com> <03f53dcc-816f-c017-f420-5eacc1fa486d@st.com>
In-Reply-To: <03f53dcc-816f-c017-f420-5eacc1fa486d@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Mon, 6 May 2019 09:25:51 +0200
Message-ID: <CA+M3ks6bGqux=D+8PgEn9ovGBEbUzkWSshB81Zy1OTG+U4Ww-w@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/stm: ltdc: return appropriate error code during probe
To:     Philippe CORNU <philippe.cornu@st.com>
Cc:     Fabien DESSENNE <fabien.dessenne@st.com>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le ven. 26 avr. 2019 =C3=A0 14:30, Philippe CORNU <philippe.cornu@st.com> a=
 =C3=A9crit :
>
> Hi Fabien,
> and thank you for your patch,
>
> Acked-by: Philippe Cornu <philippe.cornu@st.com>
>
> Philippe :-)
>
> On 4/24/19 4:03 PM, Fabien Dessenne wrote:
> > During probe, return the "clk_get" error value instead of -ENODEV.
> >
> > Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>

Applied on drm-misc-next.
Thanks,
Benjamin

> > ---
> >   drivers/gpu/drm/stm/ltdc.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> > index 521ba83..97912e2 100644
> > --- a/drivers/gpu/drm/stm/ltdc.c
> > +++ b/drivers/gpu/drm/stm/ltdc.c
> > @@ -1145,8 +1145,9 @@ int ltdc_load(struct drm_device *ddev)
> >
> >       ldev->pixel_clk =3D devm_clk_get(dev, "lcd");
> >       if (IS_ERR(ldev->pixel_clk)) {
> > -             DRM_ERROR("Unable to get lcd clock\n");
> > -             return -ENODEV;
> > +             if (PTR_ERR(ldev->pixel_clk) !=3D -EPROBE_DEFER)
> > +                     DRM_ERROR("Unable to get lcd clock\n");
> > +             return PTR_ERR(ldev->pixel_clk);
> >       }
> >
> >       if (clk_prepare_enable(ldev->pixel_clk)) {
> >
