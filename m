Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40288C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A3421881
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3nYAYtY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbfH0QmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:42:22 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46857 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfH0QmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:42:22 -0400
Received: by mail-io1-f66.google.com with SMTP id x4so47675611iog.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 09:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t4/d9H3zPkehGO8WMS+e05TTbEwolWCKrpo3GXlSVME=;
        b=E3nYAYtY8RBL7TmxP9S3fiLiAcsYg7WuNXOm+m9k8DduShri7h2su9ajoHi6oUGylN
         VZIfblgWGCzQwUbLfLOAbAZ4WRgIKwjB8AwkAPXJjXnj4SmfatFc0doTITMXScMYrK3s
         GyObWXB0qMDySutmj+YtBFWw27p9DjDkKoc7Z18/owXeKbazPgV0WP9DyUiJTp9pbWfW
         J7hGi47WdgAmeXKYkaMX0TOMT9VnJxUvsxgSnCJIJayVgzulry+kv4gNdCLD8k5FQ66O
         g2lcR7zSBGJc9xwMA2txLnLfLWLXIgZv3D4x6kPkxEFxuOwpNzUUQ8Ju687Z7TVcMUE9
         ZGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t4/d9H3zPkehGO8WMS+e05TTbEwolWCKrpo3GXlSVME=;
        b=gbrfD7eqfmzaYmJItGSo+J3uZ6wMFDcXC7eRsV+HzE0kH96kqYBhUyuCEK++yun9pE
         maLZM+yl6nL5B8fw/8GoOIXEVMeC4Z/t/JkXPVyRpC8Dg6xsrnU1CL4heWWbeQDT90O3
         D0l/C5tFwl4etx/SKN5FggQFbiscnxnfZ8eoM+vvsBogEgYS/FOgtoVa1p269k/xjYnp
         GCj6ObeRjioJvOiMhEhnRmmkuRKfcHAvv4J9odE7aEKakGYJJiUDf076c+I+IVEuva0x
         5Hl90ZTI8OEsKSgZfeKb2eJX2S2VNVZq4c6uEoJ5PulOjxcpr4fClH57aztEcyIX3piw
         tRqA==
X-Gm-Message-State: APjAAAWHdVxV3vOsPnyNaFWYgdsbFSpCcTyyc2COUrCtDmHZGVOlI7TT
        OhX81Ughnbv6z2Aotv4CTmiaOE62vENMlCBWQ1k=
X-Google-Smtp-Source: APXvYqyi2cOM6Eact6tIpG5HHBBQxrZq1Jezmt2L9lMrVOzSsV6IBQEOwioAbt80b/i/IBxMdWxMaXHUhAJQ4n/kxBg=
X-Received: by 2002:a6b:720e:: with SMTP id n14mr28333793ioc.139.1566924141570;
 Tue, 27 Aug 2019 09:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190822094657.27483-1-kraxel@redhat.com> <CAPaKu7S_He9RYsxDi0Qco4u=Xnc3FjB5nvFT_Zh+o7pvFzCvRQ@mail.gmail.com>
 <20190827052154.etk4jbx45hsrl7z5@sirius.home.kraxel.org>
In-Reply-To: <20190827052154.etk4jbx45hsrl7z5@sirius.home.kraxel.org>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Tue, 27 Aug 2019 09:42:10 -0700
Message-ID: <CAPaKu7TrPvsiy2EyC4a_tOyi7oAV-Npk+2fqkZwNUfjwNE3AeA@mail.gmail.com>
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

On Mon, Aug 26, 2019 at 10:21 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Mon, Aug 26, 2019 at 03:34:56PM -0700, Chia-I Wu wrote:
> > On Thu, Aug 22, 2019 at 2:47 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >
> > > Use drm_atomic_helper_check_plane_state()
> > > to sanity check the plane state.
> > >
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > > ---
> > >  drivers/gpu/drm/virtio/virtgpu_plane.c | 17 ++++++++++++++++-
> > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
> > > index a492ac3f4a7e..fe5efb2de90d 100644
> > > --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> > > +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> > > @@ -84,7 +84,22 @@ static const struct drm_plane_funcs virtio_gpu_plane_funcs = {
> > >  static int virtio_gpu_plane_atomic_check(struct drm_plane *plane,
> > >                                          struct drm_plane_state *state)
> > >  {
> > > -       return 0;
> > > +       bool is_cursor = plane->type == DRM_PLANE_TYPE_CURSOR;
> > > +       struct drm_crtc_state *crtc_state;
> > > +       int ret;
> > > +
> > > +       if (!state->fb || !state->crtc)
> > > +               return 0;
> > > +
> > > +       crtc_state = drm_atomic_get_crtc_state(state->state, state->crtc);
> > > +       if (IS_ERR(crtc_state))
> > > +                return PTR_ERR(crtc_state);
> > Is drm_atomic_get_new_crtc_state better here?
>
> We don't have to worry about old/new state here.  The drm_plane_state we
> get passed is the state we should check in this callback (and I think
> this always is the new state).
Acked-by: Chia-I Wu <olvaffe@gmail.com> (because I am not familiar
with the atomic code to give an r-b)

>
> cheers,
>   Gerd
>
