Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A0BC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725502087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfCHN1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:27:32 -0500
Received: from verein.lst.de ([213.95.11.211]:53841 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbfCHN1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:27:31 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E62D568C4E; Fri,  8 Mar 2019 14:27:27 +0100 (CET)
Date:   Fri, 8 Mar 2019 14:27:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     James Smart <james.smart@broadcom.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet-fc: use zero-sized array and struct_size() in
 kzalloc()
Message-ID: <20190308132727.GC18218@lst.de>
References: <20190223185108.GA6706@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190223185108.GA6706@embeddedor>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James, can you take a look at this one?

On Sat, Feb 23, 2019 at 12:51:08PM -0600, Gustavo A. R. Silva wrote:
> Update the code to use a zero-sized array instead of a pointer in
> structure nvmet_fc_tgt_queue and use struct_size() in kzalloc().
> 
> Notice that one of the more common cases of allocation size calculations
> is finding the size of a structure that has a zero-sized array at the end,
> along with memory for some number of elements for that array. For example:
> 
> struct foo {
> 	int stuff;
> 	struct boo entry[];
> };
> 
> instance = kzalloc(sizeof(struct foo) + sizeof(struct boo) * count, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can now
> use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/nvme/target/fc.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 1e9654f04c60..23baec38f97e 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -128,12 +128,12 @@ struct nvmet_fc_tgt_queue {
>  	struct nvmet_cq			nvme_cq;
>  	struct nvmet_sq			nvme_sq;
>  	struct nvmet_fc_tgt_assoc	*assoc;
> -	struct nvmet_fc_fcp_iod		*fod;		/* array of fcp_iods */
>  	struct list_head		fod_list;
>  	struct list_head		pending_cmd_list;
>  	struct list_head		avail_defer_list;
>  	struct workqueue_struct		*work_q;
>  	struct kref			ref;
> +	struct nvmet_fc_fcp_iod		fod[];		/* array of fcp_iods */
>  } __aligned(sizeof(unsigned long long));
>  
>  struct nvmet_fc_tgt_assoc {
> @@ -588,9 +588,7 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
>  	if (qid > NVMET_NR_QUEUES)
>  		return NULL;
>  
> -	queue = kzalloc((sizeof(*queue) +
> -				(sizeof(struct nvmet_fc_fcp_iod) * sqsize)),
> -				GFP_KERNEL);
> +	queue = kzalloc(struct_size(queue, fod, sqsize), GFP_KERNEL);
>  	if (!queue)
>  		return NULL;
>  
> @@ -603,7 +601,6 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
>  	if (!queue->work_q)
>  		goto out_a_put;
>  
> -	queue->fod = (struct nvmet_fc_fcp_iod *)&queue[1];
>  	queue->qid = qid;
>  	queue->sqsize = sqsize;
>  	queue->assoc = assoc;
> -- 
> 2.20.1
---end quoted text---
