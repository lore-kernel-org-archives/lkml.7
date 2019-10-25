Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4BBCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 21:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844DD21D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 21:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfJYVMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 17:12:38 -0400
Received: from ale.deltatee.com ([207.54.116.67]:36076 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbfJYVMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 17:12:38 -0400
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1iO6so-00082S-Ir; Fri, 25 Oct 2019 15:12:31 -0600
To:     Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>,
        Keith Busch <kbusch@kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
References: <20191025202535.12036-1-logang@deltatee.com>
 <20191025202535.12036-4-logang@deltatee.com>
 <28b40ab8-c695-784e-3f52-03a18b891d25@grimberg.me>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <11006dd2-718f-b569-4ef3-c01232354d5f@deltatee.com>
Date:   Fri, 25 Oct 2019 15:12:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <28b40ab8-c695-784e-3f52-03a18b891d25@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: hch@lst.de, maxg@mellanox.com, kbusch@kernel.org, sbates@raithlin.com, Chaitanya.Kulkarni@wdc.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH 3/3] nvme: Introduce nvme_execute_passthru_rq_nowait()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-10-25 2:41 p.m., Sagi Grimberg wrote:
>> +#ifdef CONFIG_NVME_TARGET_PASSTHRU
>> +static void nvme_execute_passthru_rq_work(struct work_struct *w)
>> +{
>> +    struct nvme_request *req = container_of(w, struct nvme_request,
>> work);
>> +    struct request *rq = blk_mq_rq_from_pdu(req);
>> +    rq_end_io_fn *done = rq->end_io;
>> +    void *end_io_data = rq->end_io_data;
> 
> Why is end_io_data stored to a local variable here? where is it set?

blk_execute_rq() (which is called by nvme_execute_rq()) will overwrite
rq->endio and rq->end_io_data. We store them here so we can call the
callback appropriately after the request completes. It would be set by
the caller in the same way they set it if they were calling
blk_execute_rq_nowait().

>> +
>> +    nvme_execute_passthru_rq(rq);
>> +
>> +    if (done) {
>> +        rq->end_io_data = end_io_data;
>> +        done(rq, 0);
>> +    }
>> +}
>> +
>> +void nvme_execute_passthru_rq_nowait(struct request *rq, rq_end_io_fn
>> *done)
>> +{
>> +    struct nvme_command *cmd = nvme_req(rq)->cmd;
>> +    struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
>> +    struct nvme_ns *ns = rq->q->queuedata;
>> +    struct gendisk *disk = ns ? ns->disk : NULL;
>> +    u32 effects;
>> +
>> +    /*
>> +     * This function may be called in interrupt context, so we cannot
>> sleep
>> +     * but nvme_passthru_[start|end]() may sleep so we need to execute
>> +     * the command in a work queue.
>> +     */
>> +    effects = nvme_command_effects(ctrl, ns, cmd->common.opcode);
>> +    if (effects) {
>> +        rq->end_io = done;
>> +        INIT_WORK(&nvme_req(rq)->work, nvme_execute_passthru_rq_work);
>> +        queue_work(nvme_wq, &nvme_req(rq)->work);
> 
> This work will need to be flushed when in nvme_stop_ctrl. That is
> assuming that it will fail-fast and not hang (which it should given
> that its a passthru command that is allocated via nvme_alloc_request).

Hmm, that's going to be a bit tricky. Seeing the work_struct belongs
potentially to a number of different requests, we can't just flush the
individual work items. I think we'd have to create a work-queue per ctrl
and flush that. Any objections to that?

Logan
