Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6C9C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BDA20665
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfFWN1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 09:27:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33417 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfFWN1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 09:27:41 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf2Wx-0001jO-Gh; Sun, 23 Jun 2019 15:27:39 +0200
Message-Id: <20190623132434.553729327@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 23 Jun 2019 15:23:46 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>
Subject: [patch 06/29] x86/hpet: Remove the unused hpet_msi_read() function
References: <20190623132340.463097504@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/hpet.h |    1 -
 arch/x86/kernel/hpet.c      |    7 -------
 2 files changed, 8 deletions(-)

--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -81,7 +81,6 @@ struct irq_domain;
 extern void hpet_msi_unmask(struct irq_data *data);
 extern void hpet_msi_mask(struct irq_data *data);
 extern void hpet_msi_write(struct hpet_dev *hdev, struct msi_msg *msg);
-extern void hpet_msi_read(struct hpet_dev *hdev, struct msi_msg *msg);
 extern struct irq_domain *hpet_create_irq_domain(int hpet_id);
 extern int hpet_assign_irq(struct irq_domain *domain,
 			   struct hpet_dev *dev, int dev_num);
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -462,13 +462,6 @@ void hpet_msi_write(struct hpet_dev *hde
 	hpet_writel(msg->address_lo, HPET_Tn_ROUTE(hdev->num) + 4);
 }
 
-void hpet_msi_read(struct hpet_dev *hdev, struct msi_msg *msg)
-{
-	msg->data = hpet_readl(HPET_Tn_ROUTE(hdev->num));
-	msg->address_lo = hpet_readl(HPET_Tn_ROUTE(hdev->num) + 4);
-	msg->address_hi = 0;
-}
-
 static int hpet_msi_shutdown(struct clock_event_device *evt)
 {
 	struct hpet_dev *hdev = EVT_TO_HPET_DEV(evt);


