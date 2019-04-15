Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1164C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3CF20833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AhxwBdAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfDOI4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:56:35 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34248 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfDOI4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:56:34 -0400
Received: by mail-ot1-f68.google.com with SMTP id k21so13771717otf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 01:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zXK0JNXp3LbUxj15SrB69uboNo56qZWp8mLEtqB7cF8=;
        b=AhxwBdAHsKqO+KyXdsnaqHNNccYerFv0YQPXrTmzOsllAcj5TpAfZufHDqhmVwFuQn
         i0V7Z6Hp1jP6GQElw3Aok93LD8zQVK2y3vlykQxCw63srdSb0+pt3lIbxNv9/nBf8rXz
         //g/5sgWcBIIa29+MJBDHi1pqN+U7vsZSz7fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zXK0JNXp3LbUxj15SrB69uboNo56qZWp8mLEtqB7cF8=;
        b=NgtoGSiZ1W++0aaQqCW7MD0H2K8TrmECzz7WDNL9NHQ0n8ZLbYpp9KHQHfKNUpxNmc
         JxdCQmFrPt31ZV6GUla5Nfe+PRwDTePUKNX/SxUh4pPeu484GRhpZ9/DUzrc3nBmf9PQ
         KirYdgqIBdmZu8ENMLzLvCbvHfIAStLgu1kvmWkZ1/pMri9FETqicmnAreLIOjxB+iZ4
         tfS6GeKvDlbiaiDqqQXURpsc02O1cw86CXqDBZt87R8QswAhQw62XPHukeCDyX/Sdn0H
         RK28zEEhkpHrpZtxMNrPl+nPONA6pvSFkJAXv4qoic+HQ3rVICed2/TDOTvrbcrSwH1+
         B9IA==
X-Gm-Message-State: APjAAAXsUdj5UpHtdhmkuqY7iJrpuFdOyvhhQzXO2yNqi2UiR/9S5A0P
        p/bZj6QMA99xt1CTXR12wMWay02H7/EPgQ==
X-Google-Smtp-Source: APXvYqwdC+dcZ/OCqbAWpjYYPepPyQbwJENHLaxMwY2jz/kAn4i42XnFNpiN0m+S/ApBAU+Nhz6SJw==
X-Received: by 2002:a9d:da9:: with SMTP id 38mr42701032ots.183.1555318592630;
        Mon, 15 Apr 2019 01:56:32 -0700 (PDT)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com. [209.85.210.48])
        by smtp.gmail.com with ESMTPSA id w2sm19032852otk.73.2019.04.15.01.56.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 01:56:31 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id f10so13748612otb.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 01:56:31 -0700 (PDT)
X-Received: by 2002:a9d:6206:: with SMTP id g6mr45885901otj.7.1555318590455;
 Mon, 15 Apr 2019 01:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190124100419.26492-1-tfiga@chromium.org> <20190124100419.26492-3-tfiga@chromium.org>
 <4bbe4ce4-615a-b981-0855-cd78c7a002d9@xs4all.nl> <471720b7-e304-271b-256d-a3dd394773c9@xs4all.nl>
 <CAAFQd5Au_=08pVom1z3C1nHKdKak8Y4d5odR6fiNB4urDhfjKQ@mail.gmail.com>
 <787ddc1f-388d-82be-2702-0d7d256f636c@xs4all.nl> <CAAFQd5DozydYBpEceFTbJSutP+gwjxybpd1q6N1Vi+YragQT+w@mail.gmail.com>
 <6cb0caf1-61a6-0719-1ade-1dcf8ed8a020@xs4all.nl> <CAAFQd5DdDv+Nu0Dry1XRpYAnz0DrSE5kEf7GxY64tg6aJebzMQ@mail.gmail.com>
 <1ec36515-b6ec-b355-47fb-2fe5ad4b3241@xs4all.nl> <03751bb884a443ec1cea7b5c023c9d520ffcc3a0.camel@ndufresne.ca>
In-Reply-To: <03751bb884a443ec1cea7b5c023c9d520ffcc3a0.camel@ndufresne.ca>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 15 Apr 2019 17:56:18 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BmDvou6qdaw6uSAWTyLBXeTH8RvnBi7dCGCRdedvHPMg@mail.gmail.com>
Message-ID: <CAAFQd5BmDvou6qdaw6uSAWTyLBXeTH8RvnBi7dCGCRdedvHPMg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] media: docs-rst: Document memory-to-memory video
 encoder interface
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Kamil Debski <kamil@wypas.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jeongtae Park <jtp.park@samsung.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        =?UTF-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <andrew-ct.chen@mediatek.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dave.stevenson@raspberrypi.org,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 1:05 AM Nicolas Dufresne <nicolas@ndufresne.ca> wro=
te:
>
> Le mercredi 10 avril 2019 =C3=A0 10:50 +0200, Hans Verkuil a =C3=A9crit :
> > On 4/9/19 11:35 AM, Tomasz Figa wrote:
> > > On Mon, Apr 8, 2019 at 8:11 PM Hans Verkuil <hverkuil@xs4all.nl> wrot=
e:
> > > > On 4/8/19 11:23 AM, Tomasz Figa wrote:
> > > > > On Fri, Apr 5, 2019 at 7:03 PM Hans Verkuil <hverkuil@xs4all.nl> =
wrote:
> > > > > > On 4/5/19 10:12 AM, Tomasz Figa wrote:
> > > > > > > On Thu, Mar 14, 2019 at 10:57 PM Hans Verkuil <hverkuil@xs4al=
l.nl> wrote:
> > > > > > > > Hi Tomasz,
> > > > > > > >
> > > > > > > > Some more comments...
> > > > > > > >
> > > > > > > > On 1/29/19 2:52 PM, Hans Verkuil wrote:
> > > > > > > > > Hi Tomasz,
> > > > > > > > >
> > > > > > > > > Some comments below. Nothing major, so I think a v4 shoul=
d be ready to be
> > > > > > > > > merged.
> > > > > > > > >
> > > > > > > > > On 1/24/19 11:04 AM, Tomasz Figa wrote:
> > > > > > > > > > Due to complexity of the video encoding process, the V4=
L2 drivers of
> > > > > > > > > > stateful encoder hardware require specific sequences of=
 V4L2 API calls
> > > > > > > > > > to be followed. These include capability enumeration, i=
nitialization,
> > > > > > > > > > encoding, encode parameters change, drain and reset.
> > > > > > > > > >
> > > > > > > > > > Specifics of the above have been discussed during Media=
 Workshops at
> > > > > > > > > > LinuxCon Europe 2012 in Barcelona and then later Embedd=
ed Linux
> > > > > > > > > > Conference Europe 2014 in D=C3=BCsseldorf. The de facto=
 Codec API that
> > > > > > > > > > originated at those events was later implemented by the=
 drivers we already
> > > > > > > > > > have merged in mainline, such as s5p-mfc or coda.
> > > > > > > > > >
> > > > > > > > > > The only thing missing was the real specification inclu=
ded as a part of
> > > > > > > > > > Linux Media documentation. Fix it now and document the =
encoder part of
> > > > > > > > > > the Codec API.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> > > > > > > > > > ---
> > > > > > > > > >  Documentation/media/uapi/v4l/dev-encoder.rst  | 586 ++=
++++++++++++++++
> > > > > > > > > >  Documentation/media/uapi/v4l/dev-mem2mem.rst  |   1 +
> > > > > > > > > >  Documentation/media/uapi/v4l/pixfmt-v4l2.rst  |   5 +
> > > > > > > > > >  Documentation/media/uapi/v4l/v4l2.rst         |   2 +
> > > > > > > > > >  .../media/uapi/v4l/vidioc-encoder-cmd.rst     |  38 +-
> > > > > > > > > >  5 files changed, 617 insertions(+), 15 deletions(-)
> > > > > > > > > >  create mode 100644 Documentation/media/uapi/v4l/dev-en=
coder.rst
> > > > > > > > > >
> > > > > > > > > > diff --git a/Documentation/media/uapi/v4l/dev-encoder.r=
st b/Documentation/media/uapi/v4l/dev-encoder.rst
> > > > > > > > > > new file mode 100644
> > > > > > > > > > index 000000000000..fb8b05a132ee
> > > > > > > > > > --- /dev/null
> > > > > > > > > > +++ b/Documentation/media/uapi/v4l/dev-encoder.rst
> > > > > > > > > > @@ -0,0 +1,586 @@
> > > > > > > > > > +.. -*- coding: utf-8; mode: rst -*-
> > > > > > > > > > +
> > > > > > > > > > +.. _encoder:
> > > > > > > > > > +
> > > > > > > > > > +*************************************************
> > > > > > > > > > +Memory-to-memory Stateful Video Encoder Interface
> > > > > > > > > > +*************************************************
> > > > > > > > > > +
> > > > > > > > > > +A stateful video encoder takes raw video frames in dis=
play order and encodes
> > > > > > > > > > +them into a bitstream. It generates complete chunks of=
 the bitstream, including
> > > > > > > > > > +all metadata, headers, etc. The resulting bitstream do=
es not require any
> > > > > > > > > > +further post-processing by the client.
> > > > > > > > > > +
> > > > > > > > > > +Performing software stream processing, header generati=
on etc. in the driver
> > > > > > > > > > +in order to support this interface is strongly discour=
aged. In case such
> > > > > > > > > > +operations are needed, use of the Stateless Video Enco=
der Interface (in
> > > > > > > > > > +development) is strongly advised.
> > > > > > > > > > +
> > > > > > > > > > +Conventions and notation used in this document
> > > > > > > > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > > > > > > > > > +
> > > > > > > > > > +1. The general V4L2 API rules apply if not specified i=
n this document
> > > > > > > > > > +   otherwise.
> > > > > > > > > > +
> > > > > > > > > > +2. The meaning of words "must", "may", "should", etc. =
is as per `RFC
> > > > > > > > > > +   2119 <https://tools.ietf.org/html/rfc2119>`_.
> > > > > > > > > > +
> > > > > > > > > > +3. All steps not marked "optional" are required.
> > > > > > > > > > +
> > > > > > > > > > +4. :c:func:`VIDIOC_G_EXT_CTRLS` and :c:func:`VIDIOC_S_=
EXT_CTRLS` may be used
> > > > > > > > > > +   interchangeably with :c:func:`VIDIOC_G_CTRL` and :c=
:func:`VIDIOC_S_CTRL`,
> > > > > > > > > > +   unless specified otherwise.
> > > > > > > > > > +
> > > > > > > > > > +5. Single-planar API (see :ref:`planar-apis`) and appl=
icable structures may be
> > > > > > > > > > +   used interchangeably with multi-planar API, unless =
specified otherwise,
> > > > > > > > > > +   depending on decoder capabilities and following the=
 general V4L2 guidelines.
> > > > > > > > > > +
> > > > > > > > > > +6. i =3D [a..b]: sequence of integers from a to b, inc=
lusive, i.e. i =3D
> > > > > > > > > > +   [0..2]: i =3D 0, 1, 2.
> > > > > > > > > > +
> > > > > > > > > > +7. Given an ``OUTPUT`` buffer A, then A=E2=80=99 repre=
sents a buffer on the ``CAPTURE``
> > > > > > > > > > +   queue containing data that resulted from processing=
 buffer A.
> > > > > > > > > > +
> > > > > > > > > > +Glossary
> > > > > > > > > > +=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > > +
> > > > > > > > > > +Refer to :ref:`decoder-glossary`.
> > > > > > > > > > +
> > > > > > > > > > +State machine
> > > > > > > > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > > +
> > > > > > > > > > +.. kernel-render:: DOT
> > > > > > > > > > +   :alt: DOT digraph of encoder state machine
> > > > > > > > > > +   :caption: Encoder state machine
> > > > > > > > > > +
> > > > > > > > > > +   digraph encoder_state_machine {
> > > > > > > > > > +       node [shape =3D doublecircle, label=3D"Encoding=
"] Encoding;
> > > > > > > > > > +
> > > > > > > > > > +       node [shape =3D circle, label=3D"Initialization=
"] Initialization;
> > > > > > > > > > +       node [shape =3D circle, label=3D"Stopped"] Stop=
ped;
> > > > > > > > > > +       node [shape =3D circle, label=3D"Drain"] Drain;
> > > > > > > > > > +       node [shape =3D circle, label=3D"Reset"] Reset;
> > > > > > > > > > +
> > > > > > > > > > +       node [shape =3D point]; qi
> > > > > > > > > > +       qi -> Initialization [ label =3D "open()" ];
> > > > > > > > > > +
> > > > > > > > > > +       Initialization -> Encoding [ label =3D "Both qu=
eues streaming" ];
> > > > > > > > > > +
> > > > > > > > > > +       Encoding -> Drain [ label =3D "V4L2_DEC_CMD_STO=
P" ];
> > > > > > > > > > +       Encoding -> Reset [ label =3D "VIDIOC_STREAMOFF=
(CAPTURE)" ];
> > > > > > > > > > +       Encoding -> Stopped [ label =3D "VIDIOC_STREAMO=
FF(OUTPUT)" ];
> > > > > > > > > > +       Encoding -> Encoding;
> > > > > > > > > > +
> > > > > > > > > > +       Drain -> Stopped [ label =3D "All CAPTURE\nbuff=
ers dequeued\nor\nVIDIOC_STREAMOFF(CAPTURE)" ];
> > > > > > > > > > +       Drain -> Reset [ label =3D "VIDIOC_STREAMOFF(CA=
PTURE)" ];
> > > > > > > > > > +
> > > > > > > > > > +       Reset -> Encoding [ label =3D "VIDIOC_STREAMON(=
CAPTURE)" ];
> > > > > > > > > > +       Reset -> Initialization [ label =3D "VIDIOC_REQ=
BUFS(OUTPUT, 0)" ];
> > > > > > > > > > +
> > > > > > > > > > +       Stopped -> Encoding [ label =3D "V4L2_DEC_CMD_S=
TART\nor\nVIDIOC_STREAMON(OUTPUT)" ];
> > > > > > > > > > +       Stopped -> Reset [ label =3D "VIDIOC_STREAMOFF(=
CAPTURE)" ];
> > > > > > > > > > +   }
> > > > > > > > > > +
> > > > > > > > > > +Querying capabilities
> > > > > > > > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > > > > > > > > > +
> > > > > > > > > > +1. To enumerate the set of coded formats supported by =
the encoder, the
> > > > > > > > > > +   client may call :c:func:`VIDIOC_ENUM_FMT` on ``CAPT=
URE``.
> > > > > > > > > > +
> > > > > > > > > > +   * The full set of supported formats will be returne=
d, regardless of the
> > > > > > > > > > +     format set on ``OUTPUT``.
> > > > > > > > > > +
> > > > > > > > > > +2. To enumerate the set of supported raw formats, the =
client may call
> > > > > > > > > > +   :c:func:`VIDIOC_ENUM_FMT` on ``OUTPUT``.
> > > > > > > > > > +
> > > > > > > > > > +   * Only the formats supported for the format current=
ly active on ``CAPTURE``
> > > > > > > > > > +     will be returned.
> > > > > > > > > > +
> > > > > > > > > > +   * In order to enumerate raw formats supported by a =
given coded format,
> > > > > > > > > > +     the client must first set that coded format on ``=
CAPTURE`` and then
> > > > > > > > > > +     enumerate the formats on ``OUTPUT``.
> > > > > > > > > > +
> > > > > > > > > > +3. The client may use :c:func:`VIDIOC_ENUM_FRAMESIZES`=
 to detect supported
> > > > > > > > > > +   resolutions for a given format, passing desired pix=
el format in
> > > > > > > > > > +   :c:type:`v4l2_frmsizeenum` ``pixel_format``.
> > > > > > > > > > +
> > > > > > > > > > +   * Values returned by :c:func:`VIDIOC_ENUM_FRAMESIZE=
S` for a coded pixel
> > > > > > > > > > +     format will include all possible coded resolution=
s supported by the
> > > > > > > > > > +     encoder for given coded pixel format.
> > > > > > > > > > +
> > > > > > > > > > +   * Values returned by :c:func:`VIDIOC_ENUM_FRAMESIZE=
S` for a raw pixel format
> > > > > > > > > > +     will include all possible frame buffer resolution=
s supported by the
> > > > > > > > > > +     encoder for given raw pixel format and coded form=
at currently set on
> > > > > > > > > > +     ``CAPTURE``.
> > > > > > > > > > +
> > > > > > > > > > +4. Supported profiles and levels for the coded format =
currently set on
> > > > > > > > > > +   ``CAPTURE``, if applicable, may be queried using th=
eir respective controls
> > > > > > > > > > +   via :c:func:`VIDIOC_QUERYCTRL`.
> > > > > > > > > > +
> > > > > > > > > > +5. Any additional encoder capabilities may be discover=
ed by querying
> > > > > > > > > > +   their respective controls.
> > > > > > > > > > +
> > > > > > > > > > +Initialization
> > > > > > > > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > > +
> > > > > > > > > > +1. Set the coded format on the ``CAPTURE`` queue via :=
c:func:`VIDIOC_S_FMT`
> > > > > > > > > > +
> > > > > > > > > > +   * **Required fields:**
> > > > > > > > > > +
> > > > > > > > > > +     ``type``
> > > > > > > > > > +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``=
CAPTURE``
> > > > > > > > > > +
> > > > > > > > > > +     ``pixelformat``
> > > > > > > > > > +         the coded format to be produced
> > > > > > > > > > +
> > > > > > > > > > +     ``sizeimage``
> > > > > > > > > > +         desired size of ``CAPTURE`` buffers; the enco=
der may adjust it to
> > > > > > > > > > +         match hardware requirements
> > > > > > > > > > +
> > > > > > > > > > +     ``width``, ``height``
> > > > > > > > > > +         ignored (always zero)
> > > > > > > > > > +
> > > > > > > > > > +     other fields
> > > > > > > > > > +         follow standard semantics
> > > > > > > > > > +
> > > > > > > > > > +   * **Return fields:**
> > > > > > > > > > +
> > > > > > > > > > +     ``sizeimage``
> > > > > > > > > > +         adjusted size of ``CAPTURE`` buffers
> > > > > > > > > > +
> > > > > > > > > > +   .. important::
> > > > > > > > > > +
> > > > > > > > > > +      Changing the ``CAPTURE`` format may change the c=
urrently set ``OUTPUT``
> > > > > > > > > > +      format. The encoder will derive a new ``OUTPUT``=
 format from the
> > > > > > > > > > +      ``CAPTURE`` format being set, including resoluti=
on, colorimetry
> > > > > > > > > > +      parameters, etc. If the client needs a specific =
``OUTPUT`` format, it
> > > > > > > > > > +      must adjust it afterwards.
> > > > > > > > >
> > > > > > > > > Hmm, "including resolution": if width and height are set =
to 0, what should the
> > > > > > > > > OUTPUT resolution be? Up to the driver? I think this shou=
ld be clarified since
> > > > > > > > > at a first reading of this paragraph it appears to be con=
tradictory.
> > > > > > > >
> > > > > > > > I think the driver should just return the width and height =
of the OUTPUT
> > > > > > > > format. So the width and height that userspace specifies is=
 just ignored
> > > > > > > > and replaced by the width and height of the OUTPUT format. =
After all, that's
> > > > > > > > what the bitstream will encode. Returning 0 for width and h=
eight would make
> > > > > > > > this a strange exception in V4L2 and I want to avoid that.
> > > > > > > >
> > > > > > >
> > > > > > > Hmm, however, the width and height of the OUTPUT format is no=
t what's
> > > > > > > actually encoded in the bitstream. The right selection rectan=
gle
> > > > > > > determines that.
> > > > > > >
> > > > > > > In one of the previous versions I though we could put the cod=
ec
> > > > >
> > > > > s/codec/coded/...
> > > > >
> > > > > > > resolution as the width and height of the CAPTURE format, whi=
ch would
> > > > > > > be the resolution of the encoded image rounded up to full mac=
roblocks
> > > > > > > +/- some encoder-specific constraints. AFAIR there was some c=
oncern
> > > > > > > about OUTPUT format changes triggering CAPTURE format changes=
, but to
> > > > > > > be honest, I'm not sure if that's really a problem. I just de=
cided to
> > > > > > > drop that for the simplicity.
> > > > > >
> > > > > > I'm not sure what your point is.
> > > > > >
> > > > > > The OUTPUT format has the coded resolution,
> > > > >
> > > > > That's not always true. The OUTPUT format is just the format of t=
he
> > > > > source frame buffers. In special cases where the source resolutio=
n is
> > > > > nicely aligned, it would be the same as coded size, but the remai=
ning
> > > > > cases are valid as well.
> > > > >
> > > > > > so when you set the
> > > > > > CAPTURE format it can just copy the OUTPUT coded resolution unl=
ess the
> > > > > > chosen CAPTURE pixelformat can't handle that in which case both=
 the
> > > > > > OUTPUT and CAPTURE coded resolutions are clamped to whatever is=
 the maximum
> > > > > > or minimum the codec is capable of.
> > > > >
> > > > > As per my comment above, generally speaking, the encoder will der=
ive
> > > > > an appropriate coded format from the OUTPUT format, but also othe=
r
> > > > > factors, like the crop rectangles and possibly some internal
> > > > > constraints.
> > > > >
> > > > > > That said, I am fine with just leaving it up to the driver as s=
uggested
> > > > > > before. Just as long as both the CAPTURE and OUTPUT formats rem=
ain valid
> > > > > > (i.e. width and height may never be out of range).
> > > > > >
> > > > >
> > > > > Sounds good to me.
> > > > >
> > > > > > > > > > +
> > > > > > > > > > +2. **Optional.** Enumerate supported ``OUTPUT`` format=
s (raw formats for
> > > > > > > > > > +   source) for the selected coded format via :c:func:`=
VIDIOC_ENUM_FMT`.
> > > > > > > > > > +
> > > > > > > > > > +   * **Required fields:**
> > > > > > > > > > +
> > > > > > > > > > +     ``type``
> > > > > > > > > > +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``=
OUTPUT``
> > > > > > > > > > +
> > > > > > > > > > +     other fields
> > > > > > > > > > +         follow standard semantics
> > > > > > > > > > +
> > > > > > > > > > +   * **Return fields:**
> > > > > > > > > > +
> > > > > > > > > > +     ``pixelformat``
> > > > > > > > > > +         raw format supported for the coded format cur=
rently selected on
> > > > > > > > > > +         the ``CAPTURE`` queue.
> > > > > > > > > > +
> > > > > > > > > > +     other fields
> > > > > > > > > > +         follow standard semantics
> > > > > > > > > > +
> > > > > > > > > > +3. Set the raw source format on the ``OUTPUT`` queue v=
ia
> > > > > > > > > > +   :c:func:`VIDIOC_S_FMT`.
> > > > > > > > > > +
> > > > > > > > > > +   * **Required fields:**
> > > > > > > > > > +
> > > > > > > > > > +     ``type``
> > > > > > > > > > +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``=
OUTPUT``
> > > > > > > > > > +
> > > > > > > > > > +     ``pixelformat``
> > > > > > > > > > +         raw format of the source
> > > > > > > > > > +
> > > > > > > > > > +     ``width``, ``height``
> > > > > > > > > > +         source resolution
> > > > > > > > > > +
> > > > > > > > > > +     other fields
> > > > > > > > > > +         follow standard semantics
> > > > > > > > > > +
> > > > > > > > > > +   * **Return fields:**
> > > > > > > > > > +
> > > > > > > > > > +     ``width``, ``height``
> > > > > > > > > > +         may be adjusted by encoder to match alignment=
 requirements, as
> > > > > > > > > > +         required by the currently selected formats
> > > > > > > > >
> > > > > > > > > What if the width x height is larger than the maximum sup=
ported by the
> > > > > > > > > selected coded format? This should probably mention that =
in that case the
> > > > > > > > > width x height is reduced to the largest allowed value. A=
lso mention that
> > > > > > > > > this maximum is reported by VIDIOC_ENUM_FRAMESIZES.
> > > > > > > > >
> > > > > > > > > > +
> > > > > > > > > > +     other fields
> > > > > > > > > > +         follow standard semantics
> > > > > > > > > > +
> > > > > > > > > > +   * Setting the source resolution will reset the sele=
ction rectangles to their
> > > > > > > > > > +     default values, based on the new resolution, as d=
escribed in the step 5
> > > > > > > > >
> > > > > > > > > 5 -> 4
> > > > > > > > >
> > > > > > > > > Or just say: "as described in the next step."
> > > > > > > > >
> > > > > > > > > > +     below.
> > > > > > > >
> > > > > > > > It should also be made explicit that:
> > > > > > > >
> > > > > > > > 1) the crop rectangle will be set to the given width and he=
ight *before*
> > > > > > > > it is being adjusted by S_FMT.
> > > > > > > >
> > > > > > >
> > > > > > > I don't think that's what we want here.
> > > > > > >
> > > > > > > Defining the default rectangle to be exactly the same as the =
OUTPUT
> > > > > > > resolution (after the adjustment) makes the semantics consist=
ent - not
> > > > > > > setting the crop rectangle gives you exactly the behavior as =
if there
> > > > > > > was no cropping involved (or supported by the encoder).
> > > > > >
> > > > > > I think you are right. This seems to be what the coda driver do=
es as well.
> > > > > > It is convenient to be able to just set a 1920x1080 format and =
have that
> > > > > > resolution be stored as the crop rectangle, since it avoids hav=
ing to call
> > > > > > s_selection afterwards, but it is not really consistent with th=
e way V4L2
> > > > > > works.
> > > > > >
> > > > > > > > Open question: should we support a compose rectangle for th=
e CAPTURE that
> > > > > > > > is the same as the OUTPUT crop rectangle? I.e. the CAPTURE =
format contains
> > > > > > > > the adjusted width and height and the compose rectangle (re=
ad-only) contains
> > > > > > > > the visible width and height. It's not strictly necessary, =
but it is
> > > > > > > > symmetrical.
> > > > > > >
> > > > > > > Wouldn't it rather be the CAPTURE crop rectangle that would b=
e of the
> > > > > > > same resolution of the OUTPUT compose rectangle? Then you cou=
ld
> > > > > > > actually have the CAPTURE compose rectangle for putting that =
into the
> > > > > > > desired rectangle of the encoded stream, if the encoder suppo=
rts that.
> > > > > > > (I don't know any that does, so probably out of concern for n=
ow.)
> > > > > >
> > > > > > Yes, you are right.
> > > > > >
> > > > > > But should we support this?
> > > > > >
> > > > > > I actually think not for this initial version. It can be added =
later, I guess.
> > > > > >
> > > > >
> > > > > I think it boils down on whether adding it later wouldn't
> > > > > significantly complicate the application logic. It also relates t=
o my
> > > > > other comment somewhere below.
> > > > >
> > > > > > > > 2) the CAPTURE format will be updated as well with the new =
OUTPUT width and
> > > > > > > > height. The CAPTURE sizeimage might change as well.
> > > > > > > >
> > > > > > > > > > +
> > > > > > > > > > +4. **Optional.** Set the visible resolution for the st=
ream metadata via
> > > > > > > > > > +   :c:func:`VIDIOC_S_SELECTION` on the ``OUTPUT`` queu=
e.
> > > > > > > >
> > > > > > > > I think you should mention that this is only necessary if t=
he crop rectangle
> > > > > > > > that is set when you set the format isn't what you want.
> > > > > > > >
> > > > > > >
> > > > > > > Ack.
> > > > > > >
> > > > > > > > > > +
> > > > > > > > > > +   * **Required fields:**
> > > > > > > > > > +
> > > > > > > > > > +     ``type``
> > > > > > > > > > +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``=
OUTPUT``
> > > > > > > > > > +
> > > > > > > > > > +     ``target``
> > > > > > > > > > +         set to ``V4L2_SEL_TGT_CROP``
> > > > > > > > > > +
> > > > > > > > > > +     ``r.left``, ``r.top``, ``r.width``, ``r.height``
> > > > > > > > > > +         visible rectangle; this must fit within the `=
V4L2_SEL_TGT_CROP_BOUNDS`
> > > > > > > > > > +         rectangle and may be subject to adjustment to=
 match codec and
> > > > > > > > > > +         hardware constraints
> > > > > > > > > > +
> > > > > > > > > > +   * **Return fields:**
> > > > > > > > > > +
> > > > > > > > > > +     ``r.left``, ``r.top``, ``r.width``, ``r.height``
> > > > > > > > > > +         visible rectangle adjusted by the encoder
> > > > > > > > > > +
> > > > > > > > > > +   * The following selection targets are supported on =
``OUTPUT``:
> > > > > > > > > > +
> > > > > > > > > > +     ``V4L2_SEL_TGT_CROP_BOUNDS``
> > > > > > > > > > +         equal to the full source frame, matching the =
active ``OUTPUT``
> > > > > > > > > > +         format
> > > > > > > > > > +
> > > > > > > > > > +     ``V4L2_SEL_TGT_CROP_DEFAULT``
> > > > > > > > > > +         equal to ``V4L2_SEL_TGT_CROP_BOUNDS``
> > > > > > > > > > +
> > > > > > > > > > +     ``V4L2_SEL_TGT_CROP``
> > > > > > > > > > +         rectangle within the source buffer to be enco=
ded into the
> > > > > > > > > > +         ``CAPTURE`` stream; defaults to ``V4L2_SEL_TG=
T_CROP_DEFAULT``
> > > > > > > > > > +
> > > > > > > > > > +         .. note::
> > > > > > > > > > +
> > > > > > > > > > +            A common use case for this selection targe=
t is encoding a source
> > > > > > > > > > +            video with a resolution that is not a mult=
iple of a macroblock,
> > > > > > > > > > +            e.g.  the common 1920x1080 resolution may =
require the source
> > > > > > > > > > +            buffers to be aligned to 1920x1088 for cod=
ecs with 16x16 macroblock
> > > > > > > > > > +            size. To avoid encoding the padding, the c=
lient needs to explicitly
> > > > > > > > > > +            configure this selection target to 1920x10=
80.
> > > > > > > >
> > > > > > > > This last sentence contradicts the proposed behavior of S_F=
MT(OUTPUT).
> > > > > > > >
> > > > > > >
> > > > > > > Sorry, which part exactly and what part of the proposal exact=
ly? :)
> > > > > > > (My comment above might be related, though.)
> > > > > >
> > > > > > Ignore my comment. We go back to explicitly requiring userspace=
 to set the OUTPUT
> > > > > > crop selection target, so this note remains valid.
> > > > > >
> > > > >
> > > > > Ack.
> > > > >
> > > > > > > > > > +
> > > > > > > > > > +     ``V4L2_SEL_TGT_COMPOSE_BOUNDS``
> > > > > > > > > > +         maximum rectangle within the coded resolution=
, which the cropped
> > > > > > > > > > +         source frame can be composed into; if the har=
dware does not support
> > > > > > > > > > +         composition or scaling, then this is always e=
qual to the rectangle of
> > > > > > > > > > +         width and height matching ``V4L2_SEL_TGT_CROP=
`` and located at (0, 0)
> > > > > > > > > > +
> > > > > > > > > > +     ``V4L2_SEL_TGT_COMPOSE_DEFAULT``
> > > > > > > > > > +         equal to a rectangle of width and height matc=
hing
> > > > > > > > > > +         ``V4L2_SEL_TGT_CROP`` and located at (0, 0)
> > > > > > > > > > +
> > > > > > > > > > +     ``V4L2_SEL_TGT_COMPOSE``
> > > > > > > > > > +         rectangle within the coded frame, which the c=
ropped source frame
> > > > > > > > > > +         is to be composed into; defaults to
> > > > > > > > > > +         ``V4L2_SEL_TGT_COMPOSE_DEFAULT``; read-only o=
n hardware without
> > > > > > > > > > +         additional compose/scaling capabilities; resu=
lting stream will
> > > > > > > > > > +         have this rectangle encoded as the visible re=
ctangle in its
> > > > > > > > > > +         metadata
> > > > > > > >
> > > > > > > > I think the compose targets for OUTPUT are only needed if t=
he hardware can
> > > > > > > > actually do scaling and/or composition. Otherwise they can =
(must?) be
> > > > > > > > dropped.
> > > > > > > >
> > > > > > >
> > > > > > > Note that V4L2_SEL_TGT_COMPOSE is defined to be the way for t=
he
> > > > > > > userspace to learn the target visible rectangle that's going =
to be
> > > > > > > encoded in the stream metadata. If we omit it, we wouldn't ha=
ve a way
> > > > > > > that would be consistent between encoders that can do
> > > > > > > scaling/composition and those that can't.
> > > > > >
> > > > > > I'm not convinced about this. The standard API behavior is not =
to expose
> > > > > > functionality that the hardware can't do. So if scaling isn't p=
ossible on
> > > > > > the OUTPUT side, then it shouldn't expose OUTPUT compose rectan=
gles.
> > > > > >
> > > > > > I also believe it very unlikely that we'll see encoders capable=
 of scaling
> > > > > > as it doesn't make much sense.
> > > > >
> > > > > It does make a lot of sense - WebRTC requires 3 different sizes o=
f the
> > > > > stream to be encoded at the same time. However, unfortunately, I
> > > > > haven't yet seen an encoder capable of doing so.
> > > > >
> > > > > > I would prefer to drop this to simplify the
> > > > > > spec, and when we get encoders that can scale, then we can add =
support for
> > > > > > compose rectangles (and I'm sure we'll need to think about how =
that
> > > > > > influences the CAPTURE side as well).
> > > > > >
> > > > > > For encoders without scaling it is the OUTPUT crop rectangle th=
at defines
> > > > > > the visible rectangle.
> > > > > >
> > > > > > > However, with your proposal of actually having selection rect=
angles
> > > > > > > for the CAPTURE queue, it could be solved indeed. The OUTPUT =
queue
> > > > > > > would expose a varying set of rectangles, depending on the ha=
rdware
> > > > > > > capability, while the CAPTURE queue would always expose its r=
ectangle
> > > > > > > with that information.
> > > > > >
> > > > > > I think we should keep it simple and only define selection rect=
angles
> > > > > > when really needed.
> > > > > >
> > > > > > So encoders support CROP on the OUTPUT, and decoders support CA=
PTURE
> > > > > > COMPOSE (may be read-only). Nothing else.
> > > > > >
> > > > > > Once support for scaling is needed (either on the encoder or de=
coder
> > > > > > side), then the spec should be enhanced. But I prefer to postpo=
ne that
> > > > > > until we actually have hardware that needs this.
> > > > > >
> > > > >
> > > > > Okay, let's do it this way then. Actually, I don't even think the=
re is
> > > > > much value in exposing information internal to the bitstream meta=
data
> > > > > like this, similarly to the coded size. My intention was to just
> > > > > ensure that we can easily add scaling/composing functionality lat=
er.
> > > > >
> > > > > I just removed the COMPOSE rectangles from my next draft.
> > > >
> > > > I don't think that supporting scaling will be a problem for the API=
 as
> > > > such, since this is supported for standard video capture devices. I=
t
> > > > just gets very complicated trying to describe how to configure all =
this.
> > > >
> > > > So I prefer to avoid this until we need to.
> > > >
> > > > > [snip]
> > > > > > > > Changing the OUTPUT format will always fail if OUTPUT buffe=
rs are already allocated,
> > > > > > > > or if changing the OUTPUT format would change the CAPTURE f=
ormat (sizeimage in
> > > > > > > > particular) and CAPTURE buffers were already allocated and =
are too small.
> > > > > > >
> > > > > > > The OUTPUT format must not change the CAPTURE format by defin=
ition.
> > > > > > > Otherwise we end up in a situation where we can't commit, bec=
ause both
> > > > > > > queue formats can affect each other. Any change to the OUTPUT=
 format
> > > > > > > that wouldn't work with the current CAPTURE format should be =
adjusted
> > > > > > > by the driver to match the current CAPTURE format.
> > > > > >
> > > > > > But the CAPTURE format *does* depend on the OUTPUT format: if t=
he output
> > > > > > resolution changes, then so does the CAPTURE resolution and esp=
. the
> > > > > > sizeimage value, since that is typically resolution dependent.
> > > > > >
> > > > > > The coda driver does this as well: changing the output resoluti=
on
> > > > > > will update the capture resolution and sizeimage. The vicodec d=
river does the
> > > > > > same.
> > > > > >
> > > > > > Setting the CAPTURE format basically just selects the codec to =
use, after
> > > > > > that you can set the OUTPUT format and read the updated CAPTURE=
 format to
> > > > > > get the new sizeimage value. In fact, setting the CAPTURE forma=
t shouldn't
> > > > > > change the OUTPUT format, unless the OUTPUT format is incompati=
ble with the
> > > > > > newly selected codec.
> > > > >
> > > > > Let me think about it for a while.
> > > >
> > > > Sleep on it, always works well for me :-)
> > >
> > > Okay, I think I'm not convinced.
> > >
> > > I believe we decided to allow sizeimage to be specified by the
> > > application, because it knows more about the stream it's going to
> > > encode. Only setting the size to 0 would make the encoder fall back t=
o
> > > some simple internal heuristic.
> >
> > Yes, that was the plan, but the patch stalled. I completely forgot
> > about this patch :-)
> >
> > My last reply to "Re: [RFC PATCH] media/doc: Allow sizeimage to be set =
by
> > v4l clients" was March 14th.
> >
> > Also, sizeimage must be at least the minimum size required for the give=
n
> > CAPTURE width and height. So if it is less, then sizeimage will be set =
to that
> > minimum size.
> >
> > > Another thing is handling resolution changes. I believe that would
> > > have to be handled by stopping the OUTPUT queue, changing the OUTPUT
> > > format and starting the OUTPUT queue, all that without stopping the
> > > CAPTURE queue. With the behavior you described it wouldn't work,
> > > because the OUTPUT format couldn't be changed.
> > >
> > > I'd suggest making OUTPUT format changes not change the CAPTURE sizei=
mage.
> >
> > So OUTPUT format changes will still update the CAPTURE width and height=
?
> >
> > It's kind of weird if you are encoding e.g. 1920x1080 but the CAPTURE f=
ormat
> > says 1280x720. I'm not sure what is best.
> >
> > What if the CAPTURE sizeimage is too small for the new OUTPUT resolutio=
n?
> > Should S_FMT(OUTPUT) fail with some error in that case?
>
> Sounds like we need something similar to the SOURCE_CHANGE event
> mechanism if we want to allow dynamic bitrate control which would
> require re-allocation of the capture buffer queue. (Or any other
> runtime control on our encoders, which is really expected to be
> supported these days).

Sounds like it. Or we could just assume that one needs to stop both
queues to do a resolution change, since most codes would anyway reset
the stream (e.g. send PPS/SPS, etc. for H.264) to change the
resolution. Not sure if that assumption always holds, though.

Best regards,
Tomasz
