Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5434BECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2836820640
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570462638;
	bh=jUewCEGbhOMDYXJnjrPZ2FOjYqzS9d3VzyM/APfHGbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AOGNMVZCs4vx9FUG4atk7najNV3eFS2QqE/iXZMUXAcWQ+tggQaik0xt/4yQpkrFQ
	 BYKKOGjir1SQtmbGHSBDjM0Up4fYV74C2fBdzz5GC4J5IgqUFdPUZMvBe/6Cg6jcYj
	 dhfoeI8674JramS8/bys+1hknaNK+HfYj0d2zqv4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfJGPhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:37:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727711AbfJGPhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:37:16 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6BFB20700;
        Mon,  7 Oct 2019 15:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570462635;
        bh=jUewCEGbhOMDYXJnjrPZ2FOjYqzS9d3VzyM/APfHGbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cWVW9kyD/N8d8qYeXchiPkLP/kNzLQpDe1ZvsUok7iAHjRir0d7Y0ZlKNVxE65o3+
         FQPm1pex0tR72QbiyF4X7Z7XO8Rzrsf3oKOPRiwX0CjODU21BbXv+61D/eJOdoZEpv
         sEBFdoFLm+EqRCtxvUjqqKH0w2kYpleNjGl91KSQ=
Date:   Mon, 7 Oct 2019 16:37:10 +0100
From:   Will Deacon <will@kernel.org>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        tglx@linutronix.de, info@metux.net, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: armv8_deprecated: Checking return value for
 memory allocation
Message-ID: <20191007153710.7xpx27kgeewz75kt@willie-the-truck>
References: <bd558d56-18a9-3607-3db0-ad203ab12aa8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd558d56-18a9-3607-3db0-ad203ab12aa8@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 06:06:35PM +0800, Yunfeng Ye wrote:
> There are no return value checking when using kzalloc() and kcalloc() for
> memory allocation. so add it.
> 
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> ---
> v1 -> v2:
>  - return error code when memory allocation failure
> 
>  arch/arm64/kernel/armv8_deprecated.c | 57 +++++++++++++++++++++++++++---------
>  1 file changed, 43 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
> index 2ec09de..2284fcb 100644
> --- a/arch/arm64/kernel/armv8_deprecated.c
> +++ b/arch/arm64/kernel/armv8_deprecated.c
> @@ -168,12 +168,15 @@ static int update_insn_emulation_mode(struct insn_emulation *insn,
>  	return ret;
>  }
> 
> -static void __init register_insn_emulation(struct insn_emulation_ops *ops)
> +static int __init register_insn_emulation(struct insn_emulation_ops *ops)
>  {
>  	unsigned long flags;
>  	struct insn_emulation *insn;
> 
>  	insn = kzalloc(sizeof(*insn), GFP_KERNEL);
> +	if (!insn)
> +		return -ENOMEM;
> +
>  	insn->ops = ops;
>  	insn->min = INSN_UNDEF;
> 
> @@ -197,6 +200,7 @@ static void __init register_insn_emulation(struct insn_emulation_ops *ops)
> 
>  	/* Register any handlers if required */
>  	update_insn_emulation_mode(insn, INSN_UNDEF);
> +	return 0;
>  }
> 
>  static int emulation_proc_handler(struct ctl_table *table, int write,
> @@ -224,7 +228,7 @@ static int emulation_proc_handler(struct ctl_table *table, int write,
>  	return ret;
>  }
> 
> -static void __init register_insn_emulation_sysctl(void)
> +static int __init register_insn_emulation_sysctl(void)
>  {
>  	unsigned long flags;
>  	int i = 0;
> @@ -233,6 +237,8 @@ static void __init register_insn_emulation_sysctl(void)
> 
>  	insns_sysctl = kcalloc(nr_insn_emulated + 1, sizeof(*sysctl),
>  			       GFP_KERNEL);
> +	if (!insns_sysctl)
> +		return -ENOMEM;
> 
>  	raw_spin_lock_irqsave(&insn_emulation_lock, flags);
>  	list_for_each_entry(insn, &insn_emulation, node) {
> @@ -251,6 +257,7 @@ static void __init register_insn_emulation_sysctl(void)
>  	raw_spin_unlock_irqrestore(&insn_emulation_lock, flags);
> 
>  	register_sysctl("abi", insns_sysctl);
> +	return 0;
>  }
> 
>  /*
> @@ -617,25 +624,47 @@ static int t16_setend_handler(struct pt_regs *regs, u32 instr)
>   */
>  static int __init armv8_deprecated_init(void)
>  {
> -	if (IS_ENABLED(CONFIG_SWP_EMULATION))
> -		register_insn_emulation(&swp_ops);
> +	int ret = 0;
> +	int err = 0;
> +
> +	if (IS_ENABLED(CONFIG_SWP_EMULATION)) {
> +		ret = register_insn_emulation(&swp_ops);
> +		if (ret) {
> +			pr_err("register insn emulation swp: fail\n");
> +			err = ret;
> +		}
> +	}

Is there much point in continuing here? May as well just return ret, I
think. I also don't think you need to print anything, since kmalloc
should already have shouted.

> -	if (IS_ENABLED(CONFIG_CP15_BARRIER_EMULATION))
> -		register_insn_emulation(&cp15_barrier_ops);
> +	if (IS_ENABLED(CONFIG_CP15_BARRIER_EMULATION)) {
> +		ret = register_insn_emulation(&cp15_barrier_ops);
> +		if (ret) {
> +			pr_err("register insn emulation cpu15_barrier: fail\n");
> +			err = ret;
> +		}
> +	}
> 
>  	if (IS_ENABLED(CONFIG_SETEND_EMULATION)) {
> -		if(system_supports_mixed_endian_el0())
> -			register_insn_emulation(&setend_ops);
> -		else
> +		if (system_supports_mixed_endian_el0()) {
> +			ret = register_insn_emulation(&setend_ops);
> +			if (ret) {
> +				pr_err("register insn emulation setend: fail\n");
> +				err = ret;
> +			}
> +		} else {
>  			pr_info("setend instruction emulation is not supported on this system\n");
> +		}
>  	}
> 
> -	cpuhp_setup_state_nocalls(CPUHP_AP_ARM64_ISNDEP_STARTING,
> -				  "arm64/isndep:starting",
> -				  run_all_insn_set_hw_mode, NULL);
> -	register_insn_emulation_sysctl();
> +	if (nr_insn_emulated) {
> +		cpuhp_setup_state_nocalls(CPUHP_AP_ARM64_ISNDEP_STARTING,
> +					  "arm64/isndep:starting",
> +					  run_all_insn_set_hw_mode, NULL);
> +		ret = register_insn_emulation_sysctl();
> +		if (ret)
> +			err = ret;
> +	}

I'm dubious about leaving the cpuhp notifier registered if we fail here.
Can we simply reorder the logic so that the notifier is registered after
successfully calling register_insn_emulation_sysctl()?

Will
