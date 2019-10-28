Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863E0CA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F3221721
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403956AbfJ1Q7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:59:12 -0400
Received: from ale.deltatee.com ([207.54.116.67]:58104 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbfJ1Q7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:59:12 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1iP8M5-00089J-Ka; Mon, 28 Oct 2019 10:58:58 -0600
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20191025202535.12036-1-logang@deltatee.com>
 <20191025202535.12036-4-logang@deltatee.com> <20191027150937.GC5843@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <94c1e177-4848-c88b-ec26-3da118fd18dc@deltatee.com>
Date:   Mon, 28 Oct 2019 10:58:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191027150937.GC5843@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, maxg@mellanox.com, Chaitanya.Kulkarni@wdc.com, kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH 3/3] nvme: Introduce nvme_execute_passthru_rq_nowait()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-10-27 9:09 a.m., Christoph Hellwig wrote:
> On Fri, Oct 25, 2019 at 02:25:35PM -0600, Logan Gunthorpe wrote:
>> This function is similar to nvme_execute_passthru_rq() but does
>> not wait and will call a callback when the request is complete.
>>
>> The new function can also be called in interrupt context, so if there
>> are side effects, the request will be executed in a work queue to
>> avoid sleeping.
> 
> Why would you ever call it from interrupt context?  All the target
> submission handlers should run in process context.

Oh, I mis-understood this a bit and worded that incorrectly. The intent
is to avoid having to call nvme_passthru_end() in the completion handler
which can be in interrupt context.

>> +void nvme_execute_passthru_rq_nowait(struct request *rq, rq_end_io_fn *done)
>> +{
>> +	struct nvme_command *cmd = nvme_req(rq)->cmd;
>> +	struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
>> +	struct nvme_ns *ns = rq->q->queuedata;
>> +	struct gendisk *disk = ns ? ns->disk : NULL;
>> +	u32 effects;
>> +
>> +	/*
>> +	 * This function may be called in interrupt context, so we cannot sleep
>> +	 * but nvme_passthru_[start|end]() may sleep so we need to execute
>> +	 * the command in a work queue.
>> +	 */
>> +	effects = nvme_command_effects(ctrl, ns, cmd->common.opcode);
>> +	if (effects) {
>> +		rq->end_io = done;
>> +		INIT_WORK(&nvme_req(rq)->work, nvme_execute_passthru_rq_work);
>> +		queue_work(nvme_wq, &nvme_req(rq)->work);
> 
> But independent of the target code - I'd much rather leave this to the
> caller.  Just call nvme_command_effects in the target code, then if
> there are not side effects use blk_execute_rq_nowait directly, else
> schedule a workqueue in the target code and call
> nvme_execute_passthru_rq from it.

Ok, that seems sensible. Except it conflicts a bit with Sagi's feedback:
presumably we need to cancel the work items during nvme_stop_ctrl() and
that's going to be rather difficult to do from the caller. Are we saying
this is unnecessary? It's not clear to me if passthru_start/end is going
to be affected by nvme_stop_ctrl() which I believe is the main concern.

Logan

