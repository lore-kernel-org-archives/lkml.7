Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D1EC5B57A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55D8205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="QKAhIMJC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfF1Ocq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 10:32:46 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46374 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfF1Ocq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 10:32:46 -0400
Received: by mail-qk1-f195.google.com with SMTP id x18so4937548qkn.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 07:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=b/VyFcq1YJ2hxUvdovxOiEKbEzmaJpPeA9q+/rB+TOE=;
        b=QKAhIMJCyfvq8ipubLyWBuEf4QI45ml2pt0+ScXCbno9BKFzi8+bMdUScNxXob6Q0R
         xJOgr0BZpg5HCTtndDGu0gJEonHvIjxhAh7QLnNvawoZtQksFRgX2xF7Vkt8Rk1/m5To
         bOKsbbyp5EJ1LUCagrxqOViBsspQ/E9EBwvAHF7sGd+OEOHJmuT12oetFJUzSI/qjnFz
         4sfvJtVT3yUMoUSW93ZZT7k5VbJbaVlWnjwT/7tJS7yy1ndoSzt5mhdtpBIFndPwQRuQ
         uPh8rpKAGaLNwMJLefhE9Li4Hb8l1EuYyaTLt2/u1E7rA3QDCxbub/ShEZvF/dD87AHh
         UvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=b/VyFcq1YJ2hxUvdovxOiEKbEzmaJpPeA9q+/rB+TOE=;
        b=pNK9RPo92Rq5zF+sQI3B0z8maaSMObOyfH1208y9nEt+m2qVlPV+29+jHQIsHYCSfN
         Gm6zxqsdV9dZ5lrRDw20cxb9AQvVOr5svP9UtNQQ94j0lL5z8RaM3glILZEqIzvhG/hH
         mUi2QOnf+wT8J41yZr6G/7w6YjXgCCazlmnNCEKLlhzdqITFOuqYMpzTxB6a99WaOPOS
         XC79fUvpSiKv6YtVWXSy4toRCW2BoyTqnbUMNbwW1ER7BRGiyHi7VPYAe4fLjJy0U1bh
         rWlQI8cv1YWuY5lxDLfPJEUZNIPOhiaYw/jBRKAVoYkU4ENi/aGNRqP5qkaDEzG1TM1Z
         DOEQ==
X-Gm-Message-State: APjAAAXGxL9gEWJcyJIixJ3kFpIuHDdxEdiIlNIYob1l8j9X4RQGHDxP
        1FsMR01lHg+r0nKc4DDpu4L8Cw==
X-Google-Smtp-Source: APXvYqyz0lJldcKE3SPWJvYpAF0+y6yMm/RZDxgTWd7BVRw4w2oGx1z00CGt/CM6vViYlFUFtLTGzA==
X-Received: by 2002:a37:ac0a:: with SMTP id e10mr9158150qkm.168.1561732365207;
        Fri, 28 Jun 2019 07:32:45 -0700 (PDT)
Received: from tpx230-nicolas.collaboramtl (modemcable154.55-37-24.static.videotron.ca. [24.37.55.154])
        by smtp.gmail.com with ESMTPSA id k58sm1204995qtc.38.2019.06.28.07.32.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 07:32:44 -0700 (PDT)
Message-ID: <b80bb605a3415f25b7e7ce9d059eaeb7ac75c392.camel@ndufresne.ca>
Subject: Re: [PATCH v2 00/11] Venus stateful Codec API
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>
Date:   Fri, 28 Jun 2019 10:32:42 -0400
In-Reply-To: <18f834cb4885357ce6274115096911d90b9c17ea.camel@ndufresne.ca>
References: <20190628130002.24293-1-stanimir.varbanov@linaro.org>
         <9c3399a8-4fc6-3117-10ee-3395cee034da@xs4all.nl>
         <997204c7-c702-868c-9a49-52fefc9ab3d2@linaro.org>
         <eba506ce-4d63-649a-80e6-efad20125263@xs4all.nl>
         <18f834cb4885357ce6274115096911d90b9c17ea.camel@ndufresne.ca>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-pSr0hzxtAFSGmHdsy/A9"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pSr0hzxtAFSGmHdsy/A9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le vendredi 28 juin 2019 =C3=A0 10:31 -0400, Nicolas Dufresne a =C3=A9crit =
:
> Le vendredi 28 juin 2019 =C3=A0 16:25 +0200, Hans Verkuil a =C3=A9crit :
> > On 6/28/19 4:23 PM, Stanimir Varbanov wrote:
> > > Hi Hans,
> > >=20
> > > On 6/28/19 4:37 PM, Hans Verkuil wrote:
> > > > On 6/28/19 2:59 PM, Stanimir Varbanov wrote:
> > > > > Hello,
> > > > >=20
> > > > > Here is v2 of the Venus transition to stateful codec API
> > > > > compliance. The v2 can be found at [1].
> > > > >=20
> > > > > Changes since v1:
> > > > >  * codec_state is now enum
> > > > >  * dropped IS_OUT and IS_CAP macros and use vb2_start_streaming_c=
alled()
> > > > >  * corrected g_fmt and reconfig logic
> > > > >  * s/vdec_dst_buffers_done/vdec_cancel_dst_buffers
> > > > >  * use v4l2_m2m_ioctl_try_decoder_cmd M2M helper
> > > > >  * various fixes to make v4l2-compliance pass the streaming test
> > > > >=20
> > > > > To test the streaming with --stream-from-hdr v4l2-compliance opti=
on I have
> > > > > to make the following hack (it is needed because the size of deco=
der input
> > > > > buffers (OUTPUT queue) is not enough for the h264 bitstream, i.e =
the driver
> > > > > default resolution is 64x64 but the h264 stream is 320x240):
> > > > >=20
> > > > > diff --git a/utils/v4l2-compliance/v4l2-test-buffers.cpp b/utils/=
v4l2-compliance/v4l2-test-buffers.cpp
> > > > > index c71dcf65b721..dc0fcf20d3e4 100644
> > > > > --- a/utils/v4l2-compliance/v4l2-test-buffers.cpp
> > > > > +++ b/utils/v4l2-compliance/v4l2-test-buffers.cpp
> > > > > @@ -1294,6 +1294,11 @@ int testMmap(struct node *node, unsigned f=
rame_count, enum poll_mode pollmode)
> > > > >                                         fmt.s_sizeimage(fmt.g_siz=
eimage(p) * 2, p);
> > > > >                         }
> > > > >                         fail_on_test(q.create_bufs(node, 1, &fmt)=
);
> > > > > +
> > > > > +                       for (unsigned p =3D 0; p < fmt.g_num_plan=
es(); p++)
> > > > > +                               fmt.s_sizeimage(fmt.g_sizeimage(p=
) * 2, p);
> > > > > +                       node->s_fmt(fmt);
> > > > > +
> > > > >                         fail_on_test(q.reqbufs(node, 2));
> > > > >                 }
> > > > >                 if (v4l_type_is_output(type))
> > > >=20
> > > > Does the venus driver set sizeimage based on the given output resol=
ution?
> > >=20
> > > Yes.
> > >=20
> > > > E.g. if v4l2-compliance would first set the output resolution to 32=
0x240,
> > > > is the returned sizeimage value OK in that case?
> > >=20
> > > Yes.
> > >=20
> > > Here are few options to me:
> > >  - set the correct resolution
> > >  - set 0x0 and sizeimage at some arbitrary value (1 or 2MB). Despite =
if
> > > the bitstream is 4K it will not be enough if the bitrate is huge.
> > >  - invent some mechanism to trigger reconfiguration on the OUTPUT que=
ue
> > > as well (similar to the CAPTURE queue)
> > >=20
> > > > And this also means that the venus driver requires each buffer to h=
ave
> > > > a single compressed frame, right? I.e. it can't be spread over mult=
iple
> > > > OUTPUT buffers.
> > >=20
> > > I cannot say for sure but that is how all downstream cases uses it i.=
e.
> > > one compressed frame per input buffer. I wonder if you fill input
> > > decoder buffer with many compressed frames in one input decoder buffe=
r
> > > how you pass the timestamp for every packet?
> > >=20
> > > > We really need to let userspace know about such restrictions.
> > > >=20
> > > > Stanimir, can you list the restrictions of the decoder for the vari=
ous
> > > > codecs?
> > >=20
> > > What you mean? Restrictions like "one compressed frame per input buff=
er"?
> > >=20
> >=20
> > Yes :-)
>=20
> I think I just had the same discussions through some RPi patches
> reviews. All the stateless codec drivers we have so far assumes full
> frames and some wording iirc specified this in the spec at some point.
> That removes ambiguity for timestamps application. Even though,
> timestamps in V4L2 are useless for B-Frame enabled streams (ffmpeg and
> GStreamer will ignore them).

Sorry, I mean they are not used as timestamp, only for frame matching.

>=20
> Nicolas

--=-pSr0hzxtAFSGmHdsy/A9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSScpfJiL+hb5vvd45xUwItrAaoHAUCXRYlCwAKCRBxUwItrAao
HMUmAKDBMvX7IXX19rNtnkwTxPDJWIMBtQCcDfhAV45LnvNuGP4wx/mxk1cqAJg=
=xKKh
-----END PGP SIGNATURE-----

--=-pSr0hzxtAFSGmHdsy/A9--

