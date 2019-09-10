Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4327FC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3BF2089F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393421AbfIJGa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 02:30:27 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:58251 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729634AbfIJGa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 02:30:26 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=luoben@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Tbz28j6_1568097016;
Received: from bn0418deMacBook-Pro.local(mailfrom:luoben@linux.alibaba.com fp:SMTPD_---0Tbz28j6_1568097016)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 10 Sep 2019 14:30:17 +0800
Subject: Re: [PATCH v6 0/3] genirq/vfio: Introduce irq_update_devid() and
 optimize VFIO irq ops
From:   Ben Luo <luoben@linux.alibaba.com>
To:     tglx@linutronix.de, alex.williamson@redhat.com
Cc:     linux-kernel@vger.kernel.org, tao.ma@linux.alibaba.com,
        gerry@linux.alibaba.com, nanhai.zou@linux.alibaba.com
References: <cover.1567394624.git.luoben@linux.alibaba.com>
Message-ID: <abb4080f-dfe2-1882-4bde-51bb7e660d4a@linux.alibaba.com>
Date:   Tue, 10 Sep 2019 14:30:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cover.1567394624.git.luoben@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A friendly reminder.


Thanks,

     Ben

在 2019/9/2 下午12:01, Ben Luo 写道:
> Currently, VFIO takes a free-then-request-irq way to do interrupt
> affinity setting and masking/unmasking for a VM with device passthru
> via VFIO. Sometimes it only changes the cookie data of irqaction or even
> changes nothing. The free-then-request-irq not only adds more latency,
> but also increases the risk of losing interrupt, which may lead to a
> VM hang forever in waiting for IO completion
>
> This patchset solved the issue by:
> Patch 2 introduces irq_update_devid() to only update dev_id of irqaction
> Patch 3 make use of this function and optimize irq operations in VFIO
>
> changes from v5:
>   - Patch 3: remove an error log to avoid potential DDoS attacking
>   _ Patch 3: fix typo in comment
>
> changes from v4:
>   - Patch 3: follow the previous behavior to disable interrupt on error path
>   - Patch 3: do irqbypass registration before update or free the interrupt
>   - Patch 3: add more comments
>
> changes from v3:
>   - Patch 2: rename the new function to irq_update_devid()
>   - Patch 2: use disbale_irq() to avoid a twist for threaded interrupt
>   - ALL: amend commit messages and code comments
>
> changes from v2:
>   - reformat to avoid quoted string split across lines and etc.
>
> changes from v1:
>   - add Patch 1 to enhance error recovery etc. in free irq per tglx's comments
>   - enhance error recovery code and debugging info in irq_update_devid
>   - use __must_check in external referencing of this function
>   - use EXPORT_SYMBOL_GPL for irq_update_devid
>   - reformat code of patch 3 for better readability
>
> Ben Luo (3):
>    genirq: enhance error recovery code in free irq
>    genirq: introduce irq_update_devid()
>    vfio/pci: make use of irq_update_devid() and optimize irq ops
>
>   drivers/vfio/pci/vfio_pci_intrs.c | 118 ++++++++++++++++++++++++++------------
>   include/linux/interrupt.h         |   3 +
>   kernel/irq/manage.c               | 105 +++++++++++++++++++++++++++++----
>   3 files changed, 177 insertions(+), 49 deletions(-)
>
