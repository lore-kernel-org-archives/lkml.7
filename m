Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFF3C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36A12077B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfCLSlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:41:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:29281 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfCLSlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:41:04 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2019 11:41:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,471,1544515200"; 
   d="scan'208";a="306615952"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga005.jf.intel.com with ESMTP; 12 Mar 2019 11:41:02 -0700
Date:   Tue, 12 Mar 2019 03:39:33 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christopher Lameter <cl@linux.com>
Cc:     Dave Chinner <david@fromorbit.com>, john.hubbard@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
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
Message-ID: <20190312103932.GD1119@iweiny-DESK2.sc.intel.com>
References: <20190306235455.26348-1-jhubbard@nvidia.com>
 <010001695b4631cd-f4b8fcbf-a760-4267-afce-fb7969e3ff87-000000@email.amazonses.com>
 <20190310224742.GK26298@dastard>
 <01000169705aecf0-76f2b83d-ac18-4872-9421-b4b6efe19fc7-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01000169705aecf0-76f2b83d-ac18-4872-9421-b4b6efe19fc7-000000@email.amazonses.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 05:23:21AM +0000, Christopher Lameter wrote:
> On Mon, 11 Mar 2019, Dave Chinner wrote:
> 
> > > Direct IO on a mmapped file backed page doesnt make any sense.
> >
> > People have used it for many, many years as zero-copy data movement
> > pattern. i.e. mmap the destination file, use direct IO to DMA direct
> > into the destination file page cache pages, fdatasync() to force
> > writeback of the destination file.
> 
> Well we could make that more safe through a special API that designates a
> range of pages in a file in the same way as for RDMA. This is inherently
> not reliable as we found out.

I'm not following.  What API was not reliable?  In[2] we had ideas on such an
API but AFAIK these have not been tried.

From what I have seen the above is racy and is prone to the issues John has
seen.  The difference is that Direct IO has a smaller window than RDMA.  (Or at
least I thought we already established that?)

	"And also remember that while RDMA might be the case at least some
	people care about here it really isn't different from any of the other
	gup + I/O cases, including doing direct I/O to a mmap area.  The only
	difference in the various cases is how long the area should be pinned
	down..."

		-- Christoph Hellwig : https://lkml.org/lkml/2018/10/1/591

> 
> > Now we have copy_file_range() to optimise this sort of data
> > movement, the need for games with mmap+direct IO largely goes away.
> > However, we still can't just remove that functionality as it will
> > break lots of random userspace stuff...
> 
> It is already broken and unreliable. Are there really "lots" of these
> things around? Can we test this by adding a warning in the kernel and see
> where it actually crops up?

IMHO I don't think that the copy_file_range() is going to carry us through the
next wave of user performance requirements.  RDMA, while the first, is not the
only technology which is looking to have direct access to files.  XDP is
another.[1]

Ira

[1] https://www.kernel.org/doc/html/v4.19-rc1/networking/af_xdp.html
[2] https://lore.kernel.org/lkml/20190205175059.GB21617@iweiny-DESK2.sc.intel.com/

