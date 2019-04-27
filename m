Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E5CC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01C92087F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="Aup88Ctp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfD0MGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:06:47 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40088 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfD0MGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:06:47 -0400
Received: by mail-qk1-f193.google.com with SMTP id w20so3461643qka.7
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 05:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Jn0DNRgrGIDnMhpxnffP8fyZ53Hd1ACFJP7RRjDJyik=;
        b=Aup88CtppE4N15ORZkQw7DnhRQiVPZeo4XRg1At0TYSMQ1RgxF9p50dEEGWOLACLpN
         TceW+H1jArUoSFQpxlC4StIJUEBBjazPqNaQVL12UeK8ol5jkXMPpBrHdp8FEJ8rs9ye
         jOMJKGP3oNUTtZZjwUjIkSltZbPGs3bTh/elTXyDDGYa2PJFGt+QPQN1/cuwaKCuEFnp
         ORVIFcxdZTeVKa39mV4znh8zT4OsbTxEZPd2ACkwTjU3IED7UWTB29nRbCQz5PX9iKLI
         gSZ5jgWQetDB0BQcHGISlaZfCXETpOFjt5ajxUT/tbB4ZsnQUi7b3IwDDi31k7KNEevg
         YXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Jn0DNRgrGIDnMhpxnffP8fyZ53Hd1ACFJP7RRjDJyik=;
        b=o8LnSfDrIvgUVR//okAMHOnHI427PSDeS08g3YflKAe1OSEC5NTYxYvUmJhINA/ye+
         JLDouI+eFm6f3rEISN48lQgGDgQUalmJ6XoedIxIrAiUJIWdcpxv9C47WYCKMd2C2vRk
         ZIhPLI29wYNld7Hq/E2v54en9B/Azz7m3PK59BEiI46UHbER1aYxeILqmTGpevXfAvrK
         DnUrqQtvjEWHuyfTpqBJmFVyEDurChiiKT+IFqaPFnMHWSRCiAyPLfD+q6VkPGWYWBs+
         5QIyezlOhSWoiQSiJ33gjZuYfqO/wjfHOxeHJjm4iG5rL6pJdiWQ7t29/WgbOj0c7egj
         3zmg==
X-Gm-Message-State: APjAAAV9Io/YA4a9zYwh0q8hQduP3rVwevECrg/8OQJaVRHKXG9HwyG3
        wikwP5ROW9XMIpzJqvMWvD+wSA==
X-Google-Smtp-Source: APXvYqySRM4qurhCBJaPz1gGEkIIrZ8MohzCNs/u6W4LZB21E7Pz0vJQyaCVn0LxqzM1dqUjqpyTqw==
X-Received: by 2002:a37:bca:: with SMTP id 193mr24969039qkl.17.1556366805766;
        Sat, 27 Apr 2019 05:06:45 -0700 (PDT)
Received: from skullcanyon ([2002:c0de:c115:0:481e:e17e:2f68:43f8])
        by smtp.gmail.com with ESMTPSA id j5sm14802257qtb.30.2019.04.27.05.06.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 05:06:44 -0700 (PDT)
Message-ID: <f30f69af184cc80d5c56853b517943f45c90d9d9.camel@ndufresne.ca>
Subject: Re: [PATCH v4] media: docs-rst: Document m2m stateless video
 decoder interface
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Dafna Hirschfeld <dafna3@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sat, 27 Apr 2019 08:06:42 -0400
In-Reply-To: <793af82c-6b37-6f69-648e-2cd2a2e87645@xs4all.nl>
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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 (3.32.1-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 26 avril 2019 à 16:18 +0200, Hans Verkuil a écrit :
> On 4/16/19 9:22 AM, Alexandre Courbot wrote:
> 
> <snip>
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
> > 2) We specify that no CAPTURE buffer is produced by default, unless a
> > flag asking so is specified.
> > 
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
> > 
> > An extra constraint to enforce would be that each decoding unit
> > belonging to the same frame must be submitted with the same timestamp,
> > otherwise the request submission would fail. We really need a
> > framework to enforce all this at a higher level than individual
> > drivers, once we reach an agreement I will start working on this.
> > 
> > Formats that do not support multiple decoding units per frame would
> > reject any request that does not carry the end-of-frame information.
> > 
> > Anything missing / any further comment?
> > 
> 
> After reading through this thread and a further irc discussion I now
> understand the problem. I think there are several ways this can be
> solved, but I think this is the easiest:
> 
> Introduce a new V4L2_BUF_FLAG_HOLD_CAPTURE_BUFFER flag.
> 
> If set in the OUTPUT buffer, then don't mark the CAPTURE buffer as
> done after processing the OUTPUT buffer.
> 
> If an OUTPUT buffer was queued with a different timestamp than was
> used for the currently held CAPTURE buffer, then mark that CAPTURE
> buffer as done before starting processing this OUTPUT buffer.

Just a curiosity, can you extend on how this would be handled. If there
is a number of capture buffer, these should have "no-timestamp". So I
suspect we need the condition to differentiate no-timestamp from
previous timestamp. What I'm unclear is to what does it mean "no-
timestamp". We already stated the timestamp 0 cannot be reserved as
being an unset timestamp.

> 
> In other words, for slicing you can just always set this flag and
> group the slices by the OUTPUT timestamp. If you know that you
> reached the last slice of a frame, then you can optionally clear the
> flag to ensure the CAPTURE buffer is marked done without having to wait
> for the first slice of the next frame to arrive.
> 
> Potential disadvantage of this approach is that this relies on the
> OUTPUT timestamp to be the same for all slices of the same frame.
> 
> Which sounds reasonable to me.
> 
> In addition add a V4L2_BUF_CAP_SUPPORTS_HOLD_CAPTURE_BUFFER
> capability to signal support for this flag.
> 
> I think this can be fairly easily implemented in v4l2-mem2mem.c.
> 
> In addition, this approach is not specific to codecs, it can be
> used elsewhere as well (composing multiple output buffers into one
> capture buffer is one use-case that comes to mind).
> 
> Comments? Other ideas?

Sounds reasonable to me. I'll read through Paul's comment now and
comment if needed.

> 
> Regards,
> 
> 	Hans

