Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FCDC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F9E20882
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PJL7bIGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406099AbfIWIPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 04:15:33 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45770 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405105AbfIWIPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 04:15:33 -0400
Received: by mail-ed1-f68.google.com with SMTP id h33so11941544edh.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 01:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YrphDalHhzS/eEcKq6pAk4HWzVaxWmV1yXuQ1gyWfUo=;
        b=PJL7bIGC0ZYBHvwVyYt2LJ5y887xECL9EXUH3kVh2gitdKh2PIj+LjzBO3LVxGro1P
         L45a/oCt5B7UKTTPbz8ClvwE8+bChE4KQP9p5SPpAnRpS9BKt7SQQpJAcS9rEmvpsy8w
         7Xt0OLUHniWm243JJOhB8bgzU99a89+rosGY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YrphDalHhzS/eEcKq6pAk4HWzVaxWmV1yXuQ1gyWfUo=;
        b=LJQgtRE6S6VWxsNeq9Sfg4EQh6/7od+/ws/JDVixJph3cFBx8jyxZAVjvUSikA90Hw
         G/qlRu+W5d5LsbhUh+OV0aM3DCCxoFDW+zWmWdeXXb1ZW+gMQqeaZlPSrM5GyYH8Dcbv
         JR6L2s2ReMTQ+gIMdOGDASICZwhn+Z8OCepwiYTrZkEWvgtuc6uJb3uppa1Z4zONfW/H
         7vd2ViZgJlYJ6PiqTO14bIhbSeCHbCHsgflsBYpIVX82FZUgJLkHdGoD/G2XIIm+tplB
         TszC+EC6CfUKFvzDEKANEvudHtXwQYSDhsVQlxA24m7M+VY7rIO9kuXtbS7fiahEsJWc
         E1lg==
X-Gm-Message-State: APjAAAWPTFsFdvxgG+lXLKDSOYrKoZZrK9O+GwIANG9XYLQiP0omt6Hq
        8sBfJW5G229FwhYDZ7UDru59AhBHCgD8vobcwCe66A==
X-Google-Smtp-Source: APXvYqzVI45ag269E7dBFRpSiMPbDjXntVzL2o19/1Lnor6BCjBJy2beWlf+y8GGpI0LGcSqflkxyaky8ooirXFogWY=
X-Received: by 2002:a50:f391:: with SMTP id g17mr32700852edm.163.1569226531020;
 Mon, 23 Sep 2019 01:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190830074103.16671-1-bibby.hsieh@mediatek.com> <20190830074103.16671-3-bibby.hsieh@mediatek.com>
In-Reply-To: <20190830074103.16671-3-bibby.hsieh@mediatek.com>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Mon, 23 Sep 2019 16:14:55 +0800
Message-ID: <CANdKZ0du8unMedhmdjCyXR7xKYBoWEZ7YLmrvd6Y_W-Y=u3TfQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/mediatek: Apply CMDQ control flow
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
Cc:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        YT Shen <yt.shen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        CK Hu <ck.hu@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bibby,

On Fri, Aug 30, 2019 at 3:41 PM Bibby Hsieh <bibby.hsieh@mediatek.com> wrote:
> ...
> +static void ddp_cmdq_cb(struct cmdq_cb_data data)
> +{
> +
> +#if IS_ENABLED(CONFIG_MTK_CMDQ)
> +       struct mtk_cmdq_cb_data *cb_data = data.data;
> +       struct drm_crtc_state *crtc_state = cb_data->state;
> +       struct drm_atomic_state *atomic_state = crtc_state->state;
> +       struct drm_crtc *crtc = crtc_state->crtc;
> +       struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
> +
> +       DRM_DEBUG_DRIVER("%s\n", __func__);
This debug message is printed about twice per second when enabled,
which makes debugging other things that also use DRM_DEBUG_DRIVER
harder. Can this be rate-limited or removed?

> +
> +       if (mtk_crtc->pending_needs_vblank) {
> +               /* cmdq_vblank_event must be read after cmdq_needs_event */
> +               smp_rmb();
> +
> ...
> +void mtk_drm_crtc_plane_update(struct drm_crtc *crtc, struct drm_plane *plane,
> +                              struct mtk_plane_state *state)
> +{
> +       struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
> +       struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
> +       struct drm_crtc_state *crtc_state = crtc->state;
> +       struct mtk_crtc_state *mtk_crtc_state = to_mtk_crtc_state(crtc_state);
> +       struct cmdq_pkt *cmdq_handle = mtk_crtc_state->cmdq_handle;
> +       unsigned int comp_layer_nr = mtk_ddp_comp_layer_nr(comp);
> +       unsigned int local_layer;
> +       unsigned int plane_index = plane - mtk_crtc->planes;
> +
> +       DRM_DEBUG_DRIVER("%s\n", __func__);
Same with this one.

> +       if (mtk_crtc->cmdq_client) {
> +               if (plane_index >= comp_layer_nr) {
> +                       comp = mtk_crtc->ddp_comp[1];
> +                       local_layer = plane_index - comp_layer_nr;
> ...
> @@ -494,13 +599,29 @@ static void mtk_drm_crtc_atomic_flush(struct drm_crtc *crtc,
>                                       struct drm_crtc_state *old_crtc_state)
>  {
>         struct drm_atomic_state *old_atomic_state = old_crtc_state->state;
> +       struct drm_crtc_state *crtc_state = crtc->state;
> +       struct mtk_crtc_state *state = to_mtk_crtc_state(crtc_state);
> +       struct cmdq_pkt *cmdq_handle = state->cmdq_handle;
>         struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
>         struct mtk_drm_private *priv = crtc->dev->dev_private;
> +       struct mtk_cmdq_cb_data *cb_data;
>         unsigned int pending_planes = 0;
>         int i;
>
> -       if (mtk_crtc->event)
> -               mtk_crtc->pending_needs_vblank = true;
> +       DRM_DEBUG_DRIVER("[CRTC:%u] [STATE:%p(%p)->%p(%p)]\n", crtc->base.id,
> +                        old_crtc_state, old_crtc_state->state,
> +                        crtc_state, crtc_state->state);
Same with this one.

> +
> +       if (IS_ENABLED(CONFIG_MTK_CMDQ) && mtk_crtc->cmdq_client) {
> +               drm_atomic_state_get(old_atomic_state);
> +               cb_data = kmalloc(sizeof(*cb_data), GFP_KERNEL);
> +               cb_data->state = old_crtc_state;
> ...
