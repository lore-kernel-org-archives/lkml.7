Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087A3C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 23:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF489217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 23:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfCLXYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 19:24:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:36994 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbfCLXYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 19:24:46 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2019 16:24:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,472,1544515200"; 
   d="scan'208";a="131107170"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga008.fm.intel.com with ESMTP; 12 Mar 2019 16:24:45 -0700
Date:   Tue, 12 Mar 2019 08:23:16 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christopher Lameter <cl@linux.com>, john.hubbard@gmail.com,
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
Message-ID: <20190312152316.GF1119@iweiny-DESK2.sc.intel.com>
References: <20190306235455.26348-1-jhubbard@nvidia.com>
 <010001695b4631cd-f4b8fcbf-a760-4267-afce-fb7969e3ff87-000000@email.amazonses.com>
 <20190310224742.GK26298@dastard>
 <01000169705aecf0-76f2b83d-ac18-4872-9421-b4b6efe19fc7-000000@email.amazonses.com>
 <20190312103932.GD1119@iweiny-DESK2.sc.intel.com>
 <20190312221113.GF23020@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312221113.GF23020@dastard>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 09:11:13AM +1100, Dave Chinner wrote:
> On Tue, Mar 12, 2019 at 03:39:33AM -0700, Ira Weiny wrote:
> > IMHO I don't think that the copy_file_range() is going to carry us through the
> > next wave of user performance requirements.  RDMA, while the first, is not the
> > only technology which is looking to have direct access to files.  XDP is
> > another.[1]
> 
> Sure, all I doing here was demonstrating that people have been
> trying to get local direct access to file mappings to DMA directly
> into them for a long time. Direct Io games like these are now
> largely unnecessary because we now have much better APIs to do
> zero-copy data transfer between files (which can do hardware offload
> if it is available!).
> 
> It's the long term pins that RDMA does that are the problem here.
> I'm asssuming that for XDP, you're talking about userspace zero copy
> from files to the network hardware and vice versa? transmit is
> simple (read-only mapping), but receive probably requires bpf
> programs to ensure that data (minus headers) in the incoming packet
> stream is correctly placed into the UMEM region?

Yes, exactly.

> 
> XDP receive seems pretty much like the same problem as RDMA writes
> into the file. i.e.  the incoming write DMAs are going to have to
> trigger page faults if the UMEM is a long term pin so the filesystem
> behaves correctly with this remote data placement.  I'd suggest that
> RDMA, XDP and anything other hardware that is going to pin
> file-backed mappings for the long term need to use the same "inform
> the fs of a write operation into it's mapping" mechanisms...

Yes agreed.  I have a hack patch I'm testing right now which allows the user to
take a LAYOUT lease from user space and GUP triggers on that, either allowing
or rejecting the pin based on the lease.  I think this is the first step of
what Jan suggested.[1]  There is a lot more detail to work out with what
happens if that lease needs to be broken.

> 
> And if we start talking about wanting to do peer-to-peer DMA from
> network/GPU device to storage device without going through a
> file-backed CPU mapping, we still need to have the filesystem
> involved to translate file offsets to storage locations the
> filesystem has allocated for the data and to lock them down for as
> long as the peer-to-peer DMA offload is in place.  In effect, this
> is the same problem as RDMA+FS-DAXs - the filesystem owns the file
> offset to storage location mapping and manages storage access
> arbitration, not the mm/vma mapping presented to userspace....

I've only daydreamed about Peer-to-peer transfers.  But yes I think this is the
direction we need to go.  But The details of doing a

GPU -> RDMA -> {network } -> RDMA -> FS DAX

And back again... without CPU/OS involvement are only a twinkle in my eye...
If that.

Ira

[1] https://lore.kernel.org/lkml/20190212160707.GA19076@quack2.suse.cz/

