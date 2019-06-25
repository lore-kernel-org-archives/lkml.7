Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2287AC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2440214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfFYKbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 06:31:38 -0400
Received: from foss.arm.com ([217.140.110.172]:38290 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbfFYKbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:31:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80371360;
        Tue, 25 Jun 2019 03:31:37 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91F543F71E;
        Tue, 25 Jun 2019 03:31:34 -0700 (PDT)
Date:   Tue, 25 Jun 2019 11:31:29 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Steve Capper <Steve.Capper@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "david@redhat.com" <david@redhat.com>, "cai@lca.pw" <cai@lca.pw>,
        "logang@deltatee.com" <logang@deltatee.com>,
        James Morse <James.Morse@arm.com>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "arunks@codeaurora.org" <arunks@codeaurora.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "osalvador@suse.de" <osalvador@suse.de>,
        Ard Biesheuvel <Ard.Biesheuvel@arm.com>, nd <nd@arm.com>
Subject: Re: [PATCH V6 3/3] arm64/mm: Enable memory hot remove
Message-ID: <20190625103128.GA12207@lakrids.cambridge.arm.com>
References: <1560917860-26169-1-git-send-email-anshuman.khandual@arm.com>
 <1560917860-26169-4-git-send-email-anshuman.khandual@arm.com>
 <20190621143540.GA3376@capper-debian.cambridge.arm.com>
 <20190624165148.GA9847@lakrids.cambridge.arm.com>
 <48f39fa1-c369-c8e2-4572-b7e016dca2d6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48f39fa1-c369-c8e2-4572-b7e016dca2d6@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 10:57:07AM +0530, Anshuman Khandual wrote:
> On 06/24/2019 10:22 PM, Mark Rutland wrote:
> > On Fri, Jun 21, 2019 at 03:35:53PM +0100, Steve Capper wrote:
> >> On Wed, Jun 19, 2019 at 09:47:40AM +0530, Anshuman Khandual wrote:
> >>> +static void free_hotplug_page_range(struct page *page, size_t size)
> >>> +{
> >>> +	WARN_ON(!page || PageReserved(page));
> >>> +	free_pages((unsigned long)page_address(page), get_order(size));
> >>> +}
> >>
> >> We are dealing with power of 2 number of pages, it makes a lot more
> >> sense (to me) to replace the size parameter with order.
> >>
> >> Also, all the callers are for known compile-time sizes, so we could just
> >> translate the size parameter as follows to remove any usage of get_order?
> >> PAGE_SIZE -> 0
> >> PMD_SIZE -> PMD_SHIFT - PAGE_SHIFT
> >> PUD_SIZE -> PUD_SHIFT - PAGE_SHIFT
> > 
> > Now that I look at this again, the above makes sense to me.
> > 
> > I'd requested the current form (which I now realise is broken), since
> > back in v2 the code looked like:
> > 
> > static void free_pagetable(struct page *page, int order)
> > {
> > 	...
> > 	free_pages((unsigned long)page_address(page), order);
> > 	...
> > }
> > 
> > ... with callsites looking like:
> > 
> > free_pagetable(pud_page(*pud), get_order(PUD_SIZE));
> > 
> > ... which I now see is off by PAGE_SHIFT, and we inherited that bug in
> > the current code, so the calculated order is vastly larger than it
> > should be. It's worrying that doesn't seem to be caught by anything in
> > testing. :/
> 
> get_order() returns the minimum page allocation order for a given size
> which already takes into account PAGE_SHIFT i.e get_order(PAGE_SIZE)
> returns 0.

Phew.

Let's leave this as is then -- it's clearer/simpler than using the SHIFT
constants, performance isn't a major concern in this path, and it's very
likely that GCC will inline and constant-fold this away regardless.

Sorry for the noise, and thanks for correcting me.

Mark.
