Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53049C49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 19:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F76821019
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 19:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568143390;
	bh=etYMx4uYkaJNWx+5fCuNlCZa+2SODxGgtDViXli0tOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g+8zHpl2PPyIBGHIM9XvjgDdKoIb0B708g3ZUroFJ8lsTAj53LpQspD+dfH/YmTz2
	 Rac8bQu1s9TBYR9CeRGKzb2lVqIJ8TZsBXHWbVAGKmcZVeWKCv50FKq4qU6bU22OHq
	 TvS6dF3AGuPrb54T7e968aybggxjsyF8Z4bfmZgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfIJTXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 15:23:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34912 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbfIJTXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 15:23:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id 205so12125554pfw.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 12:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fubhhbk8mxGQHPIu8VHPq/5qo3lMlhc0PCcFAaxFEGw=;
        b=Gt1VGbq3idOl6Pfrz2txkeuG9O1wiAO53ibNvoeLaHaxro0fJ8rXjlbFedy5/YQNUm
         e4uwdYOTu80BR1VJ1iin45qfQeyExtRvdHZor7SDe6QkMvGtjMDsyfE0yQzFWq84ze5A
         lVC+orwGCh/1CQe24dWiEiGCOmiU0PqQvW1Cft0nrmvA+DYu+sqzqa3HbuU/6bKLNb5D
         mZ8Fg/V3uolNAKmOw3lmSoGNNS/JltnhyxPyuxq8m2D0jnK6ljkx7ewMKSE0UuIZDMrj
         ZORHKfO4D7/PnvRDI1SU0kBdY9gazIsy3pMuV4EvpY80bkGzyrThKyb4AiN5xx8zwarF
         mW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fubhhbk8mxGQHPIu8VHPq/5qo3lMlhc0PCcFAaxFEGw=;
        b=TR+MYlvkc4nOvKOPaiwaSTHQa91RG/sX5/LPoUpzSzl1n5LcoOOBosCFBCQcL8ba9T
         1uMBGgmkHpqCJ7dy+syiXmTbxT4UuDQCJi7++xUiVkDkFe7vZlhTo1IfaKyVu29KZt23
         LfGKCwLH6iUntMRa8wF8Wfbe36fHgL9WHNSoKmTux/JnEIZPRXHpKWW8tTBvALknT9wm
         uGY0nkhH6/F5SCXghGqzJDrYOrna+CW4rLjGX7en68ji6GtJ8eHsRMzN2C5s80wzGjnu
         4z5KDH2cHwQUMxf09yWTRW4DxTGUZgeG0IaqQC6WH3QIvfYoeNmz9Mpf2/gSs1WZXhTN
         lI8A==
X-Gm-Message-State: APjAAAWxCCuMq1L954SfzB8RqvLHv+ypV/qq5fFVo35Th5uKbU7XQr7B
        y4Gf8y4RVZhmwm9Weu93nDA2k2J8
X-Google-Smtp-Source: APXvYqwTr7I/0FMR7eX2wqUS4TniGCurKs704j7dqSnY0tcIsHL6uyUViuXQmxjpXx7GquwkQsyA6g==
X-Received: by 2002:a17:90a:d0c3:: with SMTP id y3mr1214847pjw.102.1568143387926;
        Tue, 10 Sep 2019 12:23:07 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id o9sm14597446pgv.19.2019.09.10.12.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 12:23:06 -0700 (PDT)
Date:   Tue, 10 Sep 2019 12:23:04 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     sunqiuyang <sunqiuyang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] mm/migrate: fix list corruption in migration of
 non-LRU movable pages
Message-ID: <20190910192304.GA220078@google.com>
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

On Tue, Sep 03, 2019 at 04:27:46PM +0800, sunqiuyang wrote:
> From: Qiuyang Sun <sunqiuyang@huawei.com>
> 
> Currently, after a page is migrated, it
> 1) has its PG_isolated flag cleared in move_to_new_page(), and
> 2) is deleted from its LRU list (cc->migratepages) in unmap_and_move().
> However, between steps 1) and 2), the page could be isolated by another
> thread in isolate_movable_page(), and added to another LRU list, leading
> to list_del corruption later.

Once non-LRU page is migrated out successfully, driver should clear
the movable flag in the page. Look at reset_page in zs_page_migrate.
So, other thread couldn't isolate the page during the window.

If I miss something, let me know it.
Thanks.

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
> 
> 
