Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE814C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B3120679
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGN+yW1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfKLQ1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 11:27:14 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:47060 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfKLQ1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 11:27:14 -0500
Received: by mail-ed1-f65.google.com with SMTP id x11so15384624eds.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 08:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=duBtqUXc8rS5Fto0xoNFGu4k3wWR32DazDGPa4wc8r0=;
        b=UGN+yW1uKArcfiPDGUR7JGTEVHREcKqQbWqUSkRxU1GrUhZB5cGXeRCXVjD3/Q5e59
         XuXfb2XE9UwxG2Ysdos+EcxrPZXhM6aYkgUyn+k9lRVGZp6trly1plzCltnHTWb+ZaW1
         wICzhsh7+7cRRZ+7E2OWbFqeRvYG2+84u0OKbWpe1QPCypBqQcrTkMAszx3RmtfH/uZh
         depjBrbDsnchHYg+L69SZbZKQACZCEJx826T54Z4EoYGOXDm1pfcuB6IxGwqXF8fv24r
         L7Kda7MuD3e6leDlULl/qPRpahNiVA5srAHHNaj8KrwwWMtANezX0/ixJcKjDnHPsPx/
         08Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=duBtqUXc8rS5Fto0xoNFGu4k3wWR32DazDGPa4wc8r0=;
        b=JiQzCSDk9hp5zNOdBTPbChJZI59wBCGI4tS4sa3W7akkAU77erLfVNa4L8X63VUJn3
         4YwxPrO8jJfB3abwePy7pKN1nnBw14ZDF6YC8NTaMRSmOUGvWtfYMrYbJiOxQHarG18Q
         Q0vV2OEkmXi6jL2I5tP0uL8G1SHoNbsxggSjMzZaF5YejxZj4HimolNZQuE197CbFCJC
         3MVon4ehj/B+1sIZJq4ynwtGw7pzszbao+s1JeMkjDiEE9xEyNqq+1AEkKIa1/DqxkJu
         Q8GJzSGElFqSmZSZ9gLkN46JTUuQGj+NbbJpSqA9BsxiEdDBC7pIzGafyGNwyYb1m3fo
         yeVA==
X-Gm-Message-State: APjAAAW4xX66gT0yweOH7HZs8AHthXZ4ERzEOggWG8apX/LNXpkHKPhD
        AcvPRy9JIEUzquumrsI4EKYJv64a9R3sfFcATHA=
X-Google-Smtp-Source: APXvYqwINa/wmWIHF2PahNuybTm0H/AGNDuYZehBOWPhVnP8qdvcHhBoYwLBn/HIa7MeIIyGWfDqGK+cDtagO+MOR4g=
X-Received: by 2002:a17:906:f209:: with SMTP id gt9mr28706102ejb.241.1573576031902;
 Tue, 12 Nov 2019 08:27:11 -0800 (PST)
MIME-Version: 1.0
References: <20191104173737.142558-1-robdclark@gmail.com> <20191104173737.142558-2-robdclark@gmail.com>
 <CAFqH_52nFGmG-sMb03ByGSJGckT1D_TKWuy1DpkJt2usxHWHpA@mail.gmail.com>
In-Reply-To: <CAFqH_52nFGmG-sMb03ByGSJGckT1D_TKWuy1DpkJt2usxHWHpA@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 12 Nov 2019 08:27:00 -0800
Message-ID: <CAF6AEGtSacLafw3VmNfXMZBM=RCik8bu9XeUYcd0jOqivaN5eg@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] drm/atomic: clear new_state pointers at hw_done
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Sean Paul <seanpaul@chromium.org>, Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 7:51 AM Enric Balletbo Serra
<eballetbo@gmail.com> wrote:
>
> Hi Rob,
>
> Missatge de Rob Clark <robdclark@gmail.com> del dia dl., 4 de nov.
> 2019 a les 18:42:
> >
> > From: Rob Clark <robdclark@chromium.org>
> >
> > The new state should not be accessed after this point.  Clear the
> > pointers to make that explicit.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
>
> While looking to another issue I applied this patch on top of 5.4-rc7
> and my display stopped working. The system gets stuck with the
> messages below
>
> ...
> [   17.558689] rockchip-vop ff8f0000.vop: Adding to iommu group 1
> [   17.566014] rk3399-gru-sound sound: ASoC: failed to init link DP: -517
> [   17.567618] rockchip-vop ff900000.vop: Adding to iommu group 2
> [   17.580671] rk3399-gru-sound sound: ASoC: failed to init link DP: -517
> [   17.585996] rockchip-drm display-subsystem: bound ff8f0000.vop (ops
> vop_component_ops [rockchipdrm])
> [   17.589294] rk3399-gru-sound sound: ASoC: failed to init link DP: -517
> [   17.599899] rockchip-drm display-subsystem: bound ff900000.vop (ops
> vop_component_ops [rockchipdrm])
> [   17.615846] rockchip-dp ff970000.edp: no DP phy configured
> [   17.622495] rockchip-drm display-subsystem: bound ff970000.edp (ops
> rockchip_dp_component_ops [rockchipdrm])
> [   17.633688] rockchip-drm display-subsystem: bound fec00000.dp (ops
> cdn_dp_component_ops [rockchipdrm])
> [   17.644141] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [   17.651548] [drm] No driver support for vblank timestamp query.
>
> Not really useful information at this point, but I am wondering if
> could be that the rockchip driver is doing something wrong more than
> this patch is wrong?

I think we should drop this patch (but 1/2 is defn needed).. it turns
up some other problems in qemu, it seems.  So there is kind of a
bigger problem of things accessing new state after hw_done still.  But
I've not really had time to look into it.

BR,
-R

>
> Thanks,
>  Enric
>
> > ---
> >  drivers/gpu/drm/drm_atomic_helper.c | 30 +++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> > index 648494c813e5..aec9759d9df2 100644
> > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > @@ -2246,12 +2246,42 @@ EXPORT_SYMBOL(drm_atomic_helper_fake_vblank);
> >   */
> >  void drm_atomic_helper_commit_hw_done(struct drm_atomic_state *old_state)
> >  {
> > +       struct drm_connector *connector;
> > +       struct drm_connector_state *old_conn_state, *new_conn_state;
> >         struct drm_crtc *crtc;
> >         struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > +       struct drm_plane *plane;
> > +       struct drm_plane_state *old_plane_state, *new_plane_state;
> >         struct drm_crtc_commit *commit;
> > +       struct drm_private_obj *obj;
> > +       struct drm_private_state *old_obj_state, *new_obj_state;
> >         int i;
> >
> > +       /*
> > +        * After this point, drivers should not access the permanent modeset
> > +        * state, so we also clear the new_state pointers to make this
> > +        * restriction explicit.
> > +        *
> > +        * For the CRTC state, we do this in the same loop where we signal
> > +        * hw_done, since we still need to new_crtc_state to fish out the
> > +        * commit.
> > +        */
> > +
> > +       for_each_oldnew_connector_in_state(old_state, connector, old_conn_state, new_conn_state, i) {
> > +               old_state->connectors[i].new_state = NULL;
> > +       }
> > +
> > +       for_each_oldnew_plane_in_state(old_state, plane, old_plane_state, new_plane_state, i) {
> > +               old_state->planes[i].new_state = NULL;
> > +       }
> > +
> > +       for_each_oldnew_private_obj_in_state(old_state, obj, old_obj_state, new_obj_state, i) {
> > +               old_state->private_objs[i].new_state = NULL;
> > +       }
> > +
> >         for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_state, new_crtc_state, i) {
> > +               old_state->crtcs[i].new_state = NULL;
> > +
> >                 commit = new_crtc_state->commit;
> >                 if (!commit)
> >                         continue;
> > --
> > 2.23.0
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
