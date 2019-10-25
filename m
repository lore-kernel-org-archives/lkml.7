Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3B8CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 21:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F006222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 21:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfJYVk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 17:40:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39878 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfJYVk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 17:40:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id r141so3435851wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 14:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KqXCDwMNLnU9Sq5mjJqUeqsnhfK8AbIw6Nf9qBzmidA=;
        b=ml9g8e/RbbvdEpUpQLNDz9/KiXZbuPQnPlgZnOfL4C67bIYtEhX+8CbJs4JAhCY7y2
         f3htqd3KJa3Q9PGuMrRjS+GCp+6UVq8L3FhT+rjY3k0ypEwbBMMnfkiJPMHsGftgRQs7
         8KSsE7JXS+des/LfM8GYS4GMI3UoB99ib5SqTu79NASBf6usD6jkQUHTdpnzuHMNcFBM
         jIm4HdPlXeNOYPJOKXmsNBS6YctCSc3PLhSl1SWRBkuGz5PrgQgsOCrqjmXnaPHDWM1T
         +JD2WoYy0rxnyueQwIcTiQ9OyQFjIuaOPnrZ2FBUFl6P6tsKzPVOZGUgcRZgFW9KN+oa
         t4Rg==
X-Gm-Message-State: APjAAAW9K3zxuNEY33wFzOi8UyOX67cs5lyUnCj3aq5m0ZUNJt55qa7/
        0klyoVxJx3MVxXbsuLkLH+A=
X-Google-Smtp-Source: APXvYqymbwQKh72Rl1MZ6bfp6hyf49nHbGJoeGwrP2gGGiP1hWP9BfsPEOxl7jNURX5qoP5WvBuH1w==
X-Received: by 2002:a1c:96d5:: with SMTP id y204mr3257831wmd.63.1572039624378;
        Fri, 25 Oct 2019 14:40:24 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id h17sm3759607wme.6.2019.10.25.14.40.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 14:40:23 -0700 (PDT)
Subject: Re: [RFC PATCH 3/3] nvme: Introduce nvme_execute_passthru_rq_nowait()
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20191025202535.12036-1-logang@deltatee.com>
 <20191025202535.12036-4-logang@deltatee.com>
 <28b40ab8-c695-784e-3f52-03a18b891d25@grimberg.me>
 <11006dd2-718f-b569-4ef3-c01232354d5f@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <952c93fa-ef69-e113-a285-b1e9a0ddcafc@grimberg.me>
Date:   Fri, 25 Oct 2019 14:40:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <11006dd2-718f-b569-4ef3-c01232354d5f@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> +#ifdef CONFIG_NVME_TARGET_PASSTHRU
>>> +static void nvme_execute_passthru_rq_work(struct work_struct *w)
>>> +{
>>> +    struct nvme_request *req = container_of(w, struct nvme_request,
>>> work);
>>> +    struct request *rq = blk_mq_rq_from_pdu(req);
>>> +    rq_end_io_fn *done = rq->end_io;
>>> +    void *end_io_data = rq->end_io_data;
>>
>> Why is end_io_data stored to a local variable here? where is it set?
> 
> blk_execute_rq() (which is called by nvme_execute_rq()) will overwrite
> rq->endio and rq->end_io_data. We store them here so we can call the
> callback appropriately after the request completes. It would be set by
> the caller in the same way they set it if they were calling
> blk_execute_rq_nowait().

I see..

>>> +
>>> +    nvme_execute_passthru_rq(rq);
>>> +
>>> +    if (done) {
>>> +        rq->end_io_data = end_io_data;
>>> +        done(rq, 0);
>>> +    }
>>> +}
>>> +
>>> +void nvme_execute_passthru_rq_nowait(struct request *rq, rq_end_io_fn
>>> *done)
>>> +{
>>> +    struct nvme_command *cmd = nvme_req(rq)->cmd;
>>> +    struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
>>> +    struct nvme_ns *ns = rq->q->queuedata;
>>> +    struct gendisk *disk = ns ? ns->disk : NULL;
>>> +    u32 effects;
>>> +
>>> +    /*
>>> +     * This function may be called in interrupt context, so we cannot
>>> sleep
>>> +     * but nvme_passthru_[start|end]() may sleep so we need to execute
>>> +     * the command in a work queue.
>>> +     */
>>> +    effects = nvme_command_effects(ctrl, ns, cmd->common.opcode);
>>> +    if (effects) {
>>> +        rq->end_io = done;
>>> +        INIT_WORK(&nvme_req(rq)->work, nvme_execute_passthru_rq_work);
>>> +        queue_work(nvme_wq, &nvme_req(rq)->work);
>>
>> This work will need to be flushed when in nvme_stop_ctrl. That is
>> assuming that it will fail-fast and not hang (which it should given
>> that its a passthru command that is allocated via nvme_alloc_request).
> 
> Hmm, that's going to be a bit tricky. Seeing the work_struct belongs
> potentially to a number of different requests, we can't just flush the
> individual work items. I think we'd have to create a work-queue per ctrl
> and flush that. Any objections to that?

I'd object to that overhead...

How about marking the request if the workqueue path is taken and
in nvme_stop_ctrl you add a blk_mq_tagset_busy_iter and cancel
it in the callback?

Something like:
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fa7ba09dca77..13dbbec5497d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3955,12 +3955,33 @@ void nvme_complete_async_event(struct nvme_ctrl 
*ctrl, __le16 status,
  }
  EXPORT_SYMBOL_GPL(nvme_complete_async_event);

+static bool nvme_flush_async_passthru_request(struct request *rq,
+               void *data, bool reserved)
+{
+       if (!(nvme_req(rq)->flags & NVME_REQ_ASYNC_PASSTHRU))
+               return true;
+
+       dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
+                               "Cancelling passthru I/O %d", req->tag);
+       flush_work(&nvme_req(rq)->work);
+       return true;
+}
+
+static void nvme_flush_async_passthru_requests(struct nvme_ctrl *ctrl)
+{
+       blk_mq_tagset_busy_iter(ctrl->tagset,
+               nvme_flush_async_passthru_request, ctrl);
+       blk_mq_tagset_busy_iter(ctrl->admin_tagset,
+               nvme_flush_async_passthru_request, ctrl);
+}
+
  void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
  {
         nvme_mpath_stop(ctrl);
         nvme_stop_keep_alive(ctrl);
         flush_work(&ctrl->async_event_work);
         cancel_work_sync(&ctrl->fw_act_work);
+       nvme_flush_async_passthru_requests(ctrl);
  }
  EXPORT_SYMBOL_GPL(nvme_stop_ctrl);
--
