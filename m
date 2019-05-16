Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29084C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAFB7206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfEPKYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 06:24:01 -0400
Received: from foss.arm.com ([217.140.101.70]:40400 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbfEPKYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 06:24:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26DA019BF;
        Thu, 16 May 2019 03:24:00 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E5713F703;
        Thu, 16 May 2019 03:23:57 -0700 (PDT)
Date:   Thu, 16 May 2019 11:23:54 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        will.deacon@arm.com, mgorman@techsingularity.net,
        james.morse@arm.com, robin.murphy@arm.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com, osalvador@suse.de,
        david@redhat.com, cai@lca.pw, logang@deltatee.com,
        ira.weiny@intel.com
Subject: Re: [PATCH V3 2/4] arm64/mm: Hold memory hotplug lock while walking
 for kernel page table dump
Message-ID: <20190516102354.GB40960@lakrids.cambridge.arm.com>
References: <1557824407-19092-1-git-send-email-anshuman.khandual@arm.com>
 <1557824407-19092-3-git-send-email-anshuman.khandual@arm.com>
 <20190515165847.GH16651@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515165847.GH16651@dhcp22.suse.cz>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Wed, May 15, 2019 at 06:58:47PM +0200, Michal Hocko wrote:
> On Tue 14-05-19 14:30:05, Anshuman Khandual wrote:
> > The arm64 pagetable dump code can race with concurrent modification of the
> > kernel page tables. When a leaf entries are modified concurrently, the dump
> > code may log stale or inconsistent information for a VA range, but this is
> > otherwise not harmful.
> > 
> > When intermediate levels of table are freed, the dump code will continue to
> > use memory which has been freed and potentially reallocated for another
> > purpose. In such cases, the dump code may dereference bogus addressses,
> > leading to a number of potential problems.
> > 
> > Intermediate levels of table may by freed during memory hot-remove, or when
> > installing a huge mapping in the vmalloc region. To avoid racing with these
> > cases, take the memory hotplug lock when walking the kernel page table.
> 
> Why is this a problem only on arm64 

It looks like it's not -- I think we're just the first to realise this.

AFAICT x86's debugfs ptdump has the same issue if run conccurently with
memory hot remove. If 32-bit arm supported hot-remove, its ptdump code
would have the same issue.

> and why do we even care for debugfs? Does anybody rely on this thing
> to be reliable? Do we even need it? Who is using the file?

The debugfs part is used intermittently by a few people working on the
arm64 kernel page tables. We use that both to sanity-check that kernel
page tables are created/updated correctly after changes to the arm64 mmu
code, and also to debug issues if/when we encounter issues that appear
to be the result of kernel page table corruption.

So while it's rare to need it, it's really useful to have when we do
need it, and I'd rather not remove it. I'd also rather that it didn't
have latent issues where we can accidentally crash the kernel when using
it, which is what this patch is addressing.

> I am asking because I would really love to make mem hotplug locking less
> scattered outside of the core MM than more. Most users simply shouldn't
> care. Pfn walkers should rely on pfn_to_online_page.

I'm not sure if that would help us here; IIUC pfn_to_online_page() alone
doesn't ensure that the page remains online. Is there a way to achieve
that other than get_online_mems()?

The big problem for the ptdump code is when tables are freed, since the
pages can be reused elsewhere (or hot-removed), causing the ptdump code
to explode.

Thanks,
Mark.
