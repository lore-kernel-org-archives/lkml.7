Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B95C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A0D21855
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbfCNJGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 05:06:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:54422 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726284AbfCNJGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 05:06:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A2D92AEA3;
        Thu, 14 Mar 2019 09:06:35 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 49D8B1E3FE8; Thu, 14 Mar 2019 10:06:35 +0100 (CET)
Date:   Thu, 14 Mar 2019 10:06:35 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christopher Lameter <cl@linux.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, john.hubbard@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>, Jan Kara <jack@suse.cz>,
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
Subject: Re: [PATCH v3 0/1] mm: introduce put_user_page*(), placeholder
 versions
Message-ID: <20190314090635.GC16658@quack2.suse.cz>
References: <20190306235455.26348-1-jhubbard@nvidia.com>
 <010001695b4631cd-f4b8fcbf-a760-4267-afce-fb7969e3ff87-000000@email.amazonses.com>
 <20190310224742.GK26298@dastard>
 <01000169705aecf0-76f2b83d-ac18-4872-9421-b4b6efe19fc7-000000@email.amazonses.com>
 <20190312103932.GD1119@iweiny-DESK2.sc.intel.com>
 <20190312221113.GF23020@dastard>
 <20190313160319.GA15134@infradead.org>
 <010001697880bfdc-4503d0dd-03cd-4c91-84a0-c18af1eab145-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010001697880bfdc-4503d0dd-03cd-4c91-84a0-c18af1eab145-000000@email.amazonses.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13-03-19 19:21:37, Christopher Lameter wrote:
> On Wed, 13 Mar 2019, Christoph Hellwig wrote:
> 
> > On Wed, Mar 13, 2019 at 09:11:13AM +1100, Dave Chinner wrote:
> > > On Tue, Mar 12, 2019 at 03:39:33AM -0700, Ira Weiny wrote:
> > > > IMHO I don't think that the copy_file_range() is going to carry us through the
> > > > next wave of user performance requirements.  RDMA, while the first, is not the
> > > > only technology which is looking to have direct access to files.  XDP is
> > > > another.[1]
> > >
> > > Sure, all I doing here was demonstrating that people have been
> > > trying to get local direct access to file mappings to DMA directly
> > > into them for a long time. Direct Io games like these are now
> > > largely unnecessary because we now have much better APIs to do
> > > zero-copy data transfer between files (which can do hardware offload
> > > if it is available!).
> >
> > And that is just the file to file case.  There are tons of other
> > users of get_user_pages, including various drivers that do large
> > amounts of I/O like video capture.  For them it makes tons of sense
> > to transfer directly to/from a mmap()ed file.
> 
> That is very similar to the RDMA case and DAX etc. We need to have a way
> to tell a filesystem that this is going to happen and that things need to
> be setup for this to work properly.

The way to tell filesystem what's happening is exactly what we are working
on with these patches...

> But if that has not been done then I think its proper to fail a long term
> pin operation on page cache pages. Meaning the regular filesystems
> maintain control of whats happening with their pages.

And as I mentioned in my other email, we cannot just fail the pin for
pagecache pages as that would regress existing applications.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
