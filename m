Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA58C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E80217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfCNJDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 05:03:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:53978 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726436AbfCNJDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 05:03:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CD34FADFF;
        Thu, 14 Mar 2019 09:03:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0DFAA1E3FE8; Thu, 14 Mar 2019 10:03:45 +0100 (CET)
Date:   Thu, 14 Mar 2019 10:03:45 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christopher Lameter <cl@linux.com>
Cc:     Jerome Glisse <jglisse@redhat.com>, john.hubbard@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Al Viro <viro@zeniv.linux.org.uk>,
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
Message-ID: <20190314090345.GB16658@quack2.suse.cz>
References: <20190306235455.26348-1-jhubbard@nvidia.com>
 <010001695b4631cd-f4b8fcbf-a760-4267-afce-fb7969e3ff87-000000@email.amazonses.com>
 <20190308190704.GC5618@redhat.com>
 <01000169703e5495-2815ba73-34e8-45d5-b970-45784f653a34-000000@email.amazonses.com>
 <20190312153528.GB3233@redhat.com>
 <01000169787c61d0-cbc5486e-960a-492f-9ac9-9f6a466efeed-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01000169787c61d0-cbc5486e-960a-492f-9ac9-9f6a466efeed-000000@email.amazonses.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13-03-19 19:16:51, Christopher Lameter wrote:
> On Tue, 12 Mar 2019, Jerome Glisse wrote:
> 
> > > > This has been discuss extensively already. GUP usage is now widespread in
> > > > multiple drivers, removing that would regress userspace ie break existing
> > > > application. We all know what the rules for that is.
> 
> You are still misstating the issue. In RDMA land GUP is widely used for
> anonyous memory and memory based filesystems. *Not* for real filesystems.

Maybe in your RDMA land. But there are apparently other users which do use
mmap of a file on normal filesystem (e.g. ext4) as a buffer for DMA
(Infiniband does not prohibit this if nothing else, video capture devices
also use very similar pattern of gup-ing pages and using them as video
buffers). And these users are reporting occasional kernel crashes. That's
how this whole effort started. Sadly the DMA to file mmap is working good
enough that people started using it so at this point we cannot just tell:
Sorry it was a mistake to allow this, just rewrite your applications.

Plus we have O_DIRECT io which can use file mmap as a buffer and as Dave
Chinner mentioned there are real applications using this.

So no, we are not going to get away with "just forbid GUP for file backed
pages" which seems to be what you suggest. We might get away with that for
*some* GUP users and you are welcome to do that in the drivers you care
about but definitely not for all.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
