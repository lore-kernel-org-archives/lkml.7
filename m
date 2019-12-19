Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B03C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7092146E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfLSQJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 11:09:00 -0500
Received: from relay.sw.ru ([185.231.240.75]:57942 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbfLSQJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 11:09:00 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1ihyM7-0007Tl-FY; Thu, 19 Dec 2019 19:08:51 +0300
Subject: Re: [Q] ld: Does LTO reorder ro variables in two files?
To:     Alexander Monakov <amonakov@ispras.ru>
Cc:     Peter Zijlstra <peterz@infradead.org>, gcc-help@gcc.gnu.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, Jan Hubicka <hubicka@ucw.cz>
References: <157675913272.349305.8936736338884044103.stgit@localhost.localdomain>
 <20191219131242.GK2827@hirez.programming.kicks-ass.net>
 <3db1b1c8-0228-56e4-a04f-e8d24cd1dd51@virtuozzo.com>
 <alpine.LNX.2.20.13.1912191817440.18668@monopod.intra.ispras.ru>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <f8ecf41d-2f0e-1c17-8c71-1956ca8cf465@virtuozzo.com>
Date:   Thu, 19 Dec 2019 19:08:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.20.13.1912191817440.18668@monopod.intra.ispras.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.12.2019 18:45, Alexander Monakov wrote:
> [adding Jan Hubicka, GCC LTO maintainer]
> 
> On Thu, 19 Dec 2019, Kirill Tkhai wrote:
> 
>> CC: gcc-help@gcc.gnu.org
>>
>> Hi, gcc guys,
>>
>> this thread starts here: https://lkml.org/lkml/2019/12/19/403
>>
>> There are two const variables:
>>
>>    struct sched_class idle_sched_class
>> and
>>    struct sched_class fair_sched_class,
>>
>> which are declared in two files idle.c and fair.c.
>>
>> 1)In Makefile the order is: idle.o fair.o
>> 2)the variables go to the same ro section
>> 3)there is no SORT(.*) keyword in linker script.
>>
>> Is it always true, that after linkage &idle_sched_class < &fair_sched_class?
> 
> No, with LTO you don't have that guarantee. For functions it's more obvious,
> GCC wants to analyze functions in reverse topological order so callees are
> generally optimized before callers, and it will emit assembly as it goes, so
> function ordering with LTO does not give much care to translation unit
> boundaries. For variables it's a bit more subtle, GCC partitions all variables
> and functions so it can hand them off to multiple compiler processes while doing
> LTO. There's no guarantees about order of variables that end up in different
> partitions.
> 
> There's __attribute__((no_reorder)) that is intended to enforce ordering even
> with LTO (it's documented under "Common function attributes" but works for
> global variables as well).

Thanks, Alexander!

Kirill
