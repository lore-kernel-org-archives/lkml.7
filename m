Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36746C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1387B208CA
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfFWN1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 09:27:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33411 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfFWN1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 09:27:40 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf2Ww-0001jC-Nh; Sun, 23 Jun 2019 15:27:38 +0200
Message-Id: <20190623132434.447880978@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 23 Jun 2019 15:23:45 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>
Subject: [patch 05/29] x86/hpet: Remove unused parameter from hpet_next_event()
References: <20190623132340.463097504@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clockevent device pointer is not used in this function.

While at it, rename the misnamed 'timer' parameter to 'channel', which makes it
clear what this parameter means.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/hpet.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -347,15 +347,14 @@ static int hpet_resume(struct clock_even
 	return 0;
 }
 
-static int hpet_next_event(unsigned long delta,
-			   struct clock_event_device *evt, int timer)
+static int hpet_next_event(unsigned long delta, int channel)
 {
 	u32 cnt;
 	s32 res;
 
 	cnt = hpet_readl(HPET_COUNTER);
 	cnt += (u32) delta;
-	hpet_writel(cnt, HPET_Tn_CMP(timer));
+	hpet_writel(cnt, HPET_Tn_CMP(channel));
 
 	/*
 	 * HPETs are a complete disaster. The compare register is
@@ -407,7 +406,7 @@ static int hpet_legacy_resume(struct clo
 static int hpet_legacy_next_event(unsigned long delta,
 			struct clock_event_device *evt)
 {
-	return hpet_next_event(delta, evt, 0);
+	return hpet_next_event(delta, 0);
 }
 
 /*
@@ -508,7 +507,8 @@ static int hpet_msi_next_event(unsigned
 				struct clock_event_device *evt)
 {
 	struct hpet_dev *hdev = EVT_TO_HPET_DEV(evt);
-	return hpet_next_event(delta, evt, hdev->num);
+
+	return hpet_next_event(delta, hdev->num);
 }
 
 static irqreturn_t hpet_interrupt_handler(int irq, void *data)


