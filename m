Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6F8C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD0D20675
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I2DlnDhP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389512AbfEXIe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:34:26 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45565 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389046AbfEXIeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:34:25 -0400
Received: by mail-qk1-f196.google.com with SMTP id j1so6205870qkk.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oKqDPNhFrhfI648m2ZpZorjnGR/p8vjrAU5pnK+zOrc=;
        b=I2DlnDhPUcB9WSOCiHzGa1dh1aSnEVCZqggaUOEx9lu7ClYlgQWd6xGoN6YLBPFd1B
         y4VQ8i8uCB9rsJzrpZWQeb66qboUfGI6KX8JrBPy8kILPXMFqypAi02U7tX7kF7Vu9Hq
         Rgml47oOcJaNGJ2WC/7p7ccoaY757I98JYMCeJMe0sE6+052hFn/5G9Z7e3pmwA+wIp4
         fRXfuvzU/zFpDBHtVf0JPhkfXlgAQsd3jVYyMxpSCAoXbIUARfcI8LmTkJ+XII8WNDTa
         K5NIpfMyyaLuO1nfuIEI+7Vn8r4v2NnRZaBtpmf7tCoJnUnVu47g7OXKU8BLxRMpUb9W
         bP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oKqDPNhFrhfI648m2ZpZorjnGR/p8vjrAU5pnK+zOrc=;
        b=XdQfRwxHdxWzfxaCdcOcXvbxlwOdvRU6EVkONsSQ0XTdN1qucU+nuonReEKnd8OnRW
         ABjK9gpI9cU4NLstm6scRefkIopcVM6ej7Zj2kMy0+oXqYjY9dH8Iehbg003cghidoLb
         04Rin1yYlCbyb8O8l6oFgg35DY4O31UWVRu1/+qiMqON1GUxUvQ/WsIsUt/fAvmVAAXk
         IahWNKxOA6ZeIeNf/HNKTGt6vwU4oBaxQWlbkseY+5FWwJhvFIfy+8C6EcCkmfaWztYk
         sP4g/MHnh+vbb2mmH67oogxmrSHqBmRExGWldigXIVYyehCR1qxasQcWWDbKFB2BDnAY
         IdIw==
X-Gm-Message-State: APjAAAUPRbJCzXsft4NoFTvBBRlU43JNoPY04N3GwXO+Hpk2YBXPU23j
        qupbDKrBTVoiQttOMcYmmmKzO6NdMslwfdTLJ68X2w==
X-Google-Smtp-Source: APXvYqyMS3Rs1LJXdWZyK+SojuIy5gzc84YCqZt/AjhqaC8guA5a6LqGCwTxVOOBLQN9MRZFyJwqWtLqDZrNHGIGZ/Q=
X-Received: by 2002:ac8:5501:: with SMTP id j1mr4886948qtq.239.1558686864752;
 Fri, 24 May 2019 01:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <1557500579-19720-1-git-send-email-yannick.fertre@st.com> <aa466c60-9110-630e-3c75-99e632207334@st.com>
In-Reply-To: <aa466c60-9110-630e-3c75-99e632207334@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Fri, 24 May 2019 10:34:13 +0200
Message-ID: <CA+M3ks6nqUdMGxkBYf17ptVMB0P3xJ+cY93xXhCX6FTcKJr+eA@mail.gmail.com>
Subject: Re: [PATCH] drm/stm: dsi: check hardware version
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

Le ven. 10 mai 2019 =C3=A0 18:31, Philippe CORNU <philippe.cornu@st.com> a =
=C3=A9crit :
>
>
> Dear Yannick,
> Thank you for your patch,
>
> Acked-by: Philippe Cornu <philippe.cornu@st.com>
>
> Dear Benjamin,
> If you are fine with this patch, please push it *after* the patch named
> "drm/stm: dsi: add support of an optional regulator" (if I well
> understood those two patches)
>
> Thank you
> Philippe :-)

Applied on drm-misc-next,

Benjamin
>
>
> On 5/10/19 5:02 PM, Yannick Fertr=C3=A9 wrote:
> > Check version of DSI hardware IP. Only versions 1.30 & 1.31
> > are supported.
> >
> > Signed-off-by: Yannick Fertr=C3=A9 <yannick.fertre@st.com>
> > ---
> >   drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 24 +++++++++++++++++++++++-
> >   1 file changed, 23 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/st=
m/dw_mipi_dsi-stm.c
> > index 22bd095..29105e9 100644
> > --- a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> > +++ b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> > @@ -227,7 +227,6 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const st=
ruct drm_display_mode *mode,
> >       u32 val;
> >
> >       /* Update lane capabilities according to hw version */
> > -     dsi->hw_version =3D dsi_read(dsi, DSI_VERSION) & VERSION;
> >       dsi->lane_min_kbps =3D LANE_MIN_KBPS;
> >       dsi->lane_max_kbps =3D LANE_MAX_KBPS;
> >       if (dsi->hw_version =3D=3D HWVER_131) {
> > @@ -306,6 +305,7 @@ static int dw_mipi_dsi_stm_probe(struct platform_de=
vice *pdev)
> >   {
> >       struct device *dev =3D &pdev->dev;
> >       struct dw_mipi_dsi_stm *dsi;
> > +     struct clk *pclk;
> >       struct resource *res;
> >       int ret;
> >
> > @@ -347,6 +347,28 @@ static int dw_mipi_dsi_stm_probe(struct platform_d=
evice *pdev)
> >               goto err_clk_get;
> >       }
> >
> > +     pclk =3D devm_clk_get(dev, "pclk");
> > +     if (IS_ERR(pclk)) {
> > +             ret =3D PTR_ERR(pclk);
> > +             DRM_ERROR("Unable to get peripheral clock: %d\n", ret);
> > +             goto err_dsi_probe;
> > +     }
> > +
> > +     ret =3D clk_prepare_enable(pclk);
> > +     if (ret) {
> > +             DRM_ERROR("%s: Failed to enable peripheral clk\n", __func=
__);
> > +             goto err_dsi_probe;
> > +     }
> > +
> > +     dsi->hw_version =3D dsi_read(dsi, DSI_VERSION) & VERSION;
> > +     clk_disable_unprepare(pclk);
> > +
> > +     if (dsi->hw_version !=3D HWVER_130 && dsi->hw_version !=3D HWVER_=
131) {
> > +             ret =3D -ENODEV;
> > +             DRM_ERROR("bad dsi hardware version\n");
> > +             goto err_dsi_probe;
> > +     }
> > +
> >       dw_mipi_dsi_stm_plat_data.base =3D dsi->base;
> >       dw_mipi_dsi_stm_plat_data.priv_data =3D dsi;
> >
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
