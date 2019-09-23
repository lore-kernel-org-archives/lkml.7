Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B93C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E283220820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732168AbfIWPnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 11:43:17 -0400
Received: from foss.arm.com ([217.140.110.172]:44222 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbfIWPnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 11:43:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B75F91000;
        Mon, 23 Sep 2019 08:43:16 -0700 (PDT)
Received: from [10.10.156.175] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D60873F67D;
        Mon, 23 Sep 2019 08:43:15 -0700 (PDT)
Subject: Re: [PATCH] sched: fix migration to invalid cpu in
 __set_cpus_allowed_ptr
To:     Valentin Schneider <valentin.schneider@arm.com>,
        shikemeng <shikemeng@huawei.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
References: <979d57f8-802b-57e5-632a-f94ad0f9d6a1@arm.com>
 <1568535662-14956-1-git-send-email-shikemeng@huawei.com>
 <5dfd4844-6c36-3b8d-203b-564d7ad7103d@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <40680310-60b3-589a-d0e8-b4dd723db10a@arm.com>
Date:   Mon, 23 Sep 2019 17:43:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5dfd4844-6c36-3b8d-203b-564d7ad7103d@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/19 4:33 PM, Valentin Schneider wrote:
> On 15/09/2019 09:21, shikemeng wrote:
>>> It's more thoughtful to add check in cpumask_test_cpu.It can solve this problem and can prevent other potential bugs.I will test it and resend
>>> a new patch.
>>>
>>
>> Think again and again. As cpumask_check will fire a warning if cpu >= nr_cpu_ids, it seems that cpumask_check only expects cpu < nr_cpu_ids and it's
>> caller's responsibility to very cpu is in valid range. Interfaces like cpumask_test_and_set_cpu, cpumask_test_and_clear_cpu and so on are not checking
>> cpu < nr_cpu_ids either and may cause demage if cpu is out of range.
>>
> 
> cpumask operations clearly should never be fed CPU numbers > nr_cpu_ids,
> but we can get some sneaky mishaps like the one you're fixing. The answer
> might just be to have more folks turn on DEBUG_PER_CPU_MAPS in their test
> runs (I don't for instance - will do from now on), since I get the feeling
> people like to be able to disable these checks for producty kernels.
> 
> In any case, don't feel like you have to fix this globally - your fix is
> fine on its own.

I'm not sure that CONFIG_DEBUG_PER_CPU_MAPS=y will help you here.

__set_cpus_allowed_ptr(...)
{
    ...
    dest_cpu = cpumask_any_and(...)
    ...
}

With:

#define cpumask_any_and(mask1, mask2) cpumask_first_and((mask1), (mask2))
#define cpumask_first_and(src1p, src2p) cpumask_next_and(-1, (src1p),
(src2p))

cpumask_next_and() is called with n = -1 and in this case does not
invoke cpumask_check().

---

BTW, I can recreate the issue quite easily with:

  qemu-system-x86_64 ... -smp cores=64 ... -enable-kvm

with the default kernel config.



