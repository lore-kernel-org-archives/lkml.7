Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6F7C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0DCD20851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732853AbfCAHql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 02:46:41 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:55522 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732630AbfCAHql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 02:46:41 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7C2AE9FC675B8F1EC746;
        Fri,  1 Mar 2019 15:46:38 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Fri, 1 Mar 2019
 15:46:33 +0800
Message-ID: <5C78E357.5060808@huawei.com>
Date:   Fri, 1 Mar 2019 15:46:31 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
CC:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "hughd@google.com" <hughd@google.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>
Subject: Re: [PATCH] mm: hwpoison: fix thp split handing in soft_offline_in_use_page()
References: <1551179880-65331-1-git-send-email-zhongjiang@huawei.com> <20190226135156.mifspmbdyr6m3hff@kshutemo-mobl1> <5C754E78.4050804@huawei.com> <20190301072919.GA3027@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20190301072919.GA3027@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/3/1 15:29, Naoya Horiguchi wrote:
> On Tue, Feb 26, 2019 at 10:34:32PM +0800, zhong jiang wrote:
>> On 2019/2/26 21:51, Kirill A. Shutemov wrote:
>>> On Tue, Feb 26, 2019 at 07:18:00PM +0800, zhong jiang wrote:
>>>> From: zhongjiang <zhongjiang@huawei.com>
>>>>
>>>> When soft_offline_in_use_page() runs on a thp tail page after pmd is plit,
>>> s/plit/split/
>>>
>>>> we trigger the following VM_BUG_ON_PAGE():
>>>>
>>>> Memory failure: 0x3755ff: non anonymous thp
>>>> __get_any_page: 0x3755ff: unknown zero refcount page type 2fffff80000000
>>>> Soft offlining pfn 0x34d805 at process virtual address 0x20fff000
>>>> page:ffffea000d360140 count:0 mapcount:0 mapping:0000000000000000 index:0x1
>>>> flags: 0x2fffff80000000()
>>>> raw: 002fffff80000000 ffffea000d360108 ffffea000d360188 0000000000000000
>>>> raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
>>>> page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
>>>> ------------[ cut here ]------------
>>>> kernel BUG at ./include/linux/mm.h:519!
>>>>
>>>> soft_offline_in_use_page() passed refcount and page lock from tail page to
>>>> head page, which is not needed because we can pass any subpage to
>>>> split_huge_page().
>>> I don't see a description of what is going wrong and why change will fixed
>>> it. From the description, it appears as it's cosmetic-only change.
>>>
>>> Please elaborate.
>> When soft_offline_in_use_page runs on a thp tail page after pmd is split,  
>> and we pass the head page to split_huge_page, Unfortunately, the tail page
>> can be free or count turn into zero.
> I guess that you have the similar fix on memory_failure() in your mind:
>
>   commit c3901e722b2975666f42748340df798114742d6d
>   Author: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
>   Date:   Thu Nov 10 10:46:23 2016 -0800
>   
>       mm: hwpoison: fix thp split handling in memory_failure()
>
> So it seems that I somehow missed fixing soft offline when I wrote commit
> c3901e722b29, and now you find and fix that. Thank you very much.
> If you resend the patch with fixing typo, can you add some reference to
> c3901e722b29 in the patch description to show the linkage?
> And you can add the following tags:
Yep, I find that that is a similar issue. hence I refer to that description in the patch you
had mentioned.

I will add the above desprition you had mentioned in V2.

Thanks,
zhong jiang
> Fixes: 61f5d698cc97 ("mm: re-enable THP")
> Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
>
> Thanks,
> Naoya Horiguchi
>
> .
>


