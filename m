Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384C8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034992184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552552885;
	bh=NqA1RbDbfRXimLmurlTZQEXG5owfOw0qj8HdF69FceI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1MmcS37dmGo4Z+NgfFaEB9pIBd28PWw63IDBwjKuMcHW1rtYy2p5jCu6P7aEeHVPL
	 IlaB8GQzITwd2A6xGj5L1b0YgtEJTR84Y+MlKp0Bd/bLC2evnpYqf19kfD1Evl3g/a
	 0YIQeoI7eSDpkr1NMFbYVbbacOS/CG72seTkHWGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfCNIlX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 04:41:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:51010 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726539AbfCNIlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 04:41:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5A7B9AD25;
        Thu, 14 Mar 2019 08:41:21 +0000 (UTC)
Date:   Thu, 14 Mar 2019 09:41:20 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Pankaj Suryawanshi <pankaj.suryawanshi@einfochips.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "minchan@kernel.org" <minchan@kernel.org>
Subject: Re: vmscan: Reclaim unevictable pages
Message-ID: <20190314084120.GF7473@dhcp22.suse.cz>
References: <SG2PR02MB3098A05E09B0D3F3CB1C3B9BE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <SG2PR02MB309806967AE91179CAFEC34BE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <SG2PR02MB3098B751EC6B8E32806A42FBE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <SG2PR02MB3098B751EC6B8E32806A42FBE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 14-03-19 08:23:10, Pankaj Suryawanshi wrote:
> 
> Below is the Error Msg :
> 
> [   24.718792] page dumped because: VM_BUG_ON_PAGE(PageLRU(page) || PageUnevictable(page))
> [   24.726949] page->mem_cgroup:bd008c00
> [   24.730693] ------------[ cut here ]------------
> [   24.735304] kernel BUG at mm/vmscan.c:1350!
> [   24.739478] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM

Just curious. Which kernel version is that? Are there any addional
patches applied on top of vanilla?
 
> Solved the issue by below patch.
> 
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index be56e2e..2e51edc 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -990,15 +990,17 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>                 page = lru_to_page(page_list);
>                 list_del(&page->lru);
> 
>                if (!trylock_page(page)) {
>                         goto keep;
>                }
> 
>                 VM_BUG_ON_PAGE(PageActive(page), page);
> 
>                 sc->nr_scanned++;
> 
>                 if (unlikely(!page_evictable(page)))
> -                       goto activate_locked;
> +                      goto cull_mlocked;
> 
>                 if (!sc->may_unmap && page_mapped(page))
>                         goto keep_locked;
> @@ -1331,6 +1333,12 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>                 } else
>                         list_add(&page->lru, &free_pages);
>                 continue;
> +cull_mlocked:
> +                if (PageSwapCache(page))
> +                        try_to_free_swap(page);
> +                unlock_page(page);
> +                list_add(&page->lru, &ret_pages);
> +                continue;
> 
>  activate_locked:
>                 /* Not a candidate for swapping, so reclaim swap space. */
> 
> 
> 
> 
> From: Pankaj Suryawanshi
> Sent: 14 March 2019 13:23:53
> To: linux-kernel@vger.kernel.org
> Cc: minchan@kernel.org
> Subject: vmscan: Reclaim unevictable pages
> 
> 
> 
> Hello ,
> 
> shrink_page_list() returns , number of pages reclaimed, when pages is unevictable it returns VM_BUG_ON_PAGE(PageLRU(page) || PageUnevicatble(page),page);
> 
> We can add the unevictable pages in reclaim list in shrink_page_list(), return total number of reclaim pages including unevictable pages, let the caller handle unevictable pages.
> 
> Regards,
> Pankaj
> 
> ************************************************************************************************************************************************************* eInfochips Business Disclaimer: This e-mail message and all attachments transmitted with it are intended solely for the use of the addressee and may contain legally privileged and confidential information. If the reader of this message is not the intended recipient, or an employee or agent responsible for delivering this message to the intended recipient, you are hereby notified that any dissemination, distribution, copying, or other use of this message or its attachments is strictly prohibited. If you have received this message in error, please notify the sender immediately by replying to this message and please delete it from your computer. Any views expressed in this message are those of the individual sender unless otherwise stated. Company has taken enough precautions to prevent the spread of viruses. However the company 
 accepts no liability for any damage caused by any virus transmitted by this email. *************************************************************************************************************************************************************

-- 
Michal Hocko
SUSE Labs
