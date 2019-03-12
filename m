Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EE4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB3E2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfCLPfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:35:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26127 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfCLPff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:35:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9722F308FED2;
        Tue, 12 Mar 2019 15:35:33 +0000 (UTC)
Received: from redhat.com (ovpn-117-131.phx2.redhat.com [10.3.117.131])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C7025C280;
        Tue, 12 Mar 2019 15:35:30 +0000 (UTC)
Date:   Tue, 12 Mar 2019 11:35:29 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Christopher Lameter <cl@linux.com>
Cc:     john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v3 0/1] mm: introduce put_user_page*(), placeholder
 versions
Message-ID: <20190312153528.GB3233@redhat.com>
References: <20190306235455.26348-1-jhubbard@nvidia.com>
 <010001695b4631cd-f4b8fcbf-a760-4267-afce-fb7969e3ff87-000000@email.amazonses.com>
 <20190308190704.GC5618@redhat.com>
 <01000169703e5495-2815ba73-34e8-45d5-b970-45784f653a34-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01000169703e5495-2815ba73-34e8-45d5-b970-45784f653a34-000000@email.amazonses.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 12 Mar 2019 15:35:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 04:52:07AM +0000, Christopher Lameter wrote:
> On Fri, 8 Mar 2019, Jerome Glisse wrote:
> 
> > >
> > > It would good if that understanding would be enforced somehow given the problems
> > > that we see.
> >
> > This has been discuss extensively already. GUP usage is now widespread in
> > multiple drivers, removing that would regress userspace ie break existing
> > application. We all know what the rules for that is.
> 
> The applications that work are using anonymous memory and memory
> filesystems. I have never seen use cases with a real filesystem and would
> have objected if someone tried something crazy like that.
> 
> Because someone was able to get away with weird ways of abusing the system
> it not an argument that we should continue to allow such things. In fact
> we have repeatedly ensured that the kernel works reliably by improving the
> kernel so that a proper failure is occurring.

Driver doing GUP on mmap of regular file is something that seems to
already have widespread user (in the RDMA devices at least). So they
are active users and they were never told that what they are doing
was illegal.

Note that i am personaly fine with breaking device driver that can not
abide by mmu notifier but the consensus seems that it is not fine to
do so.

> > > > In fact, the GUP documentation even recommends that pattern.
> > >
> > > Isnt that pattern safe for anonymous memory and memory filesystems like
> > > hugetlbfs etc? Which is the common use case.
> >
> > Still an issue in respect to swapout ie if anon/shmem page was map
> > read only in preparation for swapout and we do not report the page
> > as dirty what endup in swap might lack what was written last through
> > GUP.
> 
> Well swapout cannot occur if the page is pinned and those pages are also
> often mlocked.

I would need to check the swapout code but i believe the write to disk
can happen before the pin checks happens. I believe the event flow is:
map read only, allocate swap, write to disk, try to free page which
checks for pin. So that you could write stale data to disk and the GUP
going away before you perform the pin checks.

They are other thing to take into account and that need proper page
dirtying, like soft dirtyness for instance.


> > >
> > > Yes you now have the filesystem as well as the GUP pinner claiming
> > > authority over the contents of a single memory segment. Maybe better not
> > > allow that?
> >
> > This goes back to regressing existing driver with existing users.
> 
> There is no regression if that behavior never really worked.

Well RDMA driver maintainer seems to report that this has been a valid
and working workload for their users.


> > > Two filesystem trying to sync one memory segment both believing to have
> > > exclusive access and we want to sort this out. Why? Dont allow this.
> >
> > This is allowed, it always was, forbidding that case now would regress
> > existing application and it would also means that we are modifying the
> > API we expose to userspace. So again this is not something we can block
> > without regressing existing user.
> 
> We have always stopped the user from doing obviously stupid and risky
> things. It would be logical to do it here as well.

While i would rather only allow device that can handle mmu notifier
it is just not acceptable to regress existing user and they do seem
to exist and had working setup going on for a while.

Cheers,
Jérôme
