Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3492FC3A5A2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 02:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138C4206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 02:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfIDCSo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 22:18:44 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3995 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727065AbfIDCSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 22:18:43 -0400
Received: from dggeml406-hub.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 3341017F6BB060C06155;
        Wed,  4 Sep 2019 10:18:42 +0800 (CST)
Received: from DGGEML422-HUB.china.huawei.com (10.1.199.39) by
 dggeml406-hub.china.huawei.com (10.3.17.50) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 4 Sep 2019 10:18:41 +0800
Received: from DGGEML512-MBX.china.huawei.com ([169.254.2.60]) by
 dggeml422-hub.china.huawei.com ([10.1.199.39]) with mapi id 14.03.0439.000;
 Wed, 4 Sep 2019 10:18:38 +0800
From:   sunqiuyang <sunqiuyang@huawei.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH 1/1] mm/migrate: fix list corruption in migration of
 non-LRU movable pages
Thread-Topic: [PATCH 1/1] mm/migrate: fix list corruption in migration of
 non-LRU movable pages
Thread-Index: AQHVYi7CKRiSaGuZ20KJAhdeZXNZ4qcZaW+AgAFf/lQ=
Date:   Wed, 4 Sep 2019 02:18:38 +0000
Message-ID: <157FC541501A9C4C862B2F16FFE316DC190C1B09@dggeml512-mbx.china.huawei.com>
References: <20190903082746.20736-1-sunqiuyang@huawei.com>,<20190903131737.GB18939@dhcp22.suse.cz>
In-Reply-To: <20190903131737.GB18939@dhcp22.suse.cz>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.249.127]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The isolate path of non-lru movable pages:

isolate_migratepages_block
	isolate_movable_page
		trylock_page
		// if PageIsolated, goto out_no_isolated
		a_ops->isolate_page
		__SetPageIsolated
		unlock_page
	list_add(&page->lru, &cc->migratepages)

The migration path:

unmap_and_move
	__unmap_and_move
		lock_page
		move_to_new_page
			a_ops->migratepage
			__ClearPageIsolated
		unlock_page
	/* here, the page could be isolated again by another thread, and added into another cc->migratepages,
	since PG_Isolated has been cleared, and not protected by page_lock */
	list_del(&page->lru)

Suppose thread A isolates three pages in the order p1, p2, p3, A's cc->migratepages will be like
	head_A - p3 - p2 - p1
After p2 is migrated (but before list_del), it is isolated by another thread B. Then list_del will delete p2
from the cc->migratepages of B (instead of A). When A continues to migrate and delete p1, it will find:
	p1->prev == p2
	p2->next == LIST_POISON1. 

So we will end up with a bug like
"list_del corruption. prev->next should be ffffffbf0a1eb8e0, but was dead000000000100"
(see __list_del_entry_valid).


________________________________________
From: Michal Hocko [mhocko@kernel.org]
Sent: Tuesday, September 03, 2019 21:17
To: sunqiuyang
Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org
Subject: Re: [PATCH 1/1] mm/migrate: fix list corruption in migration of non-LRU movable pages

On Tue 03-09-19 16:27:46, sunqiuyang wrote:
> From: Qiuyang Sun <sunqiuyang@huawei.com>
>
> Currently, after a page is migrated, it
> 1) has its PG_isolated flag cleared in move_to_new_page(), and
> 2) is deleted from its LRU list (cc->migratepages) in unmap_and_move().
> However, between steps 1) and 2), the page could be isolated by another
> thread in isolate_movable_page(), and added to another LRU list, leading
> to list_del corruption later.

Care to explain the race? Both paths use page_lock AFAICS
>
> This patch fixes the bug by moving list_del into the critical section
> protected by lock_page(), so that a page will not be isolated again before
> it has been deleted from its LRU list.
>
> Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
> ---
>  mm/migrate.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index a42858d..c58a606 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1124,6 +1124,8 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>       /* Drop an anon_vma reference if we took one */
>       if (anon_vma)
>               put_anon_vma(anon_vma);
> +     if (rc != -EAGAIN)
> +             list_del(&page->lru);
>       unlock_page(page);
>  out:
>       /*
> @@ -1190,6 +1192,7 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
>                       put_new_page(newpage, private);
>               else
>                       put_page(newpage);
> +             list_del(&page->lru);
>               goto out;
>       }
>
> @@ -1200,14 +1203,6 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
>  out:
>       if (rc != -EAGAIN) {
>               /*
> -              * A page that has been migrated has all references
> -              * removed and will be freed. A page that has not been
> -              * migrated will have kepts its references and be
> -              * restored.
> -              */
> -             list_del(&page->lru);
> -
> -             /*
>                * Compaction can migrate also non-LRU pages which are
>                * not accounted to NR_ISOLATED_*. They can be recognized
>                * as __PageMovable
> --
> 1.8.3.1

--
Michal Hocko
SUSE Labs
