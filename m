Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF48C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBFE2171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="mNs0GLwN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbfCMTRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:17:02 -0400
Received: from a9-35.smtp-out.amazonses.com ([54.240.9.35]:44142 "EHLO
        a9-35.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727545AbfCMTQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1552504611;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=nvIdXTvdBzRmRwQ0Wlhdqbz4+f72Q75prZrvS08u2DU=;
        b=mNs0GLwNl9xKR1X8gnj67r8fWgIFpKPvdnFupmcR/v1TqCwF+zAL9fq7tlL4mJj1
        prV0RUzPw/4sHohhMDsy7feO6rSMkyFpihUsF/I+bEn4+zKOiD6lv1BPOwb3WLblNoE
        6eeLXu7iSI62MppM0eQYFX/LSlNl39r960DEmpQU=
Date:   Wed, 13 Mar 2019 19:16:51 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Jerome Glisse <jglisse@redhat.com>
cc:     john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
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
In-Reply-To: <20190312153528.GB3233@redhat.com>
Message-ID: <01000169787c61d0-cbc5486e-960a-492f-9ac9-9f6a466efeed-000000@email.amazonses.com>
References: <20190306235455.26348-1-jhubbard@nvidia.com> <010001695b4631cd-f4b8fcbf-a760-4267-afce-fb7969e3ff87-000000@email.amazonses.com> <20190308190704.GC5618@redhat.com> <01000169703e5495-2815ba73-34e8-45d5-b970-45784f653a34-000000@email.amazonses.com>
 <20190312153528.GB3233@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.03.13-54.240.9.35
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019, Jerome Glisse wrote:

> > > This has been discuss extensively already. GUP usage is now widespread in
> > > multiple drivers, removing that would regress userspace ie break existing
> > > application. We all know what the rules for that is.

You are still misstating the issue. In RDMA land GUP is widely used for
anonyous memory and memory based filesystems. *Not* for real filesystems.

> > Because someone was able to get away with weird ways of abusing the system
> > it not an argument that we should continue to allow such things. In fact
> > we have repeatedly ensured that the kernel works reliably by improving the
> > kernel so that a proper failure is occurring.
>
> Driver doing GUP on mmap of regular file is something that seems to
> already have widespread user (in the RDMA devices at least). So they
> are active users and they were never told that what they are doing
> was illegal.

Not true. Again please differentiate the use cases between regular
filesystem and anonyous mappings.

> > Well swapout cannot occur if the page is pinned and those pages are also
> > often mlocked.
>
> I would need to check the swapout code but i believe the write to disk
> can happen before the pin checks happens. I believe the event flow is:
> map read only, allocate swap, write to disk, try to free page which
> checks for pin. So that you could write stale data to disk and the GUP
> going away before you perform the pin checks.

Allocate swap is a separate step that associates a swap entry to an
anonymous page.

> They are other thing to take into account and that need proper page
> dirtying, like soft dirtyness for instance.

RDMA mapped pages are all dirty all the time.

> Well RDMA driver maintainer seems to report that this has been a valid
> and working workload for their users.

No they dont.

Could you please get up to date on the discussion before posting?
