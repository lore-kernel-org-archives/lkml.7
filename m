Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4BDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32DA521904
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbfCVOkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:40:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:53499 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727719AbfCVOkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:40:21 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 07:40:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="154819997"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga004.fm.intel.com with ESMTP; 22 Mar 2019 07:40:19 -0700
Date:   Fri, 22 Mar 2019 08:41:21 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        David Nellans <dnellans@nvidia.com>
Subject: Re: [PATCH 0/5] Page demotion for memory reclaim
Message-ID: <20190322144120.GB29817@localhost.localdomain>
References: <20190321200157.29678-1-keith.busch@intel.com>
 <5B5EFBC2-2979-4B9F-A43A-1A14F16ACCE1@nvidia.com>
 <20190321223706.GA29817@localhost.localdomain>
 <F33CDC43-745B-4555-B8E0-D50D8024C727@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F33CDC43-745B-4555-B8E0-D50D8024C727@nvidia.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 05:12:33PM -0700, Zi Yan wrote:
> > Yes, we may not want to migrate everything in the shrink_page_list()
> > pages. We might want to keep a page, so we have to do those checks first. At
> > the point we know we want to attempt migration, the page is already
> > locked and not in a list, so it is just easier to directly invoke the
> > new __unmap_and_move_locked() that migrate_pages() eventually also calls.
> 
> Right, I understand that you want to only migrate small pages to begin with. My question is
> why not using the existing migrate_pages() in your patch 3. Like:
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index a5ad0b35ab8e..0a0753af357f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1261,6 +1261,20 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>                         ; /* try to reclaim the page below */
>                 }
> 
> +               if (!PageCompound(page)) {
> +                       int next_nid = next_migration_node(page);
> +                       int err;
> +
> +                       if (next_nid != TERMINAL_NODE) {
> +                               LIST_HEAD(migrate_list);
> +                               list_add(&migrate_list, &page->lru);
> +                               err = migrate_pages(&migrate_list, alloc_new_node_page, NULL,
> +                                       next_nid, MIGRATE_ASYNC, MR_DEMOTION);
> +                               if (err)
> +                                       putback_movable_pages(&migrate_list);
> +                       }
> +               }
> +
>                 /*
>                  * Anonymous process memory has backing store?
>                  * Try to allocate it some swap space here.
> 
> Because your new migrate_demote_mapping() basically does the same thing as the code above.
> If you are not OK with the gfp flags in alloc_new_node_page(), you can just write your own
> alloc_new_node_page(). :)

The page is already locked, you can't call migrate_pages()
with locked pages. You'd have to surround migrate_pages with
unlock_page/try_lock_page, and I thought that looked odd. Further,
it changes the flow if the subsequent try lock fails, and I'm trying to
be careful about not introducing different behavior if migration fails.

Patch 2/5 is included here so we can reuse the necessary code from a
locked page context.
