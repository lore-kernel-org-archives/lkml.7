Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B56C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBC22182B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfHSKPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 06:15:25 -0400
Received: from foss.arm.com ([217.140.110.172]:52078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbfHSKPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:15:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52B92344;
        Mon, 19 Aug 2019 03:15:24 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B14723F706;
        Mon, 19 Aug 2019 03:15:22 -0700 (PDT)
Date:   Mon, 19 Aug 2019 11:15:18 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Daniel Axtens <dja@axtens.net>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>, X86 ML <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v4 1/3] kasan: support backing vmalloc space with real
 shadow memory
Message-ID: <20190819101517.GA7482@lakrids.cambridge.arm.com>
References: <20190815001636.12235-1-dja@axtens.net>
 <20190815001636.12235-2-dja@axtens.net>
 <15c6110a-9e6e-495c-122e-acbde6e698d9@c-s.fr>
 <20190816170813.GA7417@lakrids.cambridge.arm.com>
 <CALCETrUn4FNjvRoJW77DNi5vdwO+EURUC_46tysjPQD0MM3THQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrUn4FNjvRoJW77DNi5vdwO+EURUC_46tysjPQD0MM3THQ@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 10:41:00AM -0700, Andy Lutomirski wrote:
> On Fri, Aug 16, 2019 at 10:08 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > Hi Christophe,
> >
> > On Fri, Aug 16, 2019 at 09:47:00AM +0200, Christophe Leroy wrote:
> > > Le 15/08/2019 à 02:16, Daniel Axtens a écrit :
> > > > Hook into vmalloc and vmap, and dynamically allocate real shadow
> > > > memory to back the mappings.
> > > >
> > > > Most mappings in vmalloc space are small, requiring less than a full
> > > > page of shadow space. Allocating a full shadow page per mapping would
> > > > therefore be wasteful. Furthermore, to ensure that different mappings
> > > > use different shadow pages, mappings would have to be aligned to
> > > > KASAN_SHADOW_SCALE_SIZE * PAGE_SIZE.
> > > >
> > > > Instead, share backing space across multiple mappings. Allocate
> > > > a backing page the first time a mapping in vmalloc space uses a
> > > > particular page of the shadow region. Keep this page around
> > > > regardless of whether the mapping is later freed - in the mean time
> > > > the page could have become shared by another vmalloc mapping.
> > > >
> > > > This can in theory lead to unbounded memory growth, but the vmalloc
> > > > allocator is pretty good at reusing addresses, so the practical memory
> > > > usage grows at first but then stays fairly stable.
> > >
> > > I guess people having gigabytes of memory don't mind, but I'm concerned
> > > about tiny targets with very little amount of memory. I have boards with as
> > > little as 32Mbytes of RAM. The shadow region for the linear space already
> > > takes one eighth of the RAM. I'd rather avoid keeping unused shadow pages
> > > busy.
> >
> > I think this depends on how much shadow would be in constant use vs what
> > would get left unused. If the amount in constant use is sufficiently
> > large (or the residue is sufficiently small), then it may not be
> > worthwhile to support KASAN_VMALLOC on such small systems.
> >
> > > Each page of shadow memory represent 8 pages of real memory. Could we use
> > > page_ref to count how many pieces of a shadow page are used so that we can
> > > free it when the ref count decreases to 0.
> > >
> > > > This requires architecture support to actually use: arches must stop
> > > > mapping the read-only zero page over portion of the shadow region that
> > > > covers the vmalloc space and instead leave it unmapped.
> > >
> > > Why 'must' ? Couldn't we switch back and forth from the zero page to real
> > > page on demand ?
> > >
> > > If the zero page is not mapped for unused vmalloc space, bad memory accesses
> > > will Oops on the shadow memory access instead of Oopsing on the real bad
> > > access, making it more difficult to locate and identify the issue.
> >
> > I agree this isn't nice, though FWIW this can already happen today for
> > bad addresses that fall outside of the usual kernel address space. We
> > could make the !KASAN_INLINE checks resilient to this by using
> > probe_kernel_read() to check the shadow, and treating unmapped shadow as
> > poison.
> 
> Could we instead modify the page fault handlers to detect this case
> and print a useful message?

In general we can't know if a bad access was a KASAN shadow lookup (e.g.
since the shadow of NULL falls outside of the shadow region), but we
could always print a message using kasan_shadow_to_mem() for any
unhandled fault to suggeest what the "real" address might have been.

Thanks,
Mark.
