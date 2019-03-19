Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712A4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3631E20850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uAIGJe8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfCSWgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 18:36:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37468 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfCSWgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 18:36:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id y15so616525wro.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 15:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=71cG6l5GTA/71CCX4+CFrV/JbL1WCVvp+ptkx8iiESY=;
        b=uAIGJe8sLoeqcv9sisFtcBr49/lpRTY6Xk+STGp5rwQZkWPOC0yYmHq53YIgOxiP4O
         n/e6QrgxstHYTEmn5+xO3Lo38p8WzlMmVjPThiFhB/EQvCZRwbipxyms9S45iBsdxmpA
         F7Ad2o5uuk54M9OpjzafQMysr3K9hpAlhsk871TgR/XBwx1OrMZ02tEzsJexIjYyPOhh
         VoqGrXB/xKhv+gBG8xP6lqxgYJ9rR8oDNKSWrs6QUN3uWR2prebl5fJF+rRPcSH7wSG0
         F0eD5kz7w6KUQNF8gsAfFanTHi8e6YiclIJ11SavigAg6J4Ok3IcNnwFjjoVSPrRHkVT
         SWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=71cG6l5GTA/71CCX4+CFrV/JbL1WCVvp+ptkx8iiESY=;
        b=iOYPjyZC6cWTBkwsoFXEV8PsLhYcIFcK+23QtdGf/yVWRVc4cU2O3Q9GIQTX/Hp8aw
         9mR6UT0BmM+SQy3jV3zfx882NV/8A75IyYoFDWvmw68doiKc7zvezL1+v+VgTkp5ZhKs
         UGV/OQl0fh8Fm1zV5hmn+O4gm4Ge0WV7KdUNZhbKrSI95gP3n8qOpuXG5htf+mcGDwoK
         JF+AzgbVcbTJSPNmFCa+QY+6A4UgpbmBCGR/E84p0mts41EYeftZTfEOWgvMZSAse5iW
         CrbehpreYBkJsxuGLtW/NE+5DRQUUZ5fuBrkzNufxyQ94bHZO/YAD07IArPHm606zocC
         gO4w==
X-Gm-Message-State: APjAAAUzu/s7TXeosbBe9kjjhMz9ClVGc1Q8xTfj2ZLlgArHIDbd6baM
        GvKZzpfyOD2VC1ImyRXeGM143zqNE5qt5PecMRSyRg==
X-Google-Smtp-Source: APXvYqwaHqPhnL61INkOyi6PAct/Paz87bcRyWCg8G+nXbKY+OB7xkf+eGiBdyfWgaM1YLX5S8scoadfXtH4rQGkXrM=
X-Received: by 2002:adf:c543:: with SMTP id s3mr18154285wrf.192.1553034979529;
 Tue, 19 Mar 2019 15:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <alpine.DEB.2.10.1903131309260.5023@lmark-linux.qualcomm.com>
 <CALAqxLUkGME+K=0g5QSja4CvN0w9z0WV60djy+5rRC+Dg-jCGg@mail.gmail.com>
 <CA+M3ks7q8QnNirk_WkaE5CmFWkEPn4uu5Hfb2kP+4d5qapHvrA@mail.gmail.com>
 <c51be371-086a-bd5b-b70a-5579f5b95320@ti.com> <CAF6AEGss21WmpF7sHGTxOEjuadSNpM6M_Z-WweK2W68FEHOFdA@mail.gmail.com>
In-Reply-To: <CAF6AEGss21WmpF7sHGTxOEjuadSNpM6M_Z-WweK2W68FEHOFdA@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 19 Mar 2019 15:36:06 -0700
Message-ID: <CALAqxLVbdpj+T4u3jZ_5Uqda5La1Py-ZGpXSep_CCoLzWyap8A@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/5 v2] DMA-BUF Heaps (destaging ION)
To:     Rob Clark <robdclark@gmail.com>
Cc:     "Andrew F. Davis" <afd@ti.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
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

On Tue, Mar 19, 2019 at 2:58 PM Rob Clark <robdclark@gmail.com> wrote:
>
> On Tue, Mar 19, 2019 at 1:00 PM Andrew F. Davis <afd@ti.com> wrote:
> >
> > On 3/19/19 11:54 AM, Benjamin Gaignard wrote:
> > > Le mer. 13 mars 2019 =C3=A0 23:31, John Stultz <john.stultz@linaro.or=
g> a =C3=A9crit :
> > >>
> > >> On Wed, Mar 13, 2019 at 1:11 PM Liam Mark <lmark@codeaurora.org> wro=
te:
> > >>> On Tue, 5 Mar 2019, John Stultz wrote:
> > >>>>
> > >>>> Eventual TODOS:
> > >>>> * Reimplement page-pool for system heap (working on this)
> > >>>> * Add stats accounting to system/cma heaps
> > >>>> * Make the kselftest actually useful
> > >>>> * Add other heaps folks see as useful (would love to get
> > >>>>   some help from actual carveout/chunk users)!
> > >>>
> > >>> We use a modified carveout heap for certain secure use cases.
> > >>
> > >> Cool! It would be great to see if you have any concerns about adding
> > >> such a secure-carveout heap to this framework. I suspect it would be
> > >> fairly similar to how its integrated into ION, but particularly I'd =
be
> > >> interested in issues around the lack of private flags and other
> > >> allocation arguments like alignment.
> > >>
> > >>> Although there would probably be some benefit in discssing how the =
dma-buf
> > >>> heap framework may want to support
> > >>> secure heaps in the future it is a large topic which I assume you d=
on't
> > >>> want to tackle now.
> > >>
> > >> So I suspect others (Benjamin?) would have a more informed opinion o=
n
> > >> the details, but the intent is to allow secure heap implementations.
> > >> I'm not sure what areas of concern you have for this allocation
> > >> framework in particular?
> > >
> > > yes I would be great to understand how you provide the information to
> > > tell that a dmabuf
> > > is secure (or not) since we can't add flag in dmabuf structure itself=
.
> > > An option is manage
> > > the access rights when a device attach itself to the dmabuf but in
> > > this case you need define
> > > a list of allowed devices per heap...
> > > If you have a good solution for secure heaps you are welcome :-)
> > >
> >
> > Do we really need any of that? A secure buffer is secured by the
> > hardware firewalls that keep out certain IP (including often the
> > processor running Linux). So the only thing we need to track internally
> > is that we should not allow mmap/kmap on the buffer. That can be done i=
n
> > the per-heap layer, everything else stays the same as a standard
> > carveout heap.
>
> For at least some hw the importing driver needs to configure things
> differently for secure buffers :-/

Does the import ioctl need/use a flag for that then? Userland already
has to keep meta-data about dmabufs around.

thanks
-john
