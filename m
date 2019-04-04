Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3C7C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD7120700
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="QNKTRJOo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfDDFEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 01:04:37 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36817 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfDDFEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 01:04:37 -0400
Received: by mail-oi1-f194.google.com with SMTP id l203so842583oia.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 22:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pEIpGRB4XQAalaO/oPr2kzyaJI5QpJw3STg8HsRAun8=;
        b=QNKTRJOoYnnBiYUHPoc7guqmRS9uRVjGQQNmG7uFM6X6oskTW7okJfqCouqaAq1j52
         OskotnANALNexnCHTTpVttJ/GfX2zGy8rEIvW6zq14sorBWDMymlLUQzmnJzbCVa1mc3
         UMQ2PigQyP20+o+RFdBBJbs3LkrOlCFXgY7HyfVjAwBzjsh0WGvuCQNBGEjpx0Kj7YNB
         qq/PIWojQn/1uYeIykYlulYh4O/lrE06zLaFAuklQXg/ms5WsdpeatBov8/xmpFpa5pX
         xxvxeToiQjqqwgn/P1I9tHSGagBTnsXkp2owmISl1eZFV4viqA5Ok9S7kzzPfFpM1rmd
         PhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pEIpGRB4XQAalaO/oPr2kzyaJI5QpJw3STg8HsRAun8=;
        b=A5gfSZJw5F5PGZv+95vLDV3pxBFjALgJt5IKzrzt9UTCupXOamjL863cGCns3VF1eH
         H/bSRNEWeo82jHCs4GufSBqGL9YWzmOit9F1g5Dmcf2zfixNz2FsQI+O0SkJeX+9uR+C
         fEmKMH5SRams2X89X2IH1wIls67ZDZjkKe2qvJqds2VBzrorEB3qZ6TvY/C6utq2F8ws
         BPdWJ5wSH6NRKpIP40jgqYdrG3HzCY4m6LflLaa6YIZvc+ytLC/z1xeDfij6BgDowoWS
         on+Po8rGTtxii7Df1OHUoHbNlhZJuC/2TMgywPZUVWLw8CCP7TbsdR5sYKK1PAdPQ/ta
         746Q==
X-Gm-Message-State: APjAAAUnIW+8ZXtHUZjKOKuYzVVbXBzgtzyfvRYjnChbQZUxy6J6mvIW
        2vcoZTYp5VkgWRDnepHXP2AkbwPEOkEVeyY/zdq4qg==
X-Google-Smtp-Source: APXvYqxY30omdXsAS/rcm0QwxlN6+LM2s0t1TmhesZhh9fbDl4RL/Lx9A6C74Oz606j2ofp52BKsHAufoXuAt1CeXoU=
X-Received: by 2002:aca:d513:: with SMTP id m19mr2097329oig.73.1554354276572;
 Wed, 03 Apr 2019 22:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <1554265806-11501-1-git-send-email-anshuman.khandual@arm.com>
 <1554265806-11501-7-git-send-email-anshuman.khandual@arm.com>
 <ea5567c7-caad-8a4e-7c6f-cec4b772a526@arm.com> <0d72db39-e20d-1cbd-368e-74dda9b6c936@arm.com>
In-Reply-To: <0d72db39-e20d-1cbd-368e-74dda9b6c936@arm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 3 Apr 2019 22:04:25 -0700
Message-ID: <CAPcyv4h5YskvjR306FsHnVHpPjnT4s2JPJXgk6CxiMz8bjhqkg@mail.gmail.com>
Subject: Re: [PATCH 6/6] arm64/mm: Enable ZONE_DEVICE
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>, james.morse@arm.com,
        Mark Rutland <mark.rutland@arm.com>, cpandya@codeaurora.org,
        arunks@codeaurora.org, osalvador@suse.de,
        Logan Gunthorpe <logang@deltatee.com>,
        David Hildenbrand <david@redhat.com>, cai@lca.pw,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 9:42 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 04/03/2019 07:28 PM, Robin Murphy wrote:
> > [ +Dan, Jerome ]
> >
> > On 03/04/2019 05:30, Anshuman Khandual wrote:
> >> Arch implementation for functions which create or destroy vmemmap mapp=
ing
> >> (vmemmap_populate, vmemmap_free) can comprehend and allocate from insi=
de
> >> device memory range through driver provided vmem_altmap structure whic=
h
> >> fulfils all requirements to enable ZONE_DEVICE on the platform. Hence =
just
> >
> > ZONE_DEVICE is about more than just altmap support, no?
>
> Hot plugging the memory into a dev->numa_node's ZONE_DEVICE and initializ=
ing the
> struct pages for it has stand alone and self contained use case. The driv=
er could
> just want to manage the memory itself but with struct pages either in the=
 RAM or
> in the device memory range through struct vmem_altmap. The driver may not=
 choose
> to opt for HMM, FS DAX, P2PDMA (use cases of ZONE_DEVICE) where it may ha=
ve to
> map these pages into any user pagetable which would necessitate support f=
or
> pte|pmd|pud_devmap.

What's left for ZONE_DEVICE if none of the above cases are used?

> Though I am still working towards getting HMM, FS DAX, P2PDMA enabled on =
arm64,
> IMHO ZONE_DEVICE is self contained and can be evaluated in itself.

I'm not convinced. What's the specific use case.

>
> >
> >> enable ZONE_DEVICE by subscribing to ARCH_HAS_ZONE_DEVICE. But this is=
 only
> >> applicable for ARM64_4K_PAGES (ARM64_SWAPPER_USES_SECTION_MAPS) only w=
hich
> >> creates vmemmap section mappings and utilize vmem_altmap structure.
> >
> > What prevents it from working with other page sizes? One of the foremos=
t use-cases for our 52-bit VA/PA support is to enable mapping large quantit=
ies of persistent memory, so we really do need this for 64K pages too. FWIW=
, it appears not to be an issue for PowerPC.
>
>
> On !AR64_4K_PAGES vmemmap_populate() calls vmemmap_populate_basepages() w=
hich
> does not support struct vmem_altmap right now. Originally was planning to=
 send
> the vmemmap_populate_basepages() enablement patches separately but will p=
ost it
> here for review.
>
> >
> >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >> ---
> >>   arch/arm64/Kconfig | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> >> index db3e625..b5d8cf5 100644
> >> --- a/arch/arm64/Kconfig
> >> +++ b/arch/arm64/Kconfig
> >> @@ -31,6 +31,7 @@ config ARM64
> >>       select ARCH_HAS_SYSCALL_WRAPPER
> >>       select ARCH_HAS_TEARDOWN_DMA_OPS if IOMMU_SUPPORT
> >>       select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
> >> +    select ARCH_HAS_ZONE_DEVICE if ARM64_4K_PAGES
> >
> > IIRC certain configurations (HMM?) don't even build if you just turn th=
is on alone (although of course things may have changed elsewhere in the me=
antime) - crucially, though, from previous discussions[1] it seems fundamen=
tally unsafe, since I don't think we can guarantee that nobody will touch t=
he corners of ZONE_DEVICE that also require pte_devmap in order not to go s=
ubtly wrong. I did get as far as cooking up some patches to sort that out [=
2][3] which I never got round to posting for their own sake, so please cons=
ider picking those up as part of this series.
>
> In the previous discussion mentioned here [1] it sort of indicates that w=
e
> cannot have a viable (ARCH_HAS_ZONE_DEVICE=3Dy but !__HAVE_ARCH_PTE_DEVMA=
P). I
> dont understand why !

Because ZONE_DEVICE was specifically invented to solve get_user_pages() for=
 DAX.

> The driver can just hotplug the range into ZONE_DEVICE,
> manage the memory itself without mapping them to user page table ever.

Then why do you even need 'struct page' objects?

> IIUC
> ZONE_DEVICE must not need user mapped device PFN support.

No, you don't understand correctly, or I don't understand how you plan
to use ZONE_DEVICE outside it's intended use case.

> All the corner case
> problems discussed previously come in once these new 'device PFN' memory =
which
> is now in ZONE_DEVICE get mapped into user page table.
>
> >
> > Robin.
> >
> >>       select ARCH_HAVE_NMI_SAFE_CMPXCHG
> >>       select ARCH_INLINE_READ_LOCK if !PREEMPT
> >>       select ARCH_INLINE_READ_LOCK_BH if !PREEMPT
> >>
> >
> >
> > [1] https://lore.kernel.org/linux-mm/CAA9_cmfA9GS+1M1aSyv1ty5jKY3iho3CE=
RhnRAruWJW3PfmpgA@mail.gmail.com/#t
> > [2] http://linux-arm.org/git?p=3Dlinux-rm.git;a=3Dcommitdiff;h=3D61816b=
833afdb56b49c2e58f5289ae18809e5d67
> > [3] http://linux-arm.org/git?p=3Dlinux-rm.git;a=3Dcommitdiff;h=3Da5a165=
60eb1becf9a1d4cc0d03d6b5e76da4f4e1
> > (apologies to anyone if the linux-arm.org server is being flaky as usua=
l and requires a few tries to respond properly)
>
> I have not evaluated pte_devmap(). Will consider [3] when enabling it. Bu=
t
> I still dont understand why ZONE_DEVICE can not be enabled and used from =
a
> driver which never requires user mapping or pte|pmd|pud_devmap() support.

Because there are mm paths that make assumptions about ZONE_DEVICE
that your use case might violate.
