Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01CDC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5BE2071F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732247AbfKTPnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:43:08 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52848 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730074AbfKTPkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:40:19 -0500
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1iXS5V-0004bQ-K9; Wed, 20 Nov 2019 15:40:13 +0000
Received: from ben by deadeye with local (Exim 4.93-RC1)
        (envelope-from <ben@decadent.org.uk>)
        id 1iXS5U-0004Lr-WF; Wed, 20 Nov 2019 15:40:13 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Zhiqiang Liu" <liuzhiqiang26@huawei.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Yunfeng Ye" <yeyunfeng@huawei.com>
Date:   Wed, 20 Nov 2019 15:38:16 +0000
Message-ID: <lsq.1574264230.646825149@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 66/83] genirq: Prevent NULL pointer dereference in
 resend_irqs()
In-Reply-To: <lsq.1574264230.280218497@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.78-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Yunfeng Ye <yeyunfeng@huawei.com>

commit eddf3e9c7c7e4d0707c68d1bb22cc6ec8aef7d4a upstream.

The following crash was observed:

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

The reason for this is that the interrupt resend mechanism happens in soft
interrupt context, which is a asynchronous mechanism versus other
operations on interrupts. free_irq() does not take resend handling into
account. Thus, the irq descriptor might be already freed before the resend
tasklet is executed. resend_irqs() does not check the return value of the
interrupt descriptor lookup and derefences the return value
unconditionally.

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
        desc->handle_irq(desc)  // desc is NULL --> Ooops

Fix this by adding a NULL pointer check in resend_irqs() before derefencing
the irq descriptor.

Fixes: a4633adcdbc1 ("[PATCH] genirq: add genirq sw IRQ-retrigger")
Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Link: https://lkml.kernel.org/r/1630ae13-5c8e-901e-de09-e740b6a426a7@huawei.com
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/irq/resend.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -37,6 +37,8 @@ static void resend_irqs(unsigned long ar
 		irq = find_first_bit(irqs_resend, nr_irqs);
 		clear_bit(irq, irqs_resend);
 		desc = irq_to_desc(irq);
+		if (!desc)
+			continue;
 		local_irq_disable();
 		desc->handle_irq(irq, desc);
 		local_irq_enable();

