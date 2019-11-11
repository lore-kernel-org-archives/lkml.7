Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E886C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 02:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678D2206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 02:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfKKCod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 21:44:33 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:45362 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726742AbfKKCoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 21:44:32 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0ThfxG.8_1573440269;
Received: from ali-6c96cfdd1403.local(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0ThfxG.8_1573440269)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 11 Nov 2019 10:44:29 +0800
Subject: Re: [RFC PATCH 0/4] Speed booting by sorting ORC unwind tables at
 build time
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
References: <20191107143205.206606-1-shile.zhang@linux.alibaba.com>
 <20191107152244.GD4114@hirez.programming.kicks-ass.net>
 <85abe498-f241-4752-81b5-6c0314f5a1e8@linux.alibaba.com>
 <20191108092136.GH4114@hirez.programming.kicks-ass.net>
 <20191108092533.GN5671@hirez.programming.kicks-ass.net>
From:   Shile Zhang <shile.zhang@linux.alibaba.com>
Message-ID: <2906cc91-113a-c132-1aef-ba94db31f847@linux.alibaba.com>
Date:   Mon, 11 Nov 2019 10:44:29 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191108092533.GN5671@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/11/8 17:25, Peter Zijlstra wrote:
> On Fri, Nov 08, 2019 at 10:21:36AM +0100, Peter Zijlstra wrote:
>> On Fri, Nov 08, 2019 at 09:42:55AM +0800, Shile Zhang wrote:
>>
>>>> Can sort{ex,orc}table() be ran concurrently? Do they want to be the same
>>>> (threaded) tool?
>>> I think it is possible to do those sort work concurrently, likes deferred
>>> memory init which is big boot time speed up.
>>> But I don't know if the exception table and ORC unwind tables can be
>>> deferred, due to those tables might be used in early boot time, for early
>>> exception handling and early debugging. I'm not familiar with that.
>> I meant at link time, run both sorts concurrently such that we only have
>> to wait for the longest, instead of the sum of them.
>>
>> They're not changing the same part of the ELF file, so it should be
>> possible to have one tool have multiple threads, each sorting a
>> different table.
>>
>> Aside from the .ex_table and ORC there's also .jump_table that wants
>> sorting (see jump_label_sort_entries()).
> Oh, and I'll be adding .static_call_sites soon, see:
>
>    https://lkml.kernel.org/r/20191007082708.013939311@infradead.org
>
> (I should repost that)
>
> That gives us 4 tables to sort which we can do concurrently in 4
> threads.

I got your point now.
I'll try to rework the sort tool to sort all tables concurrently in one 
tool with multiple-threads.
Thanks for your advice!

>> I agree that doing it at link time makes sense, I just hate to do all
>> this sorting in sequence and blowing up the link time. I don't build for
>> customers, I build for single use boot and linking _SUCKS_.

