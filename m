Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A06AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C123F20850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xZePBIBu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfCSNBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:01:10 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40124 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfCSNBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ddy2WtQjgYNYvlRtEtUeNHpMGpWAASMzDUFHIhfDZ5A=; b=xZePBIBu/Yjo+7rFBtRYbo0kg
        3SVeXDlIckV1hyl6aauroj5Fz/mjTq/3tbz71WkhapMXeyuhGg5nb6+mmmzfyHEXolj8/vonFejgH
        xWew3A4FIr6PUNh34jCirrmhIcv1XJBETwUf1x5l8PpRh2yQBwYlDk6cLxcue/2EhN1s4Z7CIZpi0
        zUqsdLq3V9io97K9AgEaqtFGaBDUiAog26O/FHQ9OI32M8GHDoVbJv9XOpHBiZdWOgvWPYsW7PADq
        AFb6NmLKl2hA09U5KMeapNrtSWe6x8kj//oC4RfdHXEHGfEupWbG+CKtPIWcK3CNX6bEbFcuWTx12
        t0ilumd8w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6EMH-0000cX-DL; Tue, 19 Mar 2019 13:00:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9FD7C23E8CA32; Tue, 19 Mar 2019 14:00:04 +0100 (CET)
Date:   Tue, 19 Mar 2019 14:00:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH 01/22] perf/core: Support outputting registers from a
 separate array
Message-ID: <20190319130004.GF5996@hirez.programming.kicks-ass.net>
References: <20190318214144.4639-1-kan.liang@linux.intel.com>
 <20190318214144.4639-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318214144.4639-2-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 02:41:23PM -0700, kan.liang@linux.intel.com wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Add support to the perf core for outputting registers from a separate
> array and add support for outputting XMM registers for x86.

What separate array and why?

> This requires changing all the perf_reg_value functions for the
> different architectures to pass the additional argument.

What additional argument? (basically a dangling reference here)

> Except for x86, they just ignore it.
> 
> XMM registers are 128 bit. To simplify the code, they are handled like
> two different registers, which means setting two bits in the register
> bitmap. This also allows only sampling the lower 64bit bits in XMM.

So that is at least 2 changes in one patch; I though there was a rule
about that.

> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---

> diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
> index f3329cabce5c..1ff0df1c97ae 100644
> --- a/arch/x86/include/uapi/asm/perf_regs.h
> +++ b/arch/x86/include/uapi/asm/perf_regs.h
> @@ -28,7 +28,28 @@ enum perf_event_x86_regs {
>  	PERF_REG_X86_R14,
>  	PERF_REG_X86_R15,
>  
> -	PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
> -	PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,
> +	/* These all need two bits set because they are 128bit */
> +	PERF_REG_X86_XMM0  = 32,
> +	PERF_REG_X86_XMM1  = 34,
> +	PERF_REG_X86_XMM2  = 36,
> +	PERF_REG_X86_XMM3  = 38,
> +	PERF_REG_X86_XMM4  = 40,
> +	PERF_REG_X86_XMM5  = 42,
> +	PERF_REG_X86_XMM6  = 44,
> +	PERF_REG_X86_XMM7  = 46,
> +	PERF_REG_X86_XMM8  = 48,
> +	PERF_REG_X86_XMM9  = 50,
> +	PERF_REG_X86_XMM10 = 52,
> +	PERF_REG_X86_XMM11 = 54,
> +	PERF_REG_X86_XMM12 = 56,
> +	PERF_REG_X86_XMM13 = 58,
> +	PERF_REG_X86_XMM14 = 60,
> +	PERF_REG_X86_XMM15 = 62,
> +
> +	/* This does not include the XMMX registers */
> +	PERF_REG_GPR_X86_32_MAX = PERF_REG_X86_GS + 1,
> +	PERF_REG_GPR_X86_64_MAX = PERF_REG_X86_R15 + 1,
> +
> +	PERF_REG_X86_MAX = PERF_REG_X86_XMM15 + 2,

This needs explaining in both the Changelog and a comment.

>  };
>  #endif /* _ASM_X86_PERF_REGS_H */
> diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
> index c06c4c16c6b6..8b44a4c5a161 100644
> --- a/arch/x86/kernel/perf_regs.c
> +++ b/arch/x86/kernel/perf_regs.c
> @@ -10,14 +10,14 @@
>  #include <asm/ptrace.h>
>  
>  #ifdef CONFIG_X86_32
> -#define PERF_REG_X86_MAX PERF_REG_X86_32_MAX
> +#define PERF_REG_GPR_X86_MAX PERF_REG_GPR_X86_32_MAX
>  #else
> -#define PERF_REG_X86_MAX PERF_REG_X86_64_MAX
> +#define PERF_REG_GPR_X86_MAX PERF_REG_GPR_X86_64_MAX
>  #endif
>  
>  #define PT_REGS_OFFSET(id, r) [id] = offsetof(struct pt_regs, r)
>  
> -static unsigned int pt_regs_offset[PERF_REG_X86_MAX] = {
> +static unsigned int pt_regs_offset[PERF_REG_GPR_X86_MAX] = {
>  	PT_REGS_OFFSET(PERF_REG_X86_AX, ax),
>  	PT_REGS_OFFSET(PERF_REG_X86_BX, bx),
>  	PT_REGS_OFFSET(PERF_REG_X86_CX, cx),
> @@ -57,15 +57,22 @@ static unsigned int pt_regs_offset[PERF_REG_X86_MAX] = {
>  #endif
>  };
>  
> -u64 perf_reg_value(struct pt_regs *regs, int idx)
> +u64 perf_reg_value(struct pt_regs *regs, u64 *extra_regs, int idx)
>  {
> +	if (idx >= 32 && idx < 64) {
> +		if (!extra_regs)
> +			return 0;
> +		return extra_regs[idx - 32];
> +	}
> +
>  	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(pt_regs_offset)))
>  		return 0;
>  
>  	return regs_get_register(regs, pt_regs_offset[idx]);
>  }
>  
> -#define REG_RESERVED (~((1ULL << PERF_REG_X86_MAX) - 1ULL))
> +#define REG_RESERVED \
> +	(PERF_REG_X86_MAX == 64 ? 0 : ~((1ULL << PERF_REG_X86_MAX)) - 1ULL)
>  
>  #ifdef CONFIG_X86_32
>  int perf_reg_validate(u64 mask)
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index e47ef764f613..bd3d6a89ccd4 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -948,6 +948,7 @@ struct perf_sample_data {
>  	u64				stack_user_size;
>  
>  	u64				phys_addr;
> +	u64				*extra_regs;
>  } ____cacheline_aligned;
>  
>  /* default value for data source */
> @@ -968,6 +969,7 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
>  	data->weight = 0;
>  	data->data_src.val = PERF_MEM_NA;
>  	data->txn = 0;
> +	data->extra_regs = NULL;
>  }

NAK, why do I have to keep explaining this?


> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 5f59d848171e..560ac237b8be 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5858,7 +5858,8 @@ EXPORT_SYMBOL_GPL(perf_unregister_guest_info_callbacks);
>  
>  static void
>  perf_output_sample_regs(struct perf_output_handle *handle,
> -			struct pt_regs *regs, u64 mask)
> +			struct pt_regs *regs,
> +			u64 *extra_regs, u64 mask)
>  {
>  	int bit;
>  	DECLARE_BITMAP(_mask, 64);
> @@ -5867,7 +5868,7 @@ perf_output_sample_regs(struct perf_output_handle *handle,
>  	for_each_set_bit(bit, _mask, sizeof(mask) * BITS_PER_BYTE) {
>  		u64 val;
>  
> -		val = perf_reg_value(regs, bit);
> +		val = perf_reg_value(regs, extra_regs, bit);
>  		perf_output_put(handle, val);
>  	}
>  }
> @@ -6274,6 +6275,7 @@ void perf_output_sample(struct perf_output_handle *handle,
>  			u64 mask = event->attr.sample_regs_user;
>  			perf_output_sample_regs(handle,
>  						data->regs_user.regs,
> +						NULL,
>  						mask);
>  		}
>  	}
> @@ -6306,6 +6308,7 @@ void perf_output_sample(struct perf_output_handle *handle,
>  
>  			perf_output_sample_regs(handle,
>  						data->regs_intr.regs,
> +						data->extra_regs,
>  						mask);
>  		}
>  	}

See, I think most of this is completely unnessecary. Both sites pass:
&perf_regs::regs to perf_output_sample_regs()<-perf_reg_value().

So all you need to do is add the XMM crud to perf_regs, and use
container_of() on the pt_regs pointer in perf_reg_value() to get back to
perf_regs and voila, XMM registers.
