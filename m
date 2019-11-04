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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471D7CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 19:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F85820869
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 19:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPjd2iCQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbfKDTOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 14:14:12 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35366 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbfKDTOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 14:14:12 -0500
Received: by mail-ed1-f68.google.com with SMTP id w3so11746004edt.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 11:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tcsTcR94U2rmzCscWDEsn+jUblNcTU2VqTYCWP7Pie0=;
        b=TPjd2iCQ7AZfvZeQzJbaP4jm6c3cATv97gypva8W58G4xMSsFP1dGtIPm9mn+T5KH5
         44pqhUWrS+vvr7MveQ7OLH6IyMezAzuhYzCDbh/ydOg8TXPonm69XWOek3B1ily7X3t7
         E136zrN/kHGVmm0NO+JuRiwtImT9GOWeOq1eLuOYK5vSwlrCC3r02d96B+tZOTA7kIsl
         VOJQy5IIrbfe2qSNDTBuO5elZv4cQRzRczafOJ6Ql7ma1nPTOucLBfmavP3bDZRRdz43
         BhfV0vqyWGmgbw0MYxVF5IEGGoXLTp8lNaEiNY7YTZT5Q64OsvfFd4fgdayFvTzOLqIo
         Zr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tcsTcR94U2rmzCscWDEsn+jUblNcTU2VqTYCWP7Pie0=;
        b=NgR6tvGPRVFRTe8drFbgpduKmw6+jcZNalZEk7Q2QNkdLbEEU/kYD/DJEbP6Vmka8e
         78wkj9hWik2DBGpeIMC7wLDeiJ4kTZFeo6Bd7rivEU16OiUk41BEawWGRs/UWCFTSIAS
         GgaTG0sY3hRXBmxVQfJNRjiPZ3yaUx4RrTcTF3VgIGyBlKJi+e7DcKl1uHFIVCTtSK6l
         7I6Kn4oigK6LdrrdNK38tqHDoEFg905M8oRg4TRNdNOFa7wJ5xcbvbkckO24k0D+pMJt
         xH+4BNZvskeThBLDsBtSNterkvloUfGwBwYAFj0C4DsjP3DdQ+QgaDj+RUf0W08eTyAf
         kFwA==
X-Gm-Message-State: APjAAAWSaSrlwN3dn8Th/LV9FW0JscDDKYJIfyoSyU8JpW7YrUFFwc8x
        JISi3/QAAqyfmddSi4dnK5rqNFX7KucHnFysslk=
X-Google-Smtp-Source: APXvYqx/fevoupOlq/+CWAag6a00zDMYfHxsDl3fCyeZefQEDY/F+iIxvpUgNG7/L3kWRfMaGEMnb7MHpS+5i4olJps=
X-Received: by 2002:a17:906:594f:: with SMTP id g15mr10752739ejr.197.1572894850301;
 Mon, 04 Nov 2019 11:14:10 -0800 (PST)
MIME-Version: 1.0
References: <20191101180713.5470-1-robdclark@gmail.com> <20191101180713.5470-2-robdclark@gmail.com>
 <20191101192458.GI1208@intel.com> <CAJs_Fx7u6VNDarYqUuUSMSsWK0jpS5ybse0h1X4AmtXO9Mia_w@mail.gmail.com>
 <20191101214431.GJ1208@intel.com> <CAF6AEGsHQ-V9aVvxLE6VeV2Ld+1_QOh7LS6GBsd6Lsr4qPZNMw@mail.gmail.com>
 <20191104184156.GL1208@intel.com>
In-Reply-To: <20191104184156.GL1208@intel.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 4 Nov 2019 11:13:59 -0800
Message-ID: <CAF6AEGuQ6WwwVYJvHSg=4NB3aafF6CEcUo2T4T+Cinz3X=DPFg@mail.gmail.com>
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

On Mon, Nov 4, 2019 at 10:42 AM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Fri, Nov 01, 2019 at 03:14:09PM -0700, Rob Clark wrote:
> > On Fri, Nov 1, 2019 at 2:44 PM Ville Syrj=C3=A4l=C3=A4
> > <ville.syrjala@linux.intel.com> wrote:
> > >
> > > On Fri, Nov 01, 2019 at 12:49:02PM -0700, Rob Clark wrote:
> > > > On Fri, Nov 1, 2019 at 12:25 PM Ville Syrj=C3=A4l=C3=A4
> > > > <ville.syrjala@linux.intel.com> wrote:
> > > > >
> > > > > On Fri, Nov 01, 2019 at 11:07:13AM -0700, Rob Clark wrote:
> > > > > > From: Rob Clark <robdclark@chromium.org>
> > > > > >
> > > > > > The new state should not be accessed after this point.  Clear t=
he
> > > > > > pointers to make that explicit.
> > > > > >
> > > > > > This makes the error corrected in the previous patch more obvio=
us.
> > > > > >
> > > > > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > > > > ---
> > > > > >  drivers/gpu/drm/drm_atomic_helper.c | 29 +++++++++++++++++++++=
++++++++
> > > > > >  1 file changed, 29 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/=
drm/drm_atomic_helper.c
> > > > > > index 732bd0ce9241..176831df8163 100644
> > > > > > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > > > > > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > > > > > @@ -2234,13 +2234,42 @@ EXPORT_SYMBOL(drm_atomic_helper_fake_vb=
lank);
> > > > > >   */
> > > > > >  void drm_atomic_helper_commit_hw_done(struct drm_atomic_state =
*old_state)
> > > > > >  {
> > > > > > +     struct drm_connector *connector;
> > > > > > +     struct drm_connector_state *old_conn_state, *new_conn_sta=
te;
> > > > > >       struct drm_crtc *crtc;
> > > > > >       struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > > > > > +     struct drm_plane *plane;
> > > > > > +     struct drm_plane_state *old_plane_state, *new_plane_state=
;
> > > > > >       struct drm_crtc_commit *commit;
> > > > > > +     struct drm_private_obj *obj;
> > > > > > +     struct drm_private_state *old_obj_state, *new_obj_state;
> > > > > >       int i;
> > > > > >
> > > > > > +     /*
> > > > > > +      * After this point, drivers should not access the perman=
ent modeset
> > > > > > +      * state, so we also clear the new_state pointers to make=
 this
> > > > > > +      * restriction explicit.
> > > > > > +      *
> > > > > > +      * For the CRTC state, we do this in the same loop where =
we signal
> > > > > > +      * hw_done, since we still need to new_crtc_state to fish=
 out the
> > > > > > +      * commit.
> > > > > > +      */
> > > > > > +
> > > > > > +     for_each_oldnew_connector_in_state(old_state, connector, =
old_conn_state, new_conn_state, i) {
> > > > > > +             old_state->connectors[i].new_state =3D NULL;
> > > > > > +     }
> > > > > > +
> > > > > > +     for_each_oldnew_plane_in_state(old_state, plane, old_plan=
e_state, new_plane_state, i) {
> > > > > > +             old_state->planes[i].new_state =3D NULL;
> > > > > > +     }
> > > > > > +
> > > > > > +     for_each_oldnew_private_obj_in_state(old_state, obj, old_=
obj_state, new_obj_state, i) {
> > > > > > +             old_state->private_objs[i].new_state =3D NULL;
> > > > > > +     }
> > > > > > +
> > > > > >       for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_s=
tate, new_crtc_state, i) {
> > > > > >               old_state->crtcs[i].new_self_refresh_active =3D n=
ew_crtc_state->self_refresh_active;
> > > > > > +             old_state->crtcs[i].new_state =3D NULL;
> > > > >
> > > > > That's going to be a real PITA when doing programming after the f=
act from
> > > > > a vblank worker. It's already a pain that the new_crtc_state->sta=
te is
> > > > > getting NULLed somewhere.
> > > > >
> > > >
> > > > I think you already have that problem, this just makes it explicit.
> > >
> > > I don't yet. Except on a branch where I have my vblank workers.
> > > And I think the only problem is having the helpers/core clobber
> > > the pointers when it should not. I don't see why it can't just
> > > leave them be and let me use them.
> > >
> >
> > I guess it comes down to what assumptions you can make in driver
> > backend.  But if you can, for example, move planes between crtcs, I
> > think you can't make assumptions about the order in which things
> > complete even if you don't have commits overtaking each other on a
> > single crtc..
>
> IMO this whole notion of accessing new_crtc_state & co. being unsafe
> for some reason is wrong. I think as long as I have the drm_atomic_state
> I should be able to look at the new/old states within.
>

accessing new state only works if you can guarantee the order in which
commits complete, which I don't think you can do in the general sense.
Like I said, it is perhaps an assumption that certain drivers can
make, although I'd probably advise against that on the grounds that it
is fragile.

BR,
-R
