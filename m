Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0DBC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD95B20675
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="LUhUl4n6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfCHC6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 21:58:50 -0500
Received: from a9-36.smtp-out.amazonses.com ([54.240.9.36]:38110 "EHLO
        a9-36.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726318AbfCHC6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 21:58:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1552013928;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=itWZ1WtMJIGZ6hsAuOQydOeKK/mKEWYE0qj8U0Zh5dg=;
        b=LUhUl4n63lCPYiPmr2W/EC4A3CQqJvXLES+K1ez+E8EDvU0LfIcTIREwaehkqeC+
        Mpn7H4vdvNH0SkPUcyo2LXbZHPlZ/GZTsP0lkW/qQz5+HvI6uqWiZmUQVUdbt1L9iqT
        TMQi73k6EBDE7eSRQcr3OpbFo5DWBoWYCycMt2Mo=
Date:   Fri, 8 Mar 2019 02:58:48 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     john.hubbard@gmail.com
cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v3 1/1] mm: introduce put_user_page*(), placeholder
 versions
In-Reply-To: <20190306235455.26348-2-jhubbard@nvidia.com>
Message-ID: <010001695b3d2701-3215b423-7367-44d6-98bc-64fc2f84264a-000000@email.amazonses.com>
References: <20190306235455.26348-1-jhubbard@nvidia.com> <20190306235455.26348-2-jhubbard@nvidia.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.03.08-54.240.9.36
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2019, john.hubbard@gmail.com wrote:

> Dave Chinner's description of this is very clear:
>
>     "The fundamental issue is that ->page_mkwrite must be called on every
>     write access to a clean file backed page, not just the first one.
>     How long the GUP reference lasts is irrelevant, if the page is clean
>     and you need to dirty it, you must call ->page_mkwrite before it is
>     marked writeable and dirtied. Every. Time."
>
> This is just one symptom of the larger design problem: filesystems do not
> actually support get_user_pages() being called on their pages, and letting
> hardware write directly to those pages--even though that patter has been
> going on since about 2005 or so.

Can we distinguish between real filesystems that actually write to a
backing device and the special filesystems (like hugetlbfs, shm and
friends) that are like anonymous memory and do not require
->page_mkwrite() in the same way as regular filesystems?

The use that I have seen in my section of the world has been restricted to
RDMA and get_user_pages being limited to anonymous memory and those
special filesystems. And if the RDMA memory is of such type then the use
in the past and present is safe.

So a logical other approach would be to simply not allow the use of
long term get_user_page() on real filesystem pages. I hope this patch
supports that?

It is customary after all that a file read or write operation involve one
single file(!) and that what is written either comes from or goes to
memory (anonymous or special memory filesystem).

If you have an mmapped memory segment with a regular device backed file
then you already have one file associated with a memory segment and a
filesystem that does take care of synchronizing the contents of the memory
segment to a backing device.

If you now perform RDMA or device I/O on such a memory segment then you
will have *two* different devices interacting with that memory segment. I
think that ought not to happen and not be supported out of the box. It
will be difficult to handle and the semantics will be hard for users to
understand.

What could happen is that the filesystem could agree on request to allow
third party I/O to go to such a memory segment. But that needs to be well
defined and clearly and explicitly handled by some mechanism in user space
that has well defined semantics for data integrity for the filesystem as
well as the RDMA or device I/O.



