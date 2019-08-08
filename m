Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE74DC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808EF21900
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565250460;
	bh=FihzoGYhR21aMukTiaIw7rbiR561WIiqw6YumzN9iN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dWcchk7WfPoH+WC0FK6sk1/TVe4503E53g/EItV7yY0jhwIPpCtD/rDDpBW1fNoj8
	 unOlXZDXRpQL+FSiXzegcAi8GX5lSvFZQIaktH5u1Z0LDF5dPFK19Hw4khKiAYUvOr
	 hrj6hvM3aIP4IeLjU4PaHnWX+LCLvvwY6299XjPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731561AbfHHHrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 03:47:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:57284 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731502AbfHHHrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 03:47:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 77326B11C;
        Thu,  8 Aug 2019 07:47:36 +0000 (UTC)
Date:   Thu, 8 Aug 2019 09:47:36 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ltp@lists.linux.it, Li Wang <liwang@redhat.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Cyril Hrubis <chrubis@suse.cz>, xishi.qiuxishi@alibaba-inc.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] hugetlbfs: fix hugetlb page migration/fault race causing
 SIGBUS
Message-ID: <20190808074736.GJ11812@dhcp22.suse.cz>
References: <20190808000533.7701-1-mike.kravetz@oracle.com>
 <20190808074607.GI11812@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808074607.GI11812@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 08-08-19 09:46:07, Michal Hocko wrote:
> On Wed 07-08-19 17:05:33, Mike Kravetz wrote:
> > Li Wang discovered that LTP/move_page12 V2 sometimes triggers SIGBUS
> > in the kernel-v5.2.3 testing.  This is caused by a race between hugetlb
> > page migration and page fault.
> > 
> > If a hugetlb page can not be allocated to satisfy a page fault, the task
> > is sent SIGBUS.  This is normal hugetlbfs behavior.  A hugetlb fault
> > mutex exists to prevent two tasks from trying to instantiate the same
> > page.  This protects against the situation where there is only one
> > hugetlb page, and both tasks would try to allocate.  Without the mutex,
> > one would fail and SIGBUS even though the other fault would be successful.
> > 
> > There is a similar race between hugetlb page migration and fault.
> > Migration code will allocate a page for the target of the migration.
> > It will then unmap the original page from all page tables.  It does
> > this unmap by first clearing the pte and then writing a migration
> > entry.  The page table lock is held for the duration of this clear and
> > write operation.  However, the beginnings of the hugetlb page fault
> > code optimistically checks the pte without taking the page table lock.
> > If clear (as it can be during the migration unmap operation), a hugetlb
> > page allocation is attempted to satisfy the fault.  Note that the page
> > which will eventually satisfy this fault was already allocated by the
> > migration code.  However, the allocation within the fault path could
> > fail which would result in the task incorrectly being sent SIGBUS.
> > 
> > Ideally, we could take the hugetlb fault mutex in the migration code
> > when modifying the page tables.  However, locks must be taken in the
> > order of hugetlb fault mutex, page lock, page table lock.  This would
> > require significant rework of the migration code.  Instead, the issue
> > is addressed in the hugetlb fault code.  After failing to allocate a
> > huge page, take the page table lock and check for huge_pte_none before
> > returning an error.  This is the same check that must be made further
> > in the code even if page allocation is successful.
> > 
> > Reported-by: Li Wang <liwang@redhat.com>
> > Fixes: 290408d4a250 ("hugetlb: hugepage migration core")
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > Tested-by: Li Wang <liwang@redhat.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Btw. is this worth marking for stable? I haven't seen it triggering
anywhere but artificial tests. On the other hand the patch is quite
straightforward so it shouldn't hurt in general.
-- 
Michal Hocko
SUSE Labs
