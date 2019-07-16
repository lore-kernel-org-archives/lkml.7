Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AB4C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 23:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8932064B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 23:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="npN4iCwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388796AbfGPXNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 19:13:38 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45562 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbfGPXNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 19:13:37 -0400
Received: by mail-qt1-f194.google.com with SMTP id x22so16512212qtp.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 16:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0vVPokc5d+Sgj99HAa1k+ihxyyDw2qJJoHYr3swOfDY=;
        b=npN4iCwRcHVsuF2BJh4ZW7sl77KF563UBDP+Vo40O+2gEmjxaU5/vnqNQtpiJs7yIn
         M6qWcc2DxuzW1xTa6eLEHeb6YraOwjroaHToF+QD45Ahlhnux+nQDyh1EfX04kDiIaqv
         EE3srqM8P/i591ms/4hle9MiaggUo4SRGLG5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0vVPokc5d+Sgj99HAa1k+ihxyyDw2qJJoHYr3swOfDY=;
        b=SiK+Y93R30qDRbaUKDolVVBpQ146Ox9PybBiz/2surngEooUJEXNN+Nr/DP7cQoQg/
         7Zv8iQf3OrLAh8VvpSdeQ9Wcdoz65siVo49A0B+LSTHdqHKMqkT2lYMVXXKPyWmiep+Q
         EuCxsAztCA5mhUc51hHTEQ4YXIpt5mZGw1Uw5OH29xHJb4PEJJlQ2a1sqA7KFEJyUb0K
         RjvqXr8CNsIBtFXmVFXkp+S+ktDGzc+8FAH+Z3v5fPk0CF+V7tdTJafzTPCtS/DxaNmr
         f6neUZi7RCk6Vej3mWjOgML8YoH3KzsJBsZFdyDSOsSBGTAvbFYs60GOLcQZ9LS+M2qT
         XAOw==
X-Gm-Message-State: APjAAAVBl+y3kftNtcuTm+EF98pUMhUg+oZr/juE6IeC1thQtYRdPfsA
        GroEOatk/FgT8c3KxrPJulLafW5/8dKNbSKDoNeY5g==
X-Google-Smtp-Source: APXvYqwqF+BfqG9NwAIGQhOUSg/ata3RZiX/cvuHswIPD1N9Cau1oN4JI06GzaDLk1MGquQ3R6rBvTWlK6d6ZqKbm+A=
X-Received: by 2002:aed:3b1c:: with SMTP id p28mr23903043qte.312.1563318816713;
 Tue, 16 Jul 2019 16:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <1562625253-29254-1-git-send-email-yongqiang.niu@mediatek.com> <1562625253-29254-24-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1562625253-29254-24-git-send-email-yongqiang.niu@mediatek.com>
From:   Ryan Case <ryandcase@chromium.org>
Date:   Tue, 16 Jul 2019 16:13:26 -0700
Message-ID: <CACjz--=Wn4BH_EwEm0DD-vUxB796wUy5Z3MLiOSeiOZXa92r_w@mail.gmail.com>
Subject: Re: [PATCH v4, 23/33] drm/mediatek: add ovl0/ovl_2l0 usecase
To:     yongqiang.niu@mediatek.com
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 3:35 PM <yongqiang.niu@mediatek.com> wrote:
>
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
>
> This patch add ovl0/ovl_2l0 usecase
> in ovl->ovl_2l0 direct link usecase:
> 1. the crtc support layer number will 4+2
> 2. ovl_2l0 background color input select ovl0 when crtc init
> and disable it when crtc finish
> 3. config ovl_2l0 layer, if crtc config layer number is
> bigger than ovl0 support layers(max is 4)
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 38 +++++++++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> index 5eac376..9ee9ce2 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -282,6 +282,15 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
>
>         for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
>                 struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[i];
> +               enum mtk_ddp_comp_id prev;
> +
> +               if (i > 0)
> +                       prev = mtk_crtc->ddp_comp[i - 1]->id;
> +               else
> +                       prev = DDP_COMPONENT_ID_MAX;
> +
> +               if (prev == DDP_COMPONENT_OVL0)
> +                       mtk_ddp_comp_bgclr_in_on(comp);
>
>                 mtk_ddp_comp_config(comp, width, height, vrefresh, bpc);
>                 mtk_ddp_comp_start(comp);
> @@ -291,9 +300,18 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
>         for (i = 0; i < mtk_crtc->layer_nr; i++) {
>                 struct drm_plane *plane = &mtk_crtc->planes[i];
>                 struct mtk_plane_state *plane_state;
> +               struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
> +               unsigned int comp_layer_nr = mtk_ddp_comp_layer_nr(comp);
> +               unsigned int local_layer;
>
>                 plane_state = to_mtk_plane_state(plane->state);
> -               mtk_ddp_comp_layer_config(mtk_crtc->ddp_comp[0], i,
> +
> +               if (i >= comp_layer_nr) {
> +                       comp = mtk_crtc->ddp_comp[1];
> +                       local_layer = i - comp_layer_nr;
> +               } else
> +                       local_layer = i;
> +               mtk_ddp_comp_layer_config(comp , local_layer,
>                                           plane_state);

There is an extra space after comp.

This whole loop is essentially identical to the one found in
mtk_crtc_ddp_config below. It would be nice to either move that loop
to a dedicated function called from both spots or allow
mtk_crtc_ddp_config to be called from here.

>         }
>
> @@ -319,6 +337,7 @@ static void mtk_crtc_ddp_hw_fini(struct mtk_drm_crtc *mtk_crtc)
>                                            mtk_crtc->ddp_comp[i]->id);
>         mtk_disp_mutex_disable(mtk_crtc->mutex);
>         for (i = 0; i < mtk_crtc->ddp_comp_nr - 1; i++) {
> +               mtk_ddp_comp_bgclr_in_off(mtk_crtc->ddp_comp[i]);
>                 mtk_ddp_remove_comp_from_path(mtk_crtc->config_regs,
>                                               mtk_crtc->mmsys_reg_data,
>                                               mtk_crtc->ddp_comp[i]->id,
> @@ -339,6 +358,8 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc)
>         struct mtk_crtc_state *state = to_mtk_crtc_state(mtk_crtc->base.state);
>         struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
>         unsigned int i;
> +       unsigned int comp_layer_nr = mtk_ddp_comp_layer_nr(comp);
> +       unsigned int local_layer;
>
>         /*
>          * TODO: instead of updating the registers here, we should prepare
> @@ -361,7 +382,14 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc)
>                         plane_state = to_mtk_plane_state(plane->state);
>
>                         if (plane_state->pending.config) {
> -                               mtk_ddp_comp_layer_config(comp, i, plane_state);
> +                               if (i >= comp_layer_nr) {
> +                                       comp = mtk_crtc->ddp_comp[1];
> +                                       local_layer = i - comp_layer_nr;
> +                               } else
> +                                       local_layer = i;
> +
> +                               mtk_ddp_comp_layer_config(comp, local_layer,
> +                                                         plane_state);
>                                 plane_state->pending.config = false;
>                         }
>                 }
> @@ -592,6 +620,12 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>         }
>
>         mtk_crtc->layer_nr = mtk_ddp_comp_layer_nr(mtk_crtc->ddp_comp[0]);
> +       if (mtk_crtc->ddp_comp_nr > 1) {
> +               struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[1];
> +
> +               if (comp->funcs->bgclr_in_on)
> +                       mtk_crtc->layer_nr += mtk_ddp_comp_layer_nr(comp);
> +       }
>         mtk_crtc->planes = devm_kcalloc(dev, mtk_crtc->layer_nr,
>                                         sizeof(struct drm_plane),
>                                         GFP_KERNEL);
> --
> 1.8.1.1.dirty
>
