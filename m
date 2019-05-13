Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767BEC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 01:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C6020873
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 01:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfEMBc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 21:32:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36300 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727054AbfEMBc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 21:32:28 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5EFD7A7C056586BE2EBB;
        Mon, 13 May 2019 09:32:26 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.55) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Mon, 13 May 2019
 09:32:15 +0800
Subject: Re: [RFC] irqchip/gic-its: fix command queue pointer comparison bug
To:     <linux-kernel@vger.kernel.org>
References: <1557581684-71297-1-git-send-email-guoheyi@huawei.com>
CC:     <wanghaibin.wang@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
        "Jason Cooper" <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
From:   Heyi Guo <guoheyi@huawei.com>
Message-ID: <07768321-46c3-170f-e92b-58ad29a655c5@huawei.com>
Date:   Mon, 13 May 2019 09:32:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <1557581684-71297-1-git-send-email-guoheyi@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.55]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, this patch still has issue when the queue is almost full, for the sample window becomes very small.

How about we calculating the delta of each time read and then accumulating it to compare with the to_idr? This can guarantee to get real rd_idx with more than 1 wraps.

Thanks,

Heyi


On 2019/5/11 21:34, Heyi Guo wrote:
> When we run several VMs with PCI passthrough and GICv4 enabled, not
> pinning vCPUs, we will occasionally see below warnings in dmesg:
>
> ITS queue timeout (65440 65504 480)
> ITS cmd its_build_vmovp_cmd failed
>
> The reason for the above issue is that in BUILD_SINGLE_CMD_FUNC:
> 1. Post the write command.
> 2. Release the lock.
> 3. Start to read GITS_CREADR to get the reader pointer.
> 4. Compare the reader pointer to the target pointer.
> 5. If reader pointer does not reach the target, sleep 1us and continue
> to try.
>
> If we have several processors running the above concurrently, other
> CPUs will post write commands while the 1st CPU is waiting the
> completion. So we may have below issue:
>
> phase 1:
> ---rd_idx-----from_idx-----to_idx--0---------
>
> wait 1us:
>
> phase 2:
> --------------from_idx-----to_idx--0-rd_idx--
>
> That is the rd_idx may fly ahead of to_idx, and if in case to_idx is
> near the wrap point, rd_idx will wrap around. So the below condition
> will not be met even after 1s:
>
> if (from_idx < to_idx && rd_idx >= to_idx)
>
> There is another theoretical issue. For a slow and busy ITS, the
> initial rd_idx may fall behind from_idx a lot, just as below:
>
> ---rd_idx---0--from_idx-----to_idx-----------
>
> This will cause the wait function exit too early.
>
> Actually, it does not make much sense to use from_idx to judge if
> to_idx is wrapped, but we need a initial rd_idx when lock is still
> acquired, and it can be used to judge whether to_idx is wrapped and
> the current rd_idx is wrapped.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
>
> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
> ---
>
> This patch has only been tested on 4.19.36, for my NIC device driver has
> something wrong with mainline kernel, so I mark it as a RFC until test has been
> done upon mainline kernel.
>
>   drivers/irqchip/irq-gic-v3-its.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 7577755..d14f3fbc 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -745,30 +745,30 @@ static void its_flush_cmd(struct its_node *its, struct its_cmd_block *cmd)
>   }
>   
>   static int its_wait_for_range_completion(struct its_node *its,
> -					 struct its_cmd_block *from,
> +					 u64	origin_rd_idx,
>   					 struct its_cmd_block *to)
>   {
> -	u64 rd_idx, from_idx, to_idx;
> +	u64 rd_idx, to_idx;
>   	u32 count = 1000000;	/* 1s! */
>   
> -	from_idx = its_cmd_ptr_to_offset(its, from);
>   	to_idx = its_cmd_ptr_to_offset(its, to);
> +	if (to_idx < origin_rd_idx)
> +		to_idx += ITS_CMD_QUEUE_SZ;
>   
>   	while (1) {
>   		rd_idx = readl_relaxed(its->base + GITS_CREADR);
>   
> -		/* Direct case */
> -		if (from_idx < to_idx && rd_idx >= to_idx)
> -			break;
> +		/* Wrap around for CREADR */
> +		if (rd_idx < origin_rd_idx)
> +			rd_idx += ITS_CMD_QUEUE_SZ;
>   
> -		/* Wrapped case */
> -		if (from_idx >= to_idx && rd_idx >= to_idx && rd_idx < from_idx)
> +		if (rd_idx >= to_idx)
>   			break;
>   
>   		count--;
>   		if (!count) {
>   			pr_err_ratelimited("ITS queue timeout (%llu %llu %llu)\n",
> -					   from_idx, to_idx, rd_idx);
> +					   origin_rd_idx, to_idx, rd_idx);
>   			return -1;
>   		}
>   		cpu_relax();
> @@ -787,6 +787,7 @@ void name(struct its_node *its,						\
>   	struct its_cmd_block *cmd, *sync_cmd, *next_cmd;		\
>   	synctype *sync_obj;						\
>   	unsigned long flags;						\
> +	u64 rd_idx;							\
>   									\
>   	raw_spin_lock_irqsave(&its->lock, flags);			\
>   									\
> @@ -808,10 +809,11 @@ void name(struct its_node *its,						\
>   	}								\
>   									\
>   post:									\
> +	rd_idx = readl_relaxed(its->base + GITS_CREADR);		\
>   	next_cmd = its_post_commands(its);				\
>   	raw_spin_unlock_irqrestore(&its->lock, flags);			\
>   									\
> -	if (its_wait_for_range_completion(its, cmd, next_cmd))		\
> +	if (its_wait_for_range_completion(its, rd_idx, next_cmd))	\
>   		pr_err_ratelimited("ITS cmd %ps failed\n", builder);	\
>   }
>   


