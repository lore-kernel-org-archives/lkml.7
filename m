Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83FAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45902184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o6M6wJve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfCTJRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:17:00 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34133 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfCTJQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:16:59 -0400
Received: by mail-qk1-f196.google.com with SMTP id n6so13618893qkf.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 02:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7m0Za07cEG6gTWG/zkbMr/Qgz0NHhI4FtEz3BgAnUdU=;
        b=o6M6wJveNuNFQTm4LjY1Xk2t60UFmTdQFRxa1bPYHJWpClRc8U5Q8f3axPo7ymVo3a
         6dCskjYlA7mVPNWPCtkGaaxH49ENWW/henlIhC+c+RVSVJzm+Zp6L7gN06MkJMJO9LH0
         bUk+DWQ69ezmK8KjBU6Jg/B3itT+WU2Yj/lOM/CofGLTrasK189hQDWyJReW6lsfkK+s
         4y7oq//V4cagDBGEjJ6Xw+bfvB8s9hhe479+fcIB4zGVqsZgd909biau90ciP96wc8Ny
         1A4sq95z2ISx1EUIPen3VdTLS3VHsTzRYKioNCuW0r/54UUnZo4pkHrFwLzIn50ta8ZQ
         40Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7m0Za07cEG6gTWG/zkbMr/Qgz0NHhI4FtEz3BgAnUdU=;
        b=VXhUv01vkOmP9kkOkzghfft7SL69tKlSVmqf3gzLcY1u8mP7dIdKahgl8cJnxL/2UF
         N7I4rs478UCqMn48mkDFqCoYFPU1n4LvzYlF6T1QJ8kyrnNJTyWzR5tzM6UXw0/URvWe
         92u1YQFhuWHpZgZAHMSS1tpVGpSVlpv4hAQOP+K8zDKKoVHNmBV79oLI1veQSu36xuAz
         rLhg12ELBPr44GmX/6gC3+O8cK6cUPlTaiB4NdmaZ7RVlfNUqjAx7SJSo+izrej0QFFv
         Wr8iK7YSvGDic5bz5aZjbextjyA+gfKsZ3pk5pZ5+uslT8jREE+QuY6j+0+5rC1RdsXb
         3SAw==
X-Gm-Message-State: APjAAAXxIup2vp9Bna580DjaTELi+A8NVLgLxjhA1o8h1eS9m5g5RKcS
        SQkBhZJ4t7OraL3uUMlf+6v/IwP7fdmDJ6kemZubjw==
X-Google-Smtp-Source: APXvYqxGuaOBSVWfQGKmn5Ax7A0EDl8OLhCnwBuN3+qpdYaYRzVEuTiHxUKI5am6hJGmOB0QA6/+RRpta2weqbtnyZc=
X-Received: by 2002:a05:620a:1315:: with SMTP id o21mr5600662qkj.228.1553073418520;
 Wed, 20 Mar 2019 02:16:58 -0700 (PDT)
MIME-Version: 1.0
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <alpine.DEB.2.10.1903131309260.5023@lmark-linux.qualcomm.com>
 <CALAqxLUkGME+K=0g5QSja4CvN0w9z0WV60djy+5rRC+Dg-jCGg@mail.gmail.com>
 <CA+M3ks7q8QnNirk_WkaE5CmFWkEPn4uu5Hfb2kP+4d5qapHvrA@mail.gmail.com>
 <c51be371-086a-bd5b-b70a-5579f5b95320@ti.com> <CAF6AEGss21WmpF7sHGTxOEjuadSNpM6M_Z-WweK2W68FEHOFdA@mail.gmail.com>
 <CALAqxLVbdpj+T4u3jZ_5Uqda5La1Py-ZGpXSep_CCoLzWyap8A@mail.gmail.com>
In-Reply-To: <CALAqxLVbdpj+T4u3jZ_5Uqda5La1Py-ZGpXSep_CCoLzWyap8A@mail.gmail.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Wed, 20 Mar 2019 10:16:47 +0100
Message-ID: <CA+M3ks61BGPkPjNd01g32LV7YZfDpy8t100KxQhScOFgGO4KjA@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/5 v2] DMA-BUF Heaps (destaging ION)
To:     John Stultz <john.stultz@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>, "Andrew F. Davis" <afd@ti.com>,
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

Le mar. 19 mars 2019 =C3=A0 23:36, John Stultz <john.stultz@linaro.org> a =
=C3=A9crit :
>
> On Tue, Mar 19, 2019 at 2:58 PM Rob Clark <robdclark@gmail.com> wrote:
> >
> > On Tue, Mar 19, 2019 at 1:00 PM Andrew F. Davis <afd@ti.com> wrote:
> > >
> > > On 3/19/19 11:54 AM, Benjamin Gaignard wrote:
> > > > Le mer. 13 mars 2019 =C3=A0 23:31, John Stultz <john.stultz@linaro.=
org> a =C3=A9crit :
> > > >>
> > > >> On Wed, Mar 13, 2019 at 1:11 PM Liam Mark <lmark@codeaurora.org> w=
rote:
> > > >>> On Tue, 5 Mar 2019, John Stultz wrote:
> > > >>>>
> > > >>>> Eventual TODOS:
> > > >>>> * Reimplement page-pool for system heap (working on this)
> > > >>>> * Add stats accounting to system/cma heaps
> > > >>>> * Make the kselftest actually useful
> > > >>>> * Add other heaps folks see as useful (would love to get
> > > >>>>   some help from actual carveout/chunk users)!
> > > >>>
> > > >>> We use a modified carveout heap for certain secure use cases.
> > > >>
> > > >> Cool! It would be great to see if you have any concerns about addi=
ng
> > > >> such a secure-carveout heap to this framework. I suspect it would =
be
> > > >> fairly similar to how its integrated into ION, but particularly I'=
d be
> > > >> interested in issues around the lack of private flags and other
> > > >> allocation arguments like alignment.
> > > >>
> > > >>> Although there would probably be some benefit in discssing how th=
e dma-buf
> > > >>> heap framework may want to support
> > > >>> secure heaps in the future it is a large topic which I assume you=
 don't
> > > >>> want to tackle now.
> > > >>
> > > >> So I suspect others (Benjamin?) would have a more informed opinion=
 on
> > > >> the details, but the intent is to allow secure heap implementation=
s.
> > > >> I'm not sure what areas of concern you have for this allocation
> > > >> framework in particular?
> > > >
> > > > yes I would be great to understand how you provide the information =
to
> > > > tell that a dmabuf
> > > > is secure (or not) since we can't add flag in dmabuf structure itse=
lf.
> > > > An option is manage
> > > > the access rights when a device attach itself to the dmabuf but in
> > > > this case you need define
> > > > a list of allowed devices per heap...
> > > > If you have a good solution for secure heaps you are welcome :-)
> > > >
> > >
> > > Do we really need any of that? A secure buffer is secured by the
> > > hardware firewalls that keep out certain IP (including often the
> > > processor running Linux). So the only thing we need to track internal=
ly
> > > is that we should not allow mmap/kmap on the buffer. That can be done=
 in
> > > the per-heap layer, everything else stays the same as a standard
> > > carveout heap.
> >
> > For at least some hw the importing driver needs to configure things
> > differently for secure buffers :-/
>
> Does the import ioctl need/use a flag for that then? Userland already
> has to keep meta-data about dmabufs around.

To secure a buffer you need to know who is allowed to write/read it and
hardware block involved in the dataflow may need to know that the buffer
is secure to configure themself.
As example for a video decoding you allow hw video decoder to read in
a buffer and display to read it. You can also allow cpu to write on the buf=
fer
to add subtitles. For that we need to be able to mmap/kmap the buffer.
Using a carveout heap for secure buffer mean that you reserved a large
memory region only for this purpose, that isn't possible on embedded device
where we are always limited in memory so we use CMA.
In the past I have used dmabuf's attach function to know who write into
the buffer and then configure who will be able to read it. It was working w=
ell
but the issue was how to in generic way this behavior.

>
> thanks
> -john
