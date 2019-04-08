Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63219C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D48D20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZLJS3jQc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfDHIpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:45:38 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37246 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfDHIpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:45:38 -0400
Received: by mail-ot1-f66.google.com with SMTP id c16so11278766otn.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 01:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gfB/+HH2Y90ngpWF2hXnVfTL5WVsKawglkZ367ON6Yw=;
        b=ZLJS3jQcy3l7EsGGor7w9vQ9Y9pvGpXP9+68eDcOBYInI1JQZ+k3ts4Km/jE+diO1K
         uT/do7j91xEaz5uwAvjY1eQ96S44PbAz8hZeGpUhBNtlf0M4NpNFjzixwgCqISr9dHuQ
         D4BXlVH9aMLYreqw6/WUA0E0TAQGU8yevYJVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gfB/+HH2Y90ngpWF2hXnVfTL5WVsKawglkZ367ON6Yw=;
        b=kwLxugme5N7Z9AFDYT/1fmi6S1VOw4dJtkYLaUKxPigkWKJEQTxTFnWJJEHrVHE1Hl
         6lEMRS1rGdTYB7lZgUcB8X2E923/Ot30+2G+KuAmviY6ZSyd+HkOetYjpWFTSdyxNdx0
         K4MWuWltIdemGqN1XZ0sj4THp/qnuJsn1ZJHclqJevRijDtQL9OBIeq0d08ot6BTXvyR
         X6uiaKq3S0sgvUFZAGGQPhlFj1Q5ZRJLm77lE9Q1k55Pe5fxQYYCtgwu7FySoftBXOZK
         DwIfGeyx+boCcthifzetDJuqrgzBLl2t7oNlqLMW9HLJx1yVymqdjRShIHCTvC966V51
         zVag==
X-Gm-Message-State: APjAAAU16c4U78UYcy+DguANgVNvI1asTqBhLLXITNKlayIJyBUdass0
        SmctcgvkOKcuzjO/chlbYeDU6Qephk4=
X-Google-Smtp-Source: APXvYqwHl+27WPz8/rlrTwx1VF5htNKtB44BCY5uRaOmflSKqtphlngK64U49boA9bR6c9fWwHe0fA==
X-Received: by 2002:a9d:7f0b:: with SMTP id j11mr17115739otq.132.1554713137447;
        Mon, 08 Apr 2019 01:45:37 -0700 (PDT)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com. [209.85.210.44])
        by smtp.gmail.com with ESMTPSA id m206sm11505458oif.50.2019.04.08.01.45.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 01:45:37 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id u15so11226194otq.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 01:45:37 -0700 (PDT)
X-Received: by 2002:a9d:57c2:: with SMTP id q2mr17945611oti.313.1554712818654;
 Mon, 08 Apr 2019 01:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190124100419.26492-1-tfiga@chromium.org> <20190124100419.26492-3-tfiga@chromium.org>
 <cb3c73e0-9481-54d1-8730-69e51655d7d8@xs4all.nl> <7528bda2-a5a1-8f06-603c-00b7990c8bce@xs4all.nl>
In-Reply-To: <7528bda2-a5a1-8f06-603c-00b7990c8bce@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 8 Apr 2019 17:40:07 +0900
X-Gmail-Original-Message-ID: <CAAFQd5D-X=Fq8am0qmoLJ6dw6-ffy2_Bg=Z3wan4Ko3BwE6aaA@mail.gmail.com>
Message-ID: <CAAFQd5D-X=Fq8am0qmoLJ6dw6-ffy2_Bg=Z3wan4Ko3BwE6aaA@mail.gmail.com>
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

On Tue, Mar 26, 2019 at 1:33 AM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 3/25/19 2:12 PM, Hans Verkuil wrote:
> > Another comment found while creating compliance tests:
> >
> > On 1/24/19 11:04 AM, Tomasz Figa wrote:
> >> +Drain
> >> +=====
> >> +
> >> +To ensure that all the queued ``OUTPUT`` buffers have been processed and the
> >> +related ``CAPTURE`` buffers are given to the client, the client must follow the
> >> +drain sequence described below. After the drain sequence ends, the client has
> >> +received all encoded frames for all ``OUTPUT`` buffers queued before the
> >> +sequence was started.
> >> +
> >> +1. Begin the drain sequence by issuing :c:func:`VIDIOC_ENCODER_CMD`.
> >> +
> >> +   * **Required fields:**
> >> +
> >> +     ``cmd``
> >> +         set to ``V4L2_ENC_CMD_STOP``
> >> +
> >> +     ``flags``
> >> +         set to 0
> >> +
> >> +     ``pts``
> >> +         set to 0
> >> +
> >> +   .. warning::
> >> +
> >> +      The sequence can be only initiated if both ``OUTPUT`` and ``CAPTURE``
> >> +      queues are streaming. For compatibility reasons, the call to
> >> +      :c:func:`VIDIOC_ENCODER_CMD` will not fail even if any of the queues is
> >> +      not streaming, but at the same time it will not initiate the `Drain`
> >> +      sequence and so the steps described below would not be applicable.
> >> +
> >> +2. Any ``OUTPUT`` buffers queued by the client before the
> >> +   :c:func:`VIDIOC_ENCODER_CMD` was issued will be processed and encoded as
> >> +   normal. The client must continue to handle both queues independently,
> >> +   similarly to normal encode operation. This includes:
> >> +
> >> +   * queuing and dequeuing ``CAPTURE`` buffers, until a buffer marked with the
> >> +     ``V4L2_BUF_FLAG_LAST`` flag is dequeued,
> >> +
> >> +     .. warning::
> >> +
> >> +        The last buffer may be empty (with :c:type:`v4l2_buffer`
> >> +        ``bytesused`` = 0) and in that case it must be ignored by the client,
> >> +        as it does not contain an encoded frame.
> >> +
> >> +     .. note::
> >> +
> >> +        Any attempt to dequeue more buffers beyond the buffer marked with
> >> +        ``V4L2_BUF_FLAG_LAST`` will result in a -EPIPE error from
> >> +        :c:func:`VIDIOC_DQBUF`.
> >> +
> >> +   * dequeuing processed ``OUTPUT`` buffers, until all the buffers queued
> >> +     before the ``V4L2_ENC_CMD_STOP`` command are dequeued,
> >> +
> >> +   * dequeuing the ``V4L2_EVENT_EOS`` event, if the client subscribes to it.
> >> +
> >> +   .. note::
> >> +
> >> +      For backwards compatibility, the encoder will signal a ``V4L2_EVENT_EOS``
> >> +      event when the last frame has been decoded and all frames are ready to be
> >> +      dequeued. It is deprecated behavior and the client must not rely on it.
> >> +      The ``V4L2_BUF_FLAG_LAST`` buffer flag should be used instead.
> >> +
> >> +3. Once all ``OUTPUT`` buffers queued before the ``V4L2_ENC_CMD_STOP`` call are
> >> +   dequeued and the last ``CAPTURE`` buffer is dequeued, the encoder is stopped
> >> +   and it will accept, but not process any newly queued ``OUTPUT`` buffers
> >> +   until the client issues any of the following operations:
> >> +
> >> +   * ``V4L2_ENC_CMD_START`` - the encoder will not be reset and will resume
> >> +     operation normally, with all the state from before the drain,
> >
> > I assume that calling CMD_START when *not* draining will succeed but does nothing.
> >
> > In other words: while draining is in progress START will return EBUSY. When draining
> > was finished, then START will resume the encoder. In all other cases it just returns
> > 0 since the encoder is really already started.
> >
> >> +
> >> +   * a pair of :c:func:`VIDIOC_STREAMOFF` and :c:func:`VIDIOC_STREAMON` on the
> >> +     ``CAPTURE`` queue - the encoder will be reset (see the `Reset` sequence)
> >> +     and then resume encoding,
> >> +
> >> +   * a pair of :c:func:`VIDIOC_STREAMOFF` and :c:func:`VIDIOC_STREAMON` on the
> >> +     ``OUTPUT`` queue - the encoder will resume operation normally, however any
> >> +     source frames queued to the ``OUTPUT`` queue between ``V4L2_ENC_CMD_STOP``
> >> +     and :c:func:`VIDIOC_STREAMOFF` will be discarded.
> >> +
> >> +.. note::
> >> +
> >> +   Once the drain sequence is initiated, the client needs to drive it to
> >> +   completion, as described by the steps above, unless it aborts the process by
> >> +   issuing :c:func:`VIDIOC_STREAMOFF` on any of the ``OUTPUT`` or ``CAPTURE``
> >> +   queues.  The client is not allowed to issue ``V4L2_ENC_CMD_START`` or
> >> +   ``V4L2_ENC_CMD_STOP`` again while the drain sequence is in progress and they
> >> +   will fail with -EBUSY error code if attempted.
> >
> > I assume calling STOP again once the drain sequence completed just returns 0 and
> > doesn't do anything else (since we're already stopped).
> >
> >> +
> >> +   Although mandatory, the availability of encoder commands may be queried
> >> +   using :c:func:`VIDIOC_TRY_ENCODER_CMD`.
> >
> > Some corner cases:
> >
> > 1) No buffers are queued on either vb2_queue, but STREAMON is called for both queues.
> >    Now ENC_CMD_STOP is issued. What should happen?
> >
> >    Proposal: the next time the applications queues a CAPTURE buffer it is returned
> >    at once as an empty buffer with FLAG_LAST set.
> >
> > 2) Both queues are streaming and buffers have been encoded, but currently no buffers
> >    are queued on either vb2_queue. Now ENC_CMD_STOP is issued. What should happen?
> >
> >    Proposal: the next time the applications queues a CAPTURE buffer it is returned
> >    at once as an empty buffer with FLAG_LAST set. This is consistent with the
> >    previous corner case.
> >
> > 3) The CAPTURE queue contains buffers, the OUTPUT queue does not. Now ENC_CMD_STOP
> >    is issued. What should happen?
> >
> >    Proposal: the oldest CAPTURE buffer in the ready queue is returned as an empty
> >    buffer with FLAG_LAST set.
> >
> > 4) Both queues have queued buffers. ENC_CMD_STOP is issued to start the drain process.
> >    Before the drain process completes STREAMOFF is called for either CAPTURE or
> >    OUTPUT queue. What should happen?
> >
> >    Proposal for STREAMOFF(CAPTURE): aborts the drain process and all CAPTURE buffers are
> >    returned to userspace. If encoding is restarted, then any remaining OUTPUT buffers
> >    will be used as input to the encoder.
> >
> >    Proposal for STREAMOFF(OUTPUT): the next capture buffer will be empty and have
> >    FLAG_LAST set.
>
> Note: I'm not quite sure about that last one yet. It's a bit tricky to implement.
>
> I think some of these rules might have to be implemented in v4l2-mem2mem.c to
> simplify drivers.

Most of the drivers would implement drain as a fake buffer inserted
into the driver-internal queue of source buffers. They also normally
have to iterate over the remaining buffers in that queue when
.stop_streaming() is called. If they find the fake buffer there, they
should return an empty buffer. The problematic case is when there is
no buffer in the CAPTURE queue. It would require the driver to
remember that the drain ended and check for that when next CAPTURE
buffer is queued. I guess that would converge with cases 1) and 2),
though.

Best regards,
Tomasz
