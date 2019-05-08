Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8273C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09E721019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfEHLcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 07:32:17 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7181 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727487AbfEHLcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 07:32:16 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5982ABEEDEE367A789E0;
        Wed,  8 May 2019 19:32:13 +0800 (CST)
Received: from [127.0.0.1] (10.184.225.177) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Wed, 8 May 2019
 19:32:06 +0800
Subject: Re: [PATCH v2] mm/hugetlb: Don't put_page in lock of hugetlb_lock
To:     Mike Kravetz <mike.kravetz@oracle.com>, <mhocko@suse.com>,
        <shenkai8@huawei.com>, <linfeilong@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <wangwang2@huawei.com>, "Zhoukang (A)" <zhoukang7@huawei.com>,
        Mingfangsen <mingfangsen@huawei.com>, <agl@us.ibm.com>,
        <nacc@us.ibm.co>
References: <12a693da-19c8-dd2c-ea6a-0a5dc9d2db27@huawei.com>
 <b8ade452-2d6b-0372-32c2-703644032b47@huawei.com>
 <9405fcd5-a5a7-db4a-d613-acf2872f6e62@oracle.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <21971d7f-aec7-bc38-7f9b-08c1bf96be9e@huawei.com>
Date:   Wed, 8 May 2019 19:31:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <9405fcd5-a5a7-db4a-d613-acf2872f6e62@oracle.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.225.177]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 5/6/19 7:06 AM, Zhiqiang Liu wrote:
>> From: Kai Shen <shenkai8@huawei.com>
>>
>> spinlock recursion happened when do LTP test:
>> #!/bin/bash
>> ./runltp -p -f hugetlb &
>> ./runltp -p -f hugetlb &
>> ./runltp -p -f hugetlb &
>> ./runltp -p -f hugetlb &
>> ./runltp -p -f hugetlb &
>>
>> The dtor returned by get_compound_page_dtor in __put_compound_page
>> may be the function of free_huge_page which will lock the hugetlb_lock,
>> so don't put_page in lock of hugetlb_lock.
>>
>>  BUG: spinlock recursion on CPU#0, hugemmap05/1079
>>   lock: hugetlb_lock+0x0/0x18, .magic: dead4ead, .owner: hugemmap05/1079, .owner_cpu: 0
>>  Call trace:
>>   dump_backtrace+0x0/0x198
>>   show_stack+0x24/0x30
>>   dump_stack+0xa4/0xcc
>>   spin_dump+0x84/0xa8
>>   do_raw_spin_lock+0xd0/0x108
>>   _raw_spin_lock+0x20/0x30
>>   free_huge_page+0x9c/0x260
>>   __put_compound_page+0x44/0x50
>>   __put_page+0x2c/0x60
>>   alloc_surplus_huge_page.constprop.19+0xf0/0x140
>>   hugetlb_acct_memory+0x104/0x378
>>   hugetlb_reserve_pages+0xe0/0x250
>>   hugetlbfs_file_mmap+0xc0/0x140
>>   mmap_region+0x3e8/0x5b0
>>   do_mmap+0x280/0x460
>>   vm_mmap_pgoff+0xf4/0x128
>>   ksys_mmap_pgoff+0xb4/0x258
>>   __arm64_sys_mmap+0x34/0x48
>>   el0_svc_common+0x78/0x130
>>   el0_svc_handler+0x38/0x78
>>   el0_svc+0x8/0xc
>>
>> Fixes: 9980d744a0 ("mm, hugetlb: get rid of surplus page accounting tricks")
>> Signed-off-by: Kai Shen <shenkai8@huawei.com>
>> Signed-off-by: Feilong Lin <linfeilong@huawei.com>
>> Reported-by: Wang Wang <wangwang2@huawei.com>
>> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Good catch.  Sorry, for the late reply.
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> 

Thank your for the reply.
Friendly ping ...


