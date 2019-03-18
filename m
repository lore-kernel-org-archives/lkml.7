Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085DCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42F320828
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkPELtMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfCRTgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:36:17 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40608 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfCRTgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:36:17 -0400
Received: by mail-qt1-f196.google.com with SMTP id x12so3271362qts.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 12:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ug8aCj6cf6eI5OanRUTPEqf5H/OkgUHRNwKRB52oRsY=;
        b=BkPELtMay7J1zaWE1E5/hN9dRoSwsqNAcTXBUaDzV3uykoVHvBXejWOQajs/401+eg
         fw3oWbza0fJxVmXWsWbahpo2eSlxxYtW8Jhck/A+XPj7u9l17aZsFquF/k3a0Rn7LFI0
         PTiuFjCWiMA8x2PpDBIR4uf41nWI9h3nUm7eHGoZgfoLl26KqFgqd9Of80o6/rKsC8AX
         t/7ZPrhvL6Sul7+eJn+oVPZ8pc5NDk2XDkCYdBOFx0xsOe2Zg/qU8/ohTm8yLlO/hwpP
         mZ9XaE2k83CldsuzmyB84u01SJ2ZUE1A5g9H4jIxTdi/7Cih75Km3R50187P0cUCHPcy
         B3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ug8aCj6cf6eI5OanRUTPEqf5H/OkgUHRNwKRB52oRsY=;
        b=qsUjjqQx2RvX5guv9rX+uutbaXjqZXPEW6ErvwOlreaNdglNnhUjSnYy1r9MhHalqY
         CeWvpMKKO5LSOs08sn48X321oWTA8Hmtjq+rCT1PHyqVN3M3dlr+tEV1q2wP4hEUEIeo
         c0K4TBzj8MmC1PKigmDdW3rK9o9RqEW83XRianP+f7WPQ6KZ/vTE9zifpjfjSQQETIYj
         emou73uWY2n9xM1ziHzhKRqnRlSEGdcK132vlZhTaslCY7qyejIO1DbWufKt8Xp/K6Tt
         cSzwflfTtasM2fT/aWd53WWyXZTCubgn1f7LYoWZdVlED5wB6SQ3c4ajORgKCnvOfrnj
         3InA==
X-Gm-Message-State: APjAAAUdY3oN6feOayYKJdsjImQCBxOslbNcQtO3FkMqQV0+OL0hi9xJ
        Ox3PSPDR/k1aXTOPHIBAnW3MF2LB
X-Google-Smtp-Source: APXvYqx80bU7nCVT7Yhn2h2F/cWo9Tw07Tii6WDFmEqlDzklk7PX5iWEgCv5XVmqDNbcIFINfj3y6A==
X-Received: by 2002:a0c:895a:: with SMTP id 26mr12867466qvq.4.1552937775612;
        Mon, 18 Mar 2019 12:36:15 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id p6sm911856qtk.70.2019.03.18.12.36.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 18 Mar 2019 12:36:14 -0700 (PDT)
Date:   Mon, 18 Mar 2019 16:36:11 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Shayenne Moura <shayenneluzmoura@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/vkms: Solve bug on kms_crc_cursor tests
Message-ID: <20190318193611.gbsnl3un6znujr3w@smtp.gmail.com>
References: <20190228101107.GL2665@phenom.ffwll.local>
 <20190228140341.GG20097@intel.com>
 <CAKkTe8Ei2fbz4L2noLvGWMCsHy1f7sadOV-horjNsGBEHt=q3w@mail.gmail.com>
 <20190301152558.GR20097@intel.com>
 <CAKkTe8HbgkVm1i2xAFT6ecgv2jFjyoqrSEYUpx_40Uj=ogKYPQ@mail.gmail.com>
 <20190301184147.GS20097@intel.com>
 <20190310203505.2needmil76a4rc74@smtp.gmail.com>
 <20190311142710.GY3888@intel.com>
 <20190315115157.6jqvnsddzmvz7jar@smtp.gmail.com>
 <20190315134833.GA3888@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w5dxbsyiubkhxxav"
Content-Disposition: inline
In-Reply-To: <20190315134833.GA3888@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w5dxbsyiubkhxxav
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03/15, Ville Syrj=C3=A4l=C3=A4 wrote:
> On Fri, Mar 15, 2019 at 08:51:57AM -0300, Rodrigo Siqueira wrote:
> > On 03/11, Ville Syrj=C3=A4l=C3=A4 wrote:
> > > On Sun, Mar 10, 2019 at 05:35:05PM -0300, Rodrigo Siqueira wrote:
> > > > On 03/01, Ville Syrj=C3=A4l=C3=A4 wrote:
> > > > > On Fri, Mar 01, 2019 at 03:35:35PM -0300, Shayenne Moura wrote:
> > > > > > Em sex, 1 de mar de 2019 =C3=A0s 12:26, Ville Syrj=C3=A4l=C3=A4
> > > > > > <ville.syrjala@linux.intel.com> escreveu:
> > > > > > >
> > > > > > > On Fri, Mar 01, 2019 at 11:55:11AM -0300, Shayenne Moura wrot=
e:
> > > > > > > > Em qui, 28 de fev de 2019 =C3=A0s 11:03, Ville Syrj=C3=A4l=
=C3=A4
> > > > > > > > <ville.syrjala@linux.intel.com> escreveu:
> > > > > > > > >
> > > > > > > > > On Thu, Feb 28, 2019 at 11:11:07AM +0100, Daniel Vetter w=
rote:
> > > > > > > > > > On Mon, Feb 25, 2019 at 11:26:06AM -0300, Shayenne Mour=
a wrote:
> > > > > > > > > > > vkms_crc_work_handle needs the value of the actual fr=
ame to
> > > > > > > > > > > schedule the workqueue that calls periodically the vb=
lank
> > > > > > > > > > > handler and the destroy state functions. However, the=
 frame
> > > > > > > > > > > value returned from vkms_vblank_simulate is updated a=
nd
> > > > > > > > > > > diminished in vblank_get_timestamp because it is not =
in a
> > > > > > > > > > > vblank interrupt, and return an inaccurate value.
> > > > > > > > > > >
> > > > > > > > > > > Solve this getting the actual vblank frame directly f=
rom the
> > > > > > > > > > > vblank->count inside the `struct drm_crtc`, instead o=
f using
> > > > > > > > > > > the `drm_accurate_vblank_count` function.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail=
=2Ecom>
> > > > > > > > > >
> > > > > > > > > > Sorry for the delay, I'm a bit swamped right now :-/
> > > > > > > > > >
> > > > > > > > > > Debug work you're doing here is really impressive! But =
I have no idea
> > > > > > > > > > what's going on. It doesn't look like it's just paperin=
g over a bug (like
> > > > > > > > > > the in_vblank_irq check we've discussed on irc), but I =
also have no idea
> > > > > > > > > > why it works.
> > > > > > > > > >
> > > > > > > > > > I'll pull in Ville, he understands this better than me.
> > > > > > > > >
> > > > > > > > > It's not entirely clear what we're trying to fix. From wh=
at I can see
> > > > > > > > > the crc work seems to be in no way synchronized with page=
 flips, so
> > > > > > > > > I'm not sure how all this is really supposed to work.
> > > > > > > > >
> > > > > > > >
> > > > > > > > Hi, Ville!
> > > > > > > >
> > > > > > > > Thank you for the review! :)
> > > > > > > >
> > > > > > > > I do not understand well what crc code is doing, but the is=
sue that I found
> > > > > > > > is related to the vblank timestamp and frame count.
> > > > > > > >
> > > > > > > > When vkms handles the crc_cursor it uses the start frame an=
d end frame
> > > > > > > > values to verify if it needs to call the function 'drm_crtc=
_add_crc_entry()'
> > > > > > > > for each frame.
> > > > > > > >
> > > > > > > > However, when getting the frame count, the code is calling =
the function
> > > > > > > > drm_update_vblank_count(dev, pipe, false) and, because of t=
he 'false',
> > > > > > > > subtracting the actual vblank timestamp (consequently, the =
frame count
> > > > > > > > value), causing conflicts.
> > > > > > >
> > > > > > > The in_vblank_irq behavour looks sane to me. What are these c=
onflicts?
> > > > > > >
> > > > > >=20
> > > > > > The entire history was:
> > > > > >  - I sent the patch with bugfix for vblank extra frame. The pat=
ch changed
> > > > > >    our function vkms_get_vblank_timestamp() to look like this:
> > > > > >=20
> > > > > > bool vkms_get_vblank_timestamp(struct drm_device *dev, unsigned=
 int pipe,
> > > > > >                    int *max_error, ktime_t *vblank_time,
> > > > > >                    bool in_vblank_irq)
> > > > > > {
> > > > > >     struct vkms_device *vkmsdev =3D drm_device_to_vkms_device(d=
ev);
> > > > > >     struct vkms_output *output =3D &vkmsdev->output;
> > > > > >=20
> > > > > >     *vblank_time =3D output->vblank_hrtimer.node.expires;
> > > > > >=20
> > > > > > +   if (!in_vblank_irq)
> > > > > > +        *vblank_time -=3D output->period_ns;
> > > > > >=20
> > > > > >     return true;
> > > > > > }
> > > > > >=20
> > > > > >  - This patch solve the issue that I was looking for (extra vbl=
ank
> > > > > > frames on kms_flip).
> > > > > >=20
> > > > > >  - However, kms_cursor_crc tests, which passed before my patch,=
 started to fail.
> > > > > >=20
> > > > > >  - Debugging them, I found that the problem was inside of funct=
ion
> > > > > > `vkms_vblank_simulate()`
> > > > > > when it was handling the crc_enabled (inside  if (state && outp=
ut->crc_enabled))
> > > > > > and inside the function vkms_crc_work_handle() too.
> > > > > >=20
> > > > > >  - Following the steps:
> > > > > > 1. Inside vkms_vblank_simulate() we call drm_crtc_accurate_vbla=
nk_count()
> > > > > > 2. In its turn, drm_crtc_accurate_vblank_count() calls the func=
tion
> > > > > >    drm_update_vblank_count(dev, pipe, false).  /* This false is=
 default */
> > > > > > 3. Finally, the =E2=80=9Cfalse=E2=80=9D used in drm_update_vbla=
nk_count(), will be
> > > > > >   passed to vkms_get_vblank_timestamp() and the condition =E2=
=80=9Cif
> > > > > >   (!in_vblank_irq)=E2=80=9D will be executed multiple times (we=
 don=E2=80=99t want it).
> > > > > >=20
> > > > > >  - Inside vkms_crc, the issue is that the returned frame value =
change for
> > > > > > every call of drm_crtc_accurate_vblank_count() because
> > > > > > in_vblank_irq =3D=3D false.
> > > >=20
> > > > Hi Ville,
> > > > =20
> > > > > OK. So why is it changing? AFAICS it should not change unless the
> > > > > timer was moved forward in between the calls.
> > > >=20
> > > > Yes Ville, you=E2=80=99re right. We have to update it only when the=
 function
> > > > vkms_vblank_simulate() is invoked (timer move forward), and FWIU we=
 do
> > > > it when we call drm_crtc_handle_vblank(). However, the current
> > > > implementation of vkms, has a call to drm_crtc_accurate_vblank_coun=
t()
> > > > inside the vkms_vblank_simulate() which is a problem because it also
> > > > update the vblank value. FWIU, this patch fixes this issue by takin=
g the
> > > > count value in the data struct instead of call
> > > > drm_crtc_accurate_vblank_count() which will avoid the extra update.
> > >=20
> > > But why does that extra update change the vblank count?
> >=20
> > Hi,
> >=20
> > I think that I=E2=80=99m failing to explain the issue and the solution =
in this
> > patch, sorry for that... and I apologize in advance for the lengthy
> > email.
> >=20
> > In this sense, allow me to elaborate the whole history in =E2=80=98chro=
nological
> > sections=E2=80=99:
> >=20
> > 1. About the =E2=80=98fake=E2=80=99 Vblank inside VKMS
> >=20
> > Since VKMS is a virtual driver, we do not have real Vblank, and we
> > simulate it by using hrtimers. I registered the function
> > vkms_vblank_simulate() as a callback inside hrtimer; in this function,
> > we do some stuff that can be summarized in the sequence below:
> >=20
> > I) drm_crtc_handle_vblank()
> > II) Check if crc is enabled or not
> > III) Schedule the next vblank with hrtimer_forward_now()
> >=20
> > 2. Override the default behaviour for get_vblank_timestamp()
> >=20
> > As I told before, everytime that vkms_vblank_simulate() is invoked the
> > function drm_crtc_handle_vblank() will be requested. For us, the
> > important thing about drm_crtc_handle_vblank() is the sequence:
> >=20
> >  a) drm_crtc_handle_vblank()
> >  b) drm_handle_vblank()
> >  c) drm_update_vblank_count()
> >  d) drm_get_last_vbltimestamp()
> >  e) get_vblank_timestamp()
> >=20
> > Since VKMS is a virtual driver, we cannot rely on the default
> > implementation of get_vblank_timestamp(). In this context, we
> > implemented our wrapper named vkms_get_vblank_timestamp(), and we have
> > to return the expires time from hrtimer to the userspace. In my first
> > implementation of this function, I had something like:
> >=20
> > bool vkms_get_vblank_timestamp(struct drm_device *dev, unsigned int pip=
e,
> >                                int *max_error, ktime_t *vblank_time,
> >                                bool in_vblank_irq)
> > {
> > [..]
> >         *vblank_time =3D output->vblank_hrtimer.node.expires;
> >         return true;
> > }
> >=20
> > Around 80% of the kms_flip tests were passing with this code. However,
> > we had some tests that break due to an extra vblank.
> >=20
> > 3. The extra vblank bug
> >=20
> > Shayenne and Daniel figured out that the extra vblank came from the
> > function drm_crtc_arm_vblank_event() invoked inside the
> > vkms_crtc_atomic_flush(). If we take a look inside
> > drm_crtc_arm_vblank_event(), we can find:
> >=20
> > void drm_crtc_arm_vblank_event([..])
> > {
> > [..]
> >        e->sequence =3D drm_crtc_accurate_vblank_count(crtc) + 1;
> > [..]
> > }
> >=20
> > This function increment the sequence by one (there is a detailed
> > explanation about it in the documentation of this function).
> >=20
> > 4. The bug fix
> >=20
> > After inspecting the code, we identified the following sequence when the
> > function drm_crtc_arm_vblank_event() is invoked:
> >=20
> >  a) drm_crtc_arm_vblank_event()
> >  b) drm_crtc_accurate_vblank_count()
> >  c) drm_update_vblank_count(dev, pipe, false)
> >=20
> > Noticed that drm_update_vblank_count() is invoked again, but now with
> > =E2=80=98false=E2=80=99 in the in_vblank_irq because it does not have t=
o report anything
> > for userspace or something like that. With this in mind, remember that
> > drm_update_vblank_count() will call get_vblank_timestamp(); with my
> > first implementation of vkms_get_vblank_timestamp() (see Section 2 for
> > recap) we will update the vblank_time with the wrong information. After
> > understanding all of these details and the meaning of the parameter
> > in_vblank_irq, the following fix was added:
> >=20
> > bool vkms_get_vblank_timestamp([..]) {
> > [..]
> >         if (!in_vblank_irq)
> >                 *vblank_time -=3D output->period_ns;
> > [..]
> > }
> >=20
> > With this validation, we can solve the problem of the extra Vblank added
> > by drm_crtc_arm_vblank_event(). Afterward, all the kms_flip test started
> > to pass.
> >=20
> > 5. The new bug on CRC operation
> >=20
> > As a side effect of the above change, the CRC tests start to failing.
> > The question was, why we break the CRC test with that fix?
> >=20
> > We start hunting the problem, and the first thing to look is the
> > function vkms_vblank_simulate(). Inside this function, we have this
> > code:
> >=20
> > vkms_vblank_simulate([..]) {
> > [..]
> >         if (state && output->crc_enabled) {
> >                 u64 frame =3D drm_crtc_accurate_vblank_count(crtc);
> >                 [..]
> >         }
> >=20
> > The output->crc_enabled is a module parameter that enables CRC
> > computation which is required for CRC tests, but not for kms_flip.
> > Additionally, notice that we save the value of the current frame because
> > it is necessary to use it on vkms_crc_work_handle(). The only thing that
> > we need to know about vkms_crc_work_handle() is the fact we call
> > drm_crtc_add_crc_entry() which requires the frame number, and we also
> > use it to check if the frame was updated or not.
> >=20
> > As I said in Section 2, drm_crtc_accurate_vblank_count() calls
> > drm_update_vblank_count() with false parameter in in_vblank_irq. Due to
> > the last change made at vkms_get_vblank_timestamp(), we broke the CRC
> > code because now we invoke get_vblank_timestamp() multiple times. The
> > consequence of this change is the excessive decrement of the timestamp
> > since the following condition execute multiple time:
> >=20
> > bool vkms_get_vblank_timestamp([..]) {
> >         if (!in_vblank_irq)
> >                 *vblank_time -=3D output->period_ns;
>=20
> The full code is
> *vblank_time =3D output->vblank_hrtimer.node.expires;
> if (!in_vblank_irq)
> 	*vblank_time -=3D output->period_ns;
>=20
> So no matter how many times you call it you should always get the same
> answer (unless the timer was moved forwared in between the calls).

Touch=C3=A9! :)

You're right! Thanks for your patience, I finally understood the problem
and now I will dig into it.

Thanks

> >=20
> > 6. The bug fix (this patch)
> >=20
> > Since we only want the frame number, as I described in Section 5, the
> > fix is quite simple: avoid call drm_crtc_accurate_vblank_count() and
> > just get the frame value from the data structure. In this patch,
> > Shayenne removed the function drm_crtc_accurate_vblank_count() which
> > avoid the extra decrement in the vkms_get_vblank_timestamp(). With this
> > patch, everything started to work well.
> >=20
> > So... In a few words, it is a VKMS problem, not a vblank issue.
> >=20
> > I=E2=80=99m not sure if the solution here is the best one, but I believ=
e that
> > the idea behind it is correct.
> >=20
> > Best Regards
> >=20
> > --=20
> > Rodrigo Siqueira
> > https://siqueira.tech
> > Graduate Student
> > Department of Computer Science
> > University of S=C3=A3o Paulo
>=20
>=20
>=20
> --=20
> Ville Syrj=C3=A4l=C3=A4
> Intel

--=20
Rodrigo Siqueira
https://siqueira.tech
Graduate Student
Department of Computer Science
University of S=C3=A3o Paulo

--w5dxbsyiubkhxxav
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAlyP8yoACgkQWJzP/com
vP9nTw//fwzspLHmqI5cI7ZjVdTPUDxWCpNZ4MaFDS5yY74KzKvA89JSjBGE3o3w
DhQFrTtX3civ0esB0dQaVDjxHRJlp6mw6MxJJ4txDVUVAkK3r5gN1tyQ52AmAYoB
Gexqon3OaSsjMcIWBBr4DB4np71eIeAQipI0bwGXeWbuXgCghpFMkdZCeqBSw8tZ
bGs+opou2egQ1KG2xCMfJEBf3pQw/UfLvDLviH6PKs88rTxizP4KQ4Vy8HltZsNK
vsAkzQKnMeOTi/xE7ZxI2c4U9fTp5ZG7wU5pNAUBxP9BZDhptkG0/ELf55BVj2YT
Vnmsw1IdXj+ielgbXGJdcQOw84tUbnhGIh3/Y39W1GFcB1YD8pPNnh8ETHQCvKa8
Lma3BxXh/Z3xmZOg+RG+UYLqDPffeOLik/s1gvRBSk4sZWWHchtgEySRE+eu2DkM
PhqGcAV9NDEik45/Rt/hM8qgmeVpir9QU9Ibd8k7wei3XFJ1D4kuAExpxDoVZOLp
w2WBoAnCcQyXmn59Xidro/IGJU3C2VRyzmNGnsvdDTJfjLzSetCOH9n0g7eV/1Lh
futtWk1p07mTnMp5GtVjHEyHfx+pR8uFXCY29jF4reMuy1et29QquDmWpSaAqUXg
ZT5CfgeoejJrInoeZ4B1hXgxDTINnPMryGw7sw1WQK/wfLmiO0E=
=r2Ee
-----END PGP SIGNATURE-----

--w5dxbsyiubkhxxav--
