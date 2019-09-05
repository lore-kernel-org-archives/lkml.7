Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B43C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8BF206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404097AbfIEUuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 16:50:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44591 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391713AbfIEUuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 16:50:02 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i5yhW-0001js-7c; Thu, 05 Sep 2019 22:49:54 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6C8B01C0895;
        Thu,  5 Sep 2019 22:49:53 +0200 (CEST)
Date:   Thu, 05 Sep 2019 20:49:53 -0000
From:   "tip-bot2 for Yunfeng Ye" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: refs/heads/irq/urgent] genirq: Prevent NULL pointer dereference
 in resend_irqs()
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156771659332.12994.218475588018626814.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the refs/heads/irq/urgent branch of tip:

Commit-ID:     eddf3e9c7c7e4d0707c68d1bb22cc6ec8aef7d4a
Gitweb:        https://git.kernel.org/tip/eddf3e9c7c7e4d0707c68d1bb22cc6ec8aef7d4a
Author:        Yunfeng Ye <yeyunfeng@huawei.com>
AuthorDate:    Wed, 04 Sep 2019 20:46:25 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 05 Sep 2019 21:31:14 +02:00

genirq: Prevent NULL pointer dereference in resend_irqs()

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
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/1630ae13-5c8e-901e-de09-e740b6a426a7@huawei.com
---
 kernel/irq/resend.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index 95414ad..98c04ca 100644
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
