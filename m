Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543B9C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F202173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfGSAkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 20:40:01 -0400
Received: from ale.deltatee.com ([207.54.116.67]:48470 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbfGSAkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 20:40:01 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hoGwH-0003ao-La; Thu, 18 Jul 2019 18:39:58 -0600
To:     Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190718225132.5865-1-logang@deltatee.com>
 <20190718225132.5865-2-logang@deltatee.com>
 <c52f80b1-e154-b11f-a868-e3209e4ccb2d@grimberg.me>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6deea9e7-ff3c-e115-b2f2-8914df0b6da7@deltatee.com>
Date:   Thu, 18 Jul 2019 18:39:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c52f80b1-e154-b11f-a868-e3209e4ccb2d@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: hch@lst.de, axboe@fb.com, kbusch@kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 2/2] nvme-core: Fix deadlock when deleting the ctrl while
 scanning
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-07-18 6:25 p.m., Sagi Grimberg wrote:
> 
>> With multipath enabled, nvme_scan_work() can read from the
>> device (through nvme_mpath_add_disk()). However, with fabrics,
>> once ctrl->state is set to NVME_CTRL_DELETING, the reads will hang
>> (see nvmf_check_ready()).
>>
>> After setting the state to deleting, nvme_remove_namespaces() will
>> hang waiting for scan_work to flush and these tasks will hang.
>>
>> To fix this, ensure we take scan_lock before changing the ctrl-state.
>> Also, ensure the state is checked while the lock is held
>> in nvme_scan_lock_work().
> 
> That's a big hammer...

I didn't think the scan_lock was that contested or that
nvme_change_ctrl_state() was really called that often...

> But this is I/O that we cannot have queued until we have a path..
> 
> I would rather have nvme_remove_namespaces() requeue all I/Os for
> namespaces that serve as the current_path and have the make_request
> routine to fail I/O if all controllers are deleting as well.
> 
> Would something like [1] (untested) make sense instead?

I'll have to give this a try next week and I'll let you know then. It
kind of makes sense to me but a number of things I tried to fix this
that I thought made sense did not work.

> 
>> +    mutex_lock(&ctrl->scan_lock);
>> +
>>       if (ctrl->state != NVME_CTRL_LIVE)
>>           return;
> 
> unlock

If we unlock here and relock below, we'd have to recheck the ctrl->state
to avoid any races. If you don't want to call nvme_identify_ctrl with
the lock held, then it would probably be better to move the state check
below it.

>>   @@ -3547,7 +3554,6 @@ static void nvme_scan_work(struct work_struct
>> *work)
>>       if (nvme_identify_ctrl(ctrl, &id))
>>           return;
> 
> unlock
> 
> 
> [1]:
> -- 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 76cd3dd8736a..627f5871858d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3576,6 +3576,11 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>         struct nvme_ns *ns, *next;
>         LIST_HEAD(ns_list);
> 
> +       mutex_lock(&ctrl->scan_lock);
> +       list_for_each_entry(ns, &ctrl->namespaces, list)
> +               nvme_mpath_clear_current_path(ns);
> +       mutex_lock(&ctrl->scan_lock);
> +
>         /* prevent racing with ns scanning */
>         flush_work(&ctrl->scan_work);
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index a9a927677970..da1731266788 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -231,6 +231,24 @@ inline struct nvme_ns *nvme_find_path(struct
> nvme_ns_head *head)
>         return ns;
>  }
> 
> +static bool nvme_available_path(struct nvme_ns_head *head)
> +{
> +       struct nvme_ns *ns;
> +
> +       list_for_each_entry_rcu(ns, &head->list, siblings) {
> +               switch (ns->ctrl->state) {
> +               case NVME_CTRL_LIVE:
> +               case NVME_CTRL_RESETTING:
> +               case NVME_CTRL_CONNECTING:
> +                       /* fallthru */
> +                       return true;
> +               default:
> +                       break;
> +               }
> +       }
> +       return false;
> +}
> +
>  static blk_qc_t nvme_ns_head_make_request(struct request_queue *q,
>                 struct bio *bio)
>  {
> @@ -257,14 +275,14 @@ static blk_qc_t nvme_ns_head_make_request(struct
> request_queue *q,
>                                       disk_devt(ns->head->disk),
>                                       bio->bi_iter.bi_sector);
>                 ret = direct_make_request(bio);
> -       } else if (!list_empty_careful(&head->list)) {
> -               dev_warn_ratelimited(dev, "no path available - requeuing
> I/O\n");
> +       } else if (nvme_available_path(head)) {
> +               dev_warn_ratelimited(dev, "no usable path - requeuing
> I/O\n");
> 
>                 spin_lock_irq(&head->requeue_lock);
>                 bio_list_add(&head->requeue_list, bio);
>                 spin_unlock_irq(&head->requeue_lock);
>         } else {
> -               dev_warn_ratelimited(dev, "no path - failing I/O\n");
> +               dev_warn_ratelimited(dev, "no available path - failing
> I/O\n");
> 
>                 bio->bi_status = BLK_STS_IOERR;
>                 bio_endio(bio);
> -- 
