Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D304C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 11:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE5020684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 11:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfCHLQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 06:16:38 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:54378 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725789AbfCHLQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 06:16:37 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 352A85FDFA920979826A;
        Fri,  8 Mar 2019 19:16:35 +0800 (CST)
Received: from [127.0.0.1] (10.184.213.217) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Fri, 8 Mar 2019
 19:16:25 +0800
Subject: Re: [PATCH 2/8] aio_poll_wake(): don't set ->woken if we ignore the
 wakeup
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Eric Dumazet <eric.dumazet@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jason Baron <jbaron@akamai.com>, <kgraul@linux.ibm.com>,
        <ktkhai@virtuozzo.com>, <kyeongdon.kim@lge.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, <pabeni@redhat.com>,
        <syzkaller-bugs@googlegroups.com>, <xiyou.wangcong@gmail.com>,
        Christoph Hellwig <hch@lst.de>, <bcrl@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-aio@kvack.org>,
        <houtao1@huawei.com>, <yi.zhang@huawei.com>
References: <CAHk-=wghRmdYKRAwakeHmjcpbLt9fJAHyU2x8s_NZONhz6RTOw@mail.gmail.com>
 <20190307000316.31133-1-viro@ZenIV.linux.org.uk>
 <20190307000316.31133-2-viro@ZenIV.linux.org.uk>
 <20190307021844.GC2217@ZenIV.linux.org.uk>
From:   "zhengbin (A)" <zhengbin13@huawei.com>
Message-ID: <c02a5a3c-c617-b0d2-28a0-462f26b0c1c8@huawei.com>
Date:   Fri, 8 Mar 2019 19:16:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190307021844.GC2217@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.213.217]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So, what should we do?

On 2019/3/7 10:18, Al Viro wrote:
> On Thu, Mar 07, 2019 at 12:03:10AM +0000, Al Viro wrote:
>> From: Al Viro <viro@zeniv.linux.org.uk>
>>
>> In case of early wakeups, aio_poll() assumes that aio_poll_complete()
>> has either already happened or is imminent.  In that case we do not
>> want to put iocb on the list of cancellables.  However, ignored
>> wakeups need to be treated as if wakeup has not happened at all.
>> Trivially fixed by having aio_poll_wake() set ->woken only after
>> it's committed to taking iocb out of the waitqueue.
>>
>> Spotted-by: zhengbin <zhengbin13@huawei.com>
>> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> ... and unfortunately it's worse than just that - what both of us
> have missed is that one could have non-specific wakep + schedule_work +
> aio_poll_complete_work() rechecking ->poll(), seeing nothing of
> interest and reinserting into queue.  All before vfs_poll() manages
> to return into aio_poll().  The window is harder to hit, but it's
> still there, with exact same "failed to add to cancel list" kind of bug
> if we do hit it ;-/
> 
> .
> 

