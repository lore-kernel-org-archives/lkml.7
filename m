Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C608C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1695520652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbfDXNRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:17:25 -0400
Received: from foss.arm.com ([217.140.101.70]:43292 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbfDXNRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:17:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8754780D;
        Wed, 24 Apr 2019 06:17:24 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81DB23F238;
        Wed, 24 Apr 2019 06:17:22 -0700 (PDT)
Date:   Wed, 24 Apr 2019 14:17:20 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Julien Grall <julien.grall@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ard.biesheuvel@linaro.org, julien.thierry@arm.com,
        marc.zyngier@arm.com, catalin.marinas@arm.com,
        suzuki.poulose@arm.com, will.deacon@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com
Subject: Re: [PATCH v3 2/3] arch/arm64: fpsimd: Introduce
 fpsimd_save_and_flush_cpu_state() and use it
Message-ID: <20190424131719.GS3567@e103592.cambridge.arm.com>
References: <20190423135719.11306-1-julien.grall@arm.com>
 <20190423135719.11306-3-julien.grall@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423135719.11306-3-julien.grall@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 02:57:18PM +0100, Julien Grall wrote:
> tent-Length: 4295
> Lines: 128
> 
> The only external user of fpsimd_save() and fpsimd_flush_cpu_state() is
> the KVM FPSIMD code.
> 
> A following patch will introduce a mechanism to acquire owernship of the
> FPSIMD/SVE context for performing context management operations. Rather
> than having to export the new helpers to get/put the context, we can just
> introduce a new function to combine fpsimd_save() and
> fpsimd_flush_cpu_state().
> 
> This has also the advantage to remove any external call of fpsimd_save()
> and fpsimd_flush_cpu_state(), so they can be turned static.
> 
> Lastly, the new function can also be used in the PM notifier.
> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> 
> ---
>     kernel_neon_begin() does not use fpsimd_save_and_flush_cpu_state()
>     because the next patch will modify the function to also grab the
>     FPSIMD/SVE context.
> 
>     Changes in v3:
>         - Rework the commit message
>         - Move the prototype of fpsimd_save_and_flush_cpu_state()
>         further down in the header
>         - Remove comment in kvm_arch_vcpu_put_fp()
> 
>     Changes in v2:
>         - Patch added
> ---
>  arch/arm64/include/asm/fpsimd.h |  5 ++---
>  arch/arm64/kernel/fpsimd.c      | 17 +++++++++++++----
>  arch/arm64/kvm/fpsimd.c         |  4 +---
>  3 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
> index b73d12fcc7f9..c311d36ecffe 100644
> --- a/arch/arm64/include/asm/fpsimd.h
> +++ b/arch/arm64/include/asm/fpsimd.h
> @@ -48,8 +48,6 @@ struct task_struct;
>  extern void fpsimd_save_state(struct user_fpsimd_state *state);
>  extern void fpsimd_load_state(struct user_fpsimd_state *state);
>  
> -extern void fpsimd_save(void);
> -
>  extern void fpsimd_thread_switch(struct task_struct *next);
>  extern void fpsimd_flush_thread(void);
>  
> @@ -63,7 +61,8 @@ extern void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *state,
>  				     void *sve_state, unsigned int sve_vl);
>  
>  extern void fpsimd_flush_task_state(struct task_struct *target);
> -extern void fpsimd_flush_cpu_state(void);
> +
> +extern void fpsimd_save_and_flush_cpu_state(void);

Nit: You could drop this blank line: these are all "state maintenance"
operations, roughly speaking.

But don't bother unless you respin for some other reason.

[...]

With or without that,

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

Cheers
---Dave
