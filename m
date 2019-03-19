Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2024C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90BEE2183F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="UjehdbZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfCSD36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 23:29:58 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43549 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfCSD36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 23:29:58 -0400
Received: by mail-ot1-f65.google.com with SMTP id u15so6305060otq.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 20:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=txmZrEKmzGMSjGC1V04Mt624MxMvgtvYkFZlSdbNCFc=;
        b=UjehdbZTqHsd6eUSShf/976IcF1OhUsgu5lop0jcaJfnII6/dl1RYIsvl59X7stv+2
         /9nPv6e6OYzyF/e5FkVCe7/Kvk912z/JjQMjtsEYcHTjE52Yxww+5Zc1VVp7U38Flc+o
         yN056nezNPrw4O77mYs9Fn9VjC4/+luVFp27QHQFlRhFB0ksZi75wxQf5RyNeEEuPDee
         HImoVm2delD701NXXBoqe8OoKaQtY6rF+Ixq+REQTTRALYP0selkjAhn+IckwUr/iARt
         OQOlowfSfuFGHojRs4FG4wMM/CjSW5JEkemIR/cRcMOaGLVeGDoM34nRM7+cSmTMm3id
         y0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=txmZrEKmzGMSjGC1V04Mt624MxMvgtvYkFZlSdbNCFc=;
        b=kY5bi3kriz/13nKCEnq9clLKCr18JdQIT2qZGHCjyl+7Xxfi2Tv6YGVl1kL+APES0Y
         xA8zqmkRccaRo1lA660cr6qMxbsN/bfoXdU0HIF+P7iIEQWNQzDEhXO/G7Lx6O75Skhl
         /TVseQSvBnVzp3xmYpmmzMB8ZmiM4o5ZDsqvM0Xe6nJXfLCmZPFQshIysPI8ZKYZWy6o
         A2EBnGluDZRRa25fxav9LDUUZ+Brmv8zU8hRKZxs6sa7VC7B2YGgbu6I4FE2rGUI8RxI
         Q/Bh3tqgLuTEEq2QAFRrDeSiDEN3K9Fc3Ah/6zNNxr0BVHvKp/5QqgAcxHOJCylEB/yd
         vEwQ==
X-Gm-Message-State: APjAAAUqNmg/Xvkbmpb7hUezy9vW8Xam4NFDpcAiE8IslOtJtwDBIIXx
        qSS0QTGon5UI8rynpyzOQ5KxL/Mth92HF24/xyYGJA==
X-Google-Smtp-Source: APXvYqzZPHgxoSDAubD81CyXLt6mCVhGS8OC9h9xp71JYmT206e9H7rWna7EmHBWwHb7pPdnKSfT8nJYDQQzXV/P+64=
X-Received: by 2002:a9d:2c23:: with SMTP id f32mr160656otb.353.1552966197263;
 Mon, 18 Mar 2019 20:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190129165428.3931-1-jglisse@redhat.com> <20190129165428.3931-8-jglisse@redhat.com>
 <CAA9_cmcN+8B_tyrxRy5MMr-AybcaDEEWB4J8dstY6h0cmFxi3g@mail.gmail.com>
 <20190318204134.GD6786@redhat.com> <CAPcyv4he6v5JQMucezZV4J3i+Ea-i7AsaGpCOnc4f-stCrhGag@mail.gmail.com>
 <20190318221515.GA6664@redhat.com>
In-Reply-To: <20190318221515.GA6664@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 18 Mar 2019 20:29:45 -0700
Message-ID: <CAPcyv4gYUfEDSsGa_e1v8hqHyyvX8pEc75=G33aaQ6EWG3pSZA@mail.gmail.com>
Subject: Re: [PATCH 07/10] mm/hmm: add an helper function that fault pages and
 map them to a device
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 3:15 PM Jerome Glisse <jglisse@redhat.com> wrote:
>
> On Mon, Mar 18, 2019 at 02:30:15PM -0700, Dan Williams wrote:
> > On Mon, Mar 18, 2019 at 1:41 PM Jerome Glisse <jglisse@redhat.com> wrot=
e:
> > >
> > > On Mon, Mar 18, 2019 at 01:21:00PM -0700, Dan Williams wrote:
> > > > On Tue, Jan 29, 2019 at 8:55 AM <jglisse@redhat.com> wrote:
> > > > >
> > > > > From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> > > > >
> > > > > This is a all in one helper that fault pages in a range and map t=
hem to
> > > > > a device so that every single device driver do not have to re-imp=
lement
> > > > > this common pattern.
> > > >
> > > > Ok, correct me if I am wrong but these seem effectively be the typi=
cal
> > > > "get_user_pages() + dma_map_page()" pattern that non-HMM drivers wo=
uld
> > > > follow. Could we just teach get_user_pages() to take an HMM shortcu=
t
> > > > based on the range?
> > > >
> > > > I'm interested in being able to share code across drivers and not h=
ave
> > > > to worry about the HMM special case at the api level.
> > > >
> > > > And to be clear this isn't an anti-HMM critique this is a "yes, let=
's
> > > > do this, but how about a more fundamental change".
> > >
> > > It is a yes and no, HMM have the synchronization with mmu notifier
> > > which is not common to all device driver ie you have device driver
> > > that do not synchronize with mmu notifier and use GUP. For instance
> > > see the range->valid test in below code this is HMM specific and it
> > > would not apply to GUP user.
> > >
> > > Nonetheless i want to remove more HMM code and grow GUP to do some
> > > of this too so that HMM and non HMM driver can share the common part
> > > (under GUP). But right now updating GUP is a too big endeavor.
> >
> > I'm open to that argument, but that statement then seems to indicate
> > that these apis are indeed temporary. If the end game is common api
> > between HMM and non-HMM drivers then I think these should at least
> > come with /* TODO: */ comments about what might change in the future,
> > and then should be EXPORT_SYMBOL_GPL since they're already planning to
> > be deprecated. They are a point in time export for a work-in-progress
> > interface.
>
> The API is not temporary it will stay the same ie the device driver
> using HMM would not need further modification. Only the inner working
> of HMM would be ported over to use improved common GUP. But GUP has
> few shortcoming today that would be a regression for HMM:
>     - huge page handling (ie dma mapping huge page not 4k chunk of
>       huge page)
>     - not incrementing page refcount for HMM (other user like user-
>       faultd also want a GUP without FOLL_GET because they abide by
>       mmu notifier)
>     - support for device memory without leaking it ie restrict such
>       memory to caller that can handle it properly and are fully
>       aware of the gotcha that comes with it
>     ...

...but this is backwards because the end state is 2 driver interfaces
for dealing with page mappings instead of one. My primary critique of
HMM is that it creates a parallel universe of HMM apis rather than
evolving the existing core apis.

> So before converting HMM to use common GUP code under-neath those GUP
> shortcoming (from HMM POV) need to be addressed and at the same time
> the common dma map pattern can be added as an extra GUP helper.

If the HMM special cases are not being absorbed into the core-mm over
time then I think this is going in the wrong direction. Specifically a
direction that increases the long term maintenance burden over time as
HMM drivers stay needlessly separated.

> The issue is that some of the above changes need to be done carefully
> to not impact existing GUP users. So i rather clear some of my plate
> before starting chewing on this carefully.

I urge you to put this kind of consideration first and not "merge
first, ask hard questions later".

> Also doing this patch first and then the GUP thing solve the first user
> problem you have been asking for. With that code in first the first user
> of the GUP convertion will be all the devices that use those two HMM
> functions. In turn the first user of that code is the ODP RDMA patch
> i already posted. Second will be nouveau once i tackle out some nouveau
> changes. I expect amdgpu to come close third as a user and other device
> driver who are working on HMM integration to come shortly after.

I appreciate that it has users, but the point of having users is so
that the code review can actually be fruitful to see if the
infrastructure makes sense, and in this case it seems to be
duplicating an existing common pattern in the kernel.
