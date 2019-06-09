Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A21FC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 13:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48898208E4
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 13:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfFINKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 09:10:50 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:46032 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728516AbfFINKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 09:10:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TTm7q0i_1560085846;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TTm7q0i_1560085846)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 09 Jun 2019 21:10:46 +0800
Subject: Re: [bug report][stable] kernel tried to execute NX-protected page -
 exploit attempt? (uid: 0)
To:     Nadav Amit <namit@vmware.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Caspar Zhang <caspar@linux.alibaba.com>,
        jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Sasha Levin <sashal@kernel.org>
References: <5817eaac-29cc-6331-af3b-b9d85a7c1cd7@linux.alibaba.com>
 <bde5bf17-35d2-45d8-1d1d-59d0f027b9c0@linux.alibaba.com>
 <D0F0870A-B396-4390-B5F1-164B68E13C73@vmware.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <c2411bbb-d0e7-59b2-3418-63650b354544@linux.alibaba.com>
Date:   Sun, 9 Jun 2019 21:10:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <D0F0870A-B396-4390-B5F1-164B68E13C73@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nadav,
Thanks for the comments.
I'll test the 3 patches in the mentioned thread.

Thanks,
Joseph

On 19/6/8 00:38, Nadav Amit wrote:
>> On Jun 7, 2019, at 3:24 AM, Joseph Qi <joseph.qi@linux.alibaba.com> wrote:
>>
>> Hi all,
>> Any idea on this regression? 
> 
> Sorry for the late response (I assumed, for some reason, that you also follow 
> the second thread about this issue).
> 
> Anyhow, it should be fixed by backporting some patches which were mistakenly
> missed.
> 
> See https://lore.kernel.org/stable/20190606131558.GJ29739@sasha-vm/
> 
> Regards,
> Nadav
> 
> 
>> Thanks,
>> Joseph
>>
>> On 19/6/5 18:23, Joseph Qi wrote:
>>> Hi,
>>>
>>> I have encountered a kernel BUG when running ltp ftrace-stress-test
>>> on 4.19.48.
>>>
>>> [  209.704855] LTP: starting ftrace-stress-test (ftrace_stress_test.sh 90)
>>> [  209.739412] Scheduler tracepoints stat_sleep, stat_iowait, stat_blocked and stat_runtime require the kernel parameter schedstats=enable or kernel.sched_schedstats=1
>>> [  212.054506] kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
>>> [  212.055595] BUG: unable to handle kernel paging request at ffffffffc0349000
>>> [  212.056589] PGD d00c067 P4D d00c067 PUD d00e067 PMD 23673e067 PTE 800000023457f061
>>> [  212.057759] Oops: 0011 [#1] SMP PTI
>>> [  212.058303] CPU: 0 PID: 0 Comm: swapper/0 Kdump: loaded Not tainted 4.19.48 #112
>>>
>>> After some investigation I have found that it is introduced by commit
>>> 8715ce033eb3 ("x86/modules: Avoid breaking W^X while loading modules"),
>>> and then revert this commit the issue is gone.
>>>
>>> I have also tested the same case on 5.2-rc3 as well as right at
>>> upstream commit f2c65fb3221a ("x86/modules: Avoid breaking W^X while
>>> loading modules"), which has been merged in 5.2-rc1, it doesn't
>>> happen.
>>>
>>> So I don't know why only stable has this issue while upstream doesn't.
>>>
>>> Thanks,
>>> Joseph
> 
