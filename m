Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B407C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430E320868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfDPHzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:55:55 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:52789 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfDPHzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 03:55:53 -0400
X-Originating-IP: 90.88.18.121
Received: from aptenodytes (aaubervilliers-681-1-63-121.w90-88.abo.wanadoo.fr [90.88.18.121])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 220631C0011;
        Tue, 16 Apr 2019 07:55:49 +0000 (UTC)
Message-ID: <0f4775b1bb04e136e3a425df0ba6a201594acdbd.camel@bootlin.com>
Subject: Re: [PATCH v4] media: docs-rst: Document m2m stateless video
 decoder interface
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Alexandre Courbot <acourbot@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Dafna Hirschfeld <dafna3@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 16 Apr 2019 09:55:49 +0200
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

Le mardi 16 avril 2019 à 16:22 +0900, Alexandre Courbot a écrit :

[...]

> Thanks for this great discussion. Let me try to summarize the status
> of this thread + the IRC discussion and add my own thoughts:
> 
> Proper support for multiple decoding units (e.g. H.264 slices) per
> frame should not be an afterthought ; compliance to encoded formats
> depend on it, and the benefit of lower latency is a significant
> consideration for vendors.
>
> m2m, which we use for all stateless codecs, has a strong assumption
> that one OUTPUT buffer consumed results in one CAPTURE buffer being
> produced. This assumption can however be overruled: at least the venus
> driver does it to implement the stateful specification.
> 
> So we need a way to specify frame boundaries when submitting encoded
> content to the driver. One request should contain a single OUTPUT
> buffer, containing a single decoding unit, but we need a way to
> specify whether the driver should directly produce a CAPTURE buffer
> from this request, or keep using the same CAPTURE buffer with
> subsequent requests.
> 
> I can think of 2 ways this can be expressed:
> 1) We keep the current m2m behavior as the default (a CAPTURE buffer
> is produced), and add a flag to ask the driver to change that behavior
> and hold on the CAPTURE buffer and reuse it with the next request(s) ;

That would kind of break the stateless idea. I think we need requests
to be fully independent of eachother and have some entity that
coordinates requests for this kind of things.

> 2) We specify that no CAPTURE buffer is produced by default, unless a
> flag asking so is specified.
> 
> The flag could be specified in one of two ways:
> a) As a new v4l2_buffer.flag for the OUTPUT buffer ;
> b) As a dedicated control, either format-specific or more common to all codecs.

I think we must aim for a generic solution that would be at least
common to all codecs, and if possible common to requests regardless of
whether they concern video decoding or not.

I really like the idea of introducing a requests batch/group/queue,
which groups requests together and allows marking them done when the
whole group is done being decoded. For that, we explicitly mark one of
the requests as the final one, so that we can continue adding requests
to the batch even when it's already being processed. When all the
requests are done being decoded, we can mark them done.

With that, we also need some tweaking in the core to look for an
available capture buffer that matches the output buffer's timestamp
before trying to dequeue the next available capture buffer. This way,
the first request of the batch will get any queued capture buffer, but
subsequent requests will find the matchung capture buffer by timestamp.

I think that's basically all we need to handle that and the two aspects
(picking by timestamp and requests groups) are rather independent and
the latter could probably be used in other situations than video
decoding.

What do you think?

Cheers,

Paul

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
> 
> An extra constraint to enforce would be that each decoding unit
> belonging to the same frame must be submitted with the same timestamp,
> otherwise the request submission would fail. We really need a
> framework to enforce all this at a higher level than individual
> drivers, once we reach an agreement I will start working on this.
> 
> Formats that do not support multiple decoding units per frame would
> reject any request that does not carry the end-of-frame information.
> 
> Anything missing / any further comment?
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

