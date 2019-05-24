Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE3CC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346C52175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="COOin8sW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389572AbfEXIfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:35:22 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43712 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389046AbfEXIfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:35:21 -0400
Received: by mail-qk1-f195.google.com with SMTP id z6so6200606qkl.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=stihjVpyL81uND5ibC7iaE+uqyg/RcZbMfoVKMB+mtE=;
        b=COOin8sWa/lSfTHzEbCe7QsWKGFHiwbo+Kuqmt7jQDTjGn3ID2t5iZEWRjwnG6By71
         uv4qD+B6V+lTSd1cGxfjm6xdUqKzNvZcPCCozGAex2g3HPLoSyGt0NRZJNju326CVrUV
         MZiPPpSrfATRPBRj69TBl8hi4mwSD9d9Ry0RIkDRDarSJhV7v4vh0sMntfyLf1zjBRF6
         ur+A0Nr18atc8xLW4L1cLh+ev5aI/b8CI+deN/SFEn4H6FL/TkNMHhBha/cCFesIbyQj
         44MwusoS5aJ1WsuHrDOHZoGBVhNW/7ciTNwIzlDSGh3AbxWasZnSztVK7nzT87PYKu6H
         HZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=stihjVpyL81uND5ibC7iaE+uqyg/RcZbMfoVKMB+mtE=;
        b=E96jCn8EMxIDO5qwFrH0M6Y58+7mqrLg7f5WiBTBRi/SS9+TIDZDz21zKUCSXT/BV7
         Me5mY1xaGf1UdyQM7LJ1C2PCaRbiJgylwIs8PZeckY8qDs7hOch7fi5hbPoc+1/NbucV
         XZWgV59nJkGE3rHbVBZbcFvapHDNel8Bouo8LY6diJWtdbo2B9P9398PR2hRaWcpd6Lc
         0N0T66QcxOqzLQL/mvWAjWtZ/gdsUL/oH1DxuCK/eDPuX79qKnc6H9QmrcSLmfq/os8j
         DeVsSl/RXV5NEDhDs839ZdPK7SAv+EuveOXhHYIPTgqPfBHeYQ6sjEsDFQ+D2/VtkT2E
         SLlw==
X-Gm-Message-State: APjAAAWnya7nPZzhn+hclzb+PBzwoI6HhjUdtXwMV0EQIUNtfQ68bPLE
        t7jdcqxcdv375992Cub9eNjo7Et5GWy6DMmNQCLuiQ==
X-Google-Smtp-Source: APXvYqzoub85iC3qRkUT/1rqPcbCAqf2PraA42mUh6gZCy1soKl7824Xl/NLHnNFN2zZSje+ohS+z/SwZ9ZQTmdisuQ=
X-Received: by 2002:a0c:ad85:: with SMTP id w5mr11932788qvc.242.1558686920808;
 Fri, 24 May 2019 01:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <1557753318-11218-1-git-send-email-yannick.fertre@st.com> <317f94d6-846f-92e2-bd0f-b44377ea7845@st.com>
In-Reply-To: <317f94d6-846f-92e2-bd0f-b44377ea7845@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Fri, 24 May 2019 10:35:10 +0200
Message-ID: <CA+M3ks77XPTZubS8icLdTF3mpQ3OHsvSqX35hHQik3ygRiGSZg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/stm: ltdc: remove clk_round_rate comment
To:     Philippe CORNU <philippe.cornu@st.com>
Cc:     Yannick FERTRE <yannick.fertre@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
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

Le lun. 13 mai 2019 =C3=A0 16:46, Philippe CORNU <philippe.cornu@st.com> a =
=C3=A9crit :
>
> Dear Yannick,
>
> Acked-by: Philippe Cornu <philippe.cornu@st.com>
>
Applied on drm-misc-next,

Benjamin

> Thank you,
>
> Philippe :-)
>
> On 5/13/19 3:15 PM, Yannick Fertr=C3=A9 wrote:
> > Clk_round_rate returns rounded clock without changing
> > the hardware in any way.
> > This function couldn't replace set_rate/get_rate calls.
> > Todo comment has been removed & a new log inserted.
> >
> > Signed-off-by: Yannick Fertr=C3=A9 <yannick.fertre@st.com>
> > ---
> > Changes in v2:
> >       - Clk_enable & clk_disable are needed for the SOC STM32F7
> >        (not for STM32MP1). I return this part of the patch to make sure=
 the
> >        driver is compatible with all SOC STM32.
> >
> >   drivers/gpu/drm/stm/ltdc.c | 8 +++-----
> >   1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> > index 97912e2..1104e78 100644
> > --- a/drivers/gpu/drm/stm/ltdc.c
> > +++ b/drivers/gpu/drm/stm/ltdc.c
> > @@ -507,11 +507,6 @@ static bool ltdc_crtc_mode_fixup(struct drm_crtc *=
crtc,
> >       struct ltdc_device *ldev =3D crtc_to_ltdc(crtc);
> >       int rate =3D mode->clock * 1000;
> >
> > -     /*
> > -      * TODO clk_round_rate() does not work yet. When ready, it can
> > -      * be used instead of clk_set_rate() then clk_get_rate().
> > -      */
> > -
> >       clk_disable(ldev->pixel_clk);
> >       if (clk_set_rate(ldev->pixel_clk, rate) < 0) {
> >               DRM_ERROR("Cannot set rate (%dHz) for pixel clk\n", rate)=
;
> > @@ -521,6 +516,9 @@ static bool ltdc_crtc_mode_fixup(struct drm_crtc *c=
rtc,
> >
> >       adjusted_mode->clock =3D clk_get_rate(ldev->pixel_clk) / 1000;
> >
> > +     DRM_DEBUG_DRIVER("requested clock %dkHz, adjusted clock %dkHz\n",
> > +                      mode->clock, adjusted_mode->clock);
> > +
> >       return true;
> >   }
> >
> > --
> > 2.7.4
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
