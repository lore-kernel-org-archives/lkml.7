Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DE6C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4E42133F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbfJDMa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 08:30:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47596 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730888AbfJDMa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 08:30:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0E088307F5E3;
        Fri,  4 Oct 2019 12:30:59 +0000 (UTC)
Received: from llong.remote.csb (ovpn-123-24.rdu2.redhat.com [10.10.123.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 47D847A406;
        Fri,  4 Oct 2019 12:30:58 +0000 (UTC)
Subject: Re: [PATCH v2] lib/smp_processor_id: Don't use cpumask_equal()
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Juri Lelli <jlelli@redhat.com>
References: <20191003203608.21881-1-longman@redhat.com>
 <20191004092048.l2jeutbrffnwfol2@linutronix.de>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <6a57f64c-6145-4191-2e0a-9f90f019b96d@redhat.com>
Date:   Fri, 4 Oct 2019 08:30:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191004092048.l2jeutbrffnwfol2@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 04 Oct 2019 12:30:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/19 5:20 AM, Sebastian Andrzej Siewior wrote:
> On 2019-10-03 16:36:08 [-0400], Waiman Long wrote:
>> The check_preemption_disabled() function uses cpumask_equal() to see
>> if the task is bounded to the current CPU only. cpumask_equal() calls
>> memcmp() to do the comparison. As x86 doesn't have __HAVE_ARCH_MEMCMP,
>> the slow memcmp() function in lib/string.c is used.
>>
>> On a RT kernel that call check_preemption_disabled() very frequently,
>> below is the perf-record output of a certain microbenchmark:
>>
>>   42.75%  2.45%  testpmd [kernel.kallsyms] [k] check_preemption_disabled
>>   40.01% 39.97%  testpmd [kernel.kallsyms] [k] memcmp
>>
>> We should avoid calling memcmp() in performance critical path. So the
>> cpumask_equal() call is now replaced with an equivalent simpler check.
> using a simple integer comparison is still more efficient than what
> __HAVE_ARCH_MEMCMP can offer.
You are right. My main point is to try to avoid using cpumask_equal() in
performance critical path irrespective of this patch.
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by:  Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>
> Sebastian

Cheers,
Longman

