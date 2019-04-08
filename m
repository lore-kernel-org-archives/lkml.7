Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCBCC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CBE920880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DwEnnLK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbfDHInU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:43:20 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38556 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfDHInU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:43:20 -0400
Received: by mail-ot1-f68.google.com with SMTP id e80so11258761ote.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 01:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cn2b5ZmcZlF/Hcq8DCZPe4LNXmCF8hhLtVtssUm+bGA=;
        b=DwEnnLK3hs+rpbTquxWX0oZlvJDcHN5xOMn2jTUYTtVPEHw7pAkymAvBMhPxi35eze
         CauC4gcpi/MplVcWlrsS8+yu5ivn02RTBEF91tiQeGFc2nUw2Y+bLiAP2TaxPH4KcNPv
         uFYtvdaT1ryQPNEYPJ6Jw5oLu/cxnl4sACHAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cn2b5ZmcZlF/Hcq8DCZPe4LNXmCF8hhLtVtssUm+bGA=;
        b=Hlkb3UU0z4Rrj1k+YY88fWjVI6MMUdg2YTlBAsp9Y2ZZOpF7YEjtvLx7dj0JLyQZ2S
         qJ6loJGpJ7K9KCO7mLRoO05FjGihFm8hhXghx2O7GmeLkxW5nWqKUIlks/3qi4ZZNcye
         DM2LvOU76H5ixygic2PSk6Cd93F1QvrXdc9n9hJLy+/9Q1EcxNyiZQwt96W0elFbpi66
         ruzhfSvud+z2i8JjC/OKhHaeBeMoQelns66Jd9az3G78AXJq4PiY3gyu8PQ8ewjdNzuZ
         Db/eR6mHxTgwhgErYbO2ZtqXCYNWaXthLyjPTtFICIWjvB3wH7LTOm7YVIs0IOQliZJa
         o2tg==
X-Gm-Message-State: APjAAAVxYzfYAWazPTi2PFjPigFwlAWjsoh4SZF2Hj2rSCt4dhvgnvOs
        e86xZRTGYqTNsN1ZU843OOtAEd8dl7c=
X-Google-Smtp-Source: APXvYqywPd5BV1aQ2ZVfMYQ/kaAHdy+vrn/I++SGi8v8+Rq9InXvAYqw7hKFcTz5i1WcTohQq8yv9g==
X-Received: by 2002:a9d:5612:: with SMTP id e18mr18968466oti.109.1554712999177;
        Mon, 08 Apr 2019 01:43:19 -0700 (PDT)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com. [209.85.167.174])
        by smtp.gmail.com with ESMTPSA id f18sm9736478otl.51.2019.04.08.01.43.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 01:43:18 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id a6so9853769oie.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 01:43:18 -0700 (PDT)
X-Received: by 2002:aca:a894:: with SMTP id r142mr15406992oie.112.1554712584587;
 Mon, 08 Apr 2019 01:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190124100419.26492-1-tfiga@chromium.org> <20190124100419.26492-3-tfiga@chromium.org>
 <cb3c73e0-9481-54d1-8730-69e51655d7d8@xs4all.nl>
In-Reply-To: <cb3c73e0-9481-54d1-8730-69e51655d7d8@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 8 Apr 2019 17:36:11 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AqRzGehW6fN4P=_oVdPdH+bJQqKhxgP6zsu80p-74bXA@mail.gmail.com>
Message-ID: <CAAFQd5AqRzGehW6fN4P=_oVdPdH+bJQqKhxgP6zsu80p-74bXA@mail.gmail.com>
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

On Mon, Mar 25, 2019 at 10:12 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> Another comment found while creating compliance tests:
>
> On 1/24/19 11:04 AM, Tomasz Figa wrote:
> > +Drain
> > +=====
> > +
> > +To ensure that all the queued ``OUTPUT`` buffers have been processed and the
> > +related ``CAPTURE`` buffers are given to the client, the client must follow the
> > +drain sequence described below. After the drain sequence ends, the client has
> > +received all encoded frames for all ``OUTPUT`` buffers queued before the
> > +sequence was started.
> > +
> > +1. Begin the drain sequence by issuing :c:func:`VIDIOC_ENCODER_CMD`.
> > +
> > +   * **Required fields:**
> > +
> > +     ``cmd``
> > +         set to ``V4L2_ENC_CMD_STOP``
> > +
> > +     ``flags``
> > +         set to 0
> > +
> > +     ``pts``
> > +         set to 0
> > +
> > +   .. warning::
> > +
> > +      The sequence can be only initiated if both ``OUTPUT`` and ``CAPTURE``
> > +      queues are streaming. For compatibility reasons, the call to
> > +      :c:func:`VIDIOC_ENCODER_CMD` will not fail even if any of the queues is
> > +      not streaming, but at the same time it will not initiate the `Drain`
> > +      sequence and so the steps described below would not be applicable.
> > +
> > +2. Any ``OUTPUT`` buffers queued by the client before the
> > +   :c:func:`VIDIOC_ENCODER_CMD` was issued will be processed and encoded as
> > +   normal. The client must continue to handle both queues independently,
> > +   similarly to normal encode operation. This includes:
> > +
> > +   * queuing and dequeuing ``CAPTURE`` buffers, until a buffer marked with the
> > +     ``V4L2_BUF_FLAG_LAST`` flag is dequeued,
> > +
> > +     .. warning::
> > +
> > +        The last buffer may be empty (with :c:type:`v4l2_buffer`
> > +        ``bytesused`` = 0) and in that case it must be ignored by the client,
> > +        as it does not contain an encoded frame.
> > +
> > +     .. note::
> > +
> > +        Any attempt to dequeue more buffers beyond the buffer marked with
> > +        ``V4L2_BUF_FLAG_LAST`` will result in a -EPIPE error from
> > +        :c:func:`VIDIOC_DQBUF`.
> > +
> > +   * dequeuing processed ``OUTPUT`` buffers, until all the buffers queued
> > +     before the ``V4L2_ENC_CMD_STOP`` command are dequeued,
> > +
> > +   * dequeuing the ``V4L2_EVENT_EOS`` event, if the client subscribes to it.
> > +
> > +   .. note::
> > +
> > +      For backwards compatibility, the encoder will signal a ``V4L2_EVENT_EOS``
> > +      event when the last frame has been decoded and all frames are ready to be
> > +      dequeued. It is deprecated behavior and the client must not rely on it.
> > +      The ``V4L2_BUF_FLAG_LAST`` buffer flag should be used instead.
> > +
> > +3. Once all ``OUTPUT`` buffers queued before the ``V4L2_ENC_CMD_STOP`` call are
> > +   dequeued and the last ``CAPTURE`` buffer is dequeued, the encoder is stopped
> > +   and it will accept, but not process any newly queued ``OUTPUT`` buffers
> > +   until the client issues any of the following operations:
> > +
> > +   * ``V4L2_ENC_CMD_START`` - the encoder will not be reset and will resume
> > +     operation normally, with all the state from before the drain,
>
> I assume that calling CMD_START when *not* draining will succeed but does nothing.
>
> In other words: while draining is in progress START will return EBUSY. When draining
> was finished, then START will resume the encoder. In all other cases it just returns
> 0 since the encoder is really already started.
>

Yes, that was the intention and seems to be the closest to the
behavior described in the existing documentation.

> > +
> > +   * a pair of :c:func:`VIDIOC_STREAMOFF` and :c:func:`VIDIOC_STREAMON` on the
> > +     ``CAPTURE`` queue - the encoder will be reset (see the `Reset` sequence)
> > +     and then resume encoding,
> > +
> > +   * a pair of :c:func:`VIDIOC_STREAMOFF` and :c:func:`VIDIOC_STREAMON` on the
> > +     ``OUTPUT`` queue - the encoder will resume operation normally, however any
> > +     source frames queued to the ``OUTPUT`` queue between ``V4L2_ENC_CMD_STOP``
> > +     and :c:func:`VIDIOC_STREAMOFF` will be discarded.
> > +
> > +.. note::
> > +
> > +   Once the drain sequence is initiated, the client needs to drive it to
> > +   completion, as described by the steps above, unless it aborts the process by
> > +   issuing :c:func:`VIDIOC_STREAMOFF` on any of the ``OUTPUT`` or ``CAPTURE``
> > +   queues.  The client is not allowed to issue ``V4L2_ENC_CMD_START`` or
> > +   ``V4L2_ENC_CMD_STOP`` again while the drain sequence is in progress and they
> > +   will fail with -EBUSY error code if attempted.
>
> I assume calling STOP again once the drain sequence completed just returns 0 and
> doesn't do anything else (since we're already stopped).
>

Right.

> > +
> > +   Although mandatory, the availability of encoder commands may be queried
> > +   using :c:func:`VIDIOC_TRY_ENCODER_CMD`.
>
> Some corner cases:
>
> 1) No buffers are queued on either vb2_queue, but STREAMON is called for both queues.
>    Now ENC_CMD_STOP is issued. What should happen?
>
>    Proposal: the next time the applications queues a CAPTURE buffer it is returned
>    at once as an empty buffer with FLAG_LAST set.
>

SGTM. It's actually similar to a relatively common case where all
CAPTURE buffers have been dequeued and the application has to refill
the CAPTURE queue, but in the meantime a drain request needs to be
issued.

> 2) Both queues are streaming and buffers have been encoded, but currently no buffers
>    are queued on either vb2_queue. Now ENC_CMD_STOP is issued. What should happen?
>
>    Proposal: the next time the applications queues a CAPTURE buffer it is returned
>    at once as an empty buffer with FLAG_LAST set. This is consistent with the
>    previous corner case.

Agreed.

>
> 3) The CAPTURE queue contains buffers, the OUTPUT queue does not. Now ENC_CMD_STOP
>    is issued. What should happen?
>
>    Proposal: the oldest CAPTURE buffer in the ready queue is returned as an empty
>    buffer with FLAG_LAST set.

Generally agreed, but not sure if there is a reason to specifically
refer to the oldest buffer. (I'm personally for keeping the queues
ordered, though...)

>
> 4) Both queues have queued buffers. ENC_CMD_STOP is issued to start the drain process.
>    Before the drain process completes STREAMOFF is called for either CAPTURE or
>    OUTPUT queue. What should happen?
>
>    Proposal for STREAMOFF(CAPTURE): aborts the drain process and all CAPTURE buffers are
>    returned to userspace. If encoding is restarted, then any remaining OUTPUT buffers
>    will be used as input to the encoder.
>

Agreed.

>    Proposal for STREAMOFF(OUTPUT): the next capture buffer will be empty and have
>    FLAG_LAST set.

Agreed.

>
> Some of this might have to be documented, but these corner cases should certainly be
> tested by v4l2-compliance. Before I write those tests I'd like to know if you agree
> with this.

Agreed with just one minor comment. Thanks for checking with me!

Best regards,
Tomasz
