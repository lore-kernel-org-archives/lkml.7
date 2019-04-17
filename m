Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1829C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516E02173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="j1/A4hny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732830AbfDQQRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:17:37 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34089 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729512AbfDQQRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:17:35 -0400
Received: by mail-qk1-f196.google.com with SMTP id n68so14702993qka.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 09:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=v8ELoZRl7UqLzoGpmPfJSv1DeLEB7trJ0AXIZA4ffJg=;
        b=j1/A4hnyM5RUxj2Q4dzUrxcX9sRtBwNeYI/JpOb4DwLTh2RPDd/xn4yAAHr6/5fTIz
         PZmx9pUeNJWqC4+zc0c0TOjZsRxniD4SFIHA160Pyh1OC6PT+siQivlmC+uS8ODbZXEM
         cvNDhCInRghAYSiC4k1kpcMoCngjA2LtUXHOsxqdWyxt/Cy/1DzrpPAsPtzxlA2mCYub
         YXeOIzZIpJiljRzc8b0wp35vemIjGYTLrOQaANjUsPZ0ufHo+fXYrNKr4lWlnBhONvry
         QvDdV+yjQr4L16oeuQesjA+BhxT+raU/NUw2PYf7ymh0s/5J3/JzOlZquhzOC6Dcz/B/
         0m8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=v8ELoZRl7UqLzoGpmPfJSv1DeLEB7trJ0AXIZA4ffJg=;
        b=i9r2lH3ENwd0XBIoDwWdWxGKK1IB7hJ/LPjf+5goiL7Sm5jpxSi/kcz4UNAnS4EUNP
         n6ZXh8S5/R/tF8axxJmmaY6pIIhYm1dl55t+AWOB0awTe9aok80XODb4vi5I/1rQKIKT
         R18vaHFWIPmZA8Lk7wOcvD4VLEBQ93INedc4POOEhocisMR/+Hv/5jFqqftoBTWOAbiL
         FHqQYkipWenT8hDhAJB4DRTtJ4VeAZbqnbX0WqPpI0eZz5+c/DmhQfGXrivagXK39Lzy
         mgzdHkoGxARHPXI6XjO/SONFdwPOxbk/S9HV7xzU1Y0h9FOV72pOCLQbdK619jQ/qwCE
         H+bA==
X-Gm-Message-State: APjAAAU71dFqswiE8+CJpqJCkUarXdbyPSZHl23Q9fp/utwnLmZaSkMX
        XyBbZlqkuUZgCvAul1u3YSj4aQ==
X-Google-Smtp-Source: APXvYqzhnd2IJYq1Q4kRcixooCC5ICn92ENAccWIZ6UHO4arA3M8Wpoqr3MRXqzk2lKMuRXxrxMwDg==
X-Received: by 2002:ae9:f442:: with SMTP id z2mr66833801qkl.172.1555517853023;
        Wed, 17 Apr 2019 09:17:33 -0700 (PDT)
Received: from tpx230-nicolas.collaboramtl (modemcable154.55-37-24.static.videotron.ca. [24.37.55.154])
        by smtp.gmail.com with ESMTPSA id s41sm30754034qta.72.2019.04.17.09.17.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 09:17:31 -0700 (PDT)
Message-ID: <ec607c4917cd205f69de9a19c13a2109ff602477.camel@ndufresne.ca>
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
Date:   Wed, 17 Apr 2019 12:17:29 -0400
In-Reply-To: <f4561d1b89464341b66b87af90f0d47a5b093b57.camel@bootlin.com>
References: <20190306080019.159676-1-acourbot@chromium.org>
         <371df0e4ec9e38d83d11171cbd98f19954cbf787.camel@ndufresne.ca>
         <da5aa9ab957923a72e30b169a3c242c4fe6260f1.camel@bootlin.com>
         <c07703459c7e48904bd7fd83be1e675c70eee83c.camel@ndufresne.ca>
         <d81d0112b99feba0a1899f3722077a4aeec9860c.camel@bootlin.com>
         <439b7f57aa3ba2b2ed5b043f961ef87cb83912af.camel@ndufresne.ca>
         <59e23c5ca5bfbadf9441ea06da2e9b9b5898c6d7.camel@bootlin.com>
         <0b495143bb260cf9f8927ee541e7f001842ac5c3.camel@ndufresne.ca>
         <f4561d1b89464341b66b87af90f0d47a5b093b57.camel@bootlin.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-9WIvxzhmOSxUCak9W+5t"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9WIvxzhmOSxUCak9W+5t
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mardi 16 avril 2019 =C3=A0 09:37 +0200, Paul Kocialkowski a =C3=A9crit :
> Hi,
>=20
> Le lundi 15 avril 2019 =C3=A0 11:30 -0400, Nicolas Dufresne a =C3=A9crit =
:
> > Le lundi 15 avril 2019 =C3=A0 15:26 +0200, Paul Kocialkowski a =C3=A9cr=
it :
> > > Hi,
> > >=20
> > > On Mon, 2019-04-15 at 08:24 -0400, Nicolas Dufresne wrote:
> > > > Le lundi 15 avril 2019 =C3=A0 09:58 +0200, Paul Kocialkowski a =C3=
=A9crit :
> > > > > Hi,
> > > > >=20
> > > > > On Sun, 2019-04-14 at 18:38 -0400, Nicolas Dufresne wrote:
> > > > > > Le dimanche 14 avril 2019 =C3=A0 18:41 +0200, Paul Kocialkowski=
 a =C3=A9crit :
> > > > > > > Hi,
> > > > > > >=20
> > > > > > > Le vendredi 12 avril 2019 =C3=A0 16:47 -0400, Nicolas Dufresn=
e a =C3=A9crit :
> > > > > > > > Le mercredi 06 mars 2019 =C3=A0 17:00 +0900, Alexandre Cour=
bot a =C3=A9crit :
> > > > > > > > > Documents the protocol that user-space should follow when
> > > > > > > > > communicating with stateless video decoders.
> > > > > > > > >=20
> > > > > > > > > The stateless video decoding API makes use of the new req=
uest and tags
> > > > > > > > > APIs. While it has been implemented with the Cedrus drive=
r so far, it
> > > > > > > > > should probably still be considered staging for a short w=
hile.
> > > > > > >=20
> > > > > > > [...]
> > > > > > >=20
> > > > > > > > From an IRC discussion with Paul and some more digging, I h=
ave found a
> > > > > > > > design problem in the decoding process.
> > > > > > > >=20
> > > > > > > > In H264 and HEVC you can have multiple decoding unit per fr=
ames
> > > > > > > > (slices). This type of encoding is increasingly popular, sp=
ecially for
> > > > > > > > low latency streaming use cases. The wording of this spec d=
oes allow
> > > > > > > > for the notion of decoding unit, and in practice it has bee=
n proven to
> > > > > > > > work through some RFC FFMPEG patches and the Cedrus driver.=
 But
> > > > > > > > something important to know is that the FFMPEG RFC implemen=
ts decoding
> > > > > > > > in lock steps. Which means:
> > > > > > > >=20
> > > > > > > >   1. It queues a single free capture buffer
> > > > > > > >   2. It queues an output buffer, set controls, queue the re=
quest
> > > > > > > >   3. It waits for a capture buffer to reach state done
> > > > > > > >   4. It dequeues that capture buffer, and queue it back aga=
in
> > > > > > > >   5. And then it runs step 2,4,3 again with following slice=
s, until we=20
> > > > > > > >      have a complete frame. After what, it restart at step =
1
> > > > > > > >=20
> > > > > > > > So the implementation makes no use of the queues. There is =
no batch
> > > > > > > > processing, so we might not be able to reach the maximum ha=
rdware
> > > > > > > > throughput.
> > > > > > > >=20
> > > > > > > > So the optimal method would look like the following, but th=
ere comes
> > > > > > > > the design issue.
> > > > > > > >=20
> > > > > > > >   1. Queue a single free capture buffer
> > > > > > > >   2. Queue output buffer for slice 1, set controls, queue t=
he request
> > > > > > > >   3. Queue output buffer for slice 2, set controls, queue t=
he request
> > > > > > > >   4. Wait for completion
> > > > > > > >=20
> > > > > > > > The problem is in step 4. Completion means that the capture=
 buffer done
> > > > > > > > decoding a single unit. So assuming the driver supports mat=
ching the
> > > > > > > > timestamp against the queued buffer, instead of waiting for=
 a new
> > > > > > > > buffer, the driver would have to mark twice the same buffer=
 to done
> > > > > > > > state, which is just not working to inform userspace that a=
ll slices
> > > > > > > > are decoded into the one capture buffer they share.
> > > > > > >=20
> > > > > > > Interestingly, I'm experiencing the exact same problem dealin=
g with a
> > > > > > > 2D graphics blitter that has limited ouput scaling abilities =
which
> > > > > > > imply handlnig a large scaling operation as multiple clipped =
smaller
> > > > > > > scaling operations. The issue is basically that multiple jobs=
 have to
> > > > > > > be submitted to complete a single frame and relying on an ind=
ication
> > > > > > > from the destination buffer (such as a fence) doesn't work to=
 indicate
> > > > > > > that all the operations were completed, since we get the indi=
cation at
> > > > > > > each step instead of at the end of the batch.
> > > > > > >=20
> > > > > > > One idea I see to solve this is to have a notion of batch in =
the driver
> > > > > > > (for our situation, that would be in v4l2) and provide means =
to get a
> > > > > > > done indication for that entity.
> > > > > > >=20
> > > > > > > I think we could extend the request API to allow this. We alr=
eady
> > > > > > > represent requests as individual file descriptors, we could t=
otally
> > > > > > > group requests in batches and get a sync fd for the batch to =
poll on
> > > > > > > when we need to return the frames. It would be good if we cou=
ld expose
> > > > > > > this in a way that makes it work with DRM as an in fence for =
display.
> > > > > > > Then we can pretty much schedule our flip + decoding together=
 (which is
> > > > > > > quite nice to have when we're running late on the decoding si=
de).
> > > > > > >=20
> > > > > > > What do you think?
> > > > > > >=20
> > > > > > > It feels to me like the request API was designed to open up t=
he way for
> > > > > > > these kinds of improvements, so I'm sure we can find an agree=
able
> > > > > > > solution that extends the API.
> > > > > > >=20
> > > > > > > > To me, multi slice encoded stream are just too common, and =
they will
> > > > > > > > also exist for AV1. So we really need a solution to this th=
at does not
> > > > > > > > require operating in lock steps. Specially that some HW can=
 decode
> > > > > > > > multiple slices in parallel (multi core), we would not want=
 to prevent
> > > > > > > > that HW from being used efficiently. On top of this, we nee=
d a solution
> > > > > > > > so that we can also keep queuing slice of the following fra=
mes if they
> > > > > > > > arrive before decoding is done.
> > > > > > >=20
> > > > > > > Agreed.
> > > > > > >=20
> > > > > > > > I don't have a solution yet myself, but it would be nice to=
 come up
> > > > > > > > with something before we freeze this API.
> > > > > > >=20
> > > > > > > I think it's rather independent from the codec used and this =
is
> > > > > > > something that should be handled at the request API level.=
=20
> > > > > > >=20
> > > > > > > I'm not sure we can always expect the hardware to be able to =
operate on
> > > > > > > a per-slice basis. I think it would be useful to reflect this=
 in the
> > > > > > > pixel format, so that we also have a possibility for a gather=
ed slice
> > > > > > > buffer (as the spec currently mentions for mpeg-2) for legacy=
 decoder
> > > > > > > hardware that will need to decode one frame in one go from a =
contiguous
> > > > > > > buffer with all the slice data appended.
> > > > > > >=20
> > > > > > > This updates my pixel format proposition from IRC to the foll=
owing:
> > > > > > > - V4L2_PIXFMT_H264_SLICE_APPENDED: single buffer for all the =
slices
> > > > > > > (appended buffer), slice params as v4l2 control (legacy);
> > > > > >=20
> > > > > > SLICE_RAW_APPENDED ? Or FRAMED_SLICES_RAW ? You would need a ne=
w
> > > > > > control for the NAL index, as there is no way to figure-out oth=
erwise.
> > > > > > I would not add this format unless a specific HW need it.
> > > > >=20
> > > > > I don't really like using "raw" as a distinguisher: I don't think=
 it's
> > > > > explicit enough. The idea here is to reflect that there is only o=
ne
> > > > > slice exposed, which is the appended result of all the frame slic=
es
> > > > > with a single v4l2 control.
> > > >=20
> > > > RAW in this context was suggested to reflect the fact there is no
> > > > header, no slice header and that emulation prevention bytes has bee=
n
> > > > removed and replaces by the real values.
> > >=20
> > > That could also be understood as "slice params coded raw", which is t=
he
> > > opposite of what it describes, hence my reluctance.
> > >=20
> > > > Just SLICE alone was much worst.
> > >=20
> > > Keep in mind that we already have a MPEG2_SLICE format in the public
> > > API. We should probably decide what it should become based on the
> > > outcome of this discussion.
> > >=20
> > > >  There is to many properties to this type of H264 buffer to
> > > > encode everything into the name, so what will really matter in the =
end
> > > > if the documentation. Feel free to propose a better name.
> > >=20
> > > Agreed, it's a side point. I always find it hard to find naming good,
> > > as well as finding good naming (my suggestions aren't really top-notc=
h
> > > either).
> > >=20
> > > Here is another proposition:
> > > - SLICE_PARSED
> > > - SLICE_ANNEX_B
> > > - SLICE_PARSED_ANNEX_B
> >=20
> > Ok, we'll keep working on that then, naming is hard. I guess by PARSED
> > you meant that the slice headers are passed as controls, and that
> > indeed make sense.
>=20
> Yep, that's right.
>=20
> > But I really thought all stateless decoder would required that. A
> > hard bet obviously.
>=20
> Well, I think that's a debate on its own. A strict interpretation of
> stateless could be that the decoder does not internally keep track of
> the reference frames and any frame can be decoded at any time (at the
> condition that the reference frames data is around). This doesn't have
> to be correlated with whether the decoder will take the slice header in
> raw or parsed format, after all.
>=20
> Note that in cedrus, our decoder still has some state, but we get to
> decide where that state is stored, which makes the whole thing
> stateless  since we can bring the state we need dynamically without
> involving the hardware.

In general, we say stateless from a HW point of view. It simply means
that the HW (the accelerator) can be multiplexed to process several
independent streams. While with stateful firmware, you generally can't
save the state, and ends up with a specific number of concurrent stream
(scheduling happens in the firmware). There is exception to that of
course, the newest Amlogic/Meson video decoder allow for saving the
decoder state. The registers are undocumented, since they are filled by
the HW parser, but it's separated in a way that we could multiplex.

Of course we do have a state in our drivers. Each time you open an m2m
device, you create an new instance which will keep track of done jobs,
pending jobs, active format, allocated memory, etc.

>=20
> > > > > > > - V4L2_PIXFMT_H264_SLICE: one buffer/slice, slice params as c=
ontrol;
> > > > > > >=20
> > > > > > > - V4L2_PIXFMT_H264_SLICE_ANNEX_B: one buffer/slice in annex-b=
 format,=20
> > > > > > > slice params encoded in the buffer;
> > > > > >=20
> > > > > > We are still working on this one, this format will be used by R=
ockchip
> > > > > > driver for sure, but this needs clarification and maybe a renam=
e if
> > > > > > it's not just one slice per buffer.
> > > > >=20
> > > > > I thought the decoder also needed the parse slice data? At least =
IIRC
> > > > > for Tegra, we need Annex-B format and a parsed slice header (so t=
he
> > > > > next one).
> > > >=20
> > > > Yes, in every cases, the HW will parse the slice data.
> > >=20
> > > Ah sorry, I meant "need the parsed slice data" (missed the d), as in,
> > > some decoders will need annex-b format but won't parse the slice head=
er
> > > on their own, so they also need the parsed slice header control.
> > > Don't ask why...
> > >=20
> > > In my proposition from above, that would be: SLICE_PARSED_ANNEX_B.
> > >=20
> > > >  It's possible
> > > > that Tegra have a matching format as Rockchip, someone would need t=
o do
> > > > a proper integration to verify. But the driver does not need the
> > > > following one, that is specific to ANNEX-B parsing.
> > > >=20
> > > > > > > - V4L2_PIXFMT_H264_SLICE_MIXED: one buffer/slice in annex-b f=
ormat,
> > > > > > > slice params encoded in the buffer and in slice params contro=
l;
> > > > > > >=20
> > > > > > > Also, we need to make sure to have a per-slice bit offset to =
the
> > > > > > > encoded data in the slice params control so that the same sli=
ce buffer
> > > > > > > can be used with any of the _SLICE formats (e.g. ffmpeg would=
 only have
> > > > > > > an annex-b slice and use any of the formats with it).
> > > > > >=20
> > > > > > Ah, I we are saying the same.
> > > > > >=20
> > > > > > > For the legacy format, we need to specify that the appended s=
lices
> > > > > > > don't repeat the annex-b start code and NAL header.
> > > > > >=20
> > > > > > I'm not sure this one make sense. the NAL header for each slice=
s of one
> > > > > > frames are not always identical.
> > > > >=20
> > > > > Yes but that's pretty much the point of the legacy format: to onl=
y
> > > > > expose a single slice buffer and slice header (even in cases wher=
e the
> > > > > bitstream codes them in multiple distinct ones).
> > > > >=20
> > > > > We can't expect this to work in every case, that's why it's a leg=
acy
> > > > > format. It seems to work pretty well for cedrus so far.
> > > >=20
> > > > I'm not sure I follow you, what Cedrus does should be changed to
> > > > whatever we decide as a final API, we should not maintain two forma=
ts.
> > >=20
> > > That point has me hesitating. It depends on whether we can expect to
> > > see hardware implementations with no support whatsoever for multi-sli=
ce=20
> > > per frame and just expect an aggregated buffer of slice compressed
> > > data. This is one operation mode that the Allwinner VPU supports.
> > >=20
> > > The point is not to use it in Cedrus since our VPU can operate per-
> > > slice, but to allow supporting hardware decoders that can't do that i=
n
> > > the future.
> > >=20
> > > I'm not sure it's healthy to make it a hard requirement for H.264
> > > decoding to operate per-slice. Does that seem too far-fetched from yo=
ur
> > > perspective? I seem to recall from a discussion that some legacy
> > > hardware only handles single-slices frames, but I may be wrong.
> > >=20
> > > > Also, what works for Cedrus is that a each buffers must have a sing=
le
> > > > slice regardless how many slices per frame. And this is what I expe=
ct
> > > > from most stateless HW.
> > >=20
> > > Currently, we append all the slices into one buffer and decode it in
> > > one go with a slightly hacked slice params to reflect that. But of
> > > course, we should be operating per-slice.
> > >=20
> > > >  This is how it works in VAAPI and VDPAU as an
> > > > example. Just for the reference, the API in VAAPI is (pseudo code, =
I
> > > > can't remember the exact name):
> > > >=20
> > > >    - beginPicture()
> > > >    - decodeSlice() *
> > > >    - endPicture()
> > > >=20
> > > > So the accelerator is told explicitly when a frame start/end, but a=
lso
> > > > it's told explicitly in which buffer to decode the frame to.
> > >=20
> > > Yes definitely. We're also given all the parsed bitstream elements in
> > > the right order so that we could already start queuing requests when
> > > each slice is passed, and just wait for completion at endPicture.
> > >=20
> > > > > We could also decide to ditch the legacy idea altogether and only
> > > > > specify formats that operate on a per-slice basis, but I'm afraid=
 we'll
> > > > > find decoders that can only take a single slice per buffer.
> > > >=20
> > > > It's impossible for a compliant decoder to only support 1 slice per
> > > > frame, so I don't follow you on this one. Also, I don't understand =
what
> > > > difference you see between per-slice basis and single slice per buf=
fer.
> > >=20
> > > Okay that's exactly what I wanted to know: whether it makes any sense
> > > to build a decoder that only operates per-frame and not per-slice.
> > > If you are confident we won't see that in the wild, we can make it an
> > > API requirement to operate per-slice.
> >=20
> > There is probably a small distinction to make between supporting
> > multiple slices per frame and operating per slice. It's nice to know
> > that Cedrus support both. As we discussed today on IRC, if we introduce
> > a flag that tells the driver when the last slice of a frame is passed,
> > it would be relatively simple for the driver to do decide what to do.
> > Of course if the HW have a limitation of one allocation, it might not
> > be fully optimal as it would have to copy.
> >=20
> > But as this is stateless decoder, I'm more inclined in introducing a
> > format that means just that, leaving it to userspace to do that right
> > packing.
> >=20
> > > > > When decoding a multi-slice frame in that setup, I think we'll be
> > > > > better off with an appended buffer containing all the slices for =
the
> > > > > frame instead of passing only a the first slice.
> > > >=20
> > > > Appended slices requires extra controls, but also introduce a lot m=
ore
> > > > decoding latency. As soon as we add the missing frame boundary
> > > > signalling, it should be really trivial for a driver to wait until =
it
> > > > received all slices before starting the decoding if that is a HW
> > > > requirement.
> > >=20
> > > Well, I don't really like the idea of the driver being aware of any o=
f
> > > that (IMO the logic should be in the media core, not the driver).
> > >=20
> > > If a driver can't do multiple slices, it shouldn't be up to the drive=
r
> > > to gather them together. But anyway, if you think we won't ever see
> > > this kind of hardware, we can just drop the whole idea.
> >=20
> > A compliant HW will support multiple slices per frame, that's not
> > really optional. But it may require all slices to be packed in a single
> > allocation, in which case it could copy, or we can just have a
> > dedicated format for this behaviour.
>=20
> I was thinking of allowing this by default with bit offsets to the
> slice. The main issue I see here will be trying to add new slice data
> to a buffer that was already queued (and might already be undergoing
> decoding), when submitting a new request to the batch (that may already
> have started decoding). We'd need a notion of "buffer partitions" or
> so.
>=20
> > > > > > > What do you think?
> > > > > > >=20
> > > > > > > >  By the way, if we could queue
> > > > > > > > twice the same buffer, that would in principal work, but in=
ternally
> > > > > > > > there is only one state per buffer. If you do external allo=
cation, then
> > > > > > > > in theory you could workaround that, but then it's ugly, be=
cause you'll
> > > > > > > > have two buffers with the same timestamp.
> > > > > > >=20
> > > > > > > One advantage of the request API is that buffers are actually=
 queued
> > > > > > > when the request is processed, so this might not be too probl=
ematic.
> > > > > > >=20
> > > > > > > I think what we need boils down to:
> > > > > > > - Being able to queue the same output buffer to multiple requ=
ests,
> > > > > > > which the request API should already allow;
> > > > > > > - Being able to grab the right capture buffer based on the ou=
tput
> > > > > > > timestamp so that the different requests for the slices are r=
endered to
> > > > > > > the same destination buffer.
> > > > > > >=20
> > > > > > > For the second point, I don't really have a clear idea of whe=
ther we
> > > > > > > can already expect v4l2 to allow picking a buffer that was ma=
rked done
> > > > > > > but was not de-queued by userspace yet. It might already be a=
llowed and
> > > > > > > we could just implement something to lookup the buffer to gra=
b by
> > > > > > > timestamp.
> > > > > >=20
> > > > > > An entirely difference solution that came to my mind in the las=
t few
> > > > > > days would be to add a new buffer flag that would mean END_OF_F=
RAME (or
> > > > > > reused the generic LAST flag). This flag would be passed on the=
 last
> > > > > > slice (if it is known that we are handling the last one) or in =
an empty
> > > > > > buffer if it is found through parsing the next following NAL. T=
his is
> > > > > > inspired by the optional OMX END_OF_FRAME flag and RTP marker b=
it.
> > > > > > Though, if we make this flag mandatory, the driver could avoid =
marking
> > > > > > the frame done until all slices has been decoded. The cons is t=
hat
> > > > > > userpace is not informed when a specific slice is done decoding=
. This
> > > > > > is quite niche, but you can use this information along with the=
 list of
> > > > > > macroblocks from the slice header so signal which portion of th=
e image
> > > > > > is now ready for an hypothetical video processing. The pros is =
that
> > > > > > this solution can be per format, so this would not be needed fo=
r VP8 as
> > > > > > an example.
> > > > >=20
> > > > > Mhh, I don't really like the idea of setting an explicit order wh=
en
> > > > > there is really none. I guess the slices for a given frame can be
> > > > > decoded in whatever order, so I would like it better if we could =
just
> > > > > submit the batch of requests and be told when the batch is done,
> > > > > instead of specifying an explicit order and waiting for the last =
buffer
> > > > > to be marked done.
> > > > >=20
> > > > > And I think this batch idea could apply to other things than vide=
o
> > > > > decoding, so it feels good to have it as the highest level we can=
 in
> > > > > media/v4l2.
> > > >=20
> > > > I haven't said anything about order. I believe you can decode slice
> > > > out-of-order in H264 but it is likely not true for all formats. You=
 are
> > > > again missing the point of decoding latency.
> > >=20
> > > Well, having an END_OF_FRAME flag on one of the slices pretty much
> > > implicitly defines an order (at least regarding this slice vs the
> > > others).
> >=20
> > No, the flag simply means that any following request will be on another
> > frame. It's more like "closing" the decoded frame. I believe you have a
> > good understanding of this proposal now after our IRC discussion.
>=20
> Yes and I think what you are suggesting makes good sense.
> For the record, we certainly need to take care that the end frame *and
> the previous ones* are finished before marking the buffers done, so
> that we can handle parallelized pipelines that may finish decoding in a
> different order than request submission order.
>=20
> > > > In live stream, the slices are transmitted over some serial link. I=
f
> > > > you wait until you have all slice before you start decoding, you de=
lay
> > > > further the moment the frame will be ready.
> > >=20
> > > So that means we need some ability to add requests to a batch while t=
he
> > > batch is being handled. Seems a bit exotic but definitely legit, and =
it
> > > can probably be done. Userspace would know when it has submitted all
> > > the slices and move on to displaying the frame.
> > >=20
> > > >  A lot of vendors make use
> > > > of this to reduce latency, and libWebRTC also makes use of this. So
> > > > being able to pass slices as part of a specific frame is rather
> > > > important. Otherwise vendor will keep doing their own stuff as the
> > > > Linux kernel API won't allow reaching their customers expectation.
> > >=20
> > > I fully agree we need to prepare for all these low-latency
> > > improvements. My goal is definitely to have something that can beat
> > > vendor-specific implementations in upstream, not just a proof of
> > > concept for half-baked decoding.
> >=20
> > Great.
> >=20
> > > > The batching capabilities should be used for the case the multiple
> > > > slices of a frame (or multiple slices of many frame is supported by=
 the
> > > > HW) have been queued before the previous batch had completed.
> > > >=20
> > > > > > A third approach could be to use the encoded buffer state to tr=
ack the
> > > > > > progress decoding that slice. Many driver will mark the buffer =
done as
> > > > > > soon as it is transferred to the accelerator, it does not alway=
s match
> > > > > > the moment that slice has been decoded. But has use said, we wo=
uld need
> > > > > > to study if it make sense to let a driver pick by timestamp a b=
uffer
> > > > > > that might already have reached done state. Other cons, is that=
 polling
> > > > > > for buffer states on the capture queue won't mean anything anym=
ore. But
> > > > > > combined with the FLAG, it would fix the cons of the FLAG solut=
ion.
> > > > >=20
> > > > > Well, I think we should keep the done operation as-is, only give =
it a
> > > > > different interpretation depending on whether the request is hand=
led
> > > > > individually or as part of a batch. I really think we shouldn't r=
ely on
> > > > > any buffer-level indication for completion when handling a batch,=
 but
> > > > > rather have something about the batch entity itself.
> > > >=20
> > > > But then there is no way to know when the frame is decoded anymore,
> > > > because as soon as the first slice is decoded, the capture is done =
and
> > > > stay done. So what's your idea here, how to do you know your decodi=
ng
> > > > is complete if you haven't dequeue/queue the frame in between slice=
s ?
> > >=20
> > > Yes, I was thinking of exposing a sync object as a fd that can be
> > > polled on, which would be associated with the request batch and
> > > signalled when completed. That's pretty much a standalone fence that'=
s
> > > not backed by a buffer.
> > >=20
> > > I would like that to be importable as a DRM input fence (if possible =
at
> > > all), so we can schedule decoding and schedule a page flip for the
> > > capture buffer at the same time. Then the capture buffer can be
> > > displayed as soon as the decoding batch is done.
> >=20
> > We'll have to bring that one is a specific topic. Right now there is
> > many peaces missing on DRM side as you already know. Also, fences would
> > be delivered out-of-order (decoding order), we'd need strong doc to
> > help user-space figure-out how to use this.
>=20
> I think DRM is quite relevant nowadays when it comes to sync (but
> that's something missing from V4L2 as of now). Yes a big part of the
> logic is left to userspace since as you mention, decoding order !=3D
> display order.
>=20
> That means that fences are only relevant when we are sure that the
> decoded frame is to be displayed next and that we have already missed
> the target vblank where its flip should have been scheduled. As far as
> I can see, the fence can reduce the latency by one frame by scheduling
> the flip at the current vblank target still (instead of the next one
> where the frame is decoded), and letting it take effect "as soon as
> possible" (which might be before or after the next vblank).
>=20
> Cheers,
>=20
> Paul
>=20
> > > > > > > > An argument that was made early was that we don't need to s=
upport this
> > > > > > > > right away because userspace can combine all the slices int=
o one
> > > > > > > > buffer. But for H264_SLICE_RAW format it's inconvenient, yo=
u'd need an
> > > > > > > > extra control to tell the driver the offset to each slices,=
 because the
> > > > > > > > raw H264 does not have enough information to be parsed. RAW=
 slice are
> > > > > > > > also I believe de-emulated, which means the code use to pre=
vent having
> > > > > > > > pattern looking like a start code has been removed, so you =
cannot just
> > > > > > > > prepend start codes. De-emulation seems better placed in us=
erspace if
> > > > > > > > the HW does not take care.
> > > > > > >=20
> > > > > > > Mhh I'd like to avoid having having to specify the offset to =
each slice
> > > > > > > for the legacy case. Just appending the encoded data (excludi=
ng slice
> > > > > > > header and start code) works for cedrus and I think it makes =
sense more
> > > > > > > generally. The idea is to only expose a single slice params a=
nd act as
> > > > > > > if it was just one big slice buffer.
> > > > > > >=20
> > > > > > > Come to think of it, maybe we need annex-b and mixed fashions=
 of that
> > > > > > > legacy pixfmt too...
> > > > > > >=20
> > > > > > > > I also very dislike the idea that we would enforce merging =
all slice
> > > > > > > > into the same buffer. The entire purpose of slices and the =
reason they
> > > > > > > > are used in practice is that you can start decoding slices =
before you
> > > > > > > > have all slices of a frame. This reduce drastically the lat=
ency for
> > > > > > > > streaming use cases, like video conferencing. So forcing th=
e merging of
> > > > > > > > slices is basically like pretending slices have no benefits=
.
> > > > > > >=20
> > > > > > > Of course, we don't want things to stay like this and this re=
work is
> > > > > > > definitely needed to get serious performance and latency goin=
g.
> > > > > > >=20
> > > > > > > One thing you should also be aware of: we're currently using =
a
> > > > > > > workqueue between the job done irq and scheduling the next fr=
ame (in
> > > > > > > v4l2 m2m).
> > > > > > >=20
> > > > > > > Maybe we could manage to fit that into an atomic path to sche=
dule the
> > > > > > > next request in the previous job done irq context.
> > > > > > >=20
> > > > > > > > I have just exposed the problem I see for now, to see what =
comes up.
> > > > > > > > But I hope we be able to propose solution too in the short =
term (in no
> > > > > > > > one beats me at it).
> > > > > > >=20
> > > > > > > Seems that we have good grounds for a discussion!
> > > > > > >=20
> > > > > > > Cheers,
> > > > > > >=20
> > > > > > > Paul
> > > > > > >=20
> > > > > > > > > +
> > > > > > > > > +A typical frame would thus be decoded using the followin=
g sequence:
> > > > > > > > > +
> > > > > > > > > +1. Queue an ``OUTPUT`` buffer containing one unit of enc=
oded bitstream data for
> > > > > > > > > +   the decoding request, using :c:func:`VIDIOC_QBUF`.
> > > > > > > > > +
> > > > > > > > > +    * **Required fields:**
> > > > > > > > > +
> > > > > > > > > +      ``index``
> > > > > > > > > +          index of the buffer being queued.
> > > > > > > > > +
> > > > > > > > > +      ``type``
> > > > > > > > > +          type of the buffer.
> > > > > > > > > +
> > > > > > > > > +      ``bytesused``
> > > > > > > > > +          number of bytes taken by the encoded data fram=
e in the buffer.
> > > > > > > > > +
> > > > > > > > > +      ``flags``
> > > > > > > > > +          the ``V4L2_BUF_FLAG_REQUEST_FD`` flag must be =
set.
> > > > > > > > > +
> > > > > > > > > +      ``request_fd``
> > > > > > > > > +          must be set to the file descriptor of the deco=
ding request.
> > > > > > > > > +
> > > > > > > > > +      ``timestamp``
> > > > > > > > > +          must be set to a unique value per frame. This =
value will be propagated
> > > > > > > > > +          into the decoded frame's buffer and can also b=
e used to use this frame
> > > > > > > > > +          as the reference of another.
> > > > > > > > > +
> > > > > > > > > +2. Set the codec-specific controls for the decoding requ=
est, using
> > > > > > > > > +   :c:func:`VIDIOC_S_EXT_CTRLS`.
> > > > > > > > > +
> > > > > > > > > +    * **Required fields:**
> > > > > > > > > +
> > > > > > > > > +      ``which``
> > > > > > > > > +          must be ``V4L2_CTRL_WHICH_REQUEST_VAL``.
> > > > > > > > > +
> > > > > > > > > +      ``request_fd``
> > > > > > > > > +          must be set to the file descriptor of the deco=
ding request.
> > > > > > > > > +
> > > > > > > > > +      other fields
> > > > > > > > > +          other fields are set as usual when setting con=
trols. The ``controls``
> > > > > > > > > +          array must contain all the codec-specific cont=
rols required to decode
> > > > > > > > > +          a frame.
> > > > > > > > > +
> > > > > > > > > +   .. note::
> > > > > > > > > +
> > > > > > > > > +      It is possible to specify the controls in differen=
t invocations of
> > > > > > > > > +      :c:func:`VIDIOC_S_EXT_CTRLS`, or to overwrite a pr=
eviously set control, as
> > > > > > > > > +      long as ``request_fd`` and ``which`` are properly =
set. The controls state
> > > > > > > > > +      at the moment of request submission is the one tha=
t will be considered.
> > > > > > > > > +
> > > > > > > > > +   .. note::
> > > > > > > > > +
> > > > > > > > > +      The order in which steps 1 and 2 take place is int=
erchangeable.
> > > > > > > > > +
> > > > > > > > > +3. Submit the request by invoking :c:func:`MEDIA_REQUEST=
_IOC_QUEUE` on the
> > > > > > > > > +   request FD.
> > > > > > > > > +
> > > > > > > > > +    If the request is submitted without an ``OUTPUT`` bu=
ffer, or if some of the
> > > > > > > > > +    required controls are missing from the request, then
> > > > > > > > > +    :c:func:`MEDIA_REQUEST_IOC_QUEUE` will return ``-ENO=
ENT``. If more than one
> > > > > > > > > +    ``OUTPUT`` buffer is queued, then it will return ``-=
EINVAL``.
> > > > > > > > > +    :c:func:`MEDIA_REQUEST_IOC_QUEUE` returning non-zero=
 means that no
> > > > > > > > > +    ``CAPTURE`` buffer will be produced for this request=
.
> > > > > > > > > +
> > > > > > > > > +``CAPTURE`` buffers must not be part of the request, and=
 are queued
> > > > > > > > > +independently. They are returned in decode order (i.e. t=
he same order as coded
> > > > > > > > > +frames were submitted to the ``OUTPUT`` queue).
> > > > > > > > > +
> > > > > > > > > +Runtime decoding errors are signaled by the dequeued ``C=
APTURE`` buffers
> > > > > > > > > +carrying the ``V4L2_BUF_FLAG_ERROR`` flag. If a decoded =
reference frame has an
> > > > > > > > > +error, then all following decoded frames that refer to i=
t also have the
> > > > > > > > > +``V4L2_BUF_FLAG_ERROR`` flag set, although the decoder w=
ill still try to
> > > > > > > > > +produce a (likely corrupted) frame.
> > > > > > > > > +
> > > > > > > > > +Buffer management while decoding
> > > > > > > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > +Contrary to stateful decoders, a stateless decoder does =
not perform any kind of
> > > > > > > > > +buffer management: it only guarantees that dequeued ``CA=
PTURE`` buffers can be
> > > > > > > > > +used by the client for as long as they are not queued ag=
ain. "Used" here
> > > > > > > > > +encompasses using the buffer for compositing or display.
> > > > > > > > > +
> > > > > > > > > +A dequeued capture buffer can also be used as the refere=
nce frame of another
> > > > > > > > > +buffer.
> > > > > > > > > +
> > > > > > > > > +A frame is specified as reference by converting its time=
stamp into nanoseconds,
> > > > > > > > > +and storing it into the relevant member of a codec-depen=
dent control structure.
> > > > > > > > > +The :c:func:`v4l2_timeval_to_ns` function must be used t=
o perform that
> > > > > > > > > +conversion. The timestamp of a frame can be used to refe=
rence it as soon as all
> > > > > > > > > +its units of encoded data are successfully submitted to =
the ``OUTPUT`` queue.
> > > > > > > > > +
> > > > > > > > > +A decoded buffer containing a reference frame must not b=
e reused as a decoding
> > > > > > > > > +target until all the frames referencing it have been dec=
oded. The safest way to
> > > > > > > > > +achieve this is to refrain from queueing a reference buf=
fer until all the
> > > > > > > > > +decoded frames referencing it have been dequeued. Howeve=
r, if the driver can
> > > > > > > > > +guarantee that buffer queued to the ``CAPTURE`` queue wi=
ll be used in queued
> > > > > > > > > +order, then user-space can take advantage of this guaran=
tee and queue a
> > > > > > > > > +reference buffer when the following conditions are met:
> > > > > > > > > +
> > > > > > > > > +1. All the requests for frames affected by the reference=
 frame have been
> > > > > > > > > +   queued, and
> > > > > > > > > +
> > > > > > > > > +2. A sufficient number of ``CAPTURE`` buffers to cover a=
ll the decoded
> > > > > > > > > +   referencing frames have been queued.
> > > > > > > > > +
> > > > > > > > > +When queuing a decoding request, the driver will increas=
e the reference count of
> > > > > > > > > +all the resources associated with reference frames. This=
 means that the client
> > > > > > > > > +can e.g. close the DMABUF file descriptors of reference =
frame buffers if it
> > > > > > > > > +won't need them afterwards.
> > > > > > > > > +
> > > > > > > > > +Seeking
> > > > > > > > > +=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > +In order to seek, the client just needs to submit reques=
ts using input buffers
> > > > > > > > > +corresponding to the new stream position. It must howeve=
r be aware that
> > > > > > > > > +resolution may have changed and follow the dynamic resol=
ution change sequence in
> > > > > > > > > +that case. Also depending on the codec used, picture par=
ameters (e.g. SPS/PPS
> > > > > > > > > +for H.264) may have changed and the client is responsibl=
e for making sure that a
> > > > > > > > > +valid state is sent to the decoder.
> > > > > > > > > +
> > > > > > > > > +The client is then free to ignore any returned ``CAPTURE=
`` buffer that comes
> > > > > > > > > +from the pre-seek position.
> > > > > > > > > +
> > > > > > > > > +Pause
> > > > > > > > > +=3D=3D=3D=3D=3D
> > > > > > > > > +
> > > > > > > > > +In order to pause, the client can just cease queuing buf=
fers onto the ``OUTPUT``
> > > > > > > > > +queue. Without source bitstream data, there is no data t=
o process and the codec
> > > > > > > > > +will remain idle.
> > > > > > > > > +
> > > > > > > > > +Dynamic resolution change
> > > > > > > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > +
> > > > > > > > > +If the client detects a resolution change in the stream,=
 it will need to perform
> > > > > > > > > +the initialization sequence again with the new resolutio=
n:
> > > > > > > > > +
> > > > > > > > > +1. Wait until all submitted requests have completed and =
dequeue the
> > > > > > > > > +   corresponding output buffers.
> > > > > > > > > +
> > > > > > > > > +2. Call :c:func:`VIDIOC_STREAMOFF` on both the ``OUTPUT`=
` and ``CAPTURE``
> > > > > > > > > +   queues.
> > > > > > > > > +
> > > > > > > > > +3. Free all ``CAPTURE`` buffers by calling :c:func:`VIDI=
OC_REQBUFS` on the
> > > > > > > > > +   ``CAPTURE`` queue with a buffer count of zero.
> > > > > > > > > +
> > > > > > > > > +4. Perform the initialization sequence again (minus the =
allocation of
> > > > > > > > > +   ``OUTPUT`` buffers), with the new resolution set on t=
he ``OUTPUT`` queue.
> > > > > > > > > +   Note that due to resolution constraints, a different =
format may need to be
> > > > > > > > > +   picked on the ``CAPTURE`` queue.
> > > > > > > > > +
> > > > > > > > > +Drain
> > > > > > > > > +=3D=3D=3D=3D=3D
> > > > > > > > > +
> > > > > > > > > +In order to drain the stream on a stateless decoder, the=
 client just needs to
> > > > > > > > > +wait until all the submitted requests are completed. The=
re is no need to send a
> > > > > > > > > +``V4L2_DEC_CMD_STOP`` command since requests are process=
ed sequentially by the
> > > > > > > > > +decoder.

--=-9WIvxzhmOSxUCak9W+5t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSScpfJiL+hb5vvd45xUwItrAaoHAUCXLdRmgAKCRBxUwItrAao
HO7DAJ9nuXbNZKJMH1zCgiAikgk8VHsvGACfTePoSN8HR6XCLKcrVd3XU+tOG5I=
=gDPN
-----END PGP SIGNATURE-----

--=-9WIvxzhmOSxUCak9W+5t--

