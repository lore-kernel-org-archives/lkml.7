Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB42EC43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 13:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3E4205C9
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 13:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556974903;
	bh=zg85sJgoGAHHS6dhij/VLeLwecU/ePlcyuHI74dmilY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bdCpI6oGDbnEu+I7UtVmEPO/5R9zs2kxeBvLriL0AwvRk60+VmcP3tfHeI2VMudzB
	 mjYQFNdUqQ9JVJ20TSHfElfu3H8R5KZTPmBrrr/4pKzEQ/gAe7tNM3RSzGnO5NGedx
	 NQIp6vOBja78b3GGfmdZVjfFDlmvB5J7l0crouJ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfEDNBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 09:01:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:37654 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726215AbfEDNBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 09:01:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DEE15ABF0;
        Sat,  4 May 2019 13:01:40 +0000 (UTC)
Date:   Sat, 4 May 2019 09:01:37 -0400
From:   Michal Hocko <mhocko@kernel.org>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     mike.kravetz@oracle.com, shenkai8@huawei.com,
        linfeilong@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, wangwang2@huawei.com,
        "Zhoukang (A)" <zhoukang7@huawei.com>,
        Mingfangsen <mingfangsen@huawei.com>, agl@us.ibm.com,
        nacc@us.ibm.com
Subject: Re: [PATCH] mm/hugetlb: Don't put_page in lock of hugetlb_lock
Message-ID: <20190504130137.GS29835@dhcp22.suse.cz>
References: <12a693da-19c8-dd2c-ea6a-0a5dc9d2db27@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12a693da-19c8-dd2c-ea6a-0a5dc9d2db27@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 04-05-19 20:28:24, Zhiqiang Liu wrote:
> From: Kai Shen <shenkai8@huawei.com>
> 
> spinlock recursion happened when do LTP test:
> #!/bin/bash
> ./runltp -p -f hugetlb &
> ./runltp -p -f hugetlb &
> ./runltp -p -f hugetlb &
> ./runltp -p -f hugetlb &
> ./runltp -p -f hugetlb &
> 
> The dtor returned by get_compound_page_dtor in __put_compound_page
> may be the function of free_huge_page which will lock the hugetlb_lock,
> so don't put_page in lock of hugetlb_lock.
> 
>  BUG: spinlock recursion on CPU#0, hugemmap05/1079
>   lock: hugetlb_lock+0x0/0x18, .magic: dead4ead, .owner: hugemmap05/1079, .owner_cpu: 0
>  Call trace:
>   dump_backtrace+0x0/0x198
>   show_stack+0x24/0x30
>   dump_stack+0xa4/0xcc
>   spin_dump+0x84/0xa8
>   do_raw_spin_lock+0xd0/0x108
>   _raw_spin_lock+0x20/0x30
>   free_huge_page+0x9c/0x260
>   __put_compound_page+0x44/0x50
>   __put_page+0x2c/0x60
>   alloc_surplus_huge_page.constprop.19+0xf0/0x140
>   hugetlb_acct_memory+0x104/0x378
>   hugetlb_reserve_pages+0xe0/0x250
>   hugetlbfs_file_mmap+0xc0/0x140
>   mmap_region+0x3e8/0x5b0
>   do_mmap+0x280/0x460
>   vm_mmap_pgoff+0xf4/0x128
>   ksys_mmap_pgoff+0xb4/0x258
>   __arm64_sys_mmap+0x34/0x48
>   el0_svc_common+0x78/0x130
>   el0_svc_handler+0x38/0x78
>   el0_svc+0x8/0xc
> 
> Fixes: 9980d744a0 ("mm, hugetlb: get rid of surplus page accounting tricks")
> Signed-off-by: Kai Shen <shenkai8@huawei.com>
> Signed-off-by: Feilong Lin <linfeilong@huawei.com>
> Reported-by: Wang Wang <wangwang2@huawei.com>

You are right. I must have completely missed that put_page path
unconditionally takes the hugetlb_lock for hugetlb pages.

Thanks for fixing this. I think this should be marked for stable
because it is not hard to imagine a regular user might trigger this.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/hugetlb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6cdc7b2..c1e7b81 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1574,8 +1574,9 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
>  	 */
>  	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages) {
>  		SetPageHugeTemporary(page);
> +		spin_unlock(&hugetlb_lock);
>  		put_page(page);
> -		page = NULL;
> +		return NULL;
>  	} else {
>  		h->surplus_huge_pages++;
>  		h->surplus_huge_pages_node[page_to_nid(page)]++;
> -- 
> 1.8.3.1
> 
> 

-- 
Michal Hocko
SUSE Labs
