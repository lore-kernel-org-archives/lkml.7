Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D884C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44882206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733029AbfDQRSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:18:45 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:49149 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbfDQRSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:18:45 -0400
Received: from collins (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 07BFE24000F;
        Wed, 17 Apr 2019 17:18:40 +0000 (UTC)
Message-ID: <ef64503f58feaee1dacaaecb3f0d9140faa70f1b.camel@bootlin.com>
Subject: Re: [PATCH v4] media: docs-rst: Document m2m stateless video
 decoder interface
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Alexandre Courbot <acourbot@chromium.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Dafna Hirschfeld <dafna3@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 17 Apr 2019 19:18:40 +0200
In-Reply-To: <88b90a267f40d71b00e29d5d063fc26407104093.camel@ndufresne.ca>
References: <20190306080019.159676-1-acourbot@chromium.org>
         <371df0e4ec9e38d83d11171cbd98f19954cbf787.camel@ndufresne.ca>
         <da5aa9ab957923a72e30b169a3c242c4fe6260f1.camel@bootlin.com>
         <c07703459c7e48904bd7fd83be1e675c70eee83c.camel@ndufresne.ca>
         <d81d0112b99feba0a1899f3722077a4aeec9860c.camel@bootlin.com>
         <439b7f57aa3ba2b2ed5b043f961ef87cb83912af.camel@ndufresne.ca>
         <59e23c5ca5bfbadf9441ea06da2e9b9b5898c6d7.camel@bootlin.com>
         <0b495143bb260cf9f8927ee541e7f001842ac5c3.camel@ndufresne.ca>
         <CAPBb6MVG+3jQcw3AuhYDYCZ0YJ0aX=TmEuM5izh12GLw9V6B8Q@mail.gmail.com>
         <88b90a267f40d71b00e29d5d063fc26407104093.camel@ndufresne.ca>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mercredi 17 avril 2019 à 12:06 -0400, Nicolas Dufresne a écrit :
> Le mardi 16 avril 2019 à 16:22 +0900, Alexandre Courbot a écrit :
> > On Tue, Apr 16, 2019 at 12:30 AM Nicolas Dufresne <nicolas@ndufresne.ca> wrote:
> > > Le lundi 15 avril 2019 à 15:26 +0200, Paul Kocialkowski a écrit :

[...]

> > Thanks for this great discussion. Let me try to summarize the status
> > of this thread + the IRC discussion and add my own thoughts:
> > 
> > Proper support for multiple decoding units (e.g. H.264 slices) per
> > frame should not be an afterthought ; compliance to encoded formats
> > depend on it, and the benefit of lower latency is a significant
> > consideration for vendors.
> > 
> > m2m, which we use for all stateless codecs, has a strong assumption
> > that one OUTPUT buffer consumed results in one CAPTURE buffer being
> > produced. This assumption can however be overruled: at least the venus
> > driver does it to implement the stateful specification.
> 
> The m2m framework code, which is quite minimal, has this limitation,
> but it has nothing to do with the userspace M2M interface. In
> userspace, M2M are just two asynchronous queues. New input data is
> queued on the OUTPUT queue, and results is taken from the CAPTURE
> queue. There is nothing in the API or the spec that limits how many
> input data (OUTPUT queue) will be used to produce a number of results
> (CAPTURE queue).
> 
> > So we need a way to specify frame boundaries when submitting encoded
> > content to the driver. One request should contain a single OUTPUT
> > buffer, containing a single decoding unit, but we need a way to
> > specify whether the driver should directly produce a CAPTURE buffer
> > from this request, or keep using the same CAPTURE buffer with
> > subsequent requests.
> 
> Yes, that's a good recap, we need a way. Just a clarification, we need
> a way for formats similar to H264/H265 for which the frame boundary is
> often only discovered by parsing the following NAL or signalled through
> a container.
> 
> > I can think of 2 ways this can be expressed:
> > 1) We keep the current m2m behavior as the default (a CAPTURE buffer
> > is produced), and add a flag to ask the driver to change that behavior
> > and hold on the CAPTURE buffer and reuse it with the next request(s) ;
> > 2) We specify that no CAPTURE buffer is produced by default, unless a
> > flag asking so is specified.
> 
> I don't think 1) is really a valid option. A buffer has one state. In
> current implementation of Cedrus, when 1 unit is decoded (1 slice) the
> capture buffer is marked as DONE. That signals any userspace polling
> for capture buffer being ready to DQ. Now, if you drive the OUTPUT and
> CAPTURE queue from separate thread, you end up with a race where
> userspace thinks the buffer is ready but a new slice comes in, so the
> state has been cleared between the poll returning and the call to DQ
> buf. User-space will unexpectedly endup doing a blocking DQBuf which is
> likely unwanted. Then if we leave is in DONE state, it's much worst,
> since there is no way to signal that the buffer is ready (the decoding
> the unit has completed).
> 
> As this API does not exist yet, introducing 2) is possible and is much
> saner to handle from userspace. The benefit  is that you have no
> special case. The driver just hold on marking the buffer DONE until it
> has processed all unit up to one that had a frame completion flag on
> it.

Mhh, without explicitly marking the requests as part of the same group,
we would basically lose the ability to function stateless with this
idea. By that, I mean that you can no longer schedule a request that's
not part of the current batch of slices, since the kernel-side would
refrain from marking the capture buffer done for that request or mark
the capture buffer for the slices along with the completion of that
request.

One way or another, I think we need to explicitly mark the requests for
the each slice of the frame as being part of the same group. And while
at it, we might want to make that possible for any use case that might
require it, not just video decoding.

The request API is quite complex on its own and I guess we're dealing
with complex topics that involve significantly changing the behavior of
v4l2. Not to say that we shouldn't try to keep things simple, we
definitely should, but it might be one of the cases where the long-term 
solution is not going to be that easy to carry out.

The way I see it, the media userspace interface was enriched with the
request API to deal with a specific case (associating source data and
associated meta-data) and managed to bring a generic and flexible
solution that also covers other use cases. So I feel like solving this
issue would be best done at the media level and in a way that's not too
centered on our specific use case.

> > The flag could be specified in one of two ways:
> > a) As a new v4l2_buffer.flag for the OUTPUT buffer ;
> > b) As a dedicated control, either format-specific or more common to all codecs.
> > 
> > I tend to favor 2) and b) for this, for the reason that with H.264 at
> > least, user-space does not know whether a slice is the last slice of a
> > frame until it starts parsing the next one, and we don't know when we
> > will receive it. If we use a control to ask that a CAPTURE buffer be
> > produced, we can always submit another request with only that control
> > set once it is clear that the frame is complete (and not delay
> > decoding meanwhile). In practice I am not that familiar with
> > latency-sensitive streaming ; maybe a smart streamer would just append
> > an AUD NAL unit at the end of every frame and we can thus submit the
> > flag it with the last slice without further delay?
> 
> AUD NAL, when present, are the first NAL of a frame, so latency wise it
> is useless. So what we do is that we rely on the encoder to tell us. So
> encoders will set a flag to signal the last slice of a frame. If you
> are doing RTP, this flags is converted into a marker bit (RTP
> specific). This marker bit is then received on the other side and
> passed to the decoder. The decoder will process the slice and when this
> is done will immediately deliver the resulting frame (if reordering
> allow). If it's not present, it will wait for the next slice in order
> to determine if the decoded frame can be delivered or not. So without
> the marker, we effectively have 1 extra frame latency in the worst
> case.
> 
> What I like of the b) proposal is that we can invert the logic and
> effectively abstract this completely for formats that don't have slices
> (or equivalent) while having this implemented generically.
> 
> What I had in mind was a) because I was thinking that we could reuse
> the flag for stateful encoder/decoder in order to support the RTP
> marker bit usecase and slice level streaming. Right now, we only do
> full frame streaming, but it's limiting. the ZyncMP firmware that
> Micheal is integrating does support low latency with slice processing,
> so to match the vendor driver capacity we'll need that flag anyway.
> 
> But in stateless, it's easier, because not setting it at all simply
> introduce more latency, while for accelerators we would like to make
> the closing of a frame mandatory. So I'm totally fine with a different
> mechanism. Again, this is handled in VAAPI and other similar API by
> having begin/end function for frames, and then a number of
> decode_slice() calls in the middle. So there is an extra context for
> frames on top of slices in these API.
> 
> > An extra constraint to enforce would be that each decoding unit
> > belonging to the same frame must be submitted with the same timestamp,
> > otherwise the request submission would fail. We really need a
> > framework to enforce all this at a higher level than individual
> > drivers, once we reach an agreement I will start working on this.
> 
> I agree with that. And adding checks for this would be really welcome
> to catch errors.

Agreed, this feels like a sane thing to do.

> > Formats that do not support multiple decoding units per frame would
> > reject any request that does not carry the end-of-frame information.
> 
> Again, we *could* also reverse the logic, so that by default all OUTPUT
> buffer would be considered complete frames. So far I only know 3
> formats that have this feature, H264, H265 and AV1. I'm not sure for
> VP9, I would need to look. But clearly JPEG, VP8, H263, raw format and
> more don't seem to have this. We could also have a generic control/flag
> and make it mandatory for specific formats if that is simpler.

Well, now I am pretty much convinced that what's in the OUTPUT buffer
should be one entity of the decoding unit, which could be a slice or
coded data for one frame depending on the format. I think adding a
control or a flag for that would bring-in too much boilerplate and
different cases to handle in the driver, which does not feel that good.

I'm still open to introducing specific formats for submitting enough
slice data for a whole frame, but not sure it is worth the effort.

Cheers,

Paul

