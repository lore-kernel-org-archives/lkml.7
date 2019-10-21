Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FBDCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145B52053B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfJUNsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:48:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:60766 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728083AbfJUNsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:48:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 22766B730;
        Mon, 21 Oct 2019 13:48:50 +0000 (UTC)
Date:   Mon, 21 Oct 2019 15:48:48 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     n-horiguchi@ah.jp.nec.com, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 11/16] mm,hwpoison: Rework soft offline for in-use
 pages
Message-ID: <20191021134846.GB11330@linux>
References: <20191017142123.24245-1-osalvador@suse.de>
 <20191017142123.24245-12-osalvador@suse.de>
 <20191018123901.GN5017@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018123901.GN5017@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 02:39:01PM +0200, Michal Hocko wrote:
> 
> I am sorry but I got lost in the above description and I cannot really
> make much sense from the code either. Let me try to outline the way how
> I think about this.
> 
> Say we have a pfn to hwpoison. We have effectivelly three possibilities
> - page is poisoned already - done nothing to do
> - page is managed by the buddy allocator - excavate from there
> - page is in use
> 
> The last category is the most interesting one. There are essentially
> three classes of pages
> - freeable
> - migrateable
> - others
> 
> We cannot do really much about the last one, right? Do we mark them
> HWPoison anyway?

We can only perform actions on LRU/Movable pages or hugetlb pages.

So unless the page does not fall into those areas, we do not do anything
with them.

> Freeable should be simply marked HWPoison and freed.
> For all those migrateable, we simply do migrate and mark HWPoison.
> Now the main question is how to handle HWPoison page when it is freed
> - aka last reference is dropped. The main question is whether the last
> reference is ever dropped. If yes then the free_pages_prepare should
> never release it to the allocator (some compound destructors would have
> to special case as well, e.g. hugetlb would have to hand over to the
> allocator rather than a pool). If not then the page would be lingering
> potentially with some state bound to it (e.g. memcg charge).  So I
> suspect you want the former.

For non-hugetlb pages, we do not call put_page in the migration path,
but we do it in page_handle_poison, after the page has been flagged as
hwpoison.
Then the check in free_papes_prepare will see that the page is hwpoison
and will bail out, so the page is not released into the allocator/pcp lists.

Hugetlb pages follow a different methodology.
They are dissolved, and then we split the higher-order page and take the
page off the buddy.
The problem is that while it is easy to hold a non-hugetlb page,
doing the same for hugetlb pages is not that easy:

1) we would need to hook in enqueue_hugetlb_page so the page is not enqueued
   into hugetlb freelists
2) when trying to free a hugetlb page, we would need to do as we do for gigantic
   pages now, and that is breaking down the pages into order-0 pages and release
   them to the buddy (so the check in free_papges_prepare would skip the
   hwpoison page).
   Trying to handle a higher-order hwpoison page in free_pages_prepare is
   a bit complicated.
   
There is one thing I was unsure though.
Bailing out at the beginning of free_pages_prepare if the page is hwpoison
means that the calls to

- __memcg_kmem_uncharge
- page_cpupid_reset_last
- reset_page_owner
- ...

will not be performed.
I thought this is right because the page is not really "free", it is just unusable,
so.. it should be still charged to the memcg?

-- 
Oscar Salvador
SUSE L3
