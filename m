Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6BCC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29B62087E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfDOH6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:58:34 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:57269 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfDOH6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:58:33 -0400
X-Originating-IP: 90.88.18.121
Received: from aptenodytes (aaubervilliers-681-1-63-121.w90-88.abo.wanadoo.fr [90.88.18.121])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id B2A4E24000A;
        Mon, 15 Apr 2019 07:58:27 +0000 (UTC)
Message-ID: <d81d0112b99feba0a1899f3722077a4aeec9860c.camel@bootlin.com>
Subject: Re: [PATCH v4] media: docs-rst: Document m2m stateless video
 decoder interface
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Dafna Hirschfeld <dafna3@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 15 Apr 2019 09:58:27 +0200
In-Reply-To: <c07703459c7e48904bd7fd83be1e675c70eee83c.camel@ndufresne.ca>
References: <20190306080019.159676-1-acourbot@chromium.org>
         <371df0e4ec9e38d83d11171cbd98f19954cbf787.camel@ndufresne.ca>
         <da5aa9ab957923a72e30b169a3c242c4fe6260f1.camel@bootlin.com>
         <c07703459c7e48904bd7fd83be1e675c70eee83c.camel@ndufresne.ca>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 2019-04-14 at 18:38 -0400, Nicolas Dufresne wrote:
> Le dimanche 14 avril 2019 à 18:41 +0200, Paul Kocialkowski a écrit :
> > Hi,
> > 
> > Le vendredi 12 avril 2019 à 16:47 -0400, Nicolas Dufresne a écrit :
> > > Le mercredi 06 mars 2019 à 17:00 +0900, Alexandre Courbot a écrit :
> > > > Documents the protocol that user-space should follow when
> > > > communicating with stateless video decoders.
> > > > 
> > > > The stateless video decoding API makes use of the new request and tags
> > > > APIs. While it has been implemented with the Cedrus driver so far, it
> > > > should probably still be considered staging for a short while.
> > 
> > [...]
> > 
> > > From an IRC discussion with Paul and some more digging, I have found a
> > > design problem in the decoding process.
> > > 
> > > In H264 and HEVC you can have multiple decoding unit per frames
> > > (slices). This type of encoding is increasingly popular, specially for
> > > low latency streaming use cases. The wording of this spec does allow
> > > for the notion of decoding unit, and in practice it has been proven to
> > > work through some RFC FFMPEG patches and the Cedrus driver. But
> > > something important to know is that the FFMPEG RFC implements decoding
> > > in lock steps. Which means:
> > > 
> > >   1. It queues a single free capture buffer
> > >   2. It queues an output buffer, set controls, queue the request
> > >   3. It waits for a capture buffer to reach state done
> > >   4. It dequeues that capture buffer, and queue it back again
> > >   5. And then it runs step 2,4,3 again with following slices, until we 
> > >      have a complete frame. After what, it restart at step 1
> > > 
> > > So the implementation makes no use of the queues. There is no batch
> > > processing, so we might not be able to reach the maximum hardware
> > > throughput.
> > > 
> > > So the optimal method would look like the following, but there comes
> > > the design issue.
> > > 
> > >   1. Queue a single free capture buffer
> > >   2. Queue output buffer for slice 1, set controls, queue the request
> > >   3. Queue output buffer for slice 2, set controls, queue the request
> > >   4. Wait for completion
> > > 
> > > The problem is in step 4. Completion means that the capture buffer done
> > > decoding a single unit. So assuming the driver supports matching the
> > > timestamp against the queued buffer, instead of waiting for a new
> > > buffer, the driver would have to mark twice the same buffer to done
> > > state, which is just not working to inform userspace that all slices
> > > are decoded into the one capture buffer they share.
> > 
> > Interestingly, I'm experiencing the exact same problem dealing with a
> > 2D graphics blitter that has limited ouput scaling abilities which
> > imply handlnig a large scaling operation as multiple clipped smaller
> > scaling operations. The issue is basically that multiple jobs have to
> > be submitted to complete a single frame and relying on an indication
> > from the destination buffer (such as a fence) doesn't work to indicate
> > that all the operations were completed, since we get the indication at
> > each step instead of at the end of the batch.
> > 
> > One idea I see to solve this is to have a notion of batch in the driver
> > (for our situation, that would be in v4l2) and provide means to get a
> > done indication for that entity.
> > 
> > I think we could extend the request API to allow this. We already
> > represent requests as individual file descriptors, we could totally
> > group requests in batches and get a sync fd for the batch to poll on
> > when we need to return the frames. It would be good if we could expose
> > this in a way that makes it work with DRM as an in fence for display.
> > Then we can pretty much schedule our flip + decoding together (which is
> > quite nice to have when we're running late on the decoding side).
> > 
> > What do you think?
> > 
> > It feels to me like the request API was designed to open up the way for
> > these kinds of improvements, so I'm sure we can find an agreeable
> > solution that extends the API.
> > 
> > > To me, multi slice encoded stream are just too common, and they will
> > > also exist for AV1. So we really need a solution to this that does not
> > > require operating in lock steps. Specially that some HW can decode
> > > multiple slices in parallel (multi core), we would not want to prevent
> > > that HW from being used efficiently. On top of this, we need a solution
> > > so that we can also keep queuing slice of the following frames if they
> > > arrive before decoding is done.
> > 
> > Agreed.
> > 
> > > I don't have a solution yet myself, but it would be nice to come up
> > > with something before we freeze this API.
> > 
> > I think it's rather independent from the codec used and this is
> > something that should be handled at the request API level. 
> > 
> > I'm not sure we can always expect the hardware to be able to operate on
> > a per-slice basis. I think it would be useful to reflect this in the
> > pixel format, so that we also have a possibility for a gathered slice
> > buffer (as the spec currently mentions for mpeg-2) for legacy decoder
> > hardware that will need to decode one frame in one go from a contiguous
> > buffer with all the slice data appended.
> > 
> > This updates my pixel format proposition from IRC to the following:
> > - V4L2_PIXFMT_H264_SLICE_APPENDED: single buffer for all the slices
> > (appended buffer), slice params as v4l2 control (legacy);
> 
> SLICE_RAW_APPENDED ? Or FRAMED_SLICES_RAW ? You would need a new
> control for the NAL index, as there is no way to figure-out otherwise.
> I would not add this format unless a specific HW need it.

I don't really like using "raw" as a distinguisher: I don't think it's
explicit enough. The idea here is to reflect that there is only one
slice exposed, which is the appended result of all the frame slices
with a single v4l2 control.

> > - V4L2_PIXFMT_H264_SLICE: one buffer/slice, slice params as control;
> > 
> > - V4L2_PIXFMT_H264_SLICE_ANNEX_B: one buffer/slice in annex-b format, 
> > slice params encoded in the buffer;
> 
> We are still working on this one, this format will be used by Rockchip
> driver for sure, but this needs clarification and maybe a rename if
> it's not just one slice per buffer.

I thought the decoder also needed the parse slice data? At least IIRC
for Tegra, we need Annex-B format and a parsed slice header (so the
next one).

> > - V4L2_PIXFMT_H264_SLICE_MIXED: one buffer/slice in annex-b format,
> > slice params encoded in the buffer and in slice params control;
> > 
> > Also, we need to make sure to have a per-slice bit offset to the
> > encoded data in the slice params control so that the same slice buffer
> > can be used with any of the _SLICE formats (e.g. ffmpeg would only have
> > an annex-b slice and use any of the formats with it).
> 
> Ah, I we are saying the same.
> 
> > For the legacy format, we need to specify that the appended slices
> > don't repeat the annex-b start code and NAL header.
> 
> I'm not sure this one make sense. the NAL header for each slices of one
> frames are not always identical.

Yes but that's pretty much the point of the legacy format: to only
expose a single slice buffer and slice header (even in cases where the
bitstream codes them in multiple distinct ones).

We can't expect this to work in every case, that's why it's a legacy
format. It seems to work pretty well for cedrus so far.

We could also decide to ditch the legacy idea altogether and only
specify formats that operate on a per-slice basis, but I'm afraid we'll
find decoders that can only take a single slice per buffer.

When decoding a multi-slice frame in that setup, I think we'll be
better off with an appended buffer containing all the slices for the
frame instead of passing only a the first slice.

> > What do you think?
> > 
> > >  By the way, if we could queue
> > > twice the same buffer, that would in principal work, but internally
> > > there is only one state per buffer. If you do external allocation, then
> > > in theory you could workaround that, but then it's ugly, because you'll
> > > have two buffers with the same timestamp.
> > 
> > One advantage of the request API is that buffers are actually queued
> > when the request is processed, so this might not be too problematic.
> > 
> > I think what we need boils down to:
> > - Being able to queue the same output buffer to multiple requests,
> > which the request API should already allow;
> > - Being able to grab the right capture buffer based on the output
> > timestamp so that the different requests for the slices are rendered to
> > the same destination buffer.
> > 
> > For the second point, I don't really have a clear idea of whether we
> > can already expect v4l2 to allow picking a buffer that was marked done
> > but was not de-queued by userspace yet. It might already be allowed and
> > we could just implement something to lookup the buffer to grab by
> > timestamp.
> 
> An entirely difference solution that came to my mind in the last few
> days would be to add a new buffer flag that would mean END_OF_FRAME (or
> reused the generic LAST flag). This flag would be passed on the last
> slice (if it is known that we are handling the last one) or in an empty
> buffer if it is found through parsing the next following NAL. This is
> inspired by the optional OMX END_OF_FRAME flag and RTP marker bit.
> Though, if we make this flag mandatory, the driver could avoid marking
> the frame done until all slices has been decoded. The cons is that
> userpace is not informed when a specific slice is done decoding. This
> is quite niche, but you can use this information along with the list of
> macroblocks from the slice header so signal which portion of the image
> is now ready for an hypothetical video processing. The pros is that
> this solution can be per format, so this would not be needed for VP8 as
> an example.

Mhh, I don't really like the idea of setting an explicit order when
there is really none. I guess the slices for a given frame can be
decoded in whatever order, so I would like it better if we could just
submit the batch of requests and be told when the batch is done,
instead of specifying an explicit order and waiting for the last buffer
to be marked done.

And I think this batch idea could apply to other things than video
decoding, so it feels good to have it as the highest level we can in
media/v4l2.

> A third approach could be to use the encoded buffer state to track the
> progress decoding that slice. Many driver will mark the buffer done as
> soon as it is transferred to the accelerator, it does not always match
> the moment that slice has been decoded. But has use said, we would need
> to study if it make sense to let a driver pick by timestamp a buffer
> that might already have reached done state. Other cons, is that polling
> for buffer states on the capture queue won't mean anything anymore. But
> combined with the FLAG, it would fix the cons of the FLAG solution.

Well, I think we should keep the done operation as-is, only give it a
different interpretation depending on whether the request is handled
individually or as part of a batch. I really think we shouldn't rely on
any buffer-level indication for completion when handling a batch, but
rather have something about the batch entity itself.

Cheers,

Paul

> > > An argument that was made early was that we don't need to support this
> > > right away because userspace can combine all the slices into one
> > > buffer. But for H264_SLICE_RAW format it's inconvenient, you'd need an
> > > extra control to tell the driver the offset to each slices, because the
> > > raw H264 does not have enough information to be parsed. RAW slice are
> > > also I believe de-emulated, which means the code use to prevent having
> > > pattern looking like a start code has been removed, so you cannot just
> > > prepend start codes. De-emulation seems better placed in userspace if
> > > the HW does not take care.
> > 
> > Mhh I'd like to avoid having having to specify the offset to each slice
> > for the legacy case. Just appending the encoded data (excluding slice
> > header and start code) works for cedrus and I think it makes sense more
> > generally. The idea is to only expose a single slice params and act as
> > if it was just one big slice buffer.
> > 
> > Come to think of it, maybe we need annex-b and mixed fashions of that
> > legacy pixfmt too...
> > 
> > > I also very dislike the idea that we would enforce merging all slice
> > > into the same buffer. The entire purpose of slices and the reason they
> > > are used in practice is that you can start decoding slices before you
> > > have all slices of a frame. This reduce drastically the latency for
> > > streaming use cases, like video conferencing. So forcing the merging of
> > > slices is basically like pretending slices have no benefits.
> > 
> > Of course, we don't want things to stay like this and this rework is
> > definitely needed to get serious performance and latency going.
> > 
> > One thing you should also be aware of: we're currently using a
> > workqueue between the job done irq and scheduling the next frame (in
> > v4l2 m2m).
> > 
> > Maybe we could manage to fit that into an atomic path to schedule the
> > next request in the previous job done irq context.
> > 
> > > I have just exposed the problem I see for now, to see what comes up.
> > > But I hope we be able to propose solution too in the short term (in no
> > > one beats me at it).
> > 
> > Seems that we have good grounds for a discussion!
> > 
> > Cheers,
> > 
> > Paul
> > 
> > > > +
> > > > +A typical frame would thus be decoded using the following sequence:
> > > > +
> > > > +1. Queue an ``OUTPUT`` buffer containing one unit of encoded bitstream data for
> > > > +   the decoding request, using :c:func:`VIDIOC_QBUF`.
> > > > +
> > > > +    * **Required fields:**
> > > > +
> > > > +      ``index``
> > > > +          index of the buffer being queued.
> > > > +
> > > > +      ``type``
> > > > +          type of the buffer.
> > > > +
> > > > +      ``bytesused``
> > > > +          number of bytes taken by the encoded data frame in the buffer.
> > > > +
> > > > +      ``flags``
> > > > +          the ``V4L2_BUF_FLAG_REQUEST_FD`` flag must be set.
> > > > +
> > > > +      ``request_fd``
> > > > +          must be set to the file descriptor of the decoding request.
> > > > +
> > > > +      ``timestamp``
> > > > +          must be set to a unique value per frame. This value will be propagated
> > > > +          into the decoded frame's buffer and can also be used to use this frame
> > > > +          as the reference of another.
> > > > +
> > > > +2. Set the codec-specific controls for the decoding request, using
> > > > +   :c:func:`VIDIOC_S_EXT_CTRLS`.
> > > > +
> > > > +    * **Required fields:**
> > > > +
> > > > +      ``which``
> > > > +          must be ``V4L2_CTRL_WHICH_REQUEST_VAL``.
> > > > +
> > > > +      ``request_fd``
> > > > +          must be set to the file descriptor of the decoding request.
> > > > +
> > > > +      other fields
> > > > +          other fields are set as usual when setting controls. The ``controls``
> > > > +          array must contain all the codec-specific controls required to decode
> > > > +          a frame.
> > > > +
> > > > +   .. note::
> > > > +
> > > > +      It is possible to specify the controls in different invocations of
> > > > +      :c:func:`VIDIOC_S_EXT_CTRLS`, or to overwrite a previously set control, as
> > > > +      long as ``request_fd`` and ``which`` are properly set. The controls state
> > > > +      at the moment of request submission is the one that will be considered.
> > > > +
> > > > +   .. note::
> > > > +
> > > > +      The order in which steps 1 and 2 take place is interchangeable.
> > > > +
> > > > +3. Submit the request by invoking :c:func:`MEDIA_REQUEST_IOC_QUEUE` on the
> > > > +   request FD.
> > > > +
> > > > +    If the request is submitted without an ``OUTPUT`` buffer, or if some of the
> > > > +    required controls are missing from the request, then
> > > > +    :c:func:`MEDIA_REQUEST_IOC_QUEUE` will return ``-ENOENT``. If more than one
> > > > +    ``OUTPUT`` buffer is queued, then it will return ``-EINVAL``.
> > > > +    :c:func:`MEDIA_REQUEST_IOC_QUEUE` returning non-zero means that no
> > > > +    ``CAPTURE`` buffer will be produced for this request.
> > > > +
> > > > +``CAPTURE`` buffers must not be part of the request, and are queued
> > > > +independently. They are returned in decode order (i.e. the same order as coded
> > > > +frames were submitted to the ``OUTPUT`` queue).
> > > > +
> > > > +Runtime decoding errors are signaled by the dequeued ``CAPTURE`` buffers
> > > > +carrying the ``V4L2_BUF_FLAG_ERROR`` flag. If a decoded reference frame has an
> > > > +error, then all following decoded frames that refer to it also have the
> > > > +``V4L2_BUF_FLAG_ERROR`` flag set, although the decoder will still try to
> > > > +produce a (likely corrupted) frame.
> > > > +
> > > > +Buffer management while decoding
> > > > +================================
> > > > +Contrary to stateful decoders, a stateless decoder does not perform any kind of
> > > > +buffer management: it only guarantees that dequeued ``CAPTURE`` buffers can be
> > > > +used by the client for as long as they are not queued again. "Used" here
> > > > +encompasses using the buffer for compositing or display.
> > > > +
> > > > +A dequeued capture buffer can also be used as the reference frame of another
> > > > +buffer.
> > > > +
> > > > +A frame is specified as reference by converting its timestamp into nanoseconds,
> > > > +and storing it into the relevant member of a codec-dependent control structure.
> > > > +The :c:func:`v4l2_timeval_to_ns` function must be used to perform that
> > > > +conversion. The timestamp of a frame can be used to reference it as soon as all
> > > > +its units of encoded data are successfully submitted to the ``OUTPUT`` queue.
> > > > +
> > > > +A decoded buffer containing a reference frame must not be reused as a decoding
> > > > +target until all the frames referencing it have been decoded. The safest way to
> > > > +achieve this is to refrain from queueing a reference buffer until all the
> > > > +decoded frames referencing it have been dequeued. However, if the driver can
> > > > +guarantee that buffer queued to the ``CAPTURE`` queue will be used in queued
> > > > +order, then user-space can take advantage of this guarantee and queue a
> > > > +reference buffer when the following conditions are met:
> > > > +
> > > > +1. All the requests for frames affected by the reference frame have been
> > > > +   queued, and
> > > > +
> > > > +2. A sufficient number of ``CAPTURE`` buffers to cover all the decoded
> > > > +   referencing frames have been queued.
> > > > +
> > > > +When queuing a decoding request, the driver will increase the reference count of
> > > > +all the resources associated with reference frames. This means that the client
> > > > +can e.g. close the DMABUF file descriptors of reference frame buffers if it
> > > > +won't need them afterwards.
> > > > +
> > > > +Seeking
> > > > +=======
> > > > +In order to seek, the client just needs to submit requests using input buffers
> > > > +corresponding to the new stream position. It must however be aware that
> > > > +resolution may have changed and follow the dynamic resolution change sequence in
> > > > +that case. Also depending on the codec used, picture parameters (e.g. SPS/PPS
> > > > +for H.264) may have changed and the client is responsible for making sure that a
> > > > +valid state is sent to the decoder.
> > > > +
> > > > +The client is then free to ignore any returned ``CAPTURE`` buffer that comes
> > > > +from the pre-seek position.
> > > > +
> > > > +Pause
> > > > +=====
> > > > +
> > > > +In order to pause, the client can just cease queuing buffers onto the ``OUTPUT``
> > > > +queue. Without source bitstream data, there is no data to process and the codec
> > > > +will remain idle.
> > > > +
> > > > +Dynamic resolution change
> > > > +=========================
> > > > +
> > > > +If the client detects a resolution change in the stream, it will need to perform
> > > > +the initialization sequence again with the new resolution:
> > > > +
> > > > +1. Wait until all submitted requests have completed and dequeue the
> > > > +   corresponding output buffers.
> > > > +
> > > > +2. Call :c:func:`VIDIOC_STREAMOFF` on both the ``OUTPUT`` and ``CAPTURE``
> > > > +   queues.
> > > > +
> > > > +3. Free all ``CAPTURE`` buffers by calling :c:func:`VIDIOC_REQBUFS` on the
> > > > +   ``CAPTURE`` queue with a buffer count of zero.
> > > > +
> > > > +4. Perform the initialization sequence again (minus the allocation of
> > > > +   ``OUTPUT`` buffers), with the new resolution set on the ``OUTPUT`` queue.
> > > > +   Note that due to resolution constraints, a different format may need to be
> > > > +   picked on the ``CAPTURE`` queue.
> > > > +
> > > > +Drain
> > > > +=====
> > > > +
> > > > +In order to drain the stream on a stateless decoder, the client just needs to
> > > > +wait until all the submitted requests are completed. There is no need to send a
> > > > +``V4L2_DEC_CMD_STOP`` command since requests are processed sequentially by the
> > > > +decoder.
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

