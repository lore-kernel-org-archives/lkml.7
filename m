Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C1AC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B0D20883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nyEXvxgr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfDHJX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:23:57 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41688 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfDHJX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:23:56 -0400
Received: by mail-oi1-f193.google.com with SMTP id v7so9931299oie.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 02:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WNoqinQd3BeX0WtX/sCdOPbiG9Apmei4/KJr3qQkFgY=;
        b=nyEXvxgrw/hcC6QnWyBwgV/2dDYGojBkhbyHHd+t5ZP4K2WkBu42qmgDxVokctabTj
         F9sqaKTvDMT2NfGtTE4974wmxSkYaHWX/GtHqmnil33Pqkx69B9kalELot3oTlykhE4t
         RwcLfNBuYOP8lQk7p02ew6Sf14Z4TNrzKK8Zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WNoqinQd3BeX0WtX/sCdOPbiG9Apmei4/KJr3qQkFgY=;
        b=LSG8D7Ka7WRjw6tPhVrdcDSbto8VAhaWyvFtm7RtHTUDvuV38bGhmtN5QyBoli4jBt
         k1oGbgGy3rB59uT/PTeLjbDJ2tsqzfJHJ1sHme1SpCqIFngVPc7TnlVZhwpjwpkEZZ7u
         PFdrlPKNq8uJBlCWgRFJk535OJVwKEhY3u2LL8XraMULV0X/lDO9YCO2GcOxizf0oW30
         YPMRaTPZkYyUSMAvSxVJrpXhe+HXjQ19oJ3CyQwXWRWfwyNc6PnFKKsBppaGY5JPKPYx
         VcOotijjHMnX6rOZ4ETrHWX4P0hXg2iV7rFU+FQN6Ocx3fI+p4s8sECtTfoMjz9cz027
         0/aA==
X-Gm-Message-State: APjAAAUPZtHZVyCCeM5gyCPJs96hewXmX+KWCCV/hpY0IRF02/ykxQLT
        SZfa9qWb1spaEfiy8nhLKNbOKfA9dyc=
X-Google-Smtp-Source: APXvYqyZvnS4t84S8TnGGeZU9CoSTwIsK5lbnwViHsH8r7JiG7RoXCvqDwhtb/tYnL+XLIT/WgGnWA==
X-Received: by 2002:aca:ed4e:: with SMTP id l75mr15445816oih.62.1554715434174;
        Mon, 08 Apr 2019 02:23:54 -0700 (PDT)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com. [209.85.210.49])
        by smtp.gmail.com with ESMTPSA id d70sm15737458oih.18.2019.04.08.02.23.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 02:23:53 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id j10so11380138otq.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 02:23:52 -0700 (PDT)
X-Received: by 2002:a9d:7749:: with SMTP id t9mr18871263otl.229.1554715432139;
 Mon, 08 Apr 2019 02:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190124100419.26492-1-tfiga@chromium.org> <20190124100419.26492-3-tfiga@chromium.org>
 <4bbe4ce4-615a-b981-0855-cd78c7a002d9@xs4all.nl> <471720b7-e304-271b-256d-a3dd394773c9@xs4all.nl>
 <CAAFQd5Au_=08pVom1z3C1nHKdKak8Y4d5odR6fiNB4urDhfjKQ@mail.gmail.com> <787ddc1f-388d-82be-2702-0d7d256f636c@xs4all.nl>
In-Reply-To: <787ddc1f-388d-82be-2702-0d7d256f636c@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 8 Apr 2019 18:23:40 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DozydYBpEceFTbJSutP+gwjxybpd1q6N1Vi+YragQT+w@mail.gmail.com>
Message-ID: <CAAFQd5DozydYBpEceFTbJSutP+gwjxybpd1q6N1Vi+YragQT+w@mail.gmail.com>
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

On Fri, Apr 5, 2019 at 7:03 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 4/5/19 10:12 AM, Tomasz Figa wrote:
> > On Thu, Mar 14, 2019 at 10:57 PM Hans Verkuil <hverkuil@xs4all.nl> wrot=
e:
> >>
> >> Hi Tomasz,
> >>
> >> Some more comments...
> >>
> >> On 1/29/19 2:52 PM, Hans Verkuil wrote:
> >>> Hi Tomasz,
> >>>
> >>> Some comments below. Nothing major, so I think a v4 should be ready t=
o be
> >>> merged.
> >>>
> >>> On 1/24/19 11:04 AM, Tomasz Figa wrote:
> >>>> Due to complexity of the video encoding process, the V4L2 drivers of
> >>>> stateful encoder hardware require specific sequences of V4L2 API cal=
ls
> >>>> to be followed. These include capability enumeration, initialization=
,
> >>>> encoding, encode parameters change, drain and reset.
> >>>>
> >>>> Specifics of the above have been discussed during Media Workshops at
> >>>> LinuxCon Europe 2012 in Barcelona and then later Embedded Linux
> >>>> Conference Europe 2014 in D=C3=BCsseldorf. The de facto Codec API th=
at
> >>>> originated at those events was later implemented by the drivers we a=
lready
> >>>> have merged in mainline, such as s5p-mfc or coda.
> >>>>
> >>>> The only thing missing was the real specification included as a part=
 of
> >>>> Linux Media documentation. Fix it now and document the encoder part =
of
> >>>> the Codec API.
> >>>>
> >>>> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> >>>> ---
> >>>>  Documentation/media/uapi/v4l/dev-encoder.rst  | 586 +++++++++++++++=
+++
> >>>>  Documentation/media/uapi/v4l/dev-mem2mem.rst  |   1 +
> >>>>  Documentation/media/uapi/v4l/pixfmt-v4l2.rst  |   5 +
> >>>>  Documentation/media/uapi/v4l/v4l2.rst         |   2 +
> >>>>  .../media/uapi/v4l/vidioc-encoder-cmd.rst     |  38 +-
> >>>>  5 files changed, 617 insertions(+), 15 deletions(-)
> >>>>  create mode 100644 Documentation/media/uapi/v4l/dev-encoder.rst
> >>>>
> >>>> diff --git a/Documentation/media/uapi/v4l/dev-encoder.rst b/Document=
ation/media/uapi/v4l/dev-encoder.rst
> >>>> new file mode 100644
> >>>> index 000000000000..fb8b05a132ee
> >>>> --- /dev/null
> >>>> +++ b/Documentation/media/uapi/v4l/dev-encoder.rst
> >>>> @@ -0,0 +1,586 @@
> >>>> +.. -*- coding: utf-8; mode: rst -*-
> >>>> +
> >>>> +.. _encoder:
> >>>> +
> >>>> +*************************************************
> >>>> +Memory-to-memory Stateful Video Encoder Interface
> >>>> +*************************************************
> >>>> +
> >>>> +A stateful video encoder takes raw video frames in display order an=
d encodes
> >>>> +them into a bitstream. It generates complete chunks of the bitstrea=
m, including
> >>>> +all metadata, headers, etc. The resulting bitstream does not requir=
e any
> >>>> +further post-processing by the client.
> >>>> +
> >>>> +Performing software stream processing, header generation etc. in th=
e driver
> >>>> +in order to support this interface is strongly discouraged. In case=
 such
> >>>> +operations are needed, use of the Stateless Video Encoder Interface=
 (in
> >>>> +development) is strongly advised.
> >>>> +
> >>>> +Conventions and notation used in this document
> >>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> +
> >>>> +1. The general V4L2 API rules apply if not specified in this docume=
nt
> >>>> +   otherwise.
> >>>> +
> >>>> +2. The meaning of words "must", "may", "should", etc. is as per `RF=
C
> >>>> +   2119 <https://tools.ietf.org/html/rfc2119>`_.
> >>>> +
> >>>> +3. All steps not marked "optional" are required.
> >>>> +
> >>>> +4. :c:func:`VIDIOC_G_EXT_CTRLS` and :c:func:`VIDIOC_S_EXT_CTRLS` ma=
y be used
> >>>> +   interchangeably with :c:func:`VIDIOC_G_CTRL` and :c:func:`VIDIOC=
_S_CTRL`,
> >>>> +   unless specified otherwise.
> >>>> +
> >>>> +5. Single-planar API (see :ref:`planar-apis`) and applicable struct=
ures may be
> >>>> +   used interchangeably with multi-planar API, unless specified oth=
erwise,
> >>>> +   depending on decoder capabilities and following the general V4L2=
 guidelines.
> >>>> +
> >>>> +6. i =3D [a..b]: sequence of integers from a to b, inclusive, i.e. =
i =3D
> >>>> +   [0..2]: i =3D 0, 1, 2.
> >>>> +
> >>>> +7. Given an ``OUTPUT`` buffer A, then A=E2=80=99 represents a buffe=
r on the ``CAPTURE``
> >>>> +   queue containing data that resulted from processing buffer A.
> >>>> +
> >>>> +Glossary
> >>>> +=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> +
> >>>> +Refer to :ref:`decoder-glossary`.
> >>>> +
> >>>> +State machine
> >>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> +
> >>>> +.. kernel-render:: DOT
> >>>> +   :alt: DOT digraph of encoder state machine
> >>>> +   :caption: Encoder state machine
> >>>> +
> >>>> +   digraph encoder_state_machine {
> >>>> +       node [shape =3D doublecircle, label=3D"Encoding"] Encoding;
> >>>> +
> >>>> +       node [shape =3D circle, label=3D"Initialization"] Initializa=
tion;
> >>>> +       node [shape =3D circle, label=3D"Stopped"] Stopped;
> >>>> +       node [shape =3D circle, label=3D"Drain"] Drain;
> >>>> +       node [shape =3D circle, label=3D"Reset"] Reset;
> >>>> +
> >>>> +       node [shape =3D point]; qi
> >>>> +       qi -> Initialization [ label =3D "open()" ];
> >>>> +
> >>>> +       Initialization -> Encoding [ label =3D "Both queues streamin=
g" ];
> >>>> +
> >>>> +       Encoding -> Drain [ label =3D "V4L2_DEC_CMD_STOP" ];
> >>>> +       Encoding -> Reset [ label =3D "VIDIOC_STREAMOFF(CAPTURE)" ];
> >>>> +       Encoding -> Stopped [ label =3D "VIDIOC_STREAMOFF(OUTPUT)" ]=
;
> >>>> +       Encoding -> Encoding;
> >>>> +
> >>>> +       Drain -> Stopped [ label =3D "All CAPTURE\nbuffers dequeued\=
nor\nVIDIOC_STREAMOFF(CAPTURE)" ];
> >>>> +       Drain -> Reset [ label =3D "VIDIOC_STREAMOFF(CAPTURE)" ];
> >>>> +
> >>>> +       Reset -> Encoding [ label =3D "VIDIOC_STREAMON(CAPTURE)" ];
> >>>> +       Reset -> Initialization [ label =3D "VIDIOC_REQBUFS(OUTPUT, =
0)" ];
> >>>> +
> >>>> +       Stopped -> Encoding [ label =3D "V4L2_DEC_CMD_START\nor\nVID=
IOC_STREAMON(OUTPUT)" ];
> >>>> +       Stopped -> Reset [ label =3D "VIDIOC_STREAMOFF(CAPTURE)" ];
> >>>> +   }
> >>>> +
> >>>> +Querying capabilities
> >>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> +
> >>>> +1. To enumerate the set of coded formats supported by the encoder, =
the
> >>>> +   client may call :c:func:`VIDIOC_ENUM_FMT` on ``CAPTURE``.
> >>>> +
> >>>> +   * The full set of supported formats will be returned, regardless=
 of the
> >>>> +     format set on ``OUTPUT``.
> >>>> +
> >>>> +2. To enumerate the set of supported raw formats, the client may ca=
ll
> >>>> +   :c:func:`VIDIOC_ENUM_FMT` on ``OUTPUT``.
> >>>> +
> >>>> +   * Only the formats supported for the format currently active on =
``CAPTURE``
> >>>> +     will be returned.
> >>>> +
> >>>> +   * In order to enumerate raw formats supported by a given coded f=
ormat,
> >>>> +     the client must first set that coded format on ``CAPTURE`` and=
 then
> >>>> +     enumerate the formats on ``OUTPUT``.
> >>>> +
> >>>> +3. The client may use :c:func:`VIDIOC_ENUM_FRAMESIZES` to detect su=
pported
> >>>> +   resolutions for a given format, passing desired pixel format in
> >>>> +   :c:type:`v4l2_frmsizeenum` ``pixel_format``.
> >>>> +
> >>>> +   * Values returned by :c:func:`VIDIOC_ENUM_FRAMESIZES` for a code=
d pixel
> >>>> +     format will include all possible coded resolutions supported b=
y the
> >>>> +     encoder for given coded pixel format.
> >>>> +
> >>>> +   * Values returned by :c:func:`VIDIOC_ENUM_FRAMESIZES` for a raw =
pixel format
> >>>> +     will include all possible frame buffer resolutions supported b=
y the
> >>>> +     encoder for given raw pixel format and coded format currently =
set on
> >>>> +     ``CAPTURE``.
> >>>> +
> >>>> +4. Supported profiles and levels for the coded format currently set=
 on
> >>>> +   ``CAPTURE``, if applicable, may be queried using their respectiv=
e controls
> >>>> +   via :c:func:`VIDIOC_QUERYCTRL`.
> >>>> +
> >>>> +5. Any additional encoder capabilities may be discovered by queryin=
g
> >>>> +   their respective controls.
> >>>> +
> >>>> +Initialization
> >>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> +
> >>>> +1. Set the coded format on the ``CAPTURE`` queue via :c:func:`VIDIO=
C_S_FMT`
> >>>> +
> >>>> +   * **Required fields:**
> >>>> +
> >>>> +     ``type``
> >>>> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``CAPTURE``
> >>>> +
> >>>> +     ``pixelformat``
> >>>> +         the coded format to be produced
> >>>> +
> >>>> +     ``sizeimage``
> >>>> +         desired size of ``CAPTURE`` buffers; the encoder may adjus=
t it to
> >>>> +         match hardware requirements
> >>>> +
> >>>> +     ``width``, ``height``
> >>>> +         ignored (always zero)
> >>>> +
> >>>> +     other fields
> >>>> +         follow standard semantics
> >>>> +
> >>>> +   * **Return fields:**
> >>>> +
> >>>> +     ``sizeimage``
> >>>> +         adjusted size of ``CAPTURE`` buffers
> >>>> +
> >>>> +   .. important::
> >>>> +
> >>>> +      Changing the ``CAPTURE`` format may change the currently set =
``OUTPUT``
> >>>> +      format. The encoder will derive a new ``OUTPUT`` format from =
the
> >>>> +      ``CAPTURE`` format being set, including resolution, colorimet=
ry
> >>>> +      parameters, etc. If the client needs a specific ``OUTPUT`` fo=
rmat, it
> >>>> +      must adjust it afterwards.
> >>>
> >>> Hmm, "including resolution": if width and height are set to 0, what s=
hould the
> >>> OUTPUT resolution be? Up to the driver? I think this should be clarif=
ied since
> >>> at a first reading of this paragraph it appears to be contradictory.
> >>
> >> I think the driver should just return the width and height of the OUTP=
UT
> >> format. So the width and height that userspace specifies is just ignor=
ed
> >> and replaced by the width and height of the OUTPUT format. After all, =
that's
> >> what the bitstream will encode. Returning 0 for width and height would=
 make
> >> this a strange exception in V4L2 and I want to avoid that.
> >>
> >
> > Hmm, however, the width and height of the OUTPUT format is not what's
> > actually encoded in the bitstream. The right selection rectangle
> > determines that.
> >
> > In one of the previous versions I though we could put the codec

s/codec/coded/...

> > resolution as the width and height of the CAPTURE format, which would
> > be the resolution of the encoded image rounded up to full macroblocks
> > +/- some encoder-specific constraints. AFAIR there was some concern
> > about OUTPUT format changes triggering CAPTURE format changes, but to
> > be honest, I'm not sure if that's really a problem. I just decided to
> > drop that for the simplicity.
>
> I'm not sure what your point is.
>
> The OUTPUT format has the coded resolution,

That's not always true. The OUTPUT format is just the format of the
source frame buffers. In special cases where the source resolution is
nicely aligned, it would be the same as coded size, but the remaining
cases are valid as well.

> so when you set the
> CAPTURE format it can just copy the OUTPUT coded resolution unless the
> chosen CAPTURE pixelformat can't handle that in which case both the
> OUTPUT and CAPTURE coded resolutions are clamped to whatever is the maxim=
um
> or minimum the codec is capable of.

As per my comment above, generally speaking, the encoder will derive
an appropriate coded format from the OUTPUT format, but also other
factors, like the crop rectangles and possibly some internal
constraints.

>
> That said, I am fine with just leaving it up to the driver as suggested
> before. Just as long as both the CAPTURE and OUTPUT formats remain valid
> (i.e. width and height may never be out of range).
>

Sounds good to me.

> >
> >>>
> >>>> +
> >>>> +2. **Optional.** Enumerate supported ``OUTPUT`` formats (raw format=
s for
> >>>> +   source) for the selected coded format via :c:func:`VIDIOC_ENUM_F=
MT`.
> >>>> +
> >>>> +   * **Required fields:**
> >>>> +
> >>>> +     ``type``
> >>>> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
> >>>> +
> >>>> +     other fields
> >>>> +         follow standard semantics
> >>>> +
> >>>> +   * **Return fields:**
> >>>> +
> >>>> +     ``pixelformat``
> >>>> +         raw format supported for the coded format currently select=
ed on
> >>>> +         the ``CAPTURE`` queue.
> >>>> +
> >>>> +     other fields
> >>>> +         follow standard semantics
> >>>> +
> >>>> +3. Set the raw source format on the ``OUTPUT`` queue via
> >>>> +   :c:func:`VIDIOC_S_FMT`.
> >>>> +
> >>>> +   * **Required fields:**
> >>>> +
> >>>> +     ``type``
> >>>> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
> >>>> +
> >>>> +     ``pixelformat``
> >>>> +         raw format of the source
> >>>> +
> >>>> +     ``width``, ``height``
> >>>> +         source resolution
> >>>> +
> >>>> +     other fields
> >>>> +         follow standard semantics
> >>>> +
> >>>> +   * **Return fields:**
> >>>> +
> >>>> +     ``width``, ``height``
> >>>> +         may be adjusted by encoder to match alignment requirements=
, as
> >>>> +         required by the currently selected formats
> >>>
> >>> What if the width x height is larger than the maximum supported by th=
e
> >>> selected coded format? This should probably mention that in that case=
 the
> >>> width x height is reduced to the largest allowed value. Also mention =
that
> >>> this maximum is reported by VIDIOC_ENUM_FRAMESIZES.
> >>>
> >>>> +
> >>>> +     other fields
> >>>> +         follow standard semantics
> >>>> +
> >>>> +   * Setting the source resolution will reset the selection rectang=
les to their
> >>>> +     default values, based on the new resolution, as described in t=
he step 5
> >>>
> >>> 5 -> 4
> >>>
> >>> Or just say: "as described in the next step."
> >>>
> >>>> +     below.
> >>
> >> It should also be made explicit that:
> >>
> >> 1) the crop rectangle will be set to the given width and height *befor=
e*
> >> it is being adjusted by S_FMT.
> >>
> >
> > I don't think that's what we want here.
> >
> > Defining the default rectangle to be exactly the same as the OUTPUT
> > resolution (after the adjustment) makes the semantics consistent - not
> > setting the crop rectangle gives you exactly the behavior as if there
> > was no cropping involved (or supported by the encoder).
>
> I think you are right. This seems to be what the coda driver does as well=
.
> It is convenient to be able to just set a 1920x1080 format and have that
> resolution be stored as the crop rectangle, since it avoids having to cal=
l
> s_selection afterwards, but it is not really consistent with the way V4L2
> works.
>
> >
> >> Open question: should we support a compose rectangle for the CAPTURE t=
hat
> >> is the same as the OUTPUT crop rectangle? I.e. the CAPTURE format cont=
ains
> >> the adjusted width and height and the compose rectangle (read-only) co=
ntains
> >> the visible width and height. It's not strictly necessary, but it is
> >> symmetrical.
> >
> > Wouldn't it rather be the CAPTURE crop rectangle that would be of the
> > same resolution of the OUTPUT compose rectangle? Then you could
> > actually have the CAPTURE compose rectangle for putting that into the
> > desired rectangle of the encoded stream, if the encoder supports that.
> > (I don't know any that does, so probably out of concern for now.)
>
> Yes, you are right.
>
> But should we support this?
>
> I actually think not for this initial version. It can be added later, I g=
uess.
>

I think it boils down on whether adding it later wouldn't
significantly complicate the application logic. It also relates to my
other comment somewhere below.

> >
> >>
> >> 2) the CAPTURE format will be updated as well with the new OUTPUT widt=
h and
> >> height. The CAPTURE sizeimage might change as well.
> >>
> >>>> +
> >>>> +4. **Optional.** Set the visible resolution for the stream metadata=
 via
> >>>> +   :c:func:`VIDIOC_S_SELECTION` on the ``OUTPUT`` queue.
> >>
> >> I think you should mention that this is only necessary if the crop rec=
tangle
> >> that is set when you set the format isn't what you want.
> >>
> >
> > Ack.
> >
> >>>> +
> >>>> +   * **Required fields:**
> >>>> +
> >>>> +     ``type``
> >>>> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``
> >>>> +
> >>>> +     ``target``
> >>>> +         set to ``V4L2_SEL_TGT_CROP``
> >>>> +
> >>>> +     ``r.left``, ``r.top``, ``r.width``, ``r.height``
> >>>> +         visible rectangle; this must fit within the `V4L2_SEL_TGT_=
CROP_BOUNDS`
> >>>> +         rectangle and may be subject to adjustment to match codec =
and
> >>>> +         hardware constraints
> >>>> +
> >>>> +   * **Return fields:**
> >>>> +
> >>>> +     ``r.left``, ``r.top``, ``r.width``, ``r.height``
> >>>> +         visible rectangle adjusted by the encoder
> >>>> +
> >>>> +   * The following selection targets are supported on ``OUTPUT``:
> >>>> +
> >>>> +     ``V4L2_SEL_TGT_CROP_BOUNDS``
> >>>> +         equal to the full source frame, matching the active ``OUTP=
UT``
> >>>> +         format
> >>>> +
> >>>> +     ``V4L2_SEL_TGT_CROP_DEFAULT``
> >>>> +         equal to ``V4L2_SEL_TGT_CROP_BOUNDS``
> >>>> +
> >>>> +     ``V4L2_SEL_TGT_CROP``
> >>>> +         rectangle within the source buffer to be encoded into the
> >>>> +         ``CAPTURE`` stream; defaults to ``V4L2_SEL_TGT_CROP_DEFAUL=
T``
> >>>> +
> >>>> +         .. note::
> >>>> +
> >>>> +            A common use case for this selection target is encoding=
 a source
> >>>> +            video with a resolution that is not a multiple of a mac=
roblock,
> >>>> +            e.g.  the common 1920x1080 resolution may require the s=
ource
> >>>> +            buffers to be aligned to 1920x1088 for codecs with 16x1=
6 macroblock
> >>>> +            size. To avoid encoding the padding, the client needs t=
o explicitly
> >>>> +            configure this selection target to 1920x1080.
> >>
> >> This last sentence contradicts the proposed behavior of S_FMT(OUTPUT).
> >>
> >
> > Sorry, which part exactly and what part of the proposal exactly? :)
> > (My comment above might be related, though.)
>
> Ignore my comment. We go back to explicitly requiring userspace to set th=
e OUTPUT
> crop selection target, so this note remains valid.
>

Ack.

> >
> >>>> +
> >>>> +     ``V4L2_SEL_TGT_COMPOSE_BOUNDS``
> >>>> +         maximum rectangle within the coded resolution, which the c=
ropped
> >>>> +         source frame can be composed into; if the hardware does no=
t support
> >>>> +         composition or scaling, then this is always equal to the r=
ectangle of
> >>>> +         width and height matching ``V4L2_SEL_TGT_CROP`` and locate=
d at (0, 0)
> >>>> +
> >>>> +     ``V4L2_SEL_TGT_COMPOSE_DEFAULT``
> >>>> +         equal to a rectangle of width and height matching
> >>>> +         ``V4L2_SEL_TGT_CROP`` and located at (0, 0)
> >>>> +
> >>>> +     ``V4L2_SEL_TGT_COMPOSE``
> >>>> +         rectangle within the coded frame, which the cropped source=
 frame
> >>>> +         is to be composed into; defaults to
> >>>> +         ``V4L2_SEL_TGT_COMPOSE_DEFAULT``; read-only on hardware wi=
thout
> >>>> +         additional compose/scaling capabilities; resulting stream =
will
> >>>> +         have this rectangle encoded as the visible rectangle in it=
s
> >>>> +         metadata
> >>
> >> I think the compose targets for OUTPUT are only needed if the hardware=
 can
> >> actually do scaling and/or composition. Otherwise they can (must?) be
> >> dropped.
> >>
> >
> > Note that V4L2_SEL_TGT_COMPOSE is defined to be the way for the
> > userspace to learn the target visible rectangle that's going to be
> > encoded in the stream metadata. If we omit it, we wouldn't have a way
> > that would be consistent between encoders that can do
> > scaling/composition and those that can't.
>
> I'm not convinced about this. The standard API behavior is not to expose
> functionality that the hardware can't do. So if scaling isn't possible on
> the OUTPUT side, then it shouldn't expose OUTPUT compose rectangles.
>
> I also believe it very unlikely that we'll see encoders capable of scalin=
g
> as it doesn't make much sense.

It does make a lot of sense - WebRTC requires 3 different sizes of the
stream to be encoded at the same time. However, unfortunately, I
haven't yet seen an encoder capable of doing so.

> I would prefer to drop this to simplify the
> spec, and when we get encoders that can scale, then we can add support fo=
r
> compose rectangles (and I'm sure we'll need to think about how that
> influences the CAPTURE side as well).
>
> For encoders without scaling it is the OUTPUT crop rectangle that defines
> the visible rectangle.
>
> >
> > However, with your proposal of actually having selection rectangles
> > for the CAPTURE queue, it could be solved indeed. The OUTPUT queue
> > would expose a varying set of rectangles, depending on the hardware
> > capability, while the CAPTURE queue would always expose its rectangle
> > with that information.
>
> I think we should keep it simple and only define selection rectangles
> when really needed.
>
> So encoders support CROP on the OUTPUT, and decoders support CAPTURE
> COMPOSE (may be read-only). Nothing else.
>
> Once support for scaling is needed (either on the encoder or decoder
> side), then the spec should be enhanced. But I prefer to postpone that
> until we actually have hardware that needs this.
>

Okay, let's do it this way then. Actually, I don't even think there is
much value in exposing information internal to the bitstream metadata
like this, similarly to the coded size. My intention was to just
ensure that we can easily add scaling/composing functionality later.

I just removed the COMPOSE rectangles from my next draft.

[snip]
> >
> >>
> >> Changing the OUTPUT format will always fail if OUTPUT buffers are alre=
ady allocated,
> >> or if changing the OUTPUT format would change the CAPTURE format (size=
image in
> >> particular) and CAPTURE buffers were already allocated and are too sma=
ll.
> >
> > The OUTPUT format must not change the CAPTURE format by definition.
> > Otherwise we end up in a situation where we can't commit, because both
> > queue formats can affect each other. Any change to the OUTPUT format
> > that wouldn't work with the current CAPTURE format should be adjusted
> > by the driver to match the current CAPTURE format.
>
> But the CAPTURE format *does* depend on the OUTPUT format: if the output
> resolution changes, then so does the CAPTURE resolution and esp. the
> sizeimage value, since that is typically resolution dependent.
>
> The coda driver does this as well: changing the output resolution
> will update the capture resolution and sizeimage. The vicodec driver does=
 the
> same.
>
> Setting the CAPTURE format basically just selects the codec to use, after
> that you can set the OUTPUT format and read the updated CAPTURE format to
> get the new sizeimage value. In fact, setting the CAPTURE format shouldn'=
t
> change the OUTPUT format, unless the OUTPUT format is incompatible with t=
he
> newly selected codec.

Let me think about it for a while.

Best regards,
Tomasz
