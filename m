Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0369C46477
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C17214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbfFRQL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:11:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:55994 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729272AbfFRQLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:11:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 88853AEE0;
        Tue, 18 Jun 2019 16:11:54 +0000 (UTC)
Date:   Tue, 18 Jun 2019 18:11:51 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        xishi.qiuxishi@alibaba-inc.com,
        "Chen, Jerry T" <jerry.t.chen@intel.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v3 2/2] mm: hugetlb: soft-offline:
 dissolve_free_huge_page() return zero on !PageHuge
Message-ID: <20190618161151.GB14817@linux>
References: <1560761476-4651-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <1560761476-4651-3-git-send-email-n-horiguchi@ah.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560761476-4651-3-git-send-email-n-horiguchi@ah.jp.nec.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 05:51:16PM +0900, Naoya Horiguchi wrote:
> madvise(MADV_SOFT_OFFLINE) often returns -EBUSY when calling soft offline
> for hugepages with overcommitting enabled. That was caused by the suboptimal
> code in current soft-offline code. See the following part:
> 
>     ret = migrate_pages(&pagelist, new_page, NULL, MPOL_MF_MOVE_ALL,
>                             MIGRATE_SYNC, MR_MEMORY_FAILURE);
>     if (ret) {
>             ...
>     } else {
>             /*
>              * We set PG_hwpoison only when the migration source hugepage
>              * was successfully dissolved, because otherwise hwpoisoned
>              * hugepage remains on free hugepage list, then userspace will
>              * find it as SIGBUS by allocation failure. That's not expected
>              * in soft-offlining.
>              */
>             ret = dissolve_free_huge_page(page);
>             if (!ret) {
>                     if (set_hwpoison_free_buddy_page(page))
>                             num_poisoned_pages_inc();
>             }
>     }
>     return ret;

Hi Naoya,

just a nit:

> 
> Here dissolve_free_huge_page() returns -EBUSY if the migration source page
> was freed into buddy in migrate_pages(), but even in that case we actually
> has a chance that set_hwpoison_free_buddy_page() succeeds. So that means
> current code gives up offlining too early now.

Maybe it is me that I am not really familiar with hugetlb code, but having had
a comment pointing out that the releasing of overcommited hugetlb pages into the
buddy allocator happens in migrate_pages()->put_page()->free_huge_page() would
have been great.

> 
> dissolve_free_huge_page() checks that a given hugepage is suitable for
> dissolving, where we should return success for !PageHuge() case because
> the given hugepage is considered as already dissolved.
> 
> This change also affects other callers of dissolve_free_huge_page(),
> which are cleaned up together.
> 
> Reported-by: Chen, Jerry T <jerry.t.chen@intel.com>
> Tested-by: Chen, Jerry T <jerry.t.chen@intel.com>
> Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Fixes: 6bc9b56433b76 ("mm: fix race on soft-offlining")
> Cc: <stable@vger.kernel.org> # v4.19+

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
