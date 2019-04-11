Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C1AC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBCEF206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfDKOjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 10:39:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbfDKOjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 10:39:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 773A3307B487;
        Thu, 11 Apr 2019 14:39:26 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CE2F65D9C8;
        Thu, 11 Apr 2019 14:39:20 +0000 (UTC)
Date:   Thu, 11 Apr 2019 10:39:19 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, kvm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 7/8] mm/mmu_notifier: pass down vma and reasons why
 mmu notifier is happening v2
Message-ID: <20190411143918.GA4266@redhat.com>
References: <20190326164747.24405-1-jglisse@redhat.com>
 <20190326164747.24405-8-jglisse@redhat.com>
 <20190410234124.GE22989@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190410234124.GE22989@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 11 Apr 2019 14:39:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 04:41:57PM -0700, Ira Weiny wrote:
> On Tue, Mar 26, 2019 at 12:47:46PM -0400, Jerome Glisse wrote:
> > From: Jérôme Glisse <jglisse@redhat.com>
> > 
> > CPU page table update can happens for many reasons, not only as a result
> > of a syscall (munmap(), mprotect(), mremap(), madvise(), ...) but also
> > as a result of kernel activities (memory compression, reclaim, migration,
> > ...).
> > 
> > Users of mmu notifier API track changes to the CPU page table and take
> > specific action for them. While current API only provide range of virtual
> > address affected by the change, not why the changes is happening
> > 
> > This patch is just passing down the new informations by adding it to the
> > mmu_notifier_range structure.
> > 
> > Changes since v1:
> >     - Initialize flags field from mmu_notifier_range_init() arguments
> > 
> > Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: linux-mm@kvack.org
> > Cc: Christian König <christian.koenig@amd.com>
> > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> > Cc: Jason Gunthorpe <jgg@mellanox.com>
> > Cc: Ross Zwisler <zwisler@kernel.org>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Radim Krčmář <rkrcmar@redhat.com>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Ralph Campbell <rcampbell@nvidia.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: kvm@vger.kernel.org
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-rdma@vger.kernel.org
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  include/linux/mmu_notifier.h | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> > index 62f94cd85455..0379956fff23 100644
> > --- a/include/linux/mmu_notifier.h
> > +++ b/include/linux/mmu_notifier.h
> > @@ -58,10 +58,12 @@ struct mmu_notifier_mm {
> >  #define MMU_NOTIFIER_RANGE_BLOCKABLE (1 << 0)
> >  
> >  struct mmu_notifier_range {
> > +	struct vm_area_struct *vma;
> >  	struct mm_struct *mm;
> >  	unsigned long start;
> >  	unsigned long end;
> >  	unsigned flags;
> > +	enum mmu_notifier_event event;
> >  };
> >  
> >  struct mmu_notifier_ops {
> > @@ -363,10 +365,12 @@ static inline void mmu_notifier_range_init(struct mmu_notifier_range *range,
> >  					   unsigned long start,
> >  					   unsigned long end)
> >  {
> > +	range->vma = vma;
> > +	range->event = event;
> >  	range->mm = mm;
> >  	range->start = start;
> >  	range->end = end;
> > -	range->flags = 0;
> > +	range->flags = flags;
> 
> Which of the "user patch sets" uses the new flags?
> 
> I'm not seeing that user yet.  In general I don't see anything wrong with the
> series and I like the idea of telling drivers why the invalidate has fired.
> 
> But is the flags a future feature?
> 

I believe the link were in the cover:

https://lkml.org/lkml/2019/1/23/833
https://lkml.org/lkml/2019/1/23/834
https://lkml.org/lkml/2019/1/23/832
https://lkml.org/lkml/2019/1/23/831

I have more coming for HMM but i am waiting after 5.2 once amdgpu
HMM patch are merge upstream as it will change what is passed down
to driver and it would conflict with non merged HMM driver (like
amdgpu today).

Cheers,
Jérôme
