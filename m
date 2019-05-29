Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76018C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 04:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47DCA2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 04:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YIwTisss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfE2ENj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 00:13:39 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44377 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfE2ENj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 00:13:39 -0400
Received: by mail-qk1-f195.google.com with SMTP id w187so558252qkb.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 21:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ngVfzcL9ABAFEihNZh2xSqucsIOjuLs9bDYJ3YGjY9Q=;
        b=YIwTisss8OGpAsO5/2Od/ZAsztSaHuFNoETgc+pwz5tlfdo1jugcfhz8IblnQtmI4K
         bMfWMEZDSdCnRcJNDWns/FCcqv28+CGtNH13ERpno/IQKcFibz0nqdG40SbqJgLeEcSt
         UnAzXk7cJ1mcSKZetxESeze5pwTk2yKMtRoqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ngVfzcL9ABAFEihNZh2xSqucsIOjuLs9bDYJ3YGjY9Q=;
        b=Vov2ca/RQSMFrBYdYpgQ8Dkrf4kGr/gEg6YRH0eGd49KknKXREtMkfk5WVEPYjPpkg
         8tOhWc1MhqdeX5m95h8fUSTpQ5cbBItknxm3kpxIhJdIFyJ4ONH5nOVh/YN8qXFi2PuC
         5XkpGfZdqShuQjARWLuw5IIwTUxA1ozCB34jagVYedFsVpVOvr2vKyvUJkJRKI5FDDKO
         aeMW2v5EirefOom9reOlztN1Bpd4ux7wO0lfrg8NKssNnP/UmHs+hRI45BnuHg9F0/ve
         /MTXh0KTNgkT2r7roTmgqxxkk0Oreyc+bz4cI60J5JZKU9u9bobexpdpA7MyW/UUvAE8
         uP2g==
X-Gm-Message-State: APjAAAUR9KkNw4pki9HKP4djJedN52uZEuBuCQ61uIPaG0TDx6kTTt7S
        lL9dOUoyxmFu0dRz/tKd6Y2ccgE/SCriB2+USTgqbw==
X-Google-Smtp-Source: APXvYqy+xrLrIWh1ypuhtM0OsRgSvv3LdNaJhdhBYvPVYPrtXMmWXw7cZ7Uw7Ssw4uPucZd11u4DhP+e2EgkxFrE2Dk=
X-Received: by 2002:ae9:ec10:: with SMTP id h16mr57494649qkg.215.1559103218155;
 Tue, 28 May 2019 21:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190527045054.113259-1-hsinyi@chromium.org> <20190527045054.113259-2-hsinyi@chromium.org>
 <1559093711.11380.6.camel@mtksdaap41>
In-Reply-To: <1559093711.11380.6.camel@mtksdaap41>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 29 May 2019 12:13:12 +0800
Message-ID: <CAJMQK-inLLC+ePfgBJuGYro3z87hvQ8rLQJX-uiEDn_8svnQ1w@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm: mediatek: fix unbind functions
To:     CK Hu <ck.hu@mediatek.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 9:35 AM CK Hu <ck.hu@mediatek.com> wrote:
>
> Hi, Hsin-yi:
>
> On Mon, 2019-05-27 at 12:50 +0800, Hsin-Yi Wang wrote:
> > move mipi_dsi_host_unregister() to .remove since mipi_dsi_host_register()
> > is called in .probe.
>
> In the latest kernel [1], mipi_dsi_host_register() is called in
> mtk_dsi_bind(), I think we don't need this part.
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/mediatek/mtk_dsi.c?h=v5.2-rc2

This patch https://patchwork.kernel.org/patch/10949305/ moves
mipi_dsi_host_register() from .bind to .probe. I'll reply there to ask
the owner to do this.

>
> >
> > detatch panel in mtk_dsi_destroy_conn_enc(), since .bind will try to
> > attach it again.
> >
> > Fixes: 2e54c14e310f ("drm/mediatek: Add DSI sub driver")
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dsi.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > index b00eb2d2e086..c9b6d3a68c8b 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > @@ -844,6 +844,8 @@ static void mtk_dsi_destroy_conn_enc(struct mtk_dsi *dsi)
> >       /* Skip connector cleanup if creation was delegated to the bridge */
> >       if (dsi->conn.dev)
> >               drm_connector_cleanup(&dsi->conn);
> > +     if (dsi->panel)
> > +             drm_panel_detach(dsi->panel);
>
> I think mtk_dsi_destroy_conn_enc() has much thing to do and I would like
> you to do more. You could refer to [2] for complete implementation.
>
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/exynos/exynos_drm_dsi.c?h=v5.2-rc2#n1575

Will update in next version.

Thanks
