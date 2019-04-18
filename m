Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1DAC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D861217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389062AbfDRNRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:17:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57952 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388685AbfDRNRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:17:51 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B40A15E72326BE78DE5D;
        Thu, 18 Apr 2019 21:17:41 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Thu, 18 Apr 2019
 21:17:36 +0800
Subject: Re: [tip:sched/core] sched/core: Make some functions static
To:     Ingo Molnar <mingo@kernel.org>, <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
        <hpa@zytor.com>, <peterz@infradead.org>
References: <20190322143153.14416-1-yuehaibing@huawei.com>
 <tip-16e671afb70f28eb189136d1395c59dafecd270a@git.kernel.org>
 <20190418124836.GB104512@gmail.com>
CC:     <linux-tip-commits@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <eeb6c251-8ff7-67fc-5dab-8e49c783705d@huawei.com>
Date:   Thu, 18 Apr 2019 21:17:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190418124836.GB104512@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/4/18 20:48, Ingo Molnar wrote:
> 
> * tip-bot for YueHaibing <tipbot@zytor.com> wrote:
> 
>> Commit-ID:  16e671afb70f28eb189136d1395c59dafecd270a
>> Gitweb:     https://git.kernel.org/tip/16e671afb70f28eb189136d1395c59dafecd270a
>> Author:     YueHaibing <yuehaibing@huawei.com>
>> AuthorDate: Fri, 22 Mar 2019 22:31:53 +0800
>> Committer:  Ingo Molnar <mingo@kernel.org>
>> CommitDate: Thu, 18 Apr 2019 14:19:25 +0200
>>
>> sched/core: Make some functions static
>>
>> Fix these sparse warnings:
>>
>>   kernel/sched/core.c:6576:11: warning: symbol 'max_cfs_quota_period' was not declared. Should it be static?
>>   kernel/sched/core.c:6577:11: warning: symbol 'min_cfs_quota_period' was not declared. Should it be static?
>>   kernel/sched/core.c:6657:5: warning: symbol 'tg_set_cfs_quota' was not declared. Should it be static?
>>   kernel/sched/core.c:6670:6: warning: symbol 'tg_get_cfs_quota' was not declared. Should it be static?
>>   kernel/sched/core.c:6683:5: warning: symbol 'tg_set_cfs_period' was not declared. Should it be static?
>>   kernel/sched/core.c:6693:6: warning: symbol 'tg_get_cfs_period' was not declared. Should it be static?
>>   kernel/sched/fair.c:2596:6: warning: symbol 'task_tick_numa' was not declared. Should it be static?
> 
> So unless this is somehow version dependent or other changes interfered, 
> this patch wasn't tested very well:

Well, this patch is sent before commit 2e8e19226398 ("sched/fair: Limit sched_cfs_period_timer() loop

 to avoid hard lockup") merged, which use max_cfs_quota_period in kernel/sched/fair.c

I can rework patch and send v2.

> 
>  kernel/sched/fair.o: In function `sched_cfs_period_timer':
>  fair.c:(.text+0x920c): undefined reference to `max_cfs_quota_period'
>  fair.c:(.text+0x9214): undefined reference to `max_cfs_quota_period'
> 
> skipping it for now.
> 
> Thanks,
> 
> 	Ingo
> 
> .
> 

