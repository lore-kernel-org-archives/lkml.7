Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06717C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF618229F3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mtl8aXY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389954AbfGYNUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:20:24 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40260 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389884AbfGYNUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:20:23 -0400
Received: by mail-qt1-f196.google.com with SMTP id a15so48978620qtn.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 06:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hksOcYMTFsQQXxPG74pF4Ev5omBJ6BpaQhz1gWRfnWA=;
        b=mtl8aXY6om467I/IRPDfWhsEihgtMKaOYEz8QL8yLJvBwx9xKAmAQPrkOp1Vo38B9/
         aQ9vOKurZmrzM8ZpTDLNbxQyxjavPEGh6EErSqOnbi8Nb6NihoL2oXkGjD5xpSAVAID6
         KjtwDJ3aVfk5Sbm9+llQAEo+pjUNBXgC3xcgI995HebYCYdNc4igLjlGb74aR6k0tuD3
         W+3FF2JHUzwCx9wpYbINO+Ons8sA/FNu226bVz+6xWI1igdZGir0lIFg+5siubDUKTBv
         9I+pykPeBgve2ZbuvF8QNefQzEEQwQ0i7ERiaS+D1vKyhdhwlu99yOb2iuPsy3gvS5bF
         H34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hksOcYMTFsQQXxPG74pF4Ev5omBJ6BpaQhz1gWRfnWA=;
        b=gVSrtbn+sbYFM3TxfP2hAv5uZfb18sQg2/OLmNcq9OhJZXfpgrtbV31qbhW4RNrlVq
         shKXOE8L+dyBp/7I9VN5q7sJTMRM6tCke+pkTAv4ru6gXBGVULnzIENNHcowZpx+eX69
         JzqesdQ/kMPvcP6USKPYMnPL4a/160vG8xJQWA6qMKlo7hBS3X6gNnFAc0R6yS72twfv
         rsQ9AXZBIFQ+6acw7duuwr+p8TX4HNOoS5NwDh4hMX2OpOhNIm6uWY5hkw2Lq2hidrpN
         5pWcNOFUV/qvnx5lVXXRJAcBFZ6JOhuUq+oJwf80WGUOqaklEqJvYFYG+DxT5Mozxx1f
         Jzxw==
X-Gm-Message-State: APjAAAX7mMySeSd/Y9mnt0AexRsTIcjtXN+uVGi7m/eJ3g5YpnlFi+/s
        EllpBP1VO/3IlDBge/bv+2Y9qM8QM9699OMWHivayg==
X-Google-Smtp-Source: APXvYqzbohpFc3U6eGc+1t9EcQe7Xduc50XTK8rY2fyUI8XmNmk8NGB9t9ex3V+pUZPDY5hCm9tEx+NwkrM8pQoP8Kg=
X-Received: by 2002:ac8:7219:: with SMTP id a25mr61991427qtp.234.1564060822527;
 Thu, 25 Jul 2019 06:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190624194908.121273-1-john.stultz@linaro.org>
 <20190624194908.121273-5-john.stultz@linaro.org> <20190718100840.GB19666@infradead.org>
 <CALAqxLWLx_tHVjZqrSNWfQ_M2RGGqh4qth3hi9GGRdSPov-gcw@mail.gmail.com>
 <20190724065958.GC16225@infradead.org> <CALAqxLUbsz+paJ=P2hwKecuN8DQjJt9Vj4MENCnFuEh6waxsXg@mail.gmail.com>
 <20190725125206.GE20286@infradead.org>
In-Reply-To: <20190725125206.GE20286@infradead.org>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Thu, 25 Jul 2019 15:20:11 +0200
Message-ID: <CA+M3ks52ADKVCw_pZP9=LSNt+vhiEFyrtB-Jm2x=p62kSV7qVA@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] dma-buf: heaps: Add CMA heap to dmabuf heaps
To:     Christoph Hellwig <hch@infradead.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Xu YiPing <xuyiping@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        butao <butao@hisilicon.com>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        Yudongbin <yudongbin@hisilicon.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu. 25 juil. 2019 =C3=A0 14:52, Christoph Hellwig <hch@infradead.org> a=
 =C3=A9crit :
>
> On Wed, Jul 24, 2019 at 11:46:24AM -0700, John Stultz wrote:
> > I'm still not understanding how this would work. Benjamin and Laura
> > already commented on this point, but for a simple example, with the
> > HiKey boards, the DRM driver requires contiguous memory for the
> > framebuffer, but the GPU can handle non-contiguous. Thus the target
> > framebuffers that we pass to the display has to be CMA allocated, but
> > all the other graphics buffers that the GPU will render to and
> > composite can be system.

No we have uses cases where graphic buffers can go directly to display with=
out
using GPU. For example we can grab frames from the camera and send them dir=
ectly
in display (same for video decoder) because we have planes for that.

>
> But that just means we need a flag that memory needs to be contiguous,
> which totally makes sense at the API level.  But CMA is not the only
> source of contigous memory, so we should not conflate the two.

We have one file descriptor per heap to be able to add access control
on each heap.
That wasn't possible with ION because the heap was selected given the
flags in ioctl
structure and we can't do access control based on that. If we put flag
to select the
allocation mechanism (system, CMA, other) in ioctl we come back to ION stat=
us.
For me one allocation mechanism =3D one heap.

>
> > Laura already touched on this, but similar logic can be used for
> > camera buffers, which can make sure we allocate from a specifically
> > reserved CMA region that is only used for the camera so we can always
> > be sure to have N free buffers immediately to capture with, etc.
>
> And for that we already have per-device CMA areas hanging off struct
> device, which this should reuse instead of adding another duplicate
> CMA area lookup scheme.
