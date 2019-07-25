Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7B3C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1252081B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389614AbfGYKPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 06:15:03 -0400
Received: from foss.arm.com ([217.140.110.172]:54824 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389418AbfGYKPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:15:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A82F28;
        Thu, 25 Jul 2019 03:15:02 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD3273F694;
        Thu, 25 Jul 2019 03:15:00 -0700 (PDT)
Date:   Thu, 25 Jul 2019 11:14:58 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH 1/2] kernel/fork: Add support for stack-end guard page
Message-ID: <20190725101458.GC14347@lakrids.cambridge.arm.com>
References: <20190719132818.40258-1-elver@google.com>
 <20190723164115.GB56959@lakrids.cambridge.arm.com>
 <CACT4Y+Y47_030eX-JiE1hFCyP5RiuTCSLZNKpTjuHwA5jQJ3+w@mail.gmail.com>
 <20190724112101.GB2624@lakrids.cambridge.arm.com>
 <CACT4Y+Zai+4VwNXS_a417M2m0DbtNhjTVdYga178ZDkvNnP4CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Zai+4VwNXS_a417M2m0DbtNhjTVdYga178ZDkvNnP4CQ@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 09:53:08AM +0200, Dmitry Vyukov wrote:
> On Wed, Jul 24, 2019 at 1:21 PM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Wed, Jul 24, 2019 at 11:11:49AM +0200, Dmitry Vyukov wrote:
> > > On Tue, Jul 23, 2019 at 6:41 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > > >
> > > > On Fri, Jul 19, 2019 at 03:28:17PM +0200, Marco Elver wrote:
> > > > > Enabling STACK_GUARD_PAGE helps catching kernel stack overflows immediately
> > > > > rather than causing difficult-to-diagnose corruption. Note that, unlike
> > > > > virtually-mapped kernel stacks, this will effectively waste an entire page of
> > > > > memory; however, this feature may provide extra protection in cases that cannot
> > > > > use virtually-mapped kernel stacks, at the cost of a page.
> > > > >
> > > > > The motivation for this patch is that KASAN cannot use virtually-mapped kernel
> > > > > stacks to detect stack overflows. An alternative would be implementing support
> > > > > for vmapped stacks in KASAN, but would add significant extra complexity.
> > > >
> > > > Do we have an idea as to how much additional complexity?
> > >
> > > We would need to map/unmap shadow for vmalloc region on stack
> > > allocation/deallocation. We may need to track shadow pages that cover
> > > both stack and an unused memory, or 2 different stacks, which are
> > > mapped/unmapped at different times. This may have some concurrency
> > > concerns.  Not sure what about page tables for other CPU, I've seen
> > > some code that updates pages tables for vmalloc region lazily on page
> > > faults. Not sure what about TLBs. Probably also some problems that I
> > > can't thought about now.
> >
> > Ok. So this looks big, we this hasn't been prototyped, so we don't have
> > a concrete idea. I agree that concurrency is likely to be painful. :)

> FTR, Daniel just mailed:
> 
> [PATCH 0/3] kasan: support backing vmalloc space with real shadow memory
> https://groups.google.com/forum/#!topic/kasan-dev/YuwLGJYPB4I
> Which presumably will supersede this.

Neat!

I'll try to follow that, (and thanks for the Cc there), but I'm not on
any of the lists it went to. IMO it would be nice if subsequent versions
would be Cc'd to LKML, if that's possible. :)

Thanks,
Mark.
