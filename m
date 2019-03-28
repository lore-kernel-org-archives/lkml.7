Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E31C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A482184C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Z6gwxHZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfC1UoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:44:05 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36057 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfC1UoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 16:44:04 -0400
Received: by mail-oi1-f195.google.com with SMTP id t206so16869023oib.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 13:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/obLKJHkKpQUcxL9/HpnQX/CMWLlh2MpUJBgyyDo0Ik=;
        b=Z6gwxHZqr8tHa9o/+Y4BLmPHFulVoPKKKjj2D3/WJezDP4/nbkB6wsQ1JcYIhMU3PK
         x6XPTOicb4eeyA2TW2pc3Q1A1S9xw8MHaINKmVyp47Zw9v3uIRKE4PLpOWtfydFU6jc+
         8mKWU1/QkuoMf8xTY2zXG91iPAwQpv1DZ8VHw0jM0ikFbk1lrBSEr9FVeohOjjbmgrpv
         vhkRt2SU1nS8XfOEc3ABp1Ty0WDcnEWMTysR31p31RIZcZst4A4IJ/emIB1wr7iyx54D
         kxnV1BqJ0igx3yiJepx7sRDnxwCRlnk6SY2jb3ZI0amU/h704MBJcklxMgsUxW45uN5q
         O7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/obLKJHkKpQUcxL9/HpnQX/CMWLlh2MpUJBgyyDo0Ik=;
        b=qgRs7M+k6P5bPcdQ7AqfkRM0VAf0uPjjOXpvrZK5YHQYADQwGMkk6md+b8rhbt4Qcz
         k/r1a/hoQF36F5tGpVZZErQiCM2dgs5N97jt/N8MpknQyG03WCZZa+GklPKdET/WJFmY
         +lyPLSKuF6HpaXgcWcru63DE4wmFbuuiCS1UsDJXdOQFBUc0s1cgz1/ETcFtMadT/LLa
         9pcUB1eSVbV22pEWVhJlsmXSwQyWuzw49jPaTGA0G21ikDMulyRIFR72+aWa3JvcwV5A
         TbtFiFVxWFdQGnLbuePXSnCYAHR+NuE84+gUIjeB5sOZ7sWn8qtQAkgj65i+ypYRNRcZ
         dgNw==
X-Gm-Message-State: APjAAAUwZ1nYFiHMpV5FNfGWsrkE6+lH7Ymw04JLit3MEeo9UiDzgy0e
        2Ao5WLpV4PogjIqYFaoP3HMdXd7zvlqC2Uwm60wiUg==
X-Google-Smtp-Source: APXvYqwGBDvSfFK7lZAr4qztuFRCQd2h6pge6C8hW/qUos+bHal25JX9ESoOqvD69ByJERllNSID1SEu82DcVNHePkQ=
X-Received: by 2002:aca:e64f:: with SMTP id d76mr1482897oih.105.1553805842214;
 Thu, 28 Mar 2019 13:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <155327387405.225273.9325594075351253804.stgit@dwillia2-desk3.amr.corp.intel.com>
 <cf304a31-70a6-e701-ec3e-c47dc84b81d2@redhat.com>
In-Reply-To: <cf304a31-70a6-e701-ec3e-c47dc84b81d2@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 28 Mar 2019 13:43:49 -0700
Message-ID: <CAPcyv4hgAM=ex0B4EBZ40RNf=bXk2WkEzySTUV4ZzOWd_HZwSQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] mm: Sub-section memory hotplug support
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Jeff Moyer <jmoyer@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        stable <stable@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 1:10 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 22.03.19 17:57, Dan Williams wrote:
> > Changes since v4 [1]:
> > - Given v4 was from March of 2017 the bulk of the changes result from
> >   rebasing the patch set from a v4.11-rc2 baseline to v5.1-rc1.
> >
> > - A unit test is added to ndctl to exercise the creation and dax
> >   mounting of multiple independent namespaces in a single 128M section.
> >
> > [1]: https://lwn.net/Articles/717383/
> >
> > ---
>
> I'm gonna have to ask some very basic questions:

No worries.

>
> You are using the term "Sub-section memory hotplug support", but is it
> actually what you mean? To rephrase, aren't we talking here about
> "Sub-section device memory hotplug support" or similar?

Specifically it is support for passing @start and @size arguments to
arch_add_memory() that are not section aligned. It's not limited to
"device memory" which is otherwise not a concept that
arch_add_memory() understands, it just groks spans of pfns.

> Reason I am asking is because I wonder how that would interact with the
> memory block device infrastructure and hotplugging of system ram -
> add_memory()/add_memory_resource(). I *assume* you are not changing the
> add_memory() interface, so that one still only works with whole sections
> (or well, memory_block_size_bytes()) - check_hotplug_memory_range().

Like you found below, the implementation enforces that add_memory_*()
interfaces maintain section alignment for @start and @size.

> In general, mix and matching system RAM and persistent memory per
> section, I am not a friend of that.

You have no choice. The platform may decide to map PMEM and System RAM
in the same section because the Linux section is too large compared to
typical memory controller mapping granularity capability.

> Especially when it comes to memory
> block devices. But I am getting the feeling that we are rather targeting
> PMEM vs. PMEM with this patch series.

The collisions are between System RAM, PMEM regions, and PMEM
namespaces (sub-divisions of regions that each need their own mapping
lifetime).

> > Quote patch7:
> >
> > "The libnvdimm sub-system has suffered a series of hacks and broken
> >  workarounds for the memory-hotplug implementation's awkward
> >  section-aligned (128MB) granularity. For example the following backtrace
> >  is emitted when attempting arch_add_memory() with physical address
> >  ranges that intersect 'System RAM' (RAM) with 'Persistent Memory' (PMEM)
> >  within a given section:
> >
> >   WARNING: CPU: 0 PID: 558 at kernel/memremap.c:300 devm_memremap_pages+0x3b5/0x4c0
> >   devm_memremap_pages attempted on mixed region [mem 0x200000000-0x2fbffffff flags 0x200]
> >   [..]
> >   Call Trace:
> >     dump_stack+0x86/0xc3
> >     __warn+0xcb/0xf0
> >     warn_slowpath_fmt+0x5f/0x80
> >     devm_memremap_pages+0x3b5/0x4c0
> >     __wrap_devm_memremap_pages+0x58/0x70 [nfit_test_iomap]
> >     pmem_attach_disk+0x19a/0x440 [nd_pmem]
> >
> >  Recently it was discovered that the problem goes beyond RAM vs PMEM
> >  collisions as some platform produce PMEM vs PMEM collisions within a
>
> As side-noted by Michal, I wonder if PMEM vs. PMEM cannot rather be
> implemented "on top" of what we have right now. Or is this what we
> already have that you call "hacks in nvdimm" code? (no NVDIMM expert,
> sorry for the stupid questions)

It doesn't work, because even if the padding was implemented 100%
correct, which thus far has failed to be the case, the platform may
change physical alignments from one boot to the next for a variety of
reasons.

>
> >  given section. The libnvdimm workaround for that case revealed that the
> >  libnvdimm section-alignment-padding implementation has been broken for a
> >  long while. A fix for that long-standing breakage introduces as many
> >  problems as it solves as it would require a backward-incompatible change
> >  to the namespace metadata interpretation. Instead of that dubious route
> >  [2], address the root problem in the memory-hotplug implementation."
> >
> > The approach is taken is to observe that each section already maintains
> > an array of 'unsigned long' values to hold the pageblock_flags. A single
> > additional 'unsigned long' is added to house a 'sub-section active'
> > bitmask. Each bit tracks the mapped state of one sub-section's worth of
> > capacity which is SECTION_SIZE / BITS_PER_LONG, or 2MB on x86-64.
> >
> > The implication of allowing sections to be piecemeal mapped/unmapped is
> > that the valid_section() helper is no longer authoritative to determine
> > if a section is fully mapped. Instead pfn_valid() is updated to consult
> > the section-active bitmask. Given that typical memory hotplug still has
> > deep "section" dependencies the sub-section capability is limited to
> > 'want_memblock=false' invocations of arch_add_memory(), effectively only
> > devm_memremap_pages() users for now.
>
> Ah, there it is. And my point would be, please don't ever unlock
> something like that for want_memblock=true. Especially not for memory
> added after boot via device drivers (add_memory()).

I don't see a strong reason why not, as long as it does not regress
existing use cases. It might need to be an opt-in for new tooling that
is aware of finer granularity hotplug. That said, I have no pressing
need to go there and just care about the arch_add_memory() capability
for now.
