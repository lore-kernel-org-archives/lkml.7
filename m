Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78815CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 19:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E89C2086D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 19:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WH7hkZsG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfKATtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 15:49:14 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45372 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfKATtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 15:49:13 -0400
Received: by mail-io1-f66.google.com with SMTP id s17so12080763iol.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 12:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KM5keI5JRBdsLMdvX/DXO4uxdl8v8GtwRSu6nk7FJlU=;
        b=WH7hkZsGVqlyvgy5eyIZq0VMmSWdPAQmDiz1SlTrO23EGhHCT1CbLFFZcJB4B6IEee
         oLS8WgiWlGXRvpCVz4PsJo1taIesksi/9tYeCqa7/mJL6BTq7rUAXDvh4pUEK41uo5w1
         fSeGDBNetbusamqn67VFSQNGcezzc0VFMS88s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KM5keI5JRBdsLMdvX/DXO4uxdl8v8GtwRSu6nk7FJlU=;
        b=frEt6ojZClk3eIXGNjTv/GdIu31l38Ok23EWO8iSjVmMbV99r7KB1vJ8TRRxjFfost
         LLzd6gFgBmK5geBkM84Q9zs433FSogu7HXSqP1o4QtXUHZvMhsw9bdZf/f2oRLLFhg6g
         ke5mhp+0flUdRs4Xgkt3mP2JLfyt2OBsJ1TWDN5uGPLSe4kZ+JBnNDlupLTQUNerV2lI
         jD2uYKE05a0Tnprm7K8sc6XItbXICbpIG3MLEuYAXOt0rD0+002iWnOI9k2cZsTVPHvI
         jHwQCzTgf1NpcXs8wh+sRXY4i3nlaO4cFMcskTpug36hjm0Wad4lWcRA31wfhvQPyDPZ
         vWpA==
X-Gm-Message-State: APjAAAWhQyuIUhdDU8FoupMnzDDNMMpwlf13I9zMLEXjtoPEapoR3KIy
        6JvcusSxMB+zwkAW0mPVCAdaEu0BE3jgxojSHRfJ6A==
X-Google-Smtp-Source: APXvYqzqj3T21Q8T+np0o4NhU2uvmqYRG5otyTj3dO3VfhI1dm5CqNDk7FXDrxrPGrD1LTFv+INtEsANSUVbr9CSNTQ=
X-Received: by 2002:a5e:d806:: with SMTP id l6mr8869892iok.299.1572637753039;
 Fri, 01 Nov 2019 12:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <20191101180713.5470-1-robdclark@gmail.com> <20191101180713.5470-2-robdclark@gmail.com>
 <20191101192458.GI1208@intel.com>
In-Reply-To: <20191101192458.GI1208@intel.com>
From:   Rob Clark <robdclark@chromium.org>
Date:   Fri, 1 Nov 2019 12:49:02 -0700
Message-ID: <CAJs_Fx7u6VNDarYqUuUSMSsWK0jpS5ybse0h1X4AmtXO9Mia_w@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/atomic: clear new_state pointers at hw_done
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Sean Paul <seanpaul@chromium.org>, Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 1, 2019 at 12:25 PM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Fri, Nov 01, 2019 at 11:07:13AM -0700, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > The new state should not be accessed after this point.  Clear the
> > pointers to make that explicit.
> >
> > This makes the error corrected in the previous patch more obvious.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/gpu/drm/drm_atomic_helper.c | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_=
atomic_helper.c
> > index 732bd0ce9241..176831df8163 100644
> > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > @@ -2234,13 +2234,42 @@ EXPORT_SYMBOL(drm_atomic_helper_fake_vblank);
> >   */
> >  void drm_atomic_helper_commit_hw_done(struct drm_atomic_state *old_sta=
te)
> >  {
> > +     struct drm_connector *connector;
> > +     struct drm_connector_state *old_conn_state, *new_conn_state;
> >       struct drm_crtc *crtc;
> >       struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > +     struct drm_plane *plane;
> > +     struct drm_plane_state *old_plane_state, *new_plane_state;
> >       struct drm_crtc_commit *commit;
> > +     struct drm_private_obj *obj;
> > +     struct drm_private_state *old_obj_state, *new_obj_state;
> >       int i;
> >
> > +     /*
> > +      * After this point, drivers should not access the permanent mode=
set
> > +      * state, so we also clear the new_state pointers to make this
> > +      * restriction explicit.
> > +      *
> > +      * For the CRTC state, we do this in the same loop where we signa=
l
> > +      * hw_done, since we still need to new_crtc_state to fish out the
> > +      * commit.
> > +      */
> > +
> > +     for_each_oldnew_connector_in_state(old_state, connector, old_conn=
_state, new_conn_state, i) {
> > +             old_state->connectors[i].new_state =3D NULL;
> > +     }
> > +
> > +     for_each_oldnew_plane_in_state(old_state, plane, old_plane_state,=
 new_plane_state, i) {
> > +             old_state->planes[i].new_state =3D NULL;
> > +     }
> > +
> > +     for_each_oldnew_private_obj_in_state(old_state, obj, old_obj_stat=
e, new_obj_state, i) {
> > +             old_state->private_objs[i].new_state =3D NULL;
> > +     }
> > +
> >       for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_state, ne=
w_crtc_state, i) {
> >               old_state->crtcs[i].new_self_refresh_active =3D new_crtc_=
state->self_refresh_active;
> > +             old_state->crtcs[i].new_state =3D NULL;
>
> That's going to be a real PITA when doing programming after the fact from
> a vblank worker. It's already a pain that the new_crtc_state->state is
> getting NULLed somewhere.
>

I think you already have that problem, this just makes it explicit.

BR,
-R
