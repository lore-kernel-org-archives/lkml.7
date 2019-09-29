Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9139C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 00:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1ED2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 00:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbfI2AxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 20:53:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49758 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728569AbfI2AxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 20:53:14 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4506EAA3CB7C4192E4B3;
        Sun, 29 Sep 2019 08:53:12 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sun, 29 Sep
 2019 08:53:07 +0800
Subject: Re: [PATCH] f2fs: fix comment of f2fs_evict_inode
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20190925093050.118921-1-yuchao0@huawei.com>
 <20190927183150.GA54001@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <8c54adaf-163f-fcbe-7731-0c18b12410e0@huawei.com>
Date:   Sun, 29 Sep 2019 08:53:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190927183150.GA54001@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaegeuk,

On 2019/9/28 2:31, Jaegeuk Kim wrote:
> Hi Chao,
> 
> On 09/25, Chao Yu wrote:
>> evict() should be called once i_count is zero, rather than i_nlinke
>> is zero.
>>
>> Reported-by: Gao Xiang <gaoxiang25@huawei.com>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/inode.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>> index db4fec30c30d..8262f4a483d3 100644
>> --- a/fs/f2fs/inode.c
>> +++ b/fs/f2fs/inode.c
>> @@ -632,7 +632,7 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
>>  }
>>  
>>  /*
>> - * Called at the last iput() if i_nlink is zero
> 
> I don't think this comment is wrong. You may be able to add on top of this.

It actually misleads the developer or user.

How do you think of:

"Called at the last iput() if i_count is zero, and will release all meta/data
blocks allocated in the inode if i_nlink is zero"

Thanks,

> 
>> + * Called at the last iput() if i_count is zero
>>   */
>>  void f2fs_evict_inode(struct inode *inode)
>>  {
>> -- 
>> 2.18.0.rc1
> .
> 
