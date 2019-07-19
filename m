Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19529C76196
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0AAB2184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfGSMVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 08:21:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:45752 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728334AbfGSMVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 08:21:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EAEF8AF37;
        Fri, 19 Jul 2019 12:21:13 +0000 (UTC)
Date:   Fri, 19 Jul 2019 14:21:11 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 3/3] mm/vmalloc: Sync unmappings in vunmap_page_range()
Message-ID: <20190719122111.GD19068@suse.de>
References: <20190717071439.14261-1-joro@8bytes.org>
 <20190717071439.14261-4-joro@8bytes.org>
 <CALCETrXfCbajLhUixKNaMfFw91gzoQzt__faYLwyBqA3eAbQVA@mail.gmail.com>
 <20190718091745.GG13091@suse.de>
 <CALCETrXJYuHN872F74kVTuw4dYOc5saKqoUFbgJ5X0EuGEhXcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXJYuHN872F74kVTuw4dYOc5saKqoUFbgJ5X0EuGEhXcA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 12:04:49PM -0700, Andy Lutomirski wrote:
> I find it problematic that there is no meaningful documentation as to
> what vmalloc_sync_all() is supposed to do.

Yeah, I found that too, there is no real design around
vmalloc_sync_all(). It looks like it was just added to fit the purpose
on x86-32. That also makes it hard to find all necessary call-sites.

> Which is obviously entirely inapplicable.  If I'm understanding
> correctly, the underlying issue here is that the vmalloc fault
> mechanism can propagate PGD entry *addition*, but nothing (not even
> flush_tlb_kernel_range()) propagates PGD entry *removal*.

Close, the underlying issue is not about PGD, but PMD entry
addition/removal on x86-32 pae systems.

> I find it suspicious that only x86 has this.  How do other
> architectures handle this?

The problem on x86-PAE arises from the !SHARED_KERNEL_PMD case, which was
introduced by the  Xen-PV patches and then re-used for the PTI-x32
enablement to be able to map the LDT into user-space at a fixed address.

Other architectures probably don't have the !SHARED_KERNEL_PMD case (or
do unsharing of kernel page-tables on any level where a huge-page could
be mapped).

> At the very least, I think this series needs a comment in
> vmalloc_sync_all() explaining exactly what the function promises to
> do.

Okay, as it stands, it promises to sync mappings for the vmalloc area
between all PGDs in the system. I will add that as a comment.

> But maybe a better fix is to add code to flush_tlb_kernel_range()
> to sync the vmalloc area if the flushed range overlaps the vmalloc
> area.

That would also cause needless overhead on x86-64 because the vmalloc
area doesn't need syncing there. I can make it x86-32 only, but that is
not a clean solution imo.

> Or, even better, improve x86_32 the way we did x86_64: adjust
> the memory mapping code such that top-level paging entries are never
> deleted in the first place.

There is not enough address space on x86-32 to partition it like on
x86-64. In the default PAE configuration there are _four_ PGD entries,
usually one for the kernel, and then 512 PMD entries. Partitioning
happens on the PMD level, for example there is one entry (2MB of address
space) reserved for the user-space LDT mapping.

Regards,

	Joerg
