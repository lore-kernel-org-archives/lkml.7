Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1404FC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4786217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irvfEg+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfHZWfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 18:35:09 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34772 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfHZWfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 18:35:08 -0400
Received: by mail-io1-f68.google.com with SMTP id s21so41524834ioa.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 15:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TR73dOPLV+Pq/EfAvMPvdl9VXPIGVXlmHtutdowbA8w=;
        b=irvfEg+oBy3K9i5ph445YDh5/r39NmczOzUV8ARAEH39xs2pKuazZRoL8IZJP565KB
         GOc/68k8QyEfdgqvdqmMItaEkV1dgxRCAfUZkNHxZkvl/ct2uS7VhGvFTnW+UWomp5u0
         yQobZ63b6IegbwLLQ8bKDU49irtHmXs5q8J8a79OwT1acMhB+JPQ6dNfEHDzIFXG1jQy
         inTQiWt+m2Dw2FoBr1U3SZ/bVEWatEX7vus22wc8y/7MF8Zt1Y65+OpffB5hHZFXZZJL
         mMNcx/fwG3BubuSFgvditqHsYEXMaFQhPXp1TgX0RhrYG40tLkIrSziEej9egv5J833i
         /EYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TR73dOPLV+Pq/EfAvMPvdl9VXPIGVXlmHtutdowbA8w=;
        b=foCgTES4JHeHY6lA/I4t0g3jPwPOE+x1KXTOY6ZXTtLnxSqGFL9tvMs5k3mpH1QOjR
         yVXamiPgOfQhJv3tJhHCGOfKAJarmSrEDOVWNLtgvrv2kJ31M9NjvNhkm1McF6kMU8eO
         L4ZEpDSnKKO1G2lXZ6RnCz3jPMIYRcZYZYPt+3sx2/bk4pAvn1clriAlnJ61zLqs24Zy
         ZGcd2OA+PttPw2QpUBYCTdwtQF3mpSj6vloY2fxOvdEEad/x1I5jbYm/DGYBFeAKXPMk
         xUOvV69c8+5S4tUwP7FT0bmtLxzubaMYHf8jDykOvDi5iX+R/GG622Q8cNw9niUthBSj
         Ir4w==
X-Gm-Message-State: APjAAAW4qm8CEi+vtUeFI4lzRUHK1o00/Yk/SJWYxOLQCA+A57vT2yop
        ORfHQ5xp2Z4NEHbS29bzDO5o9soY4mfwNZYK8B0=
X-Google-Smtp-Source: APXvYqxHblq6gKSwiBmBchpFPLh6rchETDLBs9SBgl/hgzpq8F2KDv3i9uyZVGR4IejBJ9fgI7IYrCeXxX5X4YjwbF4=
X-Received: by 2002:a6b:720e:: with SMTP id n14mr22961192ioc.139.1566858907770;
 Mon, 26 Aug 2019 15:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190822094657.27483-1-kraxel@redhat.com>
In-Reply-To: <20190822094657.27483-1-kraxel@redhat.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Mon, 26 Aug 2019 15:34:56 -0700
Message-ID: <CAPaKu7S_He9RYsxDi0Qco4u=Xnc3FjB5nvFT_Zh+o7pvFzCvRQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/virtio: add plane check
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 2:47 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Use drm_atomic_helper_check_plane_state()
> to sanity check the plane state.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_plane.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
> index a492ac3f4a7e..fe5efb2de90d 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -84,7 +84,22 @@ static const struct drm_plane_funcs virtio_gpu_plane_funcs = {
>  static int virtio_gpu_plane_atomic_check(struct drm_plane *plane,
>                                          struct drm_plane_state *state)
>  {
> -       return 0;
> +       bool is_cursor = plane->type == DRM_PLANE_TYPE_CURSOR;
> +       struct drm_crtc_state *crtc_state;
> +       int ret;
> +
> +       if (!state->fb || !state->crtc)
> +               return 0;
> +
> +       crtc_state = drm_atomic_get_crtc_state(state->state, state->crtc);
> +       if (IS_ERR(crtc_state))
> +                return PTR_ERR(crtc_state);
Is drm_atomic_get_new_crtc_state better here?

> +
> +       ret = drm_atomic_helper_check_plane_state(state, crtc_state,
> +                                                 DRM_PLANE_HELPER_NO_SCALING,
> +                                                 DRM_PLANE_HELPER_NO_SCALING,
> +                                                 is_cursor, true);
> +       return ret;
>  }
>
>  static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
> --
> 2.18.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
