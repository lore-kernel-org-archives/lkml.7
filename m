Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BF8CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834682173B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571666783;
	bh=ZkDcXofog1r1Cef9gtTnMlS/6SRpClDqtr0bbsWi7Tc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mkqBAU6RmUfIY8oxJP072tmbheswsqKUSUAMhV3neoEkyAfPA66cWjtkK6aGu0d6U
	 GsgClAYcJXQUvN0Q9SMOQXMnyIUftsR1y+Oqm7RlKpYwoGErl+2ZixqfCeCiVinpfK
	 1eIczRoABBTLODqrrgXYUegA4jwynpKi7GMUXG40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbfJUOGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:06:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:41846 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728098AbfJUOGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:06:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 53209BD9D;
        Mon, 21 Oct 2019 14:06:20 +0000 (UTC)
Date:   Mon, 21 Oct 2019 16:06:19 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     n-horiguchi@ah.jp.nec.com, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 11/16] mm,hwpoison: Rework soft offline for in-use
 pages
Message-ID: <20191021140619.GQ9379@dhcp22.suse.cz>
References: <20191017142123.24245-1-osalvador@suse.de>
 <20191017142123.24245-12-osalvador@suse.de>
 <20191018123901.GN5017@dhcp22.suse.cz>
 <20191021134846.GB11330@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021134846.GB11330@linux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21-10-19 15:48:48, Oscar Salvador wrote:
> On Fri, Oct 18, 2019 at 02:39:01PM +0200, Michal Hocko wrote:
> > 
> > I am sorry but I got lost in the above description and I cannot really
> > make much sense from the code either. Let me try to outline the way how
> > I think about this.
> > 
> > Say we have a pfn to hwpoison. We have effectivelly three possibilities
> > - page is poisoned already - done nothing to do
> > - page is managed by the buddy allocator - excavate from there
> > - page is in use
> > 
> > The last category is the most interesting one. There are essentially
> > three classes of pages
> > - freeable
> > - migrateable
> > - others
> > 
> > We cannot do really much about the last one, right? Do we mark them
> > HWPoison anyway?
> 
> We can only perform actions on LRU/Movable pages or hugetlb pages.

What would prevent other pages mapped via page tables to be handled as
well?

> So unless the page does not fall into those areas, we do not do anything
> with them.
> 
> > Freeable should be simply marked HWPoison and freed.
> > For all those migrateable, we simply do migrate and mark HWPoison.
> > Now the main question is how to handle HWPoison page when it is freed
> > - aka last reference is dropped. The main question is whether the last
> > reference is ever dropped. If yes then the free_pages_prepare should
> > never release it to the allocator (some compound destructors would have
> > to special case as well, e.g. hugetlb would have to hand over to the
> > allocator rather than a pool). If not then the page would be lingering
> > potentially with some state bound to it (e.g. memcg charge).  So I
> > suspect you want the former.
> 
> For non-hugetlb pages, we do not call put_page in the migration path,
> but we do it in page_handle_poison, after the page has been flagged as
> hwpoison.
> Then the check in free_papes_prepare will see that the page is hwpoison
> and will bail out, so the page is not released into the allocator/pcp lists.
> 
> Hugetlb pages follow a different methodology.
> They are dissolved, and then we split the higher-order page and take the
> page off the buddy.
> The problem is that while it is easy to hold a non-hugetlb page,
> doing the same for hugetlb pages is not that easy:
> 
> 1) we would need to hook in enqueue_hugetlb_page so the page is not enqueued
>    into hugetlb freelists
> 2) when trying to free a hugetlb page, we would need to do as we do for gigantic
>    pages now, and that is breaking down the pages into order-0 pages and release
>    them to the buddy (so the check in free_papges_prepare would skip the
>    hwpoison page).
>    Trying to handle a higher-order hwpoison page in free_pages_prepare is
>    a bit complicated.

I am not sure I see the problem. If you dissolve the hugetlb page then
there is no hugetlb page anymore and so you make it a regular high-order
page.

> There is one thing I was unsure though.
> Bailing out at the beginning of free_pages_prepare if the page is hwpoison
> means that the calls to
> 
> - __memcg_kmem_uncharge
> - page_cpupid_reset_last
> - reset_page_owner
> - ...
> 
> will not be performed.
> I thought this is right because the page is not really "free", it is just unusable,
> so.. it should be still charged to the memcg?

If the page is free then it shouldn't pin the memcg or any other state.
-- 
Michal Hocko
SUSE Labs
