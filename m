Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7B2C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 22:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4DE2182B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 22:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557442492;
	bh=MslwbGMGtefXAWdqoRks6S7doMHcsjJBefOUECVcWrg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=WsTuODriH/YThIHkeMIMXN+KyugpVCUN5hEQS/wgDJRzf2huNfmsoLvYutOvowhat
	 skhBLVNmLxjHKS4sjLT+bWe+7t95vhQn+18eiSq/ucegmiYn2PhLurfDmngEKlHeeE
	 nJGZYU9ecvI/UiDTcgLdamV1XERIRxBtPbL5IqRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfEIWyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 18:54:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfEIWyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 18:54:51 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AF6C2177B;
        Thu,  9 May 2019 22:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557442490;
        bh=MslwbGMGtefXAWdqoRks6S7doMHcsjJBefOUECVcWrg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l+ARRXQvHKMU5YamYFAJfDEOefTeHsJ8tfZW4B8X6TK3v3Jwaakjx+U1pHfMAHcwx
         Q86v8GbmEPKJyzUSVNi+UkaEQyUxMUvkdoaDIuP1jfrXrK1eY0cgaIwS0u7B6YGtqg
         K0XRLxp3QYaRDEZdWflE+QKMdDSBF6qUaQEgbGqs=
Date:   Thu, 9 May 2019 15:54:49 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     <mhocko@suse.com>, <mike.kravetz@oracle.com>,
        <shenkai8@huawei.com>, <linfeilong@huawei.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <wangwang2@huawei.com>, "Zhoukang (A)" <zhoukang7@huawei.com>,
        Mingfangsen <mingfangsen@huawei.com>, <agl@us.ibm.com>,
        <nacc@us.ibm.com>
Subject: Re: [PATCH v2] mm/hugetlb: Don't put_page in lock of hugetlb_lock
Message-Id: <20190509155449.ee141be7998256015ea0eb73@linux-foundation.org>
In-Reply-To: <b8ade452-2d6b-0372-32c2-703644032b47@huawei.com>
References: <12a693da-19c8-dd2c-ea6a-0a5dc9d2db27@huawei.com>
        <b8ade452-2d6b-0372-32c2-703644032b47@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 May 2019 22:06:38 +0800 Zhiqiang Liu <liuzhiqiang26@huawei.com> wrote:

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
> Acked-by: Michal Hocko <mhocko@suse.com>

THanks.  I added cc:stable@vger.kernel.org to this.
