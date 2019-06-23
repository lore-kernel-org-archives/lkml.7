Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52871C48BE8
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35799216C8
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfFWN1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 09:27:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33444 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbfFWN1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 09:27:44 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf2Wz-0001k1-Rg; Sun, 23 Jun 2019 15:27:41 +0200
Message-Id: <20190623132434.951733064@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 23 Jun 2019 15:23:50 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>
Subject: [patch 10/29] x86/hpet: Shuffle code around for readability sake
References: <20190623132340.463097504@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't make sense to have init functions in the middle of other
code. Aside of that, further changes in that area create horrible diffs if
the code stays where it is.

No functional change

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/hpet.c |   81 ++++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 40 deletions(-)

--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -559,6 +559,47 @@ static void init_one_hpet_msi_clockevent
 					0x7FFFFFFF);
 }
 
+static struct hpet_dev *hpet_get_unused_timer(void)
+{
+	int i;
+
+	if (!hpet_devs)
+		return NULL;
+
+	for (i = 0; i < hpet_num_timers; i++) {
+		struct hpet_dev *hdev = &hpet_devs[i];
+
+		if (!(hdev->flags & HPET_DEV_VALID))
+			continue;
+		if (test_and_set_bit(HPET_DEV_USED_BIT,
+			(unsigned long *)&hdev->flags))
+			continue;
+		return hdev;
+	}
+	return NULL;
+}
+
+static int hpet_cpuhp_online(unsigned int cpu)
+{
+	struct hpet_dev *hdev = hpet_get_unused_timer();
+
+	if (hdev)
+		init_one_hpet_msi_clockevent(hdev, cpu);
+	return 0;
+}
+
+static int hpet_cpuhp_dead(unsigned int cpu)
+{
+	struct hpet_dev *hdev = per_cpu(cpu_hpet_dev, cpu);
+
+	if (!hdev)
+		return 0;
+	free_irq(hdev->irq, hdev);
+	hdev->flags &= ~HPET_DEV_USED;
+	per_cpu(cpu_hpet_dev, cpu) = NULL;
+	return 0;
+}
+
 #ifdef CONFIG_HPET
 /* Reserve at least one timer for userspace (/dev/hpet) */
 #define RESERVE_TIMERS 1
@@ -644,46 +685,6 @@ static void __init hpet_reserve_msi_time
 }
 #endif
 
-static struct hpet_dev *hpet_get_unused_timer(void)
-{
-	int i;
-
-	if (!hpet_devs)
-		return NULL;
-
-	for (i = 0; i < hpet_num_timers; i++) {
-		struct hpet_dev *hdev = &hpet_devs[i];
-
-		if (!(hdev->flags & HPET_DEV_VALID))
-			continue;
-		if (test_and_set_bit(HPET_DEV_USED_BIT,
-			(unsigned long *)&hdev->flags))
-			continue;
-		return hdev;
-	}
-	return NULL;
-}
-
-static int hpet_cpuhp_online(unsigned int cpu)
-{
-	struct hpet_dev *hdev = hpet_get_unused_timer();
-
-	if (hdev)
-		init_one_hpet_msi_clockevent(hdev, cpu);
-	return 0;
-}
-
-static int hpet_cpuhp_dead(unsigned int cpu)
-{
-	struct hpet_dev *hdev = per_cpu(cpu_hpet_dev, cpu);
-
-	if (!hdev)
-		return 0;
-	free_irq(hdev->irq, hdev);
-	hdev->flags &= ~HPET_DEV_USED;
-	per_cpu(cpu_hpet_dev, cpu) = NULL;
-	return 0;
-}
 #else
 
 static inline void hpet_msi_capability_lookup(unsigned int start_timer) { }


