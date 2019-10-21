Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23500CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 18:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6EEB2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 18:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ys7t+SW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbfJUSrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 14:47:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40524 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJUSrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 14:47:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id 15so2988939pgt.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 11:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4oWcMvAF3AkSdh7Jj7EOsobOZH0CAMgAfdM6Iy8i7tY=;
        b=Ys7t+SW9gBEB82MvPaaEycHtdcBO4kIjr1l9wHD/NjJ+GMUiIHDypGSeaugD98W3D2
         3ozejRwgsJXfG9OnLTt52MC6j2k2BYHBBdoMo/ONXrMzTJXovHZbiN/RtHabO2cOlkSQ
         BDFedaOUgu7Y71rAftwiqyOwu5Ws/52l9YAL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4oWcMvAF3AkSdh7Jj7EOsobOZH0CAMgAfdM6Iy8i7tY=;
        b=ew6Rhe/AwlY3unKL8x+d9PdBNHFdOPd0rEaeLyStDvG5ztAO8yvgL0ZDEPatJpxrCY
         poi60ugknf9jnUwMB+8uucjp3x6hXcyole+btA5QIGSnxaN/g3Mg9TH2aDqUiAuUM4u5
         dNF/8LzJ0WruuRFvENmdY77g9yGZXvV1nL+RJ+vciwaA2FAlK9KGOcQUTegbubFgY90i
         JsMspBPr/CjHOpUDc6jNc/v/7z0NA6nhc6fbSD2gDEHkDrAQ8Y9Ci/Ftd62MJv50S41f
         9Amzu80ZwP9FusqRvRIUrw0Wxr7DtBKKarOw5Gix4X3dLuDE0EBxiz7dKiB+PxJtHk/X
         J8qg==
X-Gm-Message-State: APjAAAXpgay60U+UyiMAsgMmJTCCODJ+WahCZ2XNiXOkujQmV7eR2Gmn
        jQmJZXqPjEy2d8iVd07bvofpqw==
X-Google-Smtp-Source: APXvYqzDaJOYNm1B1ci5HNl8Uvds7odpyEAMRkOJ1JiIJEDNp9dyTbfunHlypCqMzsTclpmlGVSdyw==
X-Received: by 2002:aa7:90da:: with SMTP id k26mr25459478pfk.141.1571683622376;
        Mon, 21 Oct 2019 11:47:02 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id x12sm15460021pfm.130.2019.10.21.11.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 11:47:01 -0700 (PDT)
Date:   Mon, 21 Oct 2019 11:46:58 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Pavel Labath <labath@google.com>,
        Pratyush Anand <panand@redhat.com>, kinaba@google.com,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: hw_breakpoint: Handle inexact watchpoint addresses
Message-ID: <20191021184658.GE20212@google.com>
References: <20191019111216.1.I82eae759ca6dc28a245b043f485ca490e3015321@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191019111216.1.I82eae759ca6dc28a245b043f485ca490e3015321@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2019 at 11:12:26AM -0700, Douglas Anderson wrote:
> This is commit fdfeff0f9e3d ("arm64: hw_breakpoint: Handle inexact
> watchpoint addresses") but ported to arm32, which has the same
> problem.
> 
> This problem was found by Android CTS tests, notably the
> "watchpoint_imprecise" test [1].  I tested locally against a copycat
> (simplified) version of the test though.
> 
> [1] https://android.googlesource.com/platform/bionic/+/master/tests/sys_ptrace_test.cpp
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  arch/arm/kernel/hw_breakpoint.c | 96 ++++++++++++++++++++++++---------
>  1 file changed, 70 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
> index b0c195e3a06d..d394878409db 100644
> --- a/arch/arm/kernel/hw_breakpoint.c
> +++ b/arch/arm/kernel/hw_breakpoint.c
> @@ -680,26 +680,62 @@ static void disable_single_step(struct perf_event *bp)
>  	arch_install_hw_breakpoint(bp);
>  }
>  
> +/*
> + * Arm32 hardware does not always report a watchpoint hit address that matches
> + * one of the watchpoints set. It can also report an address "near" the
> + * watchpoint if a single instruction access both watched and unwatched
> + * addresses. There is no straight-forward way, short of disassembling the
> + * offending instruction, to map that address back to the watchpoint. This
> + * function computes the distance of the memory access from the watchpoint as a
> + * heuristic for the likelyhood that a given access triggered the watchpoint.
> + *
> + * See this same function in the arm64 platform code, which has the same
> + * problem.
> + *
> + * The function returns the distance of the address from the bytes watched by
> + * the watchpoint. In case of an exact match, it returns 0.
> + */
> +static u32 get_distance_from_watchpoint(unsigned long addr, u32 val,
> +					struct arch_hw_breakpoint_ctrl *ctrl)
> +{
> +	u32 wp_low, wp_high;
> +	u32 lens, lene;
> +
> +	lens = __ffs(ctrl->len);

Doesn't this always end up with 'lens == 0'? IIUC ctrl->len can have
the values ARM_BREAKPOINT_LEN_{1,2,4,8}:

#define ARM_BREAKPOINT_LEN_1	0x1
#define ARM_BREAKPOINT_LEN_2	0x3
#define ARM_BREAKPOINT_LEN_4	0xf
#define ARM_BREAKPOINT_LEN_8	0xff

> +	lene = __fls(ctrl->len);
> +
> +	wp_low = val + lens;
> +	wp_high = val + lene;

First I thought these values are off by one, but in difference to
ffs() from glibc the kernel functions start with index 0, instead
of using zero as 'no bit set'.

> +	if (addr < wp_low)
> +		return wp_low - addr;
> +	else if (addr > wp_high)
> +		return addr - wp_high;
> +	else
> +		return 0;
> +}
> +
>  static void watchpoint_handler(unsigned long addr, unsigned int fsr,
>  			       struct pt_regs *regs)
>  {
> -	int i, access;
> -	u32 val, ctrl_reg, alignment_mask;
> +	int i, access, closest_match = 0;
> +	u32 min_dist = -1, dist;
> +	u32 val, ctrl_reg;
>  	struct perf_event *wp, **slots;
>  	struct arch_hw_breakpoint *info;
>  	struct arch_hw_breakpoint_ctrl ctrl;
>  
>  	slots = this_cpu_ptr(wp_on_reg);
>  
> +	/*
> +	 * Find all watchpoints that match the reported address. If no exact
> +	 * match is found. Attribute the hit to the closest watchpoint.
> +	 */
> +	rcu_read_lock();
>  	for (i = 0; i < core_num_wrps; ++i) {
> -		rcu_read_lock();
> -
>  		wp = slots[i];
> -
>  		if (wp == NULL)
> -			goto unlock;
> +			continue;
>  
> -		info = counter_arch_bp(wp);
>  		/*
>  		 * The DFAR is an unknown value on debug architectures prior
>  		 * to 7.1. Since we only allow a single watchpoint on these
> @@ -708,33 +744,31 @@ static void watchpoint_handler(unsigned long addr, unsigned int fsr,
>  		 */
>  		if (debug_arch < ARM_DEBUG_ARCH_V7_1) {
>  			BUG_ON(i > 0);
> +			info = counter_arch_bp(wp);
>  			info->trigger = wp->attr.bp_addr;
>  		} else {
> -			if (info->ctrl.len == ARM_BREAKPOINT_LEN_8)
> -				alignment_mask = 0x7;
> -			else
> -				alignment_mask = 0x3;
> -
> -			/* Check if the watchpoint value matches. */
> -			val = read_wb_reg(ARM_BASE_WVR + i);
> -			if (val != (addr & ~alignment_mask))
> -				goto unlock;
> -
> -			/* Possible match, check the byte address select. */
> -			ctrl_reg = read_wb_reg(ARM_BASE_WCR + i);
> -			decode_ctrl_reg(ctrl_reg, &ctrl);
> -			if (!((1 << (addr & alignment_mask)) & ctrl.len))
> -				goto unlock;
> -
>  			/* Check that the access type matches. */
>  			if (debug_exception_updates_fsr()) {
>  				access = (fsr & ARM_FSR_ACCESS_MASK) ?
>  					  HW_BREAKPOINT_W : HW_BREAKPOINT_R;
>  				if (!(access & hw_breakpoint_type(wp)))
> -					goto unlock;
> +					continue;
>  			}
>  
> +			val = read_wb_reg(ARM_BASE_WVR + i);
> +			ctrl_reg = read_wb_reg(ARM_BASE_WCR + i);
> +			decode_ctrl_reg(ctrl_reg, &ctrl);
> +			dist = get_distance_from_watchpoint(addr, val, &ctrl);
> +			if (dist < min_dist) {
> +				min_dist = dist;
> +				closest_match = i;
> +			}
> +			/* Is this an exact match? */
> +			if (dist != 0)
> +				continue;
> +
>  			/* We have a winner. */
> +			info = counter_arch_bp(wp);
>  			info->trigger = addr;

Unless we care about using the 'last' watchpoint in case multiple WPs have
the same address I think it would be clearer to change the above to:

	       	       	if (dist == 0) {
				/* We have a winner. */
				info = counter_arch_bp(wp);
				info->trigger = addr;
				break;
			}

>  		}
>  
> @@ -748,10 +782,20 @@ static void watchpoint_handler(unsigned long addr, unsigned int fsr,
>  		 */
>  		if (is_default_overflow_handler(wp))
>  			enable_single_step(wp, instruction_pointer(regs));
> +	}
>  
> -unlock:
> -		rcu_read_unlock();
> +	if (min_dist > 0 && min_dist != -1) {
> +		/* No exact match found. */
> +		wp = slots[closest_match];
> +		info = counter_arch_bp(wp);
> +		info->trigger = addr;
> +		pr_debug("watchpoint fired: address = 0x%x\n", info->trigger);
> +		perf_bp_event(wp, regs);
> +		if (is_default_overflow_handler(wp))
> +			enable_single_step(wp, instruction_pointer(regs));
>  	}
> +
> +	rcu_read_unlock();
>  }
>  
>  static void watchpoint_single_step_handler(unsigned long pc)
> -- 
> 2.23.0.866.gb869b98d4c-goog
> 
