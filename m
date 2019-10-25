Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C693FCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A240E206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437707AbfJYIEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:04:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4760 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437690AbfJYIEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:04:49 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 096A5ECD9030C7B20AD8;
        Fri, 25 Oct 2019 16:04:46 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 25 Oct
 2019 16:04:42 +0800
Subject: =?UTF-8?Q?Re:_[f2fs-dev]_[bug_report]_compiler_warning:_fs/f2fs/nod?=
 =?UTF-8?B?ZS5jOiBJbiBmdW5jdGlvbiDigJhfX3NldF9uYXRfY2FjaGVfZGlydHnigJk6IA==?=
 =?UTF-8?Q?=e2=80=98head=e2=80=99_may_be_used_uninitialized?=
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>
References: <fc71f3b73116115f78bcee2753e7bb3d5331731e.camel@analog.com>
 <e815981a-50ef-0f49-cab6-e510ea44ddc0@huawei.com>
 <425c2a3697b9973bb2bb51b692f80c02ef105285.camel@analog.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <dbd29eb5-527d-300e-61b8-227d44eb6c86@huawei.com>
Date:   Fri, 25 Oct 2019 16:04:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <425c2a3697b9973bb2bb51b692f80c02ef105285.camel@analog.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/24 17:54, Ardelean, Alexandru wrote:
> On Thu, 2019-10-24 at 17:12 +0800, Chao Yu wrote:
>> [External]
>>
>> On 2019/10/23 22:02, Ardelean, Alexandru wrote:
>>> Seems to have been introduced via:
>>>
>>> ----------------------------------------------------------------
>>>
>>> commit 780de47cf6cb5f524cd98ec8ffbffc3da5696e17
>>> Author: Chao Yu <yuchao0@huawei.com>
>>> Date:   Tue Mar 20 23:08:30 2018 +0800
>>>
>>>     f2fs: don't track new nat entry in nat set
>>>     
>>>     Nat entry set is used only in checkpoint(), and during checkpoint()
>>> we
>>>     won't flush new nat entry with unallocated address, so we don't
>>> need to
>>>     add new nat entry into nat set, then nat_entry_set::entry_cnt can
>>>     indicate actual entry count we need to flush in checkpoint().
>>>     
>>>     Signed-off-by: Yunlei He <heyunlei@huawei.com>
>>>     Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>     Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ----------------------------------------------------------------
>>>
>>> Compiler warning is:
>>> ----------------------------------------------------------------
>>>
>>>   CC      fs/f2fs/node.o
>>> In file included from ./include/linux/wait.h:7:0,
>>>                  from ./include/linux/wait_bit.h:8,
>>>                  from ./include/linux/fs.h:6,
>>>                  from fs/f2fs/node.c:11:
>>> fs/f2fs/node.c: In function ‘__set_nat_cache_dirty’:
>>> ./include/linux/list.h:63:13: error: ‘head’ may be used uninitialized
>>> in
>>> this function [-Werror=maybe-uninitialized]
>>>   next->prev = new;
>>>              ^
>>> fs/f2fs/node.c:238:24: note: ‘head’ was declared here
>>>   struct nat_entry_set *head;
>>
>> That's not correct, @head will only be assigned and used if new_ne equals
>> NULL.
> 
> Ack.
> I admit that I don't understand the code, and don't claim to understand it.
> 
> This may be just a weird compiler issue.
> I thought I'd send it just as a heads-up.

I think that's the right thing to do.

> I saw this on a Raspberry Pi branch [after we enabled warnings as errors]:
> https://travis-ci.org/analogdevicesinc/linux/jobs/601844926#L1208
> 
> Looking in the latest f2fs/dev[-test] tree, it looks like the code is
> similar as in 4.19.
> https://github.com/analogdevicesinc/linux/blob/rpi-4.19.y/fs/f2fs/node.c#L235
> 
> Could be that the RPi branch has some more compiler-stuff enabled.
> 
> In any case, feel free to disregard this.
> We will see how we fix this on our end for that branch specifically.

That would make sense, let me know if you have any other suspicious compiler
warnings. :)

Thanks,

> 
> Thanks
> Alex
> 
>>
>> Thanks,
>>
>>>                         ^
>>> cc1: all warnings being treated as errors
>>> ----------------------------------------------------------------
>>>
>>> Thanks
>>> Alex
>>>
>>> _______________________________________________
>>> Linux-f2fs-devel mailing list
>>> Linux-f2fs-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>
