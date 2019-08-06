Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4C8C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 06:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F992147A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 06:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731772AbfHFGEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 02:04:25 -0400
Received: from mail5.windriver.com ([192.103.53.11]:44180 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731560AbfHFGEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 02:04:13 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x7661oZn031960
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 5 Aug 2019 23:02:00 -0700
Received: from [128.224.162.237] (128.224.162.237) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.3.468.0; Mon, 5 Aug 2019
 23:01:39 -0700
Subject: Re: [PATCH v3] tracing: Function stack size and its name mismatch in
 arm64
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <joel@joelfernandes.org>, <linux-arm-kernel@lists.infradead.org>
References: <20190802094103.163576-1-jiping.ma2@windriver.com>
 <20190802112259.0530a648@gandalf.local.home>
 <20190802120920.3b1f4351@gandalf.local.home>
From:   Jiping Ma <Jiping.Ma2@windriver.com>
Message-ID: <50eb7362-1f61-71a2-0a89-5d3bf054716e@windriver.com>
Date:   Tue, 6 Aug 2019 14:01:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20190802120920.3b1f4351@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019年08月03日 00:09, Steven Rostedt wrote:
> On Fri, 2 Aug 2019 11:22:59 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> I think you are not explaining the issue correctly. From looking at the
>> document, I think what you want to say is that the LR is saved *after*
>> the data for the function. Is that correct? If so, then yes, it would
>> cause the stack tracing algorithm to be incorrect.
>>
> [..]
>
>> Can someone confirm that this is the real issue?
> Does this patch fix your issue?
Yes, it does.

-- Jiping
>
> -- Steve
>
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index 5ab5200b2bdc..13a4832cfb00 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -13,6 +13,7 @@
>   #define HAVE_FUNCTION_GRAPH_FP_TEST
>   #define MCOUNT_ADDR		((unsigned long)_mcount)
>   #define MCOUNT_INSN_SIZE	AARCH64_INSN_SIZE
> +#define ARCH_RET_ADDR_AFTER_LOCAL_VARS 1
>   
>   #ifndef __ASSEMBLY__
>   #include <linux/compat.h>
> diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
> index 5d16f73898db..050c6bd9beac 100644
> --- a/kernel/trace/trace_stack.c
> +++ b/kernel/trace/trace_stack.c
> @@ -158,6 +158,18 @@ static void check_stack(unsigned long ip, unsigned long *stack)
>   			i++;
>   	}
>   
> +#ifdef ARCH_RET_ADDR_AFTER_LOCAL_VARS
> +	/*
> +	 * Most archs store the return address before storing the
> +	 * function's local variables. But some archs do this backwards.
> +	 */
> +	if (x > 1) {
> +		memmove(&stack_trace_index[0], &stack_trace_index[1],
> +			sizeof(stack_trace_index[0]) * (x - 1));
> +		x--;
> +	}
> +#endif
> +
>   	stack_trace_nr_entries = x;
>   
>   	if (task_stack_end_corrupted(current)) {
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

