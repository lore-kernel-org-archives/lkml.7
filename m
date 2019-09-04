Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A207FC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819F62077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbfIDKzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 06:55:37 -0400
Received: from foss.arm.com ([217.140.110.172]:51884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbfIDKzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 06:55:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6473C337;
        Wed,  4 Sep 2019 03:55:36 -0700 (PDT)
Received: from [192.168.0.8] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D94B23F246;
        Wed,  4 Sep 2019 03:55:34 -0700 (PDT)
Subject: Re: [PATCH v3] sched/core: Fix uclamp ABI bug, clean up and robustify
 sched_read_attr() ABI logic and code
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>
References: <20190903171645.28090-1-cascardo@canonical.com>
 <20190903171645.28090-2-cascardo@canonical.com>
 <20190904075532.GA26751@gmail.com> <20190904084934.GA117671@gmail.com>
 <20190904085519.GA127156@gmail.com>
 <db065b81-c373-f291-ad48-f556a209cc95@arm.com>
 <20190904103925.GA60962@gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <43e9f6ae-7ebc-d3d8-eecf-860cdef7fdec@arm.com>
Date:   Wed, 4 Sep 2019 12:55:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904103925.GA60962@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2019 12:39, Ingo Molnar wrote:
> 
> * Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> 
>>> -v3 attached. Build and minimally boot tested.
>>>
>>> Thanks,
>>>
>>> 	Ingo
>>>
>>
>> This patch fixes the issue (almost).
>>
>> LTP's sched_getattr01 passes again. But IMHO the prio 'chrt -p $$'
>> should be 0 instead of -65536.
> 
> Yeah, I forgot to zero-initialize the structure ...
> 
> Does the attached -v4 work any better for you?

Yeah, looks better now.

# chrt -p $$
[  258.245786] sched_attr_copy_to_user(): copied 48 bytes. (ksize: 56,
usize: 48)
pid 1635's current scheduling policy: SCHED_OTHER
pid 1635's current scheduling priority: 0

w/o the extra printk:

Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
