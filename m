Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067D3C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF356217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="wYDJdhrq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732835AbfDQQXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:23:00 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39330 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbfDQQW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:22:58 -0400
Received: by mail-qt1-f196.google.com with SMTP id t28so28038022qte.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 09:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=9kncwrNB2z8eCWiFb02DPYu5pmTN/NXfqpv5q51+SWM=;
        b=wYDJdhrqPssqXIbL9sy60chQ1LV/SvIs+x04Hm0CRpciKrJO/nVxeYgqy/kmfsT4zE
         lSZZWDwxbahJMRhxsfoZ5ctKP2/8wIDXkfmfATguu7AuiUs+a3wKZP0tbrI0ga3HDLtW
         M0z1QCrFhETbbI95P9YSxWIfICZQpg1HXi50pnArYbRW55wx0tforU+YyEHe+y3SVH2R
         QsPVjRHVPxEdb+nfcGYe5PURfudOsr8bhuk9PP6QqH1uoVa1HnK65CWdHNcfTH7LVNOE
         q0dQMi2+4ilG1Ea6AwYp5ixh3TyhVEBubwUdDRHN7MCj67aajhSL5JtvB7u46iv1uRM1
         f5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=9kncwrNB2z8eCWiFb02DPYu5pmTN/NXfqpv5q51+SWM=;
        b=HgmpcwzxB79wJuivsB2W2sfpCu1kDJrTLfIy+ZRsvWFRsYV6fcIFKG9OcVywVCae2N
         4XlLAlvWNLUfs5lDbea2+KSq0ibWfDEpxf7G1AW6Xey+E5sHC09S9GPeTtSFw+w5CUCE
         kW9yfg2SbUkuh21ZcJa5GfR/2a6QGP6nbUnBNPtov55YOlOhykWfe2D29CT2UuTUUpaP
         UeuxoFSrE99nSBXcjl5qixs9ZnN8dGteWfc+J13UVsEeIZTU8SA3UU61KOuDehz1kalK
         uF41ebdmJjjkT0DOlKRzOMdNQOpuAjF8FJW7gxpJGrZaR7gHLNPCaZO8O3O3sUplWcvW
         PHzg==
X-Gm-Message-State: APjAAAUi+r5yWwoGkbUYyjJARWoGugoH2oeCSe9oLKCaGqaz0MGeir4B
        FabQwp5QZba4amaGZD+sBvuleQ==
X-Google-Smtp-Source: APXvYqy204Ma2vh5Z2IF3nmnjHZA9d+I0nMSKfIGAKXJuxaHoo0RK1OfgcC9iEeHwCwoHt+VpRI6Kw==
X-Received: by 2002:ac8:72d3:: with SMTP id o19mr69227815qtp.274.1555518176601;
        Wed, 17 Apr 2019 09:22:56 -0700 (PDT)
Received: from tpx230-nicolas.collaboramtl (modemcable154.55-37-24.static.videotron.ca. [24.37.55.154])
        by smtp.gmail.com with ESMTPSA id y34sm35717335qta.96.2019.04.17.09.22.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 09:22:55 -0700 (PDT)
Message-ID: <adb19869042a1d151c2828bd6f54def064f375bb.camel@ndufresne.ca>
Subject: Re: [PATCH v4] media: docs-rst: Document m2m stateless video
 decoder interface
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Dafna Hirschfeld <dafna3@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 17 Apr 2019 12:22:52 -0400
In-Reply-To: <2de76e9b61c79cefbcd89ce60f115d0fb98e89e4.camel@bootlin.com>
References: <20190306080019.159676-1-acourbot@chromium.org>
         <371df0e4ec9e38d83d11171cbd98f19954cbf787.camel@ndufresne.ca>
         <da5aa9ab957923a72e30b169a3c242c4fe6260f1.camel@bootlin.com>
         <c1d9ca7ed7f64b3255cb66918c70b752e5a7c3ba.camel@ndufresne.ca>
         <2de76e9b61c79cefbcd89ce60f115d0fb98e89e4.camel@bootlin.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-gHnw4KDUfjQfXFpU+zha"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gHnw4KDUfjQfXFpU+zha
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mercredi 17 avril 2019 =C3=A0 17:40 +0200, Paul Kocialkowski a =C3=A9cri=
t :
> Hi,
>=20
> On Wed, 2019-04-17 at 11:30 -0400, Nicolas Dufresne wrote:
> > Le dimanche 14 avril 2019 =C3=A0 18:41 +0200, Paul Kocialkowski a =C3=
=A9crit :
> > > Hi,
> > >=20
> > > Le vendredi 12 avril 2019 =C3=A0 16:47 -0400, Nicolas Dufresne a =C3=
=A9crit :
> > > > Le mercredi 06 mars 2019 =C3=A0 17:00 +0900, Alexandre Courbot a =
=C3=A9crit :
> > > > > Documents the protocol that user-space should follow when
> > > > > communicating with stateless video decoders.
> > > > >=20
> > > > > The stateless video decoding API makes use of the new request and=
 tags
> > > > > APIs. While it has been implemented with the Cedrus driver so far=
, it
> > > > > should probably still be considered staging for a short while.
> > >=20
> > > [...]
> > >=20
> > > > From an IRC discussion with Paul and some more digging, I have foun=
d a
> > > > design problem in the decoding process.
> > > >=20
> > > > In H264 and HEVC you can have multiple decoding unit per frames
> > > > (slices). This type of encoding is increasingly popular, specially =
for
> > > > low latency streaming use cases. The wording of this spec does allo=
w
> > > > for the notion of decoding unit, and in practice it has been proven=
 to
> > > > work through some RFC FFMPEG patches and the Cedrus driver. But
> > > > something important to know is that the FFMPEG RFC implements decod=
ing
> > > > in lock steps. Which means:
> > > >=20
> > > >   1. It queues a single free capture buffer
> > > >   2. It queues an output buffer, set controls, queue the request
> > > >   3. It waits for a capture buffer to reach state done
> > > >   4. It dequeues that capture buffer, and queue it back again
> > > >   5. And then it runs step 2,4,3 again with following slices, until=
 we=20
> > > >      have a complete frame. After what, it restart at step 1
> > > >=20
> > > > So the implementation makes no use of the queues. There is no batch
> > > > processing, so we might not be able to reach the maximum hardware
> > > > throughput.
> > > >=20
> > > > So the optimal method would look like the following, but there come=
s
> > > > the design issue.
> > > >=20
> > > >   1. Queue a single free capture buffer
> > > >   2. Queue output buffer for slice 1, set controls, queue the reque=
st
> > > >   3. Queue output buffer for slice 2, set controls, queue the reque=
st
> > > >   4. Wait for completion
> > > >=20
> > > > The problem is in step 4. Completion means that the capture buffer =
done
> > > > decoding a single unit. So assuming the driver supports matching th=
e
> > > > timestamp against the queued buffer, instead of waiting for a new
> > > > buffer, the driver would have to mark twice the same buffer to done
> > > > state, which is just not working to inform userspace that all slice=
s
> > > > are decoded into the one capture buffer they share.
> > >=20
> > > Interestingly, I'm experiencing the exact same problem dealing with a
> > > 2D graphics blitter that has limited ouput scaling abilities which
> > > imply handlnig a large scaling operation as multiple clipped smaller
> > > scaling operations. The issue is basically that multiple jobs have to
> > > be submitted to complete a single frame and relying on an indication
> > > from the destination buffer (such as a fence) doesn't work to indicat=
e
> > > that all the operations were completed, since we get the indication a=
t
> > > each step instead of at the end of the batch.
> >=20
> > That looks similar to the IMX.6 IPU m2m driver. It splits the image in
> > tiles of 1024x1024 and process each tile separately. This driver has
> > been around for a long time, so I guess they have a solution to that.
> > They don't need requests, because there is nothing to be bundled with
> > the input image. I know that Renesas folks have started working on a
> > de-interlacer. Again, this kind of driver may process and reuse input
> > buffers for motion compensation, but I don't think they need special
> > userspace API for that.
>=20
> Thanks for the reference! I hope it's not a blitter that was
> contributed as a V4L2 driver instead of DRM, as it probably would be
> more useful in DRM (but that's way beside the point).

DRM does not offer a generic and discoverable interface for these
accelerators. Note that these drivers have most of the time started as
DRM driver and their DRM side where dropped. That was the case for
Exynos drivers at least.

The thing is that DRM is great if you do immediate display stuff, while
V4L2 is nice if you do streaming, where you expect filling queued, and
popping buffers from queues.

In the end, this is just an interface, nothing prevents you from making
an internal driver (like the Meson Canvas) and simply letting multiple
sub-system expose it. Specially that some of these IP will often
support both signal and memory processing, so they equally fit into a
media controller ISP, a v4l2 m2m or a DRM driver.

Another driver you might want to look is Rockchip RGA driver (which is
a multi function IP, including blitting).

>=20
> > > One idea I see to solve this is to have a notion of batch in the driv=
er
> > > (for our situation, that would be in v4l2) and provide means to get a
> > > done indication for that entity.
> >=20
> > Can't you just make this part of your driver state machine ?
>=20
> Yes definitely, and I forgot to mention that's in DRM, not V4L2.
>=20
> Anyway from that point on, I was back to talking about our codec
> situation, not my 2D blitter anymore :)
>=20
> > > I think we could extend the request API to allow this. We already
> > > represent requests as individual file descriptors, we could totally
> > > group requests in batches and get a sync fd for the batch to poll on
> > > when we need to return the frames. It would be good if we could expos=
e
> > > this in a way that makes it work with DRM as an in fence for display.
> > > Then we can pretty much schedule our flip + decoding together (which =
is
> > > quite nice to have when we're running late on the decoding side).
> > >=20
> > > What do you think?
> >=20
> > I'm not sure why this specific thing needs a userspace exposition.
>=20
> Indeed, I'll handle it in my 2D driver.
>=20
> Cheers,
>=20
> Paul
>=20
> > > It feels to me like the request API was designed to open up the way f=
or
> > > these kinds of improvements, so I'm sure we can find an agreeable
> > > solution that extends the API.
> > >=20
> > > > To me, multi slice encoded stream are just too common, and they wil=
l
> > > > also exist for AV1. So we really need a solution to this that does =
not
> > > > require operating in lock steps. Specially that some HW can decode
> > > > multiple slices in parallel (multi core), we would not want to prev=
ent
> > > > that HW from being used efficiently. On top of this, we need a solu=
tion
> > > > so that we can also keep queuing slice of the following frames if t=
hey
> > > > arrive before decoding is done.
> > >=20
> > > Agreed.
> > >=20
> > > > I don't have a solution yet myself, but it would be nice to come up
> > > > with something before we freeze this API.
> > >=20
> > > I think it's rather independent from the codec used and this is
> > > something that should be handled at the request API level.=20
> > >=20
> > > I'm not sure we can always expect the hardware to be able to operate =
on
> > > a per-slice basis. I think it would be useful to reflect this in the
> > > pixel format, so that we also have a possibility for a gathered slice
> > > buffer (as the spec currently mentions for mpeg-2) for legacy decoder
> > > hardware that will need to decode one frame in one go from a contiguo=
us
> > > buffer with all the slice data appended.
> > >=20
> > > This updates my pixel format proposition from IRC to the following:
> > > - V4L2_PIXFMT_H264_SLICE_APPENDED: single buffer for all the slices
> > > (appended buffer), slice params as v4l2 control (legacy);
> > >=20
> > > - V4L2_PIXFMT_H264_SLICE: one buffer/slice, slice params as control;
> > >=20
> > > - V4L2_PIXFMT_H264_SLICE_ANNEX_B: one buffer/slice in annex-b format,=
=20
> > > slice params encoded in the buffer;
> > >=20
> > > - V4L2_PIXFMT_H264_SLICE_MIXED: one buffer/slice in annex-b format,
> > > slice params encoded in the buffer and in slice params control;
> > >=20
> > > Also, we need to make sure to have a per-slice bit offset to the
> > > encoded data in the slice params control so that the same slice buffe=
r
> > > can be used with any of the _SLICE formats (e.g. ffmpeg would only ha=
ve
> > > an annex-b slice and use any of the formats with it).
> > >=20
> > > For the legacy format, we need to specify that the appended slices
> > > don't repeat the annex-b start code and NAL header.
> > >=20
> > > What do you think?
> > >=20
> > > >  By the way, if we could queue
> > > > twice the same buffer, that would in principal work, but internally
> > > > there is only one state per buffer. If you do external allocation, =
then
> > > > in theory you could workaround that, but then it's ugly, because yo=
u'll
> > > > have two buffers with the same timestamp.
> > >=20
> > > One advantage of the request API is that buffers are actually queued
> > > when the request is processed, so this might not be too problematic.
> > >=20
> > > I think what we need boils down to:
> > > - Being able to queue the same output buffer to multiple requests,
> > > which the request API should already allow;
> > > - Being able to grab the right capture buffer based on the output
> > > timestamp so that the different requests for the slices are rendered =
to
> > > the same destination buffer.
> > >=20
> > > For the second point, I don't really have a clear idea of whether we
> > > can already expect v4l2 to allow picking a buffer that was marked don=
e
> > > but was not de-queued by userspace yet. It might already be allowed a=
nd
> > > we could just implement something to lookup the buffer to grab by
> > > timestamp.
> > >=20
> > > > An argument that was made early was that we don't need to support t=
his
> > > > right away because userspace can combine all the slices into one
> > > > buffer. But for H264_SLICE_RAW format it's inconvenient, you'd need=
 an
> > > > extra control to tell the driver the offset to each slices, because=
 the
> > > > raw H264 does not have enough information to be parsed. RAW slice a=
re
> > > > also I believe de-emulated, which means the code use to prevent hav=
ing
> > > > pattern looking like a start code has been removed, so you cannot j=
ust
> > > > prepend start codes. De-emulation seems better placed in userspace =
if
> > > > the HW does not take care.
> > >=20
> > > Mhh I'd like to avoid having having to specify the offset to each sli=
ce
> > > for the legacy case. Just appending the encoded data (excluding slice
> > > header and start code) works for cedrus and I think it makes sense mo=
re
> > > generally. The idea is to only expose a single slice params and act a=
s
> > > if it was just one big slice buffer.
> > >=20
> > > Come to think of it, maybe we need annex-b and mixed fashions of that
> > > legacy pixfmt too...
> > >=20
> > > > I also very dislike the idea that we would enforce merging all slic=
e
> > > > into the same buffer. The entire purpose of slices and the reason t=
hey
> > > > are used in practice is that you can start decoding slices before y=
ou
> > > > have all slices of a frame. This reduce drastically the latency for
> > > > streaming use cases, like video conferencing. So forcing the mergin=
g of
> > > > slices is basically like pretending slices have no benefits.
> > >=20
> > > Of course, we don't want things to stay like this and this rework is
> > > definitely needed to get serious performance and latency going.
> > >=20
> > > One thing you should also be aware of: we're currently using a
> > > workqueue between the job done irq and scheduling the next frame (in
> > > v4l2 m2m).
> > >=20
> > > Maybe we could manage to fit that into an atomic path to schedule the
> > > next request in the previous job done irq context.
> > >=20
> > > > I have just exposed the problem I see for now, to see what comes up=
.
> > > > But I hope we be able to propose solution too in the short term (in=
 no
> > > > one beats me at it).
> > >=20
> > > Seems that we have good grounds for a discussion!
> > >=20
> > > Cheers,
> > >=20
> > > Paul
> > >=20
> > > > > +
> > > > > +A typical frame would thus be decoded using the following sequen=
ce:
> > > > > +
> > > > > +1. Queue an ``OUTPUT`` buffer containing one unit of encoded bit=
stream data for
> > > > > +   the decoding request, using :c:func:`VIDIOC_QBUF`.
> > > > > +
> > > > > +    * **Required fields:**
> > > > > +
> > > > > +      ``index``
> > > > > +          index of the buffer being queued.
> > > > > +
> > > > > +      ``type``
> > > > > +          type of the buffer.
> > > > > +
> > > > > +      ``bytesused``
> > > > > +          number of bytes taken by the encoded data frame in the=
 buffer.
> > > > > +
> > > > > +      ``flags``
> > > > > +          the ``V4L2_BUF_FLAG_REQUEST_FD`` flag must be set.
> > > > > +
> > > > > +      ``request_fd``
> > > > > +          must be set to the file descriptor of the decoding req=
uest.
> > > > > +
> > > > > +      ``timestamp``
> > > > > +          must be set to a unique value per frame. This value wi=
ll be propagated
> > > > > +          into the decoded frame's buffer and can also be used t=
o use this frame
> > > > > +          as the reference of another.
> > > > > +
> > > > > +2. Set the codec-specific controls for the decoding request, usi=
ng
> > > > > +   :c:func:`VIDIOC_S_EXT_CTRLS`.
> > > > > +
> > > > > +    * **Required fields:**
> > > > > +
> > > > > +      ``which``
> > > > > +          must be ``V4L2_CTRL_WHICH_REQUEST_VAL``.
> > > > > +
> > > > > +      ``request_fd``
> > > > > +          must be set to the file descriptor of the decoding req=
uest.
> > > > > +
> > > > > +      other fields
> > > > > +          other fields are set as usual when setting controls. T=
he ``controls``
> > > > > +          array must contain all the codec-specific controls req=
uired to decode
> > > > > +          a frame.
> > > > > +
> > > > > +   .. note::
> > > > > +
> > > > > +      It is possible to specify the controls in different invoca=
tions of
> > > > > +      :c:func:`VIDIOC_S_EXT_CTRLS`, or to overwrite a previously=
 set control, as
> > > > > +      long as ``request_fd`` and ``which`` are properly set. The=
 controls state
> > > > > +      at the moment of request submission is the one that will b=
e considered.
> > > > > +
> > > > > +   .. note::
> > > > > +
> > > > > +      The order in which steps 1 and 2 take place is interchange=
able.
> > > > > +
> > > > > +3. Submit the request by invoking :c:func:`MEDIA_REQUEST_IOC_QUE=
UE` on the
> > > > > +   request FD.
> > > > > +
> > > > > +    If the request is submitted without an ``OUTPUT`` buffer, or=
 if some of the
> > > > > +    required controls are missing from the request, then
> > > > > +    :c:func:`MEDIA_REQUEST_IOC_QUEUE` will return ``-ENOENT``. I=
f more than one
> > > > > +    ``OUTPUT`` buffer is queued, then it will return ``-EINVAL``=
.
> > > > > +    :c:func:`MEDIA_REQUEST_IOC_QUEUE` returning non-zero means t=
hat no
> > > > > +    ``CAPTURE`` buffer will be produced for this request.
> > > > > +
> > > > > +``CAPTURE`` buffers must not be part of the request, and are que=
ued
> > > > > +independently. They are returned in decode order (i.e. the same =
order as coded
> > > > > +frames were submitted to the ``OUTPUT`` queue).
> > > > > +
> > > > > +Runtime decoding errors are signaled by the dequeued ``CAPTURE``=
 buffers
> > > > > +carrying the ``V4L2_BUF_FLAG_ERROR`` flag. If a decoded referenc=
e frame has an
> > > > > +error, then all following decoded frames that refer to it also h=
ave the
> > > > > +``V4L2_BUF_FLAG_ERROR`` flag set, although the decoder will stil=
l try to
> > > > > +produce a (likely corrupted) frame.
> > > > > +
> > > > > +Buffer management while decoding
> > > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > +Contrary to stateful decoders, a stateless decoder does not perf=
orm any kind of
> > > > > +buffer management: it only guarantees that dequeued ``CAPTURE`` =
buffers can be
> > > > > +used by the client for as long as they are not queued again. "Us=
ed" here
> > > > > +encompasses using the buffer for compositing or display.
> > > > > +
> > > > > +A dequeued capture buffer can also be used as the reference fram=
e of another
> > > > > +buffer.
> > > > > +
> > > > > +A frame is specified as reference by converting its timestamp in=
to nanoseconds,
> > > > > +and storing it into the relevant member of a codec-dependent con=
trol structure.
> > > > > +The :c:func:`v4l2_timeval_to_ns` function must be used to perfor=
m that
> > > > > +conversion. The timestamp of a frame can be used to reference it=
 as soon as all
> > > > > +its units of encoded data are successfully submitted to the ``OU=
TPUT`` queue.
> > > > > +
> > > > > +A decoded buffer containing a reference frame must not be reused=
 as a decoding
> > > > > +target until all the frames referencing it have been decoded. Th=
e safest way to
> > > > > +achieve this is to refrain from queueing a reference buffer unti=
l all the
> > > > > +decoded frames referencing it have been dequeued. However, if th=
e driver can
> > > > > +guarantee that buffer queued to the ``CAPTURE`` queue will be us=
ed in queued
> > > > > +order, then user-space can take advantage of this guarantee and =
queue a
> > > > > +reference buffer when the following conditions are met:
> > > > > +
> > > > > +1. All the requests for frames affected by the reference frame h=
ave been
> > > > > +   queued, and
> > > > > +
> > > > > +2. A sufficient number of ``CAPTURE`` buffers to cover all the d=
ecoded
> > > > > +   referencing frames have been queued.
> > > > > +
> > > > > +When queuing a decoding request, the driver will increase the re=
ference count of
> > > > > +all the resources associated with reference frames. This means t=
hat the client
> > > > > +can e.g. close the DMABUF file descriptors of reference frame bu=
ffers if it
> > > > > +won't need them afterwards.
> > > > > +
> > > > > +Seeking
> > > > > +=3D=3D=3D=3D=3D=3D=3D
> > > > > +In order to seek, the client just needs to submit requests using=
 input buffers
> > > > > +corresponding to the new stream position. It must however be awa=
re that
> > > > > +resolution may have changed and follow the dynamic resolution ch=
ange sequence in
> > > > > +that case. Also depending on the codec used, picture parameters =
(e.g. SPS/PPS
> > > > > +for H.264) may have changed and the client is responsible for ma=
king sure that a
> > > > > +valid state is sent to the decoder.
> > > > > +
> > > > > +The client is then free to ignore any returned ``CAPTURE`` buffe=
r that comes
> > > > > +from the pre-seek position.
> > > > > +
> > > > > +Pause
> > > > > +=3D=3D=3D=3D=3D
> > > > > +
> > > > > +In order to pause, the client can just cease queuing buffers ont=
o the ``OUTPUT``
> > > > > +queue. Without source bitstream data, there is no data to proces=
s and the codec
> > > > > +will remain idle.
> > > > > +
> > > > > +Dynamic resolution change
> > > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > > > > +
> > > > > +If the client detects a resolution change in the stream, it will=
 need to perform
> > > > > +the initialization sequence again with the new resolution:
> > > > > +
> > > > > +1. Wait until all submitted requests have completed and dequeue =
the
> > > > > +   corresponding output buffers.
> > > > > +
> > > > > +2. Call :c:func:`VIDIOC_STREAMOFF` on both the ``OUTPUT`` and ``=
CAPTURE``
> > > > > +   queues.
> > > > > +
> > > > > +3. Free all ``CAPTURE`` buffers by calling :c:func:`VIDIOC_REQBU=
FS` on the
> > > > > +   ``CAPTURE`` queue with a buffer count of zero.
> > > > > +
> > > > > +4. Perform the initialization sequence again (minus the allocati=
on of
> > > > > +   ``OUTPUT`` buffers), with the new resolution set on the ``OUT=
PUT`` queue.
> > > > > +   Note that due to resolution constraints, a different format m=
ay need to be
> > > > > +   picked on the ``CAPTURE`` queue.
> > > > > +
> > > > > +Drain
> > > > > +=3D=3D=3D=3D=3D
> > > > > +
> > > > > +In order to drain the stream on a stateless decoder, the client =
just needs to
> > > > > +wait until all the submitted requests are completed. There is no=
 need to send a
> > > > > +``V4L2_DEC_CMD_STOP`` command since requests are processed seque=
ntially by the
> > > > > +decoder.

--=-gHnw4KDUfjQfXFpU+zha
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSScpfJiL+hb5vvd45xUwItrAaoHAUCXLdS3AAKCRBxUwItrAao
HMVLAJ9YyTdwiMpEiU5vNvtLEv1PNNKC6QCgsvxrCFRMwe3mks89jkTuLjqmZpE=
=Hstc
-----END PGP SIGNATURE-----

--=-gHnw4KDUfjQfXFpU+zha--

