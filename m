Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8AAC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 21:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 490F2206DD
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 21:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731029AbfHUVzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 17:55:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51608 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbfHUVzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 17:55:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id k1so3621612wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 14:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dZmBgENqfNwfNa5Zm5m6mwQBLa3/uboFY5OV+WZzZ38=;
        b=Ea4FbUxhxKa/s1CtuvDYT2bvrvQ5sLLqUplGMusUYgF0l6x8jHGD0UVI0kfOjY5VSL
         x6BXvfBXdW2rIsfpwBA1O18950Vr7xa1TfDM0TlXt4/QNsBO6mDmYnCYsxuNbHBDQlpi
         ky8KnOAGKh4mAVNvZp6A9hSnq5gT/HZHhG5N93nKuUoFwrx/mtRzFt6unnHOIuwoDVhk
         Fm898J+ZTDLDCvZvczbRCxH84xE7dwBXW+OH1trTzh8RButSaKRes6R4Ecr4LOIC6T3L
         zJFdeTOhwM8qZczfaDWDCr2g7fBP6gv9df9rpLkDQpy3ZchTkpO0030M5zU7eL/k+5AU
         c0lg==
X-Gm-Message-State: APjAAAWn0+zpl4m8qTT17ohPaW+wdxMh+z5LDryQZW2o/VI8RzyqLgkh
        qjt9F9imkqsB9strqXsK0xpUgEVH
X-Google-Smtp-Source: APXvYqzccoF1NgqXQH2JuoJKudOBmMaDBicb05i7nYMWynkMF/Iohx6PM+Zv7cS6FI98ejyqKs2AYQ==
X-Received: by 2002:a7b:c241:: with SMTP id b1mr2325832wmj.165.1566424505083;
        Wed, 21 Aug 2019 14:55:05 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id q3sm2019037wma.48.2019.08.21.14.55.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 14:55:04 -0700 (PDT)
Subject: Re: [PATCH 3/3] nvme: complete request in work queue on CPU with
 flooded interrupts
To:     Long Li <longli@microsoft.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1566281669-48212-1-git-send-email-longli@linuxonhyperv.com>
 <1566281669-48212-4-git-send-email-longli@linuxonhyperv.com>
 <2a30a07f-982c-c291-e263-0cf72ec61235@grimberg.me>
 <CY4PR21MB0741E77B05835E1192415943CEAA0@CY4PR21MB0741.namprd21.prod.outlook.com>
 <CY4PR21MB074141B895C9FE0D390F590ACEAA0@CY4PR21MB0741.namprd21.prod.outlook.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7fbdf43a-9499-8fb3-f6ec-5f1027b9fb65@grimberg.me>
Date:   Wed, 21 Aug 2019 14:54:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CY4PR21MB074141B895C9FE0D390F590ACEAA0@CY4PR21MB0741.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Sagi,
> 
> Here are the test results.
> 
> Benchmark command:
> fio --bs=4k --ioengine=libaio --iodepth=64 --filename=/dev/nvme0n1:/dev/nvme1n1:/dev/nvme2n1:/dev/nvme3n1:/dev/nvme4n1:/dev/nvme5n1:/dev/nvme6n1:/dev/nvme7n1:/dev/nvme8n1:/dev/nvme9n1 --direct=1 --runtime=90 --numjobs=80 --rw=randread --name=test --group_reporting --gtod_reduce=1
> 
> With your patch: 1720k IOPS
> With threaded interrupts: 1320k IOPS
> With just interrupts: 3720k IOPS
> 
> Interrupts are the fastest but we need to find a way to throttle it.

This is the workload that generates the flood?
If so I did not expect that this would be the perf difference..

If completions keep pounding on the cpu, I would expect irqpoll
to simply keep running forever and poll the cqs. There is no
fundamental reason why polling would be faster in an interrupt,
what matters could be:
1. we reschedule more than we need to
2. we don't reap enough completions in every poll round, which
will trigger rearming the interrupt and then when it fires reschedule
another softirq...

Maybe we need to take care of some irq_poll optimizations?

Does this (untested) patch make any difference?
--
diff --git a/lib/irq_poll.c b/lib/irq_poll.c
index 2f17b488d58e..0e94183eba15 100644
--- a/lib/irq_poll.c
+++ b/lib/irq_poll.c
@@ -12,7 +12,8 @@
  #include <linux/irq_poll.h>
  #include <linux/delay.h>

-static unsigned int irq_poll_budget __read_mostly = 256;
+static unsigned int irq_poll_budget __read_mostly = 3000;
+unsigned int __read_mostly irqpoll_budget_usecs = 2000;

  static DEFINE_PER_CPU(struct list_head, blk_cpu_iopoll);

@@ -77,32 +78,26 @@ EXPORT_SYMBOL(irq_poll_complete);

  static void __latent_entropy irq_poll_softirq(struct softirq_action *h)
  {
-       struct list_head *list = this_cpu_ptr(&blk_cpu_iopoll);
-       int rearm = 0, budget = irq_poll_budget;
-       unsigned long start_time = jiffies;
+       struct list_head *irqpoll_list = this_cpu_ptr(&blk_cpu_iopoll);
+       unsigned int budget = irq_poll_budget;
+       unsigned long time_limit =
+               jiffies + usecs_to_jiffies(irqpoll_budget_usecs);
+       LIST_HEAD(list);

         local_irq_disable();
+       list_splice_init(irqpoll_list, &list);
+       local_irq_enable();

-       while (!list_empty(list)) {
+       while (!list_empty(&list)) {
                 struct irq_poll *iop;
                 int work, weight;

-               /*
-                * If softirq window is exhausted then punt.
-                */
-               if (budget <= 0 || time_after(jiffies, start_time)) {
-                       rearm = 1;
-                       break;
-               }
-
-               local_irq_enable();
-
                 /* Even though interrupts have been re-enabled, this
                  * access is safe because interrupts can only add new
                  * entries to the tail of this list, and only ->poll()
                  * calls can remove this head entry from the list.
                  */
-               iop = list_entry(list->next, struct irq_poll, list);
+               iop = list_first_entry(&list, struct irq_poll, list);

                 weight = iop->weight;
                 work = 0;
@@ -111,8 +106,6 @@ static void __latent_entropy irq_poll_softirq(struct 
softirq_action *h)

                 budget -= work;

-               local_irq_disable();
-
                 /*
                  * Drivers must not modify the iopoll state, if they
                  * consume their assigned weight (or more, some drivers 
can't
@@ -125,11 +118,21 @@ static void __latent_entropy 
irq_poll_softirq(struct softirq_action *h)
                         if (test_bit(IRQ_POLL_F_DISABLE, &iop->state))
                                 __irq_poll_complete(iop);
                         else
-                               list_move_tail(&iop->list, list);
+                               list_move_tail(&iop->list, &list);
                 }
+
+               /*
+                * If softirq window is exhausted then punt.
+                */
+               if (budget <= 0 || time_after_eq(jiffies, time_limit))
+                       break;
         }

-       if (rearm)
+       local_irq_disable();
+
+       list_splice_tail_init(irqpoll_list, &list);
+       list_splice(&list, irqpoll_list);
+       if (!list_empty(irqpoll_list))
                 __raise_softirq_irqoff(IRQ_POLL_SOFTIRQ);

         local_irq_enable();
--
