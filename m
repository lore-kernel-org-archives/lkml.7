Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CDFC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA1120815
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="J8FiqaRt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfJHPBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 11:01:02 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34080 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfJHPBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:01:02 -0400
Received: by mail-oi1-f194.google.com with SMTP id 83so15072784oii.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 08:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LbF7WG0VVMrh+RlETkWL6K7152RECJRWyhuVFKyOKT0=;
        b=J8FiqaRtyCslpoOrFvHAyIezrRefCEOaAujpFQLaevw6Wsxbr5fqvNWdAR6rA+BspJ
         1XaSAwkzTEoGSm7UQbl+2omjROnBkPIxoULTIuJdYJUN/bAAu8RtpI2tW8A4Uu6HoW1C
         hGO8puHB4KET0A68pJ89t1zcx0TapdM6QB5O8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LbF7WG0VVMrh+RlETkWL6K7152RECJRWyhuVFKyOKT0=;
        b=e+OUMBtbID6/Ec6FwktIQHIqa+4LKvAY3BGxKhdggZ0srbwSS0/Fl5aOoKBYP2kI1X
         7O3vIQdNto/tsVf0+phukZfzqiJ3ugUyOx24V5ND+gY25CBTwLPkdK5Z3KWdz7O9aOai
         c7SZyB6vaepeCJLfiVxqSoJO6HLx7aM5x2f0ksb4dbvWedATKVS8Ehab0Hg0kEHtxQUd
         4bz6ZBlp9qUgibgRBKZNcpY5oCQZrGR9wcN/hpcgwt5+on5xp+/7DUPtoP4B9Fl/kNX2
         6wmqcIhkT1pQitsd8J1dzKYpYfhbeeMvdTla/cggNSrs2SibCYIOSGj6iN3vICakfsMF
         bdBQ==
X-Gm-Message-State: APjAAAVN7QVdryp5sThbQofdCKx5ZG1XpWMJ01+fKIe0Rv/SBUB4lrAX
        gQlhzIoEWSCLpVucDsVcKOyZi8xAvS1hkyRo7jbO0A==
X-Google-Smtp-Source: APXvYqxePf0H09iiLoL03nM0CZaAHHGXlX0aAhKzg6033m4U8lliHyQj0GcebQFdSka/XeXqF5UcsIiwu/KpYhNDfT8=
X-Received: by 2002:aca:5c45:: with SMTP id q66mr4096587oib.132.1570546857869;
 Tue, 08 Oct 2019 08:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <1558323179-18857-1-git-send-email-lowry.li@arm.com>
In-Reply-To: <1558323179-18857-1-git-send-email-lowry.li@arm.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 8 Oct 2019 17:00:46 +0200
Message-ID: <CAKMK7uEEQUdSHFPP7UoXs9jv2CLiPQBFQv9gsxyVnsSjApFyVQ@mail.gmail.com>
Subject: Re: [PATCH] drm/komeda: Adds zorder support
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
Cc:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 5:33 AM Lowry Li (Arm Technology China)
<Lowry.Li@arm.com> wrote:
>
> - Creates the zpos property.
> - Implement komeda_crtc_normalize_zpos to replace
> drm_atomic_normalize_zpos, reasons as the following:
>
> 1. The drm_atomic_normalize_zpos allows to configure same zpos for
> different planes, but komeda doesn't support such configuration.

Just stumbled over your custom normalized_zpos calculation, and it
looks very fishy. You seem to reinvent the normalized zpos
computation, which has the entire job of resolving duplicated zpos
values (which can happen with legacy kms). So the above is definitely
wrong.

Can you pls do a patch to remove your own code, and replace it with
helper usage? Or at least explain why exactly you can't use the
standard normalized zpos stuff and need your own (since it really
looks like just reinventing the same thing).
-Daniel

> 2. For further slave pipline case, Komeda need to calculate the
> max_slave_zorder, we will merge such calculation into
> komed_crtc_normalize_zpos to save a separated plane_state loop.
> 3. For feature none-scaling layer_split, which a plane_state will be
> assigned to two individual layers(left/right), which requires two
> normalize_zpos for this plane, plane_st->normalize_zpos will be used
> by left layer, normalize_zpos + 1 for right_layer.
>
> This patch series depends on:
> - https://patchwork.freedesktop.org/series/58710/
> - https://patchwork.freedesktop.org/series/59000/
> - https://patchwork.freedesktop.org/series/59002/
> - https://patchwork.freedesktop.org/series/59747/
> - https://patchwork.freedesktop.org/series/59915/
> - https://patchwork.freedesktop.org/series/60083/
> - https://patchwork.freedesktop.org/series/60698/
>
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_kms.c   | 90 ++++++++++++++++++++++-
>  drivers/gpu/drm/arm/display/komeda/komeda_kms.h   |  3 +
>  drivers/gpu/drm/arm/display/komeda/komeda_plane.c |  6 +-
>  3 files changed, 97 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> index 306ea06..0ec7665 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> @@ -100,6 +100,90 @@ static void komeda_kms_commit_tail(struct drm_atomic_state *old_state)
>         .atomic_commit_tail = komeda_kms_commit_tail,
>  };
>
> +static int komeda_plane_state_list_add(struct drm_plane_state *plane_st,
> +                                      struct list_head *zorder_list)
> +{
> +       struct komeda_plane_state *new = to_kplane_st(plane_st);
> +       struct komeda_plane_state *node, *last;
> +
> +       last = list_empty(zorder_list) ?
> +              NULL : list_last_entry(zorder_list, typeof(*last), zlist_node);
> +
> +       /* Considering the list sequence is zpos increasing, so if list is empty
> +        * or the zpos of new node bigger than the last node in list, no need
> +        * loop and just insert the new one to the tail of the list.
> +        */
> +       if (!last || (new->base.zpos > last->base.zpos)) {
> +               list_add_tail(&new->zlist_node, zorder_list);
> +               return 0;
> +       }
> +
> +       /* Build the list by zpos increasing */
> +       list_for_each_entry(node, zorder_list, zlist_node) {
> +               if (new->base.zpos < node->base.zpos) {
> +                       list_add_tail(&new->zlist_node, &node->zlist_node);
> +                       break;
> +               } else if (node->base.zpos == new->base.zpos) {
> +                       struct drm_plane *a = node->base.plane;
> +                       struct drm_plane *b = new->base.plane;
> +
> +                       /* Komeda doesn't support setting a same zpos for
> +                        * different planes.
> +                        */
> +                       DRM_DEBUG_ATOMIC("PLANE: %s and PLANE: %s are configured same zpos: %d.\n",
> +                                        a->name, b->name, node->base.zpos);
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static int komeda_crtc_normalize_zpos(struct drm_crtc *crtc,
> +                                     struct drm_crtc_state *crtc_st)
> +{
> +       struct drm_atomic_state *state = crtc_st->state;
> +       struct komeda_plane_state *kplane_st;
> +       struct drm_plane_state *plane_st;
> +       struct drm_framebuffer *fb;
> +       struct drm_plane *plane;
> +       struct list_head zorder_list;
> +       int order = 0, err;
> +
> +       DRM_DEBUG_ATOMIC("[CRTC:%d:%s] calculating normalized zpos values\n",
> +                        crtc->base.id, crtc->name);
> +
> +       INIT_LIST_HEAD(&zorder_list);
> +
> +       /* This loop also added all effected planes into the new state */
> +       drm_for_each_plane_mask(plane, crtc->dev, crtc_st->plane_mask) {
> +               plane_st = drm_atomic_get_plane_state(state, plane);
> +               if (IS_ERR(plane_st))
> +                       return PTR_ERR(plane_st);
> +
> +               /* Build a list by zpos increasing */
> +               err = komeda_plane_state_list_add(plane_st, &zorder_list);
> +               if (err)
> +                       return err;
> +       }
> +
> +       list_for_each_entry(kplane_st, &zorder_list, zlist_node) {
> +               plane_st = &kplane_st->base;
> +               fb = plane_st->fb;
> +               plane = plane_st->plane;
> +
> +               plane_st->normalized_zpos = order++;
> +
> +               DRM_DEBUG_ATOMIC("[PLANE:%d:%s] zpos:%d, normalized zpos: %d\n",
> +                                plane->base.id, plane->name,
> +                                plane_st->zpos, plane_st->normalized_zpos);
> +       }
> +
> +       crtc_st->zpos_changed = true;
> +
> +       return 0;
> +}
> +
>  static int komeda_kms_check(struct drm_device *dev,
>                             struct drm_atomic_state *state)
>  {
> @@ -111,7 +195,7 @@ static int komeda_kms_check(struct drm_device *dev,
>         if (err)
>                 return err;
>
> -       /* komeda need to re-calculate resource assumption in every commit
> +       /* Komeda need to re-calculate resource assumption in every commit
>          * so need to add all affected_planes (even unchanged) to
>          * drm_atomic_state.
>          */
> @@ -119,6 +203,10 @@ static int komeda_kms_check(struct drm_device *dev,
>                 err = drm_atomic_add_affected_planes(state, crtc);
>                 if (err)
>                         return err;
> +
> +               err = komeda_crtc_normalize_zpos(crtc, new_crtc_st);
> +               if (err)
> +                       return err;
>         }
>
>         err = drm_atomic_helper_check_planes(dev, state);
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> index 178bee6..d1cef46 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> @@ -7,6 +7,7 @@
>  #ifndef _KOMEDA_KMS_H_
>  #define _KOMEDA_KMS_H_
>
> +#include <linux/list.h>
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_crtc_helper.h>
> @@ -46,6 +47,8 @@ struct komeda_plane {
>  struct komeda_plane_state {
>         /** @base: &drm_plane_state */
>         struct drm_plane_state base;
> +       /** @zlist_node: zorder list node */
> +       struct list_head zlist_node;
>
>         /* @img_enhancement: on/off image enhancement */
>         u8 img_enhancement : 1;
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> index bcf30a7..aad7663 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> @@ -21,7 +21,7 @@
>
>         memset(dflow, 0, sizeof(*dflow));
>
> -       dflow->blending_zorder = st->zpos;
> +       dflow->blending_zorder = st->normalized_zpos;
>
>         /* if format doesn't have alpha, fix blend mode to PIXEL_NONE */
>         dflow->pixel_blend_mode = fb->format->has_alpha ?
> @@ -343,6 +343,10 @@ static int komeda_plane_add(struct komeda_kms_dev *kms,
>         if (err)
>                 goto cleanup;
>
> +       err = drm_plane_create_zpos_property(plane, layer->base.id, 0, 8);
> +       if (err)
> +               goto cleanup;
> +
>         return 0;
>  cleanup:
>         komeda_plane_destroy(plane);
> --
> 1.9.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
