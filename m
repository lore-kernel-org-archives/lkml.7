Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38D4C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837FA20850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="d6c2Amrh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387656AbfDJQFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:05:45 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35825 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbfDJQFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:05:44 -0400
Received: by mail-qt1-f194.google.com with SMTP id h39so3520124qte.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 09:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=Jh9uAXxulGOY2KDc3Y6G0joBKw8Zne8VkheIfBP6RzE=;
        b=d6c2AmrhIK2HkO+BNTAT4TTFjOcBYlMGGgjtvx//d2S0nOa92J9SEKb6RI9FbO53Hl
         z8O4LHP4aJTrX+oWUM9BLCdsM73vgVc2MnQK5JoUOqhtoSh9jOZGtTsZ4i7Tq4lTt159
         vfEWMyhSgXS1wiu7ZyK4OSNvvVz1T0ZIWToyiYw0YDxbTS4U0zPr/kqEQJwuj3DPWQR6
         HaLLFYRZOILC/YMbfaPBvFiXdZ7ICGOCaDA5ULh4ydtkKocVXMBcKFXiFrJn4qLDp5EH
         l1MtzhVnSdxsm+ko6OogumBMoLJSe6IN5N6TvhqzKRATjI6qk3GuRIRBYk8P+FUNKqqL
         j2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=Jh9uAXxulGOY2KDc3Y6G0joBKw8Zne8VkheIfBP6RzE=;
        b=h5sx8tZIb24pVsYh8wXZBN3MPjirNqV+NYbANg2Ce5YKaFDze9GoGiwNRInupl1KZp
         fEA4HODsVGjYlc4Jae6T2SPFXmemRMmfwMCpbue4LrYQgm9PVjNEXizmoU/+6ml2vgxX
         nlbcyKxgZCIf2nCz0qb0X62FUKMJuum0W9LF2koTcS99YRjORcnTPacZF96C4FVV3Vni
         gYkABTHfELEmcMKmLlVg7NAYmNM4xhPiceX1eQE3thgs1hQrs+xvVSvuwyE77eG9/qgY
         ZfvkuyzfgJcqRjma3l1BNsRlgTBCJL4Lb7MJxGXv9hVQ0GnAyxkwzYqCOwbtI6htoQyA
         11cw==
X-Gm-Message-State: APjAAAVQmQACMNpsraDqgxsC0HlLLXag/8JhHU1dHXlGn9vQ0YDwLtxt
        ROqOMwagN7nLHUcOGVJRIvcVxQ==
X-Google-Smtp-Source: APXvYqwZ4EIXsxV3UphHD7aAYgmkpiv5NxbBIPCuqLqDTGQ+960+vXPDUALwMNhQ24dbPiSm3+r5UQ==
X-Received: by 2002:ac8:1b63:: with SMTP id p32mr37642035qtk.173.1554912342613;
        Wed, 10 Apr 2019 09:05:42 -0700 (PDT)
Received: from tpx230-nicolas (modemcable154.55-37-24.static.videotron.ca. [24.37.55.154])
        by smtp.gmail.com with ESMTPSA id n5sm20455057qkk.4.2019.04.10.09.05.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 09:05:41 -0700 (PDT)
Message-ID: <03751bb884a443ec1cea7b5c023c9d520ffcc3a0.camel@ndufresne.ca>
Subject: Re: [PATCH v3 2/2] media: docs-rst: Document memory-to-memory video
 encoder interface
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Hans Verkuil <hverkuil@xs4all.nl>, Tomasz Figa <tfiga@chromium.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Kamil Debski <kamil@wypas.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jeongtae Park <jtp.park@samsung.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tiffany Lin =?UTF-8?Q?=28=E6=9E=97=E6=85=A7=E7=8F=8A=29?= 
        <tiffany.lin@mediatek.com>,
        Andrew-CT Chen =?UTF-8?Q?=28=E9=99=B3=E6=99=BA=E8=BF=AA=29?= 
        <andrew-ct.chen@mediatek.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dave.stevenson@raspberrypi.org,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Date:   Wed, 10 Apr 2019 12:05:39 -0400
In-Reply-To: <1ec36515-b6ec-b355-47fb-2fe5ad4b3241@xs4all.nl>
References: <20190124100419.26492-1-tfiga@chromium.org>
         <20190124100419.26492-3-tfiga@chromium.org>
         <4bbe4ce4-615a-b981-0855-cd78c7a002d9@xs4all.nl>
         <471720b7-e304-271b-256d-a3dd394773c9@xs4all.nl>
         <CAAFQd5Au_=08pVom1z3C1nHKdKak8Y4d5odR6fiNB4urDhfjKQ@mail.gmail.com>
         <787ddc1f-388d-82be-2702-0d7d256f636c@xs4all.nl>
         <CAAFQd5DozydYBpEceFTbJSutP+gwjxybpd1q6N1Vi+YragQT+w@mail.gmail.com>
         <6cb0caf1-61a6-0719-1ade-1dcf8ed8a020@xs4all.nl>
         <CAAFQd5DdDv+Nu0Dry1XRpYAnz0DrSE5kEf7GxY64tg6aJebzMQ@mail.gmail.com>
         <1ec36515-b6ec-b355-47fb-2fe5ad4b3241@xs4all.nl>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-Bw8g8yr+c7woSQXcNO9C"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Bw8g8yr+c7woSQXcNO9C
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mercredi 10 avril 2019 =C3=A0 10:50 +0200, Hans Verkuil a =C3=A9crit :
> On 4/9/19 11:35 AM, Tomasz Figa wrote:
> > On Mon, Apr 8, 2019 at 8:11 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
> > > On 4/8/19 11:23 AM, Tomasz Figa wrote:
> > > > On Fri, Apr 5, 2019 at 7:03 PM Hans Verkuil <hverkuil@xs4all.nl> wr=
ote:
> > > > > On 4/5/19 10:12 AM, Tomasz Figa wrote:
> > > > > > On Thu, Mar 14, 2019 at 10:57 PM Hans Verkuil <hverkuil@xs4all.=
nl> wrote:
> > > > > > > Hi Tomasz,
> > > > > > >=20
> > > > > > > Some more comments...
> > > > > > >=20
> > > > > > > On 1/29/19 2:52 PM, Hans Verkuil wrote:
> > > > > > > > Hi Tomasz,
> > > > > > > >=20
> > > > > > > > Some comments below. Nothing major, so I think a v4 should =
be ready to be
> > > > > > > > merged.
> > > > > > > >=20
> > > > > > > > On 1/24/19 11:04 AM, Tomasz Figa wrote:
> > > > > > > > > Due to complexity of the video encoding process, the V4L2=
 drivers of
> > > > > > > > > stateful encoder hardware require specific sequences of V=
4L2 API calls
> > > > > > > > > to be followed. These include capability enumeration, ini=
tialization,
> > > > > > > > > encoding, encode parameters change, drain and reset.
> > > > > > > > >=20
> > > > > > > > > Specifics of the above have been discussed during Media W=
orkshops at
> > > > > > > > > LinuxCon Europe 2012 in Barcelona and then later Embedded=
 Linux
> > > > > > > > > Conference Europe 2014 in D=C3=BCsseldorf. The de facto C=
odec API that
> > > > > > > > > originated at those events was later implemented by the d=
rivers we already
> > > > > > > > > have merged in mainline, such as s5p-mfc or coda.
> > > > > > > > >=20
> > > > > > > > > The only thing missing was the real specification include=
d as a part of
> > > > > > > > > Linux Media documentation. Fix it now and document the en=
coder part of
> > > > > > > > > the Codec API.
> > > > > > > > >=20
> > > > > > > > > Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> > > > > > > > > ---
> > > > > > > > >  Documentation/media/uapi/v4l/dev-encoder.rst  | 586 ++++=
++++++++++++++
> > > > > > > > >  Documentation/media/uapi/v4l/dev-mem2mem.rst  |   1 +
> > > > > > > > >  Documentation/media/uapi/v4l/pixfmt-v4l2.rst  |   5 +
> > > > > > > > >  Documentation/media/uapi/v4l/v4l2.rst         |   2 +
> > > > > > > > >  .../media/uapi/v4l/vidioc-encoder-cmd.rst     |  38 +-
> > > > > > > > >  5 files changed, 617 insertions(+), 15 deletions(-)
> > > > > > > > >  create mode 100644 Documentation/media/uapi/v4l/dev-enco=
der.rst
> > > > > > > > >=20
> > > > > > > > > diff --git a/Documentation/media/uapi/v4l/dev-encoder.rst=
 b/Documentation/media/uapi/v4l/dev-encoder.rst
> > > > > > > > > new file mode 100644
> > > > > > > > > index 000000000000..fb8b05a132ee
> > > > > > > > > --- /dev/null
> > > > > > > > > +++ b/Documentation/media/uapi/v4l/dev-encoder.rst
> > > > > > > > > @@ -0,0 +1,586 @@
> > > > > > > > > +.. -*- coding: utf-8; mode: rst -*-
> > > > > > > > > +
> > > > > > > > > +.. _encoder:
> > > > > > > > > +
> > > > > > > > > +*************************************************
> > > > > > > > > +Memory-to-memory Stateful Video Encoder Interface
> > > > > > > > > +*************************************************
> > > > > > > > > +
> > > > > > > > > +A stateful video encoder takes raw video frames in displ=
ay order and encodes
> > > > > > > > > +them into a bitstream. It generates complete chunks of t=
he bitstream, including
> > > > > > > > > +all metadata, headers, etc. The resulting bitstream does=
 not require any
> > > > > > > > > +further post-processing by the client.
> > > > > > > > > +
> > > > > > > > > +Performing software stream processing, header generation=
 etc. in the driver
> > > > > > > > > +in order to support this interface is strongly discourag=
ed. In case such
> > > > > > > > > +operations are needed, use of the Stateless Video Encode=
r Interface (in
> > > > > > > > > +development) is strongly advised.
> > > > > > > > > +
> > > > > > > > > +Conventions and notation used in this document
> > > > > > > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > > > > > > > > +
> > > > > > > > > +1. The general V4L2 API rules apply if not specified in =
this document
> > > > > > > > > +   otherwise.
> > > > > > > > > +
> > > > > > > > > +2. The meaning of words "must", "may", "should", etc. is=
 as per `RFC
> > > > > > > > > +   2119 <https://tools.ietf.org/html/rfc2119>`_.
> > > > > > > > > +
> > > > > > > > > +3. All steps not marked "optional" are required.
> > > > > > > > > +
> > > > > > > > > +4. :c:func:`VIDIOC_G_EXT_CTRLS` and :c:func:`VIDIOC_S_EX=
T_CTRLS` may be used
> > > > > > > > > +   interchangeably with :c:func:`VIDIOC_G_CTRL` and :c:f=
unc:`VIDIOC_S_CTRL`,
> > > > > > > > > +   unless specified otherwise.
> > > > > > > > > +
> > > > > > > > > +5. Single-planar API (see :ref:`planar-apis`) and applic=
able structures may be
> > > > > > > > > +   used interchangeably with multi-planar API, unless sp=
ecified otherwise,
> > > > > > > > > +   depending on decoder capabilities and following the g=
eneral V4L2 guidelines.
> > > > > > > > > +
> > > > > > > > > +6. i =3D [a..b]: sequence of integers from a to b, inclu=
sive, i.e. i =3D
> > > > > > > > > +   [0..2]: i =3D 0, 1, 2.
> > > > > > > > > +
> > > > > > > > > +7. Given an ``OUTPUT`` buffer A, then A=E2=80=99 represe=
nts a buffer on the ``CAPTURE``
> > > > > > > > > +   queue containing data that resulted from processing b=
uffer A.
> > > > > > > > > +
> > > > > > > > > +Glossary
> > > > > > > > > +=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > +
> > > > > > > > > +Refer to :ref:`decoder-glossary`.
> > > > > > > > > +
> > > > > > > > > +State machine
> > > > > > > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > +
> > > > > > > > > +.. kernel-render:: DOT
> > > > > > > > > +   :alt: DOT digraph of encoder state machine
> > > > > > > > > +   :caption: Encoder state machine
> > > > > > > > > +
> > > > > > > > > +   digraph encoder_state_machine {
> > > > > > > > > +       node [shape =3D doublecircle, label=3D"Encoding"]=
 Encoding;
> > > > > > > > > +
> > > > > > > > > +       node [shape =3D circle, label=3D"Initialization"]=
 Initialization;
> > > > > > > > > +       node [shape =3D circle, label=3D"Stopped"] Stoppe=
d;
> > > > > > > > > +       node [shape =3D circle, label=3D"Drain"] Drain;
> > > > > > > > > +       node [shape =3D circle, label=3D"Reset"] Reset;
> > > > > > > > > +
> > > > > > > > > +       node [shape =3D point]; qi
> > > > > > > > > +       qi -> Initialization [ label =3D "open()" ];
> > > > > > > > > +
> > > > > > > > > +       Initialization -> Encoding [ label =3D "Both queu=
es streaming" ];
> > > > > > > > > +
> > > > > > > > > +       Encoding -> Drain [ label =3D "V4L2_DEC_CMD_STOP"=
 ];
> > > > > > > > > +       Encoding -> Reset [ label =3D "VIDIOC_STREAMOFF(C=
APTURE)" ];
> > > > > > > > > +       Encoding -> Stopped [ label =3D "VIDIOC_STREAMOFF=
(OUTPUT)" ];
> > > > > > > > > +       Encoding -> Encoding;
> > > > > > > > > +
> > > > > > > > > +       Drain -> Stopped [ label =3D "All CAPTURE\nbuffer=
s dequeued\nor\nVIDIOC_STREAMOFF(CAPTURE)" ];
> > > > > > > > > +       Drain -> Reset [ label =3D "VIDIOC_STREAMOFF(CAPT=
URE)" ];
> > > > > > > > > +
> > > > > > > > > +       Reset -> Encoding [ label =3D "VIDIOC_STREAMON(CA=
PTURE)" ];
> > > > > > > > > +       Reset -> Initialization [ label =3D "VIDIOC_REQBU=
FS(OUTPUT, 0)" ];
> > > > > > > > > +
> > > > > > > > > +       Stopped -> Encoding [ label =3D "V4L2_DEC_CMD_STA=
RT\nor\nVIDIOC_STREAMON(OUTPUT)" ];
> > > > > > > > > +       Stopped -> Reset [ label =3D "VIDIOC_STREAMOFF(CA=
PTURE)" ];
> > > > > > > > > +   }
> > > > > > > > > +
> > > > > > > > > +Querying capabilities
> > > > > > > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > > > > > > > > +
> > > > > > > > > +1. To enumerate the set of coded formats supported by th=
e encoder, the
> > > > > > > > > +   client may call :c:func:`VIDIOC_ENUM_FMT` on ``CAPTUR=
E``.
> > > > > > > > > +
> > > > > > > > > +   * The full set of supported formats will be returned,=
 regardless of the
> > > > > > > > > +     format set on ``OUTPUT``.
> > > > > > > > > +
> > > > > > > > > +2. To enumerate the set of supported raw formats, the cl=
ient may call
> > > > > > > > > +   :c:func:`VIDIOC_ENUM_FMT` on ``OUTPUT``.
> > > > > > > > > +
> > > > > > > > > +   * Only the formats supported for the format currently=
 active on ``CAPTURE``
> > > > > > > > > +     will be returned.
> > > > > > > > > +
> > > > > > > > > +   * In order to enumerate raw formats supported by a gi=
ven coded format,
> > > > > > > > > +     the client must first set that coded format on ``CA=
PTURE`` and then
> > > > > > > > > +     enumerate the formats on ``OUTPUT``.
> > > > > > > > > +
> > > > > > > > > +3. The client may use :c:func:`VIDIOC_ENUM_FRAMESIZES` t=
o detect supported
> > > > > > > > > +   resolutions for a given format, passing desired pixel=
 format in
> > > > > > > > > +   :c:type:`v4l2_frmsizeenum` ``pixel_format``.
> > > > > > > > > +
> > > > > > > > > +   * Values returned by :c:func:`VIDIOC_ENUM_FRAMESIZES`=
 for a coded pixel
> > > > > > > > > +     format will include all possible coded resolutions =
supported by the
> > > > > > > > > +     encoder for given coded pixel format.
> > > > > > > > > +
> > > > > > > > > +   * Values returned by :c:func:`VIDIOC_ENUM_FRAMESIZES`=
 for a raw pixel format
> > > > > > > > > +     will include all possible frame buffer resolutions =
supported by the
> > > > > > > > > +     encoder for given raw pixel format and coded format=
 currently set on
> > > > > > > > > +     ``CAPTURE``.
> > > > > > > > > +
> > > > > > > > > +4. Supported profiles and levels for the coded format cu=
rrently set on
> > > > > > > > > +   ``CAPTURE``, if applicable, may be queried using thei=
r respective controls
> > > > > > > > > +   via :c:func:`VIDIOC_QUERYCTRL`.
> > > > > > > > > +
> > > > > > > > > +5. Any additional encoder capabilities may be discovered=
 by querying
> > > > > > > > > +   their respective controls.
> > > > > > > > > +
> > > > > > > > > +Initialization
> > > > > > > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > +
> > > > > > > > > +1. Set the coded format on the ``CAPTURE`` queue via :c:=
func:`VIDIOC_S_FMT`
> > > > > > > > > +
> > > > > > > > > +   * **Required fields:**
> > > > > > > > > +
> > > > > > > > > +     ``type``
> > > > > > > > > +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``CA=
PTURE``
> > > > > > > > > +
> > > > > > > > > +     ``pixelformat``
> > > > > > > > > +         the coded format to be produced
> > > > > > > > > +
> > > > > > > > > +     ``sizeimage``
> > > > > > > > > +         desired size of ``CAPTURE`` buffers; the encode=
r may adjust it to
> > > > > > > > > +         match hardware requirements
> > > > > > > > > +
> > > > > > > > > +     ``width``, ``height``
> > > > > > > > > +         ignored (always zero)
> > > > > > > > > +
> > > > > > > > > +     other fields
> > > > > > > > > +         follow standard semantics
> > > > > > > > > +
> > > > > > > > > +   * **Return fields:**
> > > > > > > > > +
> > > > > > > > > +     ``sizeimage``
> > > > > > > > > +         adjusted size of ``CAPTURE`` buffers
> > > > > > > > > +
> > > > > > > > > +   .. important::
> > > > > > > > > +
> > > > > > > > > +      Changing the ``CAPTURE`` format may change the cur=
rently set ``OUTPUT``
> > > > > > > > > +      format. The encoder will derive a new ``OUTPUT`` f=
ormat from the
> > > > > > > > > +      ``CAPTURE`` format being set, including resolution=
, colorimetry
> > > > > > > > > +      parameters, etc. If the client needs a specific ``=
OUTPUT`` format, it
> > > > > > > > > +      must adjust it afterwards.
> > > > > > > >=20
> > > > > > > > Hmm, "including resolution": if width and height are set to=
 0, what should the
> > > > > > > > OUTPUT resolution be? Up to the driver? I think this should=
 be clarified since
> > > > > > > > at a first reading of this paragraph it appears to be contr=
adictory.
> > > > > > >=20
> > > > > > > I think the driver should just return the width and height of=
 the OUTPUT
> > > > > > > format. So the width and height that userspace specifies is j=
ust ignored
> > > > > > > and replaced by the width and height of the OUTPUT format. Af=
ter all, that's
> > > > > > > what the bitstream will encode. Returning 0 for width and hei=
ght would make
> > > > > > > this a strange exception in V4L2 and I want to avoid that.
> > > > > > >=20
> > > > > >=20
> > > > > > Hmm, however, the width and height of the OUTPUT format is not =
what's
> > > > > > actually encoded in the bitstream. The right selection rectangl=
e
> > > > > > determines that.
> > > > > >=20
> > > > > > In one of the previous versions I though we could put the codec
> > > >=20
> > > > s/codec/coded/...
> > > >=20
> > > > > > resolution as the width and height of the CAPTURE format, which=
 would
> > > > > > be the resolution of the encoded image rounded up to full macro=
blocks
> > > > > > +/- some encoder-specific constraints. AFAIR there was some con=
cern
> > > > > > about OUTPUT format changes triggering CAPTURE format changes, =
but to
> > > > > > be honest, I'm not sure if that's really a problem. I just deci=
ded to
> > > > > > drop that for the simplicity.
> > > > >=20
> > > > > I'm not sure what your point is.
> > > > >=20
> > > > > The OUTPUT format has the coded resolution,
> > > >=20
> > > > That's not always true. The OUTPUT format is just the format of the
> > > > source frame buffers. In special cases where the source resolution =
is
> > > > nicely aligned, it would be the same as coded size, but the remaini=
ng
> > > > cases are valid as well.
> > > >=20
> > > > > so when you set the
> > > > > CAPTURE format it can just copy the OUTPUT coded resolution unles=
s the
> > > > > chosen CAPTURE pixelformat can't handle that in which case both t=
he
> > > > > OUTPUT and CAPTURE coded resolutions are clamped to whatever is t=
he maximum
> > > > > or minimum the codec is capable of.
> > > >=20
> > > > As per my comment above, generally speaking, the encoder will deriv=
e
> > > > an appropriate coded format from the OUTPUT format, but also other
> > > > factors, like the crop rectangles and possibly some internal
> > > > constraints.
> > > >=20
> > > > > That said, I am fine with just leaving it up to the driver as sug=
gested
> > > > > before. Just as long as both the CAPTURE and OUTPUT formats remai=
n valid
> > > > > (i.e. width and height may never be out of range).
> > > > >=20
> > > >=20
> > > > Sounds good to me.
> > > >=20
> > > > > > > > > +
> > > > > > > > > +2. **Optional.** Enumerate supported ``OUTPUT`` formats =
(raw formats for
> > > > > > > > > +   source) for the selected coded format via :c:func:`VI=
DIOC_ENUM_FMT`.
> > > > > > > > > +
> > > > > > > > > +   * **Required fields:**
> > > > > > > > > +
> > > > > > > > > +     ``type``
> > > > > > > > > +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OU=
TPUT``
> > > > > > > > > +
> > > > > > > > > +     other fields
> > > > > > > > > +         follow standard semantics
> > > > > > > > > +
> > > > > > > > > +   * **Return fields:**
> > > > > > > > > +
> > > > > > > > > +     ``pixelformat``
> > > > > > > > > +         raw format supported for the coded format curre=
ntly selected on
> > > > > > > > > +         the ``CAPTURE`` queue.
> > > > > > > > > +
> > > > > > > > > +     other fields
> > > > > > > > > +         follow standard semantics
> > > > > > > > > +
> > > > > > > > > +3. Set the raw source format on the ``OUTPUT`` queue via
> > > > > > > > > +   :c:func:`VIDIOC_S_FMT`.
> > > > > > > > > +
> > > > > > > > > +   * **Required fields:**
> > > > > > > > > +
> > > > > > > > > +     ``type``
> > > > > > > > > +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OU=
TPUT``
> > > > > > > > > +
> > > > > > > > > +     ``pixelformat``
> > > > > > > > > +         raw format of the source
> > > > > > > > > +
> > > > > > > > > +     ``width``, ``height``
> > > > > > > > > +         source resolution
> > > > > > > > > +
> > > > > > > > > +     other fields
> > > > > > > > > +         follow standard semantics
> > > > > > > > > +
> > > > > > > > > +   * **Return fields:**
> > > > > > > > > +
> > > > > > > > > +     ``width``, ``height``
> > > > > > > > > +         may be adjusted by encoder to match alignment r=
equirements, as
> > > > > > > > > +         required by the currently selected formats
> > > > > > > >=20
> > > > > > > > What if the width x height is larger than the maximum suppo=
rted by the
> > > > > > > > selected coded format? This should probably mention that in=
 that case the
> > > > > > > > width x height is reduced to the largest allowed value. Als=
o mention that
> > > > > > > > this maximum is reported by VIDIOC_ENUM_FRAMESIZES.
> > > > > > > >=20
> > > > > > > > > +
> > > > > > > > > +     other fields
> > > > > > > > > +         follow standard semantics
> > > > > > > > > +
> > > > > > > > > +   * Setting the source resolution will reset the select=
ion rectangles to their
> > > > > > > > > +     default values, based on the new resolution, as des=
cribed in the step 5
> > > > > > > >=20
> > > > > > > > 5 -> 4
> > > > > > > >=20
> > > > > > > > Or just say: "as described in the next step."
> > > > > > > >=20
> > > > > > > > > +     below.
> > > > > > >=20
> > > > > > > It should also be made explicit that:
> > > > > > >=20
> > > > > > > 1) the crop rectangle will be set to the given width and heig=
ht *before*
> > > > > > > it is being adjusted by S_FMT.
> > > > > > >=20
> > > > > >=20
> > > > > > I don't think that's what we want here.
> > > > > >=20
> > > > > > Defining the default rectangle to be exactly the same as the OU=
TPUT
> > > > > > resolution (after the adjustment) makes the semantics consisten=
t - not
> > > > > > setting the crop rectangle gives you exactly the behavior as if=
 there
> > > > > > was no cropping involved (or supported by the encoder).
> > > > >=20
> > > > > I think you are right. This seems to be what the coda driver does=
 as well.
> > > > > It is convenient to be able to just set a 1920x1080 format and ha=
ve that
> > > > > resolution be stored as the crop rectangle, since it avoids havin=
g to call
> > > > > s_selection afterwards, but it is not really consistent with the =
way V4L2
> > > > > works.
> > > > >=20
> > > > > > > Open question: should we support a compose rectangle for the =
CAPTURE that
> > > > > > > is the same as the OUTPUT crop rectangle? I.e. the CAPTURE fo=
rmat contains
> > > > > > > the adjusted width and height and the compose rectangle (read=
-only) contains
> > > > > > > the visible width and height. It's not strictly necessary, bu=
t it is
> > > > > > > symmetrical.
> > > > > >=20
> > > > > > Wouldn't it rather be the CAPTURE crop rectangle that would be =
of the
> > > > > > same resolution of the OUTPUT compose rectangle? Then you could
> > > > > > actually have the CAPTURE compose rectangle for putting that in=
to the
> > > > > > desired rectangle of the encoded stream, if the encoder support=
s that.
> > > > > > (I don't know any that does, so probably out of concern for now=
.)
> > > > >=20
> > > > > Yes, you are right.
> > > > >=20
> > > > > But should we support this?
> > > > >=20
> > > > > I actually think not for this initial version. It can be added la=
ter, I guess.
> > > > >=20
> > > >=20
> > > > I think it boils down on whether adding it later wouldn't
> > > > significantly complicate the application logic. It also relates to =
my
> > > > other comment somewhere below.
> > > >=20
> > > > > > > 2) the CAPTURE format will be updated as well with the new OU=
TPUT width and
> > > > > > > height. The CAPTURE sizeimage might change as well.
> > > > > > >=20
> > > > > > > > > +
> > > > > > > > > +4. **Optional.** Set the visible resolution for the stre=
am metadata via
> > > > > > > > > +   :c:func:`VIDIOC_S_SELECTION` on the ``OUTPUT`` queue.
> > > > > > >=20
> > > > > > > I think you should mention that this is only necessary if the=
 crop rectangle
> > > > > > > that is set when you set the format isn't what you want.
> > > > > > >=20
> > > > > >=20
> > > > > > Ack.
> > > > > >=20
> > > > > > > > > +
> > > > > > > > > +   * **Required fields:**
> > > > > > > > > +
> > > > > > > > > +     ``type``
> > > > > > > > > +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OU=
TPUT``
> > > > > > > > > +
> > > > > > > > > +     ``target``
> > > > > > > > > +         set to ``V4L2_SEL_TGT_CROP``
> > > > > > > > > +
> > > > > > > > > +     ``r.left``, ``r.top``, ``r.width``, ``r.height``
> > > > > > > > > +         visible rectangle; this must fit within the `V4=
L2_SEL_TGT_CROP_BOUNDS`
> > > > > > > > > +         rectangle and may be subject to adjustment to m=
atch codec and
> > > > > > > > > +         hardware constraints
> > > > > > > > > +
> > > > > > > > > +   * **Return fields:**
> > > > > > > > > +
> > > > > > > > > +     ``r.left``, ``r.top``, ``r.width``, ``r.height``
> > > > > > > > > +         visible rectangle adjusted by the encoder
> > > > > > > > > +
> > > > > > > > > +   * The following selection targets are supported on ``=
OUTPUT``:
> > > > > > > > > +
> > > > > > > > > +     ``V4L2_SEL_TGT_CROP_BOUNDS``
> > > > > > > > > +         equal to the full source frame, matching the ac=
tive ``OUTPUT``
> > > > > > > > > +         format
> > > > > > > > > +
> > > > > > > > > +     ``V4L2_SEL_TGT_CROP_DEFAULT``
> > > > > > > > > +         equal to ``V4L2_SEL_TGT_CROP_BOUNDS``
> > > > > > > > > +
> > > > > > > > > +     ``V4L2_SEL_TGT_CROP``
> > > > > > > > > +         rectangle within the source buffer to be encode=
d into the
> > > > > > > > > +         ``CAPTURE`` stream; defaults to ``V4L2_SEL_TGT_=
CROP_DEFAULT``
> > > > > > > > > +
> > > > > > > > > +         .. note::
> > > > > > > > > +
> > > > > > > > > +            A common use case for this selection target =
is encoding a source
> > > > > > > > > +            video with a resolution that is not a multip=
le of a macroblock,
> > > > > > > > > +            e.g.  the common 1920x1080 resolution may re=
quire the source
> > > > > > > > > +            buffers to be aligned to 1920x1088 for codec=
s with 16x16 macroblock
> > > > > > > > > +            size. To avoid encoding the padding, the cli=
ent needs to explicitly
> > > > > > > > > +            configure this selection target to 1920x1080=
.
> > > > > > >=20
> > > > > > > This last sentence contradicts the proposed behavior of S_FMT=
(OUTPUT).
> > > > > > >=20
> > > > > >=20
> > > > > > Sorry, which part exactly and what part of the proposal exactly=
? :)
> > > > > > (My comment above might be related, though.)
> > > > >=20
> > > > > Ignore my comment. We go back to explicitly requiring userspace t=
o set the OUTPUT
> > > > > crop selection target, so this note remains valid.
> > > > >=20
> > > >=20
> > > > Ack.
> > > >=20
> > > > > > > > > +
> > > > > > > > > +     ``V4L2_SEL_TGT_COMPOSE_BOUNDS``
> > > > > > > > > +         maximum rectangle within the coded resolution, =
which the cropped
> > > > > > > > > +         source frame can be composed into; if the hardw=
are does not support
> > > > > > > > > +         composition or scaling, then this is always equ=
al to the rectangle of
> > > > > > > > > +         width and height matching ``V4L2_SEL_TGT_CROP``=
 and located at (0, 0)
> > > > > > > > > +
> > > > > > > > > +     ``V4L2_SEL_TGT_COMPOSE_DEFAULT``
> > > > > > > > > +         equal to a rectangle of width and height matchi=
ng
> > > > > > > > > +         ``V4L2_SEL_TGT_CROP`` and located at (0, 0)
> > > > > > > > > +
> > > > > > > > > +     ``V4L2_SEL_TGT_COMPOSE``
> > > > > > > > > +         rectangle within the coded frame, which the cro=
pped source frame
> > > > > > > > > +         is to be composed into; defaults to
> > > > > > > > > +         ``V4L2_SEL_TGT_COMPOSE_DEFAULT``; read-only on =
hardware without
> > > > > > > > > +         additional compose/scaling capabilities; result=
ing stream will
> > > > > > > > > +         have this rectangle encoded as the visible rect=
angle in its
> > > > > > > > > +         metadata
> > > > > > >=20
> > > > > > > I think the compose targets for OUTPUT are only needed if the=
 hardware can
> > > > > > > actually do scaling and/or composition. Otherwise they can (m=
ust?) be
> > > > > > > dropped.
> > > > > > >=20
> > > > > >=20
> > > > > > Note that V4L2_SEL_TGT_COMPOSE is defined to be the way for the
> > > > > > userspace to learn the target visible rectangle that's going to=
 be
> > > > > > encoded in the stream metadata. If we omit it, we wouldn't have=
 a way
> > > > > > that would be consistent between encoders that can do
> > > > > > scaling/composition and those that can't.
> > > > >=20
> > > > > I'm not convinced about this. The standard API behavior is not to=
 expose
> > > > > functionality that the hardware can't do. So if scaling isn't pos=
sible on
> > > > > the OUTPUT side, then it shouldn't expose OUTPUT compose rectangl=
es.
> > > > >=20
> > > > > I also believe it very unlikely that we'll see encoders capable o=
f scaling
> > > > > as it doesn't make much sense.
> > > >=20
> > > > It does make a lot of sense - WebRTC requires 3 different sizes of =
the
> > > > stream to be encoded at the same time. However, unfortunately, I
> > > > haven't yet seen an encoder capable of doing so.
> > > >=20
> > > > > I would prefer to drop this to simplify the
> > > > > spec, and when we get encoders that can scale, then we can add su=
pport for
> > > > > compose rectangles (and I'm sure we'll need to think about how th=
at
> > > > > influences the CAPTURE side as well).
> > > > >=20
> > > > > For encoders without scaling it is the OUTPUT crop rectangle that=
 defines
> > > > > the visible rectangle.
> > > > >=20
> > > > > > However, with your proposal of actually having selection rectan=
gles
> > > > > > for the CAPTURE queue, it could be solved indeed. The OUTPUT qu=
eue
> > > > > > would expose a varying set of rectangles, depending on the hard=
ware
> > > > > > capability, while the CAPTURE queue would always expose its rec=
tangle
> > > > > > with that information.
> > > > >=20
> > > > > I think we should keep it simple and only define selection rectan=
gles
> > > > > when really needed.
> > > > >=20
> > > > > So encoders support CROP on the OUTPUT, and decoders support CAPT=
URE
> > > > > COMPOSE (may be read-only). Nothing else.
> > > > >=20
> > > > > Once support for scaling is needed (either on the encoder or deco=
der
> > > > > side), then the spec should be enhanced. But I prefer to postpone=
 that
> > > > > until we actually have hardware that needs this.
> > > > >=20
> > > >=20
> > > > Okay, let's do it this way then. Actually, I don't even think there=
 is
> > > > much value in exposing information internal to the bitstream metada=
ta
> > > > like this, similarly to the coded size. My intention was to just
> > > > ensure that we can easily add scaling/composing functionality later=
.
> > > >=20
> > > > I just removed the COMPOSE rectangles from my next draft.
> > >=20
> > > I don't think that supporting scaling will be a problem for the API a=
s
> > > such, since this is supported for standard video capture devices. It
> > > just gets very complicated trying to describe how to configure all th=
is.
> > >=20
> > > So I prefer to avoid this until we need to.
> > >=20
> > > > [snip]
> > > > > > > Changing the OUTPUT format will always fail if OUTPUT buffers=
 are already allocated,
> > > > > > > or if changing the OUTPUT format would change the CAPTURE for=
mat (sizeimage in
> > > > > > > particular) and CAPTURE buffers were already allocated and ar=
e too small.
> > > > > >=20
> > > > > > The OUTPUT format must not change the CAPTURE format by definit=
ion.
> > > > > > Otherwise we end up in a situation where we can't commit, becau=
se both
> > > > > > queue formats can affect each other. Any change to the OUTPUT f=
ormat
> > > > > > that wouldn't work with the current CAPTURE format should be ad=
justed
> > > > > > by the driver to match the current CAPTURE format.
> > > > >=20
> > > > > But the CAPTURE format *does* depend on the OUTPUT format: if the=
 output
> > > > > resolution changes, then so does the CAPTURE resolution and esp. =
the
> > > > > sizeimage value, since that is typically resolution dependent.
> > > > >=20
> > > > > The coda driver does this as well: changing the output resolution
> > > > > will update the capture resolution and sizeimage. The vicodec dri=
ver does the
> > > > > same.
> > > > >=20
> > > > > Setting the CAPTURE format basically just selects the codec to us=
e, after
> > > > > that you can set the OUTPUT format and read the updated CAPTURE f=
ormat to
> > > > > get the new sizeimage value. In fact, setting the CAPTURE format =
shouldn't
> > > > > change the OUTPUT format, unless the OUTPUT format is incompatibl=
e with the
> > > > > newly selected codec.
> > > >=20
> > > > Let me think about it for a while.
> > >=20
> > > Sleep on it, always works well for me :-)
> >=20
> > Okay, I think I'm not convinced.
> >=20
> > I believe we decided to allow sizeimage to be specified by the
> > application, because it knows more about the stream it's going to
> > encode. Only setting the size to 0 would make the encoder fall back to
> > some simple internal heuristic.
>=20
> Yes, that was the plan, but the patch stalled. I completely forgot
> about this patch :-)
>=20
> My last reply to "Re: [RFC PATCH] media/doc: Allow sizeimage to be set by
> v4l clients" was March 14th.
>=20
> Also, sizeimage must be at least the minimum size required for the given
> CAPTURE width and height. So if it is less, then sizeimage will be set to=
 that
> minimum size.
>=20
> > Another thing is handling resolution changes. I believe that would
> > have to be handled by stopping the OUTPUT queue, changing the OUTPUT
> > format and starting the OUTPUT queue, all that without stopping the
> > CAPTURE queue. With the behavior you described it wouldn't work,
> > because the OUTPUT format couldn't be changed.
> >=20
> > I'd suggest making OUTPUT format changes not change the CAPTURE sizeima=
ge.
>=20
> So OUTPUT format changes will still update the CAPTURE width and height?
>=20
> It's kind of weird if you are encoding e.g. 1920x1080 but the CAPTURE for=
mat
> says 1280x720. I'm not sure what is best.
>=20
> What if the CAPTURE sizeimage is too small for the new OUTPUT resolution?
> Should S_FMT(OUTPUT) fail with some error in that case?

Sounds like we need something similar to the SOURCE_CHANGE event
mechanism if we want to allow dynamic bitrate control which would
require re-allocation of the capture buffer queue. (Or any other
runtime control on our encoders, which is really expected to be
supported these days).

>=20
> Regards,
>=20
> 	Hans
>=20
> > Best regards,
> > Tomasz
> >=20

--=-Bw8g8yr+c7woSQXcNO9C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSScpfJiL+hb5vvd45xUwItrAaoHAUCXK4UUwAKCRBxUwItrAao
HC+MAJ9YvciEGs0mELkul1dHtdFQwcenPACggYkhJc4fvjSHhdQPauVext7AFt0=
=C+Ex
-----END PGP SIGNATURE-----

--=-Bw8g8yr+c7woSQXcNO9C--

