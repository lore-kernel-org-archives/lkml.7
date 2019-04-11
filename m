Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C3EC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26DE2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfDKRBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:01:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41894 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbfDKRBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 13:01:02 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D309E88ADF;
        Thu, 11 Apr 2019 17:00:59 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 800B612A68;
        Thu, 11 Apr 2019 17:00:56 +0000 (UTC)
Date:   Thu, 11 Apr 2019 13:00:54 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ross Zwisler <zwisler@kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?iso-8859-1?Q?Krcm=E1r?= <rkrcmar@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 7/8] mm/mmu_notifier: pass down vma and reasons why
 mmu notifier is happening v2
Message-ID: <20190411170054.GB4266@redhat.com>
References: <20190326164747.24405-1-jglisse@redhat.com>
 <20190326164747.24405-8-jglisse@redhat.com>
 <20190410234124.GE22989@iweiny-DESK2.sc.intel.com>
 <20190411143918.GA4266@redhat.com>
 <2807E5FD2F6FDA4886F6618EAC48510E79CAEBED@CRSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2807E5FD2F6FDA4886F6618EAC48510E79CAEBED@CRSMSX101.amr.corp.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 11 Apr 2019 17:01:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 03:21:08PM +0000, Weiny, Ira wrote:
> > On Wed, Apr 10, 2019 at 04:41:57PM -0700, Ira Weiny wrote:
> > > On Tue, Mar 26, 2019 at 12:47:46PM -0400, Jerome Glisse wrote:
> > > > From: Jérôme Glisse <jglisse@redhat.com>
> > > >
> > > > CPU page table update can happens for many reasons, not only as a
> > > > result of a syscall (munmap(), mprotect(), mremap(), madvise(), ...)
> > > > but also as a result of kernel activities (memory compression,
> > > > reclaim, migration, ...).
> > > >
> > > > Users of mmu notifier API track changes to the CPU page table and
> > > > take specific action for them. While current API only provide range
> > > > of virtual address affected by the change, not why the changes is
> > > > happening
> > > >
> > > > This patch is just passing down the new informations by adding it to
> > > > the mmu_notifier_range structure.
> > > >
> > > > Changes since v1:
> > > >     - Initialize flags field from mmu_notifier_range_init()
> > > > arguments
> > > >
> > > > Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Cc: linux-mm@kvack.org
> > > > Cc: Christian König <christian.koenig@amd.com>
> > > > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > > > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > > > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > > Cc: Jan Kara <jack@suse.cz>
> > > > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > > > Cc: Peter Xu <peterx@redhat.com>
> > > > Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> > > > Cc: Jason Gunthorpe <jgg@mellanox.com>
> > > > Cc: Ross Zwisler <zwisler@kernel.org>
> > > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > > Cc: Radim Krčmář <rkrcmar@redhat.com>
> > > > Cc: Michal Hocko <mhocko@kernel.org>
> > > > Cc: Christian Koenig <christian.koenig@amd.com>
> > > > Cc: Ralph Campbell <rcampbell@nvidia.com>
> > > > Cc: John Hubbard <jhubbard@nvidia.com>
> > > > Cc: kvm@vger.kernel.org
> > > > Cc: dri-devel@lists.freedesktop.org
> > > > Cc: linux-rdma@vger.kernel.org
> > > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > > ---
> > > >  include/linux/mmu_notifier.h | 6 +++++-
> > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/linux/mmu_notifier.h
> > > > b/include/linux/mmu_notifier.h index 62f94cd85455..0379956fff23
> > > > 100644
> > > > --- a/include/linux/mmu_notifier.h
> > > > +++ b/include/linux/mmu_notifier.h
> > > > @@ -58,10 +58,12 @@ struct mmu_notifier_mm {  #define
> > > > MMU_NOTIFIER_RANGE_BLOCKABLE (1 << 0)
> > > >
> > > >  struct mmu_notifier_range {
> > > > +	struct vm_area_struct *vma;
> > > >  	struct mm_struct *mm;
> > > >  	unsigned long start;
> > > >  	unsigned long end;
> > > >  	unsigned flags;
> > > > +	enum mmu_notifier_event event;
> > > >  };
> > > >
> > > >  struct mmu_notifier_ops {
> > > > @@ -363,10 +365,12 @@ static inline void
> > mmu_notifier_range_init (struct mmu_notifier_range *range,
> > > >  					   unsigned long start,
> > > >  					   unsigned long end)
> > > >  {
> > > > +	range->vma = vma;
> > > > +	range->event = event;
> > > >  	range->mm = mm;
> > > >  	range->start = start;
> > > >  	range->end = end;
> > > > -	range->flags = 0;
> > > > +	range->flags = flags;
> > >
> > > Which of the "user patch sets" uses the new flags?
> > >
> > > I'm not seeing that user yet.  In general I don't see anything wrong
> > > with the series and I like the idea of telling drivers why the invalidate has
> > fired.
> > >
> > > But is the flags a future feature?
> > >
> > 
> > I believe the link were in the cover:
> > 
> > https://lkml.org/lkml/2019/1/23/833
> > https://lkml.org/lkml/2019/1/23/834
> > https://lkml.org/lkml/2019/1/23/832
> > https://lkml.org/lkml/2019/1/23/831
> > 
> > I have more coming for HMM but i am waiting after 5.2 once amdgpu HMM
> > patch are merge upstream as it will change what is passed down to driver
> > and it would conflict with non merged HMM driver (like amdgpu today).
> > 
> 
> Unfortunately this does not answer my question.  Yes I saw the links to the patches which use this in the header.  Furthermore, I checked the links again, I still do not see a use of range->flags nor a use of the new flags parameter to mmu_notifier_range_init().
> 
> I still gave a reviewed by because I'm not saying it is wrong I'm just trying to understand what use drivers have of this flag.
> 
> So again I'm curious what is the use case of these flags and the use case of exposing it to the users of MMU notifiers?

Oh sorry did miss the exact question, not enough coffee. The
flags is use for BLOCKABLE i converted the bool blockable to
an int flags field so that we can have flags in the future.
The first user is probably gonna be for restoring the KVM
change_pte() optimization.

https://lkml.org/lkml/2019/2/19/754
https://lkml.org/lkml/2019/2/20/1087

I droped the CHANGE_PTE flags from this version as i need to
harass the KVM people some more for them to review this as
today the change_pte() optimization does not work so today
the change_pte() callback are useless and just wasting CPU
cycles.

Cheers,
Jérôme
