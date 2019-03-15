Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27462C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BA5218C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzMyDXs0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbfCOLwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 07:52:05 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39793 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbfCOLwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 07:52:04 -0400
Received: by mail-qk1-f193.google.com with SMTP id c189so5278487qke.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 04:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3yy9MbVJf0ytZW6j4gMDoFFEzxHJ57O54xCHeQBKpNs=;
        b=fzMyDXs0rD96nkwdr8LJGFmucZBsgQNllBrTROGxFOzdbycUPk1n6cnT5nGJLsex2w
         oDQIY0Qmn323JUzW1XVBboCg9js0uLKSYz3bnwlsTdx3UacuysXC09XQ4jvsNU4oeZ5q
         zoWk5qxP2VgCDe8KhmB+QqUNm7mLwE0IzgjGq+5u0IYC+0IqYMkd7ooWwGWjJHEeR6h8
         cFTu2yYLc5RugkVzJc3ed35IIVTuQj1n0N1BHOzymBh5p0lIzPtFO/yoc950tcST3Es7
         sVC3+Z01BbfYe8HjM/MWaFD9/K9XjZxRw9poMxPruOqTP4fX1nxr/uxIhLa7nOUMnUVS
         f4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3yy9MbVJf0ytZW6j4gMDoFFEzxHJ57O54xCHeQBKpNs=;
        b=mNrmKvoy3+d/aHOjh46R7r6SZ/Y2RIcrvflVgZ6raqGaqajtISEq2lGXpA4h0DwBsE
         V91Lrr2sb7/Y8Nz2axL6hp8AZCYRXyJWFnkmKFaCZS6u/6Wb3kIyBEuorZa0Dfs05J/k
         8GWeasD2d+z1bY2wDqfqRlyPoxhDzO1QdQTJX/7bedAcgiduV3NaxITO4s9yYfULlTNU
         2BaYFGd+XwJ6XGZIPIlAwdscKbSrPbpaw4QFXnIcV4MhEphSRvZxOPqca7qLfpTTHTl/
         GNg9W/O71fIMLj91OoaZxZReiCZHpOpwZuesMDdMefEMjfCHS/INtt3CMin2NvA/h27t
         WwVQ==
X-Gm-Message-State: APjAAAXB6G5w6Qo5Rm3ESZKTWBkv5gpURxkBWfPe+W1V4/f2qfbqfE3E
        Ae3ePJr31D/+LgKwTniM30s=
X-Google-Smtp-Source: APXvYqymM+xDKEyTQzoodsLYesDCFkYh0drOPjw+qwplNksgX3mGIfAnZzjbwdVdKEi0G2o3zWC5rg==
X-Received: by 2002:a37:c44a:: with SMTP id h10mr2340433qkm.350.1552650723498;
        Fri, 15 Mar 2019 04:52:03 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 10sm1147742qtx.40.2019.03.15.04.51.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 15 Mar 2019 04:52:00 -0700 (PDT)
Date:   Fri, 15 Mar 2019 08:51:57 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Shayenne Moura <shayenneluzmoura@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/vkms: Solve bug on kms_crc_cursor tests
Message-ID: <20190315115157.6jqvnsddzmvz7jar@smtp.gmail.com>
References: <20190225142606.gov32asdq3qe375q@smtp.gmail.com>
 <20190228101107.GL2665@phenom.ffwll.local>
 <20190228140341.GG20097@intel.com>
 <CAKkTe8Ei2fbz4L2noLvGWMCsHy1f7sadOV-horjNsGBEHt=q3w@mail.gmail.com>
 <20190301152558.GR20097@intel.com>
 <CAKkTe8HbgkVm1i2xAFT6ecgv2jFjyoqrSEYUpx_40Uj=ogKYPQ@mail.gmail.com>
 <20190301184147.GS20097@intel.com>
 <20190310203505.2needmil76a4rc74@smtp.gmail.com>
 <20190311142710.GY3888@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ry7coatxgtst4ix3"
Content-Disposition: inline
In-Reply-To: <20190311142710.GY3888@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ry7coatxgtst4ix3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03/11, Ville Syrj=C3=A4l=C3=A4 wrote:
> On Sun, Mar 10, 2019 at 05:35:05PM -0300, Rodrigo Siqueira wrote:
> > On 03/01, Ville Syrj=C3=A4l=C3=A4 wrote:
> > > On Fri, Mar 01, 2019 at 03:35:35PM -0300, Shayenne Moura wrote:
> > > > Em sex, 1 de mar de 2019 =C3=A0s 12:26, Ville Syrj=C3=A4l=C3=A4
> > > > <ville.syrjala@linux.intel.com> escreveu:
> > > > >
> > > > > On Fri, Mar 01, 2019 at 11:55:11AM -0300, Shayenne Moura wrote:
> > > > > > Em qui, 28 de fev de 2019 =C3=A0s 11:03, Ville Syrj=C3=A4l=C3=A4
> > > > > > <ville.syrjala@linux.intel.com> escreveu:
> > > > > > >
> > > > > > > On Thu, Feb 28, 2019 at 11:11:07AM +0100, Daniel Vetter wrote:
> > > > > > > > On Mon, Feb 25, 2019 at 11:26:06AM -0300, Shayenne Moura wr=
ote:
> > > > > > > > > vkms_crc_work_handle needs the value of the actual frame =
to
> > > > > > > > > schedule the workqueue that calls periodically the vblank
> > > > > > > > > handler and the destroy state functions. However, the fra=
me
> > > > > > > > > value returned from vkms_vblank_simulate is updated and
> > > > > > > > > diminished in vblank_get_timestamp because it is not in a
> > > > > > > > > vblank interrupt, and return an inaccurate value.
> > > > > > > > >
> > > > > > > > > Solve this getting the actual vblank frame directly from =
the
> > > > > > > > > vblank->count inside the `struct drm_crtc`, instead of us=
ing
> > > > > > > > > the `drm_accurate_vblank_count` function.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
> > > > > > > >
> > > > > > > > Sorry for the delay, I'm a bit swamped right now :-/
> > > > > > > >
> > > > > > > > Debug work you're doing here is really impressive! But I ha=
ve no idea
> > > > > > > > what's going on. It doesn't look like it's just papering ov=
er a bug (like
> > > > > > > > the in_vblank_irq check we've discussed on irc), but I also=
 have no idea
> > > > > > > > why it works.
> > > > > > > >
> > > > > > > > I'll pull in Ville, he understands this better than me.
> > > > > > >
> > > > > > > It's not entirely clear what we're trying to fix. From what I=
 can see
> > > > > > > the crc work seems to be in no way synchronized with page fli=
ps, so
> > > > > > > I'm not sure how all this is really supposed to work.
> > > > > > >
> > > > > >
> > > > > > Hi, Ville!
> > > > > >
> > > > > > Thank you for the review! :)
> > > > > >
> > > > > > I do not understand well what crc code is doing, but the issue =
that I found
> > > > > > is related to the vblank timestamp and frame count.
> > > > > >
> > > > > > When vkms handles the crc_cursor it uses the start frame and en=
d frame
> > > > > > values to verify if it needs to call the function 'drm_crtc_add=
_crc_entry()'
> > > > > > for each frame.
> > > > > >
> > > > > > However, when getting the frame count, the code is calling the =
function
> > > > > > drm_update_vblank_count(dev, pipe, false) and, because of the '=
false',
> > > > > > subtracting the actual vblank timestamp (consequently, the fram=
e count
> > > > > > value), causing conflicts.
> > > > >
> > > > > The in_vblank_irq behavour looks sane to me. What are these confl=
icts?
> > > > >
> > > >=20
> > > > The entire history was:
> > > >  - I sent the patch with bugfix for vblank extra frame. The patch c=
hanged
> > > >    our function vkms_get_vblank_timestamp() to look like this:
> > > >=20
> > > > bool vkms_get_vblank_timestamp(struct drm_device *dev, unsigned int=
 pipe,
> > > >                    int *max_error, ktime_t *vblank_time,
> > > >                    bool in_vblank_irq)
> > > > {
> > > >     struct vkms_device *vkmsdev =3D drm_device_to_vkms_device(dev);
> > > >     struct vkms_output *output =3D &vkmsdev->output;
> > > >=20
> > > >     *vblank_time =3D output->vblank_hrtimer.node.expires;
> > > >=20
> > > > +   if (!in_vblank_irq)
> > > > +        *vblank_time -=3D output->period_ns;
> > > >=20
> > > >     return true;
> > > > }
> > > >=20
> > > >  - This patch solve the issue that I was looking for (extra vblank
> > > > frames on kms_flip).
> > > >=20
> > > >  - However, kms_cursor_crc tests, which passed before my patch, sta=
rted to fail.
> > > >=20
> > > >  - Debugging them, I found that the problem was inside of function
> > > > `vkms_vblank_simulate()`
> > > > when it was handling the crc_enabled (inside  if (state && output->=
crc_enabled))
> > > > and inside the function vkms_crc_work_handle() too.
> > > >=20
> > > >  - Following the steps:
> > > > 1. Inside vkms_vblank_simulate() we call drm_crtc_accurate_vblank_c=
ount()
> > > > 2. In its turn, drm_crtc_accurate_vblank_count() calls the function
> > > >    drm_update_vblank_count(dev, pipe, false).  /* This false is def=
ault */
> > > > 3. Finally, the =E2=80=9Cfalse=E2=80=9D used in drm_update_vblank_c=
ount(), will be
> > > >   passed to vkms_get_vblank_timestamp() and the condition =E2=80=9C=
if
> > > >   (!in_vblank_irq)=E2=80=9D will be executed multiple times (we don=
=E2=80=99t want it).
> > > >=20
> > > >  - Inside vkms_crc, the issue is that the returned frame value chan=
ge for
> > > > every call of drm_crtc_accurate_vblank_count() because
> > > > in_vblank_irq =3D=3D false.
> >=20
> > Hi Ville,
> > =20
> > > OK. So why is it changing? AFAICS it should not change unless the
> > > timer was moved forward in between the calls.
> >=20
> > Yes Ville, you=E2=80=99re right. We have to update it only when the fun=
ction
> > vkms_vblank_simulate() is invoked (timer move forward), and FWIU we do
> > it when we call drm_crtc_handle_vblank(). However, the current
> > implementation of vkms, has a call to drm_crtc_accurate_vblank_count()
> > inside the vkms_vblank_simulate() which is a problem because it also
> > update the vblank value. FWIU, this patch fixes this issue by taking the
> > count value in the data struct instead of call
> > drm_crtc_accurate_vblank_count() which will avoid the extra update.
>=20
> But why does that extra update change the vblank count?

Hi,

I think that I=E2=80=99m failing to explain the issue and the solution in t=
his
patch, sorry for that... and I apologize in advance for the lengthy
email.

In this sense, allow me to elaborate the whole history in =E2=80=98chronolo=
gical
sections=E2=80=99:

1. About the =E2=80=98fake=E2=80=99 Vblank inside VKMS

Since VKMS is a virtual driver, we do not have real Vblank, and we
simulate it by using hrtimers. I registered the function
vkms_vblank_simulate() as a callback inside hrtimer; in this function,
we do some stuff that can be summarized in the sequence below:

I) drm_crtc_handle_vblank()
II) Check if crc is enabled or not
III) Schedule the next vblank with hrtimer_forward_now()

2. Override the default behaviour for get_vblank_timestamp()

As I told before, everytime that vkms_vblank_simulate() is invoked the
function drm_crtc_handle_vblank() will be requested. For us, the
important thing about drm_crtc_handle_vblank() is the sequence:

 a) drm_crtc_handle_vblank()
 b) drm_handle_vblank()
 c) drm_update_vblank_count()
 d) drm_get_last_vbltimestamp()
 e) get_vblank_timestamp()

Since VKMS is a virtual driver, we cannot rely on the default
implementation of get_vblank_timestamp(). In this context, we
implemented our wrapper named vkms_get_vblank_timestamp(), and we have
to return the expires time from hrtimer to the userspace. In my first
implementation of this function, I had something like:

bool vkms_get_vblank_timestamp(struct drm_device *dev, unsigned int pipe,
                               int *max_error, ktime_t *vblank_time,
                               bool in_vblank_irq)
{
[..]
        *vblank_time =3D output->vblank_hrtimer.node.expires;
        return true;
}

Around 80% of the kms_flip tests were passing with this code. However,
we had some tests that break due to an extra vblank.

3. The extra vblank bug

Shayenne and Daniel figured out that the extra vblank came from the
function drm_crtc_arm_vblank_event() invoked inside the
vkms_crtc_atomic_flush(). If we take a look inside
drm_crtc_arm_vblank_event(), we can find:

void drm_crtc_arm_vblank_event([..])
{
[..]
       e->sequence =3D drm_crtc_accurate_vblank_count(crtc) + 1;
[..]
}

This function increment the sequence by one (there is a detailed
explanation about it in the documentation of this function).

4. The bug fix

After inspecting the code, we identified the following sequence when the
function drm_crtc_arm_vblank_event() is invoked:

 a) drm_crtc_arm_vblank_event()
 b) drm_crtc_accurate_vblank_count()
 c) drm_update_vblank_count(dev, pipe, false)

Noticed that drm_update_vblank_count() is invoked again, but now with
=E2=80=98false=E2=80=99 in the in_vblank_irq because it does not have to re=
port anything
for userspace or something like that. With this in mind, remember that
drm_update_vblank_count() will call get_vblank_timestamp(); with my
first implementation of vkms_get_vblank_timestamp() (see Section 2 for
recap) we will update the vblank_time with the wrong information. After
understanding all of these details and the meaning of the parameter
in_vblank_irq, the following fix was added:

bool vkms_get_vblank_timestamp([..]) {
[..]
        if (!in_vblank_irq)
                *vblank_time -=3D output->period_ns;
[..]
}

With this validation, we can solve the problem of the extra Vblank added
by drm_crtc_arm_vblank_event(). Afterward, all the kms_flip test started
to pass.

5. The new bug on CRC operation

As a side effect of the above change, the CRC tests start to failing.
The question was, why we break the CRC test with that fix?

We start hunting the problem, and the first thing to look is the
function vkms_vblank_simulate(). Inside this function, we have this
code:

vkms_vblank_simulate([..]) {
[..]
        if (state && output->crc_enabled) {
                u64 frame =3D drm_crtc_accurate_vblank_count(crtc);
                [..]
        }

The output->crc_enabled is a module parameter that enables CRC
computation which is required for CRC tests, but not for kms_flip.
Additionally, notice that we save the value of the current frame because
it is necessary to use it on vkms_crc_work_handle(). The only thing that
we need to know about vkms_crc_work_handle() is the fact we call
drm_crtc_add_crc_entry() which requires the frame number, and we also
use it to check if the frame was updated or not.

As I said in Section 2, drm_crtc_accurate_vblank_count() calls
drm_update_vblank_count() with false parameter in in_vblank_irq. Due to
the last change made at vkms_get_vblank_timestamp(), we broke the CRC
code because now we invoke get_vblank_timestamp() multiple times. The
consequence of this change is the excessive decrement of the timestamp
since the following condition execute multiple time:

bool vkms_get_vblank_timestamp([..]) {
        if (!in_vblank_irq)
                *vblank_time -=3D output->period_ns;

6. The bug fix (this patch)

Since we only want the frame number, as I described in Section 5, the
fix is quite simple: avoid call drm_crtc_accurate_vblank_count() and
just get the frame value from the data structure. In this patch,
Shayenne removed the function drm_crtc_accurate_vblank_count() which
avoid the extra decrement in the vkms_get_vblank_timestamp(). With this
patch, everything started to work well.

So... In a few words, it is a VKMS problem, not a vblank issue.

I=E2=80=99m not sure if the solution here is the best one, but I believe th=
at
the idea behind it is correct.

Best Regards

--=20
Rodrigo Siqueira
https://siqueira.tech
Graduate Student
Department of Computer Science
University of S=C3=A3o Paulo

--ry7coatxgtst4ix3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAlyLkdwACgkQWJzP/com
vP9U1hAAhZY7R9ohulns2E52LJM47PS4I78j7ptadIp3FCN4QTVgs6dN6+Tcv56y
2FAJji7zoTa1HrGZngSV2OVgGPvrHZMDxPgUYbwHExzPCPXNFYa9+/Ho4X6zXINr
zVtbZuscTteQVN0jSzuvS/O09g7POWWFrNyou7bHYJEzEovZadA0pDpUT4U3UZeA
efPCP4hVD7ckOAOKFGZeyhvgXwC26R+eLZ/7xaWL7HivhFWYYltgkDMEmOMefy+F
nAoVNeV7rrRo0HAiwt7dNwTwG0SfgpvfTScwSUAJYzUXiUBmy0Ql5HsX0uNEOJop
Yvni+/GGQjaV3850f58eZF1ozGpwe94X7e8gOP+ZDphtaRPjBkWlKswCthP/844n
+yTgloPaltw437NYCZX+X8ncbB9t+BM3YqXNQ+MKsXQ5YqJdZ900TrTfqlRhN8d4
IDJGAC5E5656urvBOfBochX7ifouBHh/jbvV+rG3fXhGckBgTMeybQ3NSOhbMuwA
grcPC2GlDaf/lppv/3DOarao+DhkJH0wL+bAbPQo3ahShkPeeUtbD6+jvUmqqlSX
16+S2X/gombHHkywqHmMyZHrSuVCp1LuTs3B6qzAzUHkt0Q8I9f2RfliEcgEDEJl
C2bfne5kA80ZvllbkGFcr3jIfOtm3FDTVVZqeaCLrdfEIlUziD8=
=XzZy
-----END PGP SIGNATURE-----

--ry7coatxgtst4ix3--
