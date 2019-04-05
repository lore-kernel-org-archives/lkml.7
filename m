Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47A7C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FBD62175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A7mvd+sg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbfDEIMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 04:12:42 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43751 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfDEIMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 04:12:39 -0400
Received: by mail-ot1-f67.google.com with SMTP id u15so4836563otq.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 01:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=esYZCw2IZI8AdN49gB89NsQpjVsdqyO6b4pg2MuT9N0=;
        b=A7mvd+sguCPUUraxYbNLl1SlMFxXkU96cfecTItRkgAVnMCdjsmwfArj5wdKLi4hwE
         +A7Ftc4dggc/xmJxGRpP/MEaZw2wZZ6iFI4yswdStdeU/SULSwaXPBhKEcbdSIpn0jGB
         XL2i8lFiIqI2RwUKZKOAiLUHan1xFvcK4x4o8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=esYZCw2IZI8AdN49gB89NsQpjVsdqyO6b4pg2MuT9N0=;
        b=AOzdXzlMiYNvkwzWbavVtX67XcddeUChesv8qQo+gsA2j2fPDn0fnoUL3nY/GGNxEY
         qGhwVWcQl/dYQ2UA7BGOyVStQ8x2vaZjKbAjjKevkbeKKoNGl4sVeYqQRcJ8gETBl4YP
         4bTRHW6yickOKjw7J2eJacwOqpuqjDpncp6mKdFKDHBYnuXhjDP2GPX+epjXYLVe51H/
         mgJxL7xXIkVfB+UspTfD4ohtzzVnm0ocdS3YeANrf1Msxs9sOC33jRqbgwhTWiLXY4jt
         TBLNqd3WwCQF2QDCBq8Lv3cS3mVguaFmU2Yktufg0om7cx8AES+Z7EA586cZWhR0AxTC
         piWQ==
X-Gm-Message-State: APjAAAVm8eCO7OGAWTWNNEft55aVHgu+cxCmbDdqKLzv+lQlMQQvpTrG
        yg4eptFzxyJkcMkl1Td3GEaSLukoWh0=
X-Google-Smtp-Source: APXvYqwaErqo0w0Alyhh5bMvd9/h8z1Q2JLNl+0JhjZq1z9BtBRSWT81ZPvcYIhv/OBApcfl7chc5A==
X-Received: by 2002:a9d:7411:: with SMTP id n17mr7923459otk.205.1554451955777;
        Fri, 05 Apr 2019 01:12:35 -0700 (PDT)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com. [209.85.167.178])
        by smtp.gmail.com with ESMTPSA id j1sm6146970otl.43.2019.04.05.01.12.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 01:12:34 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id v10so4192772oib.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 01:12:33 -0700 (PDT)
X-Received: by 2002:aca:a894:: with SMTP id r142mr6320192oie.112.1554451952801;
 Fri, 05 Apr 2019 01:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190124100419.26492-1-tfiga@chromium.org> <20190124100419.26492-3-tfiga@chromium.org>
 <4bbe4ce4-615a-b981-0855-cd78c7a002d9@xs4all.nl> <471720b7-e304-271b-256d-a3dd394773c9@xs4all.nl>
In-Reply-To: <471720b7-e304-271b-256d-a3dd394773c9@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 5 Apr 2019 17:12:21 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Au_=08pVom1z3C1nHKdKak8Y4d5odR6fiNB4urDhfjKQ@mail.gmail.com>
Message-ID: <CAAFQd5Au_=08pVom1z3C1nHKdKak8Y4d5odR6fiNB4urDhfjKQ@mail.gmail.com>
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

On Thu, Mar 14, 2019 at 10:57 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> Hi Tomasz,
>
> Some more comments...
>
> On 1/29/19 2:52 PM, Hans Verkuil wrote:
> > Hi Tomasz,
> >
> > Some comments below. Nothing major, so I think a v4 should be ready to =
be
> > merged.
> >
> > On 1/24/19 11:04 AM, Tomasz Figa wrote:
> >> Due to complexity of the video encoding process, the V4L2 drivers of
> >> stateful encoder hardware require specific sequences of V4L2 API calls
> >> to be followed. These include capability enumeration, initialization,
> >> encoding, encode parameters change, drain and reset.
> >>
> >> Specifics of the above have been discussed during Media Workshops at
> >> LinuxCon Europe 2012 in Barcelona and then later Embedded Linux
> >> Conference Europe 2014 in D=C3=BCsseldorf. The de facto Codec API that
> >> originated at those events was later implemented by the drivers we alr=
eady
> >> have merged in mainline, such as s5p-mfc or coda.
> >>
> >> The only thing missing was the real specification included as a part o=
f
> >> Linux Media documentation. Fix it now and document the encoder part of
> >> the Codec API.
> >>
> >> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> >> ---
> >>  Documentation/media/uapi/v4l/dev-encoder.rst  | 586 +++++++++++++++++=
+
> >>  Documentation/media/uapi/v4l/dev-mem2mem.rst  |   1 +
> >>  Documentation/media/uapi/v4l/pixfmt-v4l2.rst  |   5 +
> >>  Documentation/media/uapi/v4l/v4l2.rst         |   2 +
> >>  .../media/uapi/v4l/vidioc-encoder-cmd.rst     |  38 +-
> >>  5 files changed, 617 insertions(+), 15 deletions(-)
> >>  create mode 100644 Documentation/media/uapi/v4l/dev-encoder.rst
> >>
> >> diff --git a/Documentation/media/uapi/v4l/dev-encoder.rst b/Documentat=
ion/media/uapi/v4l/dev-encoder.rst
> >> new file mode 100644
> >> index 000000000000..fb8b05a132ee
> >> --- /dev/null
> >> +++ b/Documentation/media/uapi/v4l/dev-encoder.rst
> >> @@ -0,0 +1,586 @@
> >> +.. -*- coding: utf-8; mode: rst -*-
> >> +
> >> +.. _encoder:
> >> +
> >> +*************************************************
> >> +Memory-to-memory Stateful Video Encoder Interface
> >> +*************************************************
> >> +
> >> +A stateful video encoder takes raw video frames in display order and =
encodes
> >> +them into a bitstream. It generates complete chunks of the bitstream,=
 including
> >> +all metadata, headers, etc. The resulting bitstream does not require =
any
> >> +further post-processing by the client.
> >> +
> >> +Performing software stream processing, header generation etc. in the =
driver
> >> +in order to support this interface is strongly discouraged. In case s=
uch
> >> +operations are needed, use of the Stateless Video Encoder Interface (=
in
> >> +development) is strongly advised.
> >> +
> >> +Conventions and notation used in this document
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +1. The general V4L2 API rules apply if not specified in this document
> >> +   otherwise.
> >> +
> >> +2. The meaning of words "must", "may", "should", etc. is as per `RFC
> >> +   2119 <https://tools.ietf.org/html/rfc2119>`_.
> >> +
> >> +3. All steps not marked "optional" are required.
> >> +
> >> +4. :c:func:`VIDIOC_G_EXT_CTRLS` and :c:func:`VIDIOC_S_EXT_CTRLS` may =
be used
> >> +   interchangeably with :c:func:`VIDIOC_G_CTRL` and :c:func:`VIDIOC_S=
_CTRL`,
> >> +   unless specified otherwise.
> >> +
> >> +5. Single-planar API (see :ref:`planar-apis`) and applicable structur=
es may be
> >> +   used interchangeably with multi-planar API, unless specified other=
wise,
> >> +   depending on decoder capabilities and following the general V4L2 g=
uidelines.
> >> +
> >> +6. i =3D [a..b]: sequence of integers from a to b, inclusive, i.e. i =
=3D
> >> +   [0..2]: i =3D 0, 1, 2.
> >> +
> >> +7. Given an ``OUTPUT`` buffer A, then A=E2=80=99 represents a buffer =
on the ``CAPTURE``
> >> +   queue containing data that resulted from processing buffer A.
> >> +
> >> +Glossary
> >> +=3D=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +Refer to :ref:`decoder-glossary`.
> >> +
> >> +State machine
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +.. kernel-render:: DOT
> >> +   :alt: DOT digraph of encoder state machine
> >> +   :caption: Encoder state machine
> >> +
> >> +   digraph encoder_state_machine {
> >> +       node [shape =3D doublecircle, label=3D"Encoding"] Encoding;
> >> +
> >> +       node [shape =3D circle, label=3D"Initialization"] Initializati=
on;
> >> +       node [shape =3D circle, label=3D"Stopped"] Stopped;
> >> +       node [shape =3D circle, label=3D"Drain"] Drain;
> >> +       node [shape =3D circle, label=3D"Reset"] Reset;
> >> +
> >> +       node [shape =3D point]; qi
> >> +       qi -> Initialization [ label =3D "open()" ];
> >> +
> >> +       Initialization -> Encoding [ label =3D "Both queues streaming"=
 ];
> >> +
> >> +       Encoding -> Drain [ label =3D "V4L2_DEC_CMD_STOP" ];
> >> +       Encoding -> Reset [ label =3D "VIDIOC_STREAMOFF(CAPTURE)" ];
> >> +       Encoding -> Stopped [ label =3D "VIDIOC_STREAMOFF(OUTPUT)" ];
> >> +       Encoding -> Encoding;
> >> +
> >> +       Drain -> Stopped [ label =3D "All CAPTURE\nbuffers dequeued\no=
r\nVIDIOC_STREAMOFF(CAPTURE)" ];
> >> +       Drain -> Reset [ label =3D "VIDIOC_STREAMOFF(CAPTURE)" ];
> >> +
> >> +       Reset -> Encoding [ label =3D "VIDIOC_STREAMON(CAPTURE)" ];
> >> +       Reset -> Initialization [ label =3D "VIDIOC_REQBUFS(OUTPUT, 0)=
" ];
> >> +
> >> +       Stopped -> Encoding [ label =3D "V4L2_DEC_CMD_START\nor\nVIDIO=
C_STREAMON(OUTPUT)" ];
> >> +       Stopped -> Reset [ label =3D "VIDIOC_STREAMOFF(CAPTURE)" ];
> >> +   }
> >> +
> >> +Querying capabilities
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +1. To enumerate the set of coded formats supported by the encoder, th=
e
> >> +   client may call :c:func:`VIDIOC_ENUM_FMT` on ``CAPTURE``.
> >> +
> >> +   * The full set of supported formats will be returned, regardless o=
f the
> >> +     format set on ``OUTPUT``.
> >> +
> >> +2. To enumerate the set of supported raw formats, the client may call
> >> +   :c:func:`VIDIOC_ENUM_FMT` on ``OUTPUT``.
> >> +
> >> +   * Only the formats supported for the format currently active on ``=
CAPTURE``
> >> +     will be returned.
> >> +
> >> +   * In order to enumerate raw formats supported by a given coded for=
mat,
> >> +     the client must first set that coded format on ``CAPTURE`` and t=
hen
> >> +     enumerate the formats on ``OUTPUT``.
> >> +
> >> +3. The client may use :c:func:`VIDIOC_ENUM_FRAMESIZES` to detect supp=
orted
> >> +   resolutions for a given format, passing desired pixel format in
> >> +   :c:type:`v4l2_frmsizeenum` ``pixel_format``.
> >> +
> >> +   * Values returned by :c:func:`VIDIOC_ENUM_FRAMESIZES` for a coded =
pixel
> >> +     format will include all possible coded resolutions supported by =
the
> >> +     encoder for given coded pixel format.
> >> +
> >> +   * Values returned by :c:func:`VIDIOC_ENUM_FRAMESIZES` for a raw pi=
xel format
> >> +     will include all possible frame buffer resolutions supported by =
the
> >> +     encoder for given raw pixel format and coded format currently se=
t on
> >> +     ``CAPTURE``.
> >> +
> >> +4. Supported profiles and levels for the coded format currently set o=
n
> >> +   ``CAPTURE``, if applicable, may be queried using their respective =
controls
> >> +   via :c:func:`VIDIOC_QUERYCTRL`.
> >> +
> >> +5. Any additional encoder capabilities may be discovered by querying
> >> +   their respective controls.
> >> +
> >> +Initialization
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +1. Set the coded format on the ``CAPTURE`` queue via :c:func:`VIDIOC_=
S_FMT`
> >> +
> >> +   * **Required fields:**
> >> +
> >> +     ``type``
> >> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``CAPTURE``
> >> +
> >> +     ``pixelformat``
> >> +         the coded format to be produced
> >> +
> >> +     ``sizeimage``
> >> +         desired size of ``CAPTURE`` buffers; the encoder may adjust =
it to
> >> +         match hardware requirements
> >> +
> >> +     ``width``, ``height``
> >> +         ignored (always zero)
> >> +
> >> +     other fields
> >> +         follow standard semantics
> >> +
> >> +   * **Return fields:**
> >> +
> >> +     ``sizeimage``
> >> +         adjusted size of ``CAPTURE`` buffers
> >> +
> >> +   .. important::
> >> +
> >> +      Changing the ``CAPTURE`` format may change the currently set ``=
OUTPUT``
> >> +      format. The encoder will derive a new ``OUTPUT`` format from th=
e
> >> +      ``CAPTURE`` format being set, including resolution, colorimetry
> >> +      parameters, etc. If the client needs a specific ``OUTPUT`` form=
at, it
> >> +      must adjust it afterwards.
> >
> > Hmm, "including resolution": if width and height are set to 0, what sho=
uld the
> > OUTPUT resolution be? Up to the driver? I think this should be clarifie=
d since
> > at a first reading of this paragraph it appears to be contradictory.
>
> I think the driver should just return the width and height of the OUTPUT
> format. So the width and height that userspace specifies is just ignored
> and replaced by the width and height of the OUTPUT format. After all, tha=
t's
> what the bitstream will encode. Returning 0 for width and height would ma=
ke
> this a strange exception in V4L2 and I want to avoid that.
>

Hmm, however, the width and height of the OUTPUT format is not what's
actually encoded in the bitstream. The right selection rectangle
determines that.

In one of the previous versions I though we could put the codec
resolution as the width and height of the CAPTURE format, which would
be the resolution of the encoded image rounded up to full macroblocks
+/- some encoder-specific constraints. AFAIR there was some concern
about OUTPUT format changes triggering CAPTURE format changes, but to
be honest, I'm not sure if that's really a problem. I just decided to
drop that for the simplicity.

> >
> >> +
> >> +2. **Optional.** Enumerate supported ``OUTPUT`` formats (raw formats =
for
> >> +   source) for the selected coded format via :c:func:`VIDIOC_ENUM_FMT=
`.
> >> +
> >> +   * **Required fields:**
> >> +
> >> +     ``type``
> >> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
> >> +
> >> +     other fields
> >> +         follow standard semantics
> >> +
> >> +   * **Return fields:**
> >> +
> >> +     ``pixelformat``
> >> +         raw format supported for the coded format currently selected=
 on
> >> +         the ``CAPTURE`` queue.
> >> +
> >> +     other fields
> >> +         follow standard semantics
> >> +
> >> +3. Set the raw source format on the ``OUTPUT`` queue via
> >> +   :c:func:`VIDIOC_S_FMT`.
> >> +
> >> +   * **Required fields:**
> >> +
> >> +     ``type``
> >> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
> >> +
> >> +     ``pixelformat``
> >> +         raw format of the source
> >> +
> >> +     ``width``, ``height``
> >> +         source resolution
> >> +
> >> +     other fields
> >> +         follow standard semantics
> >> +
> >> +   * **Return fields:**
> >> +
> >> +     ``width``, ``height``
> >> +         may be adjusted by encoder to match alignment requirements, =
as
> >> +         required by the currently selected formats
> >
> > What if the width x height is larger than the maximum supported by the
> > selected coded format? This should probably mention that in that case t=
he
> > width x height is reduced to the largest allowed value. Also mention th=
at
> > this maximum is reported by VIDIOC_ENUM_FRAMESIZES.
> >
> >> +
> >> +     other fields
> >> +         follow standard semantics
> >> +
> >> +   * Setting the source resolution will reset the selection rectangle=
s to their
> >> +     default values, based on the new resolution, as described in the=
 step 5
> >
> > 5 -> 4
> >
> > Or just say: "as described in the next step."
> >
> >> +     below.
>
> It should also be made explicit that:
>
> 1) the crop rectangle will be set to the given width and height *before*
> it is being adjusted by S_FMT.
>

I don't think that's what we want here.

Defining the default rectangle to be exactly the same as the OUTPUT
resolution (after the adjustment) makes the semantics consistent - not
setting the crop rectangle gives you exactly the behavior as if there
was no cropping involved (or supported by the encoder).

> Open question: should we support a compose rectangle for the CAPTURE that
> is the same as the OUTPUT crop rectangle? I.e. the CAPTURE format contain=
s
> the adjusted width and height and the compose rectangle (read-only) conta=
ins
> the visible width and height. It's not strictly necessary, but it is
> symmetrical.

Wouldn't it rather be the CAPTURE crop rectangle that would be of the
same resolution of the OUTPUT compose rectangle? Then you could
actually have the CAPTURE compose rectangle for putting that into the
desired rectangle of the encoded stream, if the encoder supports that.
(I don't know any that does, so probably out of concern for now.)

>
> 2) the CAPTURE format will be updated as well with the new OUTPUT width a=
nd
> height. The CAPTURE sizeimage might change as well.
>
> >> +
> >> +4. **Optional.** Set the visible resolution for the stream metadata v=
ia
> >> +   :c:func:`VIDIOC_S_SELECTION` on the ``OUTPUT`` queue.
>
> I think you should mention that this is only necessary if the crop rectan=
gle
> that is set when you set the format isn't what you want.
>

Ack.

> >> +
> >> +   * **Required fields:**
> >> +
> >> +     ``type``
> >> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
> >> +
> >> +     ``target``
> >> +         set to ``V4L2_SEL_TGT_CROP``
> >> +
> >> +     ``r.left``, ``r.top``, ``r.width``, ``r.height``
> >> +         visible rectangle; this must fit within the `V4L2_SEL_TGT_CR=
OP_BOUNDS`
> >> +         rectangle and may be subject to adjustment to match codec an=
d
> >> +         hardware constraints
> >> +
> >> +   * **Return fields:**
> >> +
> >> +     ``r.left``, ``r.top``, ``r.width``, ``r.height``
> >> +         visible rectangle adjusted by the encoder
> >> +
> >> +   * The following selection targets are supported on ``OUTPUT``:
> >> +
> >> +     ``V4L2_SEL_TGT_CROP_BOUNDS``
> >> +         equal to the full source frame, matching the active ``OUTPUT=
``
> >> +         format
> >> +
> >> +     ``V4L2_SEL_TGT_CROP_DEFAULT``
> >> +         equal to ``V4L2_SEL_TGT_CROP_BOUNDS``
> >> +
> >> +     ``V4L2_SEL_TGT_CROP``
> >> +         rectangle within the source buffer to be encoded into the
> >> +         ``CAPTURE`` stream; defaults to ``V4L2_SEL_TGT_CROP_DEFAULT`=
`
> >> +
> >> +         .. note::
> >> +
> >> +            A common use case for this selection target is encoding a=
 source
> >> +            video with a resolution that is not a multiple of a macro=
block,
> >> +            e.g.  the common 1920x1080 resolution may require the sou=
rce
> >> +            buffers to be aligned to 1920x1088 for codecs with 16x16 =
macroblock
> >> +            size. To avoid encoding the padding, the client needs to =
explicitly
> >> +            configure this selection target to 1920x1080.
>
> This last sentence contradicts the proposed behavior of S_FMT(OUTPUT).
>

Sorry, which part exactly and what part of the proposal exactly? :)
(My comment above might be related, though.)

> >> +
> >> +     ``V4L2_SEL_TGT_COMPOSE_BOUNDS``
> >> +         maximum rectangle within the coded resolution, which the cro=
pped
> >> +         source frame can be composed into; if the hardware does not =
support
> >> +         composition or scaling, then this is always equal to the rec=
tangle of
> >> +         width and height matching ``V4L2_SEL_TGT_CROP`` and located =
at (0, 0)
> >> +
> >> +     ``V4L2_SEL_TGT_COMPOSE_DEFAULT``
> >> +         equal to a rectangle of width and height matching
> >> +         ``V4L2_SEL_TGT_CROP`` and located at (0, 0)
> >> +
> >> +     ``V4L2_SEL_TGT_COMPOSE``
> >> +         rectangle within the coded frame, which the cropped source f=
rame
> >> +         is to be composed into; defaults to
> >> +         ``V4L2_SEL_TGT_COMPOSE_DEFAULT``; read-only on hardware with=
out
> >> +         additional compose/scaling capabilities; resulting stream wi=
ll
> >> +         have this rectangle encoded as the visible rectangle in its
> >> +         metadata
>
> I think the compose targets for OUTPUT are only needed if the hardware ca=
n
> actually do scaling and/or composition. Otherwise they can (must?) be
> dropped.
>

Note that V4L2_SEL_TGT_COMPOSE is defined to be the way for the
userspace to learn the target visible rectangle that's going to be
encoded in the stream metadata. If we omit it, we wouldn't have a way
that would be consistent between encoders that can do
scaling/composition and those that can't.

However, with your proposal of actually having selection rectangles
for the CAPTURE queue, it could be solved indeed. The OUTPUT queue
would expose a varying set of rectangles, depending on the hardware
capability, while the CAPTURE queue would always expose its rectangle
with that information.

> >> +
> >> +   .. warning::
> >> +
> >> +      The encoder may adjust the crop/compose rectangles to the neare=
st
> >> +      supported ones to meet codec and hardware requirements. The cli=
ent needs
> >> +      to check the adjusted rectangle returned by :c:func:`VIDIOC_S_S=
ELECTION`.
> >> +
> >> +5. Allocate buffers for both ``OUTPUT`` and ``CAPTURE`` via
> >> +   :c:func:`VIDIOC_REQBUFS`. This may be performed in any order.
> >> +
> >> +   * **Required fields:**
> >> +
> >> +     ``count``
> >> +         requested number of buffers to allocate; greater than zero
> >> +
> >> +     ``type``
> >> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT`` or
> >> +         ``CAPTURE``
> >> +
> >> +     other fields
> >> +         follow standard semantics
> >> +
> >> +   * **Return fields:**
> >> +
> >> +     ``count``
> >> +          actual number of buffers allocated
> >> +
> >> +   .. warning::
> >> +
> >> +      The actual number of allocated buffers may differ from the ``co=
unt``
> >> +      given. The client must check the updated value of ``count`` aft=
er the
> >> +      call returns.
> >> +
> >> +   .. note::
> >> +
> >> +      To allocate more than the minimum number of OUTPUT buffers (for=
 pipeline
> >> +      depth), the client may query the ``V4L2_CID_MIN_BUFFERS_FOR_OUT=
PUT``
> >> +      control to get the minimum number of buffers required, and pass=
 the
> >> +      obtained value plus the number of additional buffers needed in =
the
> >> +      ``count`` field to :c:func:`VIDIOC_REQBUFS`.
> >> +
> >> +   Alternatively, :c:func:`VIDIOC_CREATE_BUFS` can be used to have mo=
re
> >> +   control over buffer allocation.
> >> +
> >> +   * **Required fields:**
> >> +
> >> +     ``count``
> >> +         requested number of buffers to allocate; greater than zero
> >> +
> >> +     ``type``
> >> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
> >> +
> >> +     other fields
> >> +         follow standard semantics
> >> +
> >> +   * **Return fields:**
> >> +
> >> +     ``count``
> >> +         adjusted to the number of allocated buffers
> >> +
> >> +6. Begin streaming on both ``OUTPUT`` and ``CAPTURE`` queues via
> >> +   :c:func:`VIDIOC_STREAMON`. This may be performed in any order. The=
 actual
> >> +   encoding process starts when both queues start streaming.
> >> +
> >> +.. note::
> >> +
> >> +   If the client stops the ``CAPTURE`` queue during the encode proces=
s and then
> >> +   restarts it again, the encoder will begin generating a stream inde=
pendent
> >> +   from the stream generated before the stop. The exact constraints d=
epend
> >> +   on the coded format, but may include the following implications:
> >> +
> >> +   * encoded frames produced after the restart must not reference any
> >> +     frames produced before the stop, e.g. no long term references fo=
r
> >> +     H.264,
> >> +
> >> +   * any headers that must be included in a standalone stream must be
> >> +     produced again, e.g. SPS and PPS for H.264.
> >> +
> >> +Encoding
> >> +=3D=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +This state is reached after the `Initialization` sequence finishes
> >> +successfully.  In this state, the client queues and dequeues buffers =
to both
> >> +queues via :c:func:`VIDIOC_QBUF` and :c:func:`VIDIOC_DQBUF`, followin=
g the
> >> +standard semantics.
> >> +
> >> +The contents of encoded ``CAPTURE`` buffers depend on the active code=
d pixel
> >> +format and may be affected by codec-specific extended controls, as st=
ated
> >> +in the documentation of each format.
> >> +
> >> +Both queues operate independently, following standard behavior of V4L=
2 buffer
> >> +queues and memory-to-memory devices. In addition, the order of encode=
d frames
> >> +dequeued from the ``CAPTURE`` queue may differ from the order of queu=
ing raw
> >> +frames to the ``OUTPUT`` queue, due to properties of the selected cod=
ed format,
> >> +e.g. frame reordering.
> >> +
> >> +The client must not assume any direct relationship between ``CAPTURE`=
` and
> >> +``OUTPUT`` buffers and any specific timing of buffers becoming
> >> +available to dequeue. Specifically:
> >> +
> >> +* a buffer queued to ``OUTPUT`` may result in more than 1 buffer prod=
uced on
> >> +  ``CAPTURE`` (if returning an encoded frame allowed the encoder to r=
eturn a
> >> +  frame that preceded it in display, but succeeded it in the decode o=
rder),
> >> +
> >> +* a buffer queued to ``OUTPUT`` may result in a buffer being produced=
 on
> >> +  ``CAPTURE`` later into encode process, and/or after processing furt=
her
> >> +  ``OUTPUT`` buffers, or be returned out of order, e.g. if display
> >> +  reordering is used,
> >> +
> >> +* buffers may become available on the ``CAPTURE`` queue without addit=
ional
> >> +  buffers queued to ``OUTPUT`` (e.g. during drain or ``EOS``), becaus=
e of the
> >> +  ``OUTPUT`` buffers queued in the past whose decoding results are on=
ly
> >> +  available at later time, due to specifics of the decoding process,
> >> +
> >> +* buffers queued to ``OUTPUT`` may not become available to dequeue in=
stantly
> >> +  after being encoded into a corresponding ``CATPURE`` buffer, e.g. i=
f the
> >> +  encoder needs to use the frame as a reference for encoding further =
frames.
> >> +
> >> +.. note::
> >> +
> >> +   To allow matching encoded ``CAPTURE`` buffers with ``OUTPUT`` buff=
ers they
> >> +   originated from, the client can set the ``timestamp`` field of the
> >> +   :c:type:`v4l2_buffer` struct when queuing an ``OUTPUT`` buffer. Th=
e
> >> +   ``CAPTURE`` buffer(s), which resulted from encoding that ``OUTPUT`=
` buffer
> >> +   will have their ``timestamp`` field set to the same value when deq=
ueued.
> >> +
> >> +   In addition to the straightforward case of one ``OUTPUT`` buffer p=
roducing
> >> +   one ``CAPTURE`` buffer, the following cases are defined:
> >> +
> >> +   * one ``OUTPUT`` buffer generates multiple ``CAPTURE`` buffers: th=
e same
> >> +     ``OUTPUT`` timestamp will be copied to multiple ``CAPTURE`` buff=
ers,
> >> +
> >> +   * the encoding order differs from the presentation order (i.e. the
> >> +     ``CAPTURE`` buffers are out-of-order compared to the ``OUTPUT`` =
buffers):
> >> +     ``CAPTURE`` timestamps will not retain the order of ``OUTPUT`` t=
imestamps
> >> +     and thus monotonicity of the timestamps cannot be guaranteed.
> >
> > Drop "and thus monotonicity of the timestamps cannot be guaranteed": th=
is was never
> > guaranteed since timestamps are just copied from OUTPUT to CAPTURE.
> >
> > This phrase doesn't occur in the decoder spec, so it should be removed =
here as well.
> >
> >> +
> >> +.. note::
> >> +
> >> +   To let the client distinguish between frame types (keyframes, inte=
rmediate
> >> +   frames; the exact list of types depends on the coded format), the
> >> +   ``CAPTURE`` buffers will have corresponding flag bits set in their
> >> +   :c:type:`v4l2_buffer` struct when dequeued. See the documentation =
of
> >> +   :c:type:`v4l2_buffer` and each coded pixel format for exact list o=
f flags
> >> +   and their meanings.
> >> +
> >> +Encoding parameter changes
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> >> +
> >> +The client is allowed to use :c:func:`VIDIOC_S_CTRL` to change encode=
r
> >> +parameters at any time. The availability of parameters is encoder-spe=
cific
> >> +and the client must query the encoder to find the set of available co=
ntrols.
> >> +
> >> +The ability to change each parameter during encoding is encoder-speci=
fic, as
> >> +per the standard semantics of the V4L2 control interface. The client =
may
> >> +attempt to set a control during encoding and if the operation fails w=
ith the
> >> +-EBUSY error code, the ``CAPTURE`` queue needs to be stopped for the
> >> +configuration change to be allowed. To do this, it may follow the `Dr=
ain`
> >> +sequence to avoid losing the already queued/encoded frames.
> >> +
> >> +The timing of parameter updates is encoder-specific, as per the stand=
ard
> >> +semantics of the V4L2 control interface. If the client needs to apply=
 the
> >> +parameters exactly at specific frame, using the Request API
> >> +(:ref:`media-request-api`) should be considered, if supported by the =
encoder.
> >> +
> >> +Drain
> >> +=3D=3D=3D=3D=3D
> >> +
> >> +To ensure that all the queued ``OUTPUT`` buffers have been processed =
and the
> >> +related ``CAPTURE`` buffers are given to the client, the client must =
follow the
> >> +drain sequence described below. After the drain sequence ends, the cl=
ient has
> >> +received all encoded frames for all ``OUTPUT`` buffers queued before =
the
> >> +sequence was started.
> >> +
> >> +1. Begin the drain sequence by issuing :c:func:`VIDIOC_ENCODER_CMD`.
> >> +
> >> +   * **Required fields:**
> >> +
> >> +     ``cmd``
> >> +         set to ``V4L2_ENC_CMD_STOP``
> >> +
> >> +     ``flags``
> >> +         set to 0
> >> +
> >> +     ``pts``
> >> +         set to 0
> >> +
> >> +   .. warning::
> >> +
> >> +      The sequence can be only initiated if both ``OUTPUT`` and ``CAP=
TURE``
> >> +      queues are streaming. For compatibility reasons, the call to
> >> +      :c:func:`VIDIOC_ENCODER_CMD` will not fail even if any of the q=
ueues is
> >> +      not streaming, but at the same time it will not initiate the `D=
rain`
> >> +      sequence and so the steps described below would not be applicab=
le.
> >> +
> >> +2. Any ``OUTPUT`` buffers queued by the client before the
> >> +   :c:func:`VIDIOC_ENCODER_CMD` was issued will be processed and enco=
ded as
> >> +   normal. The client must continue to handle both queues independent=
ly,
> >> +   similarly to normal encode operation. This includes:
> >> +
> >> +   * queuing and dequeuing ``CAPTURE`` buffers, until a buffer marked=
 with the
> >> +     ``V4L2_BUF_FLAG_LAST`` flag is dequeued,
> >> +
> >> +     .. warning::
> >> +
> >> +        The last buffer may be empty (with :c:type:`v4l2_buffer`
> >> +        ``bytesused`` =3D 0) and in that case it must be ignored by t=
he client,
> >> +        as it does not contain an encoded frame.
> >> +
> >> +     .. note::
> >> +
> >> +        Any attempt to dequeue more buffers beyond the buffer marked =
with
> >> +        ``V4L2_BUF_FLAG_LAST`` will result in a -EPIPE error from
> >> +        :c:func:`VIDIOC_DQBUF`.
> >> +
> >> +   * dequeuing processed ``OUTPUT`` buffers, until all the buffers qu=
eued
> >> +     before the ``V4L2_ENC_CMD_STOP`` command are dequeued,
> >> +
> >> +   * dequeuing the ``V4L2_EVENT_EOS`` event, if the client subscribes=
 to it.
> >> +
> >> +   .. note::
> >> +
> >> +      For backwards compatibility, the encoder will signal a ``V4L2_E=
VENT_EOS``
> >> +      event when the last frame has been decoded and all frames are r=
eady to be
> >> +      dequeued. It is deprecated behavior and the client must not rel=
y on it.
> >> +      The ``V4L2_BUF_FLAG_LAST`` buffer flag should be used instead.
> >> +
> >> +3. Once all ``OUTPUT`` buffers queued before the ``V4L2_ENC_CMD_STOP`=
` call are
> >> +   dequeued and the last ``CAPTURE`` buffer is dequeued, the encoder =
is stopped
> >> +   and it will accept, but not process any newly queued ``OUTPUT`` bu=
ffers
> >> +   until the client issues any of the following operations:
> >> +
> >> +   * ``V4L2_ENC_CMD_START`` - the encoder will not be reset and will =
resume
> >> +     operation normally, with all the state from before the drain,
> >> +
> >> +   * a pair of :c:func:`VIDIOC_STREAMOFF` and :c:func:`VIDIOC_STREAMO=
N` on the
> >> +     ``CAPTURE`` queue - the encoder will be reset (see the `Reset` s=
equence)
> >> +     and then resume encoding,
> >> +
> >> +   * a pair of :c:func:`VIDIOC_STREAMOFF` and :c:func:`VIDIOC_STREAMO=
N` on the
> >> +     ``OUTPUT`` queue - the encoder will resume operation normally, h=
owever any
> >> +     source frames queued to the ``OUTPUT`` queue between ``V4L2_ENC_=
CMD_STOP``
> >> +     and :c:func:`VIDIOC_STREAMOFF` will be discarded.
> >> +
> >> +.. note::
> >> +
> >> +   Once the drain sequence is initiated, the client needs to drive it=
 to
> >> +   completion, as described by the steps above, unless it aborts the =
process by
> >> +   issuing :c:func:`VIDIOC_STREAMOFF` on any of the ``OUTPUT`` or ``C=
APTURE``
> >> +   queues.  The client is not allowed to issue ``V4L2_ENC_CMD_START``=
 or
> >> +   ``V4L2_ENC_CMD_STOP`` again while the drain sequence is in progres=
s and they
> >> +   will fail with -EBUSY error code if attempted.
> >> +
> >> +   Although mandatory, the availability of encoder commands may be qu=
eried
> >> +   using :c:func:`VIDIOC_TRY_ENCODER_CMD`.
> >> +
> >> +Reset
> >> +=3D=3D=3D=3D=3D
> >> +
> >> +The client may want to request the encoder to reinitialize the encodi=
ng, so
> >> +that the following stream data becomes independent from the stream da=
ta
> >> +generated before. Depending on the coded format, that may imply that:
> >> +
> >> +* encoded frames produced after the restart must not reference any fr=
ames
> >> +  produced before the stop, e.g. no long term references for H.264,
> >> +
> >> +* any headers that must be included in a standalone stream must be pr=
oduced
> >> +  again, e.g. SPS and PPS for H.264.
> >> +
> >> +This can be achieved by performing the reset sequence.
> >> +
> >> +1. Perform the `Drain` sequence to ensure all the in-flight encoding =
finishes
> >> +   and respective buffers are dequeued.
> >> +
> >> +2. Stop streaming on the ``CAPTURE`` queue via :c:func:`VIDIOC_STREAM=
OFF`. This
> >> +   will return all currently queued ``CAPTURE`` buffers to the client=
, without
> >> +   valid frame data.
> >> +
> >> +3. Start streaming on the ``CAPTURE`` queue via :c:func:`VIDIOC_STREA=
MON` and
> >> +   continue with regular encoding sequence. The encoded frames produc=
ed into
> >> +   ``CAPTURE`` buffers from now on will contain a standalone stream t=
hat can be
> >> +   decoded without the need for frames encoded before the reset seque=
nce,
> >> +   starting at the first ``OUTPUT`` buffer queued after issuing the
> >> +   `V4L2_ENC_CMD_STOP` of the `Drain` sequence.
> >> +
> >> +This sequence may be also used to change encoding parameters for enco=
ders
> >> +without the ability to change the parameters on the fly.
> >> +
> >> +Commit points
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +Setting formats and allocating buffers triggers changes in the behavi=
or of the
> >> +encoder.
> >> +
> >> +1. Setting the format on the ``CAPTURE`` queue may change the set of =
formats
> >> +   supported/advertised on the ``OUTPUT`` queue. In particular, it al=
so means
> >> +   that the ``OUTPUT`` format may be reset and the client must not re=
ly on the
> >> +   previously set format being preserved.
> >> +
> >> +2. Enumerating formats on the ``OUTPUT`` queue always returns only fo=
rmats
> >> +   supported for the current ``CAPTURE`` format.
> >> +
> >> +3. Setting the format on the ``OUTPUT`` queue does not change the lis=
t of
> >> +   formats available on the ``CAPTURE`` queue. An attempt to set the =
``OUTPUT``
> >> +   format that is not supported for the currently selected ``CAPTURE`=
` format
> >> +   will result in the encoder adjusting the requested ``OUTPUT`` form=
at to a
> >> +   supported one.
> >> +
> >> +4. Enumerating formats on the ``CAPTURE`` queue always returns the fu=
ll set of
> >> +   supported coded formats, irrespectively of the current ``OUTPUT`` =
format.
> >
> > irrespectively -> irrespective
> >
> >> +
> >> +5. While buffers are allocated on the ``CAPTURE`` queue, the client m=
ust not
> >> +   change the format on the queue. Drivers will return the -EBUSY err=
or code
>
> Change the format on which queue? CAPTURE or OUTPUT?

CAPTURE was intended here. One should be able to change the format on
OUTPUT freely.

>
> I think this should be more precise: changing the CAPTURE format will alw=
ays
> fail if CAPTURE buffers are already allocated, or if the OUTPUT is stream=
ing,
> or if changing the CAPTURE format will change the OUTPUT format and OUTPU=
T
> buffers are already allocated.

Indeed. I believe we can generalize this to:

5. While buffers are allocated on any of the ``OUTPUT`` or ``CAPTURE`` queu=
es,
   the client must not change the format on the ``CAPTURE`` queue. Drivers =
will
   return the -EBUSY error code for any such format change attempt.

>
> Changing the OUTPUT format will always fail if OUTPUT buffers are already=
 allocated,
> or if changing the OUTPUT format would change the CAPTURE format (sizeima=
ge in
> particular) and CAPTURE buffers were already allocated and are too small.

The OUTPUT format must not change the CAPTURE format by definition.
Otherwise we end up in a situation where we can't commit, because both
queue formats can affect each other. Any change to the OUTPUT format
that wouldn't work with the current CAPTURE format should be adjusted
by the driver to match the current CAPTURE format.

Best regards,
Tomasz

>
> Regards,
>
>         Hans
>
> >> +   for any such format change attempt.
> >> +
> >> +To summarize, setting formats and allocation must always start with t=
he
> >> +``CAPTURE`` queue and the ``CAPTURE`` queue is the master that govern=
s the
> >> +set of supported formats for the ``OUTPUT`` queue.
> >> diff --git a/Documentation/media/uapi/v4l/dev-mem2mem.rst b/Documentat=
ion/media/uapi/v4l/dev-mem2mem.rst
> >> index a0e06a88c872..82630ea89b16 100644
> >> --- a/Documentation/media/uapi/v4l/dev-mem2mem.rst
> >> +++ b/Documentation/media/uapi/v4l/dev-mem2mem.rst
> >> @@ -17,6 +17,7 @@ Video Memory-To-Memory Interface
> >>      :maxdepth: 1
> >>
> >>      dev-decoder
> >> +    dev-encoder
> >>
> >>  A V4L2 memory-to-memory device can compress, decompress, transform, o=
r
> >>  otherwise convert video data from one format into another format, in =
memory.
> >> diff --git a/Documentation/media/uapi/v4l/pixfmt-v4l2.rst b/Documentat=
ion/media/uapi/v4l/pixfmt-v4l2.rst
> >> index caf14e440447..593d25b935bf 100644
> >> --- a/Documentation/media/uapi/v4l/pixfmt-v4l2.rst
> >> +++ b/Documentation/media/uapi/v4l/pixfmt-v4l2.rst
> >> @@ -44,6 +44,11 @@ Single-planar format structure
> >>      inside the stream, when fed to a stateful mem2mem decoder, the fi=
elds
> >>      may be zero to rely on the decoder to detect the right values. Fo=
r more
> >>      details see :ref:`decoder` and format descriptions.
> >> +
> >> +    For compressed formats on the CAPTURE side of a stateful mem2mem
> >> +    encoder, the fields must be zero, since the coded size is expecte=
d to
> >> +    be calculated internally by the encoder itself, based on the OUTP=
UT
> >> +    side. For more details see :ref:`encoder` and format descriptions=
.
> >>      * - __u32
> >>        - ``pixelformat``
> >>        - The pixel format or type of compression, set by the applicati=
on.
> >> diff --git a/Documentation/media/uapi/v4l/v4l2.rst b/Documentation/med=
ia/uapi/v4l/v4l2.rst
> >> index 97015b9b40b8..e236ea23481b 100644
> >> --- a/Documentation/media/uapi/v4l/v4l2.rst
> >> +++ b/Documentation/media/uapi/v4l/v4l2.rst
> >> @@ -63,6 +63,7 @@ Authors, in alphabetical order:
> >>  - Figa, Tomasz <tfiga@chromium.org>
> >>
> >>    - Documented the memory-to-memory decoder interface.
> >> +  - Documented the memory-to-memory encoder interface.
> >>
> >>  - H Schimek, Michael <mschimek@gmx.at>
> >>
> >> @@ -75,6 +76,7 @@ Authors, in alphabetical order:
> >>  - Osciak, Pawel <posciak@chromium.org>
> >>
> >>    - Documented the memory-to-memory decoder interface.
> >> +  - Documented the memory-to-memory encoder interface.
> >>
> >>  - Osciak, Pawel <pawel@osciak.com>
> >>
> >> diff --git a/Documentation/media/uapi/v4l/vidioc-encoder-cmd.rst b/Doc=
umentation/media/uapi/v4l/vidioc-encoder-cmd.rst
> >> index c313ca8b8cb5..2b59a4e7f5ce 100644
> >> --- a/Documentation/media/uapi/v4l/vidioc-encoder-cmd.rst
> >> +++ b/Documentation/media/uapi/v4l/vidioc-encoder-cmd.rst
> >> @@ -57,19 +57,23 @@ currently only used by the STOP command and contai=
ns one bit: If the
> >>  until the end of the current *Group Of Pictures*, otherwise it will s=
top
> >>  immediately.
> >>
> >> -A :ref:`read() <func-read>` or :ref:`VIDIOC_STREAMON <VIDIOC_STREAMON=
>`
> >> -call sends an implicit START command to the encoder if it has not bee=
n
> >> -started yet. After a STOP command, :ref:`read() <func-read>` calls wi=
ll read
> >> +After a STOP command, :ref:`read() <func-read>` calls will read
> >>  the remaining data buffered by the driver. When the buffer is empty,
> >>  :ref:`read() <func-read>` will return zero and the next :ref:`read() =
<func-read>`
> >>  call will restart the encoder.
> >>
> >> +A :ref:`read() <func-read>` or :ref:`VIDIOC_STREAMON <VIDIOC_STREAMON=
>`
> >> +call sends an implicit START command to the encoder if it has not bee=
n
> >> +started yet. Applies to both queues of mem2mem encoders.
> >> +
> >>  A :ref:`close() <func-close>` or :ref:`VIDIOC_STREAMOFF <VIDIOC_STREA=
MON>`
> >>  call of a streaming file descriptor sends an implicit immediate STOP =
to
> >> -the encoder, and all buffered data is discarded.
> >> +the encoder, and all buffered data is discarded. Applies to both queu=
es of
> >> +mem2mem encoders.
> >>
> >>  These ioctls are optional, not all drivers may support them. They wer=
e
> >> -introduced in Linux 2.6.21.
> >> +introduced in Linux 2.6.21. They are, however, mandatory for stateful=
 mem2mem
> >> +encoders (as further documented in :ref:`encoder`).
> >>
> >>
> >>  .. tabularcolumns:: |p{4.4cm}|p{4.4cm}|p{8.7cm}|
> >> @@ -114,16 +118,20 @@ introduced in Linux 2.6.21.
> >>        - Stop the encoder. When the ``V4L2_ENC_CMD_STOP_AT_GOP_END`` f=
lag
> >>      is set, encoding will continue until the end of the current *Grou=
p
> >>      Of Pictures*, otherwise encoding will stop immediately. When the
> >> -    encoder is already stopped, this command does nothing. mem2mem
> >> -    encoders will send a ``V4L2_EVENT_EOS`` event when the last frame
> >> -    has been encoded and all frames are ready to be dequeued and will
> >> -    set the ``V4L2_BUF_FLAG_LAST`` buffer flag on the last buffer of
> >> -    the capture queue to indicate there will be no new buffers
> >> -    produced to dequeue. This buffer may be empty, indicated by the
> >> -    driver setting the ``bytesused`` field to 0. Once the
> >> -    ``V4L2_BUF_FLAG_LAST`` flag was set, the
> >> -    :ref:`VIDIOC_DQBUF <VIDIOC_QBUF>` ioctl will not block anymore,
> >> -    but return an ``EPIPE`` error code.
> >> +    encoder is already stopped, this command does nothing.
> >> +
> >> +    A stateful mem2mem encoder will proceed with encoding the source
> >> +    buffers pending before the command is issued and then stop produc=
ing
> >> +    new frames. It will send a ``V4L2_EVENT_EOS`` event when the last=
 frame
> >> +    has been encoded and all frames are ready to be dequeued and will=
 set
> >> +    the ``V4L2_BUF_FLAG_LAST`` buffer flag on the last buffer of the
> >> +    capture queue to indicate there will be no new buffers produced t=
o
> >> +    dequeue. This buffer may be empty, indicated by the driver settin=
g the
> >> +    ``bytesused`` field to 0. Once the buffer with the
> >> +    ``V4L2_BUF_FLAG_LAST`` flag set was dequeued, the :ref:`VIDIOC_DQ=
BUF
> >> +    <VIDIOC_QBUF>` ioctl will not block anymore, but return an ``EPIP=
E``
> >> +    error code. No flags or other arguments are accepted in case of m=
em2mem
> >> +    encoders.  See :ref:`encoder` for more details.
> >>      * - ``V4L2_ENC_CMD_PAUSE``
> >>        - 2
> >>        - Pause the encoder. When the encoder has not been started yet,=
 the
> >>
> >
> > Regards,
> >
> >       Hans
> >
>
