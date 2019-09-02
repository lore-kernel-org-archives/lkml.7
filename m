Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A27C3A5A4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 01:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF142184D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 01:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbfIBBQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 21:16:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5264 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729117AbfIBBQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 21:16:45 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 05DDA2834E6AD09C6159;
        Mon,  2 Sep 2019 09:16:42 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 2 Sep 2019
 09:16:35 +0800
Subject: Re: [PATCH v4] f2fs: add bio cache for IPU
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20190219081529.5106-1-yuchao0@huawei.com>
 <d2b3c101-0399-4e85-5765-7b6504aaca74@huawei.com>
 <20190901071757.GA49907@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <024fe351-8e25-35cd-47a7-9755498c73f4@huawei.com>
Date:   Mon, 2 Sep 2019 09:16:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190901071757.GA49907@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/1 15:17, Jaegeuk Kim wrote:
> On 08/31, Chao Yu wrote:
>> On 2019/2/19 16:15, Chao Yu wrote:
>>> @@ -1976,10 +2035,13 @@ static int __write_data_page(struct page *page, bool *submitted,
>>>  	}
>>>  
>>>  	unlock_page(page);
>>> -	if (!S_ISDIR(inode->i_mode) && !IS_NOQUOTA(inode))
>>> +	if (!S_ISDIR(inode->i_mode) && !IS_NOQUOTA(inode)) {
>>> +		f2fs_submit_ipu_bio(sbi, bio, page);
>>>  		f2fs_balance_fs(sbi, need_balance_fs);
>>> +	}
>>
>> Above bio submission was added to avoid below deadlock:
>>
>> - __write_data_page
>>  - f2fs_do_write_data_page
>>   - set_page_writeback        ---- set writeback flag
>>   - f2fs_inplace_write_data
>>  - f2fs_balance_fs
>>   - f2fs_gc
>>    - do_garbage_collect
>>     - gc_data_segment
>>      - move_data_page
>>       - f2fs_wait_on_page_writeback
>>        - wait_on_page_writeback  --- wait writeback
>>
>> However, it breaks the merge of IPU IOs, to solve this issue, it looks we need
>> to add global bio cache for such IPU merge case, then later
>> f2fs_wait_on_page_writeback can check whether writebacked page is cached or not,
>> and do the submission if necessary.
>>
>> Jaegeuk, any thoughts?
> 
> How about calling f2fs_submit_ipu_bio() when we need to do GC in the same
> context?

However it also could happen in race case:

Thread A				Thread B
- __write_data_page (inode x, page y)
 - f2fs_do_write_data_page
  - set_page_writeback        ---- set writeback flag in page y
  - f2fs_inplace_write_data
 - f2fs_balance_fs
					 - lock gc_mutex
 - lock gc_mutex
					  - f2fs_gc
					   - do_garbage_collect
					    - gc_data_segment
					     - move_data_page
					      - f2fs_wait_on_page_writeback
					       - wait_on_page_writeback  --- wait writeback of page y

So it needs a global bio cache for merged IPU pages, how about adding a list to
link all ipu bios in struct f2fs_bio_info?

struct f2fs_bio_info {
	....
	struct list_head ipu_bio_list;	/* track all ipu bio */
	spinlock_t ipu_bio_lock;	/* protect ipu bio list */
}

> 
>>
>> Thanks,
> .
> 
