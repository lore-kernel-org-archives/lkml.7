Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69BAC43613
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 21:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707D1208CA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 21:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="WBbtV67P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbfFSVyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 17:54:07 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38840 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfFSVyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 17:54:07 -0400
Received: by mail-oi1-f195.google.com with SMTP id v186so549078oie.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 14:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JrmPkmGlWIDmfFJHcUBHoDgjBA4Uq/PsSzropCIymmw=;
        b=WBbtV67PxlzWF1EF3D6ymPFrOUmHY0N0WW50GNMKS5/RKjY/r32FX/pN++Js56UrJW
         f/s7KDuhhbquot8VyWdYdbu1K4N6mZUSD30XrAOyqxYOcnWlBG3Rj2ZKM+tPxujVXYB1
         lWBLXB0NfhGXLAp7U1ISHE/MOSc+mHZlYUWYqZ3OMl+Ypm4Rxl/7aE4WuAkQ8OqkUUrb
         PgyCZA2GRtAs+sU1e0zD09j1iJl5H+Ff+Y5OV59gAlbHUKH00ZFnw4huGYE6vsTIzxrS
         Xhg+kRwWUcOvamuVw/0FKyGf4fVEibUff2E2RH/Q1BcNXHe6UPy+167cFU99QhZNgxI7
         RK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JrmPkmGlWIDmfFJHcUBHoDgjBA4Uq/PsSzropCIymmw=;
        b=hyk0wbsSdLFtAMx1/VQXAK5PF9NaYORtDsk4mZqbrLDDrp/HfFAnRBEAKstacYHPIG
         a6UY8DBxW8oOo3L8fKgfD8mXHoy3yc0aGt03D0aEhQuYicjDsMWDVwmaCu/X2X+4MvWF
         HajTvedMsBJ5qXOU6iqsium3b1ucKP6j8z3hlmFk/jvXYGSolY42RhVRSPq/Vv578Ab+
         MqnR53AGNAZT84soTeCH5bLF3hIScPPXANgctLBIDNJPqzlz2fHKqfBh9thkMIqoMieA
         gRRIdjn4xRxusuYOQmMTjRTtzBABiqD9atOGmHRlgQzIDUh4nsbjv6Lj8PK20Df1leZv
         FnGQ==
X-Gm-Message-State: APjAAAWBMQv6zf1p9IWeRijoO4QCPuf0fxzPcdCFQZIW6AfOovl+8rff
        L/qtQS28V3CY7a+yY1GnZuPNKBK1uB9xax7SfEqz2A==
X-Google-Smtp-Source: APXvYqxcjUnD4FIHV2bGaEcKpzuyLnsiNdvlDaM+9QH4AEKqN4Y/h5h0tSXn91LvSGHhJ7SPRgQdZkHoTuGUd9kflFo=
X-Received: by 2002:aca:1304:: with SMTP id e4mr4306999oii.149.1560981245880;
 Wed, 19 Jun 2019 14:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190613045903.4922-1-namit@vmware.com> <20190613045903.4922-4-namit@vmware.com>
 <20190617215750.8e46ae846c09cd5c1f22fdf9@linux-foundation.org>
 <98464609-8F5A-47B9-A64E-2F67809737AD@vmware.com> <8072D878-BBF2-47E4-B4C9-190F379F6221@vmware.com>
 <CAErSpo5eiweMk2rfT81Kwnpd=MZsOa01prPo_rAFp-MZ9F2xdQ@mail.gmail.com>
In-Reply-To: <CAErSpo5eiweMk2rfT81Kwnpd=MZsOa01prPo_rAFp-MZ9F2xdQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 19 Jun 2019 14:53:54 -0700
Message-ID: <CAPcyv4iAbWnWUT2d2VhnvuHvJE0-Vxgbf1TYtOPjkR6j3qROtw@mail.gmail.com>
Subject: Re: [PATCH 3/3] resource: Introduce resource cache
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Nadav Amit <namit@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Borislav Petkov <bp@suse.de>,
        Toshi Kani <toshi.kani@hpe.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Kleen, Andi" <andi.kleen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ add Andi ]

On Wed, Jun 19, 2019 at 6:00 AM Bjorn Helgaas <bhelgaas@google.com> wrote:
>
> On Tue, Jun 18, 2019 at 12:40 AM Nadav Amit <namit@vmware.com> wrote:
> >
> > > On Jun 17, 2019, at 10:33 PM, Nadav Amit <namit@vmware.com> wrote:
> > >
> > >> On Jun 17, 2019, at 9:57 PM, Andrew Morton <akpm@linux-foundation.or=
g> wrote:
> > >>
> > >> On Wed, 12 Jun 2019 21:59:03 -0700 Nadav Amit <namit@vmware.com> wro=
te:
> > >>
> > >>> For efficient search of resources, as needed to determine the memor=
y
> > >>> type for dax page-faults, introduce a cache of the most recently us=
ed
> > >>> top-level resource. Caching the top-level should be safe as ranges =
in
> > >>> that level do not overlap (unlike those of lower levels).
> > >>>
> > >>> Keep the cache per-cpu to avoid possible contention. Whenever a res=
ource
> > >>> is added, removed or changed, invalidate all the resources. The
> > >>> invalidation takes place when the resource_lock is taken for write,
> > >>> preventing possible races.
> > >>>
> > >>> This patch provides relatively small performance improvements over =
the
> > >>> previous patch (~0.5% on sysbench), but can benefit systems with ma=
ny
> > >>> resources.
> > >>
> > >>> --- a/kernel/resource.c
> > >>> +++ b/kernel/resource.c
> > >>> @@ -53,6 +53,12 @@ struct resource_constraint {
> > >>>
> > >>> static DEFINE_RWLOCK(resource_lock);
> > >>>
> > >>> +/*
> > >>> + * Cache of the top-level resource that was most recently use by
> > >>> + * find_next_iomem_res().
> > >>> + */
> > >>> +static DEFINE_PER_CPU(struct resource *, resource_cache);
> > >>
> > >> A per-cpu cache which is accessed under a kernel-wide read_lock look=
s a
> > >> bit odd - the latency getting at that rwlock will swamp the benefit =
of
> > >> isolating the CPUs from each other when accessing resource_cache.
> > >>
> > >> On the other hand, if we have multiple CPUs running
> > >> find_next_iomem_res() concurrently then yes, I see the benefit.  Has
> > >> the benefit of using a per-cpu cache (rather than a kernel-wide one)
> > >> been quantified?
> > >
> > > No. I am not sure how easy it would be to measure it. On the other ha=
nder
> > > the lock is not supposed to be contended (at most cases). At the time=
 I saw
> > > numbers that showed that stores to =E2=80=9Cexclusive" cache lines ca=
n be as
> > > expensive as atomic operations [1]. I am not sure how up to date thes=
e
> > > numbers are though. In the benchmark I ran, multiple CPUs ran
> > > find_next_iomem_res() concurrently.
> > >
> > > [1] http://sigops.org/s/conferences/sosp/2013/papers/p33-david.pdf
> >
> > Just to clarify - the main motivation behind the per-cpu variable is no=
t
> > about contention, but about the fact the different processes/threads th=
at
> > run concurrently might use different resources.
>
> IIUC, the underlying problem is that dax relies heavily on ioremap(),
> and ioremap() on x86 takes too long because it relies on
> find_next_iomem_res() via the __ioremap_caller() ->
> __ioremap_check_mem() -> walk_mem_res() path.
>
> The fact that x86 is the only arch that does this much work in
> ioremap() makes me wonder.  Is there something unique about x86
> mapping attributes that requires this extra work, or is there some way
> this could be reworked to avoid searching the resource map in the
> first place?

The underlying issue is that the x86-PAT implementation wants to
ensure that conflicting mappings are not set up for the same physical
address. This is mentioned in the developer manuals as problematic on
some cpus. Andi, is lookup_memtype() and track_pfn_insert() still
relevant?
