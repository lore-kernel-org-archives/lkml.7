Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3439C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785D72184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfCNHyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 03:54:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48244 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726606AbfCNHyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 03:54:17 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0EBDC5ABE2909F18C4D8;
        Thu, 14 Mar 2019 15:54:15 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Thu, 14 Mar 2019
 15:54:10 +0800
Message-ID: <5C8A08A1.3090403@huawei.com>
Date:   Thu, 14 Mar 2019 15:54:09 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
CC:     Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [Qestion] Hit a WARN_ON_ONCE in try_to_unmap_one when runing
 syzkaller
References: <5C87D848.7030802@huawei.com> <20190314062757.GA27899@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20190314062757.GA27899@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/3/14 14:27, Naoya Horiguchi wrote:
> Hi,
>
> On Wed, Mar 13, 2019 at 12:03:20AM +0800, zhong jiang wrote:
> ...
>> Minchan has changed the conditon check from  BUG_ON  to WARN_ON_ONCE in try_to_unmap_one.
>> However,  It is still an abnormal condition when PageSwapBacked is not equal to PageSwapCache.
>>
>> But Is there any case it will meet the conditon in the mainline.
>>
>> It is assumed that PageSwapBacked(page) is true in the anonymous page,   This is to say,  PageSwapcache
>> is false. however,  That is impossible because we will update the pte for hwpoison entry.
>>
>> Because page is locked ,  Its page flags should not be changed except for PageSwapBacked
> try_to_unmap_one() from hwpoison_user_mappings() could reach the
> WARN_ON_ONCE() only if TTU_IGNORE_HWPOISON is set, because PageHWPoison()
> is set at the beginning of memory_failure().
>
> Clearing TTU_IGNORE_HWPOISON might happen on the following two paths:
>
>   static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
>                                     int flags, struct page **hpagep)
>   {
>       ...
>   
>       if (PageSwapCache(p)) {
>               pr_err("Memory failure: %#lx: keeping poisoned page in swap cache\n",
>                       pfn);
>               ttu |= TTU_IGNORE_HWPOISON;
>       }
>       ...
>
>       mapping = page_mapping(hpage);                                                                           
>       if (!(flags & MF_MUST_KILL) && !PageDirty(hpage) && mapping &&                                           
>           mapping_cap_writeback_dirty(mapping)) {                                                              
>               if (page_mkclean(hpage)) {                                                                       
>                       SetPageDirty(hpage);                                                                     
>               } else {                                                                                         
>                       kill = 0;                                                                                
>                       ttu |= TTU_IGNORE_HWPOISON;                                                              
>                       pr_info("Memory failure: %#lx: corrupted page was clean: dropped without side effects\n",
>                               pfn);                                                                            
>               }                                                                                                
>       }                                                                                                        
>       ...
>
>       unmap_success = try_to_unmap(hpage, ttu);
>       ...
>
> So either of the above "ttu |= TTU_IGNORE_HWPOISON" should be executed.
> I'm not sure which one, but both paths show printk messages, so if you
> could have kernel message log, that might help ...
Thank you for your response.

Unfortunately, I lost the printk log. I was looking for it before and support us for further analysis.

It's very weird to get there. Assume that TTU_IGNORE_HWPOSISON is set. There is the two case.

First, PageSwapCache is set and page has been locked. Theoretically WARN_ON_ONCE should not be triggered.
Second, We should assume the page belongs to file page.:-(

I will go on reproducing the issue and get the printk message log.

Thanks
zhong jiang
> Thanks,
> Naoya Horiguchi
>
> .
>


