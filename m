Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAD4C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1345F20854
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfCHAfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 19:35:21 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:40681 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726241AbfCHAfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 19:35:20 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04396;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TMDiYUt_1552005317;
Received: from ali-6c96cfdd1403.local(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0TMDiYUt_1552005317)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 08 Mar 2019 08:35:17 +0800
Subject: Re: [PATCH] bcache: add cond_resched() in __bch_cache_cmp()
To:     Vojtech Pavlik <vojtech@suse.com>, Coly Li <colyli@suse.de>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1551935728-243664-1-git-send-email-shile.zhang@linux.alibaba.com>
 <24916a71-39ff-7324-ad12-9d79cc68d0da@suse.de>
 <3640cd7f-f32a-1509-dbef-6000b6e14e75@linux.alibaba.com>
 <c421d715-6d14-a6f0-907b-644318120c8e@suse.de>
 <20190307154421.GA8829@suse.cz>
From:   Shile Zhang <shile.zhang@linux.alibaba.com>
Message-ID: <b548e4a1-865e-61f1-1ac1-4daf84111f86@linux.alibaba.com>
Date:   Fri, 8 Mar 2019 08:35:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190307154421.GA8829@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/3/7 23:44, Vojtech Pavlik wrote:
> On Thu, Mar 07, 2019 at 11:36:18PM +0800, Coly Li wrote:
>> On 2019/3/7 11:06 下午, Shile Zhang wrote:
>>> On 2019/3/7 18:34, Coly Li wrote:
>>>> On 2019/3/7 1:15 下午, shile.zhang@linux.alibaba.com wrote:
>>>>> From: Shile Zhang <shile.zhang@linux.alibaba.com>
>>>>>
>>>>> Read /sys/fs/bcache/<uuid>/cacheN/priority_stats can take very long
>>>>> time with huge cache after long run.
>>>>>
>>>>> Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
>>>> Hi Shile,
>>>>
>>>> Do you test your change ? It will be helpful with more performance data
>>>> (what problem that you improved).
>>> In case of 960GB SSD cache device, once read of the 'priority_stats'
>>> costs about 600ms in our test environment.
>>>
>> After the fix, how much time it takes ?
>>
>>
>>> The perf tool shown that near 50% CPU time consumed by 'sort()', this
>>> means once sort will hold the CPU near 300ms.
>>>
>>> In our case, the statistics collector reads the 'priority_stats'
>>> periodically, it will trigger the schedule latency jitters of the
>>>
>>> task which shared same CPU core.
>>>
>> Hmm, it seems you just make the sort slower, and nothing more changes.
>> Am I right ?
> Well, it has to make the sort slower, but it'll also avoid hogging the
> CPU (on a non-preemptible kernel), avoiding a potential soft lockup
> warning and allowing other tasks to run.
>
Yes, there is a risk that other tasks have no chance to run due to sort 
hogging the CPU, it is harmful to some schedule-latency sensitive tasks.
This change just try to reduce the impact of sort, but not a performance 
improvement of it. I'm not sure if a better way can handle it more 
efficiency.

Thanks,

Shile


