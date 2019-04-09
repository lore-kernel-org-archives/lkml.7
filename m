Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B84CC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D38020857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cz+aW2ep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfDIHLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 03:11:34 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42095 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfDIHLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 03:11:33 -0400
Received: by mail-oi1-f194.google.com with SMTP id w139so12652342oie.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 00:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uZ2hw5yG8YDYGTw3t/fJ5OOx4rpHFxrA8d+kBbjE6Vw=;
        b=Cz+aW2ep//BfHbb5Sz8NDb1gK0Gc7JWZt1IicIXz1sXdKIb6gmZUXIZjKU73Wc0G3S
         Tukf695PFvUcPKZqxRZFrlKJvLGe6MlI0tHdsawA8TyJtr0+yAHMv07UyvWHUhCNrVkl
         QdDU3XCUOjuMaLg1sbYGqpuQhStwDNbUs5dwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uZ2hw5yG8YDYGTw3t/fJ5OOx4rpHFxrA8d+kBbjE6Vw=;
        b=ttQkDE/77URw92LwZ0IFgs7YSoHiqEeJ/FtlKhVolLHXTFU/wgrg8fK7j8jcqQ9jQH
         tvxyDvMDQ5rq+X8W2U9ZAR39s/2Jh336molDIJUlbdh9zvQSnQSFbKLaGC2Us/PWQnxB
         N/MKdvVsthBNctVr6/tJRO5TQy8iLO2hNElsb/e2wuSThwn3VQqVs3MUMTXKvvbsuHYr
         mSD68f8Op94YiDaxP960ryvFTNkZ12juEd5D5ncqoGRj5MSKUgJEZnBPJag8De4uWGke
         ath5vcUCMRsUCRJqmTf7+7afmkkYxS1ivzZWjAfM9H8TJjF+04CLUrL2kDv3KBc4Vmwu
         /8AA==
X-Gm-Message-State: APjAAAXEhRZ4bhydEp2vf1Bfu5nKW9kQlWQN7MWSysqAvSJbhOmcQgQD
        i8KQguxdfJrvWUPtvlM0+Fl2xh7edi8=
X-Google-Smtp-Source: APXvYqzr6vo0xlelf+Af7hz3WzrleMj+GegB1HysXLw39iRv1E9Hu340Js+7G8kY5p8ujngXGcEWjQ==
X-Received: by 2002:aca:b706:: with SMTP id h6mr18119578oif.7.1554793892009;
        Tue, 09 Apr 2019 00:11:32 -0700 (PDT)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id 189sm12555926oid.35.2019.04.09.00.11.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 00:11:29 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id l203so12694589oia.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 00:11:29 -0700 (PDT)
X-Received: by 2002:aca:edc7:: with SMTP id l190mr2709412oih.92.1554793888684;
 Tue, 09 Apr 2019 00:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190124100419.26492-1-tfiga@chromium.org> <20190124100419.26492-3-tfiga@chromium.org>
 <cb3c73e0-9481-54d1-8730-69e51655d7d8@xs4all.nl> <CAAFQd5AqRzGehW6fN4P=_oVdPdH+bJQqKhxgP6zsu80p-74bXA@mail.gmail.com>
 <fded491f-8a25-3283-76c4-dee3dd56045e@xs4all.nl>
In-Reply-To: <fded491f-8a25-3283-76c4-dee3dd56045e@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 9 Apr 2019 16:11:17 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CYT=eA_eFyHLTePBQatOBVwsoDjAfMoybJeWrO7V-raA@mail.gmail.com>
Message-ID: <CAAFQd5CYT=eA_eFyHLTePBQatOBVwsoDjAfMoybJeWrO7V-raA@mail.gmail.com>
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 5:43 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 4/8/19 10:36 AM, Tomasz Figa wrote:
> > On Mon, Mar 25, 2019 at 10:12 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
> >>
> >> Another comment found while creating compliance tests:
> >>
> >> On 1/24/19 11:04 AM, Tomasz Figa wrote:
> >>> +Drain
> >>> +=====
> >>> +
> >>> +To ensure that all the queued ``OUTPUT`` buffers have been processed and the
> >>> +related ``CAPTURE`` buffers are given to the client, the client must follow the
> >>> +drain sequence described below. After the drain sequence ends, the client has
> >>> +received all encoded frames for all ``OUTPUT`` buffers queued before the
> >>> +sequence was started.
> >>> +
> >>> +1. Begin the drain sequence by issuing :c:func:`VIDIOC_ENCODER_CMD`.
> >>> +
> >>> +   * **Required fields:**
> >>> +
> >>> +     ``cmd``
> >>> +         set to ``V4L2_ENC_CMD_STOP``
> >>> +
> >>> +     ``flags``
> >>> +         set to 0
> >>> +
> >>> +     ``pts``
> >>> +         set to 0
> >>> +
> >>> +   .. warning::
> >>> +
> >>> +      The sequence can be only initiated if both ``OUTPUT`` and ``CAPTURE``
> >>> +      queues are streaming. For compatibility reasons, the call to
> >>> +      :c:func:`VIDIOC_ENCODER_CMD` will not fail even if any of the queues is
> >>> +      not streaming, but at the same time it will not initiate the `Drain`
> >>> +      sequence and so the steps described below would not be applicable.
> >>> +
> >>> +2. Any ``OUTPUT`` buffers queued by the client before the
> >>> +   :c:func:`VIDIOC_ENCODER_CMD` was issued will be processed and encoded as
> >>> +   normal. The client must continue to handle both queues independently,
> >>> +   similarly to normal encode operation. This includes:
> >>> +
> >>> +   * queuing and dequeuing ``CAPTURE`` buffers, until a buffer marked with the
> >>> +     ``V4L2_BUF_FLAG_LAST`` flag is dequeued,
> >>> +
> >>> +     .. warning::
> >>> +
> >>> +        The last buffer may be empty (with :c:type:`v4l2_buffer`
> >>> +        ``bytesused`` = 0) and in that case it must be ignored by the client,
> >>> +        as it does not contain an encoded frame.
> >>> +
> >>> +     .. note::
> >>> +
> >>> +        Any attempt to dequeue more buffers beyond the buffer marked with
> >>> +        ``V4L2_BUF_FLAG_LAST`` will result in a -EPIPE error from
> >>> +        :c:func:`VIDIOC_DQBUF`.
> >>> +
> >>> +   * dequeuing processed ``OUTPUT`` buffers, until all the buffers queued
> >>> +     before the ``V4L2_ENC_CMD_STOP`` command are dequeued,
> >>> +
> >>> +   * dequeuing the ``V4L2_EVENT_EOS`` event, if the client subscribes to it.
> >>> +
> >>> +   .. note::
> >>> +
> >>> +      For backwards compatibility, the encoder will signal a ``V4L2_EVENT_EOS``
> >>> +      event when the last frame has been decoded and all frames are ready to be
> >>> +      dequeued. It is deprecated behavior and the client must not rely on it.
> >>> +      The ``V4L2_BUF_FLAG_LAST`` buffer flag should be used instead.
> >>> +
> >>> +3. Once all ``OUTPUT`` buffers queued before the ``V4L2_ENC_CMD_STOP`` call are
> >>> +   dequeued and the last ``CAPTURE`` buffer is dequeued, the encoder is stopped
> >>> +   and it will accept, but not process any newly queued ``OUTPUT`` buffers
> >>> +   until the client issues any of the following operations:
> >>> +
> >>> +   * ``V4L2_ENC_CMD_START`` - the encoder will not be reset and will resume
> >>> +     operation normally, with all the state from before the drain,
> >>
> >> I assume that calling CMD_START when *not* draining will succeed but does nothing.
> >>
> >> In other words: while draining is in progress START will return EBUSY. When draining
> >> was finished, then START will resume the encoder. In all other cases it just returns
> >> 0 since the encoder is really already started.
> >>
> >
> > Yes, that was the intention and seems to be the closest to the
> > behavior described in the existing documentation.
> >
> >>> +
> >>> +   * a pair of :c:func:`VIDIOC_STREAMOFF` and :c:func:`VIDIOC_STREAMON` on the
> >>> +     ``CAPTURE`` queue - the encoder will be reset (see the `Reset` sequence)
> >>> +     and then resume encoding,
> >>> +
> >>> +   * a pair of :c:func:`VIDIOC_STREAMOFF` and :c:func:`VIDIOC_STREAMON` on the
> >>> +     ``OUTPUT`` queue - the encoder will resume operation normally, however any
> >>> +     source frames queued to the ``OUTPUT`` queue between ``V4L2_ENC_CMD_STOP``
> >>> +     and :c:func:`VIDIOC_STREAMOFF` will be discarded.
> >>> +
> >>> +.. note::
> >>> +
> >>> +   Once the drain sequence is initiated, the client needs to drive it to
> >>> +   completion, as described by the steps above, unless it aborts the process by
> >>> +   issuing :c:func:`VIDIOC_STREAMOFF` on any of the ``OUTPUT`` or ``CAPTURE``
> >>> +   queues.  The client is not allowed to issue ``V4L2_ENC_CMD_START`` or
> >>> +   ``V4L2_ENC_CMD_STOP`` again while the drain sequence is in progress and they
> >>> +   will fail with -EBUSY error code if attempted.
> >>
> >> I assume calling STOP again once the drain sequence completed just returns 0 and
> >> doesn't do anything else (since we're already stopped).
> >>
> >
> > Right.
> >
> >>> +
> >>> +   Although mandatory, the availability of encoder commands may be queried
> >>> +   using :c:func:`VIDIOC_TRY_ENCODER_CMD`.
> >>
> >> Some corner cases:
> >>
> >> 1) No buffers are queued on either vb2_queue, but STREAMON is called for both queues.
> >>    Now ENC_CMD_STOP is issued. What should happen?
> >>
> >>    Proposal: the next time the applications queues a CAPTURE buffer it is returned
> >>    at once as an empty buffer with FLAG_LAST set.
> >>
> >
> > SGTM. It's actually similar to a relatively common case where all
> > CAPTURE buffers have been dequeued and the application has to refill
> > the CAPTURE queue, but in the meantime a drain request needs to be
> > issued.
> >
> >> 2) Both queues are streaming and buffers have been encoded, but currently no buffers
> >>    are queued on either vb2_queue. Now ENC_CMD_STOP is issued. What should happen?
> >>
> >>    Proposal: the next time the applications queues a CAPTURE buffer it is returned
> >>    at once as an empty buffer with FLAG_LAST set. This is consistent with the
> >>    previous corner case.
> >
> > Agreed.
> >
> >>
> >> 3) The CAPTURE queue contains buffers, the OUTPUT queue does not. Now ENC_CMD_STOP
> >>    is issued. What should happen?
> >>
> >>    Proposal: the oldest CAPTURE buffer in the ready queue is returned as an empty
> >>    buffer with FLAG_LAST set.
> >
> > Generally agreed, but not sure if there is a reason to specifically
> > refer to the oldest buffer. (I'm personally for keeping the queues
> > ordered, though...)
>
> Feel free to rephrase. Perhaps: "an empty CAPTURE buffer with FLAG_LAST set should be
> queued up for userspace to signal that the encoder has stopped." Or something along
> those lines.

I've added a note:

   For reference, handling of various corner cases is described below:

   * In case of no buffer in the ``OUTPUT`` queue at the time the
     ``V4L2_ENC_CMD_STOP`` command was issued, the drain sequence completes
     immediately and the encoder returns an empty ``CAPTURE`` buffer with the
     ``V4L2_BUF_FLAG_LAST`` flag set.

   * In case of no buffer in the ``CAPTURE`` queue at the time the drain
     sequence completes, the next time the client queues a ``CAPTURE`` buffer
     it is returned at once as an empty buffer with the ``V4L2_BUF_FLAG_LAST``
     flag set.

   * If :c:func:`VIDIOC_STREAMOFF` is called on the ``CAPTURE`` queue in the
     middle of the drain sequence, the drain sequence is cancelled and all
     ``CAPTURE`` buffers are implicitly returned to the userpace.

   * If :c:func:`VIDIOC_STREAMOFF` is called on the ``OUTPUT`` queue in the
     middle of the drain sequence, the drain sequence completes immediately and
     next ``CAPTURE`` buffer will be returned empty with the
     ``V4L2_BUF_FLAG_LAST`` flag set.

Slightly changed the split into cases to cover behaviors rather than
conditions. WDYT?

Best regards,
Tomasz

>
> Regards,
>
>         Hans
>
> >
> >>
> >> 4) Both queues have queued buffers. ENC_CMD_STOP is issued to start the drain process.
> >>    Before the drain process completes STREAMOFF is called for either CAPTURE or
> >>    OUTPUT queue. What should happen?
> >>
> >>    Proposal for STREAMOFF(CAPTURE): aborts the drain process and all CAPTURE buffers are
> >>    returned to userspace. If encoding is restarted, then any remaining OUTPUT buffers
> >>    will be used as input to the encoder.
> >>
> >
> > Agreed.
> >
> >>    Proposal for STREAMOFF(OUTPUT): the next capture buffer will be empty and have
> >>    FLAG_LAST set.
> >
> > Agreed.
> >
> >>
> >> Some of this might have to be documented, but these corner cases should certainly be
> >> tested by v4l2-compliance. Before I write those tests I'd like to know if you agree
> >> with this.
> >
> > Agreed with just one minor comment. Thanks for checking with me!
> >
> > Best regards,
> > Tomasz
> >
>
