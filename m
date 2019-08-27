Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC0AC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 05:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC472173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 05:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbfH0FV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 01:21:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44994 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfH0FV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 01:21:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4601D3082E25;
        Tue, 27 Aug 2019 05:21:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-95.ams2.redhat.com [10.36.116.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C750E1E0;
        Tue, 27 Aug 2019 05:21:55 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 223D01747D; Tue, 27 Aug 2019 07:21:54 +0200 (CEST)
Date:   Tue, 27 Aug 2019 07:21:54 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Chia-I Wu <olvaffe@gmail.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v2] drm/virtio: add plane check
Message-ID: <20190827052154.etk4jbx45hsrl7z5@sirius.home.kraxel.org>
References: <20190822094657.27483-1-kraxel@redhat.com>
 <CAPaKu7S_He9RYsxDi0Qco4u=Xnc3FjB5nvFT_Zh+o7pvFzCvRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPaKu7S_He9RYsxDi0Qco4u=Xnc3FjB5nvFT_Zh+o7pvFzCvRQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 27 Aug 2019 05:21:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 03:34:56PM -0700, Chia-I Wu wrote:
> On Thu, Aug 22, 2019 at 2:47 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > Use drm_atomic_helper_check_plane_state()
> > to sanity check the plane state.
> >
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  drivers/gpu/drm/virtio/virtgpu_plane.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
> > index a492ac3f4a7e..fe5efb2de90d 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> > @@ -84,7 +84,22 @@ static const struct drm_plane_funcs virtio_gpu_plane_funcs = {
> >  static int virtio_gpu_plane_atomic_check(struct drm_plane *plane,
> >                                          struct drm_plane_state *state)
> >  {
> > -       return 0;
> > +       bool is_cursor = plane->type == DRM_PLANE_TYPE_CURSOR;
> > +       struct drm_crtc_state *crtc_state;
> > +       int ret;
> > +
> > +       if (!state->fb || !state->crtc)
> > +               return 0;
> > +
> > +       crtc_state = drm_atomic_get_crtc_state(state->state, state->crtc);
> > +       if (IS_ERR(crtc_state))
> > +                return PTR_ERR(crtc_state);
> Is drm_atomic_get_new_crtc_state better here?

We don't have to worry about old/new state here.  The drm_plane_state we
get passed is the state we should check in this callback (and I think
this always is the new state).

cheers,
  Gerd

