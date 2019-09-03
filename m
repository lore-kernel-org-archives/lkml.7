Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C4FC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E50B2053B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567516660;
	bh=HELYILf7PmfHAJufYgPIbUuJ8NFb39wAtAfyP6VVXd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BnwW8os1OgqsLKvYtu1dNm12k99/a0BEoV0pxZRkihKP3o5d93ZXtNTlnhCdbxPdF
	 cuAJ8jK5o4zWbPPRvOHYd13SzIfs7CFjlyMuDpyNUU8zsGIYbVvPG/k5IwKkF2C18W
	 doqKr1/mhtzUpKlpKoNFiQtve3h1jx1PGzGSPbCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbfICNRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 09:17:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:58200 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727005AbfICNRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:17:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 252E0B116;
        Tue,  3 Sep 2019 13:17:38 +0000 (UTC)
Date:   Tue, 3 Sep 2019 15:17:37 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     sunqiuyang <sunqiuyang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] mm/migrate: fix list corruption in migration of
 non-LRU movable pages
Message-ID: <20190903131737.GB18939@dhcp22.suse.cz>
References: <20190903082746.20736-1-sunqiuyang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903082746.20736-1-sunqiuyang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
>  	/* Drop an anon_vma reference if we took one */
>  	if (anon_vma)
>  		put_anon_vma(anon_vma);
> +	if (rc != -EAGAIN)
> +		list_del(&page->lru);
>  	unlock_page(page);
>  out:
>  	/*
> @@ -1190,6 +1192,7 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
>  			put_new_page(newpage, private);
>  		else
>  			put_page(newpage);
> +		list_del(&page->lru);
>  		goto out;
>  	}
>  
> @@ -1200,14 +1203,6 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
>  out:
>  	if (rc != -EAGAIN) {
>  		/*
> -		 * A page that has been migrated has all references
> -		 * removed and will be freed. A page that has not been
> -		 * migrated will have kepts its references and be
> -		 * restored.
> -		 */
> -		list_del(&page->lru);
> -
> -		/*
>  		 * Compaction can migrate also non-LRU pages which are
>  		 * not accounted to NR_ISOLATED_*. They can be recognized
>  		 * as __PageMovable
> -- 
> 1.8.3.1

-- 
Michal Hocko
SUSE Labs
