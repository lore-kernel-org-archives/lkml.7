Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32ED1C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 06:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39FC224F8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 06:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OpbZtYc6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfLEGQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 01:16:25 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36722 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfLEGQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 01:16:24 -0500
Received: by mail-io1-f68.google.com with SMTP id l17so2411879ioj.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 22:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sagxzG2UOJgqtCWMTEvuG8BujWW/Ac96ALrG1/iNc1g=;
        b=OpbZtYc602v9GzttMW4clzIL5MO4H74stJoLKvSgJ9YuuzxyAVwKg2x2E5bGNMS8Ix
         VDGM0ySfeLoY9+ChJHUdC74eBzZEuLW95Lorx6yqi4GfEEPEMk7F9nkm/1HdMBuXIe8W
         5dmUXfLm7RO8hDMjSRzUREtQ0GULXDZwxm5Vk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sagxzG2UOJgqtCWMTEvuG8BujWW/Ac96ALrG1/iNc1g=;
        b=LUiw2Tt50anzsxj9yKfwP/ZOTe2btHXWtUrEmbLVYYK9AeZYEJM6epI7z7r8zBf2YK
         KgtPq7+YzPh+DAskX2Ef4/SoYY+YHngIMSLX/sYRDeXbLeSUbnEfnAePlM5zg+199TUv
         4A6swqfET2zd575EXOWRSHbN3FYBoS5+vq6HdG5Z+Bs06fQizrk6rVwijwtP7lNUvjVR
         5EAADaBniCCZehbQK4EICzp/IbUwB8kC2EEqyGBcG0lT53dwjUO1F4G+nmCpiLMAjgCX
         cAiu3JJDg6mrkrnRqq3NNjXgzH7oB5x/KmlilBIq+hSX6yvwhJhHnjK4hAT4vOcChbX8
         BDPA==
X-Gm-Message-State: APjAAAWsmMU8biR0wLaD6mPzxnARx8n12qnW82Wlj/OzlkYiL6oEbCSk
        6wmKCkFspAQSmAirpZCuFXOVFfKEuI5SSyTOgPbM0w==
X-Google-Smtp-Source: APXvYqwd0SY25U4cq3pwuC4ufVW/oZZK/mthsjkNg5Pt9lukryHB6LaDPd57XgXny29wudUpug6IojBLFRTn9swdYmo=
X-Received: by 2002:a02:b18d:: with SMTP id t13mr158882jah.4.1575526583427;
 Wed, 04 Dec 2019 22:16:23 -0800 (PST)
MIME-Version: 1.0
References: <1574817475-22378-2-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1574817475-22378-2-git-send-email-yongqiang.niu@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 5 Dec 2019 14:15:57 +0800
Message-ID: <CAJMQK-iDnOWCYmxcREGschD=sDfU6yKpUu+koP3YDeO3MPCdhQ@mail.gmail.com>
Subject: Re: [v1,1/2] drm/mediatek: Fixup external display black screen issue
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 1:17 AM <yongqiang.niu@mediatek.com> wrote:
>
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
>
> Problem:
> overlay hangup when external display hotplut test
>
> Fix:
> disable overlay when crtc disable
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 39 +++++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 14 deletions(-)
>
> --
> 1.8.1.1.dirty
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> index 4fb346c..7eca02f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -369,6 +369,20 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
>         mtk_disp_mutex_add_comp(mtk_crtc->mutex, mtk_crtc->ddp_comp[i]->id);
>         mtk_disp_mutex_enable(mtk_crtc->mutex);
>
> +       /* Initially configure all planes */
> +       for (i = 0; i < mtk_crtc->layer_nr; i++) {
> +               struct drm_plane *plane = &mtk_crtc->planes[i];
> +               struct mtk_plane_state *plane_state;
> +               struct mtk_ddp_comp *comp;
> +               unsigned int local_layer;
> +
> +               plane_state = to_mtk_plane_state(plane->state);
> +               comp = mtk_drm_ddp_comp_for_plane(crtc, plane, &local_layer);
> +               if (comp)
> +                       mtk_ddp_comp_layer_config(comp, local_layer,
> +                                                 plane_state, NULL);
> +       }
> +
>         for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
>                 struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[i];
>                 enum mtk_ddp_comp_id prev;
> @@ -385,20 +399,6 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
>                 mtk_ddp_comp_start(comp);
>         }
>
> -       /* Initially configure all planes */
> -       for (i = 0; i < mtk_crtc->layer_nr; i++) {
> -               struct drm_plane *plane = &mtk_crtc->planes[i];
> -               struct mtk_plane_state *plane_state;
> -               struct mtk_ddp_comp *comp;
> -               unsigned int local_layer;
> -
> -               plane_state = to_mtk_plane_state(plane->state);
> -               comp = mtk_drm_ddp_comp_for_plane(crtc, plane, &local_layer);
> -               if (comp)
> -                       mtk_ddp_comp_layer_config(comp, local_layer,
> -                                                 plane_state, NULL);
> -       }
> -
>         return 0;
>
>  err_mutex_unprepare:
> @@ -607,10 +607,21 @@ static void mtk_drm_crtc_atomic_disable(struct drm_crtc *crtc,
>         for (i = 0; i < mtk_crtc->layer_nr; i++) {
>                 struct drm_plane *plane = &mtk_crtc->planes[i];
>                 struct mtk_plane_state *plane_state;
> +               struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
> +               unsigned int comp_layer_nr = mtk_ddp_comp_layer_nr(comp);
> +               unsigned int local_layer;
>
>                 plane_state = to_mtk_plane_state(plane->state);
>                 plane_state->pending.enable = false;
>                 plane_state->pending.config = true;
> +
> +               if (i >= comp_layer_nr) {
> +                       comp = mtk_crtc->ddp_comp[1];
> +                       local_layer = i - comp_layer_nr;
> +               } else
> +                       local_layer = i;
> +               mtk_ddp_comp_layer_config(comp, local_layer,
> +                                         plane_state, NULL);
This part should be moved to mtk_crtc_ddp_hw_fini(), or at least
called after drm_crtc_vblank_off(). Otherwise we would see
drm_wait_one_vblank warnings on 8173 when display turns off.

[   25.696182] Call trace:
[   25.698624]  drm_wait_one_vblank+0x1f0/0x1fc
[   25.702886]  drm_crtc_wait_one_vblank+0x20/0x2c
[   25.707415]  mtk_drm_crtc_atomic_disable+0xf0/0x308
[   25.712287]  drm_atomic_helper_commit_modeset_disables+0x1b8/0x3c0
[   25.718461]  mtk_atomic_complete+0x88/0x16c
[   25.722638]  mtk_atomic_commit+0xa8/0xb0
[   25.726553]  drm_atomic_commit+0x50/0x5c
[   25.730469]  drm_atomic_helper_set_config+0x98/0xa0
[   25.735341]  drm_mode_setcrtc+0x280/0x608
[   25.739344]  drm_ioctl_kernel+0xcc/0x10c
[   25.743261]  drm_ioctl+0x240/0x3c0
[   25.746658]  drm_compat_ioctl+0xd8/0xe8
[   25.750487]  __se_compat_sys_ioctl+0x100/0x26fc
[   25.755009]  __arm64_compat_sys_ioctl+0x20/0x2c
[   25.759534]  el0_svc_common+0xa4/0x154
[   25.763277]  el0_svc_compat_handler+0x2c/0x38
[   25.767628]  el0_svc_compat+0x8/0x18
[   25.771195] ---[ end trace f4619fdac8f1c0ff ]---

>
