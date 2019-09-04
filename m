Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2A6C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625EA21883
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbfIDMqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 08:46:39 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40848 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729398AbfIDMqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:46:39 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 53398A45EB0F9F9D40D8
        for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2019 20:46:37 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Sep 2019
 20:46:31 +0800
To:     <tglx@linutronix.de>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] genirq: Fix NULL pointer dereference in resend_irqs()
CC:     Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        <linux-kernel@vger.kernel.org>
Message-ID: <1630ae13-5c8e-901e-de09-e740b6a426a7@huawei.com>
Date:   Wed, 4 Sep 2019 20:46:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops occur when running qemu on arm64:

  Unable to handle kernel NULL pointer dereference at 0000000000000158
  Internal error: Oops: 96000004 [#1] SMP
  pc : resend_irqs+0x68/0xb0
  lr : resend_irqs+0x64/0xb0
  ...
  Call trace:
   resend_irqs+0x68/0xb0
   tasklet_action_common.isra.6+0x84/0x138
   tasklet_action+0x2c/0x38
   __do_softirq+0x120/0x324
   run_ksoftirqd+0x44/0x60
   smpboot_thread_fn+0x1ac/0x1e8
   kthread+0x134/0x138
   ret_from_fork+0x10/0x18

As we know, softirq is a asynchronous mechanism. The process of free
irqs does not take resend irq handling into account. Thus, the irq_desc
may be already freed before softirq running, and resend_irqs() does not
check the validation of irq_desc, finally, the Oops occur. Process is as
follows:

  1):
  __setup_irq
    irq_startup
      check_irq_resend  // activate softirq to handle resend irq
  2):
  irq_domain_free_irqs
    irq_free_descs
      free_desc
        call_rcu(&desc->rcu, delayed_free_desc)
  3):
  __do_softirq
    tasklet_action
      resend_irqs
        desc = irq_to_desc(irq)
        desc->handle_irq(desc)  // desc is NULL, Oops occur

Fix this by checking for a NULL pointer when get @irq_desc in
resend_irqs().

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Reviewed-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
 kernel/irq/resend.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index 95414ad..98c04ca5 100644
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -36,6 +36,8 @@ static void resend_irqs(unsigned long arg)
 		irq = find_first_bit(irqs_resend, nr_irqs);
 		clear_bit(irq, irqs_resend);
 		desc = irq_to_desc(irq);
+		if (!desc)
+			continue;
 		local_irq_disable();
 		desc->handle_irq(desc);
 		local_irq_enable();
-- 
1.8.3.1


