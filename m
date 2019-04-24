Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020ACC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C535E218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbfDXAkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 20:40:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51414 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbfDXAkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 20:40:05 -0400
Received: from mail-oi1-f198.google.com ([209.85.167.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <dann.frazier@canonical.com>)
        id 1hJ5xD-0004c2-36
        for linux-kernel@vger.kernel.org; Wed, 24 Apr 2019 00:40:03 +0000
Received: by mail-oi1-f198.google.com with SMTP id w10so6850185oie.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 17:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HAJ+tsuhVeXXnt5g0+5qfIDYODvPMMpK3Zh37chKNPc=;
        b=f62AkrBPsebRTq/i38NOCMpAMQSPAWtzlXxIPI7N9P8SzNpS5bpJI5G1VuhNn1eRw7
         aF/TA3SUf1yReQDUnWJQVesdfPbF7mY1v/Db3dLG9LFA/lzqnsn+UXv7pXYGKgGxJ3a/
         RbgV9eTIEYhMx8yjDvnbBhO9CiEf2mV9IZNGl9m472J4ZDSjxEgUWyinqeqf4ni+rpKe
         FYcbvutEyd1p8lMkBoInybN62HrEc0SmSVv1AC+Ug1fn32Lso9ODnc3L5kQbhkfsvWWH
         CBph21lmiCuWWUQ5UFEXtNpKY3ru3z9QUObAqQCQLjWr/3982Vc/69LFy4nnx65FtY2p
         rq3Q==
X-Gm-Message-State: APjAAAULDWaLWLnaWmlnounj/Efv9eqF4hCiDkE5umQD7tD9ssgzKqRF
        AFE7PbqOlMIn8/8ftM4D+7Ip5gcojjr/nr1x859YPDECXKR2gEwGP4WHG0G78RtGuHXMiseI7gS
        ekVionyknHONSgS/bnJ+IxsMaulBAUbuxmL4efs7wwATC9Cl0S4+3KQBL/g==
X-Received: by 2002:aca:c511:: with SMTP id v17mr3651414oif.124.1556066401973;
        Tue, 23 Apr 2019 17:40:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx0e4WJRVNRiguNI1//zAUIEyYuWcBl6vnE7VQGMLKBvKc3t094QzmR2EGAhr9F72Gg81zS4S+vG7/HUzW4SJk=
X-Received: by 2002:aca:c511:: with SMTP id v17mr3651400oif.124.1556066401613;
 Tue, 23 Apr 2019 17:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190417204817.GA28897@xps13.dannf> <fa287dc4-59e9-0500-70ee-e96c2920d5a9@arm.com>
 <CALdTtnsHxwTjzw1asO886jYWB4LOY=UT_UGeco=f1SZzVNo7fw@mail.gmail.com>
In-Reply-To: <CALdTtnsHxwTjzw1asO886jYWB4LOY=UT_UGeco=f1SZzVNo7fw@mail.gmail.com>
From:   dann frazier <dann.frazier@canonical.com>
Date:   Tue, 23 Apr 2019 18:39:50 -0600
Message-ID: <CALdTtnvUzoPLmgghRHb+gNOkivi3H7rhAaL96gLhkwOyK-ycWA@mail.gmail.com>
Subject: Re: [RFC] arm64: swiotlb: cma_alloc error spew
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 12:03 PM dann frazier
<dann.frazier@canonical.com> wrote:
>
> On Tue, Apr 23, 2019 at 5:32 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 17/04/2019 21:48, dann frazier wrote:
> > > hey,
> > >    I'm seeing an issue on a couple of arm64 systems[*] where they spew
> > > ~10K "cma: cma_alloc: alloc failed" messages at boot. The errors are
> > > non-fatal, and bumping up cma to a large enough size (~128M) gets rid
> > > of them - but that seems suboptimal. Bisection shows that this started
> > > after commit fafadcd16595 ("swiotlb: don't dip into swiotlb pool for
> > > coherent allocations"). It looks like __dma_direct_alloc_pages()
> > > is opportunistically using CMA memory but falls back to non-CMA if CMA
> > > disabled or unavailable. I've demonstrated that this fallback is
> > > indeed returning a valid pointer. So perhaps the issue is really just
> > > the warning emission.
> >
> > The CMA area being full isn't necessarily an ignorable non-problem,
> > since it means you won't be able to allocate the kind of large buffers
> > for which CMA was intended. The question is, is it actually filling up
> > with allocations that deserve to be there, or is this the same as I've
> > seen on a log from a ThunderX2 system where it's getting exhausted by
> > thousands upon thousands of trivial single page allocations? If it's the
> > latter (CONFIG_CMA_DEBUG should help shed some light if necessary),
>
> Appears so. Here's a histogram of count/size w/ a cma= large enough to
> avoid failures:
>
> $ dmesg | grep "cma: cma_alloc(cma" | sed -r 's/.*count
> ([0-9]+)\,.*/\1/' | sort -n | uniq -c
>    2062 1
>      32 2
>     266 8
>       2 24
>       4 32
>     256 33

And IIUC, this is also a big culprit. The debugfs bitmap seems to show
that the alignment of each of these leaves 31 pages unused, which adds
up to 31MB!

  -dann

>       7 64
>       2 128
>       2 1024
>
>   -dann
>
> > then
> > that does lean towards spending a bit more effort on this idea:
> >
> > https://lore.kernel.org/lkml/20190327080821.GB20336@lst.de/
> >
> > Robin.
> >
> > > The following naive patch solves the problem for me - just silence the
> > > cma errors, since it looks like a soft error. But is there a better
> > > approach?
> > >
> > > [*] APM X-Gene & HiSilicon Hi1620 w/ SMMU disabled
> > >
> > > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > > index 6310ad01f915b..0324aa606c173 100644
> > > --- a/kernel/dma/direct.c
> > > +++ b/kernel/dma/direct.c
> > > @@ -112,7 +112,7 @@ struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
> > >          /* CMA can be used only in the context which permits sleeping */
> > >          if (gfpflags_allow_blocking(gfp)) {
> > >                  page = dma_alloc_from_contiguous(dev, count, page_order,
> > > -                                                gfp & __GFP_NOWARN);
> > > +                                                true);
> > >                  if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
> > >                          dma_release_from_contiguous(dev, page, count);
> > >                          page = NULL;
> > >
> > >
> > >
> > >
