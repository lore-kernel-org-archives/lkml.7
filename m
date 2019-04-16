Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18014C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED5A2073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WSp2yQqQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbfDPHWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:22:31 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42898 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfDPHWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 03:22:30 -0400
Received: by mail-ot1-f68.google.com with SMTP id 103so16745895otd.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 00:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6JwNcxpkLszNjML9YqNbHN0CPQ2YUNpatsffrJrJmrk=;
        b=WSp2yQqQrb50WonNk12YTrr3twZgc6hTkfuSUcKaLmrEfs0sGHifaAOyRYafA0Lr4W
         kvfGqINXD1+BXsqOTlwxm17qHRrckq75BoKYVzY8P/qogibmcLVejEvfWlbKSQHHQv9+
         qJkMi3y6LqoUuADurAe9cH/o0KQMdKmj6DdPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6JwNcxpkLszNjML9YqNbHN0CPQ2YUNpatsffrJrJmrk=;
        b=HbqtfF8352biWJhYiaLzZyqhqckcxNltaJg4CZHvSDAPZKuXatN65B4XF1cybzDDOh
         VO/AF3VRsJkOjpcFoZFK2/s3YCjlx1VvQs8h5CZNfKnD4ZlY+/Uqe6WgzL3itObGIcDP
         VXz7kreielXld0wyKUOVSG0ffWjctEuwWVxBiFcZ7b0YWimTjOBqCoW9pGFsXl2/F9X0
         w9jhjtg6hQ0M13DKlY0X5lNAo8qwonjWFI/7b2W5EYR7adPhKUMuvgS1KR1q+dv3qAzh
         247zl5sZAkqJemJI6oMfKTaJ5fJq4KicpmSSMgzg/y8b3erodnoS5pKeuoAKoVza3pjs
         mk0g==
X-Gm-Message-State: APjAAAVQXMMCHMur5NrbNjq3qk9jerGPPKxoyaV6/+1CDvPsQphgsJC/
        cQa4LFUoxhKujXI7Btci3dmsgzUQY2s=
X-Google-Smtp-Source: APXvYqwDSspr43RBsBsJT+r10NDDVtu48x2PtZ7rLFbrrzY8uY6E7uUMz+zoewYyQ0x4bvDWJGkGuQ==
X-Received: by 2002:a9d:63c9:: with SMTP id e9mr50579521otl.76.1555399348212;
        Tue, 16 Apr 2019 00:22:28 -0700 (PDT)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com. [209.85.210.49])
        by smtp.gmail.com with ESMTPSA id v19sm20516007otk.63.2019.04.16.00.22.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 00:22:27 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id s24so16728107otk.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 00:22:26 -0700 (PDT)
X-Received: by 2002:a9d:801:: with SMTP id 1mr35600782oty.73.1555399346468;
 Tue, 16 Apr 2019 00:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190306080019.159676-1-acourbot@chromium.org>
 <371df0e4ec9e38d83d11171cbd98f19954cbf787.camel@ndufresne.ca>
 <da5aa9ab957923a72e30b169a3c242c4fe6260f1.camel@bootlin.com>
 <c07703459c7e48904bd7fd83be1e675c70eee83c.camel@ndufresne.ca>
 <d81d0112b99feba0a1899f3722077a4aeec9860c.camel@bootlin.com>
 <439b7f57aa3ba2b2ed5b043f961ef87cb83912af.camel@ndufresne.ca>
 <59e23c5ca5bfbadf9441ea06da2e9b9b5898c6d7.camel@bootlin.com> <0b495143bb260cf9f8927ee541e7f001842ac5c3.camel@ndufresne.ca>
In-Reply-To: <0b495143bb260cf9f8927ee541e7f001842ac5c3.camel@ndufresne.ca>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Tue, 16 Apr 2019 16:22:14 +0900
X-Gmail-Original-Message-ID: <CAPBb6MVG+3jQcw3AuhYDYCZ0YJ0aX=TmEuM5izh12GLw9V6B8Q@mail.gmail.com>
Message-ID: <CAPBb6MVG+3jQcw3AuhYDYCZ0YJ0aX=TmEuM5izh12GLw9V6B8Q@mail.gmail.com>
Subject: Re: [PATCH v4] media: docs-rst: Document m2m stateless video decoder interface
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Dafna Hirschfeld <dafna3@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 12:30 AM Nicolas Dufresne <nicolas@ndufresne.ca> wr=
ote:
>
> Le lundi 15 avril 2019 =C3=A0 15:26 +0200, Paul Kocialkowski a =C3=A9crit=
 :
> > Hi,
> >
> > On Mon, 2019-04-15 at 08:24 -0400, Nicolas Dufresne wrote:
> > > Le lundi 15 avril 2019 =C3=A0 09:58 +0200, Paul Kocialkowski a =C3=A9=
crit :
> > > > Hi,
> > > >
> > > > On Sun, 2019-04-14 at 18:38 -0400, Nicolas Dufresne wrote:
> > > > > Le dimanche 14 avril 2019 =C3=A0 18:41 +0200, Paul Kocialkowski a=
 =C3=A9crit :
> > > > > > Hi,
> > > > > >
> > > > > > Le vendredi 12 avril 2019 =C3=A0 16:47 -0400, Nicolas Dufresne =
a =C3=A9crit :
> > > > > > > Le mercredi 06 mars 2019 =C3=A0 17:00 +0900, Alexandre Courbo=
t a =C3=A9crit :
> > > > > > > > Documents the protocol that user-space should follow when
> > > > > > > > communicating with stateless video decoders.
> > > > > > > >
> > > > > > > > The stateless video decoding API makes use of the new reque=
st and tags
> > > > > > > > APIs. While it has been implemented with the Cedrus driver =
so far, it
> > > > > > > > should probably still be considered staging for a short whi=
le.
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > > > From an IRC discussion with Paul and some more digging, I hav=
e found a
> > > > > > > design problem in the decoding process.
> > > > > > >
> > > > > > > In H264 and HEVC you can have multiple decoding unit per fram=
es
> > > > > > > (slices). This type of encoding is increasingly popular, spec=
ially for
> > > > > > > low latency streaming use cases. The wording of this spec doe=
s allow
> > > > > > > for the notion of decoding unit, and in practice it has been =
proven to
> > > > > > > work through some RFC FFMPEG patches and the Cedrus driver. B=
ut
> > > > > > > something important to know is that the FFMPEG RFC implements=
 decoding
> > > > > > > in lock steps. Which means:
> > > > > > >
> > > > > > >   1. It queues a single free capture buffer
> > > > > > >   2. It queues an output buffer, set controls, queue the requ=
est
> > > > > > >   3. It waits for a capture buffer to reach state done
> > > > > > >   4. It dequeues that capture buffer, and queue it back again
> > > > > > >   5. And then it runs step 2,4,3 again with following slices,=
 until we
> > > > > > >      have a complete frame. After what, it restart at step 1
> > > > > > >
> > > > > > > So the implementation makes no use of the queues. There is no=
 batch
> > > > > > > processing, so we might not be able to reach the maximum hard=
ware
> > > > > > > throughput.
> > > > > > >
> > > > > > > So the optimal method would look like the following, but ther=
e comes
> > > > > > > the design issue.
> > > > > > >
> > > > > > >   1. Queue a single free capture buffer
> > > > > > >   2. Queue output buffer for slice 1, set controls, queue the=
 request
> > > > > > >   3. Queue output buffer for slice 2, set controls, queue the=
 request
> > > > > > >   4. Wait for completion
> > > > > > >
> > > > > > > The problem is in step 4. Completion means that the capture b=
uffer done
> > > > > > > decoding a single unit. So assuming the driver supports match=
ing the
> > > > > > > timestamp against the queued buffer, instead of waiting for a=
 new
> > > > > > > buffer, the driver would have to mark twice the same buffer t=
o done
> > > > > > > state, which is just not working to inform userspace that all=
 slices
> > > > > > > are decoded into the one capture buffer they share.
> > > > > >
> > > > > > Interestingly, I'm experiencing the exact same problem dealing =
with a
> > > > > > 2D graphics blitter that has limited ouput scaling abilities wh=
ich
> > > > > > imply handlnig a large scaling operation as multiple clipped sm=
aller
> > > > > > scaling operations. The issue is basically that multiple jobs h=
ave to
> > > > > > be submitted to complete a single frame and relying on an indic=
ation
> > > > > > from the destination buffer (such as a fence) doesn't work to i=
ndicate
> > > > > > that all the operations were completed, since we get the indica=
tion at
> > > > > > each step instead of at the end of the batch.
> > > > > >
> > > > > > One idea I see to solve this is to have a notion of batch in th=
e driver
> > > > > > (for our situation, that would be in v4l2) and provide means to=
 get a
> > > > > > done indication for that entity.
> > > > > >
> > > > > > I think we could extend the request API to allow this. We alrea=
dy
> > > > > > represent requests as individual file descriptors, we could tot=
ally
> > > > > > group requests in batches and get a sync fd for the batch to po=
ll on
> > > > > > when we need to return the frames. It would be good if we could=
 expose
> > > > > > this in a way that makes it work with DRM as an in fence for di=
splay.
> > > > > > Then we can pretty much schedule our flip + decoding together (=
which is
> > > > > > quite nice to have when we're running late on the decoding side=
).
> > > > > >
> > > > > > What do you think?
> > > > > >
> > > > > > It feels to me like the request API was designed to open up the=
 way for
> > > > > > these kinds of improvements, so I'm sure we can find an agreeab=
le
> > > > > > solution that extends the API.
> > > > > >
> > > > > > > To me, multi slice encoded stream are just too common, and th=
ey will
> > > > > > > also exist for AV1. So we really need a solution to this that=
 does not
> > > > > > > require operating in lock steps. Specially that some HW can d=
ecode
> > > > > > > multiple slices in parallel (multi core), we would not want t=
o prevent
> > > > > > > that HW from being used efficiently. On top of this, we need =
a solution
> > > > > > > so that we can also keep queuing slice of the following frame=
s if they
> > > > > > > arrive before decoding is done.
> > > > > >
> > > > > > Agreed.
> > > > > >
> > > > > > > I don't have a solution yet myself, but it would be nice to c=
ome up
> > > > > > > with something before we freeze this API.
> > > > > >
> > > > > > I think it's rather independent from the codec used and this is
> > > > > > something that should be handled at the request API level.
> > > > > >
> > > > > > I'm not sure we can always expect the hardware to be able to op=
erate on
> > > > > > a per-slice basis. I think it would be useful to reflect this i=
n the
> > > > > > pixel format, so that we also have a possibility for a gathered=
 slice
> > > > > > buffer (as the spec currently mentions for mpeg-2) for legacy d=
ecoder
> > > > > > hardware that will need to decode one frame in one go from a co=
ntiguous
> > > > > > buffer with all the slice data appended.
> > > > > >
> > > > > > This updates my pixel format proposition from IRC to the follow=
ing:
> > > > > > - V4L2_PIXFMT_H264_SLICE_APPENDED: single buffer for all the sl=
ices
> > > > > > (appended buffer), slice params as v4l2 control (legacy);
> > > > >
> > > > > SLICE_RAW_APPENDED ? Or FRAMED_SLICES_RAW ? You would need a new
> > > > > control for the NAL index, as there is no way to figure-out other=
wise.
> > > > > I would not add this format unless a specific HW need it.
> > > >
> > > > I don't really like using "raw" as a distinguisher: I don't think i=
t's
> > > > explicit enough. The idea here is to reflect that there is only one
> > > > slice exposed, which is the appended result of all the frame slices
> > > > with a single v4l2 control.
> > >
> > > RAW in this context was suggested to reflect the fact there is no
> > > header, no slice header and that emulation prevention bytes has been
> > > removed and replaces by the real values.
> >
> > That could also be understood as "slice params coded raw", which is the
> > opposite of what it describes, hence my reluctance.
> >
> > > Just SLICE alone was much worst.
> >
> > Keep in mind that we already have a MPEG2_SLICE format in the public
> > API. We should probably decide what it should become based on the
> > outcome of this discussion.
> >
> > >  There is to many properties to this type of H264 buffer to
> > > encode everything into the name, so what will really matter in the en=
d
> > > if the documentation. Feel free to propose a better name.
> >
> > Agreed, it's a side point. I always find it hard to find naming good,
> > as well as finding good naming (my suggestions aren't really top-notch
> > either).
> >
> > Here is another proposition:
> > - SLICE_PARSED
> > - SLICE_ANNEX_B
> > - SLICE_PARSED_ANNEX_B
>
> Ok, we'll keep working on that then, naming is hard. I guess by PARSED
> you meant that the slice headers are passed as controls, and that
> indeed make sense. But I really thought all stateless decoder would
> required that. A hard bet obviously.
>
> >
> > > > > > - V4L2_PIXFMT_H264_SLICE: one buffer/slice, slice params as con=
trol;
> > > > > >
> > > > > > - V4L2_PIXFMT_H264_SLICE_ANNEX_B: one buffer/slice in annex-b f=
ormat,
> > > > > > slice params encoded in the buffer;
> > > > >
> > > > > We are still working on this one, this format will be used by Roc=
kchip
> > > > > driver for sure, but this needs clarification and maybe a rename =
if
> > > > > it's not just one slice per buffer.
> > > >
> > > > I thought the decoder also needed the parse slice data? At least II=
RC
> > > > for Tegra, we need Annex-B format and a parsed slice header (so the
> > > > next one).
> > >
> > > Yes, in every cases, the HW will parse the slice data.
> >
> > Ah sorry, I meant "need the parsed slice data" (missed the d), as in,
> > some decoders will need annex-b format but won't parse the slice header
> > on their own, so they also need the parsed slice header control.
> > Don't ask why...
> >
> > In my proposition from above, that would be: SLICE_PARSED_ANNEX_B.
> >
> > >  It's possible
> > > that Tegra have a matching format as Rockchip, someone would need to =
do
> > > a proper integration to verify. But the driver does not need the
> > > following one, that is specific to ANNEX-B parsing.
> > >
> > > > > > - V4L2_PIXFMT_H264_SLICE_MIXED: one buffer/slice in annex-b for=
mat,
> > > > > > slice params encoded in the buffer and in slice params control;
> > > > > >
> > > > > > Also, we need to make sure to have a per-slice bit offset to th=
e
> > > > > > encoded data in the slice params control so that the same slice=
 buffer
> > > > > > can be used with any of the _SLICE formats (e.g. ffmpeg would o=
nly have
> > > > > > an annex-b slice and use any of the formats with it).
> > > > >
> > > > > Ah, I we are saying the same.
> > > > >
> > > > > > For the legacy format, we need to specify that the appended sli=
ces
> > > > > > don't repeat the annex-b start code and NAL header.
> > > > >
> > > > > I'm not sure this one make sense. the NAL header for each slices =
of one
> > > > > frames are not always identical.
> > > >
> > > > Yes but that's pretty much the point of the legacy format: to only
> > > > expose a single slice buffer and slice header (even in cases where =
the
> > > > bitstream codes them in multiple distinct ones).
> > > >
> > > > We can't expect this to work in every case, that's why it's a legac=
y
> > > > format. It seems to work pretty well for cedrus so far.
> > >
> > > I'm not sure I follow you, what Cedrus does should be changed to
> > > whatever we decide as a final API, we should not maintain two formats=
.
> >
> > That point has me hesitating. It depends on whether we can expect to
> > see hardware implementations with no support whatsoever for multi-slice
> > per frame and just expect an aggregated buffer of slice compressed
> > data. This is one operation mode that the Allwinner VPU supports.
> >
> > The point is not to use it in Cedrus since our VPU can operate per-
> > slice, but to allow supporting hardware decoders that can't do that in
> > the future.
> >
> > I'm not sure it's healthy to make it a hard requirement for H.264
> > decoding to operate per-slice. Does that seem too far-fetched from your
> > perspective? I seem to recall from a discussion that some legacy
> > hardware only handles single-slices frames, but I may be wrong.
> >
> > > Also, what works for Cedrus is that a each buffers must have a single
> > > slice regardless how many slices per frame. And this is what I expect
> > > from most stateless HW.
> >
> > Currently, we append all the slices into one buffer and decode it in
> > one go with a slightly hacked slice params to reflect that. But of
> > course, we should be operating per-slice.
> >
> > >  This is how it works in VAAPI and VDPAU as an
> > > example. Just for the reference, the API in VAAPI is (pseudo code, I
> > > can't remember the exact name):
> > >
> > >    - beginPicture()
> > >    - decodeSlice() *
> > >    - endPicture()
> > >
> > > So the accelerator is told explicitly when a frame start/end, but als=
o
> > > it's told explicitly in which buffer to decode the frame to.
> >
> > Yes definitely. We're also given all the parsed bitstream elements in
> > the right order so that we could already start queuing requests when
> > each slice is passed, and just wait for completion at endPicture.
> >
> > > > We could also decide to ditch the legacy idea altogether and only
> > > > specify formats that operate on a per-slice basis, but I'm afraid w=
e'll
> > > > find decoders that can only take a single slice per buffer.
> > >
> > > It's impossible for a compliant decoder to only support 1 slice per
> > > frame, so I don't follow you on this one. Also, I don't understand wh=
at
> > > difference you see between per-slice basis and single slice per buffe=
r.
> >
> > Okay that's exactly what I wanted to know: whether it makes any sense
> > to build a decoder that only operates per-frame and not per-slice.
> > If you are confident we won't see that in the wild, we can make it an
> > API requirement to operate per-slice.
>
> There is probably a small distinction to make between supporting
> multiple slices per frame and operating per slice. It's nice to know
> that Cedrus support both. As we discussed today on IRC, if we introduce
> a flag that tells the driver when the last slice of a frame is passed,
> it would be relatively simple for the driver to do decide what to do.
> Of course if the HW have a limitation of one allocation, it might not
> be fully optimal as it would have to copy.
>
> But as this is stateless decoder, I'm more inclined in introducing a
> format that means just that, leaving it to userspace to do that right
> packing.
>
> >
> > > > When decoding a multi-slice frame in that setup, I think we'll be
> > > > better off with an appended buffer containing all the slices for th=
e
> > > > frame instead of passing only a the first slice.
> > >
> > > Appended slices requires extra controls, but also introduce a lot mor=
e
> > > decoding latency. As soon as we add the missing frame boundary
> > > signalling, it should be really trivial for a driver to wait until it
> > > received all slices before starting the decoding if that is a HW
> > > requirement.
> >
> > Well, I don't really like the idea of the driver being aware of any of
> > that (IMO the logic should be in the media core, not the driver).
> >
> > If a driver can't do multiple slices, it shouldn't be up to the driver
> > to gather them together. But anyway, if you think we won't ever see
> > this kind of hardware, we can just drop the whole idea.
>
> A compliant HW will support multiple slices per frame, that's not
> really optional. But it may require all slices to be packed in a single
> allocation, in which case it could copy, or we can just have a
> dedicated format for this behaviour.
>
> >
> > > > > > What do you think?
> > > > > >
> > > > > > >  By the way, if we could queue
> > > > > > > twice the same buffer, that would in principal work, but inte=
rnally
> > > > > > > there is only one state per buffer. If you do external alloca=
tion, then
> > > > > > > in theory you could workaround that, but then it's ugly, beca=
use you'll
> > > > > > > have two buffers with the same timestamp.
> > > > > >
> > > > > > One advantage of the request API is that buffers are actually q=
ueued
> > > > > > when the request is processed, so this might not be too problem=
atic.
> > > > > >
> > > > > > I think what we need boils down to:
> > > > > > - Being able to queue the same output buffer to multiple reques=
ts,
> > > > > > which the request API should already allow;
> > > > > > - Being able to grab the right capture buffer based on the outp=
ut
> > > > > > timestamp so that the different requests for the slices are ren=
dered to
> > > > > > the same destination buffer.
> > > > > >
> > > > > > For the second point, I don't really have a clear idea of wheth=
er we
> > > > > > can already expect v4l2 to allow picking a buffer that was mark=
ed done
> > > > > > but was not de-queued by userspace yet. It might already be all=
owed and
> > > > > > we could just implement something to lookup the buffer to grab =
by
> > > > > > timestamp.
> > > > >
> > > > > An entirely difference solution that came to my mind in the last =
few
> > > > > days would be to add a new buffer flag that would mean END_OF_FRA=
ME (or
> > > > > reused the generic LAST flag). This flag would be passed on the l=
ast
> > > > > slice (if it is known that we are handling the last one) or in an=
 empty
> > > > > buffer if it is found through parsing the next following NAL. Thi=
s is
> > > > > inspired by the optional OMX END_OF_FRAME flag and RTP marker bit=
.
> > > > > Though, if we make this flag mandatory, the driver could avoid ma=
rking
> > > > > the frame done until all slices has been decoded. The cons is tha=
t
> > > > > userpace is not informed when a specific slice is done decoding. =
This
> > > > > is quite niche, but you can use this information along with the l=
ist of
> > > > > macroblocks from the slice header so signal which portion of the =
image
> > > > > is now ready for an hypothetical video processing. The pros is th=
at
> > > > > this solution can be per format, so this would not be needed for =
VP8 as
> > > > > an example.
> > > >
> > > > Mhh, I don't really like the idea of setting an explicit order when
> > > > there is really none. I guess the slices for a given frame can be
> > > > decoded in whatever order, so I would like it better if we could ju=
st
> > > > submit the batch of requests and be told when the batch is done,
> > > > instead of specifying an explicit order and waiting for the last bu=
ffer
> > > > to be marked done.
> > > >
> > > > And I think this batch idea could apply to other things than video
> > > > decoding, so it feels good to have it as the highest level we can i=
n
> > > > media/v4l2.
> > >
> > > I haven't said anything about order. I believe you can decode slice
> > > out-of-order in H264 but it is likely not true for all formats. You a=
re
> > > again missing the point of decoding latency.
> >
> > Well, having an END_OF_FRAME flag on one of the slices pretty much
> > implicitly defines an order (at least regarding this slice vs the
> > others).
>
> No, the flag simply means that any following request will be on another
> frame. It's more like "closing" the decoded frame. I believe you have a
> good understanding of this proposal now after our IRC discussion.
>
> >
> > > In live stream, the slices are transmitted over some serial link. If
> > > you wait until you have all slice before you start decoding, you dela=
y
> > > further the moment the frame will be ready.
> >
> > So that means we need some ability to add requests to a batch while the
> > batch is being handled. Seems a bit exotic but definitely legit, and it
> > can probably be done. Userspace would know when it has submitted all
> > the slices and move on to displaying the frame.
> >
> > >  A lot of vendors make use
> > > of this to reduce latency, and libWebRTC also makes use of this. So
> > > being able to pass slices as part of a specific frame is rather
> > > important. Otherwise vendor will keep doing their own stuff as the
> > > Linux kernel API won't allow reaching their customers expectation.
> >
> > I fully agree we need to prepare for all these low-latency
> > improvements. My goal is definitely to have something that can beat
> > vendor-specific implementations in upstream, not just a proof of
> > concept for half-baked decoding.

Thanks for this great discussion. Let me try to summarize the status
of this thread + the IRC discussion and add my own thoughts:

Proper support for multiple decoding units (e.g. H.264 slices) per
frame should not be an afterthought ; compliance to encoded formats
depend on it, and the benefit of lower latency is a significant
consideration for vendors.

m2m, which we use for all stateless codecs, has a strong assumption
that one OUTPUT buffer consumed results in one CAPTURE buffer being
produced. This assumption can however be overruled: at least the venus
driver does it to implement the stateful specification.

So we need a way to specify frame boundaries when submitting encoded
content to the driver. One request should contain a single OUTPUT
buffer, containing a single decoding unit, but we need a way to
specify whether the driver should directly produce a CAPTURE buffer
from this request, or keep using the same CAPTURE buffer with
subsequent requests.

I can think of 2 ways this can be expressed:
1) We keep the current m2m behavior as the default (a CAPTURE buffer
is produced), and add a flag to ask the driver to change that behavior
and hold on the CAPTURE buffer and reuse it with the next request(s) ;
2) We specify that no CAPTURE buffer is produced by default, unless a
flag asking so is specified.

The flag could be specified in one of two ways:
a) As a new v4l2_buffer.flag for the OUTPUT buffer ;
b) As a dedicated control, either format-specific or more common to all cod=
ecs.

I tend to favor 2) and b) for this, for the reason that with H.264 at
least, user-space does not know whether a slice is the last slice of a
frame until it starts parsing the next one, and we don't know when we
will receive it. If we use a control to ask that a CAPTURE buffer be
produced, we can always submit another request with only that control
set once it is clear that the frame is complete (and not delay
decoding meanwhile). In practice I am not that familiar with
latency-sensitive streaming ; maybe a smart streamer would just append
an AUD NAL unit at the end of every frame and we can thus submit the
flag it with the last slice without further delay?

An extra constraint to enforce would be that each decoding unit
belonging to the same frame must be submitted with the same timestamp,
otherwise the request submission would fail. We really need a
framework to enforce all this at a higher level than individual
drivers, once we reach an agreement I will start working on this.

Formats that do not support multiple decoding units per frame would
reject any request that does not carry the end-of-frame information.

Anything missing / any further comment?
