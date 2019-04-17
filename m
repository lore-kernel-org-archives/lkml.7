Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C99EC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 05:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46B320675
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 05:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W99qBBpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbfDQFkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 01:40:05 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45281 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfDQFkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 01:40:04 -0400
Received: by mail-oi1-f194.google.com with SMTP id y84so19007727oia.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 22:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YkGjzQJzuxy9380uGfSkjvLTDPxPOGfZUd85dURFAYU=;
        b=W99qBBpIE+AZIRtQui0OFZeD192wHghWIkp4pYSnKPq46t2lrMLGEUHiGs6IOKWLyK
         2ryA70BVVJBhwkKybWjWDJgrc5JbheMBbEIXYfyqJnmglXiEHq2SabvOXmezRmgvQKEf
         h5UNwX+4v+yN3WoHuCshV3LFrQjAZgykvWSBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YkGjzQJzuxy9380uGfSkjvLTDPxPOGfZUd85dURFAYU=;
        b=NCe3cxwadbIPOJ5XVSOQ2mY9SyjE70bFjth7bIPmTn/kraIGRFv0PoDyrjWdP/StYQ
         /kFYCrhB9XeK1/Elvb5U9vWsT8Zofqknozh6MIG5X2WmeAn7BMO8UfB4j1B2K6A1YDaU
         QV7h6OvGS2sIsuIqnxlwDoMRUpUaoHl11QTdQYFLIeQHQVLqst4O0XpwQJlYqwiGq0do
         gd5eNgYGtnlIh88ZLGxEblKWP3Bz0W38ANlwcfXXOr9vqU9F7LPy+qAwVXot/cNkHbLd
         77reytqQB2jM2+9UAwKXWW9+8F0L7qz+87xNXeqodG0twU07B5L/1yyvPjBa33hKPZWr
         tveA==
X-Gm-Message-State: APjAAAWEk1TJGqHI5M8Jdpp8AaXNqb1hsQ5EqCV00I9iicACYQF2gC0r
        pSFVvq6wIGgjh3aSSlqnGIlQXiMXYyc=
X-Google-Smtp-Source: APXvYqxbsFpWbLbtmymqhFzKhE8tjcLbZqpXBbl9BKUJWWuBLzSHCKsA36Zq5/lIf2uNEzR7Uwu6sw==
X-Received: by 2002:aca:7513:: with SMTP id q19mr23837211oic.50.1555479603670;
        Tue, 16 Apr 2019 22:40:03 -0700 (PDT)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com. [209.85.210.49])
        by smtp.gmail.com with ESMTPSA id b23sm20860798otl.55.2019.04.16.22.40.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 22:40:03 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id f10so19672852otb.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 22:40:02 -0700 (PDT)
X-Received: by 2002:a05:6830:1248:: with SMTP id s8mr1224707otp.234.1555479601993;
 Tue, 16 Apr 2019 22:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190306080019.159676-1-acourbot@chromium.org>
 <371df0e4ec9e38d83d11171cbd98f19954cbf787.camel@ndufresne.ca>
 <da5aa9ab957923a72e30b169a3c242c4fe6260f1.camel@bootlin.com>
 <c07703459c7e48904bd7fd83be1e675c70eee83c.camel@ndufresne.ca>
 <d81d0112b99feba0a1899f3722077a4aeec9860c.camel@bootlin.com>
 <439b7f57aa3ba2b2ed5b043f961ef87cb83912af.camel@ndufresne.ca>
 <59e23c5ca5bfbadf9441ea06da2e9b9b5898c6d7.camel@bootlin.com>
 <0b495143bb260cf9f8927ee541e7f001842ac5c3.camel@ndufresne.ca>
 <CAPBb6MVG+3jQcw3AuhYDYCZ0YJ0aX=TmEuM5izh12GLw9V6B8Q@mail.gmail.com> <0f4775b1bb04e136e3a425df0ba6a201594acdbd.camel@bootlin.com>
In-Reply-To: <0f4775b1bb04e136e3a425df0ba6a201594acdbd.camel@bootlin.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Wed, 17 Apr 2019 14:39:50 +0900
X-Gmail-Original-Message-ID: <CAPBb6MU4yJVJq_AasQ0p9PPxtUyt73yB-10=ATCudUTsiwKOSg@mail.gmail.com>
Message-ID: <CAPBb6MU4yJVJq_AasQ0p9PPxtUyt73yB-10=ATCudUTsiwKOSg@mail.gmail.com>
Subject: Re: [PATCH v4] media: docs-rst: Document m2m stateless video decoder interface
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Nicolas Dufresne <nicolas@ndufresne.ca>,
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

Hi Paul,

On Tue, Apr 16, 2019 at 4:55 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Hi,
>
> Le mardi 16 avril 2019 =C3=A0 16:22 +0900, Alexandre Courbot a =C3=A9crit=
 :
>
> [...]
>
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
> >
> > So we need a way to specify frame boundaries when submitting encoded
> > content to the driver. One request should contain a single OUTPUT
> > buffer, containing a single decoding unit, but we need a way to
> > specify whether the driver should directly produce a CAPTURE buffer
> > from this request, or keep using the same CAPTURE buffer with
> > subsequent requests.
> >
> > I can think of 2 ways this can be expressed:
> > 1) We keep the current m2m behavior as the default (a CAPTURE buffer
> > is produced), and add a flag to ask the driver to change that behavior
> > and hold on the CAPTURE buffer and reuse it with the next request(s) ;
>
> That would kind of break the stateless idea. I think we need requests
> to be fully independent of eachother and have some entity that
> coordinates requests for this kind of things.

Side note: the idea that stateless decoders are entirely stateless is
not completely accurate anyway. When we specify a resolution on the
OUTPUT queue, we already store some state. What matters IIUC is that
the *hardware* behaves in a stateless manner. I don't think we should
refrain from storing some internal driver state if it makes sense.

Back to the topic: the effect of this flag would just be that the
first buffer is the CAPTURE queue is not removed, i.e. the next
request will work on the same buffer. It doesn't really preserve any
state - if the next request is the beginning of a different frame,
then the previous work will be discarded and the driver will behave as
it should, not considering any previous state.

>
> > 2) We specify that no CAPTURE buffer is produced by default, unless a
> > flag asking so is specified.
> >
> > The flag could be specified in one of two ways:
> > a) As a new v4l2_buffer.flag for the OUTPUT buffer ;
> > b) As a dedicated control, either format-specific or more common to all=
 codecs.
>
> I think we must aim for a generic solution that would be at least
> common to all codecs, and if possible common to requests regardless of
> whether they concern video decoding or not.
>
> I really like the idea of introducing a requests batch/group/queue,
> which groups requests together and allows marking them done when the
> whole group is done being decoded. For that, we explicitly mark one of
> the requests as the final one, so that we can continue adding requests
> to the batch even when it's already being processed. When all the
> requests are done being decoded, we can mark them done.

I'd need to see this idea more developed (with maybe an example of the
sequence of IOCTLs) to form an opinion about it. Also would need to be
given a few examples of where this could be used outside of stateless
codecs. Then we will have to address what this means for requests:
your argument against using a "release CAPTURE buffer" flag was that
requests won't be fully independent from each other anymore, but I
don't see that situation changing with batches. Then, does the end of
a batch only means that a CAPTURE buffer should be released, or are
other actions required for non-codec use-cases? There are lots and
lots of questions like this one lurking.

>
> With that, we also need some tweaking in the core to look for an
> available capture buffer that matches the output buffer's timestamp
> before trying to dequeue the next available capture buffer

I don't think that would be strictly necessary, unless we want to be
able to decode slices from different frames before the first one is
completed?

> This way,
> the first request of the batch will get any queued capture buffer, but
> subsequent requests will find the matchung capture buffer by timestamp.
>
> I think that's basically all we need to handle that and the two aspects
> (picking by timestamp and requests groups) are rather independent and
> the latter could probably be used in other situations than video
> decoding.
>
> What do you think?

At the current point I'd like to avoid over-engineering things.
Introducing a request batch mechanism would mean more months spent
before we can set the stateless codec API in stone, and at some point
we need to settle and release something that people can use. We don't
even have clear idea of what batches would look like and in which
cases they would be used. The idea of an extra flag is simple and
AFAICT would do the job nicely, so why not proceed with this for the
time being?

Cheers,
Alex.
