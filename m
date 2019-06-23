Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A0DC43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07CE21738
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfFWN1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 09:27:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33463 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfFWN1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 09:27:46 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf2X1-0001kP-N3; Sun, 23 Jun 2019 15:27:43 +0200
Message-Id: <20190623132435.241032433@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 23 Jun 2019 15:23:53 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>
Subject: [patch 13/29] x86/hpet: Decapitalize and rename EVT_TO_HPET_DEV
References: <20190623132340.463097504@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's a function not a macro and the upcoming changes use channel for the
individual hpet timer units to allow a step by step refactoring approach.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/hpet.c |   27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -69,9 +69,10 @@ static bool				hpet_verbose;
 
 static struct clock_event_device	hpet_clockevent;
 
-static inline struct hpet_dev *EVT_TO_HPET_DEV(struct clock_event_device *evtdev)
+static inline
+struct hpet_dev *clockevent_to_channel(struct clock_event_device *evt)
 {
-	return container_of(evtdev, struct hpet_dev, evt);
+	return container_of(evt, struct hpet_dev, evt);
 }
 
 inline unsigned int hpet_readl(unsigned int a)
@@ -458,28 +459,22 @@ void hpet_msi_write(struct hpet_dev *hde
 
 static int hpet_msi_shutdown(struct clock_event_device *evt)
 {
-	struct hpet_dev *hdev = EVT_TO_HPET_DEV(evt);
-
-	return hpet_shutdown(evt, hdev->num);
+	return hpet_shutdown(evt, clockevent_to_channel(evt)->num);
 }
 
 static int hpet_msi_set_oneshot(struct clock_event_device *evt)
 {
-	struct hpet_dev *hdev = EVT_TO_HPET_DEV(evt);
-
-	return hpet_set_oneshot(evt, hdev->num);
+	return hpet_set_oneshot(evt, clockevent_to_channel(evt)->num);
 }
 
 static int hpet_msi_set_periodic(struct clock_event_device *evt)
 {
-	struct hpet_dev *hdev = EVT_TO_HPET_DEV(evt);
-
-	return hpet_set_periodic(evt, hdev->num);
+	return hpet_set_periodic(evt, clockevent_to_channel(evt)->num);
 }
 
 static int hpet_msi_resume(struct clock_event_device *evt)
 {
-	struct hpet_dev *hdev = EVT_TO_HPET_DEV(evt);
+	struct hpet_dev *hdev = clockevent_to_channel(evt);
 	struct irq_data *data = irq_get_irq_data(hdev->irq);
 	struct msi_msg msg;
 
@@ -491,16 +486,14 @@ static int hpet_msi_resume(struct clock_
 }
 
 static int hpet_msi_next_event(unsigned long delta,
-				struct clock_event_device *evt)
+			       struct clock_event_device *evt)
 {
-	struct hpet_dev *hdev = EVT_TO_HPET_DEV(evt);
-
-	return hpet_next_event(delta, hdev->num);
+	return hpet_next_event(delta, clockevent_to_channel(evt)->num);
 }
 
 static irqreturn_t hpet_interrupt_handler(int irq, void *data)
 {
-	struct hpet_dev *dev = (struct hpet_dev *)data;
+	struct hpet_dev *dev = data;
 	struct clock_event_device *hevt = &dev->evt;
 
 	if (!hevt->event_handler) {


