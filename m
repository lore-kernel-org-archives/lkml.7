Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9894AC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717252146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfCMTdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:33:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbfCMTdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:33:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 279E53092669;
        Wed, 13 Mar 2019 19:33:33 +0000 (UTC)
Received: from redhat.com (ovpn-125-95.rdu2.redhat.com [10.10.125.95])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F62F5ED2B;
        Wed, 13 Mar 2019 19:33:30 +0000 (UTC)
Date:   Wed, 13 Mar 2019 15:33:28 -0400
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
Message-ID: <20190313193328.GA4785@redhat.com>
References: <20190306235455.26348-1-jhubbard@nvidia.com>
 <010001695b4631cd-f4b8fcbf-a760-4267-afce-fb7969e3ff87-000000@email.amazonses.com>
 <20190308190704.GC5618@redhat.com>
 <01000169703e5495-2815ba73-34e8-45d5-b970-45784f653a34-000000@email.amazonses.com>
 <20190312153528.GB3233@redhat.com>
 <01000169787c61d0-cbc5486e-960a-492f-9ac9-9f6a466efeed-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01000169787c61d0-cbc5486e-960a-492f-9ac9-9f6a466efeed-000000@email.amazonses.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 13 Mar 2019 19:33:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 07:16:51PM +0000, Christopher Lameter wrote:
> On Tue, 12 Mar 2019, Jerome Glisse wrote:
> 
> > > > This has been discuss extensively already. GUP usage is now widespread in
> > > > multiple drivers, removing that would regress userspace ie break existing
> > > > application. We all know what the rules for that is.
> 
> You are still misstating the issue. In RDMA land GUP is widely used for
> anonyous memory and memory based filesystems. *Not* for real filesystems.

Then why are they bug report as one pointed out in cover letter ? It
means someone is doing GUP on filesystem. Moreover looking at RDMA
driver i do not see anything that check that VA for GUP belongs to a
vma that is not back by a regular file.

> 
> > > Because someone was able to get away with weird ways of abusing the system
> > > it not an argument that we should continue to allow such things. In fact
> > > we have repeatedly ensured that the kernel works reliably by improving the
> > > kernel so that a proper failure is occurring.
> >
> > Driver doing GUP on mmap of regular file is something that seems to
> > already have widespread user (in the RDMA devices at least). So they
> > are active users and they were never told that what they are doing
> > was illegal.
> 
> Not true. Again please differentiate the use cases between regular
> filesystem and anonyous mappings.

Again where does the bug comes from ? Where in RDMA is the check that
VA belong to a vma that is not back by a file ?

> 
> > > Well swapout cannot occur if the page is pinned and those pages are also
> > > often mlocked.
> >
> > I would need to check the swapout code but i believe the write to disk
> > can happen before the pin checks happens. I believe the event flow is:
> > map read only, allocate swap, write to disk, try to free page which
> > checks for pin. So that you could write stale data to disk and the GUP
> > going away before you perform the pin checks.
> 
> Allocate swap is a separate step that associates a swap entry to an
> anonymous page.
> 
> > They are other thing to take into account and that need proper page
> > dirtying, like soft dirtyness for instance.
> 
> RDMA mapped pages are all dirty all the time.

Point is the pte dirty bit might not be accurate nor the soft dirty bit
because GUP user does not update those bits and thus GUP user need to
call the set_page_dirty or similar to properly report page dirtyness.

> > Well RDMA driver maintainer seems to report that this has been a valid
> > and working workload for their users.
> 
> No they dont.
> 
> Could you please get up to date on the discussion before posting?

Again why is there bug report ? Where is the code in RDMA that check
that VA does not belong to vma that is back by a file ?

As much as i would like that this use case did not exist i fear it
does and it has been upstream for a while. This also very much apply
to O_DIRECT wether you like it or not.

Cheers,
Jérôme
