Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9C3C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D722171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfDLJp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 05:45:56 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:39739 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726706AbfDLJpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 05:45:55 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436637|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.382202-0.0130681-0.60473;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03309;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.EKKGL1c_1555062352;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.EKKGL1c_1555062352)
          by smtp.aliyun-inc.com(10.147.42.253);
          Fri, 12 Apr 2019 17:45:52 +0800
Date:   Fri, 12 Apr 2019 17:38:53 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, guoren@kernel.org
Subject: Re: [PATCH 2/3] riscv: Add support for perf registers sampling
Message-ID: <20190412093851.GA4961@vmh-VirtualBox>
References: <cover.1554961908.git.han_mao@c-sky.com>
 <20190411141435.GA8343@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411141435.GA8343@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 07:24:32AM -0700, Christoph Hellwig wrote:
> > --- /dev/null
> > +++ b/arch/riscv/kernel/perf_callchain.c
> > @@ -0,0 +1,122 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
> 
> Please use normal /* */ Style comment for everything but the SPDX
> tags.
>
OK
 
> Please do early exists for all the error conditions.  Also no casts
> are needed for using ->fp as a scalar value, and we should probably
> just do a struct copy instead of copying both values individually.
> 
> The function should look something like:
> 
> static int unwind_frame_kernel(struct stackframe *frame)
> {
> 	if (!kstack_end((void *)frame->fp))
> 		return -EPERM;
> 	if ((frame->fp & 0x3 || frame->fp >= TASK_SIZE)
> 		return -EPERM;
> 
> 	*frame = *((struct stackframe *)frame->fp - 1);
> 	if (__kernel_text_address(frame->ra)) {
> 		int graph = 0;
> 
> 		frame->ra = ftrace_graph_ret_addr(NULL, &graph, frame->ra,
> 				NULL);
> 	}
> 	return 0;
> }
>
Thanks for suggestion. It looks much better with the modification.

> 
> Why not:
> 
> 	do {
> 		perf_callchain_store(entry, fr->ra);
> 	} while (unwind_frame_kernel(fr) >= 0);
> 
Yes, it's much simpler.

> > +/*
> > + * Get the return address for a single stackframe and return a pointer to the
> > + * next frame tail.
> > + */
> > +static unsigned long user_backtrace(struct perf_callchain_entry_ctx *entry,
> > +			unsigned long fp, unsigned long reg_ra)
> > +{
> > +	struct stackframe buftail;
> > +	unsigned long ra = 0;
> > +	unsigned long *user_frame_tail = (unsigned long *)(fp - sizeof(struct stackframe));
> 
> Overly long line.
Will fix the style.

> 
> > +	fp = user_backtrace(entry, fp, regs->ra);
> > +	while ((entry->nr < entry->max_stack) &&
> > +		fp && !((unsigned long)fp & 0x3))
> > +		fp = user_backtrace(entry, fp, 0);
> 
> Please don't indent the condition continuation and the loop body
> by the same amount.

Like this?
	while ((entry->nr < entry->max_stack) &&
					fp && !((unsigned long)fp & 0x3))
		fp = user_backtrace(entry, fp, 0);

Thanks,
Mao Han
