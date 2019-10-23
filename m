Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C741CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F274421906
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571849485;
	bh=RZxcIYOjmht0mENnjgaWfmezYv+FrmD90Iv+qhujZPk=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=PWBi2yQdxUYFGbj3I4jiD2bLkm23sxQrt5yqlFIvsUHzLcFQ5xOK7Y/1Prsc29xPT
	 sYh1F4O9q+1lxeyA9TTA/PvHyXCPz+VEda1nKV0O0fMBeADZgTaUfeeidQtTAAlsVn
	 bQcWU28DrBCW6QeEuLGygB958l+6sUom/ECTH3cU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfJWQvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 12:51:23 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:49694 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726360AbfJWQvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:51:23 -0400
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iNJqs-0006Um-Q5; Wed, 23 Oct 2019 18:51:14 +0200
To:     Mao Wenan <maowenan@huawei.com>, <steven.price@arm.com>
Subject: Re: [PATCH] KVM: arm64: Select =?UTF-8?Q?SCHED=5FINFO=20before=20?=  =?UTF-8?Q?SCHEDSTATS?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 23 Oct 2019 17:51:14 +0100
From:   Marc Zyngier <maz@kernel.org>
Cc:     <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
        <suzuki.poulose@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
In-Reply-To: <20191023032254.159510-1-maowenan@huawei.com>
References: <20191023032254.159510-1-maowenan@huawei.com>
Message-ID: <26ee413334937b9530bc8f033fe378ec@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: maowenan@huawei.com, steven.price@arm.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-23 04:22, Mao Wenan wrote:
> If KVM=y, it will select SCHEDSTATS, below erros can
> be seen:
> kernel/sched/stats.h: In function rq_sched_info_arrive:
> kernel/sched/stats.h:12:20: error: struct sched_info
> has no member named run_delay
>    rq->rq_sched_info.run_delay += delta;
>                     ^
> kernel/sched/stats.h:13:20: error: struct sched_info
> has no member named pcount
>    rq->rq_sched_info.pcount++;
>                     ^
> kernel/sched/stats.h: In function rq_sched_info_dequeued:
> kernel/sched/stats.h:31:20: error: struct sched_info has
> no member named run_delay
>    rq->rq_sched_info.run_delay += delta;
>
> These are because CONFIG_SCHED_INFO is not set, This patch
> is to select SCHED_INFO before SCHEDSTATS.
>
> Fixes: 8564d6372a7d ("KVM: arm64: Support stolen time reporting via
> shared structure")
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>  arch/arm64/kvm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> index d8b88e4..3c46eac 100644
> --- a/arch/arm64/kvm/Kconfig
> +++ b/arch/arm64/kvm/Kconfig
> @@ -39,6 +39,7 @@ config KVM
>  	select IRQ_BYPASS_MANAGER
>  	select HAVE_KVM_IRQ_BYPASS
>  	select HAVE_KVM_VCPU_RUN_PID_CHANGE
> +	select SCHED_INFO
>  	select SCHEDSTATS
>  	---help---
>  	  Support hosting virtualized guest machines.

SCHEDSTATS is really an odd choice. Here's what I get after disabling
DEBUG_KERNEL (from defconfig):

WARNING: unmet direct dependencies detected for SCHEDSTATS
   Depends on [n]: DEBUG_KERNEL [=n] && PROC_FS [=y]
   Selected by [y]:
   - KVM [=y] && VIRTUALIZATION [=y] && OF [=y]

WARNING: unmet direct dependencies detected for SCHEDSTATS
   Depends on [n]: DEBUG_KERNEL [=n] && PROC_FS [=y]
   Selected by [y]:
   - KVM [=y] && VIRTUALIZATION [=y] && OF [=y]

WARNING: unmet direct dependencies detected for SCHEDSTATS
   Depends on [n]: DEBUG_KERNEL [=n] && PROC_FS [=y]
   Selected by [y]:
   - KVM [=y] && VIRTUALIZATION [=y] && OF [=y]

So clearly SCHEDSTATS isn't meant to be selected on its own.

We can either just select SCHED_INFO (which *nobody else does*), or go
the full x86 way which selects TASK_DELAY_ACCT (and thus depends on
NET && MULTIUSER). My gut feeling is that we shouldn't deviate too much
from x86...

Thoughts?

         M.
-- 
Jazz is not dead. It just smells funny...
