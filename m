Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD45C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442832183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I/prDYAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfCTP7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:59:22 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38701 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfCTP7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:59:22 -0400
Received: by mail-qk1-f196.google.com with SMTP id g1so10197256qki.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 08:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UjY7xwfnfx8GuXcZlCnO4xE0fpa7VNual/+JNd9N7/I=;
        b=I/prDYAEcg6YkZBV1iYtvcMNKm9wXlaVLYzOQKcqZUpRpS/RnuM5vh0czFpPmI0UfV
         iqcbpilyXpW/2Ufd1JYUMr+c515VsQNCpg/+1LHIUFErBzvH3MTGhgcMW2HmRfI4UIzQ
         g5nf/h1STtCLXWX+VCJ0Avi9LwAbhEauVT/3qNOBr6RhVqpG716eY5xHse5rmQQlDDTR
         aXb181X4oEynyOF/Zy2w9zOSlbX96dQ2TzuhSNTzbaSzxgIIccfVGzORLIn1ZmTyxxmz
         4+nBu8j4WKEar+Sky/THxfDOpX1xWD/WdCdDgo7y6KKj9h4wXMEvaPf2HCWz8qXqduG3
         3+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UjY7xwfnfx8GuXcZlCnO4xE0fpa7VNual/+JNd9N7/I=;
        b=LIbQcX0dOHUskTVI8StWFHijYPbwryJvFI292uLJk0sVX3Ip69dffOPaGV0uo0GwGj
         7xrNdDL4en+zFCTyPNGoQy6J5P6RvKjYmKdoFd3dkd6vtxe5OW5f/getf3IYiMkuFsQ0
         txdEuFPeIXkiU3u5H/M82l2aPuhzAGeA6j653OgbpGUGkD79iVyoVOv7OEKq+vMT7nIK
         /MFbP8IrYc7TU+4QTBo7Y0hxU6IAGOnakcV6siFx1RXQODExky8WGo1n8IpCg89JdvU6
         Ic7Vg4FMlSQzFoSROm+p3TbhVGA4BDKCwwgZuKiCbNfE/C81ZjsR56sF3++xbJg8aOYH
         UdIQ==
X-Gm-Message-State: APjAAAVY238uyS08rYZrugNYrLWcHRRqoC9QvCgRHTimMo8KJk5hc6We
        Bm6VbTFw94uPc/+8YGbguML969uW/qpmdPD/Kt+rww==
X-Google-Smtp-Source: APXvYqxcgQThRVM0mk5LV/2DdUxuOeuY+8BJ7HKHnoLNurhtM51WFSpqvj+iDpKGr9/DJEhRRlI7ZqLNwMOarDaYM6I=
X-Received: by 2002:a05:620a:1315:: with SMTP id o21mr7223098qkj.228.1553097561084;
 Wed, 20 Mar 2019 08:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <alpine.DEB.2.10.1903131309260.5023@lmark-linux.qualcomm.com>
 <CALAqxLUkGME+K=0g5QSja4CvN0w9z0WV60djy+5rRC+Dg-jCGg@mail.gmail.com>
 <CA+M3ks7q8QnNirk_WkaE5CmFWkEPn4uu5Hfb2kP+4d5qapHvrA@mail.gmail.com>
 <c51be371-086a-bd5b-b70a-5579f5b95320@ti.com> <CAF6AEGss21WmpF7sHGTxOEjuadSNpM6M_Z-WweK2W68FEHOFdA@mail.gmail.com>
 <CALAqxLVbdpj+T4u3jZ_5Uqda5La1Py-ZGpXSep_CCoLzWyap8A@mail.gmail.com>
 <CA+M3ks61BGPkPjNd01g32LV7YZfDpy8t100KxQhScOFgGO4KjA@mail.gmail.com> <d6f8092d-9f90-d5ff-2ab3-b1867f8f5700@ti.com>
In-Reply-To: <d6f8092d-9f90-d5ff-2ab3-b1867f8f5700@ti.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Wed, 20 Mar 2019 16:59:10 +0100
Message-ID: <CA+M3ks77ZGU-VnxV4vJkYHvtE=EwzxZCdedmXG9ceYCyt14fHQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/5 v2] DMA-BUF Heaps (destaging ION)
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Alistair Strachan <astrachan@google.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Chenbo Feng <fengc@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Liam Mark <lmark@codeaurora.org>,
        Marissa Wall <marissaw@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer. 20 mars 2019 =C3=A0 15:54, Andrew F. Davis <afd@ti.com> a =C3=A9cri=
t :
>
> On 3/20/19 4:16 AM, Benjamin Gaignard wrote:
> > Le mar. 19 mars 2019 =C3=A0 23:36, John Stultz <john.stultz@linaro.org>=
 a =C3=A9crit :
> >>
> >> On Tue, Mar 19, 2019 at 2:58 PM Rob Clark <robdclark@gmail.com> wrote:
> >>>
> >>> On Tue, Mar 19, 2019 at 1:00 PM Andrew F. Davis <afd@ti.com> wrote:
> >>>>
> >>>> On 3/19/19 11:54 AM, Benjamin Gaignard wrote:
> >>>>> Le mer. 13 mars 2019 =C3=A0 23:31, John Stultz <john.stultz@linaro.=
org> a =C3=A9crit :
> >>>>>>
> >>>>>> On Wed, Mar 13, 2019 at 1:11 PM Liam Mark <lmark@codeaurora.org> w=
rote:
> >>>>>>> On Tue, 5 Mar 2019, John Stultz wrote:
> >>>>>>>>
> >>>>>>>> Eventual TODOS:
> >>>>>>>> * Reimplement page-pool for system heap (working on this)
> >>>>>>>> * Add stats accounting to system/cma heaps
> >>>>>>>> * Make the kselftest actually useful
> >>>>>>>> * Add other heaps folks see as useful (would love to get
> >>>>>>>>   some help from actual carveout/chunk users)!
> >>>>>>>
> >>>>>>> We use a modified carveout heap for certain secure use cases.
> >>>>>>
> >>>>>> Cool! It would be great to see if you have any concerns about addi=
ng
> >>>>>> such a secure-carveout heap to this framework. I suspect it would =
be
> >>>>>> fairly similar to how its integrated into ION, but particularly I'=
d be
> >>>>>> interested in issues around the lack of private flags and other
> >>>>>> allocation arguments like alignment.
> >>>>>>
> >>>>>>> Although there would probably be some benefit in discssing how th=
e dma-buf
> >>>>>>> heap framework may want to support
> >>>>>>> secure heaps in the future it is a large topic which I assume you=
 don't
> >>>>>>> want to tackle now.
> >>>>>>
> >>>>>> So I suspect others (Benjamin?) would have a more informed opinion=
 on
> >>>>>> the details, but the intent is to allow secure heap implementation=
s.
> >>>>>> I'm not sure what areas of concern you have for this allocation
> >>>>>> framework in particular?
> >>>>>
> >>>>> yes I would be great to understand how you provide the information =
to
> >>>>> tell that a dmabuf
> >>>>> is secure (or not) since we can't add flag in dmabuf structure itse=
lf.
> >>>>> An option is manage
> >>>>> the access rights when a device attach itself to the dmabuf but in
> >>>>> this case you need define
> >>>>> a list of allowed devices per heap...
> >>>>> If you have a good solution for secure heaps you are welcome :-)
> >>>>>
> >>>>
> >>>> Do we really need any of that? A secure buffer is secured by the
> >>>> hardware firewalls that keep out certain IP (including often the
> >>>> processor running Linux). So the only thing we need to track interna=
lly
> >>>> is that we should not allow mmap/kmap on the buffer. That can be don=
e in
> >>>> the per-heap layer, everything else stays the same as a standard
> >>>> carveout heap.
> >>>
> >>> For at least some hw the importing driver needs to configure things
> >>> differently for secure buffers :-/
> >>
> >> Does the import ioctl need/use a flag for that then? Userland already
> >> has to keep meta-data about dmabufs around.
> >
> > To secure a buffer you need to know who is allowed to write/read it and
> > hardware block involved in the dataflow may need to know that the buffe=
r
> > is secure to configure themself.
> > As example for a video decoding you allow hw video decoder to read in
> > a buffer and display to read it. You can also allow cpu to write on the=
 buffer
> > to add subtitles. For that we need to be able to mmap/kmap the buffer.
> > Using a carveout heap for secure buffer mean that you reserved a large
> > memory region only for this purpose, that isn't possible on embedded de=
vice
> > where we are always limited in memory so we use CMA.
> > In the past I have used dmabuf's attach function to know who write into
> > the buffer and then configure who will be able to read it. It was worki=
ng well
> > but the issue was how to in generic way this behavior.
> >
>
> Okay, I think I see what you are saying now.
>
> The way we handle secure playback is to firewall everything upfront and
> it is up to the application to inform the hardware about what it can and
> cannot do to the buffer, or simply not ask anything not allowed (E.g.
> writeback the decrypted stream) else it will get a firewall exception.
> The buffer itself doesn't have to carry any information.
>
> It sounds like you want the hardware driver to be able to detect the
> use-case based on the buffer itself and configure itself accordingly? Or
> the exporter at attach time to check access permissions?

Both are needed, the buffer client must know that it is a secure buffer and=
 heap
will have to configure the permissions.

>
> The first would need a change to DMA-BUF framework, maybe an added flag.

Sumit will NACK that because dmabuf have to remain neutral and not embedded
flags for every possible usage.

> The second would just need a heap exporter with the system wide smarts,
> but as you say that is not very generic..

yes it is difficult to find a good solution for that.

>
> Andrew
>
> >>
> >> thanks
> >> -john
