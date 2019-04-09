Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A720C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FDA320651
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B7PBfKlB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfDIJnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:43:49 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46834 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfDIJns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:43:48 -0400
Received: by mail-oi1-f196.google.com with SMTP id x188so12949573oia.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 02:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M9Zaom9V3GQHDePgi8JkUzY5eENAYE9Vl1F7+gTeKI0=;
        b=B7PBfKlBhb4xl/IwLozAO2uBOsEMQhK44U7wUjbBXCpHgKyWoNayK5CpUrYPF/Dh38
         LaFx13pwVfODHIvfeZjoZKiba2Nt8OtK7+C2spANp7pONymOY5/zNmLmmgoaNGtSmg7+
         hFzcBfTDa+CF+UKagY6Fq2yWJYfxOryFOh8kM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M9Zaom9V3GQHDePgi8JkUzY5eENAYE9Vl1F7+gTeKI0=;
        b=tVj+ANqNEuBK31WS5MmP7vgMJoVDcZzAK+iVa1b4vnV1WsjFAqCQLXpA9/18jFoGip
         ZycYy1ZFlxNShhy/RJiQXWjZWyAOhwsRKHYQassWNeLixHj5hXZTraYPMSDh1SUJym8f
         jFYXn/Rr2NHdrhhwvv9I5JjUzv/UKr2eqJkQjMHDj+CbxI7HmVK0xMxF0w/F6PqR2cy7
         iMT2maezgT7FYlTNCdH3tz1qb1ogHXPP8GrcOfQPXzWTV+hcLSBk9wgITu/T+h7tOm69
         +LzB9FxBK0mSXFL8baOwy7BWekyBGhIOgR7lGdI760bp8yq4TOij+6C+t7s44xWdNsND
         qYZg==
X-Gm-Message-State: APjAAAVvTwj8GPX0lc/Ax2VR8XBJr9717SsY5X8wIdBSspsix/tkE/GB
        jZinxwJViFTjfIcwfLpvtVGWRzXR4ko=
X-Google-Smtp-Source: APXvYqxr2P1+g5ddh8GmUmr7j0Ykx0KLJT7t9rU2v71DF9BF52FDcOxn5f7OhtvDgb40k9dw5/ARjg==
X-Received: by 2002:aca:c683:: with SMTP id w125mr19526909oif.144.1554803026365;
        Tue, 09 Apr 2019 02:43:46 -0700 (PDT)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com. [209.85.167.178])
        by smtp.gmail.com with ESMTPSA id j82sm7967145oih.31.2019.04.09.02.43.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 02:43:45 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id v84so13003150oif.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 02:43:45 -0700 (PDT)
X-Received: by 2002:aca:a894:: with SMTP id r142mr19214647oie.112.1554803024849;
 Tue, 09 Apr 2019 02:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190124100419.26492-1-tfiga@chromium.org> <20190124100419.26492-3-tfiga@chromium.org>
 <cb3c73e0-9481-54d1-8730-69e51655d7d8@xs4all.nl> <CAAFQd5AqRzGehW6fN4P=_oVdPdH+bJQqKhxgP6zsu80p-74bXA@mail.gmail.com>
 <fded491f-8a25-3283-76c4-dee3dd56045e@xs4all.nl> <CAAFQd5CYT=eA_eFyHLTePBQatOBVwsoDjAfMoybJeWrO7V-raA@mail.gmail.com>
 <2376896b-0087-5eee-a4b9-6ad03b0fef9c@xs4all.nl>
In-Reply-To: <2376896b-0087-5eee-a4b9-6ad03b0fef9c@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 9 Apr 2019 18:43:33 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BWXhTBWM0DtakC6KgrBdXbP_3rw5V4RhV53kFzh0awvw@mail.gmail.com>
Message-ID: <CAAFQd5BWXhTBWM0DtakC6KgrBdXbP_3rw5V4RhV53kFzh0awvw@mail.gmail.com>
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

On Tue, Apr 9, 2019 at 6:37 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 4/9/19 9:11 AM, Tomasz Figa wrote:
> > On Mon, Apr 8, 2019 at 5:43 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
> >>
> >> On 4/8/19 10:36 AM, Tomasz Figa wrote:
> >>> On Mon, Mar 25, 2019 at 10:12 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
> >>>>
> >>>> Another comment found while creating compliance tests:
> >>>>
> >>>> On 1/24/19 11:04 AM, Tomasz Figa wrote:
> >>>>> +Drain
> >>>>> +=====
> >>>>> +
> >>>>> +To ensure that all the queued ``OUTPUT`` buffers have been processed and the
> >>>>> +related ``CAPTURE`` buffers are given to the client, the client must follow the
> >>>>> +drain sequence described below. After the drain sequence ends, the client has
> >>>>> +received all encoded frames for all ``OUTPUT`` buffers queued before the
> >>>>> +sequence was started.
> >>>>> +
> >>>>> +1. Begin the drain sequence by issuing :c:func:`VIDIOC_ENCODER_CMD`.
> >>>>> +
> >>>>> +   * **Required fields:**
> >>>>> +
> >>>>> +     ``cmd``
> >>>>> +         set to ``V4L2_ENC_CMD_STOP``
> >>>>> +
> >>>>> +     ``flags``
> >>>>> +         set to 0
> >>>>> +
> >>>>> +     ``pts``
> >>>>> +         set to 0
> >>>>> +
> >>>>> +   .. warning::
> >>>>> +
> >>>>> +      The sequence can be only initiated if both ``OUTPUT`` and ``CAPTURE``
> >>>>> +      queues are streaming. For compatibility reasons, the call to
> >>>>> +      :c:func:`VIDIOC_ENCODER_CMD` will not fail even if any of the queues is
> >>>>> +      not streaming, but at the same time it will not initiate the `Drain`
> >>>>> +      sequence and so the steps described below would not be applicable.
> >>>>> +
> >>>>> +2. Any ``OUTPUT`` buffers queued by the client before the
> >>>>> +   :c:func:`VIDIOC_ENCODER_CMD` was issued will be processed and encoded as
> >>>>> +   normal. The client must continue to handle both queues independently,
> >>>>> +   similarly to normal encode operation. This includes:
> >>>>> +
> >>>>> +   * queuing and dequeuing ``CAPTURE`` buffers, until a buffer marked with the
> >>>>> +     ``V4L2_BUF_FLAG_LAST`` flag is dequeued,
> >>>>> +
> >>>>> +     .. warning::
> >>>>> +
> >>>>> +        The last buffer may be empty (with :c:type:`v4l2_buffer`
> >>>>> +        ``bytesused`` = 0) and in that case it must be ignored by the client,
> >>>>> +        as it does not contain an encoded frame.
> >>>>> +
> >>>>> +     .. note::
> >>>>> +
> >>>>> +        Any attempt to dequeue more buffers beyond the buffer marked with
> >>>>> +        ``V4L2_BUF_FLAG_LAST`` will result in a -EPIPE error from
> >>>>> +        :c:func:`VIDIOC_DQBUF`.
> >>>>> +
> >>>>> +   * dequeuing processed ``OUTPUT`` buffers, until all the buffers queued
> >>>>> +     before the ``V4L2_ENC_CMD_STOP`` command are dequeued,
> >>>>> +
> >>>>> +   * dequeuing the ``V4L2_EVENT_EOS`` event, if the client subscribes to it.
> >>>>> +
> >>>>> +   .. note::
> >>>>> +
> >>>>> +      For backwards compatibility, the encoder will signal a ``V4L2_EVENT_EOS``
> >>>>> +      event when the last frame has been decoded and all frames are ready to be
> >>>>> +      dequeued. It is deprecated behavior and the client must not rely on it.
> >>>>> +      The ``V4L2_BUF_FLAG_LAST`` buffer flag should be used instead.
> >>>>> +
> >>>>> +3. Once all ``OUTPUT`` buffers queued before the ``V4L2_ENC_CMD_STOP`` call are
> >>>>> +   dequeued and the last ``CAPTURE`` buffer is dequeued, the encoder is stopped
> >>>>> +   and it will accept, but not process any newly queued ``OUTPUT`` buffers
> >>>>> +   until the client issues any of the following operations:
> >>>>> +
> >>>>> +   * ``V4L2_ENC_CMD_START`` - the encoder will not be reset and will resume
> >>>>> +     operation normally, with all the state from before the drain,
> >>>>
> >>>> I assume that calling CMD_START when *not* draining will succeed but does nothing.
> >>>>
> >>>> In other words: while draining is in progress START will return EBUSY. When draining
> >>>> was finished, then START will resume the encoder. In all other cases it just returns
> >>>> 0 since the encoder is really already started.
> >>>>
> >>>
> >>> Yes, that was the intention and seems to be the closest to the
> >>> behavior described in the existing documentation.
> >>>
> >>>>> +
> >>>>> +   * a pair of :c:func:`VIDIOC_STREAMOFF` and :c:func:`VIDIOC_STREAMON` on the
> >>>>> +     ``CAPTURE`` queue - the encoder will be reset (see the `Reset` sequence)
> >>>>> +     and then resume encoding,
> >>>>> +
> >>>>> +   * a pair of :c:func:`VIDIOC_STREAMOFF` and :c:func:`VIDIOC_STREAMON` on the
> >>>>> +     ``OUTPUT`` queue - the encoder will resume operation normally, however any
> >>>>> +     source frames queued to the ``OUTPUT`` queue between ``V4L2_ENC_CMD_STOP``
> >>>>> +     and :c:func:`VIDIOC_STREAMOFF` will be discarded.
> >>>>> +
> >>>>> +.. note::
> >>>>> +
> >>>>> +   Once the drain sequence is initiated, the client needs to drive it to
> >>>>> +   completion, as described by the steps above, unless it aborts the process by
> >>>>> +   issuing :c:func:`VIDIOC_STREAMOFF` on any of the ``OUTPUT`` or ``CAPTURE``
> >>>>> +   queues.  The client is not allowed to issue ``V4L2_ENC_CMD_START`` or
> >>>>> +   ``V4L2_ENC_CMD_STOP`` again while the drain sequence is in progress and they
> >>>>> +   will fail with -EBUSY error code if attempted.
> >>>>
> >>>> I assume calling STOP again once the drain sequence completed just returns 0 and
> >>>> doesn't do anything else (since we're already stopped).
> >>>>
> >>>
> >>> Right.
> >>>
> >>>>> +
> >>>>> +   Although mandatory, the availability of encoder commands may be queried
> >>>>> +   using :c:func:`VIDIOC_TRY_ENCODER_CMD`.
> >>>>
> >>>> Some corner cases:
> >>>>
> >>>> 1) No buffers are queued on either vb2_queue, but STREAMON is called for both queues.
> >>>>    Now ENC_CMD_STOP is issued. What should happen?
> >>>>
> >>>>    Proposal: the next time the applications queues a CAPTURE buffer it is returned
> >>>>    at once as an empty buffer with FLAG_LAST set.
> >>>>
> >>>
> >>> SGTM. It's actually similar to a relatively common case where all
> >>> CAPTURE buffers have been dequeued and the application has to refill
> >>> the CAPTURE queue, but in the meantime a drain request needs to be
> >>> issued.
> >>>
> >>>> 2) Both queues are streaming and buffers have been encoded, but currently no buffers
> >>>>    are queued on either vb2_queue. Now ENC_CMD_STOP is issued. What should happen?
> >>>>
> >>>>    Proposal: the next time the applications queues a CAPTURE buffer it is returned
> >>>>    at once as an empty buffer with FLAG_LAST set. This is consistent with the
> >>>>    previous corner case.
> >>>
> >>> Agreed.
> >>>
> >>>>
> >>>> 3) The CAPTURE queue contains buffers, the OUTPUT queue does not. Now ENC_CMD_STOP
> >>>>    is issued. What should happen?
> >>>>
> >>>>    Proposal: the oldest CAPTURE buffer in the ready queue is returned as an empty
> >>>>    buffer with FLAG_LAST set.
> >>>
> >>> Generally agreed, but not sure if there is a reason to specifically
> >>> refer to the oldest buffer. (I'm personally for keeping the queues
> >>> ordered, though...)
> >>
> >> Feel free to rephrase. Perhaps: "an empty CAPTURE buffer with FLAG_LAST set should be
> >> queued up for userspace to signal that the encoder has stopped." Or something along
> >> those lines.
> >
> > I've added a note:
> >
> >    For reference, handling of various corner cases is described below:
> >
> >    * In case of no buffer in the ``OUTPUT`` queue at the time the
> >      ``V4L2_ENC_CMD_STOP`` command was issued, the drain sequence completes
> >      immediately and the encoder returns an empty ``CAPTURE`` buffer with the
> >      ``V4L2_BUF_FLAG_LAST`` flag set.
> >
> >    * In case of no buffer in the ``CAPTURE`` queue at the time the drain
> >      sequence completes, the next time the client queues a ``CAPTURE`` buffer
> >      it is returned at once as an empty buffer with the ``V4L2_BUF_FLAG_LAST``
> >      flag set.
> >
> >    * If :c:func:`VIDIOC_STREAMOFF` is called on the ``CAPTURE`` queue in the
> >      middle of the drain sequence, the drain sequence is cancelled and all
>
> cancelled -> canceled
>
> >      ``CAPTURE`` buffers are implicitly returned to the userpace.
>
> userpace -> userspace
>

Actually changed it to "client".

> >
> >    * If :c:func:`VIDIOC_STREAMOFF` is called on the ``OUTPUT`` queue in the
> >      middle of the drain sequence, the drain sequence completes immediately and
> >      next ``CAPTURE`` buffer will be returned empty with the
> >      ``V4L2_BUF_FLAG_LAST`` flag set.
> >
> > Slightly changed the split into cases to cover behaviors rather than
> > conditions. WDYT?
>
> Looks good (with those two typos fixed).
>

Thanks.

>         Hans
>
> >
> > Best regards,
> > Tomasz
> >
> >>
> >> Regards,
> >>
> >>         Hans
> >>
> >>>
> >>>>
> >>>> 4) Both queues have queued buffers. ENC_CMD_STOP is issued to start the drain process.
> >>>>    Before the drain process completes STREAMOFF is called for either CAPTURE or
> >>>>    OUTPUT queue. What should happen?
> >>>>
> >>>>    Proposal for STREAMOFF(CAPTURE): aborts the drain process and all CAPTURE buffers are
> >>>>    returned to userspace. If encoding is restarted, then any remaining OUTPUT buffers
> >>>>    will be used as input to the encoder.
> >>>>
> >>>
> >>> Agreed.
> >>>
> >>>>    Proposal for STREAMOFF(OUTPUT): the next capture buffer will be empty and have
> >>>>    FLAG_LAST set.
> >>>
> >>> Agreed.
> >>>
> >>>>
> >>>> Some of this might have to be documented, but these corner cases should certainly be
> >>>> tested by v4l2-compliance. Before I write those tests I'd like to know if you agree
> >>>> with this.
> >>>
> >>> Agreed with just one minor comment. Thanks for checking with me!
> >>>
> >>> Best regards,
> >>> Tomasz
> >>>
> >>
>
