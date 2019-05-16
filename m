Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C03C04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A930206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558005371;
	bh=wPq5dQpBho1HqAal08Xih0Vccmr15L0E+zjQKxqbDZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dNVzuRfLhdjuNo8BHjImTmOXdz13cPx7a/g8RPogRvnPemW4LagLO2DpHEHNQIilV
	 ZWAWp/kTrbYXFXnB558eEGAgCuJRM6N9P/NxuM90qr+yaOsCLXUy6WdwKSEHK97WX4
	 LM4XgsqoB3TdPklt05zS+0Qg0TXd2RjlJbYyG0G0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfEPLQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:16:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:32922 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726537AbfEPLQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:16:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AD50EAEF7;
        Thu, 16 May 2019 11:16:07 +0000 (UTC)
Date:   Thu, 16 May 2019 13:16:07 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        mgorman@techsingularity.net, james.morse@arm.com,
        robin.murphy@arm.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com, osalvador@suse.de,
        david@redhat.com, cai@lca.pw, logang@deltatee.com,
        ira.weiny@intel.com
Subject: Re: [PATCH V3 2/4] arm64/mm: Hold memory hotplug lock while walking
 for kernel page table dump
Message-ID: <20190516111607.GR16651@dhcp22.suse.cz>
References: <1557824407-19092-1-git-send-email-anshuman.khandual@arm.com>
 <1557824407-19092-3-git-send-email-anshuman.khandual@arm.com>
 <20190515165847.GH16651@dhcp22.suse.cz>
 <20190516102354.GB40960@lakrids.cambridge.arm.com>
 <a141ffa1-aa81-39df-11ba-9e18046356ff@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a141ffa1-aa81-39df-11ba-9e18046356ff@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16-05-19 16:36:12, Anshuman Khandual wrote:
> On 05/16/2019 03:53 PM, Mark Rutland wrote:
> > Hi Michal,
> > 
> > On Wed, May 15, 2019 at 06:58:47PM +0200, Michal Hocko wrote:
> >> On Tue 14-05-19 14:30:05, Anshuman Khandual wrote:
> >>> The arm64 pagetable dump code can race with concurrent modification of the
> >>> kernel page tables. When a leaf entries are modified concurrently, the dump
> >>> code may log stale or inconsistent information for a VA range, but this is
> >>> otherwise not harmful.
> >>>
> >>> When intermediate levels of table are freed, the dump code will continue to
> >>> use memory which has been freed and potentially reallocated for another
> >>> purpose. In such cases, the dump code may dereference bogus addressses,
> >>> leading to a number of potential problems.
> >>>
> >>> Intermediate levels of table may by freed during memory hot-remove, or when
> >>> installing a huge mapping in the vmalloc region. To avoid racing with these
> >>> cases, take the memory hotplug lock when walking the kernel page table.
> >>
> >> Why is this a problem only on arm64 
> > 
> > It looks like it's not -- I think we're just the first to realise this.
> > 
> > AFAICT x86's debugfs ptdump has the same issue if run conccurently with
> > memory hot remove. If 32-bit arm supported hot-remove, its ptdump code
> > would have the same issue.
> > 
> >> and why do we even care for debugfs? Does anybody rely on this thing
> >> to be reliable? Do we even need it? Who is using the file?
> > 
> > The debugfs part is used intermittently by a few people working on the
> > arm64 kernel page tables. We use that both to sanity-check that kernel
> > page tables are created/updated correctly after changes to the arm64 mmu
> > code, and also to debug issues if/when we encounter issues that appear
> > to be the result of kernel page table corruption.
> > 
> > So while it's rare to need it, it's really useful to have when we do
> > need it, and I'd rather not remove it. I'd also rather that it didn't
> > have latent issues where we can accidentally crash the kernel when using
> > it, which is what this patch is addressing.
> > 
> >> I am asking because I would really love to make mem hotplug locking less
> >> scattered outside of the core MM than more. Most users simply shouldn't
> >> care. Pfn walkers should rely on pfn_to_online_page.
> > 
> > I'm not sure if that would help us here; IIUC pfn_to_online_page() alone
> > doesn't ensure that the page remains online. Is there a way to achieve
> > that other than get_online_mems()?
> 
> Still wondering how pfn_to_online_page() is applicable here. It validates
> a given PFN and whether its online from sparse section mapping perspective
> before giving it's struct page. IIUC it is used during a linear scanning
> of a physical address range not for a page table walk. So how it can solve
> the problem when a struct page which was used as an intermediate level page
> table page gets released back to the buddy from another concurrent thread ?

Well, my comment about pfn_to_online_page was more generic and it might
not apply to this specific case. I meant to say that the code outside of
the core MM shouldn't really care about the hotplug locking.
-- 
Michal Hocko
SUSE Labs
