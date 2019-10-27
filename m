Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A33CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 15:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF86020873
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 15:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfJ0PJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 11:09:40 -0400
Received: from verein.lst.de ([213.95.11.211]:58424 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbfJ0PJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 11:09:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D8ED668B05; Sun, 27 Oct 2019 16:09:37 +0100 (CET)
Date:   Sun, 27 Oct 2019 16:09:37 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [RFC PATCH 3/3] nvme: Introduce
 nvme_execute_passthru_rq_nowait()
Message-ID: <20191027150937.GC5843@lst.de>
References: <20191025202535.12036-1-logang@deltatee.com> <20191025202535.12036-4-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025202535.12036-4-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 02:25:35PM -0600, Logan Gunthorpe wrote:
> This function is similar to nvme_execute_passthru_rq() but does
> not wait and will call a callback when the request is complete.
> 
> The new function can also be called in interrupt context, so if there
> are side effects, the request will be executed in a work queue to
> avoid sleeping.

Why would you ever call it from interrupt context?  All the target
submission handlers should run in process context.

> +void nvme_execute_passthru_rq_nowait(struct request *rq, rq_end_io_fn *done)
> +{
> +	struct nvme_command *cmd = nvme_req(rq)->cmd;
> +	struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
> +	struct nvme_ns *ns = rq->q->queuedata;
> +	struct gendisk *disk = ns ? ns->disk : NULL;
> +	u32 effects;
> +
> +	/*
> +	 * This function may be called in interrupt context, so we cannot sleep
> +	 * but nvme_passthru_[start|end]() may sleep so we need to execute
> +	 * the command in a work queue.
> +	 */
> +	effects = nvme_command_effects(ctrl, ns, cmd->common.opcode);
> +	if (effects) {
> +		rq->end_io = done;
> +		INIT_WORK(&nvme_req(rq)->work, nvme_execute_passthru_rq_work);
> +		queue_work(nvme_wq, &nvme_req(rq)->work);

But independent of the target code - I'd much rather leave this to the
caller.  Just call nvme_command_effects in the target code, then if
there are not side effects use blk_execute_rq_nowait directly, else
schedule a workqueue in the target code and call
nvme_execute_passthru_rq from it.
