Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719DFC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 12:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41243205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 12:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfLBMd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 07:33:29 -0500
Received: from foss.arm.com ([217.140.110.172]:53912 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727381AbfLBMd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 07:33:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 876B1DA7;
        Mon,  2 Dec 2019 04:33:26 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A31F53F7D8;
        Mon,  2 Dec 2019 04:33:25 -0800 (PST)
Date:   Mon, 2 Dec 2019 12:33:19 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Heyi Guo <guoheyi@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wanghaibin.wang@huawei.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] arm64/kernel/entry: refine comment of stack overflow
 check
Message-ID: <20191202123319.GA25809@lakrids.cambridge.arm.com>
References: <20191202113702.34158-1-guoheyi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202113702.34158-1-guoheyi@huawei.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 07:37:02PM +0800, Heyi Guo wrote:
> Stack overflow checking can be done by testing
> sp & (1 << THREAD_SHIFT)
> only for the stacks are aligned to (2 << THREAD_SHIFT) with size of
> (1 << THREAD_SIZE), and this is the case when CONFIG_VMAP_STACK is
> set.

Good point, I was sloppy with this comment.

> 
> Fix the code comment to avoid confusion.
> 
> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/kernel/entry.S | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index cf3bd2976e57..9e8ba507090f 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -76,7 +76,8 @@ alternative_else_nop_endif
>  #ifdef CONFIG_VMAP_STACK
>  	/*
>  	 * Test whether the SP has overflowed, without corrupting a GPR.
> -	 * Task and IRQ stacks are aligned to (1 << THREAD_SHIFT).
> +	 * Task and IRQ stacks are aligned to (2 << THREAD_SHIFT) with size of
> +	 * (1 << THREAD_SHIFT).
>  	 */

Can we make that:

	Task and IRQ stacks are aligned so that SP & (1 << THREAD_SHIFT)
	should always be zero.

... which I think is a bit clearer.

With that wording:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

>  	add	sp, sp, x0			// sp' = sp + x0
>  	sub	x0, sp, x0			// x0' = sp' - x0 = (sp + x0) - x0 = sp
> -- 
> 2.19.1
> 
