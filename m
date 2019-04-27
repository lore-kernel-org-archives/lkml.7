Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD07C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD1C208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="Mr1nwDvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfD0MXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:23:40 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43906 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD0MXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:23:40 -0400
Received: by mail-qt1-f193.google.com with SMTP id g4so7114014qtq.10
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 05:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=gwJOrf2R/le2WuCWV56IZbZUqIgAxkSxFzYXLOt3Iqs=;
        b=Mr1nwDvmmfaKU1A/dqAqqE9ORlvSzWAa787hrDjoCZ6spuG9pm7VQ/bdTRdTmFCchj
         31pULLRD93OWpDipLNN+f6zoOuRQZCTgFn3b2tcEnrwPyBtXQW/1METUvxEkJjNdR5gw
         ZbmvQv6L+1VnwSuSJFXc/apOS07Q119m6s6/k04ruxXNOgHKENNynf0flpLXTXdsCJJa
         vC/0/k09pFNf5U5/ZD3hdGWJPtod3STan28Kf/HYIFBq06cVBhTF7zHW29kRx4mQv7Zz
         zbw6BAQc6ZUPmP1d7Aho5OOVvb2yci+KLgs9kEWF3nRGQYJuj0zyRMZefw2VCcAMra5j
         5j1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gwJOrf2R/le2WuCWV56IZbZUqIgAxkSxFzYXLOt3Iqs=;
        b=i6BhE2QkAfvNpkr4xLIvGOCWo7YTKTsctcojammtyz5xIFAwPucFcXeKQax/K9AEyI
         HeeVGKZIlgyh/8YGnr4610jqhMJt+BIZdZQMieJ5ihcMa0lMW5jgGoPMs/S4HndGy4Da
         PySO/Bn9simt2SyWHHsLE4rZvozDKa4+BB1OY9Lr+2X3/YMBD+G5H23bri/zb9gcre9e
         hZvOto+rC5ZTAuSxx3XKLK0B6lw+Xqb2WgmYqG+xjQmQppMibJGSt1CsfCU0QFk6apCd
         p1VMYF7szdHj8hbp/hctdOD6e3ds/owncBwKB6biSb/85cAaL9pR6cXVm3LH78dJrQeT
         p95Q==
X-Gm-Message-State: APjAAAW4YKvKQRep5Yrsrs/F4j4DvAqse1UImPcTazEeJHXTZvrZXCHv
        Sj06NJEreUfD6iKiaNGoLAoBnQ==
X-Google-Smtp-Source: APXvYqzqoAcTSbVR1oRN0arJBZIltQ9c4/CVeoch2HJI9If3WhiSlH7axrPVOQ1X/DAs3nTbderX1w==
X-Received: by 2002:a0c:c686:: with SMTP id d6mr30113033qvj.179.1556367818521;
        Sat, 27 Apr 2019 05:23:38 -0700 (PDT)
Received: from skullcanyon ([2002:c0de:c115:0:481e:e17e:2f68:43f8])
        by smtp.gmail.com with ESMTPSA id 50sm19122898qtq.7.2019.04.27.05.23.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 05:23:36 -0700 (PDT)
Message-ID: <353b75b98226fd22854a5aa1da3f3a93edd6f25f.camel@ndufresne.ca>
Subject: Re: [PATCH v4] media: docs-rst: Document m2m stateless video
 decoder interface
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Dafna Hirschfeld <dafna3@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sat, 27 Apr 2019 08:23:35 -0400
In-Reply-To: <2023690a879a1d30b8a686962326dd18a77156f3.camel@bootlin.com>
References: <20190306080019.159676-1-acourbot@chromium.org>
         <371df0e4ec9e38d83d11171cbd98f19954cbf787.camel@ndufresne.ca>
         <da5aa9ab957923a72e30b169a3c242c4fe6260f1.camel@bootlin.com>
         <c07703459c7e48904bd7fd83be1e675c70eee83c.camel@ndufresne.ca>
         <d81d0112b99feba0a1899f3722077a4aeec9860c.camel@bootlin.com>
         <439b7f57aa3ba2b2ed5b043f961ef87cb83912af.camel@ndufresne.ca>
         <59e23c5ca5bfbadf9441ea06da2e9b9b5898c6d7.camel@bootlin.com>
         <0b495143bb260cf9f8927ee541e7f001842ac5c3.camel@ndufresne.ca>
         <CAPBb6MVG+3jQcw3AuhYDYCZ0YJ0aX=TmEuM5izh12GLw9V6B8Q@mail.gmail.com>
         <793af82c-6b37-6f69-648e-2cd2a2e87645@xs4all.nl>
         <2023690a879a1d30b8a686962326dd18a77156f3.camel@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 (3.32.1-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 26 avril 2019 à 18:28 +0200, Paul Kocialkowski a écrit :
> Hi,
> 
> Le vendredi 26 avril 2019 à 16:18 +0200, Hans Verkuil a écrit :
> > On 4/16/19 9:22 AM, Alexandre Courbot wrote:
> > 
> > <snip>
> > 
> > > Thanks for this great discussion. Let me try to summarize the status
> > > of this thread + the IRC discussion and add my own thoughts:
> > > 
> > > Proper support for multiple decoding units (e.g. H.264 slices) per
> > > frame should not be an afterthought ; compliance to encoded formats
> > > depend on it, and the benefit of lower latency is a significant
> > > consideration for vendors.
> > > 
> > > m2m, which we use for all stateless codecs, has a strong assumption
> > > that one OUTPUT buffer consumed results in one CAPTURE buffer being
> > > produced. This assumption can however be overruled: at least the venus
> > > driver does it to implement the stateful specification.
> > > 
> > > So we need a way to specify frame boundaries when submitting encoded
> > > content to the driver. One request should contain a single OUTPUT
> > > buffer, containing a single decoding unit, but we need a way to
> > > specify whether the driver should directly produce a CAPTURE buffer
> > > from this request, or keep using the same CAPTURE buffer with
> > > subsequent requests.
> > > 
> > > I can think of 2 ways this can be expressed:
> > > 1) We keep the current m2m behavior as the default (a CAPTURE buffer
> > > is produced), and add a flag to ask the driver to change that behavior
> > > and hold on the CAPTURE buffer and reuse it with the next request(s) ;
> > > 2) We specify that no CAPTURE buffer is produced by default, unless a
> > > flag asking so is specified.
> > > 
> > > The flag could be specified in one of two ways:
> > > a) As a new v4l2_buffer.flag for the OUTPUT buffer ;
> > > b) As a dedicated control, either format-specific or more common to all codecs.
> > > 
> > > I tend to favor 2) and b) for this, for the reason that with H.264 at
> > > least, user-space does not know whether a slice is the last slice of a
> > > frame until it starts parsing the next one, and we don't know when we
> > > will receive it. If we use a control to ask that a CAPTURE buffer be
> > > produced, we can always submit another request with only that control
> > > set once it is clear that the frame is complete (and not delay
> > > decoding meanwhile). In practice I am not that familiar with
> > > latency-sensitive streaming ; maybe a smart streamer would just append
> > > an AUD NAL unit at the end of every frame and we can thus submit the
> > > flag it with the last slice without further delay?
> > > 
> > > An extra constraint to enforce would be that each decoding unit
> > > belonging to the same frame must be submitted with the same timestamp,
> > > otherwise the request submission would fail. We really need a
> > > framework to enforce all this at a higher level than individual
> > > drivers, once we reach an agreement I will start working on this.
> > > 
> > > Formats that do not support multiple decoding units per frame would
> > > reject any request that does not carry the end-of-frame information.
> > > 
> > > Anything missing / any further comment?
> > > 
> > 
> > After reading through this thread and a further irc discussion I now
> > understand the problem. I think there are several ways this can be
> > solved, but I think this is the easiest:
> > 
> > Introduce a new V4L2_BUF_FLAG_HOLD_CAPTURE_BUFFER flag.
> > 
> > If set in the OUTPUT buffer, then don't mark the CAPTURE buffer as
> > done after processing the OUTPUT buffer.
> > 
> > If an OUTPUT buffer was queued with a different timestamp than was
> > used for the currently held CAPTURE buffer, then mark that CAPTURE
> > buffer as done before starting processing this OUTPUT buffer.
> > 
> > In other words, for slicing you can just always set this flag and
> > group the slices by the OUTPUT timestamp. If you know that you
> > reached the last slice of a frame, then you can optionally clear the
> > flag to ensure the CAPTURE buffer is marked done without having to wait
> > for the first slice of the next frame to arrive.
> > 
> > Potential disadvantage of this approach is that this relies on the
> > OUTPUT timestamp to be the same for all slices of the same frame.
> > 
> > Which sounds reasonable to me.
> > 
> > In addition add a V4L2_BUF_CAP_SUPPORTS_HOLD_CAPTURE_BUFFER
> > capability to signal support for this flag.
> > 
> > I think this can be fairly easily implemented in v4l2-mem2mem.c.
> > 
> > In addition, this approach is not specific to codecs, it can be
> > used elsewhere as well (composing multiple output buffers into one
> > capture buffer is one use-case that comes to mind).
> > 
> > Comments? Other ideas?
> 
> One remark I have: this implies that the order in which requests are
> decoded will match the order in which they are submitted (in order to
> be rely on the last slice being marked as such).

Unlike my initially suggested approach, this won't mark the last slice.
Instead it marks all slices that are not the last one. If userspace is
aware of the last one, it will unmark it, otherwise the boundary will
be detected through a timestamp change.

It basically allow to run in both per-slice and per-frame, as not
setting the flag on a slice will result in the buffer being marked done
when the slice is decoded. It will likely fit more use cases outside of
CODEC and is not request specific.

> 
> In the future, we might want to be ablle to add support for parallel
> decoders that could handle multiple slices concurrently. I don't think
> the M2M internal API is ready for that currently, but it could
> certainly be extended to allow that eventually. In that case, we can't
> rely on the order in which slices will complete their decoding and the
> one slice that was marking the end of the frame may be decoded sooner
> than other slices scheduled at the same time. In this case, we end up
> having to wait for a new frame in order to mark the destination buffer
> as done, which introduces a major latency issue for the frame.

I don't see how this relates to the current design. The driver needs to
keep track of the active jobs anyway. Jobs just need to be matched
against a specific capture buffer. So initially you'd be receiving jobs
for a capture buffer. The job queue will be "open", so that if these
jobs finishes, it won't mark done the capture buffer. Then whenever one
of the two condition (no flag or new timestamp) is met, the capture is
then marked as "can be done". That might happen right away (if all
pending jobs for the capture buffer are completed) or later after the
last job have effectively completed. Regardless of the order they
completed. The order does not really matter if you have a good data
structure.

For a codec, one m2m instance will never be able to decode to multiple
capture buffer at the same time since it will likely used as reference
in the following frames. So parallelism should happen between m2m
instance. I believe we should look into the m2m scaler and color
converters for inspiration on how multi-plexing of m2m instance is
done.

> 
> So I think the problem we should be trying to resolve should be
> formulated in terms of marking the end of a group of requests as done. 
> 
> For that, my proposal is to solve the issue at the media API level, by
> introducing an entity representing a group of requests that share the
> same destination buffer. The idea would be that requests are added to
> that entity when they are submitted, and a field in the submit ioctl
> would indicate whether the request is the last one of the batch.
> 
> The destination buffer gets picked up when the first request is
> processed and all subsequent requests grouped in the entity use the
> same one. Then, we can have the media core ensure that all the requests
> of that entity are completed and that the last element of the batch was
> submitted before marking the destination buffer as done.
> 
> This presents a few advantages:
> - Userspace has a straightforward interface to group the completion of
> requests, which is independent from both our use case and v4l2;
> - This mechanism can then be used in other situations where grouping
> the completion of different requests is desirable: for instance, it
> could be used to sync two source feeds that need to be displayed
> synchronized;
> - Userspace can poll on a single file descriptor representing the
> entity, instead of having to do the book keeping of checking that each
> request was completed before dealing with the decoded buffer.
> 
> What do you think?
> 
> Cheers,
> 
> Paul
> 

