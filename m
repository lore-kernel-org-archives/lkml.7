Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A4DCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 22:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8742085B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 22:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Np9oSpVB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfKAWOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 18:14:24 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33254 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfKAWOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 18:14:24 -0400
Received: by mail-ed1-f67.google.com with SMTP id c4so8650681edl.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 15:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QvyUOnCPDzDncgYUYYWR7jovyh1VoufcneVERJJM/xk=;
        b=Np9oSpVBax/Jy6y6l7TV2WU11Y6jOVq1AVCCZwGRV9Jn7chNfW54O9xi7EIr5LhD8V
         Z4EtYwCqcbrWE+owXXFWuvfSrmF3Lrv1rK0K/S8q3sUusmfPn4+giBuYsuQ6qcyNnsYH
         gliZpctGD2F85ionOIZ5H9m1BIB6xZT8V5xklP6MhXhRwOnhO+7UPUOQL+9tbPz+vJK2
         B7jJjBZ5qkM7VggrsKhifmRbaMi84i9hJcSi2FFnxZoXl+oy++ISJIa2fhgXpGjagOpX
         kWbEA7vRUjSybnZNbNHgNuiZSZqg+s1VXRRkHQfoCVbMeu1/1YMSz99u6aW14zhzD413
         rQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QvyUOnCPDzDncgYUYYWR7jovyh1VoufcneVERJJM/xk=;
        b=E7w67Z5/CkY6sJjVVt8HvelB42YVUsvAz9DYHzUPfa9L3aCc+Wtt0Gl3knvtNgMP+Y
         bws9FL1h5bxrVpe9NzQ2eTybzb9U82mTsEOr4lhz8lJdkowHKrDMJWU4AAnFMg4iKVQ3
         en1PXAcIlSC+urt8jg6vu2RywOEJz+Q9YBvFbNg/yxf6XlpAhhpkWviVPRs2ga8fG8Ay
         0Cc8DP+MR4n97egGD937hLE1J4mFKt0TJzo5CYHHYA0mIkr1EJp7SdOBdPq/6dRoS/gY
         lK2LsEgx2NR7Bc9yTah/yTpOy/IgRHFgpEWktKZllJ/QT6SLWC9T80Gz3/TXMNXEAniO
         0F1Q==
X-Gm-Message-State: APjAAAUrGdHdLC6ZahVfPgMRrt0MD5wPxQ1HHK4Mu86n4RM+L5O0KcZG
        mc1SqJKwXtY80EkNz+KrcJiD4oW0ISihlnTEXm8=
X-Google-Smtp-Source: APXvYqxNyJXUzP9gqvfdr0qqrrP93pIpZ7h8Rc35DY0kTbK1wnzbOnCYGe1OfAQB2WpUeuBugJxLKE+BM2I8OsY5cBA=
X-Received: by 2002:a17:906:e212:: with SMTP id gf18mr12222737ejb.90.1572646460987;
 Fri, 01 Nov 2019 15:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <20191101180713.5470-1-robdclark@gmail.com> <20191101180713.5470-2-robdclark@gmail.com>
 <20191101192458.GI1208@intel.com> <CAJs_Fx7u6VNDarYqUuUSMSsWK0jpS5ybse0h1X4AmtXO9Mia_w@mail.gmail.com>
 <20191101214431.GJ1208@intel.com>
In-Reply-To: <20191101214431.GJ1208@intel.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 1 Nov 2019 15:14:09 -0700
Message-ID: <CAF6AEGsHQ-V9aVvxLE6VeV2Ld+1_QOh7LS6GBsd6Lsr4qPZNMw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/atomic: clear new_state pointers at hw_done
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Rob Clark <robdclark@chromium.org>,
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

On Fri, Nov 1, 2019 at 2:44 PM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Fri, Nov 01, 2019 at 12:49:02PM -0700, Rob Clark wrote:
> > On Fri, Nov 1, 2019 at 12:25 PM Ville Syrj=C3=A4l=C3=A4
> > <ville.syrjala@linux.intel.com> wrote:
> > >
> > > On Fri, Nov 01, 2019 at 11:07:13AM -0700, Rob Clark wrote:
> > > > From: Rob Clark <robdclark@chromium.org>
> > > >
> > > > The new state should not be accessed after this point.  Clear the
> > > > pointers to make that explicit.
> > > >
> > > > This makes the error corrected in the previous patch more obvious.
> > > >
> > > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > > ---
> > > >  drivers/gpu/drm/drm_atomic_helper.c | 29 +++++++++++++++++++++++++=
++++
> > > >  1 file changed, 29 insertions(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/=
drm_atomic_helper.c
> > > > index 732bd0ce9241..176831df8163 100644
> > > > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > > > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > > > @@ -2234,13 +2234,42 @@ EXPORT_SYMBOL(drm_atomic_helper_fake_vblank=
);
> > > >   */
> > > >  void drm_atomic_helper_commit_hw_done(struct drm_atomic_state *old=
_state)
> > > >  {
> > > > +     struct drm_connector *connector;
> > > > +     struct drm_connector_state *old_conn_state, *new_conn_state;
> > > >       struct drm_crtc *crtc;
> > > >       struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > > > +     struct drm_plane *plane;
> > > > +     struct drm_plane_state *old_plane_state, *new_plane_state;
> > > >       struct drm_crtc_commit *commit;
> > > > +     struct drm_private_obj *obj;
> > > > +     struct drm_private_state *old_obj_state, *new_obj_state;
> > > >       int i;
> > > >
> > > > +     /*
> > > > +      * After this point, drivers should not access the permanent =
modeset
> > > > +      * state, so we also clear the new_state pointers to make thi=
s
> > > > +      * restriction explicit.
> > > > +      *
> > > > +      * For the CRTC state, we do this in the same loop where we s=
ignal
> > > > +      * hw_done, since we still need to new_crtc_state to fish out=
 the
> > > > +      * commit.
> > > > +      */
> > > > +
> > > > +     for_each_oldnew_connector_in_state(old_state, connector, old_=
conn_state, new_conn_state, i) {
> > > > +             old_state->connectors[i].new_state =3D NULL;
> > > > +     }
> > > > +
> > > > +     for_each_oldnew_plane_in_state(old_state, plane, old_plane_st=
ate, new_plane_state, i) {
> > > > +             old_state->planes[i].new_state =3D NULL;
> > > > +     }
> > > > +
> > > > +     for_each_oldnew_private_obj_in_state(old_state, obj, old_obj_=
state, new_obj_state, i) {
> > > > +             old_state->private_objs[i].new_state =3D NULL;
> > > > +     }
> > > > +
> > > >       for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_state=
, new_crtc_state, i) {
> > > >               old_state->crtcs[i].new_self_refresh_active =3D new_c=
rtc_state->self_refresh_active;
> > > > +             old_state->crtcs[i].new_state =3D NULL;
> > >
> > > That's going to be a real PITA when doing programming after the fact =
from
> > > a vblank worker. It's already a pain that the new_crtc_state->state i=
s
> > > getting NULLed somewhere.
> > >
> >
> > I think you already have that problem, this just makes it explicit.
>
> I don't yet. Except on a branch where I have my vblank workers.
> And I think the only problem is having the helpers/core clobber
> the pointers when it should not. I don't see why it can't just
> leave them be and let me use them.
>

I guess it comes down to what assumptions you can make in driver
backend.  But if you can, for example, move planes between crtcs, I
think you can't make assumptions about the order in which things
complete even if you don't have commits overtaking each other on a
single crtc..

BR,
-R
