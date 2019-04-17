Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9A0C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E321217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="tjf23sMt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732816AbfDQQG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:06:59 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35011 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732180AbfDQQG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:06:58 -0400
Received: by mail-qt1-f193.google.com with SMTP id h39so27990150qte.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 09:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=e0nboxEWzvg2PRN66nJKqX+1H6cdqxIDaZyo14OZwck=;
        b=tjf23sMtF7UniLkAfK2kteKY+cyqtWTTrVTAkmnJAHhqYWv0h6BiyVkRW8uvSUI48o
         OOy/4T0NNZ2YpbMSYnDndeUlTRM3+qpHHC3IdYXznqa8BBMcILz8StVjuk3jpd2GfD9H
         UK0lF4AtaxGtbHUjL3Va55HxEXz/pfMgdz6MBaMu+OO1CKo1l8HOQgCJXGvkIV4ur2S8
         i3kIswjuVmhi27WnjmxbPUJ7QYpCZDL69koEfqsETnWUy15dx73r50+ug7NHqUG7mOld
         5vBjgtOXC4tC3l/xX0PJLx4o/saYcWWMxQkzhcqRyJHyuv+rmzhcMRAW9bMlU4nixJE4
         Ji/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=e0nboxEWzvg2PRN66nJKqX+1H6cdqxIDaZyo14OZwck=;
        b=hnYE2y1spjpIbqB/B7sjzgfolRt1YWWmoEEVAMozp4b15Wi5DUp/ChuQiYKQEkjEt1
         NAVFO+rdjtvgwYhJSJabx4bbX5POfFMclGogHE5PlwFp6s5tPfFVM8N+iCs6d2XXqgl4
         IQb/IfUQE33vul1bE+K+cOOe1OLInzrPZWx7JKFrYTFTPS0/4GNvlewtZjnyw4XegGnT
         79XyK2LR5i/QUj/6wUfqhNgzoNmyNm/akJEo+rerZlCWlN7HowRymwXo1x7y77AQWISg
         xUDOCcpxGQWSlswaFjBTmnaYwZwIGb1XoiMfCBVeX53SHYvxuWwj/HCrLEf2KV9vVvL+
         cl4A==
X-Gm-Message-State: APjAAAVbC/i3ymwzN1s4ioZIF4qbJx9rN5/P8Ufu5FA0bxZzcq80jNNH
        2wd+yZPQrPGas8aVM1khYR5xbw==
X-Google-Smtp-Source: APXvYqy8J3qb7cOGdyCcvlVTkLrPkVUCzzd7pkqlXIsRiw0SupwQ7Zqa3+DNBstgJ8GzG9TWxFbjOw==
X-Received: by 2002:a0c:98cb:: with SMTP id g11mr72235918qvd.141.1555517217170;
        Wed, 17 Apr 2019 09:06:57 -0700 (PDT)
Received: from tpx230-nicolas.collaboramtl (modemcable154.55-37-24.static.videotron.ca. [24.37.55.154])
        by smtp.gmail.com with ESMTPSA id x8sm35138203qtj.45.2019.04.17.09.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 09:06:55 -0700 (PDT)
Message-ID: <88b90a267f40d71b00e29d5d063fc26407104093.camel@ndufresne.ca>
Subject: Re: [PATCH v4] media: docs-rst: Document m2m stateless video
 decoder interface
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Dafna Hirschfeld <dafna3@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 17 Apr 2019 12:06:54 -0400
In-Reply-To: <CAPBb6MVG+3jQcw3AuhYDYCZ0YJ0aX=TmEuM5izh12GLw9V6B8Q@mail.gmail.com>
References: <20190306080019.159676-1-acourbot@chromium.org>
         <371df0e4ec9e38d83d11171cbd98f19954cbf787.camel@ndufresne.ca>
         <da5aa9ab957923a72e30b169a3c242c4fe6260f1.camel@bootlin.com>
         <c07703459c7e48904bd7fd83be1e675c70eee83c.camel@ndufresne.ca>
         <d81d0112b99feba0a1899f3722077a4aeec9860c.camel@bootlin.com>
         <439b7f57aa3ba2b2ed5b043f961ef87cb83912af.camel@ndufresne.ca>
         <59e23c5ca5bfbadf9441ea06da2e9b9b5898c6d7.camel@bootlin.com>
         <0b495143bb260cf9f8927ee541e7f001842ac5c3.camel@ndufresne.ca>
         <CAPBb6MVG+3jQcw3AuhYDYCZ0YJ0aX=TmEuM5izh12GLw9V6B8Q@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-HaJSQpShB00DhFuNsZHU"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HaJSQpShB00DhFuNsZHU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mardi 16 avril 2019 =C3=A0 16:22 +0900, Alexandre Courbot a =C3=A9crit :
> On Tue, Apr 16, 2019 at 12:30 AM Nicolas Dufresne <nicolas@ndufresne.ca> =
wrote:
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
s, until we
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
> > > > > > > something that should be handled at the request API level.
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
> > indeed make sense. But I really thought all stateless decoder would
> > required that. A hard bet obviously.
> >=20
> > > > > > > - V4L2_PIXFMT_H264_SLICE: one buffer/slice, slice params as c=
ontrol;
> > > > > > >=20
> > > > > > > - V4L2_PIXFMT_H264_SLICE_ANNEX_B: one buffer/slice in annex-b=
 format,
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
ce
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
> >=20
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
> >=20
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
>=20
> Thanks for this great discussion. Let me try to summarize the status
> of this thread + the IRC discussion and add my own thoughts:
>=20
> Proper support for multiple decoding units (e.g. H.264 slices) per
> frame should not be an afterthought ; compliance to encoded formats
> depend on it, and the benefit of lower latency is a significant
> consideration for vendors.
>=20
> m2m, which we use for all stateless codecs, has a strong assumption
> that one OUTPUT buffer consumed results in one CAPTURE buffer being
> produced. This assumption can however be overruled: at least the venus
> driver does it to implement the stateful specification.

The m2m framework code, which is quite minimal, has this limitation,
but it has nothing to do with the userspace M2M interface. In
userspace, M2M are just two asynchronous queues. New input data is
queued on the OUTPUT queue, and results is taken from the CAPTURE
queue. There is nothing in the API or the spec that limits how many
input data (OUTPUT queue) will be used to produce a number of results
(CAPTURE queue).

>=20
> So we need a way to specify frame boundaries when submitting encoded
> content to the driver. One request should contain a single OUTPUT
> buffer, containing a single decoding unit, but we need a way to
> specify whether the driver should directly produce a CAPTURE buffer
> from this request, or keep using the same CAPTURE buffer with
> subsequent requests.

Yes, that's a good recap, we need a way. Just a clarification, we need
a way for formats similar to H264/H265 for which the frame boundary is
often only discovered by parsing the following NAL or signalled through
a container.

>=20
> I can think of 2 ways this can be expressed:
> 1) We keep the current m2m behavior as the default (a CAPTURE buffer
> is produced), and add a flag to ask the driver to change that behavior
> and hold on the CAPTURE buffer and reuse it with the next request(s) ;
> 2) We specify that no CAPTURE buffer is produced by default, unless a
> flag asking so is specified.

I don't think 1) is really a valid option. A buffer has one state. In
current implementation of Cedrus, when 1 unit is decoded (1 slice) the
capture buffer is marked as DONE. That signals any userspace polling
for capture buffer being ready to DQ. Now, if you drive the OUTPUT and
CAPTURE queue from separate thread, you end up with a race where
userspace thinks the buffer is ready but a new slice comes in, so the
state has been cleared between the poll returning and the call to DQ
buf. User-space will unexpectedly endup doing a blocking DQBuf which is
likely unwanted. Then if we leave is in DONE state, it's much worst,
since there is no way to signal that the buffer is ready (the decoding
the unit has completed).

As this API does not exist yet, introducing 2) is possible and is much
saner to handle from userspace. The benefit  is that you have no
special case. The driver just hold on marking the buffer DONE until it
has processed all unit up to one that had a frame completion flag on
it.

>=20
> The flag could be specified in one of two ways:
> a) As a new v4l2_buffer.flag for the OUTPUT buffer ;
> b) As a dedicated control, either format-specific or more common to all c=
odecs.
>=20
> I tend to favor 2) and b) for this, for the reason that with H.264 at
> least, user-space does not know whether a slice is the last slice of a
> frame until it starts parsing the next one, and we don't know when we
> will receive it. If we use a control to ask that a CAPTURE buffer be
> produced, we can always submit another request with only that control
> set once it is clear that the frame is complete (and not delay
> decoding meanwhile). In practice I am not that familiar with
> latency-sensitive streaming ; maybe a smart streamer would just append
> an AUD NAL unit at the end of every frame and we can thus submit the
> flag it with the last slice without further delay?

AUD NAL, when present, are the first NAL of a frame, so latency wise it
is useless. So what we do is that we rely on the encoder to tell us. So
encoders will set a flag to signal the last slice of a frame. If you
are doing RTP, this flags is converted into a marker bit (RTP
specific). This marker bit is then received on the other side and
passed to the decoder. The decoder will process the slice and when this
is done will immediately deliver the resulting frame (if reordering
allow). If it's not present, it will wait for the next slice in order
to determine if the decoded frame can be delivered or not. So without
the marker, we effectively have 1 extra frame latency in the worst
case.

What I like of the b) proposal is that we can invert the logic and
effectively abstract this completely for formats that don't have slices
(or equivalent) while having this implemented generically.

What I had in mind was a) because I was thinking that we could reuse
the flag for stateful encoder/decoder in order to support the RTP
marker bit usecase and slice level streaming. Right now, we only do
full frame streaming, but it's limiting. the ZyncMP firmware that
Micheal is integrating does support low latency with slice processing,
so to match the vendor driver capacity we'll need that flag anyway.

But in stateless, it's easier, because not setting it at all simply
introduce more latency, while for accelerators we would like to make
the closing of a frame mandatory. So I'm totally fine with a different
mechanism. Again, this is handled in VAAPI and other similar API by
having begin/end function for frames, and then a number of
decode_slice() calls in the middle. So there is an extra context for
frames on top of slices in these API.

>=20
> An extra constraint to enforce would be that each decoding unit
> belonging to the same frame must be submitted with the same timestamp,
> otherwise the request submission would fail. We really need a
> framework to enforce all this at a higher level than individual
> drivers, once we reach an agreement I will start working on this.

I agree with that. And adding checks for this would be really welcome
to catch errors.

>=20
> Formats that do not support multiple decoding units per frame would
> reject any request that does not carry the end-of-frame information.

Again, we *could* also reverse the logic, so that by default all OUTPUT
buffer would be considered complete frames. So far I only know 3
formats that have this feature, H264, H265 and AV1. I'm not sure for
VP9, I would need to look. But clearly JPEG, VP8, H263, raw format and
more don't seem to have this. We could also have a generic control/flag
and make it mandatory for specific formats if that is simpler.

>=20
> Anything missing / any further comment?

--=-HaJSQpShB00DhFuNsZHU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSScpfJiL+hb5vvd45xUwItrAaoHAUCXLdPHgAKCRBxUwItrAao
HLbxAKCJnYvzwJhaharkTnyXMpEXSnbKZgCgqV4iDxIQT7ILmfJ93h70vsIiN38=
=My7v
-----END PGP SIGNATURE-----

--=-HaJSQpShB00DhFuNsZHU--

