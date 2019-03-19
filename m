Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F4AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 19:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DB720651
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 19:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="tA1aPkae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfCSTNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 15:13:53 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33010 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfCSTNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 15:13:52 -0400
Received: by mail-oi1-f195.google.com with SMTP id e22so9779631oiy.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 12:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hb0TMUCfZsXrifishUIJPpzzpWyGqqsjDKL3oDA7RZw=;
        b=tA1aPkae+04SdhT1KymIG25CYueUBn6ZMXHtyA4R1DHsZP6v9/xxFKjK1f0XAOpgR0
         PIpE9/8sIwPD7EAGecSssTxUVLZjsiDikt8ZhTDFkXe3s9F9gctBxbdG84RNHu7YA6L3
         h/aHxnW6Fhp7ZmkQnRHrbYe+SmlrTcopjpXUdlhiUzROfFa293lEHe/jsqatKAOXYNGy
         hyEP8vO/QCb9zZjMmwqpnuuPUjj1lV5AOmG6CtpDH8vNv3HYhOKtIr8qkS+YqVLn6Zkc
         79zphgtqqD6Uqq3xhnozpHm1IP6m1Tp++4jKCdB6lPk2sn1nA7cEjCsGufszuq41Fhl7
         6SVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hb0TMUCfZsXrifishUIJPpzzpWyGqqsjDKL3oDA7RZw=;
        b=XLWtaVAEX/PR2kv7l0toL5j8tQ8Yp0saz1ZDOa2hik6SbUzKtCPmw2bmw2B8prDBlN
         aRwUddEY05gun1vMumxTGjWpoIpH2WTzjUGL21k6/PTnX7mn9WpCw02ofsfXUJ8OoSvx
         yI6HjnGLbHK3MJWbo/UVcT65QpMiGprj9Fh2ZUB3sSpbiI/FxzJdl0wszNCZzPNFpnSA
         iwtCb4YOHFbl3u9tnwvjNqaLv4rv+249Cv0zNbNuqO9Q/3JxCIWlW3OVpmfNosruzuOB
         bhR7i4oTGcxg03R9seBxF07QbqfSB+PPDA6Z5xdut5SUqKOrFCmTcQKcDV69hcXRleOJ
         mgvw==
X-Gm-Message-State: APjAAAVvotSGiRmgZ1+nXcgmHhYpVarQX3ZmjVKeVZOkBaU2VDFNZVV9
        DMNBnj4IklLtyw3Id7Q8hDO6HX6Dd2cqQi+mKe817w==
X-Google-Smtp-Source: APXvYqzBxrNYRkRQzrHdBRUCSknsQ4I3vdghzH5Ms1E3iCffjEZnyjCciVZjxajeGDVJPFSdiQT6m/kbQDpxrRvkk9c=
X-Received: by 2002:aca:f581:: with SMTP id t123mr2816773oih.0.1553022831762;
 Tue, 19 Mar 2019 12:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190313012706.GB3402@redhat.com> <20190313091004.b748502871ba0aa839b924e9@linux-foundation.org>
 <20190318170404.GA6786@redhat.com> <20190319094007.a47ce9222b5faacec3e96da4@linux-foundation.org>
 <20190319165802.GA3656@redhat.com> <20190319101249.d2076f4bacbef948055ae758@linux-foundation.org>
 <20190319171847.GC3656@redhat.com> <CAPcyv4iesGET_PV-QcdBbxJGgmJ_HhoGczyvb=0+SnLkFDhRuQ@mail.gmail.com>
 <20190319174552.GA3769@redhat.com> <CAPcyv4hFPOO0-=v3ZCNFA=LgE_QCvyFXGqF24Crveoj_NTbq0Q@mail.gmail.com>
 <20190319190528.GA4012@redhat.com>
In-Reply-To: <20190319190528.GA4012@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 19 Mar 2019 12:13:40 -0700
Message-ID: <CAPcyv4hg5Y_NC1iu56zcznYkCRnwg+_7bGFr==7=AC6ii=O=Ng@mail.gmail.com>
Subject: Re: [PATCH 00/10] HMM updates for 5.1
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 12:05 PM Jerome Glisse <jglisse@redhat.com> wrote:
>
> On Tue, Mar 19, 2019 at 11:42:00AM -0700, Dan Williams wrote:
> > On Tue, Mar 19, 2019 at 10:45 AM Jerome Glisse <jglisse@redhat.com> wrote:
> > >
> > > On Tue, Mar 19, 2019 at 10:33:57AM -0700, Dan Williams wrote:
> > > > On Tue, Mar 19, 2019 at 10:19 AM Jerome Glisse <jglisse@redhat.com> wrote:
> > > > >
> > > > > On Tue, Mar 19, 2019 at 10:12:49AM -0700, Andrew Morton wrote:
> > > > > > On Tue, 19 Mar 2019 12:58:02 -0400 Jerome Glisse <jglisse@redhat.com> wrote:
> > > > [..]
> > > > > > Also, the discussion regarding [07/10] is substantial and is ongoing so
> > > > > > please let's push along wth that.
> > > > >
> > > > > I can move it as last patch in the serie but it is needed for ODP RDMA
> > > > > convertion too. Otherwise i will just move that code into the ODP RDMA
> > > > > code and will have to move it again into HMM code once i am done with
> > > > > the nouveau changes and in the meantime i expect other driver will want
> > > > > to use this 2 helpers too.
> > > >
> > > > I still hold out hope that we can find a way to have productive
> > > > discussions about the implementation of this infrastructure.
> > > > Threatening to move the code elsewhere to bypass the feedback is not
> > > > productive.
> > >
> > > I am not threatening anything that code is in ODP _today_ with that
> > > patchset i was factering it out so that i could also use it in nouveau.
> > > nouveau is built in such way that right now i can not use it directly.
> > > But i wanted to factor out now in hope that i can get the nouveau
> > > changes in 5.2 and then convert nouveau in 5.3.
> > >
> > > So when i said that code will be in ODP it just means that instead of
> > > removing it from ODP i will keep it there and it will just delay more
> > > code sharing for everyone.
> >
> > The point I'm trying to make is that the code sharing for everyone is
> > moving the implementation closer to canonical kernel code and use
> > existing infrastructure. For example, I look at 'struct hmm_range' and
> > see nothing hmm specific in it. I think we can make that generic and
> > not build up more apis and data structures in the "hmm" namespace.
>
> Right now i am trying to unify driver for device that have can support
> the mmu notifier approach through HMM. Unify to a superset of driver
> that can not abide by mmu notifier is on my todo list like i said but
> it comes after. I do not want to make the big jump in just one go. So
> i doing thing under HMM and thus in HMM namespace, but once i tackle
> the larger set i will move to generic namespace what make sense.
>
> This exact approach did happen several time already in the kernel. In
> the GPU sub-system we did it several time. First do something for couple
> devices that are very similar then grow to a bigger set of devices and
> generalise along the way.
>
> So i do not see what is the problem of me repeating that same pattern
> here again. Do something for a smaller set before tackling it on for
> a bigger set.

All of that is fine, but when I asked about the ultimate trajectory
that replaces hmm_range_dma_map() with an updated / HMM-aware GUP
implementation, the response was that hmm_range_dma_map() is here to
stay. The issue is not with forking off a small side effort, it's the
plan to absorb that capability into a common implementation across
non-HMM drivers where possible.
