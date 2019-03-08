Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5DAC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940B9206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfCHTHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 14:07:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36626 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfCHTHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 14:07:09 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B543581F19;
        Fri,  8 Mar 2019 19:07:08 +0000 (UTC)
Received: from redhat.com (ovpn-124-248.rdu2.redhat.com [10.10.124.248])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CF165C1A1;
        Fri,  8 Mar 2019 19:07:06 +0000 (UTC)
Date:   Fri, 8 Mar 2019 14:07:04 -0500
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
Message-ID: <20190308190704.GC5618@redhat.com>
References: <20190306235455.26348-1-jhubbard@nvidia.com>
 <010001695b4631cd-f4b8fcbf-a760-4267-afce-fb7969e3ff87-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <010001695b4631cd-f4b8fcbf-a760-4267-afce-fb7969e3ff87-000000@email.amazonses.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 08 Mar 2019 19:07:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 03:08:40AM +0000, Christopher Lameter wrote:
> On Wed, 6 Mar 2019, john.hubbard@gmail.com wrote:
> 
> 
> > GUP was first introduced for Direct IO (O_DIRECT), allowing filesystem code
> > to get the struct page behind a virtual address and to let storage hardware
> > perform a direct copy to or from that page. This is a short-lived access
> > pattern, and as such, the window for a concurrent writeback of GUP'd page
> > was small enough that there were not (we think) any reported problems.
> > Also, userspace was expected to understand and accept that Direct IO was
> > not synchronized with memory-mapped access to that data, nor with any
> > process address space changes such as munmap(), mremap(), etc.
> 
> It would good if that understanding would be enforced somehow given the problems
> that we see.

This has been discuss extensively already. GUP usage is now widespread in
multiple drivers, removing that would regress userspace ie break existing
application. We all know what the rules for that is.

> 
> > Interactions with file systems
> > ==============================
> >
> > File systems expect to be able to write back data, both to reclaim pages,
> 
> Regular filesystems do that. But usually those are not used with GUP
> pinning AFAICT.
> 
> > and for data integrity. Allowing other hardware (NICs, GPUs, etc) to gain
> > write access to the file memory pages means that such hardware can dirty
> > the pages, without the filesystem being aware. This can, in some cases
> > (depending on filesystem, filesystem options, block device, block device
> > options, and other variables), lead to data corruption, and also to kernel
> > bugs of the form:
> 
> > Long term GUP
> > =============
> >
> > Long term GUP is an issue when FOLL_WRITE is specified to GUP (so, a
> > writeable mapping is created), and the pages are file-backed. That can lead
> > to filesystem corruption. What happens is that when a file-backed page is
> > being written back, it is first mapped read-only in all of the CPU page
> > tables; the file system then assumes that nobody can write to the page, and
> > that the page content is therefore stable. Unfortunately, the GUP callers
> > generally do not monitor changes to the CPU pages tables; they instead
> > assume that the following pattern is safe (it's not):
> >
> >     get_user_pages()
> >
> >     Hardware can keep a reference to those pages for a very long time,
> >     and write to it at any time. Because "hardware" here means "devices
> >     that are not a CPU", this activity occurs without any interaction
> >     with the kernel's file system code.
> >
> >     for each page
> >         set_page_dirty
> >         put_page()
> >
> > In fact, the GUP documentation even recommends that pattern.
> 
> Isnt that pattern safe for anonymous memory and memory filesystems like
> hugetlbfs etc? Which is the common use case.

Still an issue in respect to swapout ie if anon/shmem page was map
read only in preparation for swapout and we do not report the page
as dirty what endup in swap might lack what was written last through
GUP.

> 
> > Anyway, the file system assumes that the page is stable (nothing is writing
> > to the page), and that is a problem: stable page content is necessary for
> > many filesystem actions during writeback, such as checksum, encryption,
> > RAID striping, etc. Furthermore, filesystem features like COW (copy on
> > write) or snapshot also rely on being able to use a new page for as memory
> > for that memory range inside the file.
> >
> > Corruption during write back is clearly possible here. To solve that, one
> > idea is to identify pages that have active GUP, so that we can use a bounce
> > page to write stable data to the filesystem. The filesystem would work
> > on the bounce page, while any of the active GUP might write to the
> > original page. This would avoid the stable page violation problem, but note
> > that it is only part of the overall solution, because other problems
> > remain.
> 
> Yes you now have the filesystem as well as the GUP pinner claiming
> authority over the contents of a single memory segment. Maybe better not
> allow that?

This goes back to regressing existing driver with existing users.

> 
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
> Direct IO on a mmapped file backed page doesnt make any sense. The direct
> I/O write syscall already specifies one file handle of a filesystem that
> the data is to be written onto.  Plus mmap already established another
> second filehandle and another filesystem that is also in charge of that
> memory segment.
> 
> Two filesystem trying to sync one memory segment both believing to have
> exclusive access and we want to sort this out. Why? Dont allow this.

This is allowed, it always was, forbidding that case now would regress
existing application and it would also means that we are modifying the
API we expose to userspace. So again this is not something we can block
without regressing existing user.

Cheers,
Jérôme
