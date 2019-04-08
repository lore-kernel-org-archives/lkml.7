Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E12FC282DE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2397520880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f7vhGPzN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfDHJfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:35:16 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36045 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfDHJfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:35:16 -0400
Received: by mail-ot1-f65.google.com with SMTP id o74so11383379ota.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 02:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZzT4sSQolUv4mn0BQHFmQCUTjH0rVG/E5grQNBvVW6k=;
        b=f7vhGPzNcYql76iMtnOhYU9d/B6D0JfNePw+7Fjam0mHRNcyLgy5Varkw2At8a/jwJ
         mOX4ZHte91RX7lM+ANa0CF1kiZDh55hvQAOKV4XL+VtfLERWVrO9ICnlRtCaEBtdsi8w
         X2bmYEXey36fNfPo8qvPGuV8FTlTeibCL8fqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZzT4sSQolUv4mn0BQHFmQCUTjH0rVG/E5grQNBvVW6k=;
        b=cpN/llC8b5uHLKMti3pT0jKQwBuK2+U3nAVfm3oFpaGaaLA2lioVjGGRWRlWLHfxyx
         pyHRH6kH9CdE5iBiJvds4BKqrQYqE6kaS1ydjdgo+X/cdWjI7JuwxWH5HDHbg/wfsBK0
         0p5EBBsN5iktcaMbIvUUzvhdjtuLj/wRvWCHKNbbdIp/vp5ajqCWgMnkxRQhiAOLYd10
         lwGzbeh6dQI07i0cMIbZ9XkUIv+qx+hsuMiJvKcdOe+xkC/uNnAdYFieKpOLhg61jKna
         Tx3ugKB/ZJgHtZ+B/3uBXxmE4bREDidmO1T15bbT81sfByXfzSjonB271XNu/yvNB86o
         aY4A==
X-Gm-Message-State: APjAAAX3gmBbZyrF34ff+ZyGYYTVMBF10dPc0hIXX6Y2jcimggNl1/gP
        pPvKot7prK93P0OgFx76rbWTyH89jkA=
X-Google-Smtp-Source: APXvYqwIdhnqqa2TrQG1aoCxW7qM11/9wKOYkAkHLeSlWHysmXU71J5BPfx439Mm/LIIw9iG84cGhg==
X-Received: by 2002:a05:6830:1192:: with SMTP id u18mr18937603otq.295.1554716113334;
        Mon, 08 Apr 2019 02:35:13 -0700 (PDT)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com. [209.85.210.50])
        by smtp.gmail.com with ESMTPSA id w131sm11640702oig.29.2019.04.08.02.35.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 02:35:12 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id e80so11380238ote.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 02:35:11 -0700 (PDT)
X-Received: by 2002:a9d:6e88:: with SMTP id a8mr18410966otr.117.1554716111302;
 Mon, 08 Apr 2019 02:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190124100419.26492-1-tfiga@chromium.org> <20190124100419.26492-3-tfiga@chromium.org>
 <7dc32e83-dec3-37d6-9bfe-e162c495dcf3@xs4all.nl> <CAAFQd5APTQNdH0wbAJpkBO+spXT=dK3e=egv3648bGNPw5-bJA@mail.gmail.com>
 <515c409c-dfe9-d5dc-33e2-f8dcf5eb9cef@xs4all.nl>
In-Reply-To: <515c409c-dfe9-d5dc-33e2-f8dcf5eb9cef@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 8 Apr 2019 18:35:01 +0900
X-Gmail-Original-Message-ID: <CAAFQd5A152y=6pw9kfn7+0n89W-zg48JT6BFUOh5qF313dyjfg@mail.gmail.com>
Message-ID: <CAAFQd5A152y=6pw9kfn7+0n89W-zg48JT6BFUOh5qF313dyjfg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] media: docs-rst: Document memory-to-memory video
 encoder interface
To:     Hans Verkuil <hverkuil@xs4all.nl>
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
        =?UTF-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <andrew-ct.chen@mediatek.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
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

On Mon, Apr 8, 2019 at 4:43 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 4/8/19 8:59 AM, Tomasz Figa wrote:
> > On Thu, Mar 21, 2019 at 7:11 PM Hans Verkuil <hverkuil@xs4all.nl> wrote=
:
> >>
> >> Hi Tomasz,
> >>
> >> A few more comments:
> >>
> >> On 1/24/19 11:04 AM, Tomasz Figa wrote:
> >>> Due to complexity of the video encoding process, the V4L2 drivers of
> >>> stateful encoder hardware require specific sequences of V4L2 API call=
s
> >>> to be followed. These include capability enumeration, initialization,
> >>> encoding, encode parameters change, drain and reset.
> >>>
> >>> Specifics of the above have been discussed during Media Workshops at
> >>> LinuxCon Europe 2012 in Barcelona and then later Embedded Linux
> >>> Conference Europe 2014 in D=C3=BCsseldorf. The de facto Codec API tha=
t
> >>> originated at those events was later implemented by the drivers we al=
ready
> >>> have merged in mainline, such as s5p-mfc or coda.
> >>>
> >>> The only thing missing was the real specification included as a part =
of
> >>> Linux Media documentation. Fix it now and document the encoder part o=
f
> >>> the Codec API.
> >>>
> >>> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> >>> ---
> >>>  Documentation/media/uapi/v4l/dev-encoder.rst  | 586 ++++++++++++++++=
++
> >>>  Documentation/media/uapi/v4l/dev-mem2mem.rst  |   1 +
> >>>  Documentation/media/uapi/v4l/pixfmt-v4l2.rst  |   5 +
> >>>  Documentation/media/uapi/v4l/v4l2.rst         |   2 +
> >>>  .../media/uapi/v4l/vidioc-encoder-cmd.rst     |  38 +-
> >>>  5 files changed, 617 insertions(+), 15 deletions(-)
> >>>  create mode 100644 Documentation/media/uapi/v4l/dev-encoder.rst
> >>>
> >>> diff --git a/Documentation/media/uapi/v4l/dev-encoder.rst b/Documenta=
tion/media/uapi/v4l/dev-encoder.rst
> >>> new file mode 100644
> >>> index 000000000000..fb8b05a132ee
> >>> --- /dev/null
> >>> +++ b/Documentation/media/uapi/v4l/dev-encoder.rst
> >>> @@ -0,0 +1,586 @@
> >>> +.. -*- coding: utf-8; mode: rst -*-
> >>> +
> >>> +.. _encoder:
> >>> +
> >>> +*************************************************
> >>> +Memory-to-memory Stateful Video Encoder Interface
> >>> +*************************************************
> >>> +
> >>> +A stateful video encoder takes raw video frames in display order and=
 encodes
> >>> +them into a bitstream. It generates complete chunks of the bitstream=
, including
> >>> +all metadata, headers, etc. The resulting bitstream does not require=
 any
> >>> +further post-processing by the client.
> >>> +
> >>> +Performing software stream processing, header generation etc. in the=
 driver
> >>> +in order to support this interface is strongly discouraged. In case =
such
> >>> +operations are needed, use of the Stateless Video Encoder Interface =
(in
> >>> +development) is strongly advised.
> >>> +
> >>> +Conventions and notation used in this document
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> +
> >>> +1. The general V4L2 API rules apply if not specified in this documen=
t
> >>> +   otherwise.
> >>> +
> >>> +2. The meaning of words "must", "may", "should", etc. is as per `RFC
> >>> +   2119 <https://tools.ietf.org/html/rfc2119>`_.
> >>> +
> >>> +3. All steps not marked "optional" are required.
> >>> +
> >>> +4. :c:func:`VIDIOC_G_EXT_CTRLS` and :c:func:`VIDIOC_S_EXT_CTRLS` may=
 be used
> >>> +   interchangeably with :c:func:`VIDIOC_G_CTRL` and :c:func:`VIDIOC_=
S_CTRL`,
> >>> +   unless specified otherwise.
> >>> +
> >>> +5. Single-planar API (see :ref:`planar-apis`) and applicable structu=
res may be
> >>> +   used interchangeably with multi-planar API, unless specified othe=
rwise,
> >>> +   depending on decoder capabilities and following the general V4L2 =
guidelines.
> >>
> >> decoder -> encoder
> >>
> >
> > Ack.
> >
> >>> +
> >>> +6. i =3D [a..b]: sequence of integers from a to b, inclusive, i.e. i=
 =3D
> >>> +   [0..2]: i =3D 0, 1, 2.
> >>> +
> >>> +7. Given an ``OUTPUT`` buffer A, then A=E2=80=99 represents a buffer=
 on the ``CAPTURE``
> >>> +   queue containing data that resulted from processing buffer A.
> >>> +
> >>> +Glossary
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D
> >>> +
> >>> +Refer to :ref:`decoder-glossary`.
> >>> +
> >>> +State machine
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> +
> >>> +.. kernel-render:: DOT
> >>> +   :alt: DOT digraph of encoder state machine
> >>> +   :caption: Encoder state machine
> >>> +
> >>> +   digraph encoder_state_machine {
> >>> +       node [shape =3D doublecircle, label=3D"Encoding"] Encoding;
> >>> +
> >>> +       node [shape =3D circle, label=3D"Initialization"] Initializat=
ion;
> >>> +       node [shape =3D circle, label=3D"Stopped"] Stopped;
> >>> +       node [shape =3D circle, label=3D"Drain"] Drain;
> >>> +       node [shape =3D circle, label=3D"Reset"] Reset;
> >>> +
> >>> +       node [shape =3D point]; qi
> >>> +       qi -> Initialization [ label =3D "open()" ];
> >>> +
> >>> +       Initialization -> Encoding [ label =3D "Both queues streaming=
" ];
> >>> +
> >>> +       Encoding -> Drain [ label =3D "V4L2_DEC_CMD_STOP" ];
> >>> +       Encoding -> Reset [ label =3D "VIDIOC_STREAMOFF(CAPTURE)" ];
> >>> +       Encoding -> Stopped [ label =3D "VIDIOC_STREAMOFF(OUTPUT)" ];
> >>> +       Encoding -> Encoding;
> >>> +
> >>> +       Drain -> Stopped [ label =3D "All CAPTURE\nbuffers dequeued\n=
or\nVIDIOC_STREAMOFF(CAPTURE)" ];
> >>> +       Drain -> Reset [ label =3D "VIDIOC_STREAMOFF(CAPTURE)" ];
> >>> +
> >>> +       Reset -> Encoding [ label =3D "VIDIOC_STREAMON(CAPTURE)" ];
> >>> +       Reset -> Initialization [ label =3D "VIDIOC_REQBUFS(OUTPUT, 0=
)" ];
> >>> +
> >>> +       Stopped -> Encoding [ label =3D "V4L2_DEC_CMD_START\nor\nVIDI=
OC_STREAMON(OUTPUT)" ];
> >>> +       Stopped -> Reset [ label =3D "VIDIOC_STREAMOFF(CAPTURE)" ];
> >>> +   }
> >>> +
> >>> +Querying capabilities
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> +
> >>> +1. To enumerate the set of coded formats supported by the encoder, t=
he
> >>> +   client may call :c:func:`VIDIOC_ENUM_FMT` on ``CAPTURE``.
> >>> +
> >>> +   * The full set of supported formats will be returned, regardless =
of the
> >>> +     format set on ``OUTPUT``.
> >>> +
> >>> +2. To enumerate the set of supported raw formats, the client may cal=
l
> >>> +   :c:func:`VIDIOC_ENUM_FMT` on ``OUTPUT``.
> >>> +
> >>> +   * Only the formats supported for the format currently active on `=
`CAPTURE``
> >>> +     will be returned.
> >>> +
> >>> +   * In order to enumerate raw formats supported by a given coded fo=
rmat,
> >>> +     the client must first set that coded format on ``CAPTURE`` and =
then
> >>> +     enumerate the formats on ``OUTPUT``.
> >>> +
> >>> +3. The client may use :c:func:`VIDIOC_ENUM_FRAMESIZES` to detect sup=
ported
> >>> +   resolutions for a given format, passing desired pixel format in
> >>> +   :c:type:`v4l2_frmsizeenum` ``pixel_format``.
> >>> +
> >>> +   * Values returned by :c:func:`VIDIOC_ENUM_FRAMESIZES` for a coded=
 pixel
> >>> +     format will include all possible coded resolutions supported by=
 the
> >>> +     encoder for given coded pixel format.
> >>> +
> >>> +   * Values returned by :c:func:`VIDIOC_ENUM_FRAMESIZES` for a raw p=
ixel format
> >>> +     will include all possible frame buffer resolutions supported by=
 the
> >>> +     encoder for given raw pixel format and coded format currently s=
et on
> >>> +     ``CAPTURE``.
> >>> +
> >>> +4. Supported profiles and levels for the coded format currently set =
on
> >>> +   ``CAPTURE``, if applicable, may be queried using their respective=
 controls
> >>> +   via :c:func:`VIDIOC_QUERYCTRL`.
> >>> +
> >>> +5. Any additional encoder capabilities may be discovered by querying
> >>> +   their respective controls.
> >>> +
> >>> +Initialization
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> +
> >>> +1. Set the coded format on the ``CAPTURE`` queue via :c:func:`VIDIOC=
_S_FMT`
> >>> +
> >>> +   * **Required fields:**
> >>> +
> >>> +     ``type``
> >>> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``CAPTURE``
> >>> +
> >>> +     ``pixelformat``
> >>> +         the coded format to be produced
> >>> +
> >>> +     ``sizeimage``
> >>> +         desired size of ``CAPTURE`` buffers; the encoder may adjust=
 it to
> >>> +         match hardware requirements
> >>> +
> >>> +     ``width``, ``height``
> >>> +         ignored (always zero)
> >>> +
> >>> +     other fields
> >>> +         follow standard semantics
> >>> +
> >>> +   * **Return fields:**
> >>> +
> >>> +     ``sizeimage``
> >>> +         adjusted size of ``CAPTURE`` buffers
> >>> +
> >>> +   .. important::
> >>> +
> >>> +      Changing the ``CAPTURE`` format may change the currently set `=
`OUTPUT``
> >>> +      format. The encoder will derive a new ``OUTPUT`` format from t=
he
> >>> +      ``CAPTURE`` format being set, including resolution, colorimetr=
y
> >>> +      parameters, etc. If the client needs a specific ``OUTPUT`` for=
mat, it
> >>> +      must adjust it afterwards.
> >>> +
> >>> +2. **Optional.** Enumerate supported ``OUTPUT`` formats (raw formats=
 for
> >>> +   source) for the selected coded format via :c:func:`VIDIOC_ENUM_FM=
T`.
> >>> +
> >>> +   * **Required fields:**
> >>> +
> >>> +     ``type``
> >>> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
> >>> +
> >>> +     other fields
> >>> +         follow standard semantics
> >>> +
> >>> +   * **Return fields:**
> >>> +
> >>> +     ``pixelformat``
> >>> +         raw format supported for the coded format currently selecte=
d on
> >>> +         the ``CAPTURE`` queue.
> >>> +
> >>> +     other fields
> >>> +         follow standard semantics
> >>> +
> >>> +3. Set the raw source format on the ``OUTPUT`` queue via
> >>> +   :c:func:`VIDIOC_S_FMT`.
> >>> +
> >>> +   * **Required fields:**
> >>> +
> >>> +     ``type``
> >>> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
> >>> +
> >>> +     ``pixelformat``
> >>> +         raw format of the source
> >>> +
> >>> +     ``width``, ``height``
> >>> +         source resolution
> >>> +
> >>> +     other fields
> >>> +         follow standard semantics
> >>> +
> >>> +   * **Return fields:**
> >>> +
> >>> +     ``width``, ``height``
> >>> +         may be adjusted by encoder to match alignment requirements,=
 as
> >>> +         required by the currently selected formats
> >>> +
> >>> +     other fields
> >>> +         follow standard semantics
> >>> +
> >>> +   * Setting the source resolution will reset the selection rectangl=
es to their
> >>> +     default values, based on the new resolution, as described in th=
e step 5
> >>> +     below.
> >>> +
> >>> +4. **Optional.** Set the visible resolution for the stream metadata =
via
> >>> +   :c:func:`VIDIOC_S_SELECTION` on the ``OUTPUT`` queue.
> >>> +
> >>> +   * **Required fields:**
> >>> +
> >>> +     ``type``
> >>> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
> >>> +
> >>> +     ``target``
> >>> +         set to ``V4L2_SEL_TGT_CROP``
> >>> +
> >>> +     ``r.left``, ``r.top``, ``r.width``, ``r.height``
> >>> +         visible rectangle; this must fit within the `V4L2_SEL_TGT_C=
ROP_BOUNDS`
> >>> +         rectangle and may be subject to adjustment to match codec a=
nd
> >>> +         hardware constraints
> >>> +
> >>> +   * **Return fields:**
> >>> +
> >>> +     ``r.left``, ``r.top``, ``r.width``, ``r.height``
> >>> +         visible rectangle adjusted by the encoder
> >>> +
> >>> +   * The following selection targets are supported on ``OUTPUT``:
> >>> +
> >>> +     ``V4L2_SEL_TGT_CROP_BOUNDS``
> >>> +         equal to the full source frame, matching the active ``OUTPU=
T``
> >>> +         format
> >>> +
> >>> +     ``V4L2_SEL_TGT_CROP_DEFAULT``
> >>> +         equal to ``V4L2_SEL_TGT_CROP_BOUNDS``
> >>> +
> >>> +     ``V4L2_SEL_TGT_CROP``
> >>> +         rectangle within the source buffer to be encoded into the
> >>> +         ``CAPTURE`` stream; defaults to ``V4L2_SEL_TGT_CROP_DEFAULT=
``
> >>> +
> >>> +         .. note::
> >>> +
> >>> +            A common use case for this selection target is encoding =
a source
> >>> +            video with a resolution that is not a multiple of a macr=
oblock,
> >>> +            e.g.  the common 1920x1080 resolution may require the so=
urce
> >>> +            buffers to be aligned to 1920x1088 for codecs with 16x16=
 macroblock
> >>> +            size. To avoid encoding the padding, the client needs to=
 explicitly
> >>> +            configure this selection target to 1920x1080.
> >>> +
> >>> +     ``V4L2_SEL_TGT_COMPOSE_BOUNDS``
> >>> +         maximum rectangle within the coded resolution, which the cr=
opped
> >>> +         source frame can be composed into; if the hardware does not=
 support
> >>> +         composition or scaling, then this is always equal to the re=
ctangle of
> >>> +         width and height matching ``V4L2_SEL_TGT_CROP`` and located=
 at (0, 0)
> >>> +
> >>> +     ``V4L2_SEL_TGT_COMPOSE_DEFAULT``
> >>> +         equal to a rectangle of width and height matching
> >>> +         ``V4L2_SEL_TGT_CROP`` and located at (0, 0)
> >>> +
> >>> +     ``V4L2_SEL_TGT_COMPOSE``
> >>> +         rectangle within the coded frame, which the cropped source =
frame
> >>> +         is to be composed into; defaults to
> >>> +         ``V4L2_SEL_TGT_COMPOSE_DEFAULT``; read-only on hardware wit=
hout
> >>> +         additional compose/scaling capabilities; resulting stream w=
ill
> >>> +         have this rectangle encoded as the visible rectangle in its
> >>> +         metadata
> >>
> >> I would only support the COMPOSE targets if the hardware can actually =
do
> >> scaling and/or composing. That is conform standard V4L2 behavior where
> >> cropping/composing is only implemented if the hardware can actually do
> >> this.
> >>
> >
> > Please see my other reply to your earlier similar comment in this threa=
d.
> >
> >>> +
> >>> +   .. warning::
> >>> +
> >>> +      The encoder may adjust the crop/compose rectangles to the near=
est
> >>> +      supported ones to meet codec and hardware requirements. The cl=
ient needs
> >>> +      to check the adjusted rectangle returned by :c:func:`VIDIOC_S_=
SELECTION`.
> >>> +
> >>> +5. Allocate buffers for both ``OUTPUT`` and ``CAPTURE`` via
> >>> +   :c:func:`VIDIOC_REQBUFS`. This may be performed in any order.
> >>> +
> >>> +   * **Required fields:**
> >>> +
> >>> +     ``count``
> >>> +         requested number of buffers to allocate; greater than zero
> >>> +
> >>> +     ``type``
> >>> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT`` or
> >>> +         ``CAPTURE``
> >>> +
> >>> +     other fields
> >>> +         follow standard semantics
> >>> +
> >>> +   * **Return fields:**
> >>> +
> >>> +     ``count``
> >>> +          actual number of buffers allocated
> >>> +
> >>> +   .. warning::
> >>> +
> >>> +      The actual number of allocated buffers may differ from the ``c=
ount``
> >>> +      given. The client must check the updated value of ``count`` af=
ter the
> >>> +      call returns.
> >>> +
> >>> +   .. note::
> >>> +
> >>> +      To allocate more than the minimum number of OUTPUT buffers (fo=
r pipeline
> >>> +      depth), the client may query the ``V4L2_CID_MIN_BUFFERS_FOR_OU=
TPUT``
> >>> +      control to get the minimum number of buffers required, and pas=
s the
> >>> +      obtained value plus the number of additional buffers needed in=
 the
> >>> +      ``count`` field to :c:func:`VIDIOC_REQBUFS`.
> >>> +
> >>> +   Alternatively, :c:func:`VIDIOC_CREATE_BUFS` can be used to have m=
ore
> >>> +   control over buffer allocation.
> >>> +
> >>> +   * **Required fields:**
> >>> +
> >>> +     ``count``
> >>> +         requested number of buffers to allocate; greater than zero
> >>> +
> >>> +     ``type``
> >>> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
> >>> +
> >>> +     other fields
> >>> +         follow standard semantics
> >>> +
> >>> +   * **Return fields:**
> >>> +
> >>> +     ``count``
> >>> +         adjusted to the number of allocated buffers
> >>> +
> >>> +6. Begin streaming on both ``OUTPUT`` and ``CAPTURE`` queues via
> >>> +   :c:func:`VIDIOC_STREAMON`. This may be performed in any order. Th=
e actual
> >>> +   encoding process starts when both queues start streaming.
> >>> +
> >>> +.. note::
> >>> +
> >>> +   If the client stops the ``CAPTURE`` queue during the encode proce=
ss and then
> >>> +   restarts it again, the encoder will begin generating a stream ind=
ependent
> >>> +   from the stream generated before the stop. The exact constraints =
depend
> >>> +   on the coded format, but may include the following implications:
> >>> +
> >>> +   * encoded frames produced after the restart must not reference an=
y
> >>> +     frames produced before the stop, e.g. no long term references f=
or
> >>> +     H.264,
> >>> +
> >>> +   * any headers that must be included in a standalone stream must b=
e
> >>> +     produced again, e.g. SPS and PPS for H.264.
> >>> +
> >>> +Encoding
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D
> >>> +
> >>> +This state is reached after the `Initialization` sequence finishes
> >>> +successfully.  In this state, the client queues and dequeues buffers=
 to both
> >>> +queues via :c:func:`VIDIOC_QBUF` and :c:func:`VIDIOC_DQBUF`, followi=
ng the
> >>> +standard semantics.
> >>> +
> >>> +The contents of encoded ``CAPTURE`` buffers depend on the active cod=
ed pixel
> >>> +format and may be affected by codec-specific extended controls, as s=
tated
> >>> +in the documentation of each format.
> >>> +
> >>> +Both queues operate independently, following standard behavior of V4=
L2 buffer
> >>> +queues and memory-to-memory devices. In addition, the order of encod=
ed frames
> >>> +dequeued from the ``CAPTURE`` queue may differ from the order of que=
uing raw
> >>> +frames to the ``OUTPUT`` queue, due to properties of the selected co=
ded format,
> >>> +e.g. frame reordering.
> >>> +
> >>> +The client must not assume any direct relationship between ``CAPTURE=
`` and
> >>> +``OUTPUT`` buffers and any specific timing of buffers becoming
> >>> +available to dequeue. Specifically:
> >>> +
> >>> +* a buffer queued to ``OUTPUT`` may result in more than 1 buffer pro=
duced on
> >>> +  ``CAPTURE`` (if returning an encoded frame allowed the encoder to =
return a
> >>> +  frame that preceded it in display, but succeeded it in the decode =
order),
> >>> +
> >>> +* a buffer queued to ``OUTPUT`` may result in a buffer being produce=
d on
> >>> +  ``CAPTURE`` later into encode process, and/or after processing fur=
ther
> >>> +  ``OUTPUT`` buffers, or be returned out of order, e.g. if display
> >>> +  reordering is used,
> >>> +
> >>> +* buffers may become available on the ``CAPTURE`` queue without addi=
tional
> >>> +  buffers queued to ``OUTPUT`` (e.g. during drain or ``EOS``), becau=
se of the
> >>> +  ``OUTPUT`` buffers queued in the past whose decoding results are o=
nly
> >>> +  available at later time, due to specifics of the decoding process,
> >>> +
> >>> +* buffers queued to ``OUTPUT`` may not become available to dequeue i=
nstantly
> >>> +  after being encoded into a corresponding ``CATPURE`` buffer, e.g. =
if the
> >>> +  encoder needs to use the frame as a reference for encoding further=
 frames.
> >>> +
> >>> +.. note::
> >>> +
> >>> +   To allow matching encoded ``CAPTURE`` buffers with ``OUTPUT`` buf=
fers they
> >>> +   originated from, the client can set the ``timestamp`` field of th=
e
> >>> +   :c:type:`v4l2_buffer` struct when queuing an ``OUTPUT`` buffer. T=
he
> >>> +   ``CAPTURE`` buffer(s), which resulted from encoding that ``OUTPUT=
`` buffer
> >>> +   will have their ``timestamp`` field set to the same value when de=
queued.
> >>> +
> >>> +   In addition to the straightforward case of one ``OUTPUT`` buffer =
producing
> >>> +   one ``CAPTURE`` buffer, the following cases are defined:
> >>> +
> >>> +   * one ``OUTPUT`` buffer generates multiple ``CAPTURE`` buffers: t=
he same
> >>> +     ``OUTPUT`` timestamp will be copied to multiple ``CAPTURE`` buf=
fers,
> >>> +
> >>> +   * the encoding order differs from the presentation order (i.e. th=
e
> >>> +     ``CAPTURE`` buffers are out-of-order compared to the ``OUTPUT``=
 buffers):
> >>> +     ``CAPTURE`` timestamps will not retain the order of ``OUTPUT`` =
timestamps
> >>> +     and thus monotonicity of the timestamps cannot be guaranteed.
> >>> +
> >>> +.. note::
> >>> +
> >>> +   To let the client distinguish between frame types (keyframes, int=
ermediate
> >>> +   frames; the exact list of types depends on the coded format), the
> >>> +   ``CAPTURE`` buffers will have corresponding flag bits set in thei=
r
> >>> +   :c:type:`v4l2_buffer` struct when dequeued. See the documentation=
 of
> >>> +   :c:type:`v4l2_buffer` and each coded pixel format for exact list =
of flags
> >>> +   and their meanings.
> >>
> >> I don't think we can require this since a capture buffer may contain m=
ultiple
> >> encoded frames.
> >>
> >
> > I thought we required that only one encoded frame was in one CAPTURE
> > buffer. Real time use cases rely heavily on this frame type
> > information, so I can't imagine not requiring this.
>
> That the CAPTURE buffer contains only one encoded frame is never stated
> explicitly. I am not so sure I want that to be a hard requirement anyway
> since the old ivtv MPEG encoder just produces a bitstream.
>
> Perhaps this should be signaled with a flag in ENUM_FMT?
>
> >
> >> It would actually make more sense to return it in the output buffer, b=
ut I don't
> >> know if a hardware encoder can actually provide that information.
> >>
> >
> > I believe all the already existing drivers provide the information
> > about the encoded frame type, but I don't think they provide the
> > information about what source frame it came from.
> >
> >> Another use of these flags for an output buffer is to force a keyframe=
 if for
> >> example a scene change was detected.
> >>
> >> My feeling is that we should drop this note. Forcing a keyframe by set=
ting that
> >> flag for the output buffer might actually be a useful thing to do for =
a stateful
> >> encoder.
> >>
> >
> > However, to force keyframe, one sets it in the OUTPUT buffer. Then, to
> > actually get the right CAPTURE buffer, one has to look for one with
> > this flag set.
>
> So *if* the driver stores only one encoded frame in a CAPTURE buffer, the=
n we
> can require that these flags have to be set for that CAPTURE buffer. Othe=
rwise
> they should be cleared since they cannot be associated with a specific bu=
ffer.

But then we don't know to which source frame it applies, while it's
usually quite important to force the key frame at the right frame,
e.g. scene change.

>
> And I think it should be documented that you can set the KEYFRAME flag in=
 the
> OUTPUT buffer to force a keyframe (the driver may ignore this if it can't=
 do
> this for some reason).

Indeed. Let me make sure it's included in the document.

Best regards,
Tomasz
