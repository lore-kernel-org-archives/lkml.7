Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1454C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 07:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACBDD2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 07:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389211AbfGRHQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 03:16:55 -0400
Received: from gate.crashing.org ([63.228.1.57]:42230 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfGRHQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 03:16:54 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6I7GcDE009351;
        Thu, 18 Jul 2019 02:16:38 -0500
Message-ID: <f6dca0a974f76876e4ed8eadf2fc189418aab590.camel@kernel.crashing.org>
Subject: Re: [PATCH] nvme-pci: Support shared tags across queues for Apple
 2018 controllers
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Paul Pawlowski <paul@mrarm.io>,
        Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Date:   Thu, 18 Jul 2019 17:16:37 +1000
In-Reply-To: <ee80e26d2eda385a709d749e5f0ec9e42b442090.camel@kernel.crashing.org>
References: <20190717004527.30363-1-benh@kernel.crashing.org>
         <20190717004527.30363-2-benh@kernel.crashing.org>
         <20190717115145.GB10495@minwoo-desktop>
         <2cc90b8cfa935e345ec2b185b087f1859a040176.camel@kernel.crashing.org>
         <ee80e26d2eda385a709d749e5f0ec9e42b442090.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-18 at 17:11 +1000, Benjamin Herrenschmidt wrote:
> Another issue with the Apple T2 based 2018 controllers seem to be
> that they blow up (and shut the machine down) if there's a tag
> collision between the IO queue and the Admin queue.
> 
> This adds a quirk that offsets all the tags in the IO queue by 32
> to avoid those collisions. It also limits the number of IO queues
> to 1 since the code wouldn't otherwise make sense (the device
> supports only one queue anyway but better safe than sorry).
> 
> The bug is typically triggered by tag collisions between SMART
> commands from smartd and IO commands, often at boot time.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> Note: This is the smallest way I found of doing this that keeps
> the impact self contained to pci.c. Feel free to suggest
> alternatives.

Looks like it's not enough ... the bug is a lot harder to hit but I
still occasionally get a duplicate tag. I'm now wondering if it's
unhappy about having tags bigger than q_depth... I wouldn't be
surprised with anything here.

I'll try again with a reduce q_depth as well...

Ben.

>  drivers/nvme/host/nvme.h |  5 +++++
>  drivers/nvme/host/pci.c  | 26 ++++++++++++++++++++------
>  2 files changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 564b967058f4..eeb99e485898 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -102,6 +102,11 @@ enum nvme_quirks {
>  	 * Use non-standard 128 bytes SQEs.
>  	 */
>  	NVME_QUIRK_128_BYTES_SQES		= (1 << 11),
> +
> +	/*
> +	 * Prevent tag overlap between queues
> +	 */
> +	NVME_QUIRK_SHARED_TAGS			= (1 << 12),
>  };
>  
>  /*
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index e399e59863c7..1055f19e57a4 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -194,6 +194,7 @@ struct nvme_queue {
>  	u16 cq_head;
>  	u16 last_cq_head;
>  	u16 qid;
> +	u16 tag_offset;
>  	u8 cq_phase;
>  	u8 sqes;
>  	unsigned long flags;
> @@ -506,6 +507,7 @@ static void nvme_submit_cmd(struct nvme_queue
> *nvmeq, struct nvme_command *cmd,
>  			    bool write_sq)
>  {
>  	spin_lock(&nvmeq->sq_lock);
> +	cmd->common.command_id += nvmeq->tag_offset;
>  	memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
>  	       cmd, sizeof(*cmd));
>  	if (++nvmeq->sq_tail == nvmeq->q_depth)
> @@ -967,9 +969,10 @@ static inline void nvme_ring_cq_doorbell(struct
> nvme_queue *nvmeq)
>  static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16
> idx)
>  {
>  	volatile struct nvme_completion *cqe = &nvmeq->cqes[idx];
> +	u16 ctag = cqe->command_id - nvmeq->tag_offset;
>  	struct request *req;
>  
> -	if (unlikely(cqe->command_id >= nvmeq->q_depth)) {
> +	if (unlikely(ctag >= nvmeq->q_depth)) {
>  		dev_warn(nvmeq->dev->ctrl.device,
>  			"invalid id %d completed on queue %d\n",
>  			cqe->command_id, le16_to_cpu(cqe->sq_id));
> @@ -982,14 +985,13 @@ static inline void nvme_handle_cqe(struct
> nvme_queue *nvmeq, u16 idx)
>  	 * aborts.  We don't even bother to allocate a struct request
>  	 * for them but rather special case them here.
>  	 */
> -	if (unlikely(nvmeq->qid == 0 &&
> -			cqe->command_id >= NVME_AQ_BLK_MQ_DEPTH)) {
> +	if (unlikely(nvmeq->qid == 0 && ctag >= NVME_AQ_BLK_MQ_DEPTH))
> {
>  		nvme_complete_async_event(&nvmeq->dev->ctrl,
>  				cqe->status, &cqe->result);
>  		return;
>  	}
>  
> -	req = blk_mq_tag_to_rq(*nvmeq->tags, cqe->command_id);
> +	req = blk_mq_tag_to_rq(*nvmeq->tags, ctag);
>  	trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
>  	nvme_end_request(req, cqe->status, cqe->result);
>  }
> @@ -1020,7 +1022,10 @@ static inline int nvme_process_cq(struct
> nvme_queue *nvmeq, u16 *start,
>  
>  	*start = nvmeq->cq_head;
>  	while (nvme_cqe_pending(nvmeq)) {
> -		if (tag == -1U || nvmeq->cqes[nvmeq-
> >cq_head].command_id == tag)
> +		u16 ctag = nvmeq->cqes[nvmeq->cq_head].command_id;
> +
> +		ctag -= nvmeq->tag_offset;
> +		if (tag == -1U || ctag == tag)
>  			found++;
>  		nvme_update_cq_head(nvmeq);
>  	}
> @@ -1499,6 +1504,10 @@ static int nvme_alloc_queue(struct nvme_dev
> *dev, int qid, int depth)
>  	nvmeq->qid = qid;
>  	dev->ctrl.queue_count++;
>  
> +	if (qid && (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS))
> +		nvmeq->tag_offset = NVME_AQ_DEPTH;
> +	else
> +		nvmeq->tag_offset = 0;
>  	return 0;
>  
>   free_cqdma:
> @@ -2110,6 +2119,10 @@ static int nvme_setup_io_queues(struct
> nvme_dev *dev)
>  	unsigned long size;
>  
>  	nr_io_queues = max_io_queues();
> +
> +	if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS)
> +		nr_io_queues = 1;
> +
>  	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
>  	if (result < 0)
>  		return result;
> @@ -2957,7 +2970,8 @@ static const struct pci_device_id
> nvme_id_table[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2005),
>  		.driver_data = NVME_QUIRK_SINGLE_VECTOR |
> -				NVME_QUIRK_128_BYTES_SQES },
> +				NVME_QUIRK_128_BYTES_SQES |
> +				NVME_QUIRK_SHARED_TAGS },
>  	{ 0, }
>  };
>  MODULE_DEVICE_TABLE(pci, nvme_id_table);
> 

