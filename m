Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD80C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 11:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCF220836
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 11:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfCBK62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 05:58:28 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:35485 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726019AbfCBK61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 05:58:27 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04389;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TLmRf0B_1551524303;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TLmRf0B_1551524303)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 02 Mar 2019 18:58:24 +0800
Subject: Re: [bug report][stable] perf probe: failed to add events
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        luto@kernel.org, Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Xu Yu <xuyu@linux.alibaba.com>, peterz@infradead.org,
        mingo@redhat.com
References: <1a4240a8-288b-45d0-073d-d5cb8f0c63eb@linux.alibaba.com>
 <20190226090505.GA24409@kroah.com>
 <c7ccd9cb-3a66-98a9-faa1-7ee5ed20ff88@linux.alibaba.com>
 <20190226130802.GA10343@kroah.com> <20190226142009.GC26786@kernel.org>
 <3b233ff2-e87a-1c61-d516-6c4cdecb4f01@intel.com>
 <8e798942-0e71-c88f-866f-88e55177e286@linux.alibaba.com>
 <fea29ce5-b410-27cc-045e-feeecbc4a7f5@intel.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <ab136937-2af8-d3bc-634a-17d06c42a5c7@linux.alibaba.com>
Date:   Sat, 2 Mar 2019 18:58:23 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <fea29ce5-b410-27cc-045e-feeecbc4a7f5@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On 19/2/28 15:19, Adrian Hunter wrote:
> On 28/02/19 4:07 AM, Joseph Qi wrote:
>> Hi Adrian,
>>
>> On 19/2/27 20:39, Adrian Hunter wrote:
>>> Seems to be fixed by this:
>>>
>>> From: Adrian Hunter <adrian.hunter@intel.com>
>>> Date: Wed, 27 Feb 2019 05:35:25 +0200
>>> Subject: [PATCH] perf probe: Fix getting the kernel map
>>>
>>> Since commit 4d99e4136580 ("perf machine: Workaround missing maps for x86
>>> PTI entry trampolines"), perf tools has been creating more than one kernel
>>> map, however 'perf probe' assumed there could be only one.
>>>
>>> Fix by using machine__kernel_map() to get the main kernel map.
>>>
>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>> Fixes: 4d99e4136580 ("perf machine: Workaround missing maps for x86 PTI entry trampolines")
>>
>> Below is my investigation result before, FYI.
>> the first bad commit (v4.18 ~ v4.19):
>> d83212d5dd67 kallsyms, x86: Export addresses of PTI entry trampolines
> 
> Yes we should add a fixes tag for that also.
> 
Have you sent out the patch officially？
I can't find it in the mail list.

Thanks,
Joseph

>> revert this commit on 4.19.0, it works.
>> the first good commit again (v4.19 ~ v4.20):
>> bf904d2762ee x86/pti/64: Remove the SYSCALL64 entry trampoline
>> backported this commit as well as the related commit 98f05b5138f0 on
>> v4.19.24, it works.
>>
>> And I've tested your fix on v4.19.24, it also works.
>> Tested-by: Joseph Qi <joseph.qi@linux.alibaba.com>
>>
