Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24033C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE6320672
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="j1h4vOoi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfKVQwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 11:52:10 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37914 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVQwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 11:52:10 -0500
Received: by mail-qk1-f194.google.com with SMTP id e2so6862808qkn.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 08:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=oz+QGCoRKKLNBn1J0LTgNGDFShCE3Rvj+eur+Kujt+U=;
        b=j1h4vOoi3aE5Ab0Ery0Z98gHQPOt9iBuojfwjn0gKa8Wd9Ugjw0YHSkxwzXfGnrX3m
         hqVbHeCFsvaQBRRo7Cop0qX/G/adSCJ4m510ZaDa3iWNGUDwV3G41pn6Oy+Ux6KTDF/W
         cjuAN6ltL6XOOKi9h+OrItXPl8iLIZxAa09fW/goMT0ezFSNzhmMCMRvNtUERSApl7+v
         MRY/PgA6QCIZMTxHtImyHik+466mhdQ9ArJ7GOQA2ycKjAAf9CLldNhTujKa/Nwt43QV
         F7oDov2pQ8UAPqxbNCpfdC59O9Q3i+gDg1TqRZYX5aT9uGhgIB6pFD0IKS3qERjoguZY
         BnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=oz+QGCoRKKLNBn1J0LTgNGDFShCE3Rvj+eur+Kujt+U=;
        b=UH3XdrUz7+fdhQq9x1Qi0Fcayp9/G1lIlZ1R1IxP4mZeV9/cCOsGSHwHKnmQU2op7M
         INWahG+tDZ7bJ/Ov/KH27nNdV1Qe/FpPtZxUCvY39RbYgrNutycVKL9BnGs3m9IBPzOH
         0EmyGHC4II4BoWAdfokuWUL8N31rvbCjoTu1k4vCA2/TDbnodSidAwJAOh0YHqAMqtkT
         iaSYEHXQzAYEjM+59qGGe453SUTLLPpYDjUb+egvJzHPl0Nzg/PLjGDbcMx6tp1ronjV
         KFr9X/IjMUtLWvbW2rvuKU9i4keOdoDqUeVVXyvOsUpWjsI/ZJp05I1SjCLnFXzJfoAx
         PT8Q==
X-Gm-Message-State: APjAAAVse2fRC71hXJBM6S/wrmZj8vR6bpASmlqVSdCBw+5evwSMGeUy
        I/MHS+Gkp7tjPkbztomhb4cgmA==
X-Google-Smtp-Source: APXvYqyzJ4ny5GR6UKdaVlpzoR0g7N+dRHxbOkUrqU6nQADHUPfI7L2wPyZZYxTVsWSVFOL65OmLqA==
X-Received: by 2002:a37:4bc2:: with SMTP id y185mr14562500qka.474.1574441528764;
        Fri, 22 Nov 2019 08:52:08 -0800 (PST)
Received: from tpx230-nicolas ([2610:98:8005::d0])
        by smtp.gmail.com with ESMTPSA id h44sm3942382qtc.1.2019.11.22.08.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 08:52:07 -0800 (PST)
Message-ID: <f5341ed837529bd38d466d4b655e261d64065912.camel@ndufresne.ca>
Subject: Re: [PATCH] media: hantro: Support H264 profile control
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Hirokazu Honda <hiroh@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 22 Nov 2019 11:52:05 -0500
In-Reply-To: <CAAFQd5D3OpAAtX7_0ktz4-aAgWN_G4YBQMR=Vwp7JPopjvRkRA@mail.gmail.com>
References: <20191122051608.128717-1-hiroh@chromium.org>
         <767528be59275265072896e5c679e97575615fdd.camel@ndufresne.ca>
         <CAAFQd5D3OpAAtX7_0ktz4-aAgWN_G4YBQMR=Vwp7JPopjvRkRA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-EkBdMYKPQvs+VUkT8iK1"
User-Agent: Evolution 3.34.1 (3.34.1-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EkBdMYKPQvs+VUkT8iK1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le samedi 23 novembre 2019 =C3=A0 01:00 +0900, Tomasz Figa a =C3=A9crit :
> On Sat, Nov 23, 2019 at 12:09 AM Nicolas Dufresne <nicolas@ndufresne.ca> =
wrote:
> > Le vendredi 22 novembre 2019 =C3=A0 14:16 +0900, Hirokazu Honda a =C3=
=A9crit :
> > > The Hantro G1 decoder supports H.264 profiles from Baseline to High, =
with
> > > the exception of the Extended profile.
> > >=20
> > > Expose the V4L2_CID_MPEG_VIDEO_H264_PROFILE control, so that the
> > > applications can query the driver for the list of supported profiles.
> >=20
> > Thanks for this patch. Do you think we could also add the LEVEL control
> > so the profile/level enumeration becomes complete ?
> >=20
> > I'm thinking it would be nice if the v4l2 compliance test make sure
> > that codecs do implement these controls (both stateful and stateless),
> > it's essential for stack with software fallback, or multiple capable
> > codec hardware but with different capabilities.
> >=20
>=20
> Level is a difficult story, because it also specifies the number of
> macroblocks per second, but for decoders like this the number of
> macroblocks per second it can handle depends on things the driver
> might be not aware of - clock frequencies, DDR throughput, system
> load, etc.
>=20
> My take on this is that the decoder driver should advertise the
> highest resolution the decoder can handle due to hardware constraints.
> Performance related things depend on the integration details and
> should be managed elsewhere. For example Android and Chrome OS manage
> expected decoding performance in per-board configuration files.

When you read datasheet, the HW is always rated to maximum level (and
it's a range) with the assumption of a single stream. It seems much
easier to expose this as-is, statically then to start doing some math
with data that isn't fully exposed to the user. This is about filtering
of multiple CODEC instances, it does not need to be rocket science,
specially that the amount of missing data is important (e.g. usage of
tiles, compression, IPP all have an impact on the final performance).
All we want to know in userspace is if this HW is even possibly capable
of LEVEL X, and if not, we'll look for another one.

>=20
> > > Signed-off-by: Hirokazu Honda <hiroh@chromium.org>
> > > ---
> > >  drivers/staging/media/hantro/hantro_drv.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >=20
> > > diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/stag=
ing/media/hantro/hantro_drv.c
> > > index 6d9d41170832..9387619235d8 100644
> > > --- a/drivers/staging/media/hantro/hantro_drv.c
> > > +++ b/drivers/staging/media/hantro/hantro_drv.c
> > > @@ -355,6 +355,16 @@ static const struct hantro_ctrl controls[] =3D {
> > >                       .def =3D V4L2_MPEG_VIDEO_H264_START_CODE_ANNEX_=
B,
> > >                       .max =3D V4L2_MPEG_VIDEO_H264_START_CODE_ANNEX_=
B,
> > >               },
> > > +     }, {
> > > +             .codec =3D HANTRO_H264_DECODER,
> > > +             .cfg =3D {
> > > +                     .id =3D V4L2_CID_MPEG_VIDEO_H264_PROFILE,
> > > +                     .min =3D V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
> > > +                     .max =3D V4L2_MPEG_VIDEO_H264_PROFILE_HIGH,
> > > +                     .menu_skip_mask =3D
> > > +                     BIT(V4L2_MPEG_VIDEO_H264_PROFILE_EXTENDED),
> > > +                     .def =3D V4L2_MPEG_VIDEO_H264_PROFILE_MAIN,
> > > +             }
> > >       }, {
> > >       },
> > >  };

--=-EkBdMYKPQvs+VUkT8iK1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSScpfJiL+hb5vvd45xUwItrAaoHAUCXdgSNQAKCRBxUwItrAao
HGwvAKCHsop1nLCCcwqY6OC/VhAQ+SZlSQCfZOTuCZtzisd//KjRmwOYxdsfx00=
=pnDn
-----END PGP SIGNATURE-----

--=-EkBdMYKPQvs+VUkT8iK1--

