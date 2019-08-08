Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80961C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7A82184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565281713;
	bh=cUGyg9k4F6Juf5wkwZjrlmaaxkCzQychbABolvfV4YE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rsbwlLrK/OVxcUPTV/ig+vtQW4X7QIVy15zjLgMjn2GwP7NumsApQPBjS2yH71enD
	 14IXpND+Z9CE4Uj+cnUs/gJQPxE7w64TEjFOZ1iXBpXeZ1hovRtB8vyMOq5V5b0zoq
	 f+hSJqr6VogLBM2heRZxsnMroJpwmA12FptzGTvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732654AbfHHQ2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 12:28:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfHHQ2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:28:31 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EA172173E;
        Thu,  8 Aug 2019 16:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565281710;
        bh=cUGyg9k4F6Juf5wkwZjrlmaaxkCzQychbABolvfV4YE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1ZW/N1G5Aa4mL1wNhRPu1D5/tOlCGv/dfpmMvYhHXWaM5mPicrvGsI7SQUaOWTAB5
         BoY/4XB2jOLH3cjBJ6TYp59uxyM+N6L4RKSghBpNK4G22cm9VkO61IaJ4ZmL/hOnkg
         I2XLKB8O4PARNWpXZPy289orXB+eQNlg7THDJUAs=
Date:   Thu, 8 Aug 2019 17:28:26 +0100
From:   Will Deacon <will@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Jiping Ma <jiping.ma2@windriver.com>,
        catalin.marinas@arm.com, will.deacon@arm.com, mingo@redhat.com,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2 v2] tracing/arm64: Have max stack tracer handle the
 case of return address after data
Message-ID: <20190808162825.7klpu3ffza5zxwrt@willie-the-truck>
References: <20190807172826.352574408@goodmis.org>
 <20190807172907.155165959@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807172907.155165959@goodmis.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Wed, Aug 07, 2019 at 01:28:27PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Most archs (well at least x86) store the function call return address on the
> stack before storing the local variables for the function. The max stack
> tracer depends on this in its algorithm to display the stack size of each
> function it finds in the back trace.
> 
> Some archs (arm64), may store the return address (from its link register)
> just before calling a nested function. There's no reason to save the link
> register on leaf functions, as it wont be updated. This breaks the algorithm
> of the max stack tracer.
> 
> Add a new define ARCH_RET_ADDR_AFTER_LOCAL_VARS that an architecture may set
> if it stores the return address (link register) after it stores the
> function's local variables, and have the stack trace shift the values of the
> mapped stack size to the appropriate functions.
> 
> Link: 20190802094103.163576-1-jiping.ma2@windriver.com
> 
> Reported-by: Jiping Ma <jiping.ma2@windriver.com>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  arch/arm64/include/asm/ftrace.h | 13 +++++++++++++
>  kernel/trace/trace_stack.c      | 14 ++++++++++++++
>  2 files changed, 27 insertions(+)

I agree with your later comment that this should NOT go to stable.

> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index 5ab5200b2bdc..961e98618db4 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -14,6 +14,19 @@
>  #define MCOUNT_ADDR		((unsigned long)_mcount)
>  #define MCOUNT_INSN_SIZE	AARCH64_INSN_SIZE
>  
> +/*
> + * Currently, gcc tends to save the link register after the local variables
> + * on the stack. This causes the max stack tracer to report the function
> + * frame sizes for the wrong functions. By defining
> + * ARCH_RET_ADDR_AFTER_LOCAL_VARS, it will tell the stack tracer to expect
> + * to find the return address on the stack after the local variables have
> + * been set up.
> + *
> + * Note, this may change in the future, and we will need to deal with that
> + * if it were to happen.
> + */
> +#define ARCH_RET_ADDR_AFTER_LOCAL_VARS 1

I know it's long already, but prefixing this with FTRACE_ would be good so
that other code doesn't use it for anything. It's not the end of the world
if the ftrace stack usage statistics are wonky, but if people tried to use
this for crazy things like livepatching then we'd be in trouble.

Maybe FTRACE_ARCH_FRAME_AFTER_LOCALS, which is the same length as what
you currently have?

Will
