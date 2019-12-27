Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0F1C2D0DA
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 13:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83FA6208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 13:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfL0NXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 08:23:20 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44174 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfL0NXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 08:23:19 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 9ABA228BABE;
        Fri, 27 Dec 2019 13:23:16 +0000 (GMT)
Date:   Fri, 27 Dec 2019 14:23:13 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Inki Dae <inki.dae@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] drm/bridge: Fix Exynos DSI after making bridge chain a
 double-linked list
Message-ID: <20191227142313.5032ff0f@collabora.com>
In-Reply-To: <20191227130004.69d7dcad@collabora.com>
References: <CGME20191227110216eucas1p17cbf91afa905852d3c0b1efeec0f6f8d@eucas1p1.samsung.com>
        <20191227110135.4961-1-m.szyprowski@samsung.com>
        <20191227130004.69d7dcad@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Dec 2019 13:00:04 +0100
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Fri, 27 Dec 2019 12:01:35 +0100
> Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> 
> > Exynos DSI DRM driver uses private calls to out bridge to force certain
> > order of operations during init/exit sequences. This no longer works after
> > conversion of bridge chain to a double-linked list. To fix the regression
> > call bridge related operations manually instead of the generic
> > drm_bridge_chain_*() operations.  
> 
> I think it'd be worth explaining what the problem is (infinite loop
> caused by list_for_each_entry() use when the bridge is no longer part
> of the chain attached to the encoder).
> 
> > 
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Fixes: 05193dc38197 ("drm/bridge: Make the bridge chain a double-linked list")  
> 
> We also need to fix that in VC4.
> 
> > ---
> > This patch is a result of the following discussion:
> > https://www.spinics.net/lists/dri-devel/msg239256.html
> > ---
> >  drivers/gpu/drm/exynos/exynos_drm_dsi.c | 21 ++++++++++++---------
> >  1 file changed, 12 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> > index 3955f84dc893..f5905c239a86 100644
> > --- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> > +++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> > @@ -255,7 +255,6 @@ struct exynos_dsi {
> >  	struct mipi_dsi_host dsi_host;
> >  	struct drm_connector connector;
> >  	struct drm_panel *panel;
> > -	struct list_head bridge_chain;
> >  	struct drm_bridge *out_bridge;
> >  	struct device *dev;
> >  
> > @@ -1391,7 +1390,8 @@ static void exynos_dsi_enable(struct drm_encoder *encoder)
> >  		if (ret < 0)
> >  			goto err_put_sync;
> >  	} else {
> > -		drm_bridge_chain_pre_enable(dsi->out_bridge);
> > +		if (dsi->out_bridge->funcs->pre_enable)
> > +			dsi->out_bridge->funcs->pre_enable(dsi->out_bridge);  
> 
> Okay, so you're calling ->{pre_enable,enable,disable,post_disable}() on
> the first bridge element which only works if the chain contains one
> bridge (see below). Maybe you should keep exynos_dsi.bridge_chain and
> create custom helpers to iterate over chain elements instead of calling
> those hooks only on out_bridge.

The following diff should fix the problem while keeping the solution
generic enough to support chains containing more than one bridge.

--->8---
diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index 3955f84dc893..c861b640fc59 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -1378,6 +1378,7 @@ static void exynos_dsi_unregister_te_irq(struct exynos_dsi *dsi)
 static void exynos_dsi_enable(struct drm_encoder *encoder)
 {
        struct exynos_dsi *dsi = encoder_to_dsi(encoder);
+       struct drm_bridge *iter;
        int ret;
 
        if (dsi->state & DSIM_STATE_ENABLED)
@@ -1391,7 +1392,11 @@ static void exynos_dsi_enable(struct drm_encoder *encoder)
                if (ret < 0)
                        goto err_put_sync;
        } else {
-               drm_bridge_chain_pre_enable(dsi->out_bridge);
+               list_for_each_entry_reverse(iter, &encoder->bridge_chain,
+                                           chain_node) {
+                       if (iter->funcs->pre_enable)
+                               iter->funcs->pre_enable(iter);
+               }
        }
 
        exynos_dsi_set_display_mode(dsi);
@@ -1402,7 +1407,10 @@ static void exynos_dsi_enable(struct drm_encoder *encoder)
                if (ret < 0)
                        goto err_display_disable;
        } else {
-               drm_bridge_chain_enable(dsi->out_bridge);
+               list_for_each_entry(iter, &encoder->bridge_chain, chain_node) {
+                       if (iter->funcs->enable)
+                               iter->funcs->enable(iter);
+               }
        }
 
        dsi->state |= DSIM_STATE_VIDOUT_AVAILABLE;
@@ -1420,6 +1428,7 @@ static void exynos_dsi_enable(struct drm_encoder *encoder)
 static void exynos_dsi_disable(struct drm_encoder *encoder)
 {
        struct exynos_dsi *dsi = encoder_to_dsi(encoder);
+       struct drm_bridge *iter;
 
        if (!(dsi->state & DSIM_STATE_ENABLED))
                return;
@@ -1427,10 +1436,20 @@ static void exynos_dsi_disable(struct drm_encoder *encoder)
        dsi->state &= ~DSIM_STATE_VIDOUT_AVAILABLE;
 
        drm_panel_disable(dsi->panel);
-       drm_bridge_chain_disable(dsi->out_bridge);
+
+       list_for_each_entry_reverse(iter, &encoder->bridge_chain, chain_node) {
+               if (iter->funcs->disable)
+                       iter->funcs->disable(iter);
+       }
+
        exynos_dsi_set_display_enable(dsi, false);
        drm_panel_unprepare(dsi->panel);
-       drm_bridge_chain_post_disable(dsi->out_bridge);
+
+       list_for_each_entry(iter, &encoder->bridge_chain, chain_node) {
+               if (iter->funcs->post_disable)
+                       iter->funcs->post_disable(iter);
+       }
+
        dsi->state &= ~DSIM_STATE_ENABLED;
        pm_runtime_put_sync(dsi->dev);
 }
@@ -1523,7 +1542,7 @@ static int exynos_dsi_host_attach(struct mipi_dsi_host *host,
        if (out_bridge) {
                drm_bridge_attach(encoder, out_bridge, NULL);
                dsi->out_bridge = out_bridge;
-               list_splice(&encoder->bridge_chain, &dsi->bridge_chain);
+               list_splice_init(&encoder->bridge_chain, &dsi->bridge_chain);
        } else {
                int ret = exynos_dsi_create_connector(encoder);
 
