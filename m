Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D169CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 07:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7FF21928
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 07:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387957AbfJVH4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 03:56:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:47872 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726978AbfJVH4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 03:56:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 23D46B27C;
        Tue, 22 Oct 2019 07:56:29 +0000 (UTC)
Date:   Tue, 22 Oct 2019 09:56:27 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     n-horiguchi@ah.jp.nec.com, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 11/16] mm,hwpoison: Rework soft offline for in-use
 pages
Message-ID: <20191022075626.GB19060@linux>
References: <20191017142123.24245-1-osalvador@suse.de>
 <20191017142123.24245-12-osalvador@suse.de>
 <20191018123901.GN5017@dhcp22.suse.cz>
 <20191021134846.GB11330@linux>
 <20191021140619.GQ9379@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021140619.GQ9379@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 04:06:19PM +0200, Michal Hocko wrote:
> On Mon 21-10-19 15:48:48, Oscar Salvador wrote:
> > We can only perform actions on LRU/Movable pages or hugetlb pages.
> 
> What would prevent other pages mapped via page tables to be handled as
> well?

What kind of pages?
I mean, I guess it could be done, it was just not implemented, and I
did not want to add more "features" as my main goal was to re-work
the interface to be more deterministic.

> > 1) we would need to hook in enqueue_hugetlb_page so the page is not enqueued
> >    into hugetlb freelists
> > 2) when trying to free a hugetlb page, we would need to do as we do for gigantic
> >    pages now, and that is breaking down the pages into order-0 pages and release
> >    them to the buddy (so the check in free_papges_prepare would skip the
> >    hwpoison page).
> >    Trying to handle a higher-order hwpoison page in free_pages_prepare is
> >    a bit complicated.
> 
> I am not sure I see the problem. If you dissolve the hugetlb page then
> there is no hugetlb page anymore and so you make it a regular high-order
> page.

Yes, but the problem comes when trying to work with a hwpoison high-order page
in free_pages_prepare, it gets more complicated, and when I weigthed
code vs benefits, I was not really sure to go down that road.

If we get a hwpoison high-order page in free_pages_prepare, we need to
break it down to smaller pages, so we can skip the "bad" to not be sent
into buddy allocator.

> If the page is free then it shouldn't pin the memcg or any other state.

Well, it is not really free, as it is not usable, is it?
Anyway, I do agree that we should clean the bondings to other subsystems like memcg.

-- 
Oscar Salvador
SUSE L3
