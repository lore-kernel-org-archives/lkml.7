Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD0EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E8A2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="aVKPXXb2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbfCMTVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:21:41 -0400
Received: from a9-114.smtp-out.amazonses.com ([54.240.9.114]:60654 "EHLO
        a9-114.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729022AbfCMTVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1552504897;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=SfWdjvUkwZe+2Dd4vugu5sfhOkXcR0c1mSWLWevFMhQ=;
        b=aVKPXXb2dmDsuNCuoE242Hhb6DL9Dz/3VVvfCRCmcoewVXQ6E4W2y6kaNFzmhegf
        51+NZvO/T47ln0z/M/zfOaOCUdoOyyj+3J/3laE7SgaayKBr3K6nkMnGUYrJyPUO6C/
        SnwSnQZll03tXHxBP9oj1tuhomYOFHWeP3Zt4SD8=
Date:   Wed, 13 Mar 2019 19:21:37 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Christoph Hellwig <hch@infradead.org>
cc:     Dave Chinner <david@fromorbit.com>,
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
In-Reply-To: <20190313160319.GA15134@infradead.org>
Message-ID: <010001697880bfdc-4503d0dd-03cd-4c91-84a0-c18af1eab145-000000@email.amazonses.com>
References: <20190306235455.26348-1-jhubbard@nvidia.com> <010001695b4631cd-f4b8fcbf-a760-4267-afce-fb7969e3ff87-000000@email.amazonses.com> <20190310224742.GK26298@dastard> <01000169705aecf0-76f2b83d-ac18-4872-9421-b4b6efe19fc7-000000@email.amazonses.com>
 <20190312103932.GD1119@iweiny-DESK2.sc.intel.com> <20190312221113.GF23020@dastard> <20190313160319.GA15134@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.03.13-54.240.9.114
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019, Christoph Hellwig wrote:

> On Wed, Mar 13, 2019 at 09:11:13AM +1100, Dave Chinner wrote:
> > On Tue, Mar 12, 2019 at 03:39:33AM -0700, Ira Weiny wrote:
> > > IMHO I don't think that the copy_file_range() is going to carry us through the
> > > next wave of user performance requirements.  RDMA, while the first, is not the
> > > only technology which is looking to have direct access to files.  XDP is
> > > another.[1]
> >
> > Sure, all I doing here was demonstrating that people have been
> > trying to get local direct access to file mappings to DMA directly
> > into them for a long time. Direct Io games like these are now
> > largely unnecessary because we now have much better APIs to do
> > zero-copy data transfer between files (which can do hardware offload
> > if it is available!).
>
> And that is just the file to file case.  There are tons of other
> users of get_user_pages, including various drivers that do large
> amounts of I/O like video capture.  For them it makes tons of sense
> to transfer directly to/from a mmap()ed file.

That is very similar to the RDMA case and DAX etc. We need to have a way
to tell a filesystem that this is going to happen and that things need to
be setup for this to work properly.

But if that has not been done then I think its proper to fail a long term
pin operation on page cache pages. Meaning the regular filesystems
maintain control of whats happening with their pages.
