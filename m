Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D6FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 22:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9306620657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 22:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfCJWsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 18:48:00 -0400
Received: from ipmail03.adl2.internode.on.net ([150.101.137.141]:50623 "EHLO
        ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726758AbfCJWsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 18:48:00 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail03.adl2.internode.on.net with ESMTP; 11 Mar 2019 09:17:43 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1h37EM-000788-Dm; Mon, 11 Mar 2019 09:47:42 +1100
Date:   Mon, 11 Mar 2019 09:47:42 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christopher Lameter <cl@linux.com>
Cc:     john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
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
Subject: Re: [PATCH v3 0/1] mm: introduce put_user_page*(), placeholder
 versions
Message-ID: <20190310224742.GK26298@dastard>
References: <20190306235455.26348-1-jhubbard@nvidia.com>
 <010001695b4631cd-f4b8fcbf-a760-4267-afce-fb7969e3ff87-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010001695b4631cd-f4b8fcbf-a760-4267-afce-fb7969e3ff87-000000@email.amazonses.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 03:08:40AM +0000, Christopher Lameter wrote:
> On Wed, 6 Mar 2019, john.hubbard@gmail.com wrote:
> > Direct IO
> > =========
> >
> > Direct IO can cause corruption, if userspace does Direct-IO that writes to
> > a range of virtual addresses that are mmap'd to a file.  The pages written
> > to are file-backed pages that can be under write back, while the Direct IO
> > is taking place.  Here, Direct IO races with a write back: it calls
> > GUP before page_mkclean() has replaced the CPU pte with a read-only entry.
> > The race window is pretty small, which is probably why years have gone by
> > before we noticed this problem: Direct IO is generally very quick, and
> > tends to finish up before the filesystem gets around to do anything with
> > the page contents.  However, it's still a real problem.  The solution is
> > to never let GUP return pages that are under write back, but instead,
> > force GUP to take a write fault on those pages.  That way, GUP will
> > properly synchronize with the active write back.  This does not change the
> > required GUP behavior, it just avoids that race.
> 
> Direct IO on a mmapped file backed page doesnt make any sense.

People have used it for many, many years as zero-copy data movement
pattern. i.e. mmap the destination file, use direct IO to DMA direct
into the destination file page cache pages, fdatasync() to force
writeback of the destination file.

Now we have copy_file_range() to optimise this sort of data
movement, the need for games with mmap+direct IO largely goes away.
However, we still can't just remove that functionality as it will
break lots of random userspace stuff...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
