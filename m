Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0093C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 21:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D3E2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 21:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TaxnU2Oy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbfGQVtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 17:49:12 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45251 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfGQVtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 17:49:11 -0400
Received: by mail-qk1-f193.google.com with SMTP id s22so18773075qkj.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 14:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ejsg9zFg1SBlFMIbKb0gYl6rd1BQSyw/OZUvkIgAnYs=;
        b=TaxnU2Oyx2xFw2mWD1NKL4w1DaCcE7Y+7E0ijhbB4LV85kcJJFyakph9adbzXQFHOz
         878Z2XS7PJvMkQstz8d2kM8Kv7PEN4jRzmh6HzEWEDzyxpeFJz6gON8Dvj5Ye2rZvKH3
         6EiuYt1IV5zpofrOF9eJsX4oYBwWwKBOexo0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ejsg9zFg1SBlFMIbKb0gYl6rd1BQSyw/OZUvkIgAnYs=;
        b=p9qeYELmo75kIi3acKPIOV4Ph/svS3cKbnf7Jf3RtSmJJaMM0oAlIESUINHB5gpSPr
         Np67PqK1LWeX4Ejyp8f4n9/CksaD2FxDiPn8fAoSs04szmsHvQPVUba3BHkipoflPxQ1
         Ae59bRyjpVtY7ZlK5q+dXT0JOsLDBUMTzL3C41QkmD31nXo1PihL+xOYAknKX5IbRWLd
         7EsCfq5flbwas7Z1nrMXiesEaKPyQP1xsSxu/y+8DKwTMNQLecNdbgW7L7IFGr7zL8BE
         bj3XPIew+x9mI77D7elD/jAbf4wMB2vI5myRWn9/3iJe17JC9X8YDu3repg7Ewe9Aq2B
         tW3g==
X-Gm-Message-State: APjAAAXGbVSUTcYGnYoeE+wiKAQJ0NvsWj66mauxCKXudo86Bd1zxxcm
        +uu0OMIpRP/LsBZ2z5D/lbKwQMLSBnRswuOYT3mtlg==
X-Google-Smtp-Source: APXvYqyNm7b7/Vdeq0kcv6bDvARYwnBGZlOZ5GZXhVqH5sSSwkvumU2WuAPzCpUXnbYRnopJaVkUVvXRBo30p08cZDQ=
X-Received: by 2002:a37:48d0:: with SMTP id v199mr27184138qka.318.1563400149938;
 Wed, 17 Jul 2019 14:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190627080116.40264-1-jitao.shi@mediatek.com>
 <20190627080116.40264-2-jitao.shi@mediatek.com> <1561702259.18399.7.camel@mtksdaap41>
In-Reply-To: <1561702259.18399.7.camel@mtksdaap41>
From:   Ryan Case <ryandcase@chromium.org>
Date:   Wed, 17 Jul 2019 14:48:59 -0700
Message-ID: <CACjz--k+Z2QqLEyrWoWSma_K1eP9jcaN3osc80UJQNK9m8=TFQ@mail.gmail.com>
Subject: Re: [v5 1/7] drm/mediatek: move mipi_dsi_host_register to probe
To:     CK Hu <ck.hu@mediatek.com>
Cc:     Jitao Shi <jitao.shi@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        stonea168@163.com, dri-devel@lists.freedesktop.org,
        yingjoe.chen@mediatek.com, Ajay Kumar <ajaykumar.rs@samsung.com>,
        Vincent Palatin <vpalatin@chromium.org>,
        cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Thierry Reding <treding@nvidia.com>, linux-pwm@vger.kernel.org,
        Sascha Hauer <kernel@pengutronix.de>,
        Pawel Moll <pawel.moll@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Andy Yan <andy.yan@rock-chips.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        eddie.huang@mediatek.com, linux-arm-kernel@lists.infradead.org,
        Rahul Sharma <rahul.sharma@samsung.com>,
        srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 11:11 PM CK Hu <ck.hu@mediatek.com> wrote:
>
> Hi, Jitao:
>
> On Thu, 2019-06-27 at 16:01 +0800, Jitao Shi wrote:
> > DSI panel driver need attach function which is inculde in
> > mipi_dsi_host_ops.
> >
> > If mipi_dsi_host_register is not in probe, dsi panel will
> > probe more delay.
> >
> > So move the mipi_dsi_host_register to probe from bind.
> >
> > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > Reviewed-by: CK Hu <ck.hu@mediatek.com>
>
> This version is different than v4, so please remove reviewed-by tag when
> this patch change. When I see a reviewed-by tag of mine, I would just
> skip review it again because I assume this patch is the same as previous
> version.
>
> For this version, I give still give it a
>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dsi.c | 53 +++++++++++++++++-------------
> >  1 file changed, 31 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > index b00eb2d2e086..595b3b047c7b 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > @@ -528,7 +528,7 @@ static s32 mtk_dsi_switch_to_cmd_mode(struct mtk_dsi *dsi, u8 irq_flag, u32 t)
> >
> >  static int mtk_dsi_poweron(struct mtk_dsi *dsi)
> >  {
> > -     struct device *dev = dsi->dev;
> > +     struct device *dev = dsi->->host.dev;

single -> here

> >       int ret;
> >       u64 pixel_clock, total_bits;
> >       u32 htotal, htotal_bits, bit_per_pixel, overhead_cycles, overhead_bits;
> > @@ -1045,12 +1045,6 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
> >               return ret;
> >       }
> >
> > -     ret = mipi_dsi_host_register(&dsi->host);
> > -     if (ret < 0) {
> > -             dev_err(dev, "failed to register DSI host: %d\n", ret);
> > -             goto err_ddp_comp_unregister;
> > -     }
> > -
> >       ret = mtk_dsi_create_conn_enc(drm, dsi);
> >       if (ret) {
> >               DRM_ERROR("Encoder create failed with %d\n", ret);
> > @@ -1060,8 +1054,6 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
> >       return 0;
> >
> >  err_unregister:
> > -     mipi_dsi_host_unregister(&dsi->host);
> > -err_ddp_comp_unregister:
> >       mtk_ddp_comp_unregister(drm, &dsi->ddp_comp);
> >       return ret;
> >  }
> > @@ -1073,7 +1065,6 @@ static void mtk_dsi_unbind(struct device *dev, struct device *master,
> >       struct mtk_dsi *dsi = dev_get_drvdata(dev);
> >
> >       mtk_dsi_destroy_conn_enc(dsi);
> > -     mipi_dsi_host_unregister(&dsi->host);
> >       mtk_ddp_comp_unregister(drm, &dsi->ddp_comp);
> >  }
> >
> > @@ -1097,31 +1088,36 @@ static int mtk_dsi_probe(struct platform_device *pdev)
> >
> >       dsi->host.ops = &mtk_dsi_ops;
> >       dsi->host.dev = dev;
> > +     ret = mipi_dsi_host_register(&dsi->host);
> > +     if (ret < 0) {
> > +             dev_err(dev, "failed to register DSI host: %d\n", ret);
> > +             return ret;
> > +     }
> >
> >       ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
> >                                         &dsi->panel, &dsi->bridge);
> >       if (ret)
> > -             return ret;
> > +             goto err_unregister_host;
> >
> >       dsi->engine_clk = devm_clk_get(dev, "engine");
> >       if (IS_ERR(dsi->engine_clk)) {
> >               ret = PTR_ERR(dsi->engine_clk);
> >               dev_err(dev, "Failed to get engine clock: %d\n", ret);
> > -             return ret;
> > +             goto err_unregister_host;
> >       }
> >
> >       dsi->digital_clk = devm_clk_get(dev, "digital");
> >       if (IS_ERR(dsi->digital_clk)) {
> >               ret = PTR_ERR(dsi->digital_clk);
> >               dev_err(dev, "Failed to get digital clock: %d\n", ret);
> > -             return ret;
> > +             goto err_unregister_host;
> >       }
> >
> >       dsi->hs_clk = devm_clk_get(dev, "hs");
> >       if (IS_ERR(dsi->hs_clk)) {
> >               ret = PTR_ERR(dsi->hs_clk);
> >               dev_err(dev, "Failed to get hs clock: %d\n", ret);
> > -             return ret;
> > +             goto err_unregister_host;
> >       }
> >
> >       regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > @@ -1129,33 +1125,35 @@ static int mtk_dsi_probe(struct platform_device *pdev)
> >       if (IS_ERR(dsi->regs)) {
> >               ret = PTR_ERR(dsi->regs);
> >               dev_err(dev, "Failed to ioremap memory: %d\n", ret);
> > -             return ret;
> > +             goto err_unregister_host;
> >       }
> >
> >       dsi->phy = devm_phy_get(dev, "dphy");
> >       if (IS_ERR(dsi->phy)) {
> >               ret = PTR_ERR(dsi->phy);
> >               dev_err(dev, "Failed to get MIPI-DPHY: %d\n", ret);
> > -             return ret;
> > +             goto err_unregister_host;
> >       }
> >
> >       comp_id = mtk_ddp_comp_get_id(dev->of_node, MTK_DSI);
> >       if (comp_id < 0) {
> >               dev_err(dev, "Failed to identify by alias: %d\n", comp_id);
> > -             return comp_id;
> > +             ret = comp_id;
> > +             goto err_unregister_host;
> >       }
> >
> >       ret = mtk_ddp_comp_init(dev, dev->of_node, &dsi->ddp_comp, comp_id,
> >                               &mtk_dsi_funcs);
> >       if (ret) {
> >               dev_err(dev, "Failed to initialize component: %d\n", ret);
> > -             return ret;
> > +             goto err_unregister_host;
> >       }
> >
> >       irq_num = platform_get_irq(pdev, 0);
> >       if (irq_num < 0) {
> > -             dev_err(&pdev->dev, "failed to request dsi irq resource\n");
> > -             return -EPROBE_DEFER;
> > +             dev_err(&pdev->dev, "failed to get dsi irq_num: %d\n", irq_num);
> > +             ret = irq_num;
> > +             goto err_unregister_host;
> >       }
> >
> >       irq_set_status_flags(irq_num, IRQ_TYPE_LEVEL_LOW);
> > @@ -1163,14 +1161,24 @@ static int mtk_dsi_probe(struct platform_device *pdev)
> >                              IRQF_TRIGGER_LOW, dev_name(&pdev->dev), dsi);
> >       if (ret) {
> >               dev_err(&pdev->dev, "failed to request mediatek dsi irq\n");
> > -             return -EPROBE_DEFER;
> > +             goto err_unregister_host;
> >       }
> >
> >       init_waitqueue_head(&dsi->irq_wait_queue);
> >
> >       platform_set_drvdata(pdev, dsi);
> >
> > -     return component_add(&pdev->dev, &mtk_dsi_component_ops);
> > +     ret = component_add(&pdev->dev, &mtk_dsi_component_ops);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "failed to add component: %d\n", ret);
> > +             goto err_unregister_host;
> > +     }
> > +
> > +     return 0;
> > +
> > +err_unregister_host:
> > +     mipi_dsi_host_unregister(&dsi->host);
> > +     return ret;
> >  }
> >
> >  static int mtk_dsi_remove(struct platform_device *pdev)
> > @@ -1179,6 +1187,7 @@ static int mtk_dsi_remove(struct platform_device *pdev)
> >
> >       mtk_output_dsi_disable(dsi);
> >       component_del(&pdev->dev, &mtk_dsi_component_ops);
> > +     mipi_dsi_host_unregister(&dsi->host);
> >
> >       return 0;
> >  }
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
