Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B0EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 03:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76ED9217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 03:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ltDHoa7q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfCMDnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 23:43:02 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:45387 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbfCMDnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 23:43:01 -0400
Received: by mail-vk1-f196.google.com with SMTP id v187so132304vkf.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 20:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H0dIcw6m1Pzr0Ps1GAlM43xbFMS3sCb4y/K1DlTFxi4=;
        b=ltDHoa7qX/+p2IbyixR+qVL8X/IQ5+LXGIEF7HHMo6Zz/2CRXlG1orsfb4AVbh+E96
         JxQYs7ZAzwWzmKWjmpoPPT7TqC9D/EydtrF00rpPjYQXNhinOg3hI2eMCaRHmp+ARDq2
         ilu+vIqgk1etAFlwHihsw4fGkiaLwNUcuDXpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H0dIcw6m1Pzr0Ps1GAlM43xbFMS3sCb4y/K1DlTFxi4=;
        b=eb81H0GkK4wsTtIGh6+NtXrbZiZ8/RxmfQ1N69uSROZGIkkJf33EE1pTKQuxUEPHYw
         5VSkwnJFBOK5uhKLoV1KUgMalZiGPGAdbCVnGct7QZbYjyKOGcpRWTQw3joRFFLEitzM
         M+iqwSiSQlbFiN8Vke2qYLSKnwj08Zd8FbDgCAtAGv6uZ9YMgzEqR74tyPsiM/tSqeXC
         z0MXJ8lBtQQIvN+f2CfhX/ImL1NHecjfS5G90JD7WRaJ9+bcYlCqI3WY1105gfLBcXs7
         XUk0r8dC+Jlrr+jMd5Rmugnb2cpmNWHxyMatwFHdcpyXkcZC+e8gCJ09UyV+0+qoe8MV
         0JuQ==
X-Gm-Message-State: APjAAAWi3be+AlliiPV8ZtNqcpV9QJWS9LhHg7eeUtWgfjzzxgb1e9L/
        tR4Uy+Dz3Hb49maa8pVQ0LUYQeLNVfc=
X-Google-Smtp-Source: APXvYqwPDT/1oTY2llVg/4dhBaGPXUzvtiG8Ue+QIrQNRC0St2Z+ZayLCVyA+/k1FwQU6mreifoUjg==
X-Received: by 2002:a1f:a0d7:: with SMTP id j206mr21466165vke.37.1552448579951;
        Tue, 12 Mar 2019 20:42:59 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id l12sm65909uao.15.2019.03.12.20.42.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 20:42:57 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id c189so191491vsd.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 20:42:56 -0700 (PDT)
X-Received: by 2002:a67:f744:: with SMTP id w4mr22501451vso.16.1552448576321;
 Tue, 12 Mar 2019 20:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190312022204.2775-1-helen.koike@collabora.com>
 <20190312022204.2775-2-helen.koike@collabora.com> <20190312073438.05ad8173@collabora.com>
 <f888a2d0-c6b1-8995-7254-ba2923dd22f9@collabora.com> <20190312165243.5b771e4a@collabora.com>
In-Reply-To: <20190312165243.5b771e4a@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 13 Mar 2019 12:42:45 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CCEDaxLbw0E9NJJ-tEcHd8-Lidvcvt8qfPAnKu7uuj8w@mail.gmail.com>
Message-ID: <CAAFQd5CCEDaxLbw0E9NJJ-tEcHd8-Lidvcvt8qfPAnKu7uuj8w@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] drm/rockchip: fix fb references in async update
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Helen Koike <helen.koike@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nicholas.kazlauskas@amd.com, andrey.grodzovsky@amd.com,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@google.com>, kernel@collabora.com,
        harry.wentland@amd.com,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@google.com>,
        Sandy Huang <hjc@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 12:52 AM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Tue, 12 Mar 2019 12:34:45 -0300
> Helen Koike <helen.koike@collabora.com> wrote:
>
> > On 3/12/19 3:34 AM, Boris Brezillon wrote:
> > > On Mon, 11 Mar 2019 23:21:59 -0300
> > > Helen Koike <helen.koike@collabora.com> wrote:
> > >
> > >> In the case of async update, modifications are done in place, i.e. in the
> > >> current plane state, so the new_state is prepared and the new_state is
> > >> cleanup up (instead of the old_state, diferrently on what happen in a
> > >
> > >   ^ cleaned up                              ^ differently (but maybe
> > > "unlike what happens" is more appropriate here).
> > >
> > >> normal sync update).
> > >> To cleanup the old_fb properly, it needs to be placed in the new_state
> > >> in the end of async_update, so cleanup call will unreference the old_fb
> > >> correctly.
> > >>
> > >> Also, the previous code had a:
> > >>
> > >>    plane_state = plane->funcs->atomic_duplicate_state(plane);
> > >>    ...
> > >>    swap(plane_state, plane->state);
> > >>
> > >>    if (plane->state->fb && plane->state->fb != new_state->fb) {
> > >>    ...
> > >>    }
> > >>
> > >> Which was wrong, as the fb were just assigned to be equal, so this if
> > >> statement nevers evaluates to true.
> > >>
> > >> Another details is that the function drm_crtc_vblank_get() can only be
> > >> called when vop->is_enabled is true, otherwise it has no effect and
> > >> trows a WARN_ON().
> > >>
> > >> Calling drm_atomic_set_fb_for_plane() (which get a referent of the new
> > >> fb and pus the old fb) is not required, as it is taken care by
> > >> drm_mode_cursor_universal() when calling
> > >> drm_atomic_helper_update_plane().
> > >>
> > >> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> > >>
> > >> ---
> > >> Hello,
> > >>
> > >> I tested on the rockchip ficus v1.1 using igt plane_cursor_legacy and
> > >> kms_cursor_legacy and I didn't see any regressions.
> > >>
> > >> Changes in v2: None
> > >>
> > >>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 42 ++++++++++++---------
> > >>  1 file changed, 24 insertions(+), 18 deletions(-)
> > >>
> > >> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > >> index c7d4c6073ea5..a1ee8c156a7b 100644
> > >> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > >> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > >> @@ -912,30 +912,31 @@ static void vop_plane_atomic_async_update(struct drm_plane *plane,
> > >>                                      struct drm_plane_state *new_state)
> > >>  {
> > >>    struct vop *vop = to_vop(plane->state->crtc);
> > >> -  struct drm_plane_state *plane_state;
> > >> +  struct drm_framebuffer *old_fb = plane->state->fb;
> > >>
> > >> -  plane_state = plane->funcs->atomic_duplicate_state(plane);
> > >> -  plane_state->crtc_x = new_state->crtc_x;
> > >> -  plane_state->crtc_y = new_state->crtc_y;
> > >> -  plane_state->crtc_h = new_state->crtc_h;
> > >> -  plane_state->crtc_w = new_state->crtc_w;
> > >> -  plane_state->src_x = new_state->src_x;
> > >> -  plane_state->src_y = new_state->src_y;
> > >> -  plane_state->src_h = new_state->src_h;
> > >> -  plane_state->src_w = new_state->src_w;
> > >> -
> > >> -  if (plane_state->fb != new_state->fb)
> > >> -          drm_atomic_set_fb_for_plane(plane_state, new_state->fb);
> > >> -
> > >> -  swap(plane_state, plane->state);
> > >> -
> > >> -  if (plane->state->fb && plane->state->fb != new_state->fb) {
> > >> +  /*
> > >> +   * A scanout can still be occurring, so we can't drop the reference to
> > >> +   * the old framebuffer. To solve this we get a reference to old_fb and
> > >> +   * set a worker to release it later.
> > >
> > > Hm, doesn't look like an async update to me if we have to wait for the
> > > next VBLANK to happen to get the new content on the screen. Maybe we
> > > should reject async updates when old_fb != new_fb in the rk
> > > ->async_check() hook.
> >
> > Unless I am misunderstanding this, we don't wait here, we just grab a
> > reference to the fb in case it is being still used by the hw, so it
> > doesn't get released prematurely.
>
> I was just reacting to the comment that says the new FB should stay
> around until the next VBLANK event happens. If the FB must stay around
> that probably means the HW is still using, which made me wonder if this
> HW actually supports async update (where async means "update now and
> don't care about about tearing"). Or maybe it takes some time to switch
> to the new FB and waiting for the next VBLANK to release the old FB was
> an easy solution to not wait for the flip to actually happen in
> ->async_update() (which is kind of a combination of async+non-blocking).

The hardware switches framebuffers on vblank, so whatever framebuffer
is currently being scanned out from needs to stay there until the
hardware switches to the new one in shadow registers. If that doesn't
happen, you get IOMMU faults and the display controller stops working
since we don't have any fault handling currently, just printing a
message.

Best regards,
Tomasz
