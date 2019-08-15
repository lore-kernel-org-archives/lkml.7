Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6C4C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 18:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F732063F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 18:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="WCp1BUIZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731841AbfHOS0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 14:26:25 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33082 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729855AbfHOS0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 14:26:24 -0400
Received: by mail-oi1-f195.google.com with SMTP id u15so2963577oiv.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 11:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s0YEdeAxiTGGwe/Hiw2GkO06bUsVvGwdq+cB36lO/84=;
        b=WCp1BUIZCxKpAjL0kW5IU+SXYCf33DLA7lvCI2GV7PNy/OQnZ7KzW6WtrmXyprZ8dF
         tF0y47JyMBhKynaoaOuCAfpws6I8yULRcvMtaEGzPa/e454G3S6VQgcgy2gA3KU/7Rwm
         nUoDURvu+vUQgKx3ta9nlJJy+RUWn9+4h3fdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s0YEdeAxiTGGwe/Hiw2GkO06bUsVvGwdq+cB36lO/84=;
        b=dRre8cyDYLI92JUTD9bIEJOsExMtehIszfWLWbNdHuDDOpVlL6ZDuyBK2QWBmJpurU
         /dR3F6RUOrIb3V+lIqL7ggCBQZBbz2eZUw2pmrSOIy/qbYcVBGrXiJAvGR9+IIaXylsh
         GYNBIXaYNfDB9pgA/r95iStuP1B20S6PgQMSGlfekJAB9ClayRAMfPUxIrDDgEYngLur
         yeC5aXEcSQLBzjuqf2oELo74ZJpAPUQhuAdFDEyusKTDfxqJ+Ij9dJ2rXbnIg88l3czB
         V/VEm/ecVujUPWC79fmpz7DcwpV66VM8A9hfeHWNQtAC6+mr9/fqQClEtNhSSvdfSzhQ
         MzUQ==
X-Gm-Message-State: APjAAAUGmMU/Q4V3ugcROw1byGrXDSe6PeO79sDffTKtsmXu7LhQ63C5
        nOHs1E/iPdOIJ13bRdBc9A9GIjCyCISNIVTdU/k1qQ==
X-Google-Smtp-Source: APXvYqxtPdgNI25jjs/0j/zAlSwjU9ER3m+Tcsqgn9juD6honwZEGNCtxPS1hkcNYHf/hRSjbiLxHniAoTzubjLs04o=
X-Received: by 2002:aca:b104:: with SMTP id a4mr2593919oif.14.1565893583115;
 Thu, 15 Aug 2019 11:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190815180322.25600-1-lyude@redhat.com>
In-Reply-To: <20190815180322.25600-1-lyude@redhat.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 15 Aug 2019 20:26:11 +0200
Message-ID: <CAKMK7uENUtrcAhZ=4xzkN-ri7sNzfwzQL=-Vic1rxr=Y38+DhQ@mail.gmail.com>
Subject: Re: [RFC] drm: Bump encoder limit from 32 to 64
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Nouveau Dev <nouveau@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 8:03 PM Lyude Paul <lyude@redhat.com> wrote:
>
> Assuming that GPUs would never have even close to 32 separate video
> encoders is quite honestly a pretty reasonable assumption. Unfortunately
> we do not live in a reasonable world, as it looks like it is actually
> possible to find devices that will create more drm_encoder objects then
> this. Case in point: the ThinkPad P71's discrete GPU, which exposes 1
> eDP port and 5 DP ports. On the P71, nouveau attempts to create one
> encoder for the eDP port, and two encoders for each DP++/USB-C port
> along with 4 MST encoders for each DP port. This comes out to 35
> different encoders. Unfortunately, this can't really be optimized to
> make less encoders either.
>
> So, what if we bumped the limit to 64? Unfortunately this has one very
> awkward drawback: we already expose 32-bit bitmasks for encoders to
> userspace in drm_encoder->possible_clones. Yikes. Luckily for us
> however, the year is 2019 and modern hardware that supports cloning is
> basically non-existent.
>
> So, let's try to compromise here: allow encoders with indexes <32 to
> have non-zero values in drm_encoder->possible_clones, and don't allow
> encoders with higher indexes to set drm_encoder->possible_clones to a
> non-zero value. This allows us to avoid breaking UAPI, while still being
> able to bump up the encoder limit.
>
> This also fixes driver probing for nouveau on the ThinkPad P71.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: nouveau@lists.freedesktop.org

We should never have exposed encoders, that was such a mistake ...

Does nouveau really still use encoders as datastructures internally
for modeset? Otherwise could we perhaps just expose a set of fake
encoders (one per connector) and give up on all these tricks?

Maybe even as a drm level generic thing, i.e. at drm_register_time we
check whether there's any encoders with ->possible_clones set (the
only real information in an encoder, and fairly useless on modern hw
like you point out). And if that's the case we hide all the "real"
encoders from userspace and put up a pile of fake ones. Which do
nothing else than keep userspace happy. Thoughts?

> ---
>  drivers/gpu/drm/drm_atomic.c  |  2 +-
>  drivers/gpu/drm/drm_encoder.c | 10 ++++++++--
>  include/drm/drm_crtc.h        |  2 +-
>  include/drm/drm_encoder.h     | 20 +++++++++++++++-----
>  4 files changed, 25 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 419381abbdd1..27ce988ef0cc 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -392,7 +392,7 @@ static void drm_atomic_crtc_print_state(struct drm_printer *p,
>         drm_printf(p, "\tcolor_mgmt_changed=%d\n", state->color_mgmt_changed);
>         drm_printf(p, "\tplane_mask=%x\n", state->plane_mask);
>         drm_printf(p, "\tconnector_mask=%x\n", state->connector_mask);
> -       drm_printf(p, "\tencoder_mask=%x\n", state->encoder_mask);
> +       drm_printf(p, "\tencoder_mask=%llx\n", state->encoder_mask);
>         drm_printf(p, "\tmode: " DRM_MODE_FMT "\n", DRM_MODE_ARG(&state->mode));
>
>         if (crtc->funcs->atomic_print_state)
> diff --git a/drivers/gpu/drm/drm_encoder.c b/drivers/gpu/drm/drm_encoder.c
> index 7fb47b7b8b44..e4b8f675aa81 100644
> --- a/drivers/gpu/drm/drm_encoder.c
> +++ b/drivers/gpu/drm/drm_encoder.c
> @@ -112,8 +112,14 @@ int drm_encoder_init(struct drm_device *dev,
>  {
>         int ret;
>
> -       /* encoder index is used with 32bit bitmasks */
> -       if (WARN_ON(dev->mode_config.num_encoder >= 32))
> +       /*
> +        * Since possible_clones has been exposed to userspace as a 32bit
> +        * bitmask, we don't allow creating encoders with an index >=32 which
> +        * are capable of cloning.
> +        */
> +       if (WARN_ON(dev->mode_config.num_encoder >= 64) ||
> +           WARN_ON(dev->mode_config.num_encoder >= 32 &&
> +                   encoder->possible_clones))

This is too early, drivers are free to change ->possible_clones later
on. We've have to recheck that at drm_dev_register() time I think.
-Daniel

>                 return -EINVAL;
>
>         ret = drm_mode_object_add(dev, &encoder->base, DRM_MODE_OBJECT_ENCODER);
> diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
> index 7d14c11bdc0a..fd0b2438c3d5 100644
> --- a/include/drm/drm_crtc.h
> +++ b/include/drm/drm_crtc.h
> @@ -210,7 +210,7 @@ struct drm_crtc_state {
>          * @encoder_mask: Bitmask of drm_encoder_mask(encoder) of encoders
>          * attached to this CRTC.
>          */
> -       u32 encoder_mask;
> +       u64 encoder_mask;
>
>         /**
>          * @adjusted_mode:
> diff --git a/include/drm/drm_encoder.h b/include/drm/drm_encoder.h
> index 70cfca03d812..3f9cb65694e1 100644
> --- a/include/drm/drm_encoder.h
> +++ b/include/drm/drm_encoder.h
> @@ -159,7 +159,15 @@ struct drm_encoder {
>          * encoders can be used in a cloned configuration, they both should have
>          * each another bits set.
>          *
> -        * In reality almost every driver gets this wrong.
> +        * In reality almost every driver gets this wrong, and most modern
> +        * display hardware does not have support for cloning. As well, while we
> +        * expose this mask to userspace as 32bits long, we do sure purely to
> +        * avoid breaking pre-existing UAPI since the limitation on the number
> +        * of encoders has been increased from 32 bits to 64 bits. In order to
> +        * maintain functionality for drivers which do actually support cloning,
> +        * we only allow cloning with encoders that have an index <32. Encoders
> +        * with indexes higher than 32 are not allowed to specify a non-zero
> +        * value here.
>          *
>          * Note that since encoder objects can't be hotplugged the assigned indices
>          * are stable and hence known before registering all objects.
> @@ -198,13 +206,15 @@ static inline unsigned int drm_encoder_index(const struct drm_encoder *encoder)
>  }
>
>  /**
> - * drm_encoder_mask - find the mask of a registered ENCODER
> + * drm_encoder_mask - find the mask of a registered encoder
>   * @encoder: encoder to find mask for
>   *
> - * Given a registered encoder, return the mask bit of that encoder for an
> - * encoder's possible_clones field.
> + * Returns:
> + * A bit mask with the nth bit set, where n is the index of the encoder. Take
> + * care when using this, as the DRM UAPI only allows for 32 bit encoder masks
> + * while internally encoder masks are 64 bits.
>   */
> -static inline u32 drm_encoder_mask(const struct drm_encoder *encoder)
> +static inline u64 drm_encoder_mask(const struct drm_encoder *encoder)
>  {
>         return 1 << drm_encoder_index(encoder);
>  }
> --
> 2.21.0
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
