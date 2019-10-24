Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77D7CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A67E320856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393442AbfJXLW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 07:22:26 -0400
Received: from foss.arm.com ([217.140.110.172]:48200 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393360AbfJXLW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 07:22:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85B66B57;
        Thu, 24 Oct 2019 04:22:10 -0700 (PDT)
Received: from [10.1.194.43] (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7790D3F71A;
        Thu, 24 Oct 2019 04:22:09 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
Subject: Re: [PATCH] KVM: arm64: Select SCHED_INFO before SCHEDSTATS
To:     Marc Zyngier <maz@kernel.org>, Mao Wenan <maowenan@huawei.com>
Cc:     catalin.marinas@arm.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
References: <20191023032254.159510-1-maowenan@huawei.com>
 <26ee413334937b9530bc8f033fe378ec@www.loen.fr>
Message-ID: <6d037fa1-5e8b-38cd-e947-7547c1e8dd15@arm.com>
Date:   Thu, 24 Oct 2019 12:22:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <26ee413334937b9530bc8f033fe378ec@www.loen.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/2019 17:51, Marc Zyngier wrote:
> On 2019-10-23 04:22, Mao Wenan wrote:
>> If KVM=y, it will select SCHEDSTATS, below erros can
>> be seen:
>> kernel/sched/stats.h: In function rq_sched_info_arrive:
>> kernel/sched/stats.h:12:20: error: struct sched_info
>> has no member named run_delay
>>    rq->rq_sched_info.run_delay += delta;
>>                     ^
>> kernel/sched/stats.h:13:20: error: struct sched_info
>> has no member named pcount
>>    rq->rq_sched_info.pcount++;
>>                     ^
>> kernel/sched/stats.h: In function rq_sched_info_dequeued:
>> kernel/sched/stats.h:31:20: error: struct sched_info has
>> no member named run_delay
>>    rq->rq_sched_info.run_delay += delta;
>>
>> These are because CONFIG_SCHED_INFO is not set, This patch
>> is to select SCHED_INFO before SCHEDSTATS.
>>
>> Fixes: 8564d6372a7d ("KVM: arm64: Support stolen time reporting via
>> shared structure")
>> Signed-off-by: Mao Wenan <maowenan@huawei.com>
>> ---
>>  arch/arm64/kvm/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
>> index d8b88e4..3c46eac 100644
>> --- a/arch/arm64/kvm/Kconfig
>> +++ b/arch/arm64/kvm/Kconfig
>> @@ -39,6 +39,7 @@ config KVM
>>      select IRQ_BYPASS_MANAGER
>>      select HAVE_KVM_IRQ_BYPASS
>>      select HAVE_KVM_VCPU_RUN_PID_CHANGE
>> +    select SCHED_INFO
>>      select SCHEDSTATS
>>      ---help---
>>        Support hosting virtualized guest machines.
> 
> SCHEDSTATS is really an odd choice. Here's what I get after disabling
> DEBUG_KERNEL (from defconfig):
> 
> WARNING: unmet direct dependencies detected for SCHEDSTATS
>   Depends on [n]: DEBUG_KERNEL [=n] && PROC_FS [=y]
>   Selected by [y]:
>   - KVM [=y] && VIRTUALIZATION [=y] && OF [=y]
> 
> WARNING: unmet direct dependencies detected for SCHEDSTATS
>   Depends on [n]: DEBUG_KERNEL [=n] && PROC_FS [=y]
>   Selected by [y]:
>   - KVM [=y] && VIRTUALIZATION [=y] && OF [=y]
> 
> WARNING: unmet direct dependencies detected for SCHEDSTATS
>   Depends on [n]: DEBUG_KERNEL [=n] && PROC_FS [=y]
>   Selected by [y]:
>   - KVM [=y] && VIRTUALIZATION [=y] && OF [=y]
> 
> So clearly SCHEDSTATS isn't meant to be selected on its own.
> 
> We can either just select SCHED_INFO (which *nobody else does*), or go
> the full x86 way which selects TASK_DELAY_ACCT (and thus depends on
> NET && MULTIUSER). My gut feeling is that we shouldn't deviate too much
> from x86...
> 
> Thoughts?

I suspect you're right - TASK_DELAY_ACCT seems to be the closest to what
we need. SCHEDSTATS has the "advantage" of forcing sched_info_on() to
return true - preventing it from being disabled. But we clearly don't
want to require CONFIG_DEBUG_KERNEL for CONFIG_KVM.

The next best is CONFIG_TASK_DELAY_ACCT which enables sched_info_on()
unless "nodelayacct" is specified on the cmdline. It seems reasonable
that the cmdline option might break stolen time.

So let's just copy x86:

-----8<-----
From 915893f5c57241cc29d90769b3f720a6135277d7 Mon Sep 17 00:00:00 2001
From: Steven Price <steven.price@arm.com>
Date: Thu, 24 Oct 2019 12:14:36 +0100
Subject: [PATCH] KVM: arm64: Select TASK_DELAY_ACCT rather than SCHEDSTATS

SCHEDSTATS requires DEBUG_KERNEL (and PROC_FS) and therefore isn't a
good choice for enabling the scheduling statistics required for stolen
time.

Instead match the x86 configuration and select TASK_DELAY_ACCT. This
adds the dependencies of NET && MULTIUSER for arm64 KVM.

Suggested-by: Marc Zyngier <maz@kernel.org>
Fixes: 8564d6372a7d ("KVM: arm64: Support stolen time reporting via shared structure")
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/kvm/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index d8b88e40d223..1ffb300e2d92 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -21,6 +21,8 @@ if VIRTUALIZATION
 config KVM
 	bool "Kernel-based Virtual Machine (KVM) support"
 	depends on OF
+	# for TASKSTATS/TASK_DELAY_ACCT:
+	depends on NET && MULTIUSER
 	select MMU_NOTIFIER
 	select PREEMPT_NOTIFIERS
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
@@ -39,7 +41,7 @@ config KVM
 	select IRQ_BYPASS_MANAGER
 	select HAVE_KVM_IRQ_BYPASS
 	select HAVE_KVM_VCPU_RUN_PID_CHANGE
-	select SCHEDSTATS
+	select TASK_DELAY_ACCT
 	---help---
 	  Support hosting virtualized guest machines.
 	  We don't support KVM with 16K page tables yet, due to the multiple
-- 
2.20.1

