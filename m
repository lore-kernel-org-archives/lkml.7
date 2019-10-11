Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2165C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 21:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E06E2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 21:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbfJKV4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 17:56:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:35756 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728993AbfJKV4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 17:56:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 493C4ACA8;
        Fri, 11 Oct 2019 21:56:44 +0000 (UTC)
Subject: Re: [PATCH v2 1/1] mm/vmalloc: remove preempt_disable/enable when do
 preloading
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20191010223318.28115-1-urezki@gmail.com>
 <20191011181532.nardqmokz7yxtsu3@linutronix.de>
From:   Daniel Wagner <dwagner@suse.de>
Message-ID: <c5b522c3-2d38-a8c8-b9e9-b3e3448ed8fa@suse.de>
Date:   Fri, 11 Oct 2019 23:56:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191011181532.nardqmokz7yxtsu3@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/19 8:15 PM, Sebastian Andrzej Siewior wrote:
> On 2019-10-11 00:33:18 [+0200], Uladzislau Rezki (Sony) wrote:
>> Get rid of preempt_disable() and preempt_enable() when the
>> preload is done for splitting purpose. The reason is that
>> calling spin_lock() with disabled preemtion is forbidden in
>> CONFIG_PREEMPT_RT kernel.
>>
>> Therefore, we do not guarantee that a CPU is preloaded, instead
>> we minimize the case when it is not with this change.
>>
>> For example i run the special test case that follows the preload
>> pattern and path. 20 "unbind" threads run it and each does
>> 1000000 allocations. Only 3.5 times among 1000000 a CPU was
>> not preloaded. So it can happen but the number is negligible.
>>
>> V1 -> V2:
>>    - move __this_cpu_cmpxchg check when spin_lock is taken,
>>      as proposed by Andrew Morton
>>    - add more explanation in regard of preloading
>>    - adjust and move some comments
>>
>> Fixes: 82dd23e84be3 ("mm/vmalloc.c: preload a CPU with one object for split purpose")
>> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Daniel Wagner <dwagner@suse.de>

