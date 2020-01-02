Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29111C2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 03:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0025520863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 03:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbgABD5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 22:57:53 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:54505 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727509AbgABD5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 22:57:53 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TmXvN1X_1577937470;
Received: from IT-C02W23QPG8WN.local(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0TmXvN1X_1577937470)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Jan 2020 11:57:51 +0800
Subject: Re: [PATCH] mm/page-writeback.c: avoid potential division by zero
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        xlpang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, julia.lawall@lip6.fr
References: <20200101093204.3592-1-wenyang@linux.alibaba.com>
 <230E8A87-2900-427B-9EA3-CC48B4DCA5FC@lca.pw>
From:   Wen Yang <wenyang@linux.alibaba.com>
Message-ID: <62482b58-81e1-0295-1e28-e11261404831@linux.alibaba.com>
Date:   Thu, 2 Jan 2020 11:57:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <230E8A87-2900-427B-9EA3-CC48B4DCA5FC@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/1/1 8:39 下午, Qian Cai wrote:
> 
> 
>> On Jan 1, 2020, at 4:32 AM, Wen Yang <wenyang@linux.alibaba.com> wrote:
>>
>> The variables 'min', 'max' and 'bw' are unsigned long and
>> do_div truncates them to 32 bits, which means it can test
>> non-zero and be truncated to zero for division.
>> Fix this issue by using div64_ul() instead.
> 
> How did you find out the issue? If it is caught by compilers, can you paste the original warnings? Also, can you figure out which commit introduced the issue in the first place, so it could be backported to stable if needed?
> 

Thanks for your comments.
There are no compilation warnings here.

We found this issue by following these steps:
We were first inspired by commit b0ab99e7736a ("sched: Fix possible 
divide by zero in avg_atom () calculation"), combined with our recently 
analyzed mm code, we found this suspicious place.

And we also disassembled and confirmed it:

  201                 if (min) {
  202                         min *= this_bw;
  203                         do_div(min, tot_bw);
  204                 }

/usr/src/debug/kernel-4.9.168-016.ali3000/linux-4.9.168-016.ali3000.alios7.x86_64/mm/page-writeback.c: 
201
0xffffffff811c37da <__wb_calc_thresh+234>:      xor    %r10d,%r10d
0xffffffff811c37dd <__wb_calc_thresh+237>:      test   %rax,%rax
0xffffffff811c37e0 <__wb_calc_thresh+240>:      je 
0xffffffff811c3800 <__wb_calc_thresh+272>
/usr/src/debug/kernel-4.9.168-016.ali3000/linux-4.9.168-016.ali3000.alios7.x86_64/mm/page-writeback.c: 
202
0xffffffff811c37e2 <__wb_calc_thresh+242>:      imul   %r8,%rax
/usr/src/debug/kernel-4.9.168-016.ali3000/linux-4.9.168-016.ali3000.alios7.x86_64/mm/page-writeback.c: 
203
0xffffffff811c37e6 <__wb_calc_thresh+246>:      mov    %r9d,%r10d 
    ---> truncates it to 32 bits here

0xffffffff811c37e9 <__wb_calc_thresh+249>:      xor    %edx,%edx
0xffffffff811c37eb <__wb_calc_thresh+251>:      div    %r10
0xffffffff811c37ee <__wb_calc_thresh+254>:      imul   %rbx,%rax
0xffffffff811c37f2 <__wb_calc_thresh+258>:      shr    $0x2,%rax
0xffffffff811c37f6 <__wb_calc_thresh+262>:      mul    %rcx
0xffffffff811c37f9 <__wb_calc_thresh+265>:      shr    $0x2,%rdx
0xffffffff811c37fd <__wb_calc_thresh+269>:      mov    %rdx,%r10

This issue was introduced by commit 693108a8a667 (“writeback: make 
bdi->min/max_ratio handling cgroup writeback aware”).

Finally, we will summarize the above cases and plan to write a general 
coccinelle rule to check for similar problems.


>>
>> For the two variables 'numerator' and 'denominator',
>> though they are declared as long, they should actually be
>> unsigned long (according to the implementation of
>> the fprop_fraction_percpu() function).
