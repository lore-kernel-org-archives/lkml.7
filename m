Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3D3C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE796206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbfHTRdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:33:42 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44979 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfHTRdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:33:42 -0400
Received: by mail-ot1-f68.google.com with SMTP id w4so5785299ote.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 10:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DJrnLjhScHru9gcJVh+InGx4/K8NhQtt/YaanaUBKEI=;
        b=YR4N3Zc9UFFyBrTNldCqnIR9cIMgisCCqjkeoarMfUz5mKqE+ZU5OqGmhAnCMwYaNy
         tmEz5EMDEbUOwnHyleUFZyll3yjgW8PblMgYROvz0jL2srV5WhopoD92tDZk9OFe6cXK
         T/W0AwzK1GA9SolRf9PodzIE14DTe4towajs6BbzPt3K54T00b55NkgVojKc17mtwc9D
         t6KMYl8UfSGo5JwXtHTrtHRIvlEZ0WVrhH71Jx3EknZuQBr9WPORie/2mmn83ryvXXoC
         eazr1j0kXqMeU+F5DmFSA35NGCBbze7X5370OEYZRahQ8QGm9a3VgRde4rugDQYMiuwL
         EG6A==
X-Gm-Message-State: APjAAAWT5zHKLE1XH+4CInFxPqpaPwLnLEVC+SAPEKbZl/XtR1cGCD3P
        qLWos4+yhdXw6vJa0dZsmuI=
X-Google-Smtp-Source: APXvYqwLvtPAu0vNNv/aME3T3x5ujv2kgu7v1Dc+Lbq4Pc0X6NZyD8oBBkPNk9orn/aWQjslTJCPQw==
X-Received: by 2002:a9d:628e:: with SMTP id x14mr14957344otk.361.1566322421233;
        Tue, 20 Aug 2019 10:33:41 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id v24sm6742582otj.78.2019.08.20.10.33.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 10:33:40 -0700 (PDT)
Subject: Re: [PATCH 3/3] nvme: complete request in work queue on CPU with
 flooded interrupts
To:     longli@linuxonhyperv.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
References: <1566281669-48212-1-git-send-email-longli@linuxonhyperv.com>
 <1566281669-48212-4-git-send-email-longli@linuxonhyperv.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2a30a07f-982c-c291-e263-0cf72ec61235@grimberg.me>
Date:   Tue, 20 Aug 2019 10:33:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566281669-48212-4-git-send-email-longli@linuxonhyperv.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Long Li <longli@microsoft.com>
> 
> When a NVMe hardware queue is mapped to several CPU queues, it is possible
> that the CPU this hardware queue is bound to is flooded by returning I/O for
> other CPUs.
> 
> For example, consider the following scenario:
> 1. CPU 0, 1, 2 and 3 share the same hardware queue
> 2. the hardware queue interrupts CPU 0 for I/O response
> 3. processes from CPU 1, 2 and 3 keep sending I/Os
> 
> CPU 0 may be flooded with interrupts from NVMe device that are I/O responses
> for CPU 1, 2 and 3. Under heavy I/O load, it is possible that CPU 0 spends
> all the time serving NVMe and other system interrupts, but doesn't have a
> chance to run in process context.
> 
> To fix this, CPU 0 can schedule a work to complete the I/O request when it
> detects the scheduler is not making progress. This serves multiple purposes:
> 
> 1. This CPU has to be scheduled to complete the request. The other CPUs can't
> issue more I/Os until some previous I/Os are completed. This helps this CPU
> get out of NVMe interrupts.
> 
> 2. This acts a throttling mechanisum for NVMe devices, in that it can not
> starve a CPU while servicing I/Os from other CPUs.
> 
> 3. This CPU can make progress on RCU and other work items on its queue.

The problem is indeed real, but this is the wrong approach in my mind.

We already have irqpoll which takes care proper budgeting polling
cycles and not hogging the cpu.

I've sent rfc for this particular problem before [1]. At the time IIRC,
Christoph suggested that we will poll the first batch directly from
the irq context and reap the rest in irqpoll handler.

[1]: 
http://lists.infradead.org/pipermail/linux-nvme/2016-October/006497.html

How about something like this instead:
--
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 71127a366d3c..84bf16d75109 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -24,6 +24,7 @@
  #include <linux/io-64-nonatomic-lo-hi.h>
  #include <linux/sed-opal.h>
  #include <linux/pci-p2pdma.h>
+#include <linux/irq_poll.h>

  #include "trace.h"
  #include "nvme.h"
@@ -32,6 +33,7 @@
  #define CQ_SIZE(q)     ((q)->q_depth * sizeof(struct nvme_completion))

  #define SGES_PER_PAGE  (PAGE_SIZE / sizeof(struct nvme_sgl_desc))
+#define NVME_POLL_BUDGET_IRQ   256

  /*
   * These can be higher, but we need to ensure that any command doesn't
@@ -189,6 +191,7 @@ struct nvme_queue {
         u32 *dbbuf_cq_db;
         u32 *dbbuf_sq_ei;
         u32 *dbbuf_cq_ei;
+       struct irq_poll iop;
         struct completion delete_done;
  };

@@ -1015,6 +1018,23 @@ static inline int nvme_process_cq(struct 
nvme_queue *nvmeq, u16 *start,
         return found;
  }

+static int nvme_irqpoll_handler(struct irq_poll *iop, int budget)
+{
+       struct nvme_queue *nvmeq = container_of(iop, struct nvme_queue, 
iop);
+       struct pci_dev *pdev = to_pci_dev(nvmeq->dev->dev);
+       u16 start, end;
+       int completed;
+
+       completed = nvme_process_cq(nvmeq, &start, &end, budget);
+       nvme_complete_cqes(nvmeq, start, end);
+       if (completed < budget) {
+               irq_poll_complete(&nvmeq->iop);
+               enable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
+       }
+
+       return completed;
+}
+
  static irqreturn_t nvme_irq(int irq, void *data)
  {
         struct nvme_queue *nvmeq = data;
@@ -1028,12 +1048,16 @@ static irqreturn_t nvme_irq(int irq, void *data)
         rmb();
         if (nvmeq->cq_head != nvmeq->last_cq_head)
                 ret = IRQ_HANDLED;
-       nvme_process_cq(nvmeq, &start, &end, -1);
+       nvme_process_cq(nvmeq, &start, &end, NVME_POLL_BUDGET_IRQ);
         nvmeq->last_cq_head = nvmeq->cq_head;
         wmb();

         if (start != end) {
                 nvme_complete_cqes(nvmeq, start, end);
+               if (nvme_cqe_pending(nvmeq)) {
+                       disable_irq_nosync(irq);
+                       irq_poll_sched(&nvmeq->iop);
+               }
                 return IRQ_HANDLED;
         }

@@ -1347,6 +1371,7 @@ static enum blk_eh_timer_return 
nvme_timeout(struct request *req, bool reserved)

  static void nvme_free_queue(struct nvme_queue *nvmeq)
  {
+       irq_poll_disable(&nvmeq->iop);
         dma_free_coherent(nvmeq->dev->dev, CQ_SIZE(nvmeq),
                                 (void *)nvmeq->cqes, nvmeq->cq_dma_addr);
         if (!nvmeq->sq_cmds)
@@ -1481,6 +1506,7 @@ static int nvme_alloc_queue(struct nvme_dev *dev, 
int qid, int depth)
         nvmeq->dev = dev;
         spin_lock_init(&nvmeq->sq_lock);
         spin_lock_init(&nvmeq->cq_poll_lock);
+       irq_poll_init(&nvmeq->iop, NVME_POLL_BUDGET_IRQ, 
nvme_irqpoll_handler);
         nvmeq->cq_head = 0;
         nvmeq->cq_phase = 1;
         nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
--
