Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B8CC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CE221670
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbfIDJbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 05:31:34 -0400
Received: from foss.arm.com ([217.140.110.172]:50388 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727348AbfIDJbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 05:31:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25915344;
        Wed,  4 Sep 2019 02:31:33 -0700 (PDT)
Received: from [192.168.0.8] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E07B3F246;
        Wed,  4 Sep 2019 02:31:31 -0700 (PDT)
Subject: Re: [PATCH v3] sched/core: Fix uclamp ABI bug, clean up and robustify
 sched_read_attr() ABI logic and code
To:     Ingo Molnar <mingo@kernel.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     linux-kernel@vger.kernel.org,
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
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <db065b81-c373-f291-ad48-f556a209cc95@arm.com>
Date:   Wed, 4 Sep 2019 11:31:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904085519.GA127156@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2019 10:55, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
>> +	if (!access_ok(uattr, ksize)
>>  		return -EFAULT;
> 
> How about we pretend that I never sent v2? ;-)
> 
> -v3 attached. Build and minimally boot tested.
> 
> Thanks,
> 
> 	Ingo
> 

This patch fixes the issue (almost).

LTP's sched_getattr01 passes again. But IMHO the prio 'chrt -p $$'
should be 0 instead of -65536.

- tip sched/core (w/ CONFIG_UCLAMP_TASK):

root@juno:/opt/ltp/results# chrt -p $$
chrt: failed to get pid 1635's policy: File too large

Test Start Time: Wed Sep  4 10:17:34 2019
-----------------------------------------
Testcase                                           Result     Exit Value
--------                                           ------     ----------
sched_get_priority_min01                           PASS       0
sched_get_priority_min02                           PASS       0
sched_getparam01                                   PASS       0
sched_getparam02                                   PASS       0
sched_getparam03                                   PASS       0
sched_rr_get_interval01                            PASS       0
sched_rr_get_interval02                            PASS       0
sched_rr_get_interval03                            PASS       0
sched_setparam01                                   PASS       0
sched_setparam02                                   PASS       0
sched_setparam03                                   PASS       0
sched_setparam04                                   PASS       0
sched_setparam05                                   PASS       0
sched_getscheduler01                               PASS       0
sched_getscheduler02                               PASS       0
sched_setscheduler01                               PASS       0
sched_setscheduler02                               PASS       0
sched_setscheduler03                               PASS       0
sched_yield01                                      PASS       0
sched_setaffinity01                                PASS       0
sched_getaffinity01                                PASS       0
sched_setattr01                                    PASS       0
sched_getattr01                                    FAIL       1  <---
sched_getattr02                                    PASS       0

-----------------------------------------------
Total Tests: 24
Total Skipped Tests: 0
Total Failures: 1
Kernel Version: 5.3.0-rc1-00101-g0413d7f33e60
Machine Architecture: aarch64
Hostname: juno

- tip sched/core (w/ CONFIG_UCLAMP_TASK) + patch:

root@juno:~# chrt -p $$
pid 1633's current scheduling policy: SCHED_OTHER
pid 1633's current scheduling priority: -65536    <--- should be 0

Test Start Time: Wed Sep  4 10:22:45 2019
-----------------------------------------
Testcase                                           Result     Exit Value
--------                                           ------     ----------
sched_get_priority_min01                           PASS       0
sched_get_priority_min02                           PASS       0
sched_getparam01                                   PASS       0
sched_getparam02                                   PASS       0
sched_getparam03                                   PASS       0
sched_rr_get_interval01                            PASS       0
sched_rr_get_interval02                            PASS       0
sched_rr_get_interval03                            PASS       0
sched_setparam01                                   PASS       0
sched_setparam02                                   PASS       0
sched_setparam03                                   PASS       0
sched_setparam04                                   PASS       0
sched_setparam05                                   PASS       0
sched_getscheduler01                               PASS       0
sched_getscheduler02                               PASS       0
sched_setscheduler01                               PASS       0
sched_setscheduler02                               PASS       0
sched_setscheduler03                               PASS       0
sched_yield01                                      PASS       0
sched_setaffinity01                                PASS       0
sched_getaffinity01                                PASS       0
sched_setattr01                                    PASS       0
sched_getattr01                                    PASS       0 <---
sched_getattr02                                    PASS       0

-----------------------------------------------
Total Tests: 24
Total Skipped Tests: 0
Total Failures: 0
Kernel Version: 5.3.0-rc1-00102-g80a776a6e3b7
Machine Architecture: aarch64
Hostname: juno
