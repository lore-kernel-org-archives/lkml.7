Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EA3C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D5B2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eyKDUNvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfDIJfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:35:51 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34001 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfDIJfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:35:51 -0400
Received: by mail-oi1-f194.google.com with SMTP id v10so12998927oib.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 02:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qXpfYmPxf2yHrr524k2EKBjBFyw3gs8k0vpTi/pzY70=;
        b=eyKDUNvcxj/MUkG+abKccn3Aabn6KdLp6s8m5t4tsHipbgEgQ0NAflPeCVOufSkmgt
         TvqCgTYCt+qJ+JqMukMHhRg77f/o/BLYnBzZgzHsQ6v7ksZ2OgekWs4bqh96QBWOPjqQ
         gQdyJuknU7mclNuDQjDAavWg3tdrAXhVdHBVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qXpfYmPxf2yHrr524k2EKBjBFyw3gs8k0vpTi/pzY70=;
        b=ForFr+HGFnvu4jkBKeWA4jdKBePn5LUDqn0DUYgX9lbQmgWwonTc5xDPvvvhx9mFOB
         RGckY6xoTS3Ba681ktyCAH35hKLlK7A/ZEdIC+woX/U0YyFk3P5gI3adaYMkaZSWZ2hF
         GsKJ02O+YnYi1vyC09oA399jUn1Vl2NiIMX16MNGyl9fJbzcbGZ6IjbtsZJjdzttITVm
         94x3yDhyTSGk04+t+3QPxb40rPgapGqsBEuzG7p8VOyNg1hYDe/l4hrRQANDJWv2BGfT
         O5LY1AG8KMQEXVTBfat+ME+B96uVaEzcc0SwrJaNnl+YqW0vJgkJs92jKilDwVXRnbeb
         3D2w==
X-Gm-Message-State: APjAAAX7FuVdxaMIDnhGC5qGJqRFfvqCrM+F2+tuhLeCVIxux2RyEWdK
        9bUJzDuABFhqJxe8wOWaZt1SRAPCARQ=
X-Google-Smtp-Source: APXvYqxkuzg3PV7jnLMTuW8G/yN+URJX3d0apXWJRAkn6WBsZLH8iPGhLYexQkfGKt79g8QAvWUXGA==
X-Received: by 2002:aca:a88c:: with SMTP id r134mr19276564oie.139.1554802549423;
        Tue, 09 Apr 2019 02:35:49 -0700 (PDT)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com. [209.85.167.179])
        by smtp.gmail.com with ESMTPSA id g21sm12942919otk.12.2019.04.09.02.35.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 02:35:48 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id e5so13018935oii.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 02:35:47 -0700 (PDT)
X-Received: by 2002:aca:a894:: with SMTP id r142mr19198523oie.112.1554802547152;
 Tue, 09 Apr 2019 02:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190124100419.26492-1-tfiga@chromium.org> <20190124100419.26492-3-tfiga@chromium.org>
 <4bbe4ce4-615a-b981-0855-cd78c7a002d9@xs4all.nl> <471720b7-e304-271b-256d-a3dd394773c9@xs4all.nl>
 <CAAFQd5Au_=08pVom1z3C1nHKdKak8Y4d5odR6fiNB4urDhfjKQ@mail.gmail.com>
 <787ddc1f-388d-82be-2702-0d7d256f636c@xs4all.nl> <CAAFQd5DozydYBpEceFTbJSutP+gwjxybpd1q6N1Vi+YragQT+w@mail.gmail.com>
 <6cb0caf1-61a6-0719-1ade-1dcf8ed8a020@xs4all.nl>
In-Reply-To: <6cb0caf1-61a6-0719-1ade-1dcf8ed8a020@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 9 Apr 2019 18:35:35 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DdDv+Nu0Dry1XRpYAnz0DrSE5kEf7GxY64tg6aJebzMQ@mail.gmail.com>
Message-ID: <CAAFQd5DdDv+Nu0Dry1XRpYAnz0DrSE5kEf7GxY64tg6aJebzMQ@mail.gmail.com>
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

On Mon, Apr 8, 2019 at 8:11 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 4/8/19 11:23 AM, Tomasz Figa wrote:
> > On Fri, Apr 5, 2019 at 7:03 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
> >>
> >> On 4/5/19 10:12 AM, Tomasz Figa wrote:
> >>> On Thu, Mar 14, 2019 at 10:57 PM Hans Verkuil <hverkuil@xs4all.nl> wr=
ote:
> >>>>
> >>>> Hi Tomasz,
> >>>>
> >>>> Some more comments...
> >>>>
> >>>> On 1/29/19 2:52 PM, Hans Verkuil wrote:
> >>>>> Hi Tomasz,
> >>>>>
> >>>>> Some comments below. Nothing major, so I think a v4 should be ready=
 to be
> >>>>> merged.
> >>>>>
> >>>>> On 1/24/19 11:04 AM, Tomasz Figa wrote:
> >>>>>> Due to complexity of the video encoding process, the V4L2 drivers =
of
> >>>>>> stateful encoder hardware require specific sequences of V4L2 API c=
alls
> >>>>>> to be followed. These include capability enumeration, initializati=
on,
> >>>>>> encoding, encode parameters change, drain and reset.
> >>>>>>
> >>>>>> Specifics of the above have been discussed during Media Workshops =
at
> >>>>>> LinuxCon Europe 2012 in Barcelona and then later Embedded Linux
> >>>>>> Conference Europe 2014 in D=C3=BCsseldorf. The de facto Codec API =
that
> >>>>>> originated at those events was later implemented by the drivers we=
 already
> >>>>>> have merged in mainline, such as s5p-mfc or coda.
> >>>>>>
> >>>>>> The only thing missing was the real specification included as a pa=
rt of
> >>>>>> Linux Media documentation. Fix it now and document the encoder par=
t of
> >>>>>> the Codec API.
> >>>>>>
> >>>>>> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> >>>>>> ---
> >>>>>>  Documentation/media/uapi/v4l/dev-encoder.rst  | 586 +++++++++++++=
+++++
> >>>>>>  Documentation/media/uapi/v4l/dev-mem2mem.rst  |   1 +
> >>>>>>  Documentation/media/uapi/v4l/pixfmt-v4l2.rst  |   5 +
> >>>>>>  Documentation/media/uapi/v4l/v4l2.rst         |   2 +
> >>>>>>  .../media/uapi/v4l/vidioc-encoder-cmd.rst     |  38 +-
> >>>>>>  5 files changed, 617 insertions(+), 15 deletions(-)
> >>>>>>  create mode 100644 Documentation/media/uapi/v4l/dev-encoder.rst
> >>>>>>
> >>>>>> diff --git a/Documentation/media/uapi/v4l/dev-encoder.rst b/Docume=
ntation/media/uapi/v4l/dev-encoder.rst
> >>>>>> new file mode 100644
> >>>>>> index 000000000000..fb8b05a132ee
> >>>>>> --- /dev/null
> >>>>>> +++ b/Documentation/media/uapi/v4l/dev-encoder.rst
> >>>>>> @@ -0,0 +1,586 @@
> >>>>>> +.. -*- coding: utf-8; mode: rst -*-
> >>>>>> +
> >>>>>> +.. _encoder:
> >>>>>> +
> >>>>>> +*************************************************
> >>>>>> +Memory-to-memory Stateful Video Encoder Interface
> >>>>>> +*************************************************
> >>>>>> +
> >>>>>> +A stateful video encoder takes raw video frames in display order =
and encodes
> >>>>>> +them into a bitstream. It generates complete chunks of the bitstr=
eam, including
> >>>>>> +all metadata, headers, etc. The resulting bitstream does not requ=
ire any
> >>>>>> +further post-processing by the client.
> >>>>>> +
> >>>>>> +Performing software stream processing, header generation etc. in =
the driver
> >>>>>> +in order to support this interface is strongly discouraged. In ca=
se such
> >>>>>> +operations are needed, use of the Stateless Video Encoder Interfa=
ce (in
> >>>>>> +development) is strongly advised.
> >>>>>> +
> >>>>>> +Conventions and notation used in this document
> >>>>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>> +
> >>>>>> +1. The general V4L2 API rules apply if not specified in this docu=
ment
> >>>>>> +   otherwise.
> >>>>>> +
> >>>>>> +2. The meaning of words "must", "may", "should", etc. is as per `=
RFC
> >>>>>> +   2119 <https://tools.ietf.org/html/rfc2119>`_.
> >>>>>> +
> >>>>>> +3. All steps not marked "optional" are required.
> >>>>>> +
> >>>>>> +4. :c:func:`VIDIOC_G_EXT_CTRLS` and :c:func:`VIDIOC_S_EXT_CTRLS` =
may be used
> >>>>>> +   interchangeably with :c:func:`VIDIOC_G_CTRL` and :c:func:`VIDI=
OC_S_CTRL`,
> >>>>>> +   unless specified otherwise.
> >>>>>> +
> >>>>>> +5. Single-planar API (see :ref:`planar-apis`) and applicable stru=
ctures may be
> >>>>>> +   used interchangeably with multi-planar API, unless specified o=
therwise,
> >>>>>> +   depending on decoder capabilities and following the general V4=
L2 guidelines.
> >>>>>> +
> >>>>>> +6. i =3D [a..b]: sequence of integers from a to b, inclusive, i.e=
. i =3D
> >>>>>> +   [0..2]: i =3D 0, 1, 2.
> >>>>>> +
> >>>>>> +7. Given an ``OUTPUT`` buffer A, then A=E2=80=99 represents a buf=
fer on the ``CAPTURE``
> >>>>>> +   queue containing data that resulted from processing buffer A.
> >>>>>> +
> >>>>>> +Glossary
> >>>>>> +=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>> +
> >>>>>> +Refer to :ref:`decoder-glossary`.
> >>>>>> +
> >>>>>> +State machine
> >>>>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>> +
> >>>>>> +.. kernel-render:: DOT
> >>>>>> +   :alt: DOT digraph of encoder state machine
> >>>>>> +   :caption: Encoder state machine
> >>>>>> +
> >>>>>> +   digraph encoder_state_machine {
> >>>>>> +       node [shape =3D doublecircle, label=3D"Encoding"] Encoding=
;
> >>>>>> +
> >>>>>> +       node [shape =3D circle, label=3D"Initialization"] Initiali=
zation;
> >>>>>> +       node [shape =3D circle, label=3D"Stopped"] Stopped;
> >>>>>> +       node [shape =3D circle, label=3D"Drain"] Drain;
> >>>>>> +       node [shape =3D circle, label=3D"Reset"] Reset;
> >>>>>> +
> >>>>>> +       node [shape =3D point]; qi
> >>>>>> +       qi -> Initialization [ label =3D "open()" ];
> >>>>>> +
> >>>>>> +       Initialization -> Encoding [ label =3D "Both queues stream=
ing" ];
> >>>>>> +
> >>>>>> +       Encoding -> Drain [ label =3D "V4L2_DEC_CMD_STOP" ];
> >>>>>> +       Encoding -> Reset [ label =3D "VIDIOC_STREAMOFF(CAPTURE)" =
];
> >>>>>> +       Encoding -> Stopped [ label =3D "VIDIOC_STREAMOFF(OUTPUT)"=
 ];
> >>>>>> +       Encoding -> Encoding;
> >>>>>> +
> >>>>>> +       Drain -> Stopped [ label =3D "All CAPTURE\nbuffers dequeue=
d\nor\nVIDIOC_STREAMOFF(CAPTURE)" ];
> >>>>>> +       Drain -> Reset [ label =3D "VIDIOC_STREAMOFF(CAPTURE)" ];
> >>>>>> +
> >>>>>> +       Reset -> Encoding [ label =3D "VIDIOC_STREAMON(CAPTURE)" ]=
;
> >>>>>> +       Reset -> Initialization [ label =3D "VIDIOC_REQBUFS(OUTPUT=
, 0)" ];
> >>>>>> +
> >>>>>> +       Stopped -> Encoding [ label =3D "V4L2_DEC_CMD_START\nor\nV=
IDIOC_STREAMON(OUTPUT)" ];
> >>>>>> +       Stopped -> Reset [ label =3D "VIDIOC_STREAMOFF(CAPTURE)" ]=
;
> >>>>>> +   }
> >>>>>> +
> >>>>>> +Querying capabilities
> >>>>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>> +
> >>>>>> +1. To enumerate the set of coded formats supported by the encoder=
, the
> >>>>>> +   client may call :c:func:`VIDIOC_ENUM_FMT` on ``CAPTURE``.
> >>>>>> +
> >>>>>> +   * The full set of supported formats will be returned, regardle=
ss of the
> >>>>>> +     format set on ``OUTPUT``.
> >>>>>> +
> >>>>>> +2. To enumerate the set of supported raw formats, the client may =
call
> >>>>>> +   :c:func:`VIDIOC_ENUM_FMT` on ``OUTPUT``.
> >>>>>> +
> >>>>>> +   * Only the formats supported for the format currently active o=
n ``CAPTURE``
> >>>>>> +     will be returned.
> >>>>>> +
> >>>>>> +   * In order to enumerate raw formats supported by a given coded=
 format,
> >>>>>> +     the client must first set that coded format on ``CAPTURE`` a=
nd then
> >>>>>> +     enumerate the formats on ``OUTPUT``.
> >>>>>> +
> >>>>>> +3. The client may use :c:func:`VIDIOC_ENUM_FRAMESIZES` to detect =
supported
> >>>>>> +   resolutions for a given format, passing desired pixel format i=
n
> >>>>>> +   :c:type:`v4l2_frmsizeenum` ``pixel_format``.
> >>>>>> +
> >>>>>> +   * Values returned by :c:func:`VIDIOC_ENUM_FRAMESIZES` for a co=
ded pixel
> >>>>>> +     format will include all possible coded resolutions supported=
 by the
> >>>>>> +     encoder for given coded pixel format.
> >>>>>> +
> >>>>>> +   * Values returned by :c:func:`VIDIOC_ENUM_FRAMESIZES` for a ra=
w pixel format
> >>>>>> +     will include all possible frame buffer resolutions supported=
 by the
> >>>>>> +     encoder for given raw pixel format and coded format currentl=
y set on
> >>>>>> +     ``CAPTURE``.
> >>>>>> +
> >>>>>> +4. Supported profiles and levels for the coded format currently s=
et on
> >>>>>> +   ``CAPTURE``, if applicable, may be queried using their respect=
ive controls
> >>>>>> +   via :c:func:`VIDIOC_QUERYCTRL`.
> >>>>>> +
> >>>>>> +5. Any additional encoder capabilities may be discovered by query=
ing
> >>>>>> +   their respective controls.
> >>>>>> +
> >>>>>> +Initialization
> >>>>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>> +
> >>>>>> +1. Set the coded format on the ``CAPTURE`` queue via :c:func:`VID=
IOC_S_FMT`
> >>>>>> +
> >>>>>> +   * **Required fields:**
> >>>>>> +
> >>>>>> +     ``type``
> >>>>>> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``CAPTURE``
> >>>>>> +
> >>>>>> +     ``pixelformat``
> >>>>>> +         the coded format to be produced
> >>>>>> +
> >>>>>> +     ``sizeimage``
> >>>>>> +         desired size of ``CAPTURE`` buffers; the encoder may adj=
ust it to
> >>>>>> +         match hardware requirements
> >>>>>> +
> >>>>>> +     ``width``, ``height``
> >>>>>> +         ignored (always zero)
> >>>>>> +
> >>>>>> +     other fields
> >>>>>> +         follow standard semantics
> >>>>>> +
> >>>>>> +   * **Return fields:**
> >>>>>> +
> >>>>>> +     ``sizeimage``
> >>>>>> +         adjusted size of ``CAPTURE`` buffers
> >>>>>> +
> >>>>>> +   .. important::
> >>>>>> +
> >>>>>> +      Changing the ``CAPTURE`` format may change the currently se=
t ``OUTPUT``
> >>>>>> +      format. The encoder will derive a new ``OUTPUT`` format fro=
m the
> >>>>>> +      ``CAPTURE`` format being set, including resolution, colorim=
etry
> >>>>>> +      parameters, etc. If the client needs a specific ``OUTPUT`` =
format, it
> >>>>>> +      must adjust it afterwards.
> >>>>>
> >>>>> Hmm, "including resolution": if width and height are set to 0, what=
 should the
> >>>>> OUTPUT resolution be? Up to the driver? I think this should be clar=
ified since
> >>>>> at a first reading of this paragraph it appears to be contradictory=
.
> >>>>
> >>>> I think the driver should just return the width and height of the OU=
TPUT
> >>>> format. So the width and height that userspace specifies is just ign=
ored
> >>>> and replaced by the width and height of the OUTPUT format. After all=
, that's
> >>>> what the bitstream will encode. Returning 0 for width and height wou=
ld make
> >>>> this a strange exception in V4L2 and I want to avoid that.
> >>>>
> >>>
> >>> Hmm, however, the width and height of the OUTPUT format is not what's
> >>> actually encoded in the bitstream. The right selection rectangle
> >>> determines that.
> >>>
> >>> In one of the previous versions I though we could put the codec
> >
> > s/codec/coded/...
> >
> >>> resolution as the width and height of the CAPTURE format, which would
> >>> be the resolution of the encoded image rounded up to full macroblocks
> >>> +/- some encoder-specific constraints. AFAIR there was some concern
> >>> about OUTPUT format changes triggering CAPTURE format changes, but to
> >>> be honest, I'm not sure if that's really a problem. I just decided to
> >>> drop that for the simplicity.
> >>
> >> I'm not sure what your point is.
> >>
> >> The OUTPUT format has the coded resolution,
> >
> > That's not always true. The OUTPUT format is just the format of the
> > source frame buffers. In special cases where the source resolution is
> > nicely aligned, it would be the same as coded size, but the remaining
> > cases are valid as well.
> >
> >> so when you set the
> >> CAPTURE format it can just copy the OUTPUT coded resolution unless the
> >> chosen CAPTURE pixelformat can't handle that in which case both the
> >> OUTPUT and CAPTURE coded resolutions are clamped to whatever is the ma=
ximum
> >> or minimum the codec is capable of.
> >
> > As per my comment above, generally speaking, the encoder will derive
> > an appropriate coded format from the OUTPUT format, but also other
> > factors, like the crop rectangles and possibly some internal
> > constraints.
> >
> >>
> >> That said, I am fine with just leaving it up to the driver as suggeste=
d
> >> before. Just as long as both the CAPTURE and OUTPUT formats remain val=
id
> >> (i.e. width and height may never be out of range).
> >>
> >
> > Sounds good to me.
> >
> >>>
> >>>>>
> >>>>>> +
> >>>>>> +2. **Optional.** Enumerate supported ``OUTPUT`` formats (raw form=
ats for
> >>>>>> +   source) for the selected coded format via :c:func:`VIDIOC_ENUM=
_FMT`.
> >>>>>> +
> >>>>>> +   * **Required fields:**
> >>>>>> +
> >>>>>> +     ``type``
> >>>>>> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
> >>>>>> +
> >>>>>> +     other fields
> >>>>>> +         follow standard semantics
> >>>>>> +
> >>>>>> +   * **Return fields:**
> >>>>>> +
> >>>>>> +     ``pixelformat``
> >>>>>> +         raw format supported for the coded format currently sele=
cted on
> >>>>>> +         the ``CAPTURE`` queue.
> >>>>>> +
> >>>>>> +     other fields
> >>>>>> +         follow standard semantics
> >>>>>> +
> >>>>>> +3. Set the raw source format on the ``OUTPUT`` queue via
> >>>>>> +   :c:func:`VIDIOC_S_FMT`.
> >>>>>> +
> >>>>>> +   * **Required fields:**
> >>>>>> +
> >>>>>> +     ``type``
> >>>>>> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
> >>>>>> +
> >>>>>> +     ``pixelformat``
> >>>>>> +         raw format of the source
> >>>>>> +
> >>>>>> +     ``width``, ``height``
> >>>>>> +         source resolution
> >>>>>> +
> >>>>>> +     other fields
> >>>>>> +         follow standard semantics
> >>>>>> +
> >>>>>> +   * **Return fields:**
> >>>>>> +
> >>>>>> +     ``width``, ``height``
> >>>>>> +         may be adjusted by encoder to match alignment requiremen=
ts, as
> >>>>>> +         required by the currently selected formats
> >>>>>
> >>>>> What if the width x height is larger than the maximum supported by =
the
> >>>>> selected coded format? This should probably mention that in that ca=
se the
> >>>>> width x height is reduced to the largest allowed value. Also mentio=
n that
> >>>>> this maximum is reported by VIDIOC_ENUM_FRAMESIZES.
> >>>>>
> >>>>>> +
> >>>>>> +     other fields
> >>>>>> +         follow standard semantics
> >>>>>> +
> >>>>>> +   * Setting the source resolution will reset the selection recta=
ngles to their
> >>>>>> +     default values, based on the new resolution, as described in=
 the step 5
> >>>>>
> >>>>> 5 -> 4
> >>>>>
> >>>>> Or just say: "as described in the next step."
> >>>>>
> >>>>>> +     below.
> >>>>
> >>>> It should also be made explicit that:
> >>>>
> >>>> 1) the crop rectangle will be set to the given width and height *bef=
ore*
> >>>> it is being adjusted by S_FMT.
> >>>>
> >>>
> >>> I don't think that's what we want here.
> >>>
> >>> Defining the default rectangle to be exactly the same as the OUTPUT
> >>> resolution (after the adjustment) makes the semantics consistent - no=
t
> >>> setting the crop rectangle gives you exactly the behavior as if there
> >>> was no cropping involved (or supported by the encoder).
> >>
> >> I think you are right. This seems to be what the coda driver does as w=
ell.
> >> It is convenient to be able to just set a 1920x1080 format and have th=
at
> >> resolution be stored as the crop rectangle, since it avoids having to =
call
> >> s_selection afterwards, but it is not really consistent with the way V=
4L2
> >> works.
> >>
> >>>
> >>>> Open question: should we support a compose rectangle for the CAPTURE=
 that
> >>>> is the same as the OUTPUT crop rectangle? I.e. the CAPTURE format co=
ntains
> >>>> the adjusted width and height and the compose rectangle (read-only) =
contains
> >>>> the visible width and height. It's not strictly necessary, but it is
> >>>> symmetrical.
> >>>
> >>> Wouldn't it rather be the CAPTURE crop rectangle that would be of the
> >>> same resolution of the OUTPUT compose rectangle? Then you could
> >>> actually have the CAPTURE compose rectangle for putting that into the
> >>> desired rectangle of the encoded stream, if the encoder supports that=
.
> >>> (I don't know any that does, so probably out of concern for now.)
> >>
> >> Yes, you are right.
> >>
> >> But should we support this?
> >>
> >> I actually think not for this initial version. It can be added later, =
I guess.
> >>
> >
> > I think it boils down on whether adding it later wouldn't
> > significantly complicate the application logic. It also relates to my
> > other comment somewhere below.
> >
> >>>
> >>>>
> >>>> 2) the CAPTURE format will be updated as well with the new OUTPUT wi=
dth and
> >>>> height. The CAPTURE sizeimage might change as well.
> >>>>
> >>>>>> +
> >>>>>> +4. **Optional.** Set the visible resolution for the stream metada=
ta via
> >>>>>> +   :c:func:`VIDIOC_S_SELECTION` on the ``OUTPUT`` queue.
> >>>>
> >>>> I think you should mention that this is only necessary if the crop r=
ectangle
> >>>> that is set when you set the format isn't what you want.
> >>>>
> >>>
> >>> Ack.
> >>>
> >>>>>> +
> >>>>>> +   * **Required fields:**
> >>>>>> +
> >>>>>> +     ``type``
> >>>>>> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
> >>>>>> +
> >>>>>> +     ``target``
> >>>>>> +         set to ``V4L2_SEL_TGT_CROP``
> >>>>>> +
> >>>>>> +     ``r.left``, ``r.top``, ``r.width``, ``r.height``
> >>>>>> +         visible rectangle; this must fit within the `V4L2_SEL_TG=
T_CROP_BOUNDS`
> >>>>>> +         rectangle and may be subject to adjustment to match code=
c and
> >>>>>> +         hardware constraints
> >>>>>> +
> >>>>>> +   * **Return fields:**
> >>>>>> +
> >>>>>> +     ``r.left``, ``r.top``, ``r.width``, ``r.height``
> >>>>>> +         visible rectangle adjusted by the encoder
> >>>>>> +
> >>>>>> +   * The following selection targets are supported on ``OUTPUT``:
> >>>>>> +
> >>>>>> +     ``V4L2_SEL_TGT_CROP_BOUNDS``
> >>>>>> +         equal to the full source frame, matching the active ``OU=
TPUT``
> >>>>>> +         format
> >>>>>> +
> >>>>>> +     ``V4L2_SEL_TGT_CROP_DEFAULT``
> >>>>>> +         equal to ``V4L2_SEL_TGT_CROP_BOUNDS``
> >>>>>> +
> >>>>>> +     ``V4L2_SEL_TGT_CROP``
> >>>>>> +         rectangle within the source buffer to be encoded into th=
e
> >>>>>> +         ``CAPTURE`` stream; defaults to ``V4L2_SEL_TGT_CROP_DEFA=
ULT``
> >>>>>> +
> >>>>>> +         .. note::
> >>>>>> +
> >>>>>> +            A common use case for this selection target is encodi=
ng a source
> >>>>>> +            video with a resolution that is not a multiple of a m=
acroblock,
> >>>>>> +            e.g.  the common 1920x1080 resolution may require the=
 source
> >>>>>> +            buffers to be aligned to 1920x1088 for codecs with 16=
x16 macroblock
> >>>>>> +            size. To avoid encoding the padding, the client needs=
 to explicitly
> >>>>>> +            configure this selection target to 1920x1080.
> >>>>
> >>>> This last sentence contradicts the proposed behavior of S_FMT(OUTPUT=
).
> >>>>
> >>>
> >>> Sorry, which part exactly and what part of the proposal exactly? :)
> >>> (My comment above might be related, though.)
> >>
> >> Ignore my comment. We go back to explicitly requiring userspace to set=
 the OUTPUT
> >> crop selection target, so this note remains valid.
> >>
> >
> > Ack.
> >
> >>>
> >>>>>> +
> >>>>>> +     ``V4L2_SEL_TGT_COMPOSE_BOUNDS``
> >>>>>> +         maximum rectangle within the coded resolution, which the=
 cropped
> >>>>>> +         source frame can be composed into; if the hardware does =
not support
> >>>>>> +         composition or scaling, then this is always equal to the=
 rectangle of
> >>>>>> +         width and height matching ``V4L2_SEL_TGT_CROP`` and loca=
ted at (0, 0)
> >>>>>> +
> >>>>>> +     ``V4L2_SEL_TGT_COMPOSE_DEFAULT``
> >>>>>> +         equal to a rectangle of width and height matching
> >>>>>> +         ``V4L2_SEL_TGT_CROP`` and located at (0, 0)
> >>>>>> +
> >>>>>> +     ``V4L2_SEL_TGT_COMPOSE``
> >>>>>> +         rectangle within the coded frame, which the cropped sour=
ce frame
> >>>>>> +         is to be composed into; defaults to
> >>>>>> +         ``V4L2_SEL_TGT_COMPOSE_DEFAULT``; read-only on hardware =
without
> >>>>>> +         additional compose/scaling capabilities; resulting strea=
m will
> >>>>>> +         have this rectangle encoded as the visible rectangle in =
its
> >>>>>> +         metadata
> >>>>
> >>>> I think the compose targets for OUTPUT are only needed if the hardwa=
re can
> >>>> actually do scaling and/or composition. Otherwise they can (must?) b=
e
> >>>> dropped.
> >>>>
> >>>
> >>> Note that V4L2_SEL_TGT_COMPOSE is defined to be the way for the
> >>> userspace to learn the target visible rectangle that's going to be
> >>> encoded in the stream metadata. If we omit it, we wouldn't have a way
> >>> that would be consistent between encoders that can do
> >>> scaling/composition and those that can't.
> >>
> >> I'm not convinced about this. The standard API behavior is not to expo=
se
> >> functionality that the hardware can't do. So if scaling isn't possible=
 on
> >> the OUTPUT side, then it shouldn't expose OUTPUT compose rectangles.
> >>
> >> I also believe it very unlikely that we'll see encoders capable of sca=
ling
> >> as it doesn't make much sense.
> >
> > It does make a lot of sense - WebRTC requires 3 different sizes of the
> > stream to be encoded at the same time. However, unfortunately, I
> > haven't yet seen an encoder capable of doing so.
> >
> >> I would prefer to drop this to simplify the
> >> spec, and when we get encoders that can scale, then we can add support=
 for
> >> compose rectangles (and I'm sure we'll need to think about how that
> >> influences the CAPTURE side as well).
> >>
> >> For encoders without scaling it is the OUTPUT crop rectangle that defi=
nes
> >> the visible rectangle.
> >>
> >>>
> >>> However, with your proposal of actually having selection rectangles
> >>> for the CAPTURE queue, it could be solved indeed. The OUTPUT queue
> >>> would expose a varying set of rectangles, depending on the hardware
> >>> capability, while the CAPTURE queue would always expose its rectangle
> >>> with that information.
> >>
> >> I think we should keep it simple and only define selection rectangles
> >> when really needed.
> >>
> >> So encoders support CROP on the OUTPUT, and decoders support CAPTURE
> >> COMPOSE (may be read-only). Nothing else.
> >>
> >> Once support for scaling is needed (either on the encoder or decoder
> >> side), then the spec should be enhanced. But I prefer to postpone that
> >> until we actually have hardware that needs this.
> >>
> >
> > Okay, let's do it this way then. Actually, I don't even think there is
> > much value in exposing information internal to the bitstream metadata
> > like this, similarly to the coded size. My intention was to just
> > ensure that we can easily add scaling/composing functionality later.
> >
> > I just removed the COMPOSE rectangles from my next draft.
>
> I don't think that supporting scaling will be a problem for the API as
> such, since this is supported for standard video capture devices. It
> just gets very complicated trying to describe how to configure all this.
>
> So I prefer to avoid this until we need to.
>
> >
> > [snip]
> >>>
> >>>>
> >>>> Changing the OUTPUT format will always fail if OUTPUT buffers are al=
ready allocated,
> >>>> or if changing the OUTPUT format would change the CAPTURE format (si=
zeimage in
> >>>> particular) and CAPTURE buffers were already allocated and are too s=
mall.
> >>>
> >>> The OUTPUT format must not change the CAPTURE format by definition.
> >>> Otherwise we end up in a situation where we can't commit, because bot=
h
> >>> queue formats can affect each other. Any change to the OUTPUT format
> >>> that wouldn't work with the current CAPTURE format should be adjusted
> >>> by the driver to match the current CAPTURE format.
> >>
> >> But the CAPTURE format *does* depend on the OUTPUT format: if the outp=
ut
> >> resolution changes, then so does the CAPTURE resolution and esp. the
> >> sizeimage value, since that is typically resolution dependent.
> >>
> >> The coda driver does this as well: changing the output resolution
> >> will update the capture resolution and sizeimage. The vicodec driver d=
oes the
> >> same.
> >>
> >> Setting the CAPTURE format basically just selects the codec to use, af=
ter
> >> that you can set the OUTPUT format and read the updated CAPTURE format=
 to
> >> get the new sizeimage value. In fact, setting the CAPTURE format shoul=
dn't
> >> change the OUTPUT format, unless the OUTPUT format is incompatible wit=
h the
> >> newly selected codec.
> >
> > Let me think about it for a while.
>
> Sleep on it, always works well for me :-)

Okay, I think I'm not convinced.

I believe we decided to allow sizeimage to be specified by the
application, because it knows more about the stream it's going to
encode. Only setting the size to 0 would make the encoder fall back to
some simple internal heuristic.

Another thing is handling resolution changes. I believe that would
have to be handled by stopping the OUTPUT queue, changing the OUTPUT
format and starting the OUTPUT queue, all that without stopping the
CAPTURE queue. With the behavior you described it wouldn't work,
because the OUTPUT format couldn't be changed.

I'd suggest making OUTPUT format changes not change the CAPTURE sizeimage.

Best regards,
Tomasz
