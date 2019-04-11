Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1430FC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D604220850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YkZoFEdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfDKOYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 10:24:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37666 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfDKOYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 10:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0PQ6u1lryoiBwiTNLXSuUsVuukUeEcpBs3lJidBSw3Q=; b=YkZoFEdj+mDuWhZR9lu1QPt7i
        6Kmzt3Km4bC7+HUCiUzk3r37FaGfNsSg9Ctx9QheZfUEeXpIo/Mvsknm5NHITXgfdIubs8eP8E/zh
        h5a7LtGMbUmDhhR+x53KB4CiCTq6KmZEvnmo53dTypGeOXui1vvd7YWD1l5izNjZNKOyVqobe9e0n
        3jrghxOzP++KF80XlRSkJxcmtiJFrSidFS8GJOE5bSuJdeyABOMfMI83cqpnddlUJS4PU7GOsgi1o
        mCrvxvs6ivXGxtpoWVwjIfaDMCUWzxR/DJXjyEV4J3zTbTqhK+eY/EYiWDly4HothfgUj+JUE3Otu
        3LOIEPsvA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEacy-0006u7-LD; Thu, 11 Apr 2019 14:24:32 +0000
Date:   Thu, 11 Apr 2019 07:24:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mao Han <han_mao@c-sky.com>
Cc:     linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH 1/3] riscv: Add perf callchain support
Message-ID: <20190411142432.GB8343@infradead.org>
References: <cover.1554961908.git.han_mao@c-sky.com>
 <195185ea63240ed396026505d96d1f6449963482.1554961908.git.han_mao@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <195185ea63240ed396026505d96d1f6449963482.1554961908.git.han_mao@c-sky.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> --- /dev/null
> +++ b/arch/riscv/kernel/perf_callchain.c
> @@ -0,0 +1,122 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.

Please use normal /* */ Style comment for everything but the SPDX
tags.

> +static int unwind_frame_kernel(struct stackframe *frame)
> +{
> +	int graph = 0;
> +
> +	/* 0x3 means misalignment */
> +	if (!kstack_end((void *)frame->fp) &&
> +	    !((unsigned long)frame->fp & 0x3) &&
> +	    ((unsigned long)frame->fp >= TASK_SIZE)) {
> +		frame->ra = ((struct stackframe *)frame->fp - 1)->ra;
> +		frame->fp = ((struct stackframe *)frame->fp - 1)->fp;
> +		/* make sure CONFIG_FUNCTION_GRAPH_TRACER is turned on */
> +		if (__kernel_text_address(frame->ra))
> +			frame->ra = ftrace_graph_ret_addr(NULL, &graph,
> +							frame->ra, NULL);
> +		return 0;
> +	} else {
> +		return -EPERM;
> +	}

Please do early exists for all the error conditions.  Also no casts
are needed for using ->fp as a scalar value, and we should probably
just do a struct copy instead of copying both values individually.

The function should look something like:

static int unwind_frame_kernel(struct stackframe *frame)
{
	if (!kstack_end((void *)frame->fp))
		return -EPERM;
	if ((frame->fp & 0x3 || frame->fp >= TASK_SIZE)
		return -EPERM;

	*frame = *((struct stackframe *)frame->fp - 1);
	if (__kernel_text_address(frame->ra)) {
		int graph = 0;

		frame->ra = ftrace_graph_ret_addr(NULL, &graph, frame->ra,
				NULL);
	}
	return 0;
}

> +static void notrace walk_stackframe(struct stackframe *fr,
> +			struct perf_callchain_entry_ctx *entry)
> +{
> +	while (1) {
> +		int ret;
> +
> +		perf_callchain_store(entry, fr->ra);
> +
> +		ret = unwind_frame_kernel(fr);
> +		if (ret < 0)
> +			break;
> +	}
> +}

Why not:

	do {
		perf_callchain_store(entry, fr->ra);
	} while (unwind_frame_kernel(fr) >= 0);

> +/*
> + * Get the return address for a single stackframe and return a pointer to the
> + * next frame tail.
> + */
> +static unsigned long user_backtrace(struct perf_callchain_entry_ctx *entry,
> +			unsigned long fp, unsigned long reg_ra)
> +{
> +	struct stackframe buftail;
> +	unsigned long ra = 0;
> +	unsigned long *user_frame_tail = (unsigned long *)(fp - sizeof(struct stackframe));

Overly long line.

> +	fp = user_backtrace(entry, fp, regs->ra);
> +	while ((entry->nr < entry->max_stack) &&
> +		fp && !((unsigned long)fp & 0x3))
> +		fp = user_backtrace(entry, fp, 0);

Please don't indent the condition continuation and the loop body
by the same amount.
