Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1909EECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 18:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38B521925
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 18:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="NgfrjT6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395282AbfJQSHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 14:07:17 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42428 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388188AbfJQSHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 14:07:17 -0400
Received: by mail-qt1-f194.google.com with SMTP id w14so4893430qto.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 11:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O8aPNDBxCNGS4hw55BtMCSSOHVJRAaIQa9yD2iMaQKo=;
        b=NgfrjT6GBJThLJamv9Jn9DbzBJb/SDaoMWbX51RMkb5cxPW613VN1NNlJR+kJyUCyP
         KCgtFs6BAl+2Mz8t/PmLg7eraChYFFBw4qDsHwL24KzKgSLGKxm6VjWSQLym15laEc6x
         O8WD2OPPsJAdgJH2j885dSFJFkSxRZ0ZuOegnW+TrLMmjnSzuHmEzibW9FpJrJn9+TTm
         y+2p/QaV7bmMQ4X1KtSLKnZ6+xupJgiW1+W0RAjtvNoTr83VAKHu9KgJHq1BOLGk02CI
         zvYF2ShJ46lHeYtrA49Ouuz1o6JkTX27dkaMW/ei9PgnFpto/SgFdJ5RPvLhpPCM8hBz
         pd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O8aPNDBxCNGS4hw55BtMCSSOHVJRAaIQa9yD2iMaQKo=;
        b=TvbI/8DHSOL7h1dUwnX4jD6w8giDRX2h+ixs+NjFropYOL8wGUftu9+utONz4HCNz4
         IZRzSu79fZ1xma8CFunwA9ipy+Aca+/jU0kQDPmerqM3xwwbbJeMEh0z0FDuluFjZT4p
         BU4XdHUDUvEnGgJuRqxuqN3/6J8DncFesNkVunVt5pLmIE7PuXwqFd+TE8jwCT13uxb6
         oKXdJN39EE+WqKl+flE3BIEdWevaDyoNcBOTup+7tJhnjSUB++aVkbsFc7EQYZ7F2K4d
         Mlp1HaYjYEYpv/jbaNzHItdWhKDVPkE/kXaGs6yeLSE0Gv3k8oWnxBgzkR6iP93zcVDu
         /CVA==
X-Gm-Message-State: APjAAAUObB/37xRRwL6nsQzWrCYQlI+/UKZ+1MBWnaw5GeynjwK/UuoM
        2O2/nqNO1DK3kfMIjocACYWJMnpm+8Y=
X-Google-Smtp-Source: APXvYqy98Behq50Rx7i37NYt4U5mS/Bg7hgCs0GGPo47m3ccYSpSNKz15PxrzZe5ztPmy+H9lwTk5A==
X-Received: by 2002:ac8:529a:: with SMTP id s26mr5134896qtn.238.1571335635529;
        Thu, 17 Oct 2019 11:07:15 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id b1sm1237767qtr.17.2019.10.17.11.07.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 11:07:14 -0700 (PDT)
Message-ID: <1571335633.5937.69.camel@lca.pw>
Subject: Re: memory offline infinite loop after soft offline
From:   Qian Cai <cai@lca.pw>
To:     Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Date:   Thu, 17 Oct 2019 14:07:13 -0400
In-Reply-To: <20191017100106.GF24485@dhcp22.suse.cz>
References: <1570829564.5937.36.camel@lca.pw>
         <20191014083914.GA317@dhcp22.suse.cz>
         <20191017093410.GA19973@hori.linux.bs1.fc.nec.co.jp>
         <20191017100106.GF24485@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-10-17 at 12:01 +0200, Michal Hocko wrote:
> On Thu 17-10-19 09:34:10, Naoya Horiguchi wrote:
> > On Mon, Oct 14, 2019 at 10:39:14AM +0200, Michal Hocko wrote:
> 
> [...]
> > > diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> > > index 89c19c0feadb..5fb3fee16fde 100644
> > > --- a/mm/page_isolation.c
> > > +++ b/mm/page_isolation.c
> > > @@ -274,7 +274,7 @@ __test_page_isolated_in_pageblock(unsigned long pfn, unsigned long end_pfn,
> > >  			 * simple way to verify that as VM_BUG_ON(), though.
> > >  			 */
> > >  			pfn += 1 << page_order(page);
> > > -		else if (skip_hwpoisoned_pages && PageHWPoison(page))
> > > +		else if (skip_hwpoisoned_pages && PageHWPoison(compound_head(page)))
> > >  			/* A HWPoisoned page cannot be also PageBuddy */
> > >  			pfn++;
> > >  		else
> > 
> > This fix looks good to me. The original code only addresses hwpoisoned 4kB-page,
> > we seem to have this issue since the following commit,
> 
> Thanks a lot for double checking Naoya!
>  
> >   commit b023f46813cde6e3b8a8c24f432ff9c1fd8e9a64
> >   Author: Wen Congyang <wency@cn.fujitsu.com>
> >   Date:   Tue Dec 11 16:00:45 2012 -0800
> >   
> >       memory-hotplug: skip HWPoisoned page when offlining pages
> > 
> > and extension of LTP coverage finally discovered this.
> 
> Qian, could you give the patch some testing?

Unfortunately, this does not solve the problem. It looks to me that in
soft_offline_huge_page(), set_hwpoison_free_buddy_page() will only set
PG_hwpoison for buddy pages, so the even the compound_head() has no PG_hwpoison
set.

		if (PageBuddy(page_head) && page_order(page_head) >= order) {
			if (!TestSetPageHWPoison(page))
				hwpoisoned = true;

The below is the dump_page() of the compound_head().

[  113.796632][ T8907] page:c00c000800458040 refcount:0 mapcount:0
mapping:0000000000000000 index:0x0
[  113.796716][ T8907] flags: 0x83fffc000000000()
[  113.796764][ T8907] raw: 083fffc000000000 0000000000000000 ffffffff00450500
0000000000000000
[  113.796870][ T8907] raw: 0000000000000000 0000000000000000 00000000ffffffff
0000000000000000
[  113.796959][ T8907] page dumped because: soft offline compound_head()
[  113.797037][ T8907] page_owner tracks the page as freed
[  113.797086][ T8907] page last allocated via order 5, migratetype Movable,
gfp_mask
0x346cca(GFP_HIGHUSER_MOVABLE|__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_COMP|__GFP_
THISNODE)
[  113.797262][ T8907]  prep_new_page+0x3c0/0x440
[  113.797316][ T8907]  get_page_from_freelist+0x2568/0x2bb0
[  113.797395][ T8907]  __alloc_pages_nodemask+0x1b4/0x670
[  113.797443][ T8907]  alloc_fresh_huge_page+0xb8/0x300
[  113.797493][ T8907]  alloc_migrate_huge_page+0x30/0x70
[  113.797550][ T8907]  alloc_new_node_page+0xc4/0x380
[  113.797609][ T8907]  migrate_pages+0x3b4/0x19e0
[  113.797649][ T8907]  do_move_pages_to_node.isra.29.part.30+0x44/0xa0
[  113.797713][ T8907]  kernel_move_pages+0x498/0xfc0
[  113.797784][ T8907]  sys_move_pages+0x28/0x40
[  113.797843][ T8907]  system_call+0x5c/0x68
[  113.797895][ T8907] page last free stack trace:
[  113.797947][ T8907]  __free_pages_ok+0xa4c/0xd40
[  113.797991][ T8907]  update_and_free_page+0x2dc/0x5b0
[  113.798059][ T8907]  free_huge_page+0x2dc/0x740
[  113.798103][ T8907]  __put_compound_page+0x64/0xc0
[  113.798171][ T8907]  putback_active_hugepage+0x228/0x390
[  113.798219][ T8907]  migrate_pages+0xa78/0x19e0
[  113.798273][ T8907]  soft_offline_page+0x314/0x1050
[  113.798319][ T8907]  sys_madvise+0x1068/0x1080
[  113.798381][ T8907]  system_call+0x5c/0x68

> ---
> 
> From 441a9515dcdb29bb0ca39ff995632907d959032f Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Thu, 17 Oct 2019 11:49:15 +0200
> Subject: [PATCH] hugetlb, memory_hotplug: fix HWPoisoned tail pages properly
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Qian Cai has noticed that hwpoisoned hugetlb pages prevent memory
> offlining from making a forward progress. He has nailed down the issue
> to be __test_page_isolated_in_pageblock always returning EBUSY because
> of soft offlined page:
> [  101.665160][ T8885] pfn = 77501, end_pfn = 78000
> [  101.665245][ T8885] page:c00c000001dd4040 refcount:0 mapcount:0
> mapping:0000000000000000 index:0x0
> [  101.665329][ T8885] flags: 0x3fffc000000000()
> [  101.665391][ T8885] raw: 003fffc000000000 0000000000000000 ffffffff01dd0500
> 0000000000000000
> [  101.665498][ T8885] raw: 0000000000000000 0000000000000000 00000000ffffffff
> 0000000000000000
> [  101.665588][ T8885] page dumped because: soft_offline
> [  101.665639][ T8885] page_owner tracks the page as freed
> [  101.665697][ T8885] page last allocated via order 5, migratetype Movable,
> gfp_mask
> 0x346cca(GFP_HIGHUSER_MOVABLE|__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_COMP|__GFP_
> THISNODE)
> [  101.665924][ T8885]  prep_new_page+0x3c0/0x440
> [  101.665962][ T8885]  get_page_from_freelist+0x2568/0x2bb0
> [  101.666059][ T8885]  __alloc_pages_nodemask+0x1b4/0x670
> [  101.666115][ T8885]  alloc_fresh_huge_page+0x244/0x6e0
> [  101.666183][ T8885]  alloc_migrate_huge_page+0x30/0x70
> [  101.666254][ T8885]  alloc_new_node_page+0xc4/0x380
> [  101.666325][ T8885]  migrate_pages+0x3b4/0x19e0
> [  101.666375][ T8885]  do_move_pages_to_node.isra.29.part.30+0x44/0xa0
> [  101.666464][ T8885]  kernel_move_pages+0x498/0xfc0
> [  101.666520][ T8885]  sys_move_pages+0x28/0x40
> [  101.666643][ T8885]  system_call+0x5c/0x68
> [  101.666665][ T8885] page last free stack trace:
> [  101.666704][ T8885]  __free_pages_ok+0xa4c/0xd40
> [  101.666773][ T8885]  update_and_free_page+0x2dc/0x5b0
> [  101.666821][ T8885]  free_huge_page+0x2dc/0x740
> [  101.666875][ T8885]  __put_compound_page+0x64/0xc0
> [  101.666926][ T8885]  putback_active_hugepage+0x228/0x390
> [  101.666990][ T8885]  migrate_pages+0xa78/0x19e0
> [  101.667048][ T8885]  soft_offline_page+0x314/0x1050
> [  101.667117][ T8885]  sys_madvise+0x1068/0x1080
> [  101.667185][ T8885]  system_call+0x5c/0x68
> 
> The reason is that __test_page_isolated_in_pageblock doesn't recognize
> hugetlb tail pages as the HWPoison bit is not transferred from the head
> page. Pfn walker then doesn't recognize those pages and so EBUSY is
> returned up the call chain.
> 
> The proper fix would be to handle HWPoison throughout the huge page but
> considering there is a WIP to rework that code considerably let's go
> with a simple and easily backportable workaround and simply check the
> the head of a compound page for the HWPoison flag.
> 
> Reported-and-analyzed-by: Qian Cai <cai@lca.pw>
> Fixes: b023f46813cd ("memory-hotplug: skip HWPoisoned page when offlining pages")
> Cc: stable
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/page_isolation.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 89c19c0feadb..5fb3fee16fde 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -274,7 +274,7 @@ __test_page_isolated_in_pageblock(unsigned long pfn, unsigned long end_pfn,
>  			 * simple way to verify that as VM_BUG_ON(), though.
>  			 */
>  			pfn += 1 << page_order(page);
> -		else if (skip_hwpoisoned_pages && PageHWPoison(page))
> +		else if (skip_hwpoisoned_pages && PageHWPoison(compound_head(page)))
>  			/* A HWPoisoned page cannot be also PageBuddy */
>  			pfn++;
>  		else
> -- 
> 2.20.1
> 
