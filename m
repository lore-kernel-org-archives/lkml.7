Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528DBC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 05:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E074D21738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 05:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gecTCYQG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfDEFxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 01:53:33 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46630 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfDEFxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 01:53:33 -0400
Received: by mail-ot1-f65.google.com with SMTP id s24so4543117otk.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 22:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+1aHKHMBIahT++eAGRzprv8AEPG0+wZMF02pfdaTUWU=;
        b=gecTCYQGJ9B3/0lBycwLUYYOHJocVHIwAM6/7ww+Xv9sciExNYpFDiSsgGEK9kzybj
         uyP3EDteQwM0KrBAVVGARmllgx8JHL9O9TCAERy666fUKrqEIaeZphUCUQZE1MbO/3Ow
         u74BJ01dGKD026kvW8JrwrQelh/vMsQcdoFTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+1aHKHMBIahT++eAGRzprv8AEPG0+wZMF02pfdaTUWU=;
        b=Xm2Kk2W/YzXdDUH3tIX69/O1exvk7o3aU5v88EyQGhYgJ7K0r6nt47Bw7vNKtHwvrX
         arXxW0nRpxApofnQCardJTwfpeb3prrCRCfBsQx3vNAzR0xKOfqpPrLXlJXl/3775mGh
         9Q+NjLFZTZ7d7H2UWF4rNsm9Dpil0RJPIWEx8G2Hvd7N2ZASDks+YlTGF6E3N5rp2tuL
         A4fb3jJbZazyloEPcIRSbBNh45S96AHksjW4zNdrWWLhK9xlsXBGXyQunnHkVkA7PwLW
         DnaA4GJOlTQLDju4A4cHbZrFOj3JzO4tX3H7pVyP3sr+FmgAWFJbLG86ZGbnbgZsRQh8
         ZWpA==
X-Gm-Message-State: APjAAAUuEROd0V7hgluB8OyYcTmlJbBgzri4bzv9dNcokro1quPEHcZ0
        SU1D11q87RyWwUwshKGtW9EW2HMaDlQ=
X-Google-Smtp-Source: APXvYqy393bmXXn0eSgjvx9lC6Sx3SzGeEtftcePrcRczpaL3cu34Vg1ySnyNwWlrpEk1ccF6YQ5Zw==
X-Received: by 2002:a9d:62c8:: with SMTP id z8mr7500893otk.144.1554443611249;
        Thu, 04 Apr 2019 22:53:31 -0700 (PDT)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com. [209.85.210.49])
        by smtp.gmail.com with ESMTPSA id o10sm6467934oif.41.2019.04.04.22.53.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 22:53:29 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id k21so4630078otf.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 22:53:29 -0700 (PDT)
X-Received: by 2002:a9d:7749:: with SMTP id t9mr7162495otl.229.1554443609056;
 Thu, 04 Apr 2019 22:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190124100419.26492-1-tfiga@chromium.org> <20190124100419.26492-3-tfiga@chromium.org>
 <4bbe4ce4-615a-b981-0855-cd78c7a002d9@xs4all.nl>
In-Reply-To: <4bbe4ce4-615a-b981-0855-cd78c7a002d9@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 5 Apr 2019 14:53:17 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Dd9s-+XmA-KhokarCGUH6qCbdY3qcYq3oSfW7oRmMtMg@mail.gmail.com>
Message-ID: <CAAFQd5Dd9s-+XmA-KhokarCGUH6qCbdY3qcYq3oSfW7oRmMtMg@mail.gmail.com>
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

On Tue, Jan 29, 2019 at 10:53 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> Hi Tomasz,
>
> Some comments below. Nothing major, so I think a v4 should be ready to be
> merged.
>
> On 1/24/19 11:04 AM, Tomasz Figa wrote:
> > Due to complexity of the video encoding process, the V4L2 drivers of
> > stateful encoder hardware require specific sequences of V4L2 API calls
> > to be followed. These include capability enumeration, initialization,
> > encoding, encode parameters change, drain and reset.
> >
> > Specifics of the above have been discussed during Media Workshops at
> > LinuxCon Europe 2012 in Barcelona and then later Embedded Linux
> > Conference Europe 2014 in D=C3=BCsseldorf. The de facto Codec API that
> > originated at those events was later implemented by the drivers we alre=
ady
> > have merged in mainline, such as s5p-mfc or coda.
> >
> > The only thing missing was the real specification included as a part of
> > Linux Media documentation. Fix it now and document the encoder part of
> > the Codec API.
> >
> > Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> > ---
> >  Documentation/media/uapi/v4l/dev-encoder.rst  | 586 ++++++++++++++++++
> >  Documentation/media/uapi/v4l/dev-mem2mem.rst  |   1 +
> >  Documentation/media/uapi/v4l/pixfmt-v4l2.rst  |   5 +
> >  Documentation/media/uapi/v4l/v4l2.rst         |   2 +
> >  .../media/uapi/v4l/vidioc-encoder-cmd.rst     |  38 +-
> >  5 files changed, 617 insertions(+), 15 deletions(-)
> >  create mode 100644 Documentation/media/uapi/v4l/dev-encoder.rst
> >
> > diff --git a/Documentation/media/uapi/v4l/dev-encoder.rst b/Documentati=
on/media/uapi/v4l/dev-encoder.rst
> > new file mode 100644
> > index 000000000000..fb8b05a132ee
> > --- /dev/null
> > +++ b/Documentation/media/uapi/v4l/dev-encoder.rst
> > @@ -0,0 +1,586 @@
> > +.. -*- coding: utf-8; mode: rst -*-
> > +
> > +.. _encoder:
> > +
> > +*************************************************
> > +Memory-to-memory Stateful Video Encoder Interface
> > +*************************************************
> > +
> > +A stateful video encoder takes raw video frames in display order and e=
ncodes
> > +them into a bitstream. It generates complete chunks of the bitstream, =
including
> > +all metadata, headers, etc. The resulting bitstream does not require a=
ny
> > +further post-processing by the client.
> > +
> > +Performing software stream processing, header generation etc. in the d=
river
> > +in order to support this interface is strongly discouraged. In case su=
ch
> > +operations are needed, use of the Stateless Video Encoder Interface (i=
n
> > +development) is strongly advised.
> > +
> > +Conventions and notation used in this document
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +1. The general V4L2 API rules apply if not specified in this document
> > +   otherwise.
> > +
> > +2. The meaning of words "must", "may", "should", etc. is as per `RFC
> > +   2119 <https://tools.ietf.org/html/rfc2119>`_.
> > +
> > +3. All steps not marked "optional" are required.
> > +
> > +4. :c:func:`VIDIOC_G_EXT_CTRLS` and :c:func:`VIDIOC_S_EXT_CTRLS` may b=
e used
> > +   interchangeably with :c:func:`VIDIOC_G_CTRL` and :c:func:`VIDIOC_S_=
CTRL`,
> > +   unless specified otherwise.
> > +
> > +5. Single-planar API (see :ref:`planar-apis`) and applicable structure=
s may be
> > +   used interchangeably with multi-planar API, unless specified otherw=
ise,
> > +   depending on decoder capabilities and following the general V4L2 gu=
idelines.
> > +
> > +6. i =3D [a..b]: sequence of integers from a to b, inclusive, i.e. i =
=3D
> > +   [0..2]: i =3D 0, 1, 2.
> > +
> > +7. Given an ``OUTPUT`` buffer A, then A=E2=80=99 represents a buffer o=
n the ``CAPTURE``
> > +   queue containing data that resulted from processing buffer A.
> > +
> > +Glossary
> > +=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Refer to :ref:`decoder-glossary`.
> > +
> > +State machine
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +.. kernel-render:: DOT
> > +   :alt: DOT digraph of encoder state machine
> > +   :caption: Encoder state machine
> > +
> > +   digraph encoder_state_machine {
> > +       node [shape =3D doublecircle, label=3D"Encoding"] Encoding;
> > +
> > +       node [shape =3D circle, label=3D"Initialization"] Initializatio=
n;
> > +       node [shape =3D circle, label=3D"Stopped"] Stopped;
> > +       node [shape =3D circle, label=3D"Drain"] Drain;
> > +       node [shape =3D circle, label=3D"Reset"] Reset;
> > +
> > +       node [shape =3D point]; qi
> > +       qi -> Initialization [ label =3D "open()" ];
> > +
> > +       Initialization -> Encoding [ label =3D "Both queues streaming" =
];
> > +
> > +       Encoding -> Drain [ label =3D "V4L2_DEC_CMD_STOP" ];
> > +       Encoding -> Reset [ label =3D "VIDIOC_STREAMOFF(CAPTURE)" ];
> > +       Encoding -> Stopped [ label =3D "VIDIOC_STREAMOFF(OUTPUT)" ];
> > +       Encoding -> Encoding;
> > +
> > +       Drain -> Stopped [ label =3D "All CAPTURE\nbuffers dequeued\nor=
\nVIDIOC_STREAMOFF(CAPTURE)" ];
> > +       Drain -> Reset [ label =3D "VIDIOC_STREAMOFF(CAPTURE)" ];
> > +
> > +       Reset -> Encoding [ label =3D "VIDIOC_STREAMON(CAPTURE)" ];
> > +       Reset -> Initialization [ label =3D "VIDIOC_REQBUFS(OUTPUT, 0)"=
 ];
> > +
> > +       Stopped -> Encoding [ label =3D "V4L2_DEC_CMD_START\nor\nVIDIOC=
_STREAMON(OUTPUT)" ];
> > +       Stopped -> Reset [ label =3D "VIDIOC_STREAMOFF(CAPTURE)" ];
> > +   }
> > +
> > +Querying capabilities
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +1. To enumerate the set of coded formats supported by the encoder, the
> > +   client may call :c:func:`VIDIOC_ENUM_FMT` on ``CAPTURE``.
> > +
> > +   * The full set of supported formats will be returned, regardless of=
 the
> > +     format set on ``OUTPUT``.
> > +
> > +2. To enumerate the set of supported raw formats, the client may call
> > +   :c:func:`VIDIOC_ENUM_FMT` on ``OUTPUT``.
> > +
> > +   * Only the formats supported for the format currently active on ``C=
APTURE``
> > +     will be returned.
> > +
> > +   * In order to enumerate raw formats supported by a given coded form=
at,
> > +     the client must first set that coded format on ``CAPTURE`` and th=
en
> > +     enumerate the formats on ``OUTPUT``.
> > +
> > +3. The client may use :c:func:`VIDIOC_ENUM_FRAMESIZES` to detect suppo=
rted
> > +   resolutions for a given format, passing desired pixel format in
> > +   :c:type:`v4l2_frmsizeenum` ``pixel_format``.
> > +
> > +   * Values returned by :c:func:`VIDIOC_ENUM_FRAMESIZES` for a coded p=
ixel
> > +     format will include all possible coded resolutions supported by t=
he
> > +     encoder for given coded pixel format.
> > +
> > +   * Values returned by :c:func:`VIDIOC_ENUM_FRAMESIZES` for a raw pix=
el format
> > +     will include all possible frame buffer resolutions supported by t=
he
> > +     encoder for given raw pixel format and coded format currently set=
 on
> > +     ``CAPTURE``.
> > +
> > +4. Supported profiles and levels for the coded format currently set on
> > +   ``CAPTURE``, if applicable, may be queried using their respective c=
ontrols
> > +   via :c:func:`VIDIOC_QUERYCTRL`.
> > +
> > +5. Any additional encoder capabilities may be discovered by querying
> > +   their respective controls.
> > +
> > +Initialization
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +1. Set the coded format on the ``CAPTURE`` queue via :c:func:`VIDIOC_S=
_FMT`
> > +
> > +   * **Required fields:**
> > +
> > +     ``type``
> > +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``CAPTURE``
> > +
> > +     ``pixelformat``
> > +         the coded format to be produced
> > +
> > +     ``sizeimage``
> > +         desired size of ``CAPTURE`` buffers; the encoder may adjust i=
t to
> > +         match hardware requirements
> > +
> > +     ``width``, ``height``
> > +         ignored (always zero)
> > +
> > +     other fields
> > +         follow standard semantics
> > +
> > +   * **Return fields:**
> > +
> > +     ``sizeimage``
> > +         adjusted size of ``CAPTURE`` buffers
> > +
> > +   .. important::
> > +
> > +      Changing the ``CAPTURE`` format may change the currently set ``O=
UTPUT``
> > +      format. The encoder will derive a new ``OUTPUT`` format from the
> > +      ``CAPTURE`` format being set, including resolution, colorimetry
> > +      parameters, etc. If the client needs a specific ``OUTPUT`` forma=
t, it
> > +      must adjust it afterwards.
>
> Hmm, "including resolution": if width and height are set to 0, what shoul=
d the
> OUTPUT resolution be? Up to the driver? I think this should be clarified =
since
> at a first reading of this paragraph it appears to be contradictory.
>

Indeed, it's hard to derive some sensible resolution from 0...

The intention here is to prevent the application from making any
assumptions about the OUTPUT format, if it changes the CAPTURE format.
Then, it shouldn't actually matter what's the new OUTPUT format, since
the application needs to set it anyway.

Maybe let's just remove the mention of deriving and say something
along these lines?

"How the new ``OUTPUT`` format is determined is unspecified and the client =
must
 ensure it matches its needs afterwards."

> > +
> > +2. **Optional.** Enumerate supported ``OUTPUT`` formats (raw formats f=
or
> > +   source) for the selected coded format via :c:func:`VIDIOC_ENUM_FMT`=
.
> > +
> > +   * **Required fields:**
> > +
> > +     ``type``
> > +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
> > +
> > +     other fields
> > +         follow standard semantics
> > +
> > +   * **Return fields:**
> > +
> > +     ``pixelformat``
> > +         raw format supported for the coded format currently selected =
on
> > +         the ``CAPTURE`` queue.
> > +
> > +     other fields
> > +         follow standard semantics
> > +
> > +3. Set the raw source format on the ``OUTPUT`` queue via
> > +   :c:func:`VIDIOC_S_FMT`.
> > +
> > +   * **Required fields:**
> > +
> > +     ``type``
> > +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
> > +
> > +     ``pixelformat``
> > +         raw format of the source
> > +
> > +     ``width``, ``height``
> > +         source resolution
> > +
> > +     other fields
> > +         follow standard semantics
> > +
> > +   * **Return fields:**
> > +
> > +     ``width``, ``height``
> > +         may be adjusted by encoder to match alignment requirements, a=
s
> > +         required by the currently selected formats
>
> What if the width x height is larger than the maximum supported by the
> selected coded format? This should probably mention that in that case the
> width x height is reduced to the largest allowed value. Also mention that
> this maximum is reported by VIDIOC_ENUM_FRAMESIZES.
>

Right, the description should mention minimums and maximums as well.

> > +
> > +     other fields
> > +         follow standard semantics
> > +
> > +   * Setting the source resolution will reset the selection rectangles=
 to their
> > +     default values, based on the new resolution, as described in the =
step 5
>
> 5 -> 4
>
> Or just say: "as described in the next step."
>

Good idea.

> > +     below.
> > +
> > +4. **Optional.** Set the visible resolution for the stream metadata vi=
a
> > +   :c:func:`VIDIOC_S_SELECTION` on the ``OUTPUT`` queue.
> > +
> > +   * **Required fields:**
> > +
> > +     ``type``
> > +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
> > +
> > +     ``target``
> > +         set to ``V4L2_SEL_TGT_CROP``
> > +
> > +     ``r.left``, ``r.top``, ``r.width``, ``r.height``
> > +         visible rectangle; this must fit within the `V4L2_SEL_TGT_CRO=
P_BOUNDS`
> > +         rectangle and may be subject to adjustment to match codec and
> > +         hardware constraints
> > +
> > +   * **Return fields:**
> > +
> > +     ``r.left``, ``r.top``, ``r.width``, ``r.height``
> > +         visible rectangle adjusted by the encoder
> > +
> > +   * The following selection targets are supported on ``OUTPUT``:
> > +
> > +     ``V4L2_SEL_TGT_CROP_BOUNDS``
> > +         equal to the full source frame, matching the active ``OUTPUT`=
`
> > +         format
> > +
> > +     ``V4L2_SEL_TGT_CROP_DEFAULT``
> > +         equal to ``V4L2_SEL_TGT_CROP_BOUNDS``
> > +
> > +     ``V4L2_SEL_TGT_CROP``
> > +         rectangle within the source buffer to be encoded into the
> > +         ``CAPTURE`` stream; defaults to ``V4L2_SEL_TGT_CROP_DEFAULT``
> > +
> > +         .. note::
> > +
> > +            A common use case for this selection target is encoding a =
source
> > +            video with a resolution that is not a multiple of a macrob=
lock,
> > +            e.g.  the common 1920x1080 resolution may require the sour=
ce
> > +            buffers to be aligned to 1920x1088 for codecs with 16x16 m=
acroblock
> > +            size. To avoid encoding the padding, the client needs to e=
xplicitly
> > +            configure this selection target to 1920x1080.
> > +
> > +     ``V4L2_SEL_TGT_COMPOSE_BOUNDS``
> > +         maximum rectangle within the coded resolution, which the crop=
ped
> > +         source frame can be composed into; if the hardware does not s=
upport
> > +         composition or scaling, then this is always equal to the rect=
angle of
> > +         width and height matching ``V4L2_SEL_TGT_CROP`` and located a=
t (0, 0)
> > +
> > +     ``V4L2_SEL_TGT_COMPOSE_DEFAULT``
> > +         equal to a rectangle of width and height matching
> > +         ``V4L2_SEL_TGT_CROP`` and located at (0, 0)
> > +
> > +     ``V4L2_SEL_TGT_COMPOSE``
> > +         rectangle within the coded frame, which the cropped source fr=
ame
> > +         is to be composed into; defaults to
> > +         ``V4L2_SEL_TGT_COMPOSE_DEFAULT``; read-only on hardware witho=
ut
> > +         additional compose/scaling capabilities; resulting stream wil=
l
> > +         have this rectangle encoded as the visible rectangle in its
> > +         metadata
> > +
> > +   .. warning::
> > +
> > +      The encoder may adjust the crop/compose rectangles to the neares=
t
> > +      supported ones to meet codec and hardware requirements. The clie=
nt needs
> > +      to check the adjusted rectangle returned by :c:func:`VIDIOC_S_SE=
LECTION`.
> > +
> > +5. Allocate buffers for both ``OUTPUT`` and ``CAPTURE`` via
> > +   :c:func:`VIDIOC_REQBUFS`. This may be performed in any order.
> > +
> > +   * **Required fields:**
> > +
> > +     ``count``
> > +         requested number of buffers to allocate; greater than zero
> > +
> > +     ``type``
> > +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT`` or
> > +         ``CAPTURE``
> > +
> > +     other fields
> > +         follow standard semantics
> > +
> > +   * **Return fields:**
> > +
> > +     ``count``
> > +          actual number of buffers allocated
> > +
> > +   .. warning::
> > +
> > +      The actual number of allocated buffers may differ from the ``cou=
nt``
> > +      given. The client must check the updated value of ``count`` afte=
r the
> > +      call returns.
> > +
> > +   .. note::
> > +
> > +      To allocate more than the minimum number of OUTPUT buffers (for =
pipeline
> > +      depth), the client may query the ``V4L2_CID_MIN_BUFFERS_FOR_OUTP=
UT``
> > +      control to get the minimum number of buffers required, and pass =
the
> > +      obtained value plus the number of additional buffers needed in t=
he
> > +      ``count`` field to :c:func:`VIDIOC_REQBUFS`.
> > +
> > +   Alternatively, :c:func:`VIDIOC_CREATE_BUFS` can be used to have mor=
e
> > +   control over buffer allocation.
> > +
> > +   * **Required fields:**
> > +
> > +     ``count``
> > +         requested number of buffers to allocate; greater than zero
> > +
> > +     ``type``
> > +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
> > +
> > +     other fields
> > +         follow standard semantics
> > +
> > +   * **Return fields:**
> > +
> > +     ``count``
> > +         adjusted to the number of allocated buffers
> > +
> > +6. Begin streaming on both ``OUTPUT`` and ``CAPTURE`` queues via
> > +   :c:func:`VIDIOC_STREAMON`. This may be performed in any order. The =
actual
> > +   encoding process starts when both queues start streaming.
> > +
> > +.. note::
> > +
> > +   If the client stops the ``CAPTURE`` queue during the encode process=
 and then
> > +   restarts it again, the encoder will begin generating a stream indep=
endent
> > +   from the stream generated before the stop. The exact constraints de=
pend
> > +   on the coded format, but may include the following implications:
> > +
> > +   * encoded frames produced after the restart must not reference any
> > +     frames produced before the stop, e.g. no long term references for
> > +     H.264,
> > +
> > +   * any headers that must be included in a standalone stream must be
> > +     produced again, e.g. SPS and PPS for H.264.
> > +
> > +Encoding
> > +=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +This state is reached after the `Initialization` sequence finishes
> > +successfully.  In this state, the client queues and dequeues buffers t=
o both
> > +queues via :c:func:`VIDIOC_QBUF` and :c:func:`VIDIOC_DQBUF`, following=
 the
> > +standard semantics.
> > +
> > +The contents of encoded ``CAPTURE`` buffers depend on the active coded=
 pixel
> > +format and may be affected by codec-specific extended controls, as sta=
ted
> > +in the documentation of each format.
> > +
> > +Both queues operate independently, following standard behavior of V4L2=
 buffer
> > +queues and memory-to-memory devices. In addition, the order of encoded=
 frames
> > +dequeued from the ``CAPTURE`` queue may differ from the order of queui=
ng raw
> > +frames to the ``OUTPUT`` queue, due to properties of the selected code=
d format,
> > +e.g. frame reordering.
> > +
> > +The client must not assume any direct relationship between ``CAPTURE``=
 and
> > +``OUTPUT`` buffers and any specific timing of buffers becoming
> > +available to dequeue. Specifically:
> > +
> > +* a buffer queued to ``OUTPUT`` may result in more than 1 buffer produ=
ced on
> > +  ``CAPTURE`` (if returning an encoded frame allowed the encoder to re=
turn a
> > +  frame that preceded it in display, but succeeded it in the decode or=
der),
> > +
> > +* a buffer queued to ``OUTPUT`` may result in a buffer being produced =
on
> > +  ``CAPTURE`` later into encode process, and/or after processing furth=
er
> > +  ``OUTPUT`` buffers, or be returned out of order, e.g. if display
> > +  reordering is used,
> > +
> > +* buffers may become available on the ``CAPTURE`` queue without additi=
onal
> > +  buffers queued to ``OUTPUT`` (e.g. during drain or ``EOS``), because=
 of the
> > +  ``OUTPUT`` buffers queued in the past whose decoding results are onl=
y
> > +  available at later time, due to specifics of the decoding process,
> > +
> > +* buffers queued to ``OUTPUT`` may not become available to dequeue ins=
tantly
> > +  after being encoded into a corresponding ``CATPURE`` buffer, e.g. if=
 the
> > +  encoder needs to use the frame as a reference for encoding further f=
rames.
> > +
> > +.. note::
> > +
> > +   To allow matching encoded ``CAPTURE`` buffers with ``OUTPUT`` buffe=
rs they
> > +   originated from, the client can set the ``timestamp`` field of the
> > +   :c:type:`v4l2_buffer` struct when queuing an ``OUTPUT`` buffer. The
> > +   ``CAPTURE`` buffer(s), which resulted from encoding that ``OUTPUT``=
 buffer
> > +   will have their ``timestamp`` field set to the same value when dequ=
eued.
> > +
> > +   In addition to the straightforward case of one ``OUTPUT`` buffer pr=
oducing
> > +   one ``CAPTURE`` buffer, the following cases are defined:
> > +
> > +   * one ``OUTPUT`` buffer generates multiple ``CAPTURE`` buffers: the=
 same
> > +     ``OUTPUT`` timestamp will be copied to multiple ``CAPTURE`` buffe=
rs,
> > +
> > +   * the encoding order differs from the presentation order (i.e. the
> > +     ``CAPTURE`` buffers are out-of-order compared to the ``OUTPUT`` b=
uffers):
> > +     ``CAPTURE`` timestamps will not retain the order of ``OUTPUT`` ti=
mestamps
> > +     and thus monotonicity of the timestamps cannot be guaranteed.
>
> Drop "and thus monotonicity of the timestamps cannot be guaranteed": this=
 was never
> guaranteed since timestamps are just copied from OUTPUT to CAPTURE.
>
> This phrase doesn't occur in the decoder spec, so it should be removed he=
re as well.
>

Indeed. I think I forgot to remove it from here.

> > +
> > +.. note::
> > +
> > +   To let the client distinguish between frame types (keyframes, inter=
mediate
> > +   frames; the exact list of types depends on the coded format), the
> > +   ``CAPTURE`` buffers will have corresponding flag bits set in their
> > +   :c:type:`v4l2_buffer` struct when dequeued. See the documentation o=
f
> > +   :c:type:`v4l2_buffer` and each coded pixel format for exact list of=
 flags
> > +   and their meanings.
> > +
> > +Encoding parameter changes
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > +
> > +The client is allowed to use :c:func:`VIDIOC_S_CTRL` to change encoder
> > +parameters at any time. The availability of parameters is encoder-spec=
ific
> > +and the client must query the encoder to find the set of available con=
trols.
> > +
> > +The ability to change each parameter during encoding is encoder-specif=
ic, as
> > +per the standard semantics of the V4L2 control interface. The client m=
ay
> > +attempt to set a control during encoding and if the operation fails wi=
th the
> > +-EBUSY error code, the ``CAPTURE`` queue needs to be stopped for the
> > +configuration change to be allowed. To do this, it may follow the `Dra=
in`
> > +sequence to avoid losing the already queued/encoded frames.
> > +
> > +The timing of parameter updates is encoder-specific, as per the standa=
rd
> > +semantics of the V4L2 control interface. If the client needs to apply =
the
> > +parameters exactly at specific frame, using the Request API
> > +(:ref:`media-request-api`) should be considered, if supported by the e=
ncoder.
> > +
> > +Drain
> > +=3D=3D=3D=3D=3D
> > +
> > +To ensure that all the queued ``OUTPUT`` buffers have been processed a=
nd the
> > +related ``CAPTURE`` buffers are given to the client, the client must f=
ollow the
> > +drain sequence described below. After the drain sequence ends, the cli=
ent has
> > +received all encoded frames for all ``OUTPUT`` buffers queued before t=
he
> > +sequence was started.
> > +
> > +1. Begin the drain sequence by issuing :c:func:`VIDIOC_ENCODER_CMD`.
> > +
> > +   * **Required fields:**
> > +
> > +     ``cmd``
> > +         set to ``V4L2_ENC_CMD_STOP``
> > +
> > +     ``flags``
> > +         set to 0
> > +
> > +     ``pts``
> > +         set to 0
> > +
> > +   .. warning::
> > +
> > +      The sequence can be only initiated if both ``OUTPUT`` and ``CAPT=
URE``
> > +      queues are streaming. For compatibility reasons, the call to
> > +      :c:func:`VIDIOC_ENCODER_CMD` will not fail even if any of the qu=
eues is
> > +      not streaming, but at the same time it will not initiate the `Dr=
ain`
> > +      sequence and so the steps described below would not be applicabl=
e.
> > +
> > +2. Any ``OUTPUT`` buffers queued by the client before the
> > +   :c:func:`VIDIOC_ENCODER_CMD` was issued will be processed and encod=
ed as
> > +   normal. The client must continue to handle both queues independentl=
y,
> > +   similarly to normal encode operation. This includes:
> > +
> > +   * queuing and dequeuing ``CAPTURE`` buffers, until a buffer marked =
with the
> > +     ``V4L2_BUF_FLAG_LAST`` flag is dequeued,
> > +
> > +     .. warning::
> > +
> > +        The last buffer may be empty (with :c:type:`v4l2_buffer`
> > +        ``bytesused`` =3D 0) and in that case it must be ignored by th=
e client,
> > +        as it does not contain an encoded frame.
> > +
> > +     .. note::
> > +
> > +        Any attempt to dequeue more buffers beyond the buffer marked w=
ith
> > +        ``V4L2_BUF_FLAG_LAST`` will result in a -EPIPE error from
> > +        :c:func:`VIDIOC_DQBUF`.
> > +
> > +   * dequeuing processed ``OUTPUT`` buffers, until all the buffers que=
ued
> > +     before the ``V4L2_ENC_CMD_STOP`` command are dequeued,
> > +
> > +   * dequeuing the ``V4L2_EVENT_EOS`` event, if the client subscribes =
to it.
> > +
> > +   .. note::
> > +
> > +      For backwards compatibility, the encoder will signal a ``V4L2_EV=
ENT_EOS``
> > +      event when the last frame has been decoded and all frames are re=
ady to be
> > +      dequeued. It is deprecated behavior and the client must not rely=
 on it.
> > +      The ``V4L2_BUF_FLAG_LAST`` buffer flag should be used instead.
> > +
> > +3. Once all ``OUTPUT`` buffers queued before the ``V4L2_ENC_CMD_STOP``=
 call are
> > +   dequeued and the last ``CAPTURE`` buffer is dequeued, the encoder i=
s stopped
> > +   and it will accept, but not process any newly queued ``OUTPUT`` buf=
fers
> > +   until the client issues any of the following operations:
> > +
> > +   * ``V4L2_ENC_CMD_START`` - the encoder will not be reset and will r=
esume
> > +     operation normally, with all the state from before the drain,
> > +
> > +   * a pair of :c:func:`VIDIOC_STREAMOFF` and :c:func:`VIDIOC_STREAMON=
` on the
> > +     ``CAPTURE`` queue - the encoder will be reset (see the `Reset` se=
quence)
> > +     and then resume encoding,
> > +
> > +   * a pair of :c:func:`VIDIOC_STREAMOFF` and :c:func:`VIDIOC_STREAMON=
` on the
> > +     ``OUTPUT`` queue - the encoder will resume operation normally, ho=
wever any
> > +     source frames queued to the ``OUTPUT`` queue between ``V4L2_ENC_C=
MD_STOP``
> > +     and :c:func:`VIDIOC_STREAMOFF` will be discarded.
> > +
> > +.. note::
> > +
> > +   Once the drain sequence is initiated, the client needs to drive it =
to
> > +   completion, as described by the steps above, unless it aborts the p=
rocess by
> > +   issuing :c:func:`VIDIOC_STREAMOFF` on any of the ``OUTPUT`` or ``CA=
PTURE``
> > +   queues.  The client is not allowed to issue ``V4L2_ENC_CMD_START`` =
or
> > +   ``V4L2_ENC_CMD_STOP`` again while the drain sequence is in progress=
 and they
> > +   will fail with -EBUSY error code if attempted.
> > +
> > +   Although mandatory, the availability of encoder commands may be que=
ried
> > +   using :c:func:`VIDIOC_TRY_ENCODER_CMD`.
> > +
> > +Reset
> > +=3D=3D=3D=3D=3D
> > +
> > +The client may want to request the encoder to reinitialize the encodin=
g, so
> > +that the following stream data becomes independent from the stream dat=
a
> > +generated before. Depending on the coded format, that may imply that:
> > +
> > +* encoded frames produced after the restart must not reference any fra=
mes
> > +  produced before the stop, e.g. no long term references for H.264,
> > +
> > +* any headers that must be included in a standalone stream must be pro=
duced
> > +  again, e.g. SPS and PPS for H.264.
> > +
> > +This can be achieved by performing the reset sequence.
> > +
> > +1. Perform the `Drain` sequence to ensure all the in-flight encoding f=
inishes
> > +   and respective buffers are dequeued.
> > +
> > +2. Stop streaming on the ``CAPTURE`` queue via :c:func:`VIDIOC_STREAMO=
FF`. This
> > +   will return all currently queued ``CAPTURE`` buffers to the client,=
 without
> > +   valid frame data.
> > +
> > +3. Start streaming on the ``CAPTURE`` queue via :c:func:`VIDIOC_STREAM=
ON` and
> > +   continue with regular encoding sequence. The encoded frames produce=
d into
> > +   ``CAPTURE`` buffers from now on will contain a standalone stream th=
at can be
> > +   decoded without the need for frames encoded before the reset sequen=
ce,
> > +   starting at the first ``OUTPUT`` buffer queued after issuing the
> > +   `V4L2_ENC_CMD_STOP` of the `Drain` sequence.
> > +
> > +This sequence may be also used to change encoding parameters for encod=
ers
> > +without the ability to change the parameters on the fly.
> > +
> > +Commit points
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Setting formats and allocating buffers triggers changes in the behavio=
r of the
> > +encoder.
> > +
> > +1. Setting the format on the ``CAPTURE`` queue may change the set of f=
ormats
> > +   supported/advertised on the ``OUTPUT`` queue. In particular, it als=
o means
> > +   that the ``OUTPUT`` format may be reset and the client must not rel=
y on the
> > +   previously set format being preserved.
> > +
> > +2. Enumerating formats on the ``OUTPUT`` queue always returns only for=
mats
> > +   supported for the current ``CAPTURE`` format.
> > +
> > +3. Setting the format on the ``OUTPUT`` queue does not change the list=
 of
> > +   formats available on the ``CAPTURE`` queue. An attempt to set the `=
`OUTPUT``
> > +   format that is not supported for the currently selected ``CAPTURE``=
 format
> > +   will result in the encoder adjusting the requested ``OUTPUT`` forma=
t to a
> > +   supported one.
> > +
> > +4. Enumerating formats on the ``CAPTURE`` queue always returns the ful=
l set of
> > +   supported coded formats, irrespectively of the current ``OUTPUT`` f=
ormat.
>
> irrespectively -> irrespective
>

Ack.

Best regards,
Tomasz
