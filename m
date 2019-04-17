Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD8BC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133822073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbfDQRjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:39:54 -0400
Received: from foss.arm.com ([217.140.101.70]:48904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbfDQRjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:39:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB00C15AB;
        Wed, 17 Apr 2019 10:39:53 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0CFD3F59C;
        Wed, 17 Apr 2019 10:39:50 -0700 (PDT)
Date:   Wed, 17 Apr 2019 18:39:48 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, will.deacon@arm.com,
        catalin.marinas@arm.com, mhocko@suse.com,
        mgorman@techsingularity.net, james.morse@arm.com,
        robin.murphy@arm.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com, osalvador@suse.de,
        david@redhat.com, cai@lca.pw, logang@deltatee.com,
        ira.weiny@intel.com
Subject: Re: [PATCH V2 2/2] arm64/mm: Enable memory hot remove
Message-ID: <20190417173948.GB15589@lakrids.cambridge.arm.com>
References: <1555221553-18845-1-git-send-email-anshuman.khandual@arm.com>
 <1555221553-18845-3-git-send-email-anshuman.khandual@arm.com>
 <20190415134841.GC13990@lakrids.cambridge.arm.com>
 <2faba38b-ab79-2dda-1b3c-ada5054d91fa@arm.com>
 <20190417142154.GA393@lakrids.cambridge.arm.com>
 <bba0b71c-2d04-d589-e2bf-5de37806548f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bba0b71c-2d04-d589-e2bf-5de37806548f@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 10:15:35PM +0530, Anshuman Khandual wrote:
> On 04/17/2019 07:51 PM, Mark Rutland wrote:
> > On Wed, Apr 17, 2019 at 03:28:18PM +0530, Anshuman Khandual wrote:
> >> On 04/15/2019 07:18 PM, Mark Rutland wrote:
> >>> On Sun, Apr 14, 2019 at 11:29:13AM +0530, Anshuman Khandual wrote:

> >>>> +	spin_unlock(&init_mm.page_table_lock);
> >>>
> >>> What precisely is the page_table_lock intended to protect?
> >>
> >> Concurrent modification to kernel page table (init_mm) while clearing entries.
> > 
> > Concurrent modification by what code?
> > 
> > If something else can *modify* the portion of the table that we're
> > manipulating, then I don't see how we can safely walk the table up to
> > this point without holding the lock, nor how we can safely add memory.
> > 
> > Even if this is to protect something else which *reads* the tables,
> > other code in arm64 which modifies the kernel page tables doesn't take
> > the lock.
> > 
> > Usually, if you can do a lockless walk you have to verify that things
> > didn't change once you've taken the lock, but we don't follow that
> > pattern here.
> > 
> > As things stand it's not clear to me whether this is necessary or
> > sufficient.
> 
> Hence lets take more conservative approach and wrap the entire process of
> remove_pagetable() under init_mm.page_table_lock which looks safe unless
> in the worst case when free_pages() gets stuck for some reason in which
> case we have bigger memory problem to deal with than a soft lock up.

Sorry, but I'm not happy with _any_ solution until we understand where
and why we need to take the init_mm ptl, and have made some effort to
ensure that the kernel correctly does so elsewhere. It is not sufficient
to consider this code in isolation.

IIUC, before this patch we never clear non-leaf entries in the kernel
page tables, so readers don't presently need to take the ptl in order to
safely walk down to a leaf entry.

For example, the arm64 ptdump code never takes the ptl, and as of this
patch it will blow up if it races with a hot-remove, regardless of
whether the hot-remove code itself holds the ptl.

Note that the same applies to the x86 ptdump code; we cannot assume that
just because x86 does something that it happens to be correct.

I strongly suspect there are other cases that would fall afoul of this,
in both arm64 and generic code.

Thanks,
Mark.
