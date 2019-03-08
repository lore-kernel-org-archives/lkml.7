Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C91AC10F09
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706C020851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfCHR5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:57:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40612 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbfCHR5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 12:57:19 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1EE7E3089E62;
        Fri,  8 Mar 2019 17:57:18 +0000 (UTC)
Received: from redhat.com (ovpn-124-248.rdu2.redhat.com [10.10.124.248])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8BA7F1001DDE;
        Fri,  8 Mar 2019 17:57:15 +0000 (UTC)
Date:   Fri, 8 Mar 2019 12:57:13 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     john.hubbard@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
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
Subject: Re: [PATCH v3 1/1] mm: introduce put_user_page*(), placeholder
 versions
Message-ID: <20190308175712.GD3661@redhat.com>
References: <20190306235455.26348-1-jhubbard@nvidia.com>
 <20190306235455.26348-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190306235455.26348-2-jhubbard@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 08 Mar 2019 17:57:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 03:54:55PM -0800, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> Introduces put_user_page(), which simply calls put_page().
> This provides a way to update all get_user_pages*() callers,
> so that they call put_user_page(), instead of put_page().
> 
> Also introduces put_user_pages(), and a few dirty/locked variations,
> as a replacement for release_pages(), and also as a replacement
> for open-coded loops that release multiple pages.
> These may be used for subsequent performance improvements,
> via batching of pages to be released.
> 
> This is the first step of fixing a problem (also described in [1] and
> [2]) with interactions between get_user_pages ("gup") and filesystems.
> 
> Problem description: let's start with a bug report. Below, is what happens
> sometimes, under memory pressure, when a driver pins some pages via gup,
> and then marks those pages dirty, and releases them. Note that the gup
> documentation actually recommends that pattern. The problem is that the
> filesystem may do a writeback while the pages were gup-pinned, and then the
> filesystem believes that the pages are clean. So, when the driver later
> marks the pages as dirty, that conflicts with the filesystem's page
> tracking and results in a BUG(), like this one that I experienced:
> 
>     kernel BUG at /build/linux-fQ94TU/linux-4.4.0/fs/ext4/inode.c:1899!
>     backtrace:
>         ext4_writepage
>         __writepage
>         write_cache_pages
>         ext4_writepages
>         do_writepages
>         __writeback_single_inode
>         writeback_sb_inodes
>         __writeback_inodes_wb
>         wb_writeback
>         wb_workfn
>         process_one_work
>         worker_thread
>         kthread
>         ret_from_fork
> 
> ...which is due to the file system asserting that there are still buffer
> heads attached:
> 
>         ({                                                      \
>                 BUG_ON(!PagePrivate(page));                     \
>                 ((struct buffer_head *)page_private(page));     \
>         })
> 
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
> 
> The steps are to fix it are:
> 
> 1) (This patch): provide put_user_page*() routines, intended to be used
>    for releasing pages that were pinned via get_user_pages*().
> 
> 2) Convert all of the call sites for get_user_pages*(), to
>    invoke put_user_page*(), instead of put_page(). This involves dozens of
>    call sites, and will take some time.
> 
> 3) After (2) is complete, use get_user_pages*() and put_user_page*() to
>    implement tracking of these pages. This tracking will be separate from
>    the existing struct page refcounting.
> 
> 4) Use the tracking and identification of these pages, to implement
>    special handling (especially in writeback paths) when the pages are
>    backed by a filesystem.
> 
> [1] https://lwn.net/Articles/774411/ : "DMA and get_user_pages()"
> [2] https://lwn.net/Articles/753027/ : "The Trouble with get_user_pages()"
> 
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Christopher Lameter <cl@linux.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Jerome Glisse <jglisse@redhat.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>    # docs
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Just a small comments below that would help my life :)

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

> ---
>  include/linux/mm.h | 24 ++++++++++++++
>  mm/swap.c          | 82 ++++++++++++++++++++++++++++++++++++++++++++++

Why not putting those functions in gup.c instead of swap.c ?

>  2 files changed, 106 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 80bb6408fe73..809b7397d41e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -993,6 +993,30 @@ static inline void put_page(struct page *page)
>  		__put_page(page);
>  }
>  
> +/**
> + * put_user_page() - release a gup-pinned page
> + * @page:            pointer to page to be released
> + *
> + * Pages that were pinned via get_user_pages*() must be released via
> + * either put_user_page(), or one of the put_user_pages*() routines
> + * below. This is so that eventually, pages that are pinned via
> + * get_user_pages*() can be separately tracked and uniquely handled. In
> + * particular, interactions with RDMA and filesystems need special
> + * handling.
> + *
> + * put_user_page() and put_page() are not interchangeable, despite this early
> + * implementation that makes them look the same. put_user_page() calls must
> + * be perfectly matched up with get_user_page() calls.
> + */
> +static inline void put_user_page(struct page *page)
> +{
> +	put_page(page);
> +}
> +
> +void put_user_pages_dirty(struct page **pages, unsigned long npages);
> +void put_user_pages_dirty_lock(struct page **pages, unsigned long npages);
> +void put_user_pages(struct page **pages, unsigned long npages);
> +
>  #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
>  #define SECTION_IN_PAGE_FLAGS
>  #endif
> diff --git a/mm/swap.c b/mm/swap.c
> index 4d7d37eb3c40..a6b4f693f46d 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -133,6 +133,88 @@ void put_pages_list(struct list_head *pages)
>  }
>  EXPORT_SYMBOL(put_pages_list);
>  
> +typedef int (*set_dirty_func)(struct page *page);

set_dirty_func_t would be better as it is the rule for typedef to append
the _t also it make it easier for coccinelle patch.

