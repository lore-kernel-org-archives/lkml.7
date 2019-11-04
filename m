Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB96C47E49
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB75620717
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F59FOw5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbfKDVMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:12:00 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39709 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfKDVMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:12:00 -0500
Received: by mail-ed1-f68.google.com with SMTP id l25so14330682edt.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 13:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QJX38fPH4Wmm+NgS8n4DnoBmgQALP+GtwdgAD3lH8MI=;
        b=F59FOw5EM0G/b4mEvS1yY4BDvYP7j8S7tBalF1rIUni4dl8Q8CQqso54n3xO9DKZ30
         +PXvdbSv4VqiRSSbgq5bCFRCbX2+4N77CSpCXhhYJpOn1EeURCz7yKZAU9mzXGbI9QiF
         USTGaD89RJTIW0TPqEdFyCErU+7KG1VWqF6IqNktxqloX1o0qb8VH5vD/7B9xxt+MF1t
         ninKOgHxYsGFQYLAx+Fmh3kPes2u1JJ2JV4UJbOGGYgGLeP6ba8qABe28QZI6IP1nrH+
         x7k33ZTE3LM2z2XaIkakFGud8Xlhw8andNAKKJx/by6TSVPwAb14DHrfhhEHDhBy4l+y
         uIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QJX38fPH4Wmm+NgS8n4DnoBmgQALP+GtwdgAD3lH8MI=;
        b=Kf3szDr0uLqzXJulmyOC1B2qGlEzcAqjxwCFXDNvfAwqqwVnpRm7FTVA41ah/NorLc
         GqL1wrzHT78oMvL0jae8Zx6dLhhjQU/J5X0fezOKa/rkD/E6GZufvuy5QM/fOduWLI5l
         UTT/Y57HDm9I01SOcIuyvVnhHE9m3k8o/eiX7eEcO+lMR1A0mpGnsFhpft8A+1xZvZfE
         4Fwt+o7UyDFUI4qQQLKUPdcVhFF2XFf9gkqQdndO4HUjCxKxX7uq71nhOdhMScLlBy91
         B4F2TgU/4rQ1m6uHZo1pbk/WnY5dhUGQ228JmcjKTSqIJUS5/HvZNj/y+L8cO4mfE0oK
         gmYQ==
X-Gm-Message-State: APjAAAUEVQw13vC1it94p+Tput2xf4yEAhA3wCZ99ML82u1iQ0inOl02
        x74QQwSfw6nX9naZf9gpLt8RBYfMDevsqL8PJKw=
X-Google-Smtp-Source: APXvYqzMhHOg1RYQzZ/UzBp7P2MnDnTf91ciO2W51U6TAE5TVPjWc4em2tPR3TlDTBamoKwdGEWwxI7L6tDNph/D7eg=
X-Received: by 2002:a17:906:a44:: with SMTP id x4mr25620544ejf.64.1572901917757;
 Mon, 04 Nov 2019 13:11:57 -0800 (PST)
MIME-Version: 1.0
References: <20191101180713.5470-1-robdclark@gmail.com> <20191101180713.5470-2-robdclark@gmail.com>
 <20191101192458.GI1208@intel.com> <CAJs_Fx7u6VNDarYqUuUSMSsWK0jpS5ybse0h1X4AmtXO9Mia_w@mail.gmail.com>
 <20191101214431.GJ1208@intel.com> <CAF6AEGsHQ-V9aVvxLE6VeV2Ld+1_QOh7LS6GBsd6Lsr4qPZNMw@mail.gmail.com>
 <20191104184156.GL1208@intel.com> <CAF6AEGuQ6WwwVYJvHSg=4NB3aafF6CEcUo2T4T+Cinz3X=DPFg@mail.gmail.com>
 <20191104205010.GM1208@intel.com>
In-Reply-To: <20191104205010.GM1208@intel.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 4 Nov 2019 13:11:46 -0800
Message-ID: <CAF6AEGv5k_kLkHezpemV-=md_YZbxFq3ENkaN88JSFzVeEnxuQ@mail.gmail.com>
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

On Mon, Nov 4, 2019 at 12:50 PM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Mon, Nov 04, 2019 at 11:13:59AM -0800, Rob Clark wrote:
> > On Mon, Nov 4, 2019 at 10:42 AM Ville Syrj=C3=A4l=C3=A4
> > <ville.syrjala@linux.intel.com> wrote:
> > >
> > > On Fri, Nov 01, 2019 at 03:14:09PM -0700, Rob Clark wrote:
> > > > On Fri, Nov 1, 2019 at 2:44 PM Ville Syrj=C3=A4l=C3=A4
> > > > <ville.syrjala@linux.intel.com> wrote:
> > > > >
> > > > > On Fri, Nov 01, 2019 at 12:49:02PM -0700, Rob Clark wrote:
> > > > > > On Fri, Nov 1, 2019 at 12:25 PM Ville Syrj=C3=A4l=C3=A4
> > > > > > <ville.syrjala@linux.intel.com> wrote:
> > > > > > >
> > > > > > > On Fri, Nov 01, 2019 at 11:07:13AM -0700, Rob Clark wrote:
> > > > > > > > From: Rob Clark <robdclark@chromium.org>
> > > > > > > >
> > > > > > > > The new state should not be accessed after this point.  Cle=
ar the
> > > > > > > > pointers to make that explicit.
> > > > > > > >
> > > > > > > > This makes the error corrected in the previous patch more o=
bvious.
> > > > > > > >
> > > > > > > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > > > > > > ---
> > > > > > > >  drivers/gpu/drm/drm_atomic_helper.c | 29 +++++++++++++++++=
++++++++++++
> > > > > > > >  1 file changed, 29 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/=
gpu/drm/drm_atomic_helper.c
> > > > > > > > index 732bd0ce9241..176831df8163 100644
> > > > > > > > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > > > > > > > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > > > > > > > @@ -2234,13 +2234,42 @@ EXPORT_SYMBOL(drm_atomic_helper_fak=
e_vblank);
> > > > > > > >   */
> > > > > > > >  void drm_atomic_helper_commit_hw_done(struct drm_atomic_st=
ate *old_state)
> > > > > > > >  {
> > > > > > > > +     struct drm_connector *connector;
> > > > > > > > +     struct drm_connector_state *old_conn_state, *new_conn=
_state;
> > > > > > > >       struct drm_crtc *crtc;
> > > > > > > >       struct drm_crtc_state *old_crtc_state, *new_crtc_stat=
e;
> > > > > > > > +     struct drm_plane *plane;
> > > > > > > > +     struct drm_plane_state *old_plane_state, *new_plane_s=
tate;
> > > > > > > >       struct drm_crtc_commit *commit;
> > > > > > > > +     struct drm_private_obj *obj;
> > > > > > > > +     struct drm_private_state *old_obj_state, *new_obj_sta=
te;
> > > > > > > >       int i;
> > > > > > > >
> > > > > > > > +     /*
> > > > > > > > +      * After this point, drivers should not access the pe=
rmanent modeset
> > > > > > > > +      * state, so we also clear the new_state pointers to =
make this
> > > > > > > > +      * restriction explicit.
> > > > > > > > +      *
> > > > > > > > +      * For the CRTC state, we do this in the same loop wh=
ere we signal
> > > > > > > > +      * hw_done, since we still need to new_crtc_state to =
fish out the
> > > > > > > > +      * commit.
> > > > > > > > +      */
> > > > > > > > +
> > > > > > > > +     for_each_oldnew_connector_in_state(old_state, connect=
or, old_conn_state, new_conn_state, i) {
> > > > > > > > +             old_state->connectors[i].new_state =3D NULL;
> > > > > > > > +     }
> > > > > > > > +
> > > > > > > > +     for_each_oldnew_plane_in_state(old_state, plane, old_=
plane_state, new_plane_state, i) {
> > > > > > > > +             old_state->planes[i].new_state =3D NULL;
> > > > > > > > +     }
> > > > > > > > +
> > > > > > > > +     for_each_oldnew_private_obj_in_state(old_state, obj, =
old_obj_state, new_obj_state, i) {
> > > > > > > > +             old_state->private_objs[i].new_state =3D NULL=
;
> > > > > > > > +     }
> > > > > > > > +
> > > > > > > >       for_each_oldnew_crtc_in_state(old_state, crtc, old_cr=
tc_state, new_crtc_state, i) {
> > > > > > > >               old_state->crtcs[i].new_self_refresh_active =
=3D new_crtc_state->self_refresh_active;
> > > > > > > > +             old_state->crtcs[i].new_state =3D NULL;
> > > > > > >
> > > > > > > That's going to be a real PITA when doing programming after t=
he fact from
> > > > > > > a vblank worker. It's already a pain that the new_crtc_state-=
>state is
> > > > > > > getting NULLed somewhere.
> > > > > > >
> > > > > >
> > > > > > I think you already have that problem, this just makes it expli=
cit.
> > > > >
> > > > > I don't yet. Except on a branch where I have my vblank workers.
> > > > > And I think the only problem is having the helpers/core clobber
> > > > > the pointers when it should not. I don't see why it can't just
> > > > > leave them be and let me use them.
> > > > >
> > > >
> > > > I guess it comes down to what assumptions you can make in driver
> > > > backend.  But if you can, for example, move planes between crtcs, I
> > > > think you can't make assumptions about the order in which things
> > > > complete even if you don't have commits overtaking each other on a
> > > > single crtc..
> > >
> > > IMO this whole notion of accessing new_crtc_state & co. being unsafe
> > > for some reason is wrong. I think as long as I have the drm_atomic_st=
ate
> > > I should be able to look at the new/old states within.
> > >
> >
> > accessing new state only works if you can guarantee the order in which
> > commits complete, which I don't think you can do in the general sense.
>
> Doesn't feel like it should take a lot of rocket science to guarantee
> the states get freed in the right order.
>

I agree, reference counting is not rocket science.  But that isn't the
way drm core handles per-object state currently.  Refcnt'ing is
probably the approach that I'd recommend if someone wanted to lift
this restriction about accessing new-state later.

BR,
-R
