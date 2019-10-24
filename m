Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D414CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7070F2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571923156;
	bh=Iq3tIW/M4EU3kskk8A3JDdCS8uVIwkhKDQO89M+kMDk=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=l1YmmWws2Qc6OpQuy9zqxrfGVDyaTOG9GUp9PtsUCFgLB5qtfcgRTY+TCJOK6xtKx
	 TdMZcfix5QTGRNIS2NiI+jo5CV+mM9r4hEvtGqJWkUo/041hS9mhAknZJ5ql+BoU96
	 AuAoic2WzTsn+ApZUu2IhWibg3JgTyAPHrsKldBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502502AbfJXNTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 09:19:15 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:39373 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730061AbfJXNTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 09:19:14 -0400
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iNd1A-0000Sw-Ge; Thu, 24 Oct 2019 15:19:08 +0200
To:     Steven Price <steven.price@arm.com>
Subject: Re: [PATCH] KVM: arm64: Select =?UTF-8?Q?SCHED=5FINFO=20before=20?=  =?UTF-8?Q?SCHEDSTATS?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 24 Oct 2019 14:19:08 +0100
From:   Marc Zyngier <maz@kernel.org>
Cc:     Mao Wenan <maowenan@huawei.com>, <catalin.marinas@arm.com>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <will@kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <6d037fa1-5e8b-38cd-e947-7547c1e8dd15@arm.com>
References: <20191023032254.159510-1-maowenan@huawei.com>
 <26ee413334937b9530bc8f033fe378ec@www.loen.fr>
 <6d037fa1-5e8b-38cd-e947-7547c1e8dd15@arm.com>
Message-ID: <3abfc893613caf529b0f6a933e74068d@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: steven.price@arm.com, maowenan@huawei.com, catalin.marinas@arm.com, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, will@kernel.org, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-24 12:22, Steven Price wrote:

[...]

> From 915893f5c57241cc29d90769b3f720a6135277d7 Mon Sep 17 00:00:00 
> 2001
> From: Steven Price <steven.price@arm.com>
> Date: Thu, 24 Oct 2019 12:14:36 +0100
> Subject: [PATCH] KVM: arm64: Select TASK_DELAY_ACCT rather than 
> SCHEDSTATS
>
> SCHEDSTATS requires DEBUG_KERNEL (and PROC_FS) and therefore isn't a
> good choice for enabling the scheduling statistics required for 
> stolen
> time.
>
> Instead match the x86 configuration and select TASK_DELAY_ACCT. This
> adds the dependencies of NET && MULTIUSER for arm64 KVM.
>
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Fixes: 8564d6372a7d ("KVM: arm64: Support stolen time reporting via
> shared structure")
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  arch/arm64/kvm/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> index d8b88e40d223..1ffb300e2d92 100644
> --- a/arch/arm64/kvm/Kconfig
> +++ b/arch/arm64/kvm/Kconfig
> @@ -21,6 +21,8 @@ if VIRTUALIZATION
>  config KVM
>  	bool "Kernel-based Virtual Machine (KVM) support"
>  	depends on OF
> +	# for TASKSTATS/TASK_DELAY_ACCT:
> +	depends on NET && MULTIUSER
>  	select MMU_NOTIFIER
>  	select PREEMPT_NOTIFIERS
>  	select HAVE_KVM_CPU_RELAX_INTERCEPT
> @@ -39,7 +41,7 @@ config KVM
>  	select IRQ_BYPASS_MANAGER
>  	select HAVE_KVM_IRQ_BYPASS
>  	select HAVE_KVM_VCPU_RUN_PID_CHANGE
> -	select SCHEDSTATS
> +	select TASK_DELAY_ACCT
>  	---help---
>  	  Support hosting virtualized guest machines.
>  	  We don't support KVM with 16K page tables yet, due to the 
> multiple

Same issue as before: you have an implicit config symbol selection.
TASK_DELAY_ACCT depends on TASKSTATS (which is why you have this NET &&
MULTIUSER constraint).

You need to select both TASK_DELAY_ACCT and TASKSTATS, as the comment 
you
add suggests.

         M.
-- 
Jazz is not dead. It just smells funny...
