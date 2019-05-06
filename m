Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E99C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2DE2054F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfEFOGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:06:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7728 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbfEFOGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:06:00 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8BC805C34C77B0AC26C3;
        Mon,  6 May 2019 22:05:54 +0800 (CST)
Received: from [127.0.0.1] (10.184.225.177) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Mon, 6 May 2019
 22:05:47 +0800
Subject: Re: [PATCH] mm/hugetlb: Don't put_page in lock of hugetlb_lock
To:     Michal Hocko <mhocko@kernel.org>
CC:     <mike.kravetz@oracle.com>, <shenkai8@huawei.com>,
        <linfeilong@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <wangwang2@huawei.com>,
        "Zhoukang (A)" <zhoukang7@huawei.com>,
        Mingfangsen <mingfangsen@huawei.com>, <agl@us.ibm.com>,
        <nacc@us.ibm.com>
References: <12a693da-19c8-dd2c-ea6a-0a5dc9d2db27@huawei.com>
 <20190504130137.GS29835@dhcp22.suse.cz>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <d82df01c-09e8-4e3d-4e01-d4df87936f75@huawei.com>
Date:   Mon, 6 May 2019 22:05:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190504130137.GS29835@dhcp22.suse.cz>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.225.177]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat 04-05-19 20:28:24, Zhiqiang Liu wrote:
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

>> Fixes: 9980d744a0 ("mm, hugetlb: get rid of surplus page accounting tricks")
>> Signed-off-by: Kai Shen <shenkai8@huawei.com>
>> Signed-off-by: Feilong Lin <linfeilong@huawei.com>
>> Reported-by: Wang Wang <wangwang2@huawei.com>
> 
> You are right. I must have completely missed that put_page path
> unconditionally takes the hugetlb_lock for hugetlb pages.
> 
> Thanks for fixing this. I think this should be marked for stable
> because it is not hard to imagine a regular user might trigger this.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Thank you for your reply.
I will add Acked-by: Michal Hocko <mhocko@suse.com> in the v2 patch.


