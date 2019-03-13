Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8379C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74CCA20643
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HAIUAFIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfCMQDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:03:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfCMQDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uNI5X/3NiZwWGw9ll+SGYgUYDbq0/M8f6aJJzFdlRg8=; b=HAIUAFIbqsW3BMxa/FP5NX1sG
        yw88chlyXN2ibo/Qu5d+gI4KxTZuL7AbNlHF0jJlGUzB21qP16G260680a2VUZLeipWU05Mn99LAu
        PpqWc6IqgqhyIMLkJEcfN72nGVnUjHbzkIcfuVkd6VEn+tXvqAXZavNAS5s0lksDJ73gRqY7kPQ1l
        JBqGDM9SN+rIsNP5uhBsIKXyqajBBvmyhH7qgWPZReT9+cYuPLpQDXyYo0hYgy6iZxpT1IxQlRJiI
        3WWBkZ6SbAAmf4MBUw1zyzXRfAEkSmW5eamvKicLBu/pT0jDDL1fpCBp+a72ig51Y279e15azLyL7
        29XFmWulA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h46Lf-0004Jg-Kg; Wed, 13 Mar 2019 16:03:19 +0000
Date:   Wed, 13 Mar 2019 09:03:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Christopher Lameter <cl@linux.com>, john.hubbard@gmail.com,
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
Message-ID: <20190313160319.GA15134@infradead.org>
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
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
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

And that is just the file to file case.  There are tons of other
users of get_user_pages, including various drivers that do large
amounts of I/O like video capture.  For them it makes tons of sense
to transfer directly to/from a mmap()ed file.
