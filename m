Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD77C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 14:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96A92064A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 14:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409706AbfIXOKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 10:10:06 -0400
Received: from foss.arm.com ([217.140.110.172]:59814 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730778AbfIXOKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 10:10:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B747337;
        Tue, 24 Sep 2019 07:10:05 -0700 (PDT)
Received: from [192.168.1.50] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A79B13F59C;
        Tue, 24 Sep 2019 07:10:01 -0700 (PDT)
Subject: Re: [PATCH] sched: fix migration to invalid cpu in
 __set_cpus_allowed_ptr
To:     Valentin Schneider <valentin.schneider@arm.com>,
        shikemeng <shikemeng@huawei.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
References: <979d57f8-802b-57e5-632a-f94ad0f9d6a1@arm.com>
 <1568535662-14956-1-git-send-email-shikemeng@huawei.com>
 <5dfd4844-6c36-3b8d-203b-564d7ad7103d@arm.com>
 <40680310-60b3-589a-d0e8-b4dd723db10a@arm.com>
 <1d8e6aab-5258-494c-c4cd-1802eda34d59@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <706581c9-e4ee-967d-b010-4798afd2245e@arm.com>
Date:   Tue, 24 Sep 2019 16:09:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1d8e6aab-5258-494c-c4cd-1802eda34d59@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/19 6:06 PM, Valentin Schneider wrote:
> On 23/09/2019 16:43, Dietmar Eggemann wrote:
>> I'm not sure that CONFIG_DEBUG_PER_CPU_MAPS=y will help you here.
>>
>> __set_cpus_allowed_ptr(...)
>> {
>>     ...
>>     dest_cpu = cpumask_any_and(...)
>>     ...
>> }
>>
>> With:
>>
>> #define cpumask_any_and(mask1, mask2) cpumask_first_and((mask1), (mask2))
>> #define cpumask_first_and(src1p, src2p) cpumask_next_and(-1, (src1p),
>> (src2p))
>>
>> cpumask_next_and() is called with n = -1 and in this case does not
>> invoke cpumask_check().
>>
> 
> It won't warn here because it's still a valid return value, but it should
> warn in the cpumask_test_cpu() that follows (in is_cpu_allowed()) because
> it would be passed a value >= nr_cpu_ids. So at the very least this config
> does catch cpumask_any*() return values being blindly passed to
> cpumask_test_cpu().

OK, I see and agree.

But IMHO, we still don't call cpumask_test_cpu(dest_cpu, ...), right.

What the patch fixes is that it closes the window between two reads of
cpu_active_mask in which cpuhp can potentially punch a hole into the
cpu_active_mask.

If p is not running or queued and it's state is unequal to TASK_WAKING,
a 'dest_cpu == nr_cpu_ids' goes unnoticed. Otherwise we see an 'unable
to handle kernel paging request' or 'unable to handle page fault for
address' bug in migration_cpu_stop() or move_queued_task().

Do I miss something?

[...]

