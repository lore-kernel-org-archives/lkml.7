Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8508C282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB3220850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="u1r+NHUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfDLUsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 16:48:00 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34132 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfDLUr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 16:47:59 -0400
Received: by mail-qt1-f193.google.com with SMTP id k2so12864436qtm.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 13:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=rnPjkfJa63fDV8fBFAPb0UNDar0RDNcjyqW9tTyIwUU=;
        b=u1r+NHUkIzcKufrsujplXVsO4g6mjk8RkLCslbyExnTNZTBl95XNqmXMC+SA1aOeJD
         hgV5WM0baF9lYH8f2yfPnxWWRYyl65Xp2FWQX4LKTiLkxF8/d7lvgerfXr3a4IQ0YJPN
         5luXNYfig69iZvW5BoZVw8oWAe5MAD3Oi0erYSL5U341WvcmY8M7rmII5s/G72J6wxtu
         3bJgEa45DnC3snao+uzJYYnGZrf2i2Dxiq3PLq+NfDaDNdhhza7lprXaogRcxFWfBExO
         /oqJXHGXWC8nLVKxhGj/EprFy7W2dKvF2duU9Edk3ury3E9T/VO3PY7bYm6NGZFOo+Ko
         VUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=rnPjkfJa63fDV8fBFAPb0UNDar0RDNcjyqW9tTyIwUU=;
        b=tHl6fep36Inl4kSXl6G6JDLDRhZjP3LyRkHZ/v53kJmxKHypXWYdlepcR+pD8teAHQ
         g2mlsxanCkuFxFEGuUbvGkkhJawrEGC3HBq2UHBtyVac71T4hTDApzhpXAlIZ7XljOHm
         l9BedvyMA0/QgA1UqTIzX2WSf4iBZMEA7FsWZ9f1nHg5v28I963RCLn8I/Z0VMIPZqpb
         XVxJnDYOs5rrnekTWXouOkgjEiajyldffal5/BHQAGerDhLpX0asOpguOvTfJmoZN2D8
         8EeujTk6Urxh4cMUChyceFQrjkWnLlsYETm7pIe1q4+LQ8Acne88lZDdlpRbN/87RM3+
         5quw==
X-Gm-Message-State: APjAAAV7wtGYSaHTZ4O144E1tz3vIoeNbM7lqO0EX81ea02j9gL9Nlhi
        DF5Fyn4jk2tszmFvzKXQeFMRNw==
X-Google-Smtp-Source: APXvYqyKy/9ynKRtEWlLcWHlfJiXa+knobYacb61bYxJXFzE/qeAuWFGV/AC2AmbpjUmHTd0EeaMOA==
X-Received: by 2002:a0c:99df:: with SMTP id y31mr47694340qve.171.1555102077921;
        Fri, 12 Apr 2019 13:47:57 -0700 (PDT)
Received: from tpx230-nicolas (modemcable154.55-37-24.static.videotron.ca. [24.37.55.154])
        by smtp.gmail.com with ESMTPSA id d205sm22751488qkg.66.2019.04.12.13.47.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 13:47:56 -0700 (PDT)
Message-ID: <371df0e4ec9e38d83d11171cbd98f19954cbf787.camel@ndufresne.ca>
Subject: Re: [PATCH v4] media: docs-rst: Document m2m stateless video
 decoder interface
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Alexandre Courbot <acourbot@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Dafna Hirschfeld <dafna3@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 12 Apr 2019 16:47:53 -0400
In-Reply-To: <20190306080019.159676-1-acourbot@chromium.org>
References: <20190306080019.159676-1-acourbot@chromium.org>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-9snnxKwTMomiZY8JtQm7"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9snnxKwTMomiZY8JtQm7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mercredi 06 mars 2019 =C3=A0 17:00 +0900, Alexandre Courbot a =C3=A9crit=
 :
> Documents the protocol that user-space should follow when
> communicating with stateless video decoders.
>=20
> The stateless video decoding API makes use of the new request and tags
> APIs. While it has been implemented with the Cedrus driver so far, it
> should probably still be considered staging for a short while.
>=20
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> ---
> Changes since v3:
>=20
> * Rephrased the conditions under which reference buffers must be queued
>   back (hopefully) more accurately.
>=20
>  Documentation/media/uapi/v4l/dev-mem2mem.rst  |   5 +
>  .../media/uapi/v4l/dev-stateless-decoder.rst  | 386 ++++++++++++++++++
>  2 files changed, 391 insertions(+)
>  create mode 100644 Documentation/media/uapi/v4l/dev-stateless-decoder.rs=
t
>=20
> diff --git a/Documentation/media/uapi/v4l/dev-mem2mem.rst b/Documentation=
/media/uapi/v4l/dev-mem2mem.rst
> index 67a980818dc8..db6f4efc458d 100644
> --- a/Documentation/media/uapi/v4l/dev-mem2mem.rst
> +++ b/Documentation/media/uapi/v4l/dev-mem2mem.rst
> @@ -13,6 +13,11 @@
>  Video Memory-To-Memory Interface
>  ********************************
> =20
> +.. toctree::
> +    :maxdepth: 1
> +
> +    dev-stateless-decoder
> +
>  A V4L2 memory-to-memory device can compress, decompress, transform, or
>  otherwise convert video data from one format into another format, in mem=
ory.
>  Such memory-to-memory devices set the ``V4L2_CAP_VIDEO_M2M`` or
> diff --git a/Documentation/media/uapi/v4l/dev-stateless-decoder.rst b/Doc=
umentation/media/uapi/v4l/dev-stateless-decoder.rst
> new file mode 100644
> index 000000000000..861fd2662886
> --- /dev/null
> +++ b/Documentation/media/uapi/v4l/dev-stateless-decoder.rst
> @@ -0,0 +1,386 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _stateless_decoder:
> +
> +**************************************************
> +Memory-to-memory Stateless Video Decoder Interface
> +**************************************************
> +
> +A stateless decoder is a decoder that works without retaining any kind o=
f state
> +between processed frames. This means that each frame is decoded independ=
ently
> +of any previous and future frames, and that the client is responsible fo=
r
> +maintaining the decoding state and providing it to the decoder with each
> +decoding request. This is in contrast to the stateful video decoder inte=
rface,
> +where the hardware and driver maintain the decoding state and all the cl=
ient
> +has to do is to provide the raw encoded stream and dequeue decoded frame=
s in
> +display order.
> +
> +This section describes how user-space ("the client") is expected to comm=
unicate
> +with stateless decoders in order to successfully decode an encoded strea=
m.
> +Compared to stateful codecs, the decoder/client sequence is simpler, but=
 the
> +cost of this simplicity is extra complexity in the client which must mai=
ntain a
> +consistent decoding state.
> +
> +Stateless decoders make use of the request API. A stateless decoder must=
 expose
> +the ``V4L2_BUF_CAP_SUPPORTS_REQUESTS`` capability on its ``OUTPUT`` queu=
e when
> +:c:func:`VIDIOC_REQBUFS` or :c:func:`VIDIOC_CREATE_BUFS` are invoked.
> +
> +Querying capabilities
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +1. To enumerate the set of coded formats supported by the decoder, the c=
lient
> +   calls :c:func:`VIDIOC_ENUM_FMT` on the ``OUTPUT`` queue.
> +
> +   * The driver must always return the full set of supported ``OUTPUT`` =
formats,
> +     irrespective of the format currently set on the ``CAPTURE`` queue.
> +
> +   * Simultaneously, the driver must restrain the set of values returned=
 by
> +     codec-specific capability controls (such as H.264 profiles) to the =
set
> +     actually supported by the hardware.
> +
> +2. To enumerate the set of supported raw formats, the client calls
> +   :c:func:`VIDIOC_ENUM_FMT` on the ``CAPTURE`` queue.
> +
> +   * The driver must return only the formats supported for the format cu=
rrently
> +     active on the ``OUTPUT`` queue.
> +
> +   * Depending on the currently set ``OUTPUT`` format, the set of suppor=
ted raw
> +     formats may depend on the value of some controls (e.g. parsed forma=
t
> +     headers) which are codec-dependent. The client is responsible for m=
aking
> +     sure that these controls are set before querying the ``CAPTURE`` qu=
eue.
> +     Failure to do so will result in the default values for these contro=
ls being
> +     used, and a returned set of formats that may not be usable for the =
media
> +     the client is trying to decode.
> +
> +3. The client may use :c:func:`VIDIOC_ENUM_FRAMESIZES` to detect support=
ed
> +   resolutions for a given format, passing desired pixel format in
> +   :c:type:`v4l2_frmsizeenum`'s ``pixel_format``.
> +
> +4. Supported profiles and levels for the current ``OUTPUT`` format, if
> +   applicable, may be queried using their respective controls via
> +   :c:func:`VIDIOC_QUERYCTRL`.
> +
> +Initialization
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +1. Set the coded format on the ``OUTPUT`` queue via :c:func:`VIDIOC_S_FM=
T`.
> +
> +   * **Required fields:**
> +
> +     ``type``
> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``.
> +
> +     ``pixelformat``
> +         a coded pixel format.
> +
> +     ``width``, ``height``
> +         coded width and height parsed from the stream.
> +
> +     other fields
> +         follow standard semantics.
> +
> +   .. note::
> +
> +      Changing the ``OUTPUT`` format may change the currently set ``CAPT=
URE``
> +      format. The driver will derive a new ``CAPTURE`` format from the
> +      ``OUTPUT`` format being set, including resolution, colorimetry
> +      parameters, etc. If the client needs a specific ``CAPTURE`` format=
,
> +      it must adjust it afterwards.
> +
> +2. Call :c:func:`VIDIOC_S_EXT_CTRLS` to set all the controls (parsed hea=
ders,
> +   etc.) required by the ``OUTPUT`` format to enumerate the ``CAPTURE`` =
formats.
> +
> +3. Call :c:func:`VIDIOC_G_FMT` for ``CAPTURE`` queue to get the format f=
or the
> +   destination buffers parsed/decoded from the bitstream.
> +
> +   * **Required fields:**
> +
> +     ``type``
> +         a ``V4L2_BUF_TYPE_*`` enum appropriate for ``CAPTURE``.
> +
> +   * **Returned fields:**
> +
> +     ``width``, ``height``
> +         frame buffer resolution for the decoded frames.
> +
> +     ``pixelformat``
> +         pixel format for decoded frames.
> +
> +     ``num_planes`` (for _MPLANE ``type`` only)
> +         number of planes for pixelformat.
> +
> +     ``sizeimage``, ``bytesperline``
> +         as per standard semantics; matching frame buffer format.
> +
> +   .. note::
> +
> +      The value of ``pixelformat`` may be any pixel format supported for=
 the
> +      ``OUTPUT`` format, based on the hardware capabilities. It is sugge=
sted
> +      that driver chooses the preferred/optimal format for the current
> +      configuration. For example, a YUV format may be preferred over an =
RGB
> +      format, if an additional conversion step would be required for RGB=
.
> +
> +4. *[optional]* Enumerate ``CAPTURE`` formats via :c:func:`VIDIOC_ENUM_F=
MT` on
> +   the ``CAPTURE`` queue. The client may use this ioctl to discover whic=
h
> +   alternative raw formats are supported for the current ``OUTPUT`` form=
at and
> +   select one of them via :c:func:`VIDIOC_S_FMT`.
> +
> +   .. note::
> +
> +      The driver will return only formats supported for the currently se=
lected
> +      ``OUTPUT`` format, even if more formats may be supported by the de=
coder in
> +      general.
> +
> +      For example, a decoder may support YUV and RGB formats for
> +      resolutions 1920x1088 and lower, but only YUV for higher resolutio=
ns (due
> +      to hardware limitations). After setting a resolution of 1920x1088 =
or lower
> +      as the ``OUTPUT`` format, :c:func:`VIDIOC_ENUM_FMT` may return a s=
et of
> +      YUV and RGB pixel formats, but after setting a resolution higher t=
han
> +      1920x1088, the driver will not return RGB pixel formats, since the=
y are
> +      unsupported for this resolution.
> +
> +5. *[optional]* Choose a different ``CAPTURE`` format than suggested via
> +   :c:func:`VIDIOC_S_FMT` on ``CAPTURE`` queue. It is possible for the c=
lient to
> +   choose a different format than selected/suggested by the driver in
> +   :c:func:`VIDIOC_G_FMT`.
> +
> +    * **Required fields:**
> +
> +      ``type``
> +          a ``V4L2_BUF_TYPE_*`` enum appropriate for ``CAPTURE``.
> +
> +      ``pixelformat``
> +          a raw pixel format.
> +
> +6. Allocate source (bitstream) buffers via :c:func:`VIDIOC_REQBUFS` on
> +   ``OUTPUT`` queue.
> +
> +    * **Required fields:**
> +
> +      ``count``
> +          requested number of buffers to allocate; greater than zero.
> +
> +      ``type``
> +          a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``.
> +
> +      ``memory``
> +          follows standard semantics.
> +
> +    * **Return fields:**
> +
> +      ``count``
> +          actual number of buffers allocated.
> +
> +    * If required, the driver will adjust ``count`` to be equal or bigge=
r to the
> +      minimum of required number of ``OUTPUT`` buffers for the given for=
mat and
> +      requested count. The client must check this value after the ioctl =
returns
> +      to get the actual number of buffers allocated.
> +
> +7. Allocate destination (raw format) buffers via :c:func:`VIDIOC_REQBUFS=
` on the
> +   ``CAPTURE`` queue.
> +
> +    * **Required fields:**
> +
> +      ``count``
> +          requested number of buffers to allocate; greater than zero. Th=
e client
> +          is responsible for deducing the minimum number of buffers requ=
ired
> +          for the stream to be properly decoded (taking e.g. reference f=
rames
> +          into account) and pass an equal or bigger number.
> +
> +      ``type``
> +          a ``V4L2_BUF_TYPE_*`` enum appropriate for ``CAPTURE``.
> +
> +      ``memory``
> +          follows standard semantics. ``V4L2_MEMORY_USERPTR`` is not sup=
ported
> +          for ``CAPTURE`` buffers.
> +
> +    * **Return fields:**
> +
> +      ``count``
> +          adjusted to allocated number of buffers, in case the codec req=
uires
> +          more buffers than requested.
> +
> +    * The driver must adjust count to the minimum of required number of
> +      ``CAPTURE`` buffers for the current format, stream configuration a=
nd
> +      requested count. The client must check this value after the ioctl
> +      returns to get the number of buffers allocated.
> +
> +8. Allocate requests (likely one per ``OUTPUT`` buffer) via
> +    :c:func:`MEDIA_IOC_REQUEST_ALLOC` on the media device.
> +
> +9. Start streaming on both ``OUTPUT`` and ``CAPTURE`` queues via
> +    :c:func:`VIDIOC_STREAMON`.
> +
> +Decoding
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +For each frame, the client is responsible for submitting at least one re=
quest to
> +which the following is attached:
> +
> +* The amount of encoded data expected by the codec for its current
> +  configuration, as a buffer submitted to the ``OUTPUT`` queue. Typicall=
y, this
> +  corresponds to one frame worth of encoded data, but some formats may a=
llow (or
> +  require) different amounts per unit.
> +* All the metadata needed to decode the submitted encoded data, in the f=
orm of
> +  controls relevant to the format being decoded.
> +
> +The amount and contents of the source ``OUTPUT`` buffer, as well as the =
controls
> +that must be set on the request, depend on the active coded pixel format=
 and
> +might be affected by codec-specific extended controls, as stated in
> +documentation of each format.

=46rom an IRC discussion with Paul and some more digging, I have found a
design problem in the decoding process.

In H264 and HEVC you can have multiple decoding unit per frames
(slices). This type of encoding is increasingly popular, specially for
low latency streaming use cases. The wording of this spec does allow
for the notion of decoding unit, and in practice it has been proven to
work through some RFC FFMPEG patches and the Cedrus driver. But
something important to know is that the FFMPEG RFC implements decoding
in lock steps. Which means:

  1. It queues a single free capture buffer
  2. It queues an output buffer, set controls, queue the request
  3. It waits for a capture buffer to reach state done
  4. It dequeues that capture buffer, and queue it back again
  5. And then it runs step 2,4,3 again with following slices, until we=20
     have a complete frame. After what, it restart at step 1

So the implementation makes no use of the queues. There is no batch
processing, so we might not be able to reach the maximum hardware
throughput.

So the optimal method would look like the following, but there comes
the design issue.

  1. Queue a single free capture buffer
  2. Queue output buffer for slice 1, set controls, queue the request
  3. Queue output buffer for slice 2, set controls, queue the request
  4. Wait for completion

The problem is in step 4. Completion means that the capture buffer done
decoding a single unit. So assuming the driver supports matching the
timestamp against the queued buffer, instead of waiting for a new
buffer, the driver would have to mark twice the same buffer to done
state, which is just not working to inform userspace that all slices
are decoded into the one capture buffer they share.

To me, multi slice encoded stream are just too common, and they will
also exist for AV1. So we really need a solution to this that does not
require operating in lock steps. Specially that some HW can decode
multiple slices in parallel (multi core), we would not want to prevent
that HW from being used efficiently. On top of this, we need a solution
so that we can also keep queuing slice of the following frames if they
arrive before decoding is done.

I don't have a solution yet myself, but it would be nice to come up
with something before we freeze this API. By the way, if we could queue
twice the same buffer, that would in principal work, but internally
there is only one state per buffer. If you do external allocation, then
in theory you could workaround that, but then it's ugly, because you'll
have two buffers with the same timestamp.

An argument that was made early was that we don't need to support this
right away because userspace can combine all the slices into one
buffer. But for H264_SLICE_RAW format it's inconvenient, you'd need an
extra control to tell the driver the offset to each slices, because the
raw H264 does not have enough information to be parsed. RAW slice are
also I believe de-emulated, which means the code use to prevent having
pattern looking like a start code has been removed, so you cannot just
prepend start codes. De-emulation seems better placed in userspace if
the HW does not take care.

I also very dislike the idea that we would enforce merging all slice
into the same buffer. The entire purpose of slices and the reason they
are used in practice is that you can start decoding slices before you
have all slices of a frame. This reduce drastically the latency for
streaming use cases, like video conferencing. So forcing the merging of
slices is basically like pretending slices have no benefits.

I have just exposed the problem I see for now, to see what comes up.
But I hope we be able to propose solution too in the short term (in no
one beats me at it).

> +
> +A typical frame would thus be decoded using the following sequence:
> +
> +1. Queue an ``OUTPUT`` buffer containing one unit of encoded bitstream d=
ata for
> +   the decoding request, using :c:func:`VIDIOC_QBUF`.
> +
> +    * **Required fields:**
> +
> +      ``index``
> +          index of the buffer being queued.
> +
> +      ``type``
> +          type of the buffer.
> +
> +      ``bytesused``
> +          number of bytes taken by the encoded data frame in the buffer.
> +
> +      ``flags``
> +          the ``V4L2_BUF_FLAG_REQUEST_FD`` flag must be set.
> +
> +      ``request_fd``
> +          must be set to the file descriptor of the decoding request.
> +
> +      ``timestamp``
> +          must be set to a unique value per frame. This value will be pr=
opagated
> +          into the decoded frame's buffer and can also be used to use th=
is frame
> +          as the reference of another.
> +
> +2. Set the codec-specific controls for the decoding request, using
> +   :c:func:`VIDIOC_S_EXT_CTRLS`.
> +
> +    * **Required fields:**
> +
> +      ``which``
> +          must be ``V4L2_CTRL_WHICH_REQUEST_VAL``.
> +
> +      ``request_fd``
> +          must be set to the file descriptor of the decoding request.
> +
> +      other fields
> +          other fields are set as usual when setting controls. The ``con=
trols``
> +          array must contain all the codec-specific controls required to=
 decode
> +          a frame.
> +
> +   .. note::
> +
> +      It is possible to specify the controls in different invocations of
> +      :c:func:`VIDIOC_S_EXT_CTRLS`, or to overwrite a previously set con=
trol, as
> +      long as ``request_fd`` and ``which`` are properly set. The control=
s state
> +      at the moment of request submission is the one that will be consid=
ered.
> +
> +   .. note::
> +
> +      The order in which steps 1 and 2 take place is interchangeable.
> +
> +3. Submit the request by invoking :c:func:`MEDIA_REQUEST_IOC_QUEUE` on t=
he
> +   request FD.
> +
> +    If the request is submitted without an ``OUTPUT`` buffer, or if some=
 of the
> +    required controls are missing from the request, then
> +    :c:func:`MEDIA_REQUEST_IOC_QUEUE` will return ``-ENOENT``. If more t=
han one
> +    ``OUTPUT`` buffer is queued, then it will return ``-EINVAL``.
> +    :c:func:`MEDIA_REQUEST_IOC_QUEUE` returning non-zero means that no
> +    ``CAPTURE`` buffer will be produced for this request.
> +
> +``CAPTURE`` buffers must not be part of the request, and are queued
> +independently. They are returned in decode order (i.e. the same order as=
 coded
> +frames were submitted to the ``OUTPUT`` queue).
> +
> +Runtime decoding errors are signaled by the dequeued ``CAPTURE`` buffers
> +carrying the ``V4L2_BUF_FLAG_ERROR`` flag. If a decoded reference frame =
has an
> +error, then all following decoded frames that refer to it also have the
> +``V4L2_BUF_FLAG_ERROR`` flag set, although the decoder will still try to
> +produce a (likely corrupted) frame.
> +
> +Buffer management while decoding
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +Contrary to stateful decoders, a stateless decoder does not perform any =
kind of
> +buffer management: it only guarantees that dequeued ``CAPTURE`` buffers =
can be
> +used by the client for as long as they are not queued again. "Used" here
> +encompasses using the buffer for compositing or display.
> +
> +A dequeued capture buffer can also be used as the reference frame of ano=
ther
> +buffer.
> +
> +A frame is specified as reference by converting its timestamp into nanos=
econds,
> +and storing it into the relevant member of a codec-dependent control str=
ucture.
> +The :c:func:`v4l2_timeval_to_ns` function must be used to perform that
> +conversion. The timestamp of a frame can be used to reference it as soon=
 as all
> +its units of encoded data are successfully submitted to the ``OUTPUT`` q=
ueue.
> +
> +A decoded buffer containing a reference frame must not be reused as a de=
coding
> +target until all the frames referencing it have been decoded. The safest=
 way to
> +achieve this is to refrain from queueing a reference buffer until all th=
e
> +decoded frames referencing it have been dequeued. However, if the driver=
 can
> +guarantee that buffer queued to the ``CAPTURE`` queue will be used in qu=
eued
> +order, then user-space can take advantage of this guarantee and queue a
> +reference buffer when the following conditions are met:
> +
> +1. All the requests for frames affected by the reference frame have been
> +   queued, and
> +
> +2. A sufficient number of ``CAPTURE`` buffers to cover all the decoded
> +   referencing frames have been queued.
> +
> +When queuing a decoding request, the driver will increase the reference =
count of
> +all the resources associated with reference frames. This means that the =
client
> +can e.g. close the DMABUF file descriptors of reference frame buffers if=
 it
> +won't need them afterwards.
> +
> +Seeking
> +=3D=3D=3D=3D=3D=3D=3D
> +In order to seek, the client just needs to submit requests using input b=
uffers
> +corresponding to the new stream position. It must however be aware that
> +resolution may have changed and follow the dynamic resolution change seq=
uence in
> +that case. Also depending on the codec used, picture parameters (e.g. SP=
S/PPS
> +for H.264) may have changed and the client is responsible for making sur=
e that a
> +valid state is sent to the decoder.
> +
> +The client is then free to ignore any returned ``CAPTURE`` buffer that c=
omes
> +from the pre-seek position.
> +
> +Pause
> +=3D=3D=3D=3D=3D
> +
> +In order to pause, the client can just cease queuing buffers onto the ``=
OUTPUT``
> +queue. Without source bitstream data, there is no data to process and th=
e codec
> +will remain idle.
> +
> +Dynamic resolution change
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +If the client detects a resolution change in the stream, it will need to=
 perform
> +the initialization sequence again with the new resolution:
> +
> +1. Wait until all submitted requests have completed and dequeue the
> +   corresponding output buffers.
> +
> +2. Call :c:func:`VIDIOC_STREAMOFF` on both the ``OUTPUT`` and ``CAPTURE`=
`
> +   queues.
> +
> +3. Free all ``CAPTURE`` buffers by calling :c:func:`VIDIOC_REQBUFS` on t=
he
> +   ``CAPTURE`` queue with a buffer count of zero.
> +
> +4. Perform the initialization sequence again (minus the allocation of
> +   ``OUTPUT`` buffers), with the new resolution set on the ``OUTPUT`` qu=
eue.
> +   Note that due to resolution constraints, a different format may need =
to be
> +   picked on the ``CAPTURE`` queue.
> +
> +Drain
> +=3D=3D=3D=3D=3D
> +
> +In order to drain the stream on a stateless decoder, the client just nee=
ds to
> +wait until all the submitted requests are completed. There is no need to=
 send a
> +``V4L2_DEC_CMD_STOP`` command since requests are processed sequentially =
by the
> +decoder.

--=-9snnxKwTMomiZY8JtQm7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSScpfJiL+hb5vvd45xUwItrAaoHAUCXLD5egAKCRBxUwItrAao
HBWcAJ9UaDg3bjGfXDsPL9MlMVVwJCcSkQCeK2bSl/LXVn3BRmI2T0bvw9BBDyg=
=TuZf
-----END PGP SIGNATURE-----

--=-9snnxKwTMomiZY8JtQm7--

